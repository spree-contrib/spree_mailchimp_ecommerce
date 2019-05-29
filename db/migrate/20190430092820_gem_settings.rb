class GemSettings < ActiveRecord::Migration
  def change
    create_table :mailchimp_settings do |t|
      t.string :mailchimp_api_key
      t.string :mailchimp_store_id
      t.string :mailchimp_list_id
      t.string :mailchimp_store_name
      t.string :cart_url
    end
  end
end
