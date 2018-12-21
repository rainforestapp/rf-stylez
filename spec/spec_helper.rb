require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../lib/rubocop/cop/lint/no_env'
require_relative '../lib/rubocop/cop/lint/no_http_party'
require_relative '../lib/rubocop/cop/lint/obscure'
require_relative '../lib/rubocop/cop/lint/no_grape_api'
require_relative '../lib/rubocop/cop/lint/use_positive_int32_validator'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.order = :random
  config.warnings = true
  Kernel.srand config.seed
end