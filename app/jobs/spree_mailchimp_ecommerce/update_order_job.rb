# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderJob < ApplicationJob
    def perform(order)
      gibbon_store.orders(order.number).update(body: order.mailchimp_order)
    end
  end
end
