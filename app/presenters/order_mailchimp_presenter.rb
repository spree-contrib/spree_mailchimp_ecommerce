# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class OrderMailchimpPresenter
      attr_reader :order

      def initialize(order)
        @order = order
        raise "Order in wrong state" unless order.complete?
      end

      def json
        return unless user

        {
          id: order.number,
          customer: user,
          currency_code: order.currency,
          order_total: order.total.to_s,
          lines: lines
        }.as_json
      end

      private

      def user
        if order.user
          UserMailchimpPresenter.new(order.user).json
        elsif order.email
          {
            id: Digest::MD5.hexdigest(order.email),
            email_address: order.email,
            opt_in_status: true
          }
        end
      end

      def lines
        order.line_items.map { |l| line(l) }
      end

      def line(line)
        {
          id: Digest::MD5.hexdigest("#{line.id}#{line.order_id}"),
          product_id: ProductMailchimpPresenter.new(line.product).json["id"],
          product_variant_id: Digest::MD5.hexdigest("#{line.variant.sku}#{line.variant.id}"),
          quantity: line.quantity,
          price: line.price.to_s
        }
      end
    end
  end
end
