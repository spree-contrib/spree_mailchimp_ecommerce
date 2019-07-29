module SpreeMailchimpEcommerce
  class Engine < ::Rails::Engine
    require "spree/core"
    isolate_namespace Spree
    engine_name "spree_mailchimp_ecommerce"

    require "mailchimp_helper"

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_presenter*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      ApplicationController.send :include, MailchimpHelper
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
