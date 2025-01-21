# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   raise 'foo'
      #
      #   # good
      #   raise ArgumentError, 'foo'
      #
      class NoUntypedRaise < Base
        MSG = "Do not raise untyped exceptions, specify the error type so it can be rescued specifically."

        def_node_matcher :is_untyped_raise?, "(send nil? {:raise :fail} (str ...) ...)"

        def on_send(node)
          return unless is_untyped_raise?(node)

          add_offense(node)
        end
      end
    end
  end
end
