module SpreeMailchimpEcommerce
  class DeleteStoreJob < ApplicationJob
    def perform
      gibbon_store.delete
    end
  end
end
