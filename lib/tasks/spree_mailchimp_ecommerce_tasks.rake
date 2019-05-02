namespace :spree_mailchimp_ecommerce do
  desc "Create a store"
  task create_a_store: :environment do
    ::Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key).
      ecommerce.stores.create(body: {
                                id: ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id,
                                list_id: ::SpreeMailchimpEcommerce.configuration.mailchimp_list_id,
                                name: ::SpreeMailchimpEcommerce.configuration.mailchimp_store_name,
                                currency_code: "USD"
                              })
  end
end
