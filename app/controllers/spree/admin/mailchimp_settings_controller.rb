module Spree
  module Admin
    class MailchimpSettingsController < ResourceController
      def index
        path = model_class.first ? edit_admin_mailchimp_setting_path(model_class.first.id) : new_admin_mailchimp_setting_path
        redirect_to path
      end

      def create
        mailchimp_setting_attributes
        if @mailchimp_setting.save
          begin
            ::SpreeMailchimpEcommerce::CreateStoreJob.perform_now(@mailchimp_setting)
            ::SpreeMailchimpEcommerce::UploadStoreContentJob.perform_later
            @mailchimp_setting.update(mailchimp_account_name: @mailchimp_setting.accout_name)
            redirect_to edit_admin_mailchimp_setting_path(model_class.first.id)
          rescue Gibbon::MailChimpError => e
            flash.now[:error] = e.detail
            render :new
          end
        else
          flash[:error] = @mailchimp_setting.errors.full_messages.to_sentence
          render :new
        end
      end

      def update
        @mailchimp_setting = MailchimpSetting.find(params[:id])
        ActiveRecord::Base.transaction do
          @mailchimp_setting.update(permitted_params)
          ::SpreeMailchimpEcommerce::UpdateStoreJob.perform_later(@mailchimp_setting)
        end
        redirect_to edit_admin_mailchimp_setting_path
      end

      def destroy
        @mailchimp_setting = MailchimpSetting.find(params[:id])
        ActiveRecord::Base.transaction do
          ::SpreeMailchimpEcommerce::DeleteStoreJob.perform_now
          @mailchimp_setting.destroy
        end
        redirect_to new_admin_mailchimp_setting_path
      end

      private

      def model_class
        @model_class ||= ::MailchimpSetting
      end

      def permitted_params
        params.require(:mailchimp_setting).permit(:mailchimp_api_key, :mailchimp_list_id, :mailchimp_store_name, :mailchimp_store_email)
      end

      def mailchimp_setting_attributes
        @mailchimp_setting = MailchimpSetting.new(permitted_params)
        @mailchimp_setting.mailchimp_store_id = @mailchimp_setting.create_store_id
        @mailchimp_setting.cart_url = "#{::Rails.application.routes.url_helpers.spree_url}cart"
      end
    end
  end
end
