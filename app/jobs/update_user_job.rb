class UpdateUserJob < ApplicationJob
  def perform(user)
    return unless user.mailchimp_user

    Gibbon::Request.ecommerce.
      stores(ENV["MAILCHIMP_STORE_ID"]).
      customers(user.mailchimp_user["id"]).
      update(body: user.mailchimp_user)
  end
end
