module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_cart
      begin
        Gibbon::Request.ecommerce.
          stores(ENV["MAILCHIMP_STORE_ID"]).
          carts(order.mailchimp_cart["id"]).
          update(body: order.mailchimp_cart)
      rescue Gibbon::MailChimpError => error
        Rails.Rails.logger.error("order: #{order.id} error: #{error.message}") unless error.status_code == 404
      end
    end
  end
end
