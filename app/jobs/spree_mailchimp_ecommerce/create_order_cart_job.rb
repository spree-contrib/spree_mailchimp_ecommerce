# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_cart

      gibbon_store.carts.create(body: order.mailchimp_cart)
    end
  end
end
