# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class AddressMailchimpPresenter
      attr_reader :address

      def initialize(address)
        @address = address
      end

      def json
        {
          address1: address.address1 || "",
          address2: address.address2 || "",
          city: address.city || "",
          province: address.state&.name || "",
          province_code: address.state&.abbr || "",
          postal_code: address.zipcode || "",
          country: address.country&.name || "",
          country_code: address.country&.iso || ""
        }.as_json
      end
    end
  end
end
