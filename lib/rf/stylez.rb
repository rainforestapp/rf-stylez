require 'rf/stylez/version'
require 'rubocop/cop/lint/no_env'
require 'rubocop/cop/lint/no_json'
require 'rubocop/cop/lint/no_http_party'
require 'rubocop/cop/lint/obscure'
require 'rubocop/cop/lint/no_grape_api'
require 'rubocop/cop/lint/use_positive_int32_validator'

module Rf
  module Stylez
    def self.reek_config_path
      File.expand_path('../../ruby/reek.yml', __dir__)
    end
  end
end
