module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(product)
      return unless product.mailchimp_product

      Gibbon::Request.ecommerce.
        stores(ENV["MAILCHIMP_STORE_ID"]).
        products(product.mailchimp_product["id"]).
        update(body: product.mailchimp_product)
    end
  end
end
