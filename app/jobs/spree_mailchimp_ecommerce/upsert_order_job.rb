# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpsertOrderJob < ApplicationJob
    def perform(mailchimp_order)
      gibbon_store.orders(mailchimp_order["id"]).update(body: mailchimp_order)
    rescue Gibbon::MailChimpError => e
      if e.status_code == 404
        gibbon_store.orders(mailchimp_order["id"]).create(body: mailchimp_order)
      else
        # re-raise
        raise
      end
    end
  end
end
