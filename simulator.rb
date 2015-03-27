require "commands"

class Engine
  attr_reader :instrs, :cmds
  
  def initialize(fd)
    @instrs = fd.readlines.map do |line|
      line.split
    end
    build_cmds
  end

  def run
    @cmds.collect do |cmd|
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
      @cmds.push(klass.new extra)
    end
  end
end


@eng = Engine.new File.new("instructions.txt")
@eng.run
