# frozen_string_literal: true

require 'json'
require 'net/http'
require 'logger'
require 'rf/stylez/version'
require 'rubocop/cop/lint/no_env'
require 'rubocop/cop/lint/no_json'
require 'rubocop/cop/lint/no_http_party'
require 'rubocop/cop/lint/obscure'
require 'rubocop/cop/lint/no_grape_api'
require 'rubocop/cop/lint/use_positive_int32_validator'
require 'rubocop/cop/lint/no_untyped_raise'

module Rf
  module Stylez
    RUBYGEMS_URL = URI('https://rubygems.org/api/v1/gems/rf-stylez.json').freeze

    def self.check_for_updates
      remote_version = JSON.parse(Net::HTTP.get(RUBYGEMS_URL))['version']
      if remote_version == VERSION
        STDOUT.puts
        STDOUT.puts('You are running latest rf-stylez ')
        STDOUT.puts('(•_•) ( •_•)>⌐■-■ (⌐■_■)')
        STDOUT.puts
      else
        STDERR.puts
        STDERR.puts('Please update rf-stylez: gem update rf-stylez')
        STDERR.puts("#{remote_version} is newest and you are running #{VERSION}")
        STDERR.puts
      end
    rescue SocketError
      STDOUT.puts('Offline, cannot check for rf-stylez updates')
    end

    check_for_updates
  end
end
