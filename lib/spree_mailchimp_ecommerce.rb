require "spree_core"
require "spree_extension"
require "spree_mailchimp_ecommerce/engine"
require "gibbon"

module SpreeMailchimpEcommerce
  class << self
    def configuration
      Configuration.new
    end
  end

  class Configuration
    ATTR_LIST = [:mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, :cart_url, :active?]

    ATTR_LIST.each do |a|
      define_method a do
        setting_model.try(a)
      end
    end

    private

    def setting_model
      ::MailchimpSetting.last
    end
  end
end
