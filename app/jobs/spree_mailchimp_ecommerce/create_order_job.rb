# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderJob < ApplicationJob
    def perform(mailchimp_order)
      gibbon_store.orders.create(body: mailchimp_order)
    end
  end
end
