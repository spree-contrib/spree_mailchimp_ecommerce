# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeletePromoRuleJob < ApplicationJob
    def perform(mailchimp_promo_rule)
      gibbon_store.promo_rules(mailchimp_promo_rule["id"]).delete
    end
  end
end
