class Command
  attr_reader :extra
  
  def initialize(*args)
    @extra = args.pop
  end
end


class Place < Command
  def initialize(*args)
    super(*args)
    @headshorts = {
      "N"=> :NORTH,
      "S"=> :SOUTH,
      "W"=> :WEST,
      "E"=> :EAST,
    }
    massage_extra
  end

  def execute(tbl)
    tbl.crt_stat = Stat.new(@new_pos.x, @new_pos.y, @new_head)
    "Place the robot at #{tbl.crt_stat}"
  end

  private
  def massage_extra
    # needed to differentiate between reading from file or using stringio
    # I'm to tired now to dig for the difference and fix it.
    if @extra.instance_of?(Array) 
      @extra = @extra.pop
    end
    extra_a = @extra.split(",")
    pos = extra_a[0...2].collect {|el| el.to_i}
    @new_pos = Position.new(*pos)
    @new_head = @headshorts[extra_a[2]]
  end
end


class Move < Command
  def initialize(*args)
    super(*args)
    @head2move = {
      NORTH: Position.new(0, 1),
       EAST: Position.new(1, 0),
      SOUTH: Position.new(0, -1),
       WEST: Position.new(-1, 0),
    }
  end
    
  #silently doesn't do nothing when invalid move commands
  def execute(tbl)
    tbl.crt_pos = tbl.crt_pos + @head2move[tbl.heading]
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
  def execute(tbl)
    stat = tbl.accept(Status.new)
    "#{stat.x},#{stat.y},#{stat.h}"
  end
end

class Status < Command
  def execute(tbl)
    Stat.new(tbl.crt_pos.x, tbl.crt_pos.y, tbl.heading)
  end
end

