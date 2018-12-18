# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreateUserJob < ApplicationJob
    def perform(user)
      Gibbon::Request.ecommerce.stores(ENV['MAILCHIMP_STORE_ID']).customers.create(body: user.mailchimp_decorated_user)
    end
  end
end
