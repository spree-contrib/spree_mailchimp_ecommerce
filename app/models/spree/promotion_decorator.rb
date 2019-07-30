module Spree
  module SpreeMailchimpEcommerce
    module PromotionDecorator
      def self.prepended(base)
        base.after_create :create_mailchimp_promotion
        base.after_update :update_mailchimp_promotion
        base.after_destroy :delete_mailchimp_promotion
      end

      def mailchimp_promo_rule
        ::SpreeMailchimpEcommerce::Presenters::PromoRuleMailchimpPresenter.new(self).json
      end

      def mailchimp_promo_code
        ::SpreeMailchimpEcommerce::Presenters::PromoCodeMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_promotion
        ::SpreeMailchimpEcommerce::CreatePromoRuleJob.perform_later(self)
        ::SpreeMailchimpEcommerce::CreatePromoCodeJob.perform_later(self)
      end

      def update_mailchimp_promotion
        ::SpreeMailchimpEcommerce::UpdatePromoRuleJob.perform_later(self)
        ::SpreeMailchimpEcommerce::UpdatePromoCodeJob.perform_later(self)
      end

      def delete_mailchimp_promotion
        ::SpreeMailchimpEcommerce::DeletePromoCodeJob.perform_later(self)
        ::SpreeMailchimpEcommerce::DeletePromoRuleJob.perform_later(self)
      end
    end
  end
end
Spree::Promotion.prepend(Spree::SpreeMailchimpEcommerce::PromotionDecorator)
