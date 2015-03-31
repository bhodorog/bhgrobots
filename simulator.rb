require "stringio"
require "commands"
require "models"

class Engine
  attr_reader :instrs, :cmds
  
  def initialize(fd, filter=[Report])
    @table = Table.new(Position.new(5, 5))
    @filter = filter
    @instrs = fd.readlines.map do |line|
      line.split
    end
    build_cmds
  end

  def run
    @res = @cmds.collect do |cmd|
      @table.accept(cmd)
    end
    filter_cmds
  end

  def filter_cmds
    @res.select{ |el| @filter.any?{|f| el.is_a?(f)}}.collect{ |el| el.r_s}
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

class Foo
  def main
  end
end
