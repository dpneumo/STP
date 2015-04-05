require 'minitest/autorun'
require 'pry'
require_relative '../lib/mapper'

class MapperTest < MiniTest::Test
  class FakeForeman
    def call(line); nil; end
  end

  class FakeCodeRunner
    def call(line); line.upcase; end
  end

  def setup
    @mapper = Mapper.new(foreman: FakeForeman.new, coderunner: FakeCodeRunner.new)
    @lines = ["first\n", "second\n"]
  end

  def test_call_returns_an_array_of_transformed_lines
    assert_equal ["FIRST\n", "SECOND\n"], @mapper.call(@lines)
  end
end


