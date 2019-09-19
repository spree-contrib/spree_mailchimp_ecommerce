# Spree Mailchimp E-Commerce
[![Build Status](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce.svg?branch=master)](https://travis-ci.org/spark-solutions/spree_mailchimp_ecommerce)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/maintainability)](https://codeclimate.com/github/spark-solutions/spree_mailchimp_ecommerce/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/test_coverage)](https://codeclimate.com/github/spark-solutions/spree_mailchimp_ecommerce/test_coverage)

Spree Mailchimp E-Commerce is a [Spree Commerce](https://spreecommerce.org/) extension leveraging the latest [Mailchimp E-commerce API 3.0](https://mailchimp.com/developer/guides/getting-started-with-ecommerce/) to help you engage your customer base in a meaningful way through email marketing and track the resulting revenue and other key metrics. 

By doing some growth hacking, monitoring results and optimizing [Mailchimp E-Commerce](https://mailchimp.com/ecommerce-solutions/) settings you might be able to significantly increase all the key E-Commerce metrics such as number of visits per user and re-purchase rate (loyalty), conversion rate, number of items per order, average order value, and as a result your sales results and lifetime customer value.
 
This extension lets you connect your Spree Commerce store with your Mailchimp account in order to:
* sync your store data to enable E-commerce oriented email marketing,
  * sync customer and product data for automated or manually curated emails,
  * sync promotion codes to auto-populate Postcards or Campaigns,
* automate personalized emails to up-sell and cross-sell:
  * set up **abandoned cart emails** to recapture lost sales,  
  * add **product recommendations** to your transactional emails,
  * create other **targeted automations**, such as a welcome email series for new customers spread over a few days or weeks,
* boost your sales with regular curated newsletters or email campaigns:
  * acquire new subscriber emails through a **pop-up form** triggered according to your preferences,
  * **segment your subscribers** based on their purchase activity or predicted audience demographics for tailored email campaigns,
  * drag and drop **product recommendation** blocks or **promo code** blocks into your email campaigns,
* print and mail actual [Postcards](https://mailchimp.com/features/postcards/) (with promo codes) to engage your customers off-line,
* enjoy **tracking revenue** gained this way in your Mailchimp dashboard.

## Before You Start
* Your Spree version has to be at least 3.3. The extension may not work to its full extent for older Spree versions but you may [request](https://spreecommerce.org/contact/) its customizations.
* We recommend you use this extension on a staging environment first and test it there before installing it on production. 
* After your Spree Commerce sync is complete, you will have access to Mailchimp’s E-Commerce features. The sync may take from less than an hour, up to around 12 hours, depending on your site’s database size.
* The extension syncs the customer's first name, last name, email address, and orders.
* Spree customers who haven't signed up for marketing emails will appear as non-subscribed contacts in Mailchimp. They can receive transactional emails and be targeted with ad campaigns, but cannot be exported.

## Configuring the extension
To start using the extension, follow these steps:
- Follow all the [installation](https://github.com/spark-solutions/spree_mailchimp_ecommerce#installation) steps listed below in this readme file. This is a task for a Spree developer.
- After finishing all of the required steps, login to your Mailchimp account.
- Log in to your Spree admin account.
- In the Spree admin dashboard menu click on *CONFIGURATIONS > Mailchimp settings*.
- Enter your Mailchimp account information into the three fields in the Spree admin dashboard:
  - MAILCHIMP_API_KEY - enter your Mailchimp API Key which you can find in your Mailchimp account in *Extras > API Keys* menu. Generate your API Key there and and copy & paste it into this field.
  - MAILCHIMP_LIST_ID - enter your Audience ID which can be found on the *Audience* settings page.
  - MAILCHIMP_STORE_NAME - enter your store or brand name (useful when connecting multiple stores to a single Mailchimp account).
- Click on the **Create** button underneath the form. The button will indicate the sync status transitioning between values: 
  - Inactive,
  - Created, 
  - Syncing, 
  - Ready.
- Go to your Mailchimp dashboard to verify that the sync succeeded by hovering over on your name (top right corner) and clicking the *Connected sites* section. 

**Please note that the Syncing process may take up to 12 hours, depending on your Spree store database size.**

## Next steps

Set up Spree Mailchimp E-Commerce, give it some time and observe the results. Tweak and experiment with the settings to maximize the business results in time periods allowing for enough traffic and order volume to observe significant results of your adjustments. Ideally don't adjust too many factors at once to be able to isolate and understand the impact of a particular adjustment. This extension and Mailchimp E-Commerce platform is a proven solution for boosting business results.

More reading and use scenarios:
* [Mailchimp E-Commerce solutions overview, guides and case studies](https://mailchimp.com/ecommerce-solutions/)
* [Sell More Stuff with Mailchimp](https://mailchimp.com/help/sell-more-stuff-with-mailchimp/)
* [Mailchimp E-Commerce API 3.0 documentation](https://mailchimp.com/developer/guides/getting-started-with-ecommerce/)

## Deactivating Spree Mailchimp E-Commerce
If you find yourself in a situation which requires you to deactivate Mailchimp on Spree Commerce, be it because of troubleshooting or a change of heart, all you need to do is go to Spree *CONFIGURATIONS > Mailchimp settings* and click the “Remove Store” button. After doing so, the extension will disconnect which you can verify in your *Mailchimp Account > Connected Sites*. Then you can also remove the gemfile from your Spree code base.
 
## Troubleshooting
**My store won't sync with Mailchimp.**
If you're experiencing issues with the data sync, and have already tried to remove and reinstall the extension, there are a few other possible causes. Request [tech support](https://spreecommerce.org/contact/) to find out more.
 
**Your Spree setup doesn't meet the minimum requirements.**
This extension supports only Spree versions above 3.3. If your Spree version is older you may [request](https://spreecommerce.org/contact/) customization of your Spree platfrom. We highly recommend using the newest Spree and extension versions for the best results.
 
**You're experiencing conflicts with other extensions/gems.**
You may need to turn off all other extensions/gems except for the Spree Mailchimp E-Commerce extension, in order to find, if the extension itself is syncing correctly.
 
**My E-Commerce automation isn't sending:**
Your store probably hasn't finished syncing. To see if your store has completed its sync, check its status on your Mailchimp *Connected Sites* page.
 
**I'm sending duplicate transactional emails.**
Spree by default sends out transactional emails internally. In order to properly set up transactional emails, you need to decide if you want Spree or Mailchimp to send them out. If you do not wish to send emails through Spree, you will have to reconfigure your Spree application and turn the mailers off. You need a developer to do that for you.
 
**I see duplicate store connections.**
Have you recently removed and reinstalled Spree Mailchimp E-Commerce extension in order to resolve an issue with your connection? If you see a duplicate connection afterward, you may have deleted the extension without deactivating it, first. Repeat the process by disconnecting first and make sure not to skip any steps.

**Pop-up image is not properly showing up.**
In order for the Pop-up image to appear correctly, remember to Clear the Cache in *Spree Admin Panel > General Settings*, after updating the image in the Mailchimp dashboard. If that does not resolve the issue, please contact [tech support](https://spreecommerce.org/contact/).
 
**I need to talk to support.**
If you've tried our troubleshooting suggestions, but still have trouble with your sync, contact [Mailchimp Support](https://mailchimp.com/contact/) or [Spree Commerce](https://spreecommerce.org/contact/) support. It's helpful to include your Spree Commerce version, along with screenshots of your Mailchimp settings and Spree Mailchimp E-Commerce settings.
 
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

5. Setup you mailchimp credentials on `http://yoursite.test/admin/mailchimp_settings` and than click 'Setup your store' button

## User first and last name

By default, Spree doesn't provide `firstname` and `lastname` methods for the User model. However, MailChimp requires this fields. `SpreeMailchimpEcommerce` define these methods in presenter as

```ruby
  def firstname
    user.try(:firstname) || user&.bill_address&.firstname || "unknown firstname"
  end

  def lastname
    user.try(:lastname) || user&.bill_address&.lastname || "unknown lastname"
  end
```

Feel free to define `firstname` and `lastname` in your `User` model decorator.

Also, based on a Spree and Rails version, you can have different method to retrieve image url. 
By default it defined as 

```ruby
  def mailchimp_image_url
    images.first&.attachment&.url
  end
``` 

You can redifine it in your `Product` model decorator

## License

Spree Mailchimp E-Commerce is copyright © 2018-2019
[Spark Solutions Sp. z o.o.][spark]. It is free software,
and may be redistributed under the terms specified in the
[LICENCE](LICENSE) file.

[LICENSE]: https://github.com/spree-contrib/spree_analytics_trackers/blob/master/LICENSE

## About Spark Solutions
[![Spark Solutions](http://sparksolutions.co/wp-content/uploads/2015/01/logo-ss-tr-221x100.png)][spark]

Spree Mailchimp E-Commerce is maintained by [Spark Solutions Sp. z o.o.](http://sparksolutions.co?utm_source=github)

We are passionate about open source software.
We are also [available for hire][spark].

[spark]:http://sparksolutions.co?utm_source=github
