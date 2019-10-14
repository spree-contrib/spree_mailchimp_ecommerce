module SpreeMailchimpEcommerce
  module Spree
    module LineItemDecorator
      def self.prepended(base)
        base.after_update :update_mailchimp_cart
        base.after_create :handle_cart
        base.after_destroy :delete_line_item
      end

      def handle_cart
        return unless order.user

        order.mailchimp_cart_created ? update_mailchimp_cart : order.create_mailchimp_cart
      end

      def mailchimp_line_item
        ::SpreeMailchimpEcommerce::LineMailchimpPresenter.new(self).json
      end

      private

      def update_mailchimp_cart
        order.update_mailchimp_cart
      end

      def delete_line_item
        ::SpreeMailchimpEcommerce::DeleteLineItemJob.perform_later(self)
      end
    end
  end
end
Spree::LineItem.prepend(SpreeMailchimpEcommerce::Spree::LineItemDecorator)
