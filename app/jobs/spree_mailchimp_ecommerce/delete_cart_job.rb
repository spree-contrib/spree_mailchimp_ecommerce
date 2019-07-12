# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order_number)
      gibbon_store.carts(order_number).delete

    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to delete mailchimp cart #{e}"

    end
  end
end
