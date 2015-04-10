class EventTest
  attr_reader :lam
  def initialize(lam=nil)
    @lam = lam || ->(line) { false }
  end

  def call(line)
    lam.call line
  end
end

