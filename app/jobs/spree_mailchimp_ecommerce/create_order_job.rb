# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(order)
      Gibbon::Request.ecommerce.stores(ENV['MAILCHIMP_STORE_ID'])
                     .orders.create(body: order.mailchimp_order)
    rescue Gibbon::MailChimpError => error
      data = { msg: "order: #{order.id} error: #{error.message}" }
      ::Errors::CustomNotifier.new.call(error, data)
    end
  end
end
