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
          url: "#{::Rails.application.routes.url_helpers.spree_url}/#{product.category&.permalink || 'products'}/#{product.slug}" || "",
          vendor: product.category&.name || "",
          image_url: image_url,
          variants: variants
        }.as_json
      end

      private

      def variants
        product.has_variants? ? product.variants.map(&:mailchimp_variant) : [product.master.mailchimp_variant]
      end

      def image_url
        product.mailchimp_image_url
      end
    end
  end
end
