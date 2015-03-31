class Command
  attr_reader :extra, :r_s, :r # r for result, r_s for result_string
  
  def initialize(*args)
    @extra = args.pop
    @r = nil
    @r_s = to_s
  end

  def attempt(tbl)
    if validate(tbl)
      execute(tbl)
    else
      @r_s = "Skipped"
    end
    self
  end

  def validate(tbl)
    tbl.heading and tbl.crt_pos.x and tbl.crt_pos.y
  end
end

@@HEADINGS_OLD = {
  "N"=> :NORTH,
  "S"=> :SOUTH,
  "W"=> :WEST,
  "E"=> :EAST,
}

@@HEADINGS = [:N, :E, :S, :W]

class Place < Command
  def initialize(*args)
    super(*args)
    massage_extra
  end

  def execute(tbl)
    if @valid
      tbl.crt_stat = Stat.new(@new_pos.x, @new_pos.y, @new_head)
      @r = tbl.crt_stat
      @r_s = "#{self.class} to #{@r}"
    end
  end

  def validate(tbl)
    true
  end

  private
  def massage_extra
    # kind of a hack needed to differentiate between reading from file or using
    # stringio I'm to tired now to dig for the difference and fix it.
    if @extra.instance_of?(Array) 
      @extra = @extra.pop
    end
    extra_a = @extra.split(",")
    pos = extra_a[0...2].collect {|el| el.to_i}
    @new_pos = Position.new(*pos)
    head = extra_a[2].to_sym
    head_idx = @@HEADINGS.index(head)
    @new_head = @@HEADINGS[head_idx] if head_idx
    @valid = true unless !@new_head
  end
end


class Move < Command
  def initialize(*args)
    super(*args)
    @head2move = {
      N: Position.new(0, 1),
      E: Position.new(1, 0),
      S: Position.new(0, -1),
      W: Position.new(-1, 0),
    }
  end
    
  #silently doesn't do nothing when invalid move commands
  def execute(tbl)
    tbl.crt_pos = tbl.crt_pos + @head2move[tbl.heading]
    @r = tbl.crt_pos
    @r_s = "#{self.class} to #{tbl.crt_pos}"
  end
end


class Rotate < Command
  def execute(tbl)
    idx = @@HEADINGS.index(tbl.heading)
    rotated_idx = (idx+@angle) % 4
    tbl.heading = @@HEADINGS[rotated_idx]
    @r_s = "#{self.class.superclass} to #{self.class}"
  end
end

class Left < Rotate
  def initialize(*args)
    super(*args)
    @angle = -1
  end
end

class Right < Rotate
  def initialize(*args)
    super(*args)
    @angle = 1
  end
end

class Report < Command
  def execute(tbl)
    stat = tbl.accept(Status.new)
    @r_s = "#{stat.x},#{stat.y},#{stat.h}"
  end
end

class Status < Command
  def attempt(tbl)
    super(tbl)
    @r
  end

  def execute(tbl)
    @r = tbl.crt_stat
  end

  def validate(tbl)
    true
  end
end

