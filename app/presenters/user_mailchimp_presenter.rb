# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class UserMailchimpPresenter
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def json
        {
          id: Digest::MD5.hexdigest(user.id.to_s),
          email_address: user.email,
          opt_in_status: false,
          first_name: user&.firstname || "",
          last_name: user&.lastname || "",
          address: address
        }.as_json
      end

      private

      def firstname
        user&.firstname || user&.bill_address&.firstname || "unknown firstname"
      end

      def lastname
        user&.lastname || user&.bill_address&.lastname || "unknown lastname"
      end

      def address
        ad = user.bill_address
        return {} unless ad

        AddressMailchimpPresenter.new(ad).json
      end
    end
  end
end
