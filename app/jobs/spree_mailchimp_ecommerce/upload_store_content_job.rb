module SpreeMailchimpEcommerce
  class UploadStoreContentJob < ApplicationJob
    def perform(*_args)
      begin
        gibbon_store.update(body: { is_syncing: true })

        ::Spree::Product.find_each do |product|
          ::SpreeMailchimpEcommerce::CreateProductJob.perform_now(product.mailchimp_product)
        end

        ::Spree::User.where.not(email: nil).find_each do |user|
          ::SpreeMailchimpEcommerce::CreateUserJob.perform_now(user.mailchimp_user)
        end

        ::Spree::Order.complete.find_each do |order|
          ::SpreeMailchimpEcommerce::CreateOrderJob.perform_now(order.mailchimp_order)
        end

        ::Spree::Promotion.find_each do |promotion|
          ::SpreeMailchimpEcommerce::CreatePromoRuleJob.perform_now(promotion.mailchimp_promo_rule)
          ::SpreeMailchimpEcommerce::CreatePromoCodeJob.perform_now(promotion.mailchimp_promo_rule, promotion.mailchimp_promo_code)
        end
      rescue Gibbon::MailChimpError => e
        Rails.logger.error("[MAILCHIMP] Error while syncing process: #{e}")
      end
    ensure
      gibbon_store.update(body: { is_syncing: false })
    end
  end
end
