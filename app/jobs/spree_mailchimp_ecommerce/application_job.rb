module SpreeMailchimpEcommerce
  class ApplicationJob < ActiveJob::Base
    private
    def gibbon_store
      Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
        ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id)
    end
  end
end
