require 'simulator'
require 'optparse'
require 'ostruct'
require 'commands'

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
      # opts.on("-h", "--help", "Display this screen") do
      #   p opts
      # end
      opts.banner = @@Usage
      # opts.on("-i", "--input FILE", "instructions file") do |f|
      #   @options.input = f
      # end
      opts.on("-f", "--filter f1, f2, f3, ...", Array, "filter reports of the commands based on this option. You can pass a list of comma separated of the following Place|Move|Left|Right|[Report]|Status|Object") do |fs|
        @options.filters = fs || options.filters
      end
    end.parse!(opts)
  end

  def validate_opts
    def _klassify_filters
      fltrs = @options.filters.collect do |flt|
        klass = Object::const_get(flt)
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
    input = ARGV.shift
    validate_filename(input)
    parse_opts(ARGV)
    validate_opts
    @eng = Engine.new(File.new(input), @options.filters)
    p @eng.run
  end
end

CliRunner.new.main
