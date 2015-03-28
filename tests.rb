require "stringio"
require "test/unit"

require_relative "simulator"

class TestEngine < Test::Unit::TestCase
  @@basic_tc =<<HEREDOC
MOVE
LEFT
RIGHT
PLACE 1,1,N
HEREDOC

  def test_initialize
    inp = StringIO.new
    inp.puts(@@basic_tc)
    inp.seek 0
    eng = Engine.new inp
    assert_equal(4, eng.instrs.length)
  end
end


class TestPosition < Test::Unit::TestCase
  def test_add
    a = Position.new(1, 2)
    b = Position.new(2, 1)
    res = a + b
    assert_equal(3, res.x)
    assert_equal(3, res.y)
  end
end

class TestLimits < Test::Unit::TestCase
  def test_is_valid?
    llim = Limits.new(Struct.new(:x, :y).new(5, 5))
    assert(llim.is_valid?(Position.new(2, 2)))
    assert(llim.is_valid?(Position.new(0, 5)))
    assert(llim.is_valid?(Position.new(5, 0)))
    assert(llim.is_valid?(Position.new(0, 0)))
    assert(!llim.is_valid?(Position.new(6, 0)))
    assert(!llim.is_valid?(Position.new(-1, 0)))
    assert(!llim.is_valid?(Position.new(0, -1)))
  end
end


