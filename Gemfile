source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'spree'

gem "deface"
gem "gibbon", "~> 3.2.0"
gem "highline"
gem "pry"
gem "rails-controller-testing"
gem "rubocop-rspec", require: false
gem "spree_auth_devise"
gem "bullet"
gem 'rspec-sqlimit'

gemspec
