module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product)
      return unless product.mailchimp_product
      gibbon_store.products.create(body: product.mailchimp_product)
    end
  end
end
