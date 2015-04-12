  class FakeForeman
    attr_reader :coderunner
    def call(line)
      nil
    end

    def current_state
      :beginning
    end
  end
