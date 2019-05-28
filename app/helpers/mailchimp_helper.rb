module Spree::SpreeMailchimpEcommerce
  class MailchimpHelper
    def mailchimp_snippet
      set_snippet&.html_safe
    end

    def set_snippet
      return unless mailchimp_store_id && ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key

      Rails.cache.fetch "mailchimp_settings_#{mailchimp_store_id}" do
        ::Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
            ecommerce.stores(mailchimp_store_id).retrieve.body["connected_site"]["site_script"]["fragment"]
      end
    end

    def mailchimp_store_id
      ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id
    end
  end
end
