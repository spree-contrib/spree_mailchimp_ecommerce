# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreatePromoRuleJob < ApplicationJob
    def perform(promotion)
      return unless promotion.mailchimp_promo_rule

      gibbon_store.promo_rules.create(body: promotion.mailchimp_promo_rule)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a promo rule with ID = #{promotion.id}. #{e}"
    end
  end
end
