# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreatePromoJob < ApplicationJob
    def perform(mailchimp_promo_rule, mailchimp_promo_code)
      ::SpreeMailchimpEcommerce::CreatePromoRuleJob.perform_now(mailchimp_promo_rule)
      ::SpreeMailchimpEcommerce::CreatePromoCodeJob.perform_now(mailchimp_promo_rule, mailchimp_promo_code)
    end
  end
end
