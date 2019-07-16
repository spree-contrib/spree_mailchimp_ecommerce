module Spree
  module SpreeMailchimpEcommerce
    module ProductDecorator
      def self.prepended(base)
        base.after_create :create_mailchimp_product
        base.after_update :update_mailchimp_product
        base.after_destroy :delete_mailchimp_product
      end

      def mailchimp_product
        ::SpreeMailchimpEcommerce::Presenters::ProductMailchimpPresenter.new(self).json
      end

      def mailchimp_image_url
        Gem.loaded_specs["rails"].version >= Gem::Version.new('5.0.0') ? active_storage_url : paperclip_url
      end

      private

      def paperclip_url
        images.first&.attachment&.url
      end

      def active_storage_url
        return '' unless images.any?
        Rails.application.routes.url_helpers.rails_blob_url(images.first&.attachment)
      end

      def create_mailchimp_product
        ::SpreeMailchimpEcommerce::CreateProductJob.perform_later(id)
      end

      def update_mailchimp_product
        ::SpreeMailchimpEcommerce::UpdateProductJob.perform_later(id)
      end

      def delete_mailchimp_product
        ::SpreeMailchimpEcommerce::DeleteProductJob.perform_later(id)
      end
    end
  end
end
Spree::Product.prepend(Spree::SpreeMailchimpEcommerce::ProductDecorator)
