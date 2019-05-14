module Spree
  module Admin
    class MailchimpSettingsController < ResourceController
      def index
        path = model_class.last ? edit_admin_mailchimp_setting_path(model_class.last.id) : new_admin_mailchimp_setting_path
        redirect_to path
      end

      def setup_store
        ::SpreeMailchimpEcommerce::CreateStoreJob.perform_later
        redirect_to edit_admin_mailchimp_setting_path(model_class.last.id), notice: 'Your store is going to be setup shortly.'
      end

      def model_class
        @model_class ||= ::MailchimpSetting
      end
    end
  end
end
