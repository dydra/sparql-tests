module RSpec
  module Core
    module Formatters
      # Formats backtraces so they're clickable by TextMate
      class HtmlFormatter

        def example_file(example)
          if example.metadata[:example_group][:block].inspect =~ /\/(.*\.rb)/
            file = $1
          else
            file = "file not found, #{example.metadata.keys.inspect}"
          end
          remote = "https://datagraph.unfuddle.com/a#/projects/3/repositories/56/file?path=#{file.slice(file =~ /\/spec\//, file.length)}"
          [file, remote]
        end

        def example_failed(example)
          (file, remote) = example_file(example)
          counter = 0
          exception = example.metadata[:execution_result][:exception]
          extra = extra_failure_content(exception)
          failure_style = 'failed'
          failure_style = RSpec::Core::PendingExampleFixedError === exception ? 'pending_fixed' : 'failed'
          @output.puts "    <script type=\"text/javascript\">makeRed('rspec-header');</script>" unless @header_red
          @header_red = true
          @output.puts "    <script type=\"text/javascript\">makeRed('example_group_#{example_group_number}');</script>" unless @example_group_red
          @example_group_red = true
          move_progress
          @output.puts "    <dd class=\"spec #{failure_style}\">"
          @output.puts "      <span class=\"failed_spec_name\">#{h(example.description)} (<a href=\"file:///#{file}\">Local copy</a>) (<a href=\"#{remote}\">unfuddle</a>)</span>"
          @output.puts "      <div class=\"failure\" id=\"failure_#{counter}\">"
          @output.puts "        <div class=\"message\"><pre>#{h(exception.message)}</pre></div>" unless exception.nil?
          @output.puts "        <div class=\"backtrace\"><pre>#{format_backtrace(exception.backtrace, example).join("\n")}</pre></div>" if exception
          @output.puts extra unless extra == ""
          @output.puts "      </div>"
          @output.puts "    </dd>"
          @output.flush
        end

        def example_passed(example)
          (file, remote) = example_file(example)
          move_progress
          @output.puts "    <dd class=\"spec passed\"><span class=\"passed_spec_name\">#{h(example.description)}"
          @output.puts "(<a href=\"file:///#{file}\">Local copy</a>) (<a href=\"#{remote}\">unfuddle</a>)</span></dd>"
          @output.flush
        end

      end
    end
  end
end
