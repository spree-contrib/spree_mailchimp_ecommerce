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

    it 'does not allow to update mailchimp_list_id' do
      subject.update(mailchimp_list_id: FFaker::Internet.password)

      expect(subject.valid?).to be false
      expect(subject.errors.to_h[:mailchimp_list_id]).to eq Spree.t(:can_not_be_updated)
    end
  end
end

