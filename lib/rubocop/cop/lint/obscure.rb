# frozen_string_literal: true

# Custom rubocop to warn against using obscure Ruby language features as
# defined in our internal Ruby coding standards
# https://paper.dropbox.com/doc/Coding-Standards-for-Ruby-gV22vwXEHhE5Ahsb1r06c
module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   if (a...b)
      #
      #   # bad
      #   if (a..b)
      #
      # https://ruby-doc.org/core-2.4.0/doc/syntax/control_expressions_rdoc.html#label-Flip-Flop
      #
      #   # bad
      #   "%s" % "string"
      #
      # https://ruby-doc.org/core-2.4.0/String.html#method-i-25
      class Obscure < Cop
        MSG = "Do not use the flipflop operator"

        def_node_matcher :is_stringformat?, <<-PATTERN
          (send {str dstr} $:% ...)
        PATTERN

        def on_iflipflop(node)
          add_offense(node)
        end

        def on_eflipflop(node)
          add_offense(node)
        end

        def on_send(node)
          return unless is_stringformat?(node)

          add_offense(node, message: "Do not use String#%")
        end
      end
    end
  end
end
