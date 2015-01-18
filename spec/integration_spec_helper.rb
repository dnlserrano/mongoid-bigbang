require 'database_cleaner'
require 'spec_helper'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.clean_with :truncation, { :reset_ids => true }
  end

  config.after(:each) do
    DatabaseCleaner.clean_with :truncation, { :reset_ids => true }
  end
end