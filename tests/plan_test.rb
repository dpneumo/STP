require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative 'plan_interface_test'
require_relative '../lib/plan'

class PlanTest < MiniTest::Test
  def setup
    @plan = Plan.new
  end

  include PlanInterfaceTest
end
