module Spree
  module SpreeMailchimpEcommerce
    module LineItemDecorator
      def self.prepended(base)
        base.after_update :update_mailchimp_cart
        base.after_create :update_mailchimp_cart
        base.after_destroy :delete_line_item
      end

      def mailchimp_line_item
        ::SpreeMailchimpEcommerce::Presenters::LineMailchimpPresenter.new(self).json
      end

      private

      def update_mailchimp_cart
        ::SpreeMailchimpEcommerce::UpdateOrderCartJob.perform_later(order_id)
      end

      def delete_line_item
        ::SpreeMailchimpEcommerce::DeleteLineItemJob.perform_later(id)
      end
    end
  end
end
Spree::LineItem.prepend(Spree::SpreeMailchimpEcommerce::LineItemDecorator)
