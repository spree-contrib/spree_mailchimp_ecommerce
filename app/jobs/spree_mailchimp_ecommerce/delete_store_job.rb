module SpreeMailchimpEcommerce
  class DeleteStoreJob < ApplicationJob
    def perform
      begin
        gibbon_store.delete
      rescue Gibbon::MailChimpError => e
        Rails.logger.warn "[MAILCHIMP] Failed to delete store. #{e}"
      end
    end
  end
end
