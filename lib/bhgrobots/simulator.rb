require "stringio"

require_relative "commands"
require_relative "models"
require_relative "utils"

module Bhgrobots
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
        @cmds.push(Bhgrobots::build_cmd(inst))
      end
    end
  end
end
