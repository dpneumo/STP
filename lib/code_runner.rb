class CodeRunner
  attr_accessor :mylambda

  def call(line)
    submit_line(line)
  end


private
  def initialize(opts={})
    plan =      opts.fetch :plan
    @mylambda = plan.initial_lambda
  end

  def submit_line(line)
    mylambda.call(line)
  end
end
