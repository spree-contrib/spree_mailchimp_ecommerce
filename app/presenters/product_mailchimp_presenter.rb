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
          title: product.name || '',
          description: product.description || '',
          variants: variants
        }.as_json
      end

      private

      def variants
        product.variants.map { |v| variant(v) }
      end

      def variant(variant)
        {
          id: Digest::MD5.hexdigest("#{variant.sku}#{variant.id}"),
          title: product.name || '',
          sku: variant.sku,
          price: variant.cost_price.to_s
        }
      end
    end
end
end
