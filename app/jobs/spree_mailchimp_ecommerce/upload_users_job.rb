# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UploadUsersJob < ApplicationJob
    def perform
      Spree::User.pluck(:id).each do |id|
        SpreeMailchimpEcommerce::UploadUserJob.perform_later(id)
      end
    end
  end
end
