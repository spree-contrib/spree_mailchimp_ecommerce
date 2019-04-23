module SpreeMailchimpEcommerce
  class UpdateUserJob < ApplicationJob
    def perform(user_id)
      user = Spree::User.find_by(id: user_id)
      return unless user

      mailchimp_user = user.mailchimp_user
      return unless mailchimp_user

      begin
        gibbon_store.customers(mailchimp_user["id"]).update(body: mailchimp_user)
      rescue Gibbon::MailChimpError => e
        gibbon_store.customers.create(body: mailchimp_user) if e.status_code == 404
      end
    end
  end
end
