module Spree
  module SpreeMailchimpEcommerce
    module OrderDecorator
      def self.prepended(base)
        base.after_update :create_mailchimp_cart, if: proc { changes["email"] }
        base.after_create :create_mailchimp_cart, if: proc { user.present? }
        base.state_machine.after_transition to: :complete, do: :create_mailchimp_order
      end

      def mailchimp_cart
        ::SpreeMailchimpEcommerce::Presenters::CartMailchimpPresenter.new(self).json
      end

      def mailchimp_order
        ::SpreeMailchimpEcommerce::Presenters::OrderMailchimpPresenter.new(self).json
      end

      private

      def create_mailchimp_cart
        ::SpreeMailchimpEcommerce::CreateOrderCartJob.perform_later(self)
      end

      def create_mailchimp_order
        ::SpreeMailchimpEcommerce::CreateOrderJob.perform_later(self)
      end
    end
  end
end
Spree::Order.prepend(Spree::SpreeMailchimpEcommerce::OrderDecorator)
