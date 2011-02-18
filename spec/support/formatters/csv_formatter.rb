require 'rspec/core/formatters/base_text_formatter'

class CSVFormatter < RSpec::Core::Formatters::BaseTextFormatter

  def initialize(output)
    super(output)
    @groups = []
  end

  def example_group_started(example_group)
    @groups.push(example_group.description)
  end

  def example_group_finished(example_group)
    @groups.pop
  end

  def example_passed(example)
    super(example)
    output.puts passed_output(example)
  end

  def example_pending(example)
    super(example)
    output.puts pending_output(example, example.execution_result[:pending_message])
  end

  def example_failed(example)
    super(example)
    output.puts failure_output(example, example.execution_result[:exception])
  end

  def failure_output(example, exception)
    csv_output(example,'failed')
  end

  def passed_output(example)
    csv_output(example,'passed')
  end

  def pending_output(example, message)
    csv_output(example,'pending')
  end

  def csv_output(example, status)
    "#{status}\t#{example.execution_result[:run_time]}\t#{@groups.last}/#{example.description}"
  end

  def example_group_chain
    example_group.ancestors.reverse
  end

  def dump_summary(*args)
  end

end
