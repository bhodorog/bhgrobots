class Command
  attr_reader :extra
  
  def initialize(*args)
    @extra = args.pop
    custom_init
  end

  private
  def custom_init
  end
end


class Place < Command
  def execute(tbl)
    "Place"
  end
end


class Move < Command
  Delta = Struct.new(:x, :y)
  #silently doesn't do nothing when invalid move commands
  def execute(tbl)
    tbl.crt_pos = tbl.crt_pos + @head2move[:NORTH]
  end

  private
  def custom_init
    @head2move = {
      NORTH: Delta.new(0, 1),
       EAST: Delta.new(1, 0),
      SOUTH: Delta.new(0, -1),
       WEST: Delta.new(-1, 0),
    }
  end
end


class Rotate < Command
  def execute(tbl)
    "Rotate"
    # tbl.robot.rotate(@angle)
  end
end

class Left < Rotate
end

class Right < Rotate
end

class Report < Command
  def execute
    "Rotate"
  end
end



