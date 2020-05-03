# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line_id, order_id, order_number)
      gibbon_store.carts(order_number).lines(Digest::MD5.hexdigest("#{line_id}#{order_id}")).delete
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to delete line item = #{line_id}. #{e}"
    end
  end
end
