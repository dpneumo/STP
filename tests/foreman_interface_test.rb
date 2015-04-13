module ForemanInterfaceTest
  def test_implements_coderunner_reader
    assert_equal true, @fm.respond_to?(:coderunner)
  end

  def test_implements_current_state_reader
    assert_equal true, @fm.respond_to?(:current_state)
  end

  def test_implements_call
    assert_equal true, @fm.respond_to?(:call)
    assert_equal 1, @fm.method(:call).arity
  end
end
