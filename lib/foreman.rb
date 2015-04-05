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
    rule = plan.transition(line)
    change_state(rule) if rule
  end

  def change_state(rule)
    coderunner.mylambda = rule[:lam]
    self.current_state = rule[:new_state]
  end

  def current_state=(state)
    plan.current_state = state
  end
end
