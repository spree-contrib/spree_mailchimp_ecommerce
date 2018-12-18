module Spree
module SpreeMailchimpEcommerce
  module OrderDecorator
    def self.prepended(base)
      base.state_machine.after_transition to: :delivery, do: :create_mailchimp_cart
      base.state_machine.after_transition to: :complete, do: :create_mailchimp_order
    end

    def mailchimp_cart
      SpreeMailchimpEcommerce::Presenters::CartMailchimpPresenter.new(self).json
    end

    def mailchimp_order
      SpreeMailchimpEcommerce::Presenters::OrderMailchimpPresenter.new(self).json
    end

    private

    def create_mailchimp_cart
      Mailchimp::CreateOrderCartJob.perform_later(self)
    end

    def create_mailchimp_order
      Mailchimp::CreateOrderJob.perform_later(self)
    end
  end
end
end
Spree::Order.prepend(Spree::SpreeMailchimpEcommerce::OrderDecorator)
