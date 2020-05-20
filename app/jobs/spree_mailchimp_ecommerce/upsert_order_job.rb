# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpsertOrderJob < ApplicationJob
    def perform(mailchimp_order)
      gibbon_store.orders(mailchimp_order["id"]).upsert(body: mailchimp_order)
    end
  end
end
