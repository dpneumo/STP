class CodeRunner
  attr_accessor :transforms, :actions

  def call(line)
    submit_line(line)
  end


private
  def initialize(opts={})
    #plan =        opts.fetch :plan
    @actions =    opts.fetch :actions, []
    @transforms = opts.fetch :transforms, [ ->(line) { line } ]
  end

  def submit_line(line)
    actions.reduce(line) {|line, action| action.call(line) }
    transforms.reduce(line) {|line, xform| xform.call(line) }
  end
end
