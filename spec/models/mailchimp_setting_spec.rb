require "spec_helper"

describe MailchimpSetting, type: :model do
  subject { create(:mailchimp_setting) }

  describe "validations" do
    it 'allows to save mailchimp setting' do
      expect(subject.persisted?).to be true
    end

    it 'allows to destroy mailchimp setting' do
      subject.destroy

      expect(subject.destroyed?).to be true
    end

    context 'when mailchimp is synchronised' do
      before { subject.update(state: 'ready') }

      it 'does not allow to update mailchimp_list_id' do
        subject.update(mailchimp_list_id: FFaker::Internet.password)

        expect(subject.valid?).to be false
        expect(subject.errors.to_h[:mailchimp_list_id]).to eq Spree.t(:can_not_be_updated)
      end
    end

    context 'when mailchimp is not synchronised' do
      let(:new_list_id) { FFaker::Internet.password }

      it 'allows to update mailchimp_list_id' do
        subject.update(mailchimp_list_id: new_list_id)

        expect(subject.reload.mailchimp_list_id).to eq new_list_id
      end
    end
  end
end

