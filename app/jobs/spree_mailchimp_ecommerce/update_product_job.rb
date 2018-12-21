module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(product)
      return unless product.mailchimp_product

      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).ecommerce.
        stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        products(product.mailchimp_product["id"]).
        update(body: product.reload.mailchimp_product)
    end
  end
end
