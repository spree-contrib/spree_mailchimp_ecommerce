# frozen_string_literal: true

class CreateOrderCartJob < ApplicationJob
  def perform(order)
    return unless order.mailchimp_order

    Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).
      carts.create(body: order.mailchimp_cart)
  rescue Gibbon::MailChimpError => error
    Logger.error("user: #{u.id} error: #{error.message}")
  end
end
