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

  task create_a_list: :environment do
    require 'highline'
    cli = HighLine.new
    lists = Gibbon::Request.new(api_key: ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key)
              .lists.retrieve.body['lists'].map{|e| { id: e['id'], name: e['name'] }}
    puts 'no list found' && return unless lists.any?
    lists.each_with_index {|e, i| puts "#{i}) #{e[:name]}"}
    answer = cli.ask "Which list do you want to use for integration? (type number)"
    puts "Your list id is: #{lists[answer][:id]}. Put it into config file"
  end
end
