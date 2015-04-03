require "test/unit"

require_relative "../../lib/bhgrobots/utils"

class TestClassname < Test::Unit::TestCase
  def setup
    @expected = "Classname"
    @full_fqn = "Module::Submodule::#{@expected}"
    @simple_fqn = "#{@expected}"
  end

  def test_just_class
    assert_equal(@expected, Bhgrobots::class_name(@simple_fqn))
  end

  def test_fully_qualified
    assert_equal(@expected, Bhgrobots::class_name(@full_fqn))
  end
end

class TestKlassify < Test::Unit::TestCase
  def setup
    @legals = %w[Report report REPORT rEPORT]
    @expected = "Bhgrobots::Report"
    @illegals = %w[Inexistent]
  end

  def test_legals
    @legals.each do |inst|
      assert_equal(@expected, Bhgrobots::klassify(inst).name)
    end
  end

  def test_illegals
    @illegals.each do |inst|
      assert_raises(NameError) do
        Bhgrobots::klassify(inst)
      end
    end
  end
end
