# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Spree
    module CheckoutControllerDecorator
      def self.prepended(base)
        base.before_action :set_order_campaign_id, only: [:update]
      end

      private

      def set_order_campaign_id
        return unless cookies[:mailchimp_campaign_id]

        current_order.mailchimp_campaign_id = cookies[:mailchimp_campaign_id]
      end
    end
  end
end
Spree::CheckoutController.prepend(SpreeMailchimpEcommerce::Spree::CheckoutControllerDecorator)
