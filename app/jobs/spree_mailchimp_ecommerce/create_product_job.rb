module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(product_id)
      product = Spree::Product.find_by(id: product_id)
      return unless product

      mailchimp_product = product.mailchimp_product
      return unless mailchimp_product

      gibbon_store.products.create(body: mailchimp_product)
    end
  end
end
