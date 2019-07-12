# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateUserJob < ApplicationJob

    def perform(mailchimp_user)
      gibbon_store.customers.create(body: mailchimp_user)

      rescue Gibbon::MailChimpError => e
        Rails.logger.warn "[MAILCHIMP] Customer Already Exists. #{e}"
    end

  end
end
