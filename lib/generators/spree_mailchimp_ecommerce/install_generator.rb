require "highline"
module SpreeMailchimpEcommerce
  class InstallGenerator < Rails::Generators::Base
    # def setup_variables
    #  cli = HighLine.new
    #  @api_key = cli.ask "Provide your mailchimp api key:"
    #  @store_id = cli.ask "\nProvide your store id:"
    #  @store_name = cli.ask "\nProvide your store name:"
    #  lists = ::Gibbon::Request.new(api_key: @api_key).
    #          lists.retrieve.body["lists"].map { |e| { id: e["id"], name: e["name"] } }
    #  puts "You should create a list on mailchimp site to continue" && return unless lists.any?
    #  lists.each_with_index { |e, i| puts "\n#{i}) #{e[:name]}" }
    #  answer = cli.ask "Which list do you want to use for integration? (type number)"
    #  @list_id = lists[answer.to_i][:id]
    # end

    def create_initializer_file
      #  puts "All fields are required" && return if [@api_key, @store_id, @store_name, @list_id].map(&:empty?).any?
      create_file "config/initializers/spree_mailchimp_ecommerce.rb", content
      #  puts "Settings saved. You can review and change your settings in you initializers file"
    end

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

    # def create_a_store
    #  ::Gibbon::Request.new(api_key: @api_key).
    #    ecommerce.stores.create(body: {
    #                              id: @store_id,
    #                              list_id: @list_id,
    #                              name: @store_name,
    #                              currency_code: "USD"
    #                            })
    # end

    def inject_a_script
      inject_into_file "app/views/spree/shared/_head.html.erb", after: "<%= yield :head %>\n" do
        "<%= @mailchimp_snippet&.html_safe %>"
      end
    end

    private

    def content
      "SpreeMailchimpEcommerce.configure"
    end
  end
end
