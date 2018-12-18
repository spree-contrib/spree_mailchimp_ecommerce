module SpreeMailchimpEcommerce
  class Engine < ::Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_mailchimp_ecommerce'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
