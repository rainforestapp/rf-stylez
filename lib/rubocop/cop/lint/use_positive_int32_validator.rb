# frozen_string_literal: true
require 'byebug'

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   params do
      #     requires :id, type: Integer
      #   end
      #
      #   # good
      #   params do
      #     requires :id, type: Integer, positive_int32: true
      #   end
      class UsePositiveInt32Validator < Cop
        MSG = 'If this Integer maps to a postgres Integer column, validate with `positive_int32: true`'.freeze

        # if a params block, return all the nodes in it
        def_node_matcher :is_grape_params?, '(block (send nil? :params) (args) $...)'
        # check if the param is `requires` / `optional`
        def_node_search :find_params_hashes, <<~PATTERN
        (send nil? {:requires :optional}
          (sym _)
          $(hash ...) ...)
        PATTERN
        # check if hash contains `type: Integer`
        def_node_search :is_type_integer?, '(pair (sym :type) (const nil? :Integer))'
        # check if the hash contains the `positive_int32` validator
        def_node_search :validates_integer?, '(pair (sym :positive_int32) (true))'

        def on_block(node)
          params = is_grape_params?(node)
          return unless 
          hash = find_params_hashes(node)
          hash&.each do |param|
            if is_type_integer?(param) && !validates_integer?(param)
              add_offense(param)
            end
          end
        end
      end
    end
  end
end