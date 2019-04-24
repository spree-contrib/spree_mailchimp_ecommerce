# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find(order_id)
      return unless order.mailchimp_order

      gibbon_store.orders.create(body: order.mailchimp_order)
    end
  end
end
