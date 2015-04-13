class FakePlan
  attr_accessor :current_state
  def initialize(opts={})
    @current_state = :beginning
    @master =        opts.fetch :master, {}
  end

  def transition(line)
    case line
    when 'line will match'     # an event
      { check: ->(line) {true},
        new_state: :middle,
        actions: [],
        transforms: [] }
    else
      { check: ->(line) {false},
        new_state: :beginning,
        actions: [],
        transforms: [] }
    end
  end
end
