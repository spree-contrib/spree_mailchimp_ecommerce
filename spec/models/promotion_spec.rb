require "spec_helper"

describe Spree::Promotion, type: :model do
  let!(:subject) { create(:promotion) }

  describe "mailchimp" do
    it "schedules mailchimp notification on promotion create" do
      expect(SpreeMailchimpEcommerce::CreatePromoJob).to have_been_enqueued.with(subject.mailchimp_promo_rule, subject.mailchimp_promo_code)
    end

    it "schedules mailchimp notification on promotion update" do
      subject.update!(name: "new promotion")

      expect(SpreeMailchimpEcommerce::UpdatePromoJob).to have_been_enqueued.with(subject.mailchimp_promo_rule, subject.mailchimp_promo_code)
    end

    it "schedules mailchimp notification on product delete" do
      subject.destroy!

      expect(SpreeMailchimpEcommerce::DeletePromoJob).to have_been_enqueued.with(subject.mailchimp_promo_rule, subject.mailchimp_promo_code)
    end
  end

  describe ".mailchimp_promotion" do
    it "returns valid schema" do
      expect(subject.mailchimp_promo_code).to match_json_schema("promo_code")
      expect(subject.mailchimp_promo_rule).to match_json_schema("promo_rule")
    end

    it "doesn't send unnecessary requests to db" do
      expect { subject.reload.mailchimp_promo_code }.not_to exceed_query_limit(3)
      expect { subject.reload.mailchimp_promo_rule }.not_to exceed_query_limit(5)
    end
  end
end
