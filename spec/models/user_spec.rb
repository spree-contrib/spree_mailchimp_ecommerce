require "spec_helper"

describe Spree::User, type: :model do
  subject { build(:user_with_addresses) }

  describe 'after_create' do
    it "schedules mailchimp notification on user create" do
      subject.save!

      expect(SpreeMailchimpEcommerce::CreateUserJob).to have_been_enqueued.with(subject.mailchimp_user)
    end
  end

  describe 'after_update' do
    before { subject.save }

    context 'when some of MAILCHIMP_ATTRIBUTES is updated' do
      context 'when email is changed' do
        before { subject.update(email: FFaker::Internet.email) }

        it 'enqueues SpreeMailchimpEcommerce::UpdateUserJob' do
          binding.pry
          expect(SpreeMailchimpEcommerce::UpdateUserJob).to have_been_enqueued.with(subject.mailchimp_user)
        end
      end

      context 'when bill address is changed' do
        let(:new_address) { create(:address) }

        before { subject.update(bill_address: new_address) }

        it 'enqueues SpreeMailchimpEcommerce::UpdateUserJob' do
          expect(SpreeMailchimpEcommerce::UpdateUserJob).to have_been_enqueued.with(subject.mailchimp_user)
        end
      end
    end

    context 'when some other attribute is updated' do
      it 'does not enqueue SpreeMailchimpEcommerce::UpdateUserJob' do
        expect { subject.update(current_sign_in_ip: FFaker::Internet.ip_v4_address) }.not_to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size)
      end
    end
  end

  describe ".mailchimp_user" do
    it "returns valid schema" do
      expect(subject.mailchimp_user).to match_json_schema("user")
    end

    it "doesn't send unnecessary requests to db" do
      subject.save!

      expect { subject.mailchimp_user }.not_to exceed_query_limit(1)
    end
  end
end
