module OrderMethods
  def order_json
    return {} unless user

    {
      id: order.number,
      customer: user,
      currency_code: order.currency || order.store&.default_currency || ::Spree::Config[:currency],
      order_total: (order.total || 0).to_s,
      lines: lines
    }.as_json
  end

  private

  def lines
    order.line_items.map(&:mailchimp_line_item)
  end
end
