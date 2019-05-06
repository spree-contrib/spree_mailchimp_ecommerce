module SpreeMailchimpEcommerce
  module ApplicationControllerDecorator
    def self.prepended(base)
      base.before_action :set_campaign_id, :set_snippet
    end

    private

    def set_campaign_id
      return if params["mc_cid"].nil?

      cookies[:mailchimp_campaign_id] = { value: params["mc_cid"] }
    end

    def set_snippet
      return unless mailchimp_store_id && ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key

      @mailchimp_snippet = Rails.cache.fetch "mailchimp_settings_#{mailchimp_store_id}" do
        ::Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
          ecommerce.stores(mailchimp_store_id).retrieve.body["connected_site"]["site_script"]["fragment"]
      end
    end

    def mailchimp_store_id
      @store_id = ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id
    end
  end
end
ApplicationController.prepend(SpreeMailchimpEcommerce::ApplicationControllerDecorator)
