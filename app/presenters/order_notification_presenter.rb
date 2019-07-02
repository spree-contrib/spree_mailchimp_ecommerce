# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class OrderNotificationPresenter
      attr_reader :order

      def initialize(order)
        @order = order
      end

      def invoice_or_order_confirmation
        state = order.payment_state == "paid" ? "paid" : "pending"
        { financial_status: state }.as_json
      end

      def cancellation_confirmation
        { financial_status: "cancelled" }.as_json
      end

      def refund_confirmation
        { financial_status: "refunded" }.as_json
      end

      def shipping_confirmation
        { fulfillment_status: order.shipment_state }.as_json
      end
    end
  end
end
