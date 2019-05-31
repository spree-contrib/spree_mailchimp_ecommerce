module SpreeMailchimpEcommerce
  class DeleteProductJob < ApplicationJob
    def perform(product_id)
      product = ::Spree::Product.find(product_id)

      gibbon_store.products(product.mailchimp_product["id"]).delete
    end
  end
end
