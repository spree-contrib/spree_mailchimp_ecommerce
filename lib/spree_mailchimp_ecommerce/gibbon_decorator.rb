require 'faraday'
require 'gibbon'

module SpreeMailchimpEcommerce::GibbonDecorator
  private
  def handle_error(error)
    raise Faraday::TimeoutError if error.is_a?(Faraday::TimeoutError)

    super
  end
end

::Gibbon::APIRequest.prepend(SpreeMailchimpEcommerce::GibbonDecorator)
