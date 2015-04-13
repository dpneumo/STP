require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative 'code_runner_interface_test'
require_relative '../lib/code_runner'

class CodeRunnerTest < MiniTest::Test
  def setup
    @cr = CodeRunner.new
  end

  include CodeRunnerInterfaceTest

  def test_default_transforms_and_actions_do_not_alter_line
    assert_equal 'a line', @cr.call('a line')
  end

  def test_can_call_code_stored_in_actions
    action_output = ''
    @cr.actions = [ ->(line) { action_output = line } ]
    @cr.call('newline')
    assert_equal 'newline', action_output
  end

  def test_code_in_actions_does_not_alter_line_passed_to_transforms
    @cr.actions = [ ->(line) { line + '-' + line } ]
    assert_equal 'newline', @cr.call('newline')
  end

  def test_can_call_code_stored_in_transforms
    @cr.transforms = [ ->(line) { line + '-' + line } ]
    assert_equal 'newline-newline', @cr.call('newline')
  end
end
