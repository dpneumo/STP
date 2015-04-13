class FakePlan
  attr_accessor :current_state

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

private
  def initialize(opts={})
    @current_state = :beginning
    @master =        opts.fetch :master, {}
  end
end
