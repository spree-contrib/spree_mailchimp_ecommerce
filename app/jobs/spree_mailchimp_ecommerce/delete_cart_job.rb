# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteCartJob < ApplicationJob
    def perform(order_id)
      order = Spree::Order.find_by(id: order_id)
      return unless order

      gibbon_store.carts(order.number).delete
    rescue Gibbon::MailChimpError => error
      raise unless error.status_code == 404
    end
  end
end
