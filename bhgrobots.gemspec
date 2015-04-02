Gem::Specification.new do |s|
  s.name        = 'bhgrobots'
  s.version     = '0.0.2'
  s.date        = '2015-04-01'
  s.summary     = "A trial project for ruby"
  s.description = "Simulate a robot blindly moving on a square table"
  s.authors     = ["Bogdan Hodorog"]
  s.email       = 'bogdan.hodorog@gmail.com'
  s.homepage    =
    'https://github.com/bhodorog/bhgrobots'
  s.license     = 'MIT'
  s.extra_rdoc_files = %w(README.md)
  # s.files       = ["lib/hola.rb"]
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,scenarios}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
