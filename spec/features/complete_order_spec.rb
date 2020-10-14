require "spec_helper"

feature "Complete Order Spec", :js do
  let!(:product)         { create(:product, name: "spree_product") }
  let!(:variant)         { create(:variant, product: product) }
  let!(:state)           { create(:state, id: 2, name: "New York", abbr: "NY", country: country_us) }
  let!(:shipping_method) { create(:shipping_method) }
  let!(:credit_card)     { create(:credit_card, year: Time.zone.now.year + 1) }
  let!(:country_us)      { create(:country, :country_us) }
  let(:order_number)     { Spree::Order.last.number }

  before do
    variant.stock_items.first.update(count_on_hand: 10)
    allow(SpreeMailchimpEcommerce).to receive(:configuration).and_return(SpreeMailchimpEcommerce::Configuration.new)
  end

  after { Timecop.return }

  scenario "Deletes cart and creates Mailchimp Order" do
    add_product_to_cart
    expect(current_path).to eq("/checkout/registration")

    sign_up
    expect(current_path).to eq("/checkout/address")

    fill_in_checkout_address
    expect(current_path).to eq("/checkout/delivery")

    click_on "Save and Continue"
    expect(current_path).to eq("/checkout/payment")

    fill_in_credit_card_details
    expect(current_path).to eq("/checkout/confirm")

    click_on "Place Order"
    if Spree.version.to_f >= 4.0 || Spree.version.to_f == 3.7
      expect(current_path).to eq("/orders/#{order_number}")
    elsif Spree.version.to_f < 4.0
      expect(current_path).to eq('/checkout/update/confirm')
    end

    if Spree.version.to_f <= 4.0
      expect(page).to have_content('Your order has been processed successfully')
    else
      expect(page).to have_content('Order placed successfully')
    end

    expect(SpreeMailchimpEcommerce::DeleteCartJob).to have_been_enqueued.exactly(:once)
    expect(SpreeMailchimpEcommerce::CreateOrderJob).to have_been_enqueued.exactly(:once)
  end
end
