require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/mapper'
require_relative '../lib/fake_foreman.rb'
require_relative '../lib/fake_code_runner.rb'

class MapperTest < MiniTest::Test
  def setup
    @mapper = Mapper.new( foreman: FakeForeman.new( coderunner: FakeCodeRunner.new,
                                                    plan:       FakePlan.new ),
                          coderunner: FakeCodeRunner.new)
    @lines = ["first\n", "second\n"]
  end

  def test_call_returns_an_array_of_transformed_lines
    assert_equal ["FIRST\n", "SECOND\n"], @mapper.call(@lines)
  end
end


