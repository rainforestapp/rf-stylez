# frozen_string_literal: true

require "unparser"

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   vcr: { record_mode: :once, tag: :foo }
      #   vcr: { record_mode: :none }
      #
      #   # good
      #   vcr: { tag: :foo }
      #   vcr: true
      class NoVCRRecording < RuboCop::Cop::Base
        extend AutoCorrector

        MSG = "Do not set :record option in VCR"

        def_node_search :is_only_setting_record_option?, <<~PATTERN
          (pair
            (sym :vcr)
            (hash
              (pair
                (sym :record)
                ...
              )
            )
          )
        PATTERN
        def_node_search :is_setting_record_option?, <<~PATTERN
          (pair
            (sym :vcr)
            (hash
              <
                (pair
                  (sym :record)
                  ...
                )
                ...
              >
            )
          )
        PATTERN

        def on_pair(node)
          return unless is_only_setting_record_option?(node) || is_setting_record_option?(node)

          add_offense(node) do |corrector|
            if is_only_setting_record_option?(node)
              corrector.replace(node, "vcr: true")
            elsif is_setting_record_option?(node)
              corrector.replace(node, remove_record_option(node))
            end
          end
        end

        private

        def remove_record_option(top_pair_node)
          extend AST::Sexp

          _vcr_key, hash = top_pair_node.children
          other_options = hash.children.reject do |pair|
            key, _value = pair.children
            key == s(:sym, :record)
          end

          Unparser.unparse(s(:pair, s(:sym, :vcr), s(:hash, *other_options)))
        end
      end
    end
  end
end
