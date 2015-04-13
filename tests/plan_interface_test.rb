module PlanInterfaceTest
  def test_implements_current_state_reader
    assert_equal true, @plan.respond_to?(:current_state)
  end

  def test_implements_current_state_writer
    assert_equal true, @plan.respond_to?(:current_state=)
  end

  def test_implements_transition
    assert_equal true, @plan.respond_to?(:transition)
    assert_equal 1, @plan.method(:transition).arity
  end
end
