class CodeRunner
  attr_accessor :transforms

  def call(line)
    submit_line(line)
  end


private
  def initialize(opts={})
    plan =        opts.fetch :plan
    @transforms = plan.transforms
  end

  def submit_line(line)
    transforms.reduce(line) {|line, xform| xform.call(line) }
  end
end
