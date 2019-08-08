require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
require "spree/testing_support/extension_rake"

RSpec::Core::RakeTask.new

task :default do
  if Dir["spec/dummy"].empty?
    Rake::Task[:test_app].invoke
    Rails::Generators.invoke("spree_mailchimp_ecommerce:install", ["--auto_run_migrations SOMETHING"])
    Dir.chdir("../../")
  end
  Rake::Task[:spec].invoke
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV["LIB_NAME"] = "spree_mailchimp_ecommerce"
  Rake::Task["extension:test_app"].invoke
end
