# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user)
      Gibbon::Request.ecommerce
                     .stores(ENV['MAILCHIMP_STORE_ID'])
                     .customers(user.mailchimp_decorated_user['id'])
                     .update(body: user.mailchimp_decorated_user)
    end
  end
end
