module SpreeMailchimpEcommerce
  module Spree
    module RefundDecorator
      def self.prepended(base)
        base.after_save :add_refund_notification
      end

      private

      def add_refund_notification
        payment.order.after_refund_jobs
      end
    end
  end
end
Spree::Refund.prepend(SpreeMailchimpEcommerce::Spree::RefundDecorator)
