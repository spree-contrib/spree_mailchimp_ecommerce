module Spree
  module SpreeMailchimpEcommerce
    module LineItemDecorator
      def self.prepended(base)
        base.after_update :update_mailchimp_cart
        base.after_create :update_mailchimp_cart
        base.after_destroy :delete_line_item
      end

      private

      def update_mailchimp_cart
        ::SpreeMailchimpEcommerce::UpdateOrderCartJob.perform_later(order)
      end

      def delete_line_item
        ::SpreeMailchimpEcommerce::DeleteLineItemJob.perform_later(self)
      end
    end
  end
end
Spree::LineItem.prepend(Spree::SpreeMailchimpEcommerce::LineItemDecorator)
