require_relative 'mapper'
require_relative 'foreman'
require_relative 'code_runner'
require_relative 'plan'

class STP
  def lines
    mapper.call(original_lines)
  end

  # Convenience methods
  def each(&block)
    lines.each &block
  end

  def map(&block)
    lines.map &block
  end

private
  attr_reader :document, :plan,
              :code_runner, :foreman, :mapper

  def initialize(opts={})
    @document = opts.fetch :document, []
    @plan = Plan.new(master: opts.fetch(:plan, nil))

    @code_runner = CodeRunner.new
    @foreman =     Foreman.new( coderunner: code_runner, plan: @plan )
    @mapper =      Mapper.new(  coderunner: code_runner, foreman: foreman )
  end

  def original_lines
    case document
    when File, Array
      document
    when String
      document.lines
    else
      raise ArgumentError, 'Document is neither String, File or Array.'
    end
  end
end
