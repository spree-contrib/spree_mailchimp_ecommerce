require "spec_helper"

describe Spree::Order, type: :model do
  subject { build(:order) }

  describe "json" do
    context 'order with user' do
      subject { create(:order_with_line_items, state: "complete", user: create(:user_with_addresses)) }

      describe ".mailchimp_order" do
        it "returns valid schema" do
          expect(subject.mailchimp_order).to match_json_schema("order")
        end
      end

      describe ".mailchimp_cart" do
        it "returns valid schema" do
          allow_any_instance_of(NilClass).to receive(:cart_url) { "test.com/cart" }

          expect(subject.mailchimp_cart).to match_json_schema("cart")
        end
      end
    end

    context 'order without user' do
      subject { create(:order_with_line_items, state: "complete", user: nil, email: 'test@test.test') }
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

        expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.with(subject.id)
        expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.with(subject.id)
      end
    end

    describe "cart" do
      context "user exitst" do
        it "shedules mailchimp notification on cart created" do
          subject.save!

          expect(SpreeMailchimpEcommerce::CreateOrderCartJob).to have_been_enqueued.with(subject.id)
        end
      end

      context "guest user" do
        before do
          subject.user = nil
          subject.email = nil
          subject.state = "address"
          subject.save!
        end

        it "shedules mailchimp notification on cart created" do
          subject.email = "new_email@test.test"
          subject.save
          expect(SpreeMailchimpEcommerce::CreateOrderCartJob).to have_been_enqueued.with(subject.id)
        end
      end
    end
  end
end
