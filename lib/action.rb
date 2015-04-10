class Action
  attr_reader :line, :lam
  def initialize(line=nil, lam=nil)
    @line = line
    @lam = lam || ->() {}
  end

  def perform
    lam.call(line)
  end
end
