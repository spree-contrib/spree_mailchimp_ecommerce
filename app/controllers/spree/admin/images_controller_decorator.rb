Spree::Admin::ImagesController.class_eval do
  after_action :update_mailchimp_product, only: [:create, :update]

  private

  def update_mailchimp_product
    ::SpreeMailchimpEcommerce::UpdateProductJob.perform_later(@product.id)
  end
end

