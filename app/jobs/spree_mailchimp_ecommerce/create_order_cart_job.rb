# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateOrderCartJob < ApplicationJob
    def perform(cart)
      gibbon_store.carts.create(body: cart)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create mailchimp cart #{e}"
    end
  end
end
