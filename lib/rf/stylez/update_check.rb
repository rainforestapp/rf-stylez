# frozen_string_literal: true

require 'json'
require 'net/http'
require 'logger'

module Rf
  module Stylez
    module UpdateCheck
      RUBYGEMS_URL = URI('https://rubygems.org/api/v1/gems/rf-stylez.json').freeze

      def self.check
        logger = Logger.new(STDOUT)
        current_version = Gem::Version.new(VERSION)

        remote_version = Gem::Version.new(
          JSON.parse(Net::HTTP.get(RUBYGEMS_URL))['version']
        )
        if current_version >= remote_version
          logger.info('You are running latest rf-stylez ')
          logger.info('(•_•) ( •_•)>⌐■-■ (⌐■_■)')
        else
          logger.warn('RF Stylez is out of date!')
          logger.warn("Newest version is: #{remote_version}")
          logger.warn("You are running: #{current_version}")
          logger.warn('Please update: `gem update rf-stylez`')
        end
      rescue SocketError
        logger.info('Offline, cannot check for rf-stylez updates')
      end
    end
  end
end
