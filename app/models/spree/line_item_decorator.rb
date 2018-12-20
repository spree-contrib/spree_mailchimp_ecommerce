module Spree
  module SpreeMailchimpEcommerce
    module LineItemDecorator
      def self.prepended(base)
        base.after_update :update_mailchimp_cart
        base.after_create :update_mailchimp_cart
      end

      private

      def update_mailchimp_cart
        ::SpreeMailchimpEcommerce::UpdateOrderCartJob.perform_later(self.order)
      end
    end
  end
end
Spree::LineItem.prepend(Spree::SpreeMailchimpEcommerce::LineItemDecorator)
