class Transforms
  attr_reader :xforms
  def initialize(xforms=nil)
    @xforms = xforms || []
  end

  def call(line)
    xforms.reduce(line) {|line, x| x.call(line) }
    line
  end
end
