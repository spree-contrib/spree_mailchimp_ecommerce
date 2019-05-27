# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product_id)
      product = ::Spree::Product.find(product_id)
      return unless product.mailchimp_product

      gibbon_store.products.create(body: product.mailchimp_product)
    rescue Gibbon::MailChimpError
      puts "ERROR FOR PRODUCT #{product_id}"
    end
  end
end
