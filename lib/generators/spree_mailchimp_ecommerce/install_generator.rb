module SpreeMailchimpEcommerce
  class InstallGenerator < Rails::Generators::Base
    def create_initializer_file
      create_file "config/initializers/spree_mailchimp_ecommerce.rb", content
    end

    private

    def content
      "SpreeMailchimpEcommerce.configure do |config|\n  config.mailchimp_api_key = ''\n  config.mailchimp_store_id = ''\n  config.mailchimp_list_id = ''\n  config.mailchimp_store_name = ''\nend"
    end
  end
end
