module SpreeMailchimpEcommerce
  class ImportExistingJob < ApplicationJob
    def perform
      create_store
      upload_customers
      upload_products
      upload_carts
      upload_orders
    end

    private

    def create_store
      Gibbon::Request.ecommerce.stores.create(body: {
                                                id: ENV["MAILCHIMP_STORE_ID"],
                                                list_id: ENV["MAILCHIMP_LIST_ID"],
                                                name: ENV["MAILCHIMP_STORE_NAME"],
                                                currency_code: "USD"
                                              })
    end

    def upload_customers
      Spree::User.find_each do |u|
        begin
          Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).customers.create(body: u.mailchimp_user)
        rescue StandardError => error
          Logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_products
      Spree::Product.includes(:variants).find_each do |p|
        begin
          pr = Mailchimp::ProductMailchimpPresenter.new(p).json
          Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).products.create(body: pr)
        rescue StandardError => error
          Logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_carts
      Spree::Order.where.not(state: "complete").includes(:line_items).find_each do |o|
        begin
          ord = Mailchimp::CartMailchimpPresenter.new(o).json
          next if ord.empty?

          Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).carts.create(body: ord)
        rescue StandardError => error
          Logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end

    def upload_orders
      Spree::Order.where(state: "complete").includes(:line_items).find_each do |o|
        begin
          ord = Mailchimp::OrderMailchimpPresenter.new(o).json
          next if ord.empty?

          Gibbon::Request.ecommerce.stores(ENV["MAILCHIMP_STORE_ID"]).orders.create(body: ord)
        rescue StandardError => error
          Logger.error("user: #{u.id} error: #{error.message}")
        end
      end
    end
  end
end
