# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob

    def perform(cart_number, line_id)
      gibbon_store.carts(cart_number).lines(line_id).delete
    end

  end
end
