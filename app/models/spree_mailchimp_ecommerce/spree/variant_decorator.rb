module SpreeMailchimpEcommerce
  module Spree
    module VariantDecorator
      def mailchimp_variant
        ::SpreeMailchimpEcommerce::VariantMailchimpPresenter.new(self).json
      end
    end
  end
end
Spree::Variant.prepend(SpreeMailchimpEcommerce::Spree::VariantDecorator)

