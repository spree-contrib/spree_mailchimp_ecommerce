module SpreeMailchimpEcommerce
  class DeleteProductJob < ApplicationJob
    def perform(mailchimp_product)
      gibbon_store.products(mailchimp_product["id"]).delete
    end
  end
end
