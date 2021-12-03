# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(mailchimp_user)
      return unless mailchimp_user

      gibbon_store.customers(mailchimp_user["id"]).update(body: mailchimp_user)
    rescue Gibbon::MailChimpError => e
      if e.status_code == 404
        gibbon_store.customers.create(body: mailchimp_user)
      else
        Rails.logger.error("[MAILCHIMP] Error while creating user: #{e}")
      end
    end
  end
end
