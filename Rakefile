task :default => :test

task :test, [:files] do |_, args|
  cleaned = args.to_a.select {|a| a}
  filter = cleaned.empty? ? "*" : "{#{args.to_a.join(",")},}"
  tests = `git ls-files -- test/cases/#{filter}.rb`.split("\n")
  tests.each do |file|
    ruby "-I./lib/ #{file} #{ENV["opts"]}"
  end
end

task :build do
  sh %{gem build bhgrobots.gemspec}
end

task install: [:build] do
  sh %{gem install bhgrobots*.gem}
end
