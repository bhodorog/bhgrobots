task :default => [:test]

task :test, [:files] do |_, args|
  filter = args.to_a.empty? ? "*" : "{#{args.to_a.join(",")},}"
  tests = `git ls-files -- test/cases/#{filter}.rb`.split("\n")
  tests.each do |file|
    ruby %{-I./lib/ #{file}}
  end
end

task :build do
  sh %{gem build bhgrobots.gemspec}
end
