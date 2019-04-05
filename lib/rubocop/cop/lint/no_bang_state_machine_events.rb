# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad - will define `!`-ended method that won't raise
      #   state_machine :state do
      #     event :started! do
      #       ...
      #     end
      #   end
      #
      #   # good
      #   state_machine :state do
      #     event :started do
      #       ...
      #     end
      #   end
      class NoBangStateMachineEvents < Cop
        MSG = 'Event names ending with a `!` define `!`-ended methods that do not raise'

        def_node_matcher :is_state_machine_event?, '(send nil? :event (sym $_))'
        def_node_matcher :is_state_machine?, '(block (send nil? :state_machine ...) ...)'

        def on_send(node)
          return unless (event_name = is_state_machine_event?(node))
          return unless is_state_machine?(node.parent.parent)
          return unless event_name.match?(/\w+!$/)

          add_offense(node)
        end
      end
    end
  end
end
