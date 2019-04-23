source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "spree", ">= 3.3.0"

# Provides basic authentication functionality for testing parts of your engine
gem "rails-controller-testing"
gem "rubocop-rspec", require: false
gem "spree_auth_devise", github: "spree/spree_auth_devise", branch: "master"

gemspec
