class Plan
  attr_accessor :current_state

  def transition(line)
    protocol.detect {|event| event[:check].call(line) }
  end

private
  attr_reader :master

  def initialize(opts={})
    @master =        opts.fetch :master,         {}
    @current_state = opts.fetch :initial_state,  :beginning
  end

  def protocol
    master[current_state]
  end
end
