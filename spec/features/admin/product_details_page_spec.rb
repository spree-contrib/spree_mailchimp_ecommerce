require 'spec_helper'

feature 'Product Details Page', js: true do
  SpreeMailchimpEcommerce.configure

  let!(:product) { create(:product, name: 'spree_product') }
  let!(:variant) { create(:variant, product: product) }
  let!(:image) { create(:image, viewable_id: variant.id) }
  stub_authorization!

  scenario 'Updates product image' do
    visit '/admin/products/spree_product/images'

    find_all('span.icon-edit')[0].click
    click_on 'Update'

    expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(product.id)
  end

  scenario 'Uploads new image' do
    visit '/admin/products/spree_product/images'

    click_on 'New Image'
    click_on 'Create'

    expect(SpreeMailchimpEcommerce::UpdateProductJob).to have_been_enqueued.with(product.id)
  end
end