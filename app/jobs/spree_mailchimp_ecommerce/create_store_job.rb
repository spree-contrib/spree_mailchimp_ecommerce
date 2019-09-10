module SpreeMailchimpEcommerce
  class CreateStoreJob < ApplicationJob
    def perform(mailchimp_setting)
      ::Gibbon::Request.new(api_key: mailchimp_setting.mailchimp_api_key).
        ecommerce.stores.create(body: {
                                  id: mailchimp_setting.mailchimp_store_id,
                                  list_id: mailchimp_setting.mailchimp_list_id,
                                  name: mailchimp_setting.mailchimp_store_name,
                                  currency_code: ::Spree::Store.default.default_currency || ::Spree::Config[:currency],
                                  domain: ::Rails.application.routes.url_helpers.spree_url,
                                  is_syncing: true
                                })
    end
  end
end
