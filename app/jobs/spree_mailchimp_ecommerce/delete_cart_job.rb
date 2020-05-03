# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order_number)
      begin
        gibbon_store.carts(order_number).delete
      rescue Gibbon::MailChimpError => e
        # silently eat the exception if we're trying to delete a cart that doesn't exist
        raise unless e.body["status"] == 404
      end
    end
  end
end
