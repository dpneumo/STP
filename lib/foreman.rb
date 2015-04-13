class Foreman
  attr_reader :coderunner

  def call(line)
    configure_for line
  end

  def current_state
    plan.current_state
  end

private
  attr_reader :plan

  def initialize(opts={})
    @coderunner =  opts.fetch :coderunner
    @plan   =      opts.fetch :plan
  end

  def configure_for(line)
    event = plan.transition(line)
    coderunner.actions = event[:actions]
    coderunner.transforms = event[:transforms]
    plan.current_state = event[:new_state] if event[:new_state]
  end
end
