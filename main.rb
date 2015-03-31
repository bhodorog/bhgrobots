require 'simulator'

p ARGV
inp = StringIO.new
inp.puts(ARGF.read)
inp.seek(0)
@eng = Engine.new(inp)
p @eng.run
