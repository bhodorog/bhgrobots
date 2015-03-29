require "stringio"
require "test/unit"

require_relative "simulator"

class TestEngine < Test::Unit::TestCase
  @@basic_tc =<<HEREDOC
MOVE
LEFT
RIGHT
PLACE 1,1,N
REPORT
HEREDOC

  def test_initialize
    inp = StringIO.new
    inp.puts(@@basic_tc)
    inp.seek 0
    eng = Engine.new inp
    assert_equal(5, eng.instrs.length)
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

  def test_eq
    alien = Struct.new(:x, :y).new(1, 2)
    assert(Position.new(1, 2) != alien)
    assert(Position.new(2, 1) != Position.new(1, 2))
    assert(Position.new(1, 2) == Position.new(1, 2))
  end
end

class TestLimits < Test::Unit::TestCase
  def setup
    @llim = Limits.new(Struct.new(:x, :y).new(5, 5))
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
    @tbl = Table.new(Size.new(5, 5))
  end

  def test_drop_invalid_pos
    invalid_pos = Position.new(6, 6)
    start_pos = @tbl.crt_pos
    @tbl.crt_pos = invalid_pos
    assert(@tbl.crt_pos == start_pos)
  end
end

class TestCommands < Test::Unit::TestCase
  def setup
    @tbl = Table.new(Size.new(5, 5))
  end

  def test_place
    @tbl.accept(Place.new("1,1,S"))
    after = @tbl.accept(Status.new)
    assert_equal(1, after.x)
    assert_equal(1, after.y)
    assert_equal(:SOUTH, after.h)
  end

  def test_legal_move
    legal = Move.new
    before = @tbl.accept(Status.new)
    @tbl.accept(legal)
    after = @tbl.accept(Status.new)
    assert_equal(before.x, after.x)
    assert_equal(before.y + 1, after.y)
    assert_equal(before.h, after.h)
  end

  def test_report
    rep = @tbl.accept(Report.new).split(",")
    assert_equal(3, rep.length)
    assert(rep[0..1].all? {|el| el.to_i.instance_of?(Fixnum)})
    assert(["NORTH", "SOUTH", "WEST", "EAST"].include?(rep[2]))
  end

  def test_status
    st = @tbl.accept(Status.new)
    assert([st.x, st.y].all? {|el| el.instance_of?(Fixnum)})
    assert([:NORTH, :SOUTH, :WEST, :EAST].include?(st.h))
  end
end

