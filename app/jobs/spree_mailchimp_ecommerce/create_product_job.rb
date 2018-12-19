module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product)
      return unless product.mailchimp_product

      Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).products.create(body: product.mailchimp_product)
    end
  end
end
