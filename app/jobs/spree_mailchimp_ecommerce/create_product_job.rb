# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product_id)
      product = ::Spree::Product.find(product_id)
      return unless product.mailchimp_product

      gibbon_store.products.create(body: product.mailchimp_product)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "Cannot created product##{product_id}. #{e}"
    end
  end
end
