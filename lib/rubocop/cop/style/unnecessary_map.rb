# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class UnnecessaryMap < Base

        MSG = 'Use `#each` instead of `#map` when return value is unused.'

        # @!method map_without_using_result?(node)
        def_node_matcher :map_without_using_result?, <<~PATTERN
          (block(send(...) :map) ...)
        PATTERN

        def on_defs(node)
          body = node.children[2]

          body.children.each_with_index do |c, index|
            map_without_using_result?(c) do |matched_call|
              add_offense(matched_call, location: :selector)
            end
            if index == body.children.size - 1
              # don't inspect the final value
              # we don't want to match any implicit returns
            end
          end
        end
      end
    end
  end
end
