# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class DeletePromoCodeJob < ApplicationJob
    def perform(promotion)
      gibbon_store.promo_rules(promotion.mailchimp_promo_rule["id"]).
        promo_codes(promotion.mailchimp_promo_code["id"]).delete
    end
  end
end
