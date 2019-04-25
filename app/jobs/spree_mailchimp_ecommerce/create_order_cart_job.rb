# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(cart)
      gibbon_store.carts.create(body: cart)
    end
  end
end
