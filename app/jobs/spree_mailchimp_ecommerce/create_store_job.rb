module SpreeMailchimpEcommerce
  class CreateStoreJob < ApplicationJob
    def perform(*_args)
      ::Gibbon::Request.new(api_key: mailchimp_api_key).
        ecommerce.stores.create(body: {
                                  id: mailchimp_store_id,
                                  list_id: mailchimp_list_id,
                                  name: mailchimp_store_name,
                                  currency_code: ::Spree::Store.default.default_currency || ::Spree::Config[:currency],
                                  domain: ::Rails.application.routes.url_helpers.spree_url,
                                  is_syncing: true
                                })
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

      gibbon_store.update(body: { is_syncing: false })
    end
  end
end
