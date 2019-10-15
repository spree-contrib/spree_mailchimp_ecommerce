# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeletePromoJob < ApplicationJob
    def perform(mailchimp_promo_rule, mailchimp_promo_code)
      ::SpreeMailchimpEcommerce::DeletePromoCodeJob.perform_now(mailchimp_promo_rule, mailchimp_promo_code)
      ::SpreeMailchimpEcommerce::DeletePromoRuleJob.perform_now(mailchimp_promo_rule)
    end
  end
end
