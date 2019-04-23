# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line_id)
      line = Spree::LineItem.find_by(id: line_id)
      return unless line

      line_digest = Digest::MD5.hexdigest("#{line.id}#{line.order_id}")
      gibbon_store.carts(line.order.number).lines(line_digest).delete
    rescue Gibbon::MailChimpError => error
      raise unless error.status_code == 404
    end
  end
end
