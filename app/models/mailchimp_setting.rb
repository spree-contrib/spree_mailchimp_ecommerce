class MailchimpSetting < ActiveRecord::Base
  validates :mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, :cart_url, presence: true
  validate :validate_only_one_store, on: :create
  validate :mailchimp_list_id_cannot_be_updated, on: :update

  def validate_only_one_store
    errors.add(:base, "only one store allowed") unless MailchimpSetting.count.zero?
  end

  def create_store_id
    Digest::MD5.hexdigest(mailchimp_store_name + mailchimp_list_id).to_s
  end

  def accout_name
    ::SpreeMailchimpEcommerce::GetAccountNameJob.perform_now(self)
  end

  private

  def mailchimp_list_id_cannot_be_updated
    errors.add(:mailchimp_list_id, Spree.t(:can_not_be_updated)) if mailchimp_list_id_changed? && state == 'ready'
  end
end
