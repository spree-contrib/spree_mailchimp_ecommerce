# frozen_string_literal: true

module SpreeMailchimpEcommerce
  module Presenters
    class PromoRuleMailchimpPresenter
      attr_reader :promotion

      def initialize(promotion)
        @promotion = promotion
      end

      # mailchimp require amount, type and target and its specific values,
      # so for allow create promo_rule always, not only for proper promotion
      # we send "dummy" values accepted by mailchimp
      def json
        {
          id: Digest::MD5.hexdigest(promotion.id.to_s),
          title: promotion.name || "",
          description: promotion.description || "",
          starts_at: starts_at,
          ends_at: ends_at,
          amount: amount.to_f,
          type: type || "fixed",
          target: target || "total",
          created_at_foreign: promotion.created_at.strftime("%Y%m%dT%H%M%S"),
          updated_at_foreign: promotion.updated_at.strftime("%Y%m%dT%H%M%S")
        }.as_json
      end

      private

      def starts_at
        promotion.starts_at ? promotion.starts_at.strftime("%Y%m%dT%H%M%S") : ""
      end

      # with ends_at as "" the promo_code is unavaialbe but still exist
      def ends_at
        available? && promotion.expires_at ? promotion.expires_at.strftime("%Y%m%dT%H%M%S") : ""
      end

      def amount
        return unless %w[total per_item].include?(target)

        preferences = promotion.actions.first.calculator.preferences
        preferences[:amount] || (preferences[:percent] || preferences[:flat_percent]) / 100
      end

      def type
        return unless %w[total per_item].include?(target)

        case promotion.actions.first.calculator.type
        when "Spree::Calculator::FlatRate"
          "fixed"
        when "Spree::Calculator::PercentOnLineItem", "Spree::Calculator::FlatPercentItemTotal"
          "percentage"
        end
      end

      def target
        return unless available?

        case promotion.actions.first.type
        when "Spree::Promotion::Actions::FreeShipping"
          "shipping"
        when "Spree::Promotion::Actions::CreateAdjustment"
          "total"
        when "Spree::Promotion::Actions::CreateItemAdjustments"
          "per_item"
        end
      end

      def available?
        promotion.actions.count == 1
      end
    end
  end
end
