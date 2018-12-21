# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order)
      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        ecommerce.
        stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        carts(order.mailchimp_cart["id"]).delete
    rescue Gibbon::MailChimpError => error
      Rails.logger.error("user: #{u.id} error: #{error.message}")
    end
  end
end
