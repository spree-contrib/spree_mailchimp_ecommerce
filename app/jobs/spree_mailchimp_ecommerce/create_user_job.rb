module SpreeMailchimpEcommerce
  class CreateUserJob < ApplicationJob
    def perform(user_id)
      user = Spree::User.find(user_id)
      return unless user.mailchimp_user

      gibbon_store.customers.create(body: user.mailchimp_user)
    end
  end
end
