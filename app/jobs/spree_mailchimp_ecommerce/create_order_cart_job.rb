# frozen_string_literal: true
module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(order)
      return unless order.mailchimp_cart

      Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).
        carts.create(body: order.mailchimp_cart)
    rescue Gibbon::MailChimpError => error
      Rails.logger.error("user: #{u.id} error: #{error.message}")
    end
  end
end
