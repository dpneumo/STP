module PlanHelper

  # Checks
  def nothing_happened
    ->(line) { true }
  end
  def prevailed
    ->(line) { /Prevailed/.match line }
  end
  def at_no
    ->(line) { /at no/.match line }
  end
  def on_dear
    ->(line) { /On dear/.match line }
  end

  # Actions
  def do_nothing; ->(line) {}; end

  # Transforms
  def upcase; ->(line) { line.upcase }; end
  def downcase; ->(line) { line.downcase }; end
  def swapcase; ->(line) { line.swapcase }; end
  def skip_line; ->(line) { line }; end

  # Events
  def prevailed_evnt
    { check: self.prevailed,
      new_state: :middle,
      actions: nil,
      transforms: [self.upcase] }
  end

  def skip_beg_line_evnt
    { check: self.nothing_happened,
      new_state: :beginning,
      actions: nil,
      transforms: nil }
  end

  def at_no_evnt
    { check: self.at_no,
      new_state: :ending,
      actions: nil,
      transforms: [self.downcase] }
  end

  def skip_mid_line_evnt
    { check: self.nothing_happened,
      new_state: :middle,
      actions: nil,
      transforms: nil }
  end

  def on_dear_evnt
    { check: self.on_dear,
      new_state: :beginning,
      actions: nil,
      transforms: [self.swapcase] }
  end

  def skip_end_line_evnt
    { check: self.nothing_happened,
      new_state: :ending,
      actions: nil,
      transforms: nil }
  end

end
