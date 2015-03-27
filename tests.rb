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


