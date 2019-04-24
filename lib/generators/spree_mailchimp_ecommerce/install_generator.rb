require "highline"
module SpreeMailchimpEcommerce
  class InstallGenerator < Rails::Generators::Base
    def setup_variables
      cli = HighLine.new
      @api_key = cli.ask "Provide your mailchimp api key:"
      @store_id = cli.ask "\nProvide your store id:"
      @store_name = cli.ask "\nProvide your store name:"
      lists = Gibbon::Request.new(api_key: @api_key).
              lists.retrieve.body["lists"].map { |e| { id: e["id"], name: e["name"] } }
      puts "You should create a list on mailchimp site to continue" && return unless lists.any?
      lists.each_with_index { |e, i| puts "\n#{i}) #{e[:name]}" }
      answer = cli.ask "Which list do you want to use for integration? (type number)"
      @list_id = lists[answer.to_i][:id]
    end

    def create_initializer_file
      puts "All fields are required" && return if [@api_key, @store_id, @store_name, @list_id].map(&:empty?).any?
      # create_file "config/initializers/spree_mailchimp_ecommerce.rb", content
      puts "Settings saved. you can review and change your settings in you initializers file"
    end

    # def create_a_store
    #  Gibbon::Request.new(api_key: @api_key).
    #    ecommerce.stores.create(body: {
    #                              id: @store_id,
    #                              list_id: @list_id,
    #                              name: @store_name,
    #                              currency_code: "USD"
    #                            })
    # end

    def inject_a_script
      inject_into_file "app/views/spree/shared/_head.html.erb", after: "<%= yield :head %>\n" do
        Gibbon::Request.new(api_key: @api_key).
          ecommerce.stores(@store_id).retrieve.body["connected_site"]["site_script"]["fragment"] + "\n"
      end
    end

    private

    # rubocop:disable Metrics/LineLength
    def content
      "SpreeMailchimpEcommerce.configure do |config|\n  config.mailchimp_api_key = '#{@api_key}'\n  config.mailchimp_store_id = '#{@store_id}'\n  config.mailchimp_list_id = '#{@list_id}'\n  config.mailchimp_store_name = '#{@store_name}'\n  config.cart_url = '/cart'\n end"
    end
    # rubocop:enable Metrics/LineLength
  end
end
