require "spree_core"
require "spree_extension"
require "spree_mailchimp_ecommerce/engine"
require "gibbon"

module SpreeMailchimpEcommerce
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
  end

  class Configuration
    ATTR_LIST = [:mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, :cart_url, :active?]

    ATTR_LIST.each do |a|
      define_method a do
        Rails.cache.fetch "settings_#{a}" do
          setting_model.try(a)
        end
      end
    end

    private

    def setting_model
      ::MailchimpSetting.last
    end
  end


end
