require "spec_helper"

feature "Order notification", js: true do
  let(:admin_user) { create(:admin_user) }
  let!(:order) { create(:completed_order_with_totals) }
  let(:reimbursement) { create(:reimbursement) }
  let(:payment) { create(:payment, amount: order.total, order: order, state: "completed") }
  let(:refund_reason) { create(:default_refund_reason) }

  scenario "Cancel order" do
    order
    login_as_admin
    click_on order.number.to_s
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    click_on "Cancel"
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    expect(SpreeMailchimpEcommerce::UpsertOrderJob).to have_been_enqueued.exactly(:once)
  end

  scenario "Ship order" do
    payment
    login_as_admin
    click_on order.number.to_s
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    click_on "Ship"
    sleep(3)
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    expect(SpreeMailchimpEcommerce::UpsertOrderJob).to have_been_enqueued.exactly(:once)
  end

  scenario "Refund by reimbursement" do
    reimbursement
    refund_reason
    order = reimbursement.order
    login_as_admin
    click_on order.number.to_s
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    click_on "Customer Returns"
    expect(current_path).to eq("/admin/orders/#{order.number}/customer_returns")
    click_on reimbursement.customer_return.number.to_s
    expect(current_path).to eq("/admin/orders/#{order.number}/customer_returns/1/edit")
    Spree.version.to_f <= 4.0 ? find('.action-edit').click : find('a[data-action="edit"]').click
    click_on "Reimburse"
    expect(SpreeMailchimpEcommerce::UpsertOrderJob).to have_been_enqueued.exactly(:once)
  end

  scenario "Refund payment" do
    payment
    order = payment.order
    refund_reason
    login_as_admin
    click_on payment.order.number.to_s
    expect(current_path).to eq("/admin/orders/#{order.number}/edit")
    click_on "Payments"
    expect(current_path).to eq("/admin/orders/#{order.number}/payments")
    Spree.version.to_f <= 4.0 ? find('.action-refund').click : find('a[data-original-title="Refund"]').click
    expect(current_path).to eq("/admin/orders/#{order.number}/payments/#{payment.number}/refunds/new")
    if Spree.version.to_f <= 4.0
      select refund_reason.name.to_s, from: 'refund_refund_reason_id'
    else
      first('.select2-container', minimum: 1).click
      find('div.select2-result-label[role="option"]', text: refund_reason.name.to_s, visible: false).click
    end
    click_on "Refund"
    expect(SpreeMailchimpEcommerce::UpsertOrderJob).to have_been_enqueued.exactly(:once)
  end
end
