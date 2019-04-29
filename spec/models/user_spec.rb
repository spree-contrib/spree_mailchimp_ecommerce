require "spec_helper"

describe Spree::User, type: :model do
  subject { build(:user_with_addresses) }

  describe "mailchimp" do
    it "schedules mailchimp notification on user create" do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateUserJob).to have_been_enqueued.with(subject.mailchimp_user)
    end
  end

  describe ".mailchimp_user" do
    it "returns valid schema" do
      expect(subject.mailchimp_user).to match_json_schema("user")
    end
  end
end
