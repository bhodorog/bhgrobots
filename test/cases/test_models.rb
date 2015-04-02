require "test/unit"
require_relative "../../lib/bhgrobots/models"

class TestPosition < Test::Unit::TestCase
  def test_add
    a = Bhgrobots::Position.new(1, 2)
    b = Bhgrobots::Position.new(2, 1)
    res = a + b
    assert_equal(3, res.x)
    assert_equal(3, res.y)
  end

  def test_eq
    alien = Struct.new(:x, :y).new(1, 2)
    assert(Bhgrobots::Position.new(1, 2) != alien)
    assert(Bhgrobots::Position.new(2, 1) != Bhgrobots::Position.new(1, 2))
    assert(Bhgrobots::Position.new(1, 2) == Bhgrobots::Position.new(1, 2))
  end
end

class TestLimits < Test::Unit::TestCase
  def setup
    @llim = Bhgrobots::Limits.new(Struct.new(:x, :y).new(5, 5))
    @MockPos = Struct.new(:x, :y)
  end

  def test_is_valid?
    assert(@llim.is_valid?(@MockPos.new(2, 2)))
    assert(@llim.is_valid?(@MockPos.new(0, 5)))
    assert(@llim.is_valid?(@MockPos.new(5, 0)))
    assert(@llim.is_valid?(@MockPos.new(0, 0)))
    assert(not(@llim.is_valid?(@MockPos.new(6, 0))))
    assert(not(@llim.is_valid?(@MockPos.new(-1, 0))))
    assert(not(@llim.is_valid?(@MockPos.new(0, -1))))
  end

  def test_horiz_valid?
    assert(@llim.horiz_valid?(@MockPos.new(2, 10)))
    assert(not(@llim.horiz_valid?(@MockPos.new(10, 2))))
  end

  def test_vert_valid?
    assert(@llim.vert_valid?(@MockPos.new(10, 2)))
    assert(not(@llim.vert_valid?(@MockPos.new(2, 10))))
  end
end

class TestTable < Test::Unit::TestCase
  def setup
    @tbl = Bhgrobots::Table.new(Bhgrobots::Size.new(5, 5), Bhgrobots::Stat.new(0, 0, :N))
  end

  def test_drop_invalid_pos
    invalid_pos = Bhgrobots::Position.new(6, 6)
    start_pos = @tbl.crt_pos
    @tbl.crt_pos = invalid_pos
    assert(@tbl.crt_pos == start_pos)
  end
end

