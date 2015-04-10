class Plan
  attr_reader :initial_lambda
  attr_accessor :current_state

  def transition(line)
    protocol.detect {|event| event[:test].call(line) }
  end


private
  attr_reader :master

  def initialize(opts={})
    @master =         opts.fetch :master,        {}
    @current_state =  opts.fetch :initial_state, :beginning
    @initial_lambda = opts.fetch :initial_lambda, ->(line) { line }
  end

  def protocol
    master[current_state]
  end
end
