# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdatePromoJob < ApplicationJob
    def perform(mailchimp_promo_rule, mailchimp_promo_code)
      ::SpreeMailchimpEcommerce::UpdatePromoRuleJob.perform_now(mailchimp_promo_rule)
      ::SpreeMailchimpEcommerce::UpdatePromoCodeJob.perform_now(mailchimp_promo_rule, mailchimp_promo_code)
    end
  end
end
