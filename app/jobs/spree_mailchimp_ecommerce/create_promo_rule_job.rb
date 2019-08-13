# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreatePromoRuleJob < ApplicationJob
    def perform(mailchimp_promo_rule)
      return unless mailchimp_promo_rule

      gibbon_store.promo_rules.create(body: mailchimp_promo_rule)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a promo rule with ID = #{mailchimp_promo_rule['id']}. #{e}"
    end
  end
end
