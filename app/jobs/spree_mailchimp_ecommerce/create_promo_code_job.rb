# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreatePromoCodeJob < ApplicationJob
    def perform(mailchimp_promo_rule, mailchimp_promo_code)
      return unless mailchimp_promo_code

      gibbon_store.promo_rules(mailchimp_promo_rule["id"]).promo_codes.create(body: mailchimp_promo_code)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a promo code with ID = #{mailchimp_promo_code['id']}. #{e}"
    end
  end
end
