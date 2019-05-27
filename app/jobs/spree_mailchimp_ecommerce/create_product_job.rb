# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product_id)
      product = ::Spree::Product.unscoped.find(product_id)
      return unless product.mailchimp_product

      gibbon_store.products.create(body: product.mailchimp_product)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a product with ID = #{product_id}. #{e}"
    end
  end
end
