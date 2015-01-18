RSpec.configure do |config|
  config.color = true

  config.expect_with :rspec do |c|
    c.syntax = :should
  end

  config.mock_with :rspec do |c|
    c.syntax = :should
  end
end