module Spree
  module SpreeMailchimpEcommerce
    module LineItemDecorator
      def self.prepended(base)
        base.after_update :update_mailchimp_cart
        base.after_create :handle_cart
        base.after_destroy :delete_line_item
      end

      def mailchimp_line_item
        ::SpreeMailchimpEcommerce::Presenters::LineMailchimpPresenter.new(self).json
      end

      private

      def handle_cart
        order.mailchimp_cart_created ? order.update_mailchimp_cart : order.create_mailchimp_cart
      end

      def update_mailchimp_cart
        order.update_mailchimp_cart
      end

      def delete_line_item
        ::SpreeMailchimpEcommerce::DeleteLineItemJob.perform_later(id)
      end
    end
  end
end
Spree::LineItem.prepend(Spree::SpreeMailchimpEcommerce::LineItemDecorator)
