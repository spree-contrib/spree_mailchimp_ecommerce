# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateProductJob < ApplicationJob
    def perform(mailchimp_product)
      return unless mailchimp_product

      gibbon_store.products.create(body: mailchimp_product)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a product with ID = #{mailchimp_product['id']}. #{e}"
    end
  end
end
