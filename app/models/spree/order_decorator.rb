module Spree
  module SpreeMailchimpEcommerce
    module OrderDecorator
      def self.prepended(base)
        base.before_update :create_mailchimp_cart, if: proc { email_changed? }
        base.after_create :create_mailchimp_cart, if: proc { user.present? }
        base.state_machine.after_transition to: :complete, do: :after_create_jobs
      end

      def mailchimp_cart
        ::SpreeMailchimpEcommerce::Presenters::CartMailchimpPresenter.new(self).json
      end

      def mailchimp_order
        ::SpreeMailchimpEcommerce::Presenters::OrderMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_cart
        binding.pry
        ::SpreeMailchimpEcommerce::CreateOrderCartJob.perform_later(id)
      end

      def after_create_jobs
        create_mailchimp_order
        delete_mailchimp_cart
      end

      def delete_mailchimp_cart
        ::SpreeMailchimpEcommerce::DeleteCartJob.perform_later(id)
      end

      def create_mailchimp_order
        ::SpreeMailchimpEcommerce::CreateOrderJob.perform_later(id)
      end
    end
  end
end
Spree::Order.prepend(Spree::SpreeMailchimpEcommerce::OrderDecorator)
