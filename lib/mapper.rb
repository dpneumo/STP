class Mapper
  attr_reader :foreman, :coderunner

  def call(lines, &block)
    map(lines, &block)
  end

private
  def initialize(opts={})
    @foreman    = opts.fetch :foreman
    @coderunner = opts.fetch :coderunner
  end

  def map(lines, &block)
    lines.map do |line|
      foreman.call(line)
      coderunner.call(line)
    end
  end
end
