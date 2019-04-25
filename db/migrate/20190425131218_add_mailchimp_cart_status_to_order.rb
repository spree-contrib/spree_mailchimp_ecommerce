class AddMailchimpCartStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_orders, :mailchimp_cart_created, :boolean
  end
end
