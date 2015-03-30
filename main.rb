require 'simulator'

inp = StringIO.new
inp.puts(ARGF.read)
inp.seek(0)
@eng = Engine.new(inp)
@eng.run
