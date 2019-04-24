# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user_id)
      user = Spree::User.find(user_id)
      return unless user.mailchimp_user

      gibbon_store.customers(user.mailchimp_user["id"]).update(body: user.reload.mailchimp_user)
    end
  end
end
