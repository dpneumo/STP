class Xform
  attr_reader :lam
  def initialize(lam=nil)
    @lam = lam || ->(line) { line }
  end

  def call(line)
    lam.call line
    line
  end
end
