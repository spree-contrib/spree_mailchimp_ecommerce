# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(mailchimp_cart)
      gibbon_store.carts(mailchimp_cart["id"]).update(body: mailchimp_cart)
    end
  end
end
