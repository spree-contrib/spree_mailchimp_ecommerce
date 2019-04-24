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

  desc 'Create 100 users and 100 orders'
  task create_users_and_orders: :environment do
    (1..100).each do |i|
      user = Spree::User.new(
                            email: "kz+script#{i}@sprks.eu",
                            password: 'password'
      )
      user.save!(validate: false)
      user.orders.new(state: 'complete').save!(validate: false)
    end
  end
end
