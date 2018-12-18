# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(product)
      Gibbon::Request.ecommerce
                     .stores(ENV['MAILCHIMP_STORE_ID'])
                     .products(product.mailchimp_product['id'])
                     .update(body: product.mailchimp_product)
    end
  end
end
