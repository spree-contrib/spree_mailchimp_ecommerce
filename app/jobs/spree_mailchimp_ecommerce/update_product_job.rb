module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(product_id)
      product = Spree::Product.find_by(id: product_id)
      return unless product

      mailchimp_product = product.mailchimp_product
      return unless mailchimp_product

      gibbon_store.products(mailchimp_product["id"]).update(body: mailchimp_product)
    rescue Gibbon::MailChimpError => error
      raise unless error.status_code == 404
    end
  end
end
