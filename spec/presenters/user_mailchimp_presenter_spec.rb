require 'spec_helper'

RSpec.describe SpreeMailchimpEcommerce::UserMailchimpPresenter, type: :presenter do
  let(:address) { create(:address) }
  let!(:user) { create(:user, bill_address: address) }

  describe '.json' do
    subject { described_class.new(user).json }

    let(:result) do
      {
        id: Digest::MD5.hexdigest(user.email.downcase),
        email_address: user.email,
        opt_in_status: false,
        first_name: address.firstname,
        last_name: address.lastname,
        address: {
          address1: address.address1,
          address2: address.address2,
          city: address.city,
          province: address.state&.name,
          province_code: address.state&.abbr,
          postal_code: address.zipcode,
          country: address.country&.name,
          country_code: address.country&.iso
        }
      }.as_json
    end

    it 'returns serialized object' do
      expect(subject).to eq(result)
    end
  end
end
