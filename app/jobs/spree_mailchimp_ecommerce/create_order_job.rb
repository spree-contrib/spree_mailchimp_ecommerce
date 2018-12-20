module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_order

      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        orders.create(body: order.mailchimp_order)
    rescue Gibbon::MailChimpError => error
      Rails.logger.error("user: #{u.id} error: #{error.message}")
    end
  end
end
