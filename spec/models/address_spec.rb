require "spec_helper"

describe Spree::Address, type: :model do
  describe 'after update' do
    context 'when address is user bill address' do
      shared_examples 'SpreeMailchimpEcommerce::UpdateUserJob enqueued' do
        it 'enqueues SpreeMailchimpEcommerce::UpdateUserJob' do
          expect(::SpreeMailchimpEcommerce::UpdateUserJob).to have_been_enqueued.with(user.reload.mailchimp_user)
        end
      end

      let!(:address) { create(:address) }
      let!(:user) { create(:user, bill_address: address) }

      before { address.update(user: user) }

      context 'when some of MAILCHIMP_ATTRIBUTES is updated' do
        context 'when firstname attribute is updated' do
          before { address.update(firstname: FFaker::Name.first_name) }

          it_behaves_like 'SpreeMailchimpEcommerce::UpdateUserJob enqueued'
        end

        context 'when lastname attribute is updated' do
          before { address.update(lastname: FFaker::Name.last_name) }

          it_behaves_like 'SpreeMailchimpEcommerce::UpdateUserJob enqueued'
        end
      end

      context 'when some other attribute is updated' do
        it 'does not enqueue SpreeMailchimpEcommerce::UpdateUserJob' do
          expect { address.update(phone: FFaker::PhoneNumber.short_phone_number) }.not_to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size)
        end
      end
    end

    context 'when address is not user bill address' do
      shared_examples 'SpreeMailchimpEcommerce::UpdateUserJob not enqueued' do
        it 'does not enqueue SpreeMailchimpEcommerce::UpdateUserJob' do
          expect(::SpreeMailchimpEcommerce::UpdateUserJob).not_to have_been_enqueued
        end
      end

      let!(:address) { create(:address, user: nil) }

      context 'when firstname attribute is updated' do
        before { address.update(firstname: FFaker::Name.first_name) }

        it_behaves_like 'SpreeMailchimpEcommerce::UpdateUserJob not enqueued'
      end

      context 'when lastname attribute is updated' do
        before { address.update(lastname: FFaker::Name.last_name) }

        it_behaves_like 'SpreeMailchimpEcommerce::UpdateUserJob not enqueued'
      end

      context 'when some other attribute is updated' do
        before { address.update(city: FFaker::Address.city) }

        it_behaves_like 'SpreeMailchimpEcommerce::UpdateUserJob not enqueued'
      end
    end
  end
end
