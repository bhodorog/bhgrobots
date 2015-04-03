require "stringio"
require "test/unit"

require_relative "../../lib/bhgrobots/simulator"

class TestEngine < Test::Unit::TestCase
  BASIC_TC =<<HEREDOC
MOVE
LEFT
RIGHT
PLACE 1,1,N
REPORT
HEREDOC

  def setup
    @inp = StringIO.new(BASIC_TC)
    @eng = Bhgrobots::Engine.new(@inp)
  end

  def test_initialize
    assert_equal(5, @eng.instrs.length)
  end

  def test_simple_filter
    @eng = Bhgrobots::Engine.new(@inp, filter=["Report"])
    @eng.run.each do |r|
      assert_kind_of(Report, r)
    end
  end

  def test_many_filters
    fltrs = ["Report", "Move", "Left"]
    @eng = Bhgrobots::Engine.new(@inp, fltrs)
    @eng.run.each do |res|
      flrtrs.any? {|flt| assert_kind_of(flt, res)}
    end
  end
end

