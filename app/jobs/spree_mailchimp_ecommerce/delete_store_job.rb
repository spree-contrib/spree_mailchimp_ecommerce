module SpreeMailchimpEcommerce
  class DeleteStoreJob < ApplicationJob
    def perform(mailchimp_setting)
      ::Gibbon::Request.new(api_key: mailchimp_setting.mailchimp_api_key).
        ecommerce.stores(mailchimp_setting.mailchimp_store_id).delete
    end
  end
end
