# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UploadProductsJob < ApplicationJob
    def perform
      rake("RAILS_ENV=#{Rails.env} spree_mailchimp_ecommerce:upload_products")
    end
  end
end
