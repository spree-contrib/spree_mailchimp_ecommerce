$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'spree_mailchimp_ecommerce/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'spree_mailchimp_ecommerce'
  s.version     = SpreeMailchimpEcommerce::VERSION
  s.authors     = ['Spark solutions']
  s.email       = ['hi@sparksolutions.co']
  s.homepage    = 'https://spreecommerce.org/integrations/mailchimp-and-spree-integration/'
  s.summary     = 'Spree Mailchimp E-Commerce'
  s.description = 'Spree Mailchimp E-Commerce is a Spree Commerce extension leveraging the latest Mailchimp E-commerce API 3.0 to help you engage your customer base in a meaningful way through email marketing and track the resulting revenue and other key metrics.'
  s.license     = 'MIT'

  s.files        = `git ls-files`.split('\n')

  s.require_path = 'lib'

  spree_version = '>= 3.3.0', '< 5.0'

  s.add_dependency 'gibbon', '~> 3.2'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_extension'
  s.add_dependency 'deface'

  s.add_development_dependency 'factory_bot', '<=4.11'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'json_matchers'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-console'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'chromedriver-helper'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-sqlimit'
end
