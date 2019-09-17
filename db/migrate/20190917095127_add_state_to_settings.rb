class AddStateToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :mailchimp_setting, :state, :string, default: 'inactive'
  end
end
