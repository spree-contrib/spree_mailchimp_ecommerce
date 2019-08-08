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
    yield(configuration)
  end

  class Configuration
    attr_accessor :mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, :cart_url
  end
end
