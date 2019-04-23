module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user_id)
      user = Spree::User.find_by(id: user_id)
      return unless user

      mailchimp_user = user.mailchimp_user
      return unless mailchimp_user

      gibbon_store.customers(mailchimp_user["id"]).update(body: mailchimp_user)
    rescue Gibbon::MailChimpError => error
      raise unless error.status_code == 404
    end
  end
end
