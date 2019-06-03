# SpreeMailchimpEcommerce
[![Build Status](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce.svg?branch=master)](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/maintainability)](https://codeclimate.com/github/spark-solutions/spree_mailchimp_ecommerce/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/test_coverage)](https://codeclimate.com/github/spark-solutions/spree_mailchimp_ecommerce/test_coverage)

##THE GEM UNDER DEVELOPMENT. DO NOT USE IT ON PRODUCTION

## Installation
1. Add this line to your application's Gemfile:

```ruby
gem 'spree_mailchimp_ecommerce', github: 'spark-solutions/spree_mailchimp_ecommerce', branch: 'master'
```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Install extension
  ```bash
  $ bundle exec rails g spree_mailchimp_ecommerce:install
  ```

4. Restart your server


5. Deployment


6. Setup you mailchimp credentials on `admin/mailchimp_settings` and than click 'Setup your store' button

## User first and last name

By default, Spree doesn't provide `firstname` and `lastname` methods for the User model. However, MailChimp requires these fields. `SpreeMailchimpEcommerce` define these methods in presenter as

```ruby
  def firstname
    user.try(:firstname) || user&.bill_address&.firstname || "unknown firstname"
  end

  def lastname
    user.try(:lastname) || user&.bill_address&.lastname || "unknown lastname"
  end
```

Feel free to define `firstname` and `lastname` in your `User` model decorator.

## Connecting the store to mailchimp (post-installation)

1. TBD

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
