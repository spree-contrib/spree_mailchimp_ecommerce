require "spec_helper"

describe Spree::Order, type: :model do
  before { allow_any_instance_of(SpreeMailchimpEcommerce::Configuration).to receive(:cart_url) { "test.com/cart" } }

  describe "json" do
    context "order with user" do
      let (:user) { create(:user_with_addresses) }
      describe ".mailchimp_order" do
        let(:shipment) { create(:shipment) }
        subject { create(:completed_order_with_totals, user: user, shipments: [shipment]) }
        it "returns valid schema" do
          expect(subject.mailchimp_order).to match_json_schema("order")
        end

        it "doesn't send unnecessary requests to db" do
          expect { subject.mailchimp_order }.not_to exceed_query_limit(1)
        end
      end

      describe ".mailchimp_cart" do
        subject { create(:order_with_line_items, user: user) }
        it "returns valid schema" do
          expect(subject.mailchimp_cart).to match_json_schema("cart")
        end

        it "doesn't send unnecessary requests to db" do
          expect { subject.mailchimp_cart }.not_to exceed_query_limit(1)
        end
      end
    end

    context "order without user" do
      let(:shipment) { create(:shipment) }
      subject { create(:completed_order_with_totals, user: nil, email: "test@test.test", shipments: [shipment]) }
      describe ".mailchimp_order" do
        it "returns valid schema" do
          expect(subject.mailchimp_order).to match_json_schema("order")
        end
      end
    end
  end

  describe 'StockItem' do
    subject { create(:order_with_line_items, state: 'confirm')}
    before do
      subject.variants.first.stock_items.first.update_attribute(:count_on_hand, 10)
      create(:payment, order: subject)
    end
    it 'schedules mailchimp product updating on complete order' do
      subject.next
      expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(subject.products.first.mailchimp_product)
    end
  end

  describe "mailchimp order" do
    let(:address) { create(:address) }
    subject { create(:order, state: "confirm", shipping_address: address) }
    it "schedules mailchimp Order Invoice notification on paid order complete" do
      subject.next
      expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.with(subject.mailchimp_order)
      expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.with(subject.number)
      expect(subject.mailchimp_order["financial_status"]).to eq("paid")
    end

    it "schedules mailchimp Order Confirmation notification on not paid order complete" do
      create(:payment, order: subject, state: "failed")
      subject.next
      expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.with(subject.mailchimp_order)
      expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.with(subject.number)
      expect(subject.mailchimp_order["financial_status"]).to eq("pending")
    end

    it "schedules mailchimp Cancellation Confirmation notification on order cancel" do
      order = create(:completed_order_with_totals)
      order.cancel

      expect(SpreeMailchimpEcommerce::UpdateOrderJob).to have_been_enqueued.with(order.mailchimp_order)
      expect(order.mailchimp_order["financial_status"]).to eq("cancelled")
    end

    it "schedules mailchimp Shipping Confirmation notification on order shipped" do
      order = create(:order_ready_to_ship)
      order.shipments.first.ship!

      expect(SpreeMailchimpEcommerce::UpdateOrderJob).to have_been_enqueued.with(order.mailchimp_order)
      expect(order.mailchimp_order["fulfillment_status"]).to eq("shipped")
    end

    it "schedules mailchimp Refund Confirmation notification on order refund" do
      order = create(:shipped_order)
      create(:refund, payment: order.payments.first)

      expect(SpreeMailchimpEcommerce::UpdateOrderJob).to have_been_enqueued.with(order.mailchimp_order)
      expect(order.mailchimp_order["financial_status"]).to eq("refunded")
    end
  end
end
