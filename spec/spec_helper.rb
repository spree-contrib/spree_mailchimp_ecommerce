ENV['RAILS_ENV'] = 'test'
require "simplecov"
require "simplecov-console"
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

require File.expand_path('dummy/config/environment.rb', __dir__)

require 'spree_dev_tools/rspec/spec_helper'
require 'webmock/rspec'
require 'json_matchers/rspec'
require 'timecop'

# Requires factories and other useful helpers defined in spree_core.
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/order_walkthrough'
require 'selenium-webdriver'

JsonMatchers.schema_root = 'spec/support/schemas'
WebMock.allow_net_connect!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include HelperMethods

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::TestingSupport::UrlHelpers

  # == Requests support
  #
  # Adds convenient methods to request Spree's controllers
  # spree_get :index
  config.include Spree::TestingSupport::ControllerRequests, type: :controller

  Rails.application.routes.default_url_options[:host] = "test.com"
  ::Spree::Core::Engine.routes.default_url_options[:host] = "test.com"
end
