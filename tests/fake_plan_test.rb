require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative 'plan_interface_test'
require_relative '../lib/fake_plan'

class FakePlanTest < MiniTest::Test
  def setup
    @plan = FakePlan.new
  end

  include PlanInterfaceTest
end
