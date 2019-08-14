require "spec_helper"

describe Spree::Product, type: :model do
  subject { build(:product) }

  describe "mailchimp" do
    it "schedules mailchimp notification on product create" do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateProductJob).to have_been_enqueued.with(subject.mailchimp_product)
    end

    it "schedules mailchimp notification on product update" do
      subject.save!
      subject.update!(name: "new product")

      expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(subject.mailchimp_product)
    end

    it "schedules mailchimp notification on product delete" do
      subject.save!
      subject.destroy

      expect(SpreeMailchimpEcommerce::DeleteProductJob).to have_been_enqueued.with(subject.mailchimp_product)
    end
  end

  describe ".mailchimp_product" do
    it "returns valid schema" do
      expect(subject.mailchimp_product).to match_json_schema("product")
    end

    it "doesn't send unnecessary requests to db" do
      subject.save!

      expect { subject.mailchimp_product }.not_to exceed_query_limit(1)
    end
  end
end
