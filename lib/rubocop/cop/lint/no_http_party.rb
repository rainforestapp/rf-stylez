# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   HTTParty.get(..)
      #
      #   # good
      #   TimedRequest.get(...)
      class NoHTTParty < Cop
        MSG = "Prefer `TimedRequest` instead of raw `HTTParty` calls."

        def_node_matcher :is_HTTParty?, "(send (const nil? :HTTParty) ...)"

        def on_send(node)
          return unless is_HTTParty?(node)
          add_offense(node)
        end
      end
    end
  end
end
