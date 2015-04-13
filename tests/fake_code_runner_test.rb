require 'minitest/autorun'
require 'pry'
require 'test_helper.rb'
require_relative 'code_runner_interface_test'
require_relative '../lib/fake_code_runner'

class FakeCodeRunnerTest < MiniTest::Test
  include CodeRunnerInterfaceTest
end
