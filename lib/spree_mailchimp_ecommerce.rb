require "spree_core"
require "spree_extension"
require "spree_mailchimp_ecommerce/engine"
require "gibbon"
require "spree_mailchimp_ecommerce/gibbon_decorator"

module SpreeMailchimpEcommerce
  class << self
    def configuration
      Configuration.new
    end
  end

  class Configuration
    ATTR_LIST = [:mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, :cart_url]

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

::Spree::Core::Engine.routes.default_url_options[:host] = ENV['BASE_URL']
