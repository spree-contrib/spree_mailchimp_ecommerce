class AddStateToSettings < ActiveRecord::Migration[5.2]
  def change
    change_table :mailchimp_setting, :state, :string, default: 'inactive'
  end
end
