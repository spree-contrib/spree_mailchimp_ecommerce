require "spec_helper"

describe Spree::Product, type: :model do
  subject { build(:product) }

  describe "mailchimp" do
    it "schedules mailchimp notification on product create" do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateProductJob).to have_been_enqueued.with(subject)
    end

    it "schedules mailchimp notification on product update" do
      subject.save!
      subject.update!(name: "new product")

      expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(subject)
    end
  end
end
