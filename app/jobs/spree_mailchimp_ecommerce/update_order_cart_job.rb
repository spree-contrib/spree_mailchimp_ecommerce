module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_cart

      begin
        Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).ecommerce.
          stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
          carts(order.mailchimp_cart["id"]).
          update(body: order.mailchimp_cart)
      rescue Gibbon::MailChimpError => error
        Rails.logger.error("order: #{order.id} error: #{error.message}") unless error.status_code == 404
      end
    end
  end
end
