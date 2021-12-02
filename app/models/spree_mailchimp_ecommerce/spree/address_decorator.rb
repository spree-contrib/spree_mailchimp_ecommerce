module SpreeMailchimpEcommerce
  module Spree
    module AddressDecorator
      MAILCHIMP_ATTRIBUTES = ['firstname', 'lastname', 'address1', 'address2', 'city', 'state_id', 'zipcode', 'country_id'].freeze

      def self.prepended(base)
        base.after_update :update_mailchimp_user
      end

      private

      def update_mailchimp_user
        return if user&.bill_address_id != id
        return if (previous_changes.keys & MAILCHIMP_ATTRIBUTES).empty?

        SpreeMailchimpEcommerce::UpdateUserJob.perform_later(user.mailchimp_user)
      end
    end
  end
end

Spree::Address.prepend(SpreeMailchimpEcommerce::Spree::AddressDecorator)
