require 'spec_helper'

feature 'Complete Order Spec', :js do
  before { SpreeMailchimpEcommerce.configure }

  let!(:product)         { create(:product, name: 'spree_product') }
  let!(:variant)         { create(:variant, product: product) }
  let!(:state)           { create(:state, id: 2, name: 'New York', abbr: 'NY', country: country_us) }
  let!(:shipping_method) { create(:shipping_method) }
  let!(:credit_card)     { create(:credit_card, year: '2020') }
  let!(:country_us)      { create(:country, :country_us) }
  let(:order_number)     { Spree::Order.last.number }

  before do
    variant.stock_items.first.update(count_on_hand: 10)
    Timecop.freeze(Time.local(2019, 5, 21))
  end

  after { Timecop.return }

  scenario 'Deletes cart and creates Mailchimp Order' do
    add_product_to_cart
    expect(current_path).to eq('/checkout/registration')

    sign_up
    expect(current_path).to eq('/checkout/address')

    fill_in_checkout_address
    expect(current_path).to eq('/checkout/delivery')
    
    click_on 'Save and Continue'
    expect(current_path).to eq('/checkout/payment')

    fill_in_credit_card_details
    expect(current_path).to eq('/checkout/confirm')
    
    click_on 'Place Order'
    expect(current_path).to eq("/orders/#{order_number}")
    expect(page).to have_content('Your order has been processed successfully')

    expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.exactly(:once)
    expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.exactly(:once)
  end
  
  def add_product_to_cart
    visit '/'
    click_on 'spree_product'
    click_on 'Add To Cart'
    click_on 'Checkout'
  end

  def sign_up
    fill_in 'spree_user_email', with: 'spree@example.com'
    fill_in 'spree_user_password', with: 'Spree123'
    fill_in 'spree_user_password_confirmation', with: 'Spree123'
    click_on 'Create'
  end

  def fill_in_checkout_address
    fill_in 'order_bill_address_attributes_firstname', with: 'John'
    fill_in 'order_bill_address_attributes_lastname', with: 'Doe'
    fill_in 'order_bill_address_attributes_address1', with: 'Broadway 1540'
    fill_in 'order_bill_address_attributes_city', with: 'New York'
    fill_in 'order_bill_address_attributes_zipcode', with: '10036'
    fill_in 'order_bill_address_attributes_phone', with: '123456789'
    within '#order_bill_address_attributes_country_id' do
      find("option[value='232']").click
    end
    within '#order_bill_address_attributes_state_id' do
      find("option[value='2']").click
    end
    click_on 'Save and Continue'
  end

  def fill_in_credit_card_details
    fill_in 'name_on_card_1', with: 'John Doe'
    fill_in 'card_number', with: '4111111111111111'
    fill_in 'card_code', with: '123'
    find('#card_expiry').send_keys 12
    find('#card_expiry').send_keys 20
    click_on 'Save and Continue'
  end
end
