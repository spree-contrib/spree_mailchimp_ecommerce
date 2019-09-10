class MailchimpSetting < ActiveRecord::Base
  validates :mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name, presence: true

  def validate_only_one_store
    errors.add(:base, "only one store allowed") unless MailchimpSetting.count.zero?
  end

  def create_store_id
    Digest::MD5.hexdigest(mailchimp_store_name + mailchimp_list_id).to_s
  end
end
