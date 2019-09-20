# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class SubscriberMailchimpPresenter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def json
      {
        email_address: user.email || "",
        status: "subscribed"
      }.as_json
    end
  end
end
