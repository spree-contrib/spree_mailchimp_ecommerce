# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateOrderCartJob < ApplicationJob
    def perform(mailchimp_cart)
      gibbon_store.carts(mailchimp_cart["id"]).update(body: mailchimp_cart)
      rescue Gibbon::MailChimpError => e
        Rails.logger.warn "[MAILCHIMP] Failed to update mailchimp cart. #{e}"

    end
  end
end
