module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find_by(id: order_id)
      return unless order

      mailchimp_order = order.mailchimp_order
      return unless mailchimp_order

      gibbon_store.orders.create(body: mailchimp_order)
    end
  end
end
