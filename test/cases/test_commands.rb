require "test/unit"
require_relative "../../lib/bhgrobots/commands"

class TestCommands < Test::Unit::TestCase
  def setup
    @tbl = Bhgrobots::Table.new(Bhgrobots::Size.new(5, 5), Bhgrobots::Stat.new(0, 0, :N))
  end

  def test_legal_place
    @tbl.accept(Bhgrobots::Place.new("1,1,S"))
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(1, after.x)
    assert_equal(1, after.y)
    assert_equal(:S, after.h)
  end

  def test_illegal_place
    before = @tbl.accept(Bhgrobots::Status.new)
    @tbl.accept(Bhgrobots::Place.new("1,1,X"))
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before, after)
  end

  def tets_discards_until_place
    before = @tbl.accept(Bhgrobots::Status.new)
    @tbl.accept(Bhgrobots::Report.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(after, before)
    assert_nil(before)
    before = after
    @tbl.accept(Bhgrobots::Move.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(after, before)
    assert_nil(before)
    before = after
    @tbl.accept(Bhgrobots::Left.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(after, before)
    assert_nil(before)
    before = after
    @tbl.accept(Bhgrobots::Right.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(after, before)
  end

  def test_legal_move
    legal = Bhgrobots::Move.new
    before = @tbl.accept(Bhgrobots::Status.new)
    @tbl.accept(legal)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before.x, after.x)
    assert_equal(before.y + 1, after.y)
    assert_equal(before.h, after.h)
  end

  def test_illegal_move
    @tbl.accept(Bhgrobots::Place.new("0,1,W"))
    before = @tbl.accept(Bhgrobots::Status.new)
    illegal = Bhgrobots::Move.new
    @tbl.accept(illegal)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before, after)
  end

  def test_rotate
    before = @tbl.accept(Bhgrobots::Status.new)
    @tbl.accept(Bhgrobots::Right.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before.pos, after.pos)
    assert_equal(:E, after.h)
    @tbl.accept(Bhgrobots::Right.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before.pos, after.pos)
    assert_equal(:S, after.h)
    @tbl.accept(Bhgrobots::Left.new)
    after = @tbl.accept(Bhgrobots::Status.new)
    assert_equal(before.pos, after.pos)
    assert_equal(:E, after.h)
  end

  def test_report
    rep = @tbl.accept(Bhgrobots::Report.new).r_s
    rep = rep.split(",")
    assert_equal(3, rep.length)
    assert(rep[0..1].all? {|el| el.to_i.instance_of?(Fixnum)})
    assert(["N", "S", "W", "E"].include?(rep[2]))
  end

  def test_status
    st = @tbl.accept(Bhgrobots::Status.new)
    assert([st.x, st.y].all? {|el| el.instance_of?(Fixnum)})
    assert([:N, :S, :W, :E].include?(st.h))
  end

  def test_nil_status
    tbl = Bhgrobots::Table.new(Bhgrobots::Size.new(5, 5))
    st = tbl.accept(Bhgrobots::Status.new)
    assert(st)
    assert_nil(st)
  end
    
  private
  def assert_nil(st)
    assert(!st.x) and assert(!st.y) and assert(!st.h)
  end
end

