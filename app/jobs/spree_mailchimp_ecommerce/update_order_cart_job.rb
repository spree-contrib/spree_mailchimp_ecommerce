module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find(order_id)
      return unless order.mailchimp_cart

      begin
        gibbon_store.carts(order.mailchimp_cart["id"]).update(body: order.reload.mailchimp_cart)
      rescue Gibbon::MailChimpError => error
        Rails.logger.error("order: #{order.id} error: #{error.message}") unless error.status_code == 404
      end
    end
  end
end
