# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeletePromoRuleJob < ApplicationJob
    def perform(promotion)
      gibbon_store.promo_rules(promotion.mailchimp_promo_rule["id"]).delete
    end
  end
end
