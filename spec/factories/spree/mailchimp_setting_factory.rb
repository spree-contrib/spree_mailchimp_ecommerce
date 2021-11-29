FactoryBot.define do
  factory :mailchimp_setting, class: MailchimpSetting do
    sequence(:mailchimp_api_key) { |i| "#{FFaker::Internet.password}" + i.to_s }
    sequence(:mailchimp_store_id) { |i| "#{FFaker::Internet.password}" + i.to_s }
    sequence(:mailchimp_list_id) { |i| "#{FFaker::Internet.password}" + i.to_s }
    sequence(:mailchimp_store_name) { |i| "store_no_#{i}" }
    cart_url { FFaker::Internet.http_url }
    mailchimp_account_name { FFaker::Internet.user_name }
    state { 'inactive' }
    mailchimp_store_email { FFaker::Internet.email }
  end
end
