module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find_by(id: order_id)
      return unless order

      mailchimp_cart = order.mailchimp_cart
      return unless mailchimp_cart

      begin
        gibbon_store.carts(order.number).update(body: mailchimp_cart)
      rescue Gibbon::MailChimpError => e
        gibbon_store.carts.create(body: mailchimp_cart) if e.status_code == 404
      end
    end
  end
end
