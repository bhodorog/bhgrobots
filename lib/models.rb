Size = Struct.new(:x, :y)

class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def +(other)
    Position.new(@x + other.x,  @y + other.y)
  end

  def ==(other)
    if not other.is_a?(Position)
      return false
    end
    @x == other.x and @y == other.y
  end

  def !=(other)
    not(self.==(other))
  end

  def to_s
    "#{x},#{y}"
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

class Stat
  attr_reader :x, :y
  attr_accessor :h

  def initialize(x=0, y=0, h=:N)
    @x, @y, @h = x, y, h
  end

  def pos
    Position.new(x, y)
  end

  def ==(other)
    if !other.instance_of?(Stat)
      return false
    end
    x == other.x and y == other.y and h == other.h
  end

  def to_s
    "#{x},#{y},#{h}"
  end
end

class Table
  def initialize(size, place=Stat.new(nil, nil, nil))
    @limits = Limits.new(size)
    @crt_stat = place
  end

  def accept(cmd)
    cmd.attempt(self)
  end

  def crt_stat=(s)
    if @limits.is_valid?(s.pos)
      @crt_stat = s
    end
  end

  def crt_pos=(pos)
    if @limits.is_valid?(pos)
      @crt_stat = Stat.new(pos.x, pos.y, @crt_stat.h)
    end
  end

  def crt_pos
    @crt_stat.pos
  end

  def heading
    @crt_stat.h
  end

  def heading=(h)
    @crt_stat.h = h
  end

  def crt_stat
    Stat.new(crt_pos.x, crt_pos.y, heading)
  end
end
