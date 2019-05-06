module SpreeMailchimpEcommerce
  class CreateStoreJob < ApplicationJob
    def perform(*_args)
      ::Gibbon::Request.new(api_key: mailchimp_api_key).
        ecommerce.stores.create(body: {
                                  id: mailchimp_store_id,
                                  list_id: mailchimp_list_id,
                                  name: mailchimp_store_name,
                                  currency_code: "USD"
                                })
      ::MailchimpSetting.last.update(site_script: script_line)
    end

    def script_line
      ::Gibbon::Request.new(api_key: mailchimp_api_key).
        ecommerce.stores(mailchimp_store_id).retrieve.body["connected_site"]["site_script"]["fragment"] + "\n"
    end
  end
end
