class FakeCodeRunner
  attr_reader :transforms, :actions

  def transforms=(val)
    @transforms = val if val
  end

  def actions=(val)
    @actions = val if val
  end

  def call(line)
      line.upcase
    end
end
