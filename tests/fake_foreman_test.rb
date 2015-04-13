require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative '../lib/fake_foreman'
require_relative 'foreman_interface_test'
require_relative '../lib/fake_code_runner.rb'
require_relative '../lib/fake_plan'

class FakeForemanTest < MiniTest::Test
  def setup
    @fm = FakeForeman.new( coderunner: FakeCodeRunner.new,
                           plan:       FakePlan.new )
  end

  include ForemanInterfaceTest
end
