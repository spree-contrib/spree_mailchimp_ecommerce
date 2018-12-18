# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class CartMailchimpPresenter
      attr_reader :order

      def initialize(order)
        @order = order
      end

      def json
        return {} unless user

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
        return unless email

        {
          id: Digest::MD5.hexdigest(email),
          email_address: email,
          opt_in_status: true
        }
      end

      def email
        if order.user
          order.user.email.downcase
        elsif order.email
          order.email
        end
      end

      def lines
        order.line_items.map { |l| line(l) }
      end

      def line(line)
        {
          id: Digest::MD5.hexdigest("#{line.id}#{line.order_id}"),
          product_id: Mailchimp::ProductMailchimpPresenter.new(line.product).json['id'],
          product_variant_id: Digest::MD5.hexdigest("#{line.variant.sku}#{line.variant.id}"),
          quantity: line.quantity,
          price: line.price.to_s
        }
      end
end
end
end
