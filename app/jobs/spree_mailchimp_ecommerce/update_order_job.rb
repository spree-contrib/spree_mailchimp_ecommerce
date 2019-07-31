# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderJob < ApplicationJob
    def perform(mailchimp_order)
      gibbon_store.orders(mailchimp_order["id"]).update(body: mailchimp_order)
    end
  end
end
