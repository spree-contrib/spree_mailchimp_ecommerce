module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_order

      Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).
        orders.create(body: order.mailchimp_order)
    rescue Gibbon::MailChimpError => error
      Rails.logger.error("user: #{u.id} error: #{error.message}")
    end
  end
end
