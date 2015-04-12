class CodeRunner
  attr_reader :transforms, :actions

  def transforms=(val)
    @transforms = val if val
  end

  def actions=(val)
    @actions = val if val
  end

  def call(line)
    submit_line(line)
  end

private
  def initialize()
    @actions =    [ ->(line) {} ]
    @transforms = [ ->(line) { line } ]
  end

  def submit_line(line)
    actions.reduce(line) {|line, action| action.call(line) }
    transforms.reduce(line) {|line, xform| xform.call(line) }
  end
end
