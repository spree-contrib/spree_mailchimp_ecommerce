# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(product_id)
      product = ::Spree::Product.find(product_id)
      return unless product.mailchimp_product

      gibbon_store.products(product.mailchimp_product["id"]).update(body: product.reload.mailchimp_product)
    end
  end
end
