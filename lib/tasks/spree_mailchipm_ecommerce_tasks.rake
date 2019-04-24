namespace :spree_mailchimp_ecommerce do
  desc "Create a store"
  task create_a_store: :environment do
    Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
      ecommerce.stores.create(body: {
                                id: ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id,
                                list_id: ::SpreeMailchimpEcommerce.configuration.mailchimp_list_id,
                                name: ::SpreeMailchimpEcommerce.configuration.mailchimp_store_name,
                                currency_code: "USD"
                              })
  end

  desc "Initial uploading of products list"
  task upload_products: :environment do
    logger = Logger.new("log/spree_mailchimp_initial_upload.log")
    Spree::Product.find_each do |product|
      begin
        SpreeMailchimpEcommerce::CreateProductJob.perform_now(product.id)
      rescue StandardError => e
        logger.error("#{e.class}: #{e.message}, product id: #{product.id}")
      end
    end
  end
end
