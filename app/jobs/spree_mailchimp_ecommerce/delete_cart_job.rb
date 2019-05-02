# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order_number)
      gibbon_store.carts(order_number).delete
    end
  end
end
