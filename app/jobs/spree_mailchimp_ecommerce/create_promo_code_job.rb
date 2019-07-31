# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class CreatePromoCodeJob < ApplicationJob
    def perform(promotion)
      return unless promotion.mailchimp_promo_code

      gibbon_store.promo_rules(promotion.mailchimp_promo_rule["id"]).promo_codes.create(body: promotion.mailchimp_promo_code)
    rescue Gibbon::MailChimpError => e
      Rails.logger.warn "[MAILCHIMP] Failed to create a promo code with ID = #{promotion.id}. #{e}"
    end
  end
end
