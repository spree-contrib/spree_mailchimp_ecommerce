# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UpdatePromoRuleJob < ApplicationJob
    def perform(promotion)
      gibbon_store.promo_rules(promotion.mailchimp_promo_rule["id"]).
        update(body: promotion.reload.mailchimp_promo_rule)
    end
  end
end
