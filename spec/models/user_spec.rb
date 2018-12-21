require 'spec_helper'

describe Spree::User, type: :model do
  subject { Spree::User.new(email: 'test@test.test', password: '12345678') }

  describe 'mailchimp' do
    it 'schedules mailchimp notification on user create' do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateUserJob).to have_been_enqueued.with(subject)
    end
  end
end
