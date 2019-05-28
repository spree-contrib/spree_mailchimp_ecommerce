require "spec_helper"

describe Spree::Order, type: :model do
  subject { build(:order) }
  before { allow_any_instance_of(SpreeMailchimpEcommerce::Configuration).to receive(:cart_url) { "test.com/cart" } }
  describe "json" do
    context "order with user" do
      subject { create(:order_with_line_items, state: "complete", user: create(:user_with_addresses)) }

      describe ".mailchimp_order" do
        it "returns valid schema" do
          expect(subject.mailchimp_order).to match_json_schema("order")
        end
      end

      describe ".mailchimp_cart" do
        it "returns valid schema" do
          expect(subject.mailchimp_cart).to match_json_schema("cart")
        end
      end
    end

    context "order without user" do
      subject { create(:order_with_line_items, state: "complete", user: nil, email: "test@test.test") }
      describe ".mailchimp_order" do
        it "returns valid schema" do
          expect(subject.mailchimp_order).to match_json_schema("order")
        end
      end
    end
  end

  describe "mailchimp" do
    describe "order" do
      it "schedules mailchimp notification on order complete" do
        subject.state = "payment"
        subject.save!
        subject.next!

        expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.with(subject.mailchimp_order)
        expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.with(subject.number)
      end
    end
  end
end
