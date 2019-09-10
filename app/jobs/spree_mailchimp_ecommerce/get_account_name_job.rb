module SpreeMailchimpEcommerce
  class GetAccountNameJob < ApplicationJob
    def perform(mailchimp_setting)
      ::Gibbon::Request.new(api_key: mailchimp_setting.mailchimp_api_key).retrieve.body["account_name"]
    end
  end
end
