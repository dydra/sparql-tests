module RSpec
  module Core
    module Formatters

      ## allow contexts in the documentation formatter to span multiple files.
      # This is pretty brittle, but was rejected upstream as being too special a
      # case.
      class DocumentationFormatter

        alias_method :old_example_group_started, :example_group_started
        def example_group_started(example_group)

          if previous_groups.empty? || example_group.description != previous_groups.pop
            previous_groups.clear
            old_example_group_started(example_group)
          else
            @group_level += 1
          end
        end

        alias_method :old_example_group_finished, :example_group_finished
        def example_group_finished(example_group)
          previous_groups.push example_group.description
          old_example_group_finished(example_group)
        end

        def previous_groups
          @previous_groups ||= []
        end

      end if defined? DocumentationFormatter
    end
  end
end
