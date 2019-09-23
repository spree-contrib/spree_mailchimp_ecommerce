class AddStateToSettings < SpreeExtension::Migration[4.2]
  def change
    add_column :mailchimp_setting, :state, :string, default: 'inactive'
  end
end
