module Spree
  module SpreeMailchimpEcommerce
    module StockItemDecorator
      def self.prepended(base)
        base.after_save :update_product
      end

      private

      def update_product
        return unless count_on_hand_previously_changed? || count_on_hand_changed?

        ::SpreeMailchimpEcommerce::UpdateProductJob.perform_later(product.mailchimp_product)
      end
    end
  end
end
Spree::StockItem.prepend(Spree::SpreeMailchimpEcommerce::StockItemDecorator)
