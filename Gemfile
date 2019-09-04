source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "spree"

gem "bullet"
gem "deface"
gem "gibbon", "~> 3.2.0"
gem "highline"
gem "pry"
gem "rails-controller-testing"
gem "rspec-sqlimit"
gem "rubocop-rspec", require: false
gem "spree_auth_devise"

gemspec
