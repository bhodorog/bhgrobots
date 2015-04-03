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
      @instrs = fd.readlines.map {|l| l.strip}
      build_cmds
    end

    def run
      @res = @cmds.map do |cmd|
        @table.accept(cmd)
      end
      filter_cmds
    end

    def filter_cmds
      @res.select do |el|
        @filter.any?{ |f| el.is_a?(f) }
      end.map{ |el| el.r_s}
    end

    private
    def build_cmds
      @cmds = @instrs.map do |i|
        Bhgrobots::build_cmd(i)
      end
    end
  end
end
