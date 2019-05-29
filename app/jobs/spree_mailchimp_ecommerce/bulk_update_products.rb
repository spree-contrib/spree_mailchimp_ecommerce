module SpreeMailchimpEcommerce
  class BulkUpdateProducts < ApplicationJob

    def perform(*args)
      Spree::Product.all.each do |p|
        i = i+1
        puts Spree::Product.all.size + '/' + i
        gibbon_store.products(product.mailchimp_product["id"]).update(body: SpreeMailchimpEcommerce::Presenters::ProductMailchimpPresenter.new(p).json)
      end
    end

  end
end