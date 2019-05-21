require "spree/testing_support/factories"

if FactoryBot.factories.registered?(:country)
  FactoryBot.modify do
    factory :country do
      trait :country_us do
        id { 232 }
        iso_name { 'UNITED STATES' }
        iso 'US'
        iso3 { 'USA' }
        name { 'United States' }
        numcode { 840 }
        states_required { true }
      end
    end
  end
end
