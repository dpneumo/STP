class Plan
  attr_accessor :current_state

  def transition(line)
    protocol.detect {|event| event[:check].call(line) }
  end

private
  attr_reader :master

  def initialize(opts={})
    @current_state = opts.fetch :initial_state,  :beginning
    @master =        opts.fetch :master,         {beginning: [ {check: ->(line) { true }, new_state: :beginning,
                                                  actions: nil, transforms: nil } ]}
  end

  def protocol
    master[current_state]
  end
end
