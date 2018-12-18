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
          opt_in_status: true,
          first_name: user.firstname || '',
          last_name: user.lastname || '',
          address: address
        }.as_json
      end

      private

      def address
        ad = user.addresses.first
        return {} unless ad

        {
          address1: ad.address1 || '',
          address2: ad.address2 || '',
          city: ad.city,
          province: ad.state&.name,
          province_code: ad.state&.abbr,
          postal_code: ad.zipcode,
          country: ad.country&.name,
          country_code: ad.country&.iso
        }
      end
    end
end
end
