# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateProductJob < ApplicationJob
    def perform(mailchimp_product)
      return unless mailchimp_product

      gibbon_store.products(mailchimp_product["id"]).update(body: mailchimp_product)
    end
  end
end
