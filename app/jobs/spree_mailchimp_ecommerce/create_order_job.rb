module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_order

      gibbon_store.orders.create(body: order.mailchimp_order)
    rescue Gibbon::MailChimpError => error
      Rails.logger.error("order: #{order.id} error: #{error.message}")
    end
  end
end
