module SpreeMailchimpEcommerce
  module Spree
    module UserDecorator
      MAILCHIMP_ATTRIBUTES = ['firstname', 'lastname', 'email', 'bill_address_id'].freeze

      def self.prepended(base)
        base.after_create :create_mailchimp_user
        base.after_update :update_mailchimp_user
      end

      def mailchimp_user
        ::SpreeMailchimpEcommerce::UserMailchimpPresenter.new(self).json
      end

      def mailchimp_subscriber
        ::SpreeMailchimpEcommerce::SubscriberMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_user
        ::SpreeMailchimpEcommerce::CreateUserJob.perform_later(mailchimp_user)
      end

      def update_mailchimp_user
        return if (previous_changes.keys & MAILCHIMP_ATTRIBUTES).empty?

        ::SpreeMailchimpEcommerce::UpdateUserJob.perform_later(mailchimp_user)
      end
    end
  end
end
Spree::User.prepend(SpreeMailchimpEcommerce::Spree::UserDecorator)
