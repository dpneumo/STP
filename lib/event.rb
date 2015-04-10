class Event
  attr_reader :test, :actions, :transforms
  def initialize(opts={})
    @test = opts.fetch :test, Test.new
    @actions = opts.fetch :actions, []
    @transforms = opts.fetch :transforms, []
  end
end
