# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # @example
      #   # bad
      #   class Foo < Grape::API
      #
      #   # good
      #   class Foo < Api::AuthBase
      #
      #   # good
      #   class Foo < Api::Base
      class NoGrapeAPI < Cop
        MSG = "Prefer inheriting `Api::AuthBase` or `Api::Base` instead of `Grape::API`."

        def_node_matcher :inherits_Grape_API?, "(class (const ...) (const (const nil? :Grape) :API) ...)"

        def on_class(node)
          return unless inherits_Grape_API?(node)

          add_offense(node)
        end
      end
    end
  end
end
