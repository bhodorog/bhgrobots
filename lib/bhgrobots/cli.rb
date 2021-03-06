require 'optparse'
require 'ostruct'

require_relative 'commands'
require_relative 'simulator'

module Bhgrobots
  class CliRunner
    @@Usage = "Usage: ruby -I. main.py FILENAME [options]"
    def initialize
      @options = OpenStruct.new
      _defaults
    end

    private
    def _defaults
      @options.filters = ["Report"]
    end

    public
    def parse_opts(opts)
      OptionParser.new do |opts|
        opts.banner = @@Usage
        opts.on("-f", "--filter f1, f2, f3, ...", Array,
                %{"filter reports of the commands based on this option. You can
 pass a list of comma separated of the following Place|Move|Left|Right|[Report]|
Status|Object"}.gsub("\n", "")) do |fs|
          @options.filters = fs || @options.filters
        end
        opts.on("-h", "--help", "Display this screen") do
          puts opts
          exit
        end
      end.parse!(opts)
    end

    def validate_opts
      def _klassify_filters
        fltrs = @options.filters.map do |flt|
          Bhgrobots::klassify(flt)
        end
      end

      @options.filters = _klassify_filters
    end

    def validate_filename(inp)
      if !inp
        p "Please provide an input FILENAME as 1st arg"
        p @@Usage
        exit
      elsif !File.exist?(inp)
        p "File '#{inp}' provided must exists!"
        exit
      end
    end
    
    def main
      if ARGV.empty? or ARGV.include?("-h") or ARGV.include?("--help")
        ARGV << "-h"
      else
        input = ARGV.shift
        validate_filename(input)
      end
      parse_opts(ARGV)
      validate_opts
      @eng = Engine.new(File.new(input), @options.filters)
      p @eng.run
    end
  end
end
