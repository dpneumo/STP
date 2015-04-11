require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/code_runner'

class CodeRunnerTest < MiniTest::Test

  def setup
    @cr = CodeRunner.new(plan: Plan.new)
  end

  def test_can_call_code_stored_in_transforms
    @cr.transforms = [ ->(line) { line + '-' + line } ]
    assert_equal 'newline-newline', @cr.call('newline')
  end

  def test_initial_lambda_returns_its_parm_unchanged
    assert_equal 'a line', @cr.call('a line')
  end
end
