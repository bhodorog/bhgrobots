Coordinate = Struct.new(:x, :y)

class Robot
  def initialize
    @heading = :NORTH
  end
end

class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def +(other)
    Position.new(@x + other.x,  @y + other.y)
  end
end

class Limits
  def initialize(size)
    @left = 0
    @bottom = 0
    @right = size.x
    @top = size.y
  end

  def is_valid?(pos)
     horiz_valid?(pos) and vert_valid?(pos)
  end

  def horiz_valid?(pos)
    @left <= pos.x and pos.x <= @right
  end

  def vert_valid?(pos)
    @bottom <= pos.y and pos.y <= @top
  end
end

class Table
  attr_accessor :crt_pos
  attr_reader :robot
  
  def initialize(size)
    @robot = Robot.new
    @crt_pos = Position.new(0, 0)
    @limits = Limits.new(size)
  end

  def accept(cmd)
    cmd.execute(self)
  end

  def crt_pos=(pos)
    if @limits.is_valid?(pos)
      @limits = pos
    end
  end

  def crt_pos
    @crt_pos
  end
end
