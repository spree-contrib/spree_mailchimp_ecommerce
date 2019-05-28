# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class OrderMailchimpPresenter
      include OrderMethods

      attr_reader :order

      def initialize(order)
        @order = order
        raise "Order in wrong state" unless order.complete?
      end

      def json
        order_json.merge(campaign_id)
      end

      private

      def campaign_id
        return {} unless order.mailchimp_campaign_id

        { campaign_id: order.mailchimp_campaign_id }
      end

      def user
        if order.user
          UserMailchimpPresenter.new(order.user).json
        elsif order.email
          {
            id: Digest::MD5.hexdigest(order.email.downcase),
            first_name: order.bill_address&.firstname || "",
            last_name: order.bill_address&.last_name || "",
            email_address: order.email || "",
            opt_in_status: false,
            address: address
          }
        end
      end

      def address
        return {} unless order.shipping_address

        AddressMailchimpPresenter.new(order.shipping_address).json
      end
    end
  end
end
