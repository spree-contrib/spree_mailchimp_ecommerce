module Spree
  module SpreeMailchimpEcommerce
    module UserDecorator
      def self.prepended(base)
        base.after_create :create_mailchimp_user
        base.after_update :update_mailchimp_user
      end

      def mailchimp_user
        ::SpreeMailchimpEcommerce::Presenters::UserMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_user
        ::SpreeMailchimpEcommerce::CreateUserJob.perform_later(self)
      end

      def update_mailchimp_user
        ignored_keys = %w[sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip updated_at]
        return true if (changes.keys - ignored_keys).empty?

        UpdateUserJob.perform_later(self)
      end
    end
  end
end
Spree::User.prepend(Spree::SpreeMailchimpEcommerce::UserDecorator)
