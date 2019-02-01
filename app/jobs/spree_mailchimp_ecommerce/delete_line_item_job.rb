# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line)
      gibbon_store.carts(line.order.mailchimp_cart["id"]).lines(Digest::MD5.hexdigest("#{line.id}#{line.order_id}")).delete
    end
  end
end
