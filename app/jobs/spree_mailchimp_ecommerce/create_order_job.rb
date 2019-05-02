# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order)
      gibbon_store.orders.create(body: order)
    end
  end
end
