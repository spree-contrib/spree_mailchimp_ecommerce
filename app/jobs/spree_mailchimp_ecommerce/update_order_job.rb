# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderJob < ApplicationJob
    def perform(order)
      order = ::Spree::Order.find(order.id)
      return unless order.mailchimp_order

      gibbon_store.orders(order.mailchimp_order["id"]).update(body: order.reload.mailchimp_order)
    end
  end
end
