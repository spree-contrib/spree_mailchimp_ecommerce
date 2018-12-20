module SpreeMailchimpEcommerce
  class ImportExistingJob < ApplicationJob
    def perform
      upload_customers
      upload_products
      upload_carts
      upload_orders
    end

    private

    def upload_customers
      Spree::User.find_each do |u|
        begin
          Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
            ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).customers.create(body: u.mailchimp_user)
        rescue StandardError => error
          Rails.logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_products
      Spree::Product.includes(:variants).find_each do |p|
        begin
          pr = Mailchimp::ProductMailchimpPresenter.new(p).json
          Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
            ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).products.create(body: pr)
        rescue StandardError => error
          Rails.logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_carts
      Spree::Order.where.not(state: "complete").includes(:line_items).find_each do |o|
        begin
          ord = Mailchimp::CartMailchimpPresenter.new(o).json
          next if ord.empty?

          Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
            ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).carts.create(body: ord)
        rescue StandardError => error
          Rails.logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_orders
      Spree::Order.where(state: "complete").includes(:line_items).find_each do |o|
        begin
          ord = Mailchimp::OrderMailchimpPresenter.new(o).json
          next if ord.empty?

          Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
            ecommerce.stores(::SpreeMailchimpEcommerce.configuration.mailchimp_store_id).orders.create(body: ord)
        rescue StandardError => error
          Rails.logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end
  end
end
