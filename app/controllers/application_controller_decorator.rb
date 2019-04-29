module SpreeMailchimpEcommerce
  module ApplicationControllerDecorator
    def self.prepended(base)
      base.before_action :set_campaign_id
    end

    private

    def set_campaign_id
      return if params['mc_cid'].nil?

      cookies[:mailchimp_campaign_id] = { value: params['mc_cid'] }
    end
  end
end
ApplicationController.prepend(SpreeMailchimpEcommerce::ApplicationControllerDecorator)
