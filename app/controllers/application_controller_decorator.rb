module SpreeMailchimpEcommerce
  module ApplicationControllerDecorator
    def self.prepended(base)
      base.before_action :set_campaign_id

      base.helper SpreeMailchimpEcommerce::Engine.helpers
    end

    private

    def set_campaign_id
      return if params["mc_cid"].nil?

      cookies[:mailchimp_campaign_id] = {
          value: params["mc_cid"],
          domain: :all
      }
    end

    def mailchimp_store_id
      @store_id = ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id
    end
  end
end
ApplicationController.prepend(SpreeMailchimpEcommerce::ApplicationControllerDecorator)
