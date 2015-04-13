require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/foreman'
require_relative 'foreman_interface_test'
require_relative '../lib/fake_code_runner.rb'
require_relative '../lib/fake_plan'

class ForemanTest < MiniTest::Test
  def setup
    @fm = Foreman.new( coderunner: FakeCodeRunner.new,
                       plan:       FakePlan.new )
  end

  include ForemanInterfaceTest

  def test_correctly_handles_transition_when_line_matches_an_allowed_transition
    @fm.call('line will match')
    assert_equal :middle, @fm.current_state
    assert_equal [], @fm.coderunner.actions
    assert_equal [], @fm.coderunner.transforms
  end

  def test_state_is_not_changed_if_line_does_not_match_an_allowed_transition
    @fm.call('will not match')
    assert_equal :beginning, @fm.current_state
  end
end
