require "pry"

class Command
  attr_reader :extra
  
  def initialize(*args)
    @extra = extra.pop
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

class Interpreter
  attr_reader :instrs, :cmds
  
  def initialize(fname)
    @instrs = File.readlines(fname).map do |line|
      line.split
    end
    build_cmds
  end

  def run
    for cmd in @cmds
      cmd.execute
    end
  end

  private
  def build_cmds
    @cmds = []
    for inst in @instrs
      klass_name = inst[0].downcase.capitalize
      klass = Object::const_get(klass_name)
      extra = inst[1, inst.length-1]
      binding.pry
      @cmds.push(klass.new extra)
    end
  end
end

int = Interpreter.new "instructions.txt"
int.run
