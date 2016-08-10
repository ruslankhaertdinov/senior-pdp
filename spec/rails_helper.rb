ENV["RAILS_ENV"] ||= "test"

require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "shoulda/matchers"
require "rake"
require "elasticsearch/extensions/test/cluster/tasks"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end

Capybara::Webkit.configure do |config|
  config.block_unknown_urls

  # google map urls
  config.allow_url("*//maps.google.com/*")
  config.allow_url("*.gstatic.com/*")
end
