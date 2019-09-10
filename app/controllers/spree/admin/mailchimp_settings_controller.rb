module Spree
  module Admin
    class MailchimpSettingsController < ResourceController
      def index
        path = model_class.first ? edit_admin_mailchimp_setting_path(model_class.first.id) : new_admin_mailchimp_setting_path
        redirect_to path
      end

      def create
        @mailchimp_setting = MailchimpSetting.new(check_params)
        @mailchimp_setting.mailchimp_store_id = @mailchimp_setting.create_store_id
        @mailchimp_setting.cart_url = "#{::Rails.application.routes.url_helpers.spree_url}cart"
        if @mailchimp_setting.valid?
          if model_class.first
            @mailchimp_setting.validate_only_one_store
            flash[:error] = @mailchimp_setting.errors.full_messages.to_sentence
            redirect_to edit_admin_mailchimp_setting_path(model_class.first.id)
          else
            begin
              ::SpreeMailchimpEcommerce::CreateStoreJob.perform_now(@mailchimp_setting)
              if @mailchimp_setting.save
                ::SpreeMailchimpEcommerce::UploadStoreContentJob.perform_later
                @mailchimp_setting.update(mailchimp_account_name: @mailchimp_setting.accout_name)
                redirect_to edit_admin_mailchimp_setting_path(model_class.first.id)
              else
                render :new
              end
            rescue Gibbon::MailChimpError => e
              flash.now[:error] = e.detail
              render :new
            end
          end
        else
          flash.now[:error] = @mailchimp_setting.errors.full_messages.to_sentence
          render :new
        end
      end

      def update
        if @mailchimp_setting.update(check_params)
          ::SpreeMailchimpEcommerce::UpdateStoreJob.perform_later(@mailchimp_setting)
          redirect_to edit_admin_mailchimp_setting_path(@mailchimp_setting)
        else
          flash[:alert] = @dish.errors.full_messages.to_sentence
          render :edit
        end
        @mailchimp_setting = MailchimpSetting.find(params[:id])
      end

      def destroy
        @mailchimp_setting = MailchimpSetting.find(params[:id])
        ::SpreeMailchimpEcommerce::DeleteStoreJob.perform_now(@mailchimp_setting)
        @mailchimp_setting.destroy
        redirect_to new_admin_mailchimp_setting_path
      end

      private

      def model_class
        @model_class ||= ::MailchimpSetting
      end

      def check_params
        params.require(:mailchimp_setting).permit(:mailchimp_api_key, :mailchimp_list_id, :mailchimp_store_name)
      end
    end
  end
end
