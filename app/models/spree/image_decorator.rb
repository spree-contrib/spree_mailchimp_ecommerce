module Spree
  module SpreeMailchimpEcommerce
    module ImageDecorator
      def self.prepended(base)
        base.after_create :update_mailchimp_product
        base.after_update :update_mailchimp_product
        base.after_destroy :update_mailchimp_product
      end

      private

      def update_mailchimp_product
        ::SpreeMailchimpEcommerce::UpdateProductJob.perform_later(find_product)
      end

      def find_product
        Spree::Variant.find(self.viewable_id).product.id
      end
    end
  end
end
Spree::Image.prepend(Spree::SpreeMailchimpEcommerce::ImageDecorator)
