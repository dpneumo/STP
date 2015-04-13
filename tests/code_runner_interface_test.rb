module CodeRunnerInterfaceTest
  def test_implements_transforms_reader
    assert_equal true, @cr.respond_to?(:transforms)
  end

  def test_implements_transforms_writer
    assert_equal true, @cr.respond_to?(:transforms=)
  end

  def test_implements_actions_reader
    assert_equal true, @cr.respond_to?(:actions)
  end

  def test_implements_actions_writer
    assert_equal true, @cr.respond_to?(:actions=)
  end

  def test_implements_call
    assert_equal true, @cr.respond_to?(:call)
    assert_equal 1, @cr.method(:call).arity
  end
end
