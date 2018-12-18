# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(order)
      Gibbon::Request.ecommerce.stores(ENV['MAILCHIMP_STORE_ID'])
                     .carts.create(body: order.mailchimp_cart)
    rescue Gibbon::MailChimpError => error
      data = { msg: "order: #{order.id} error: #{error.message}" }
      ::Errors::CustomNotifier.new.call(error, data)
    end
  end
end
