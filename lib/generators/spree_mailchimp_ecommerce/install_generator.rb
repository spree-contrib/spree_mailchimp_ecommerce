require "highline"
module SpreeMailchimpEcommerce
  class InstallGenerator < Rails::Generators::Base
    def create_migrations
      run "bundle exec rake railties:install:migrations FROM=spree_mailchimp_ecommerce"
    end

    def run_migrations
      run_migrations = options[:auto_run_migrations] || ["", "y", "Y"].include?(ask("Would you like to run the migrations now? [Y/n]"))
      if run_migrations
        run "bundle exec rake db:migrate"
      else
        puts "Skipping rake db:migrate, don't forget to run it!"
      end
    end

    def inject_a_script
      inject_into_file "app/views/spree/shared/_head.html.erb", after: "<%= yield :head %>\n" do
        "<%= @mailchimp_snippet&.html_safe %>"
      end
    end
  end
end
