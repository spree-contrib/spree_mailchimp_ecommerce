module SpreeMailchimpEcommerce
  class UpdateStoreJob < ApplicationJob
    def perform(mailchimp_setting)
      ::Gibbon::Request.new(api_key: mailchimp_setting.mailchimp_api_key).
        ecommerce.stores(mailchimp_setting.mailchimp_store_id).
        update(body: { name: mailchimp_setting.mailchimp_store_name })
    end
  end
end
