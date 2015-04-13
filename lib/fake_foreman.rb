class FakeForeman
  attr_reader :coderunner
  def initialize(opts={})
    @coderunner =  opts.fetch :coderunner
    @plan   =      opts.fetch :plan
  end

  def call(line)
    nil
  end

  def current_state
    :beginning
  end
end
