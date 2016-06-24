if ENV["COVERAGE"]
  # Run Coverage report
  require 'simplecov'
  SimpleCov.start do
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Views', 'app/views'
    add_group 'Libraries', 'lib'
  end
end

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'rspec/rails'
require 'database_cleaner'
require 'ffaker'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'

Dir[File.join(File.dirname(__FILE__), "factories/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.extend Spree::TestingSupport::AuthorizationHelpers::Controller, type: :controller
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  # allow you to focus on just one test by adding 'focus: true' to the
  # describe, context or it block.
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.order = "random"

  # config.filter_gems_from_backtrace %w[rails activerecord actionpack activesupport zeus]

  config.before(:each) do
    if RSpec.current_example.metadata[:js]
      DatabaseCleaner.strategy = :truncation, { except: ['spree_countries', 'spree_zones', 'spree_zone_members', 'spree_states', 'spree_roles'] }
    else
      DatabaseCleaner.strategy = :transaction
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
