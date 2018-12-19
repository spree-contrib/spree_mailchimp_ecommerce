module SpreeMailchimpEcommerce
  class CreateUserJob < ApplicationJob
    def perform(user)
      return unless user.mailchimp_user

      Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).customers.create(body: user.mailchimp_user)
    end
  end
end
