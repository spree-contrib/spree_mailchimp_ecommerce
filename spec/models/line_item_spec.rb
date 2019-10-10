require "spec_helper"

describe Spree::LineItem, type: :model do
  subject { build(:line_item) }

  describe "mailchimp" do
    it "schedules mailchimp notification on item update" do
      subject.save!
      subject.update!(quantity: "3")

      expect(SpreeMailchimpEcommerce::UpdateOrderCartJob).to have_been_enqueued
    end

    it "schedules mailchimp notification on item delete" do
      subject.save!
      subject.destroy

      expect(SpreeMailchimpEcommerce::DeleteLineItemJob).to have_been_enqueued
    end
  end
end

