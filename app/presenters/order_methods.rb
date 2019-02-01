module OrderMethods
  def json
    return unless user

    {
      id: order.number,
      customer: user,
      currency_code: order.currency,
      order_total: order.total.to_s,
      lines: lines
    }.as_json
  end

  private

  def lines
    order.line_items.map { |l| l.mailchimp_line_item }
  end
end
