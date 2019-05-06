Deface::Override.new(
  virtual_path: "spree/admin/shared/sub_menu/_configuration",
  name: "add_mailchimp_settings_configuration_menu",
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  text: '<%= configurations_sidebar_menu_item "Mailchimp settings", spree.admin_mailchimp_settings_path %>'
)
