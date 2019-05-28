# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class CartMailchimpPresenter
      include OrderMethods

      attr_reader :order

      def initialize(order)
        @order = order
      end

      def json
        order_json.merge(checkout_url: ::SpreeMailchimpEcommerce.configuration.cart_url)
      end

      private

      def user
        if order.user
          UserMailchimpPresenter.new(order.user).json
        elsif order.email
          {
            id: Digest::MD5.hexdigest(order.email.downcase),
            email_address: order.email || "",
            first_name: order.bill_address&.firstname || "",
            last_name: order.bill_address&.last_name || "",
            opt_in_status: false
          }
        end
      end
    end
  end
end
