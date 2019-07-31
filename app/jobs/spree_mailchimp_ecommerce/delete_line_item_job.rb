# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line)
      gibbon_store.carts(line.order.number).lines(Digest::MD5.hexdigest("#{line.id}#{line.order_id}")).delete
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to delete line item = #{line.id}. #{e}"
    end
  end
end
