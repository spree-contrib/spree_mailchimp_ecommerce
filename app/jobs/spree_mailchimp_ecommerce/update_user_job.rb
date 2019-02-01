module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user)
      return unless user.mailchimp_user
      gibbon_store.customers(user.mailchimp_user["id"]).update(body: user.reload.mailchimp_user)
    end
  end
end
