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
    #if event
      coderunner.transforms = event[:transforms]
      plan.current_state = event[:new_state]
    #end
  end
end
