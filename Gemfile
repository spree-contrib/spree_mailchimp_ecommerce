source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'
gem 'rspec-sqlimit', git: 'https://github.com/nepalez/rspec-sqlimit', ref: '0c62feb61710c93f20f086a427a7a14784e5ca0d'

gemspec
