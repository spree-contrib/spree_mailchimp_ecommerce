# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find(order_id)
      return unless order.mailchimp_cart

      gibbon_store.carts(order.number).update(body: order.reload.mailchimp_cart)
    end
  end
end
