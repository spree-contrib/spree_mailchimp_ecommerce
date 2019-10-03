class AddEmailToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :mailchimp_settings, :mailchimp_store_email, :string
  end
end
