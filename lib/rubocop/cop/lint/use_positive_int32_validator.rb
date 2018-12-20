# frozen_string_literal: true
require 'byebug'

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   requires :id, type: Integer, desc: 'Comment ID'
      #
      #   # good
      #   requires :id, type: Integer, desc: 'Comment ID', positive_int32: true
      class UserPositiveInt32Validator < Cop
        MSG = 'If this Integer maps to a postgres Integer column, validate with `positive_int32: true`'.freeze

        def_node_matcher :get_require_with_integer_hash, <<~PATTERN
        (send nil? {:requires :optional}
          (sym _)
          $(hash ...) ...)
        PATTERN
        def_node_search :is_type_integer?, '(pair (sym :type) (const nil? :Integer))'
        def_node_search :validates_integer?, '(pair (sym :positive_int32) (true))'

        def on_send(node)
          hash = get_require_with_integer_hash(node)
          return unless hash
          return unless is_type_integer?(hash)
          return if validates_integer?(hash)
          add_offense(node)
        end
      end
    end
  end
end
