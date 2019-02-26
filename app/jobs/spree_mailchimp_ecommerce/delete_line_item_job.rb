# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line_id)
      line = Spree::LineItem.find(line_id)

      gibbon_store.carts(line.order.number).lines(Digest::MD5.hexdigest("#{line.id}#{line.order_id}")).delete
    end
  end
end
