$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spree_mailchimp_ecommerce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_mailchimp_ecommerce"
  s.version     = SpreeMailchimpEcommerce::VERSION
  s.authors     = ["Oleg Leontev"]
  s.email       = ["oleg.leontiev@sparksolutions.co"]
  s.homepage    = "http://spreecommerce.org"
  s.summary     = "Summary of SpreeMailchimpEcommerce."
  s.description = "Description of SpreeMailchimpEcommerce."
  s.license     = "MIT"

  s.files        = `git ls-files`.split("\n")

  s.require_path = 'lib'

  spree_version = '>= 3.0.0', '< 4.0'

  s.add_dependency "gibbon"
  s.add_dependency 'pg'
  s.add_dependency "rails"
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency "spree_extension"

  s.add_development_dependency "factory_bot", '<=4.11'
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "vcr"
  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'json_matchers'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-console'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'chromedriver-helper'
  s.add_development_dependency 'timecop'
end
