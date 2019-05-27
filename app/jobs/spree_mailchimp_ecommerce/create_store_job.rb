module SpreeMailchimpEcommerce
  class CreateStoreJob < ApplicationJob
    def perform(*_args)
      response = ::Gibbon::Request.new(api_key: mailchimp_api_key).
        ecommerce.stores.create(body: {
                                  id: mailchimp_store_id,
                                  list_id: mailchimp_list_id,
                                  name: mailchimp_store_name,
                                  currency_code: "USD",
                                  domain: ENV['BASE_URL']
                                })
      MailchimpSetting.last.update(active: true) if response
      ::Spree::Product.pluck(:id).each do |id|
        ::SpreeMailchimpEcommerce::CreateProductJob.perform_later(id)
      end
    end
  end
end
