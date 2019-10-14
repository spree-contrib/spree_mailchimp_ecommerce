require "spec_helper"

feature "Mailchimp settings", :js do
  let!(:admin_user) { create :admin_user }
  before do
    login_as_admin
  end

  scenario "Creating store" do
    visit("admin/mailchimp_settings")

    expect(current_path).to eq("/admin/mailchimp_settings/new")
    fill_in("mailchimp_setting_mailchimp_api_key", with: "ece39afe8c53959b9412f61939d1bXXX-us4")
    fill_in("mailchimp_setting_mailchimp_list_id", with: "list_id")
    fill_in("mailchimp_setting_mailchimp_store_name", with: "store_name")
    fill_in("mailchimp_setting_mailchimp_store_email", with: "store@email.com")

    expect { click_on("Create") }.to change { MailchimpSetting.count }.from(0).to(1)
  end
end

