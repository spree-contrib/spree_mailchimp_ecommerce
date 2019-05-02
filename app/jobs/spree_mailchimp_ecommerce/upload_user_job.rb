# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UploadUserJob < ApplicationJob
    def perform(user_id)
      user = ::Spree::User.find(user_id)
      return unless user.mailchimp_subscriber

      ::Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        lists(::SpreeMailchimpEcommerce.configuration.mailchimp_list_id).members.
        create(body: user.mailchimp_subscriber)
    end
  end
end
