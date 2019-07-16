module Spree
  module SpreeMailchimpEcommerce
    module LineItemDecorator

      def self.prepended(base)
        base.after_save :handle_cart
        base.after_destroy do |item|
          delete_line_item(item.order.number, item.id, item.order_id)
        end
      end

      def handle_cart
        return unless order.user

        if order.checkout_allowed?
          order.mailchimp_cart_created ? order.update_mailchimp_cart : order.create_mailchimp_cart
        else
          order.delete_mailchimp_cart
        end
      end

      def mailchimp_line_item
        ::SpreeMailchimpEcommerce::Presenters::LineMailchimpPresenter.new(self).json
      end

      private

      def delete_line_item(order_number, deleted_line_item_id, deletedline_item_order_id)
        return unless order.user

        if order.checkout_allowed?
          associated_order = order_number
          line_id = Digest::MD5.hexdigest("#{deleted_line_item_id}#{deletedline_item_order_id}")

          ::SpreeMailchimpEcommerce::DeleteLineItemJob.perform_later(associated_order, line_id)
        else
          order.delete_mailchimp_cart
        end
      end

    end
  end
end
Spree::LineItem.prepend(Spree::SpreeMailchimpEcommerce::LineItemDecorator)
