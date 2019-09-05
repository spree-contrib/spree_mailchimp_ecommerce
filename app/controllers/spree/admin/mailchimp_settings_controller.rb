module Spree
  module Admin
    class MailchimpSettingsController < ResourceController
      def index
        path = model_class.first ? edit_admin_mailchimp_setting_path(model_class.first.id) : new_admin_mailchimp_setting_path
        redirect_to path
      end

      def create
        @mailchimp_setting = MailchimpSetting.new(check_params)
        begin
          ::SpreeMailchimpEcommerce::CreateStoreJob.perform_now(@mailchimp_setting)
          if @mailchimp_setting.save
            redirect_to edit_admin_mailchimp_setting_path(model_class.first.id)
          else
            render :new
          end
        rescue Gibbon::MailChimpError => e

          #errors = []
          #e.body["errors"].each do |error|
            #errors << "for #{error["field"].blank? ? "all" : error["field"]}: #{error["message"]}"
          #end
          flash.now[:error] = e.body
          #errors.join
          render :new
        end
      end



      def destroy
        @mailchimp_setting = MailchimpSetting.find(params[:id])
        ::SpreeMailchimpEcommerce::DeleteStoreJob.perform_now(@mailchimp_setting)
        @mailchimp_setting.destroy
        redirect_to new_admin_mailchimp_setting_path
      end

      def setup_store
        ::SpreeMailchimpEcommerce::CreateStoreJob.perform_now
        redirect_to edit_admin_mailchimp_setting_path(model_class.last.id), notice: "Your store is going to be setup shortly."
      end

      def model_class
        @model_class ||= ::MailchimpSetting
      end

      def check_params
        params.require(:mailchimp_setting).permit(:mailchimp_api_key, :mailchimp_store_id, :mailchimp_list_id, :mailchimp_store_name)
      end
    end
  end
end
