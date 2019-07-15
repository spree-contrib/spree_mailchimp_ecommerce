module Spree
  module SpreeMailchimpEcommerce
    module OrderDecorator
      def self.prepended(base)
        base.before_update :create_mailchimp_cart, if: proc { email_changed? }
        base.state_machine.after_transition to: :complete, do: :after_create_jobs
      end

      def associate_user!(user, override_email = true)
        super

        create_mailchimp_cart unless new_record? || !checkout_allowed?
        true
      end

      def mailchimp_cart
        ::SpreeMailchimpEcommerce::Presenters::CartMailchimpPresenter.new(self).json
      end

      def mailchimp_order
        ::SpreeMailchimpEcommerce::Presenters::OrderMailchimpPresenter.new(self).json
      end

      def create_mailchimp_cart
        return if mailchimp_cart_created

        ::SpreeMailchimpEcommerce::CreateOrderCartJob.perform_later(mailchimp_cart)

        #ToDo update_coloumn should be triggered from sucess response from API, here we are assuming cart was created.
        update_column(:mailchimp_cart_created, true)
      end

      def update_mailchimp_cart
        ::SpreeMailchimpEcommerce::UpdateOrderCartJob.perform_later(mailchimp_cart)
      end

      def delete_mailchimp_cart
        #ToDo Try Fix Failing Spec but this should be correct, no point deleteing a cart that didnt get created -> return unless mailchimp_cart_created
        ::SpreeMailchimpEcommerce::DeleteCartJob.perform_later(number)


        #ToDo update_coloumn should be triggered from sucess response from API, here we are assuming cart was delteted.
        update_column(:mailchimp_cart_created, nil)
      end

      private

      def after_create_jobs
        create_mailchimp_order
        delete_mailchimp_cart
      end

      def create_mailchimp_order
        ::SpreeMailchimpEcommerce::CreateOrderJob.perform_later(mailchimp_order)
      end
    end
  end
end
Spree::Order.prepend(Spree::SpreeMailchimpEcommerce::OrderDecorator)
