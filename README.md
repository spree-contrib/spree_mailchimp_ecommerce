# SpreeMailchimpEcommerce
[![Build Status](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce.svg?branch=master)](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/maintainability)](https://codeclimate.com/github/spark-solutions/spree_mailchimp_ecommerce/maintainability)


## Installation
1. Add this line to your application's Gemfile:

```ruby
gem 'spree_mailchimp_ecommerce', github: 'spark-solutions/spree_mailchimp_ecommerce', branch: 'master'
```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy initializer
```bash
$ bundle exec rails g spree_mailchimp_ecommerce:install
```

4. Setup you keys in `config/initializers/spree_mailchimp_ecommerce.rb`

5. Create a store on Mailchimp side

```bash
$ rake spree_mailchimp_ecommerce:create_a_store
```

6. Restart your server

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
