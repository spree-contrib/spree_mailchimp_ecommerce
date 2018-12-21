# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeleteLineItemJob < ApplicationJob
    def perform(line)
      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        ecommerce.
        stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        carts(line.order.mailchimp_cart["id"]).lines(Digest::MD5.hexdigest("#{line.id}#{line.order_id}")).
        delete
    end
  end
end
