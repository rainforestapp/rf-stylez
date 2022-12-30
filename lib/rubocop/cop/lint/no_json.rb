# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   JSON.parse(...)
      #
      #   # good
      #   MultiJson.load(...)
      #
      class NoJSON < Cop
        MSG = "Use `MultiJson` instead of `JSON`."

        def_node_matcher :is_JSON?, "(const nil? :JSON)"

        def on_const(node)
          return unless is_JSON?(node)
          add_offense(node)
        end
      end
    end
  end
end
