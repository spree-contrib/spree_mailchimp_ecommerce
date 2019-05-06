module SpreeMailchimpEcommerce
  class ApplicationJob < ActiveJob::Base
    around_perform do |_job, block|
      raise "Integration inactive" unless mailchimp_active?
      raise "Mailchimp extension not configurated" if [mailchimp_api_key,
                                                       mailchimp_store_id,
                                                       mailchimp_list_id,
                                                       mailchimp_store_name,
                                                       cart_url].map(&:empty?).any?

      block.call
    end

    private

    def mailchimp_active?
      ::SpreeMailchimpEcommerce.configuration.active?
    end

    def mailchimp_api_key
      ::SpreeMailchimpEcommerce.configuration.mailchimp_api_key
    end

    def mailchimp_store_id
      ::SpreeMailchimpEcommerce.configuration.mailchimp_store_id
    end

    def mailchimp_list_id
      ::SpreeMailchimpEcommerce.configuration.mailchimp_list_id
    end

    def mailchimp_store_name
      ::SpreeMailchimpEcommerce.configuration.mailchimp_store_name
    end

    def cart_url
      ::SpreeMailchimpEcommerce.configuration.cart_url
    end

    def gibbon_store
      ::Gibbon::Request.new(api_key: mailchimp_api_key).
        ecommerce.stores(mailchimp_store_id)
    end
  end
end
