# frozen_string_literal: true

require "rubocop"
require "rubocop/rspec/support"
require_relative "../lib/rubocop/cop/lint/no_json"
require_relative "../lib/rubocop/cop/lint/no_http_party"
require_relative "../lib/rubocop/cop/lint/obscure"
require_relative "../lib/rubocop/cop/lint/no_grape_api"
require_relative "../lib/rubocop/cop/lint/use_positive_int32_validator"
require_relative "../lib/rubocop/cop/lint/no_bang_state_machine_events"
require_relative "../lib/rubocop/cop/lint/no_untyped_raise"
require_relative "../lib/rubocop/cop/lint/no_vcr_recording"

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.order = :random
  config.warnings = true
  Kernel.srand config.seed
end
