module SpreeMailchimpEcommerce
  class DeleteProductJob < ApplicationJob
    def perform(product)
      gibbon_store.products(product.mailchimp_product["id"]).delete
    end
  end
end
