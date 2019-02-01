# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order)
      gibbon_store.carts(order.mailchimp_cart["id"]).delete
    end
  end
end
