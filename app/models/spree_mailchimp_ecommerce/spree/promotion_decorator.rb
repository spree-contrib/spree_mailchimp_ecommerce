module SpreeMailchimpEcommerce
  module Spree
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
        ::SpreeMailchimpEcommerce::CreatePromoJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
      end

      def update_mailchimp_promotion
        ::SpreeMailchimpEcommerce::UpdatePromoJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
      end

      def delete_mailchimp_promotion
        ::SpreeMailchimpEcommerce::DeletePromoJob.perform_later(mailchimp_promo_rule, mailchimp_promo_code)
      end
    end
  end
end
Spree::Promotion.prepend(SpreeMailchimpEcommerce::Spree::PromotionDecorator)
