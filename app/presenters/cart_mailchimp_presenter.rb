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
        super.merge({ checkout_url: ::SpreeMailchimpEcommerce.configuration.cart_url })
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
    end
  end
end
