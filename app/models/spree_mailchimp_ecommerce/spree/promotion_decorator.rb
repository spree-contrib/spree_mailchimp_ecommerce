module Spree
  module SpreeMailchimpEcommerce
    module PromotionDecorator
      def self.prepended(base)
        base.after_create :create_mailchimp_promotion
        base.after_update :update_mailchimp_promotion
        base.after_destroy :delete_mailchimp_promotion
      end

      def mailchimp_promo_rule
        ::SpreeMailchimpEcommerce::PromoRuleMailchimpPresenter.new(self).json
      end

      def mailchimp_promo_code
        ::SpreeMailchimpEcommerce::PromoCodeMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_promotion
        ::SpreeMailchimpEcommerce::CreatePromoRuleJob.perform_later(mailchimp_promo_rule)
        ::SpreeMailchimpEcommerce::CreatePromoCodeJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
      end

      def update_mailchimp_promotion
        ::SpreeMailchimpEcommerce::UpdatePromoRuleJob.perform_later(mailchimp_promo_rule)
        ::SpreeMailchimpEcommerce::UpdatePromoCodeJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
      end

      def delete_mailchimp_promotion
        ::SpreeMailchimpEcommerce::DeletePromoCodeJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
        ::SpreeMailchimpEcommerce::DeletePromoRuleJob.perform_later(mailchimp_promo_rule)
      end
    end
  end
end
Spree::Promotion.prepend(Spree::SpreeMailchimpEcommerce::PromotionDecorator)
