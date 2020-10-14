module HelperMethods
  def sign_up
    click_on 'Sign Up'
    fill_in "spree_user_email", with: "spree@example.com"
    fill_in "spree_user_password", with: "Spree123"
    fill_in "spree_user_password_confirmation", with: "Spree123"
    click_on "Sign Up"
  end

  def login
    fill_in "spree_user_email", with: "spree@example.com"
    fill_in "spree_user_password", with: "Spree123"
    click_on "Log in"
  end

  def login_as_admin
    visit "/admin"
    fill_in "spree_user_email", with: admin_user.email
    fill_in "spree_user_password", with: admin_user.password
    click_on "Log in"
  end

  def add_product_to_cart
    visit "/products"
    click_on "spree_product"
    click_on "Add To Cart"
    click_on "Checkout"
  end

  def fill_in_checkout_address
    fill_in "order_bill_address_attributes_firstname", with: "John"
    fill_in "order_bill_address_attributes_lastname", with: "Doe"
    fill_in "order_bill_address_attributes_address1", with: "Broadway 1540"
    fill_in "order_bill_address_attributes_city", with: "New York"
    fill_in "order_bill_address_attributes_zipcode", with: "10036"
    fill_in "order_bill_address_attributes_phone", with: "123456789"
    within "#order_bill_address_attributes_country_id" do
      find("option[value='232']").click
    end
    within "#order_bill_address_attributes_state_id" do
      find("option[value='2']").click
    end
    click_on "Save and Continue"
  end

  def fill_in_credit_card_details
    fill_in "card_number", with: "4111111111111111"
    fill_in "card_code", with: "123"
    find("#card_expiry").send_keys 12
    find("#card_expiry").send_keys 20
    find("#card_number").send_keys 1_111_111_111_111_111 until find("#card_number").value == "4111 1111 1111 1111"
    click_on "Save and Continue"
  end
end
