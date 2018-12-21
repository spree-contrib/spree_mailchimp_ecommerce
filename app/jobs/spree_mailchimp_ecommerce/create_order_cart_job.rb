# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_cart

      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        ecommerce.
        stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        carts.create(body: order.mailchimp_cart)
    end
  end
end
