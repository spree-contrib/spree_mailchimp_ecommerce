module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user)
      return unless user.mailchimp_user

      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).ecommerce.
        stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).
        customers(user.mailchimp_user["id"]).
        update(body: user.mailchimp_user)
    end
  end
end
