# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class ProductMailchimpPresenter
      attr_reader :product

      def initialize(product)
        @product = product
      end

      def json
        {
          id: Digest::MD5.hexdigest(product.id.to_s),
          title: product.name || "",
          description: product.description || "",
          url: "#{ENV['BASE_URL']}/#{product.category&.permalink || 'products'}/#{product.slug}",
          vendor: product.category&.name || "",
          image_url: product.images.first&.attachment&.url || "",
          variants: variants
        }.as_json
      end

      private

      def variants
        product.variants.map(&:mailchimp_variant)
      end
    end
  end
end
