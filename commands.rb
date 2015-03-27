class Command
  attr_reader :extra
  
  def initialize(*args)
    @extra = args.pop
  end
end


class Place < Command
  def execute
    "Place"
  end
end


class Move < Command
  def execute
    "Move"
  end
end


class Rotate < Command
  def execute
    "Rotate"
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



