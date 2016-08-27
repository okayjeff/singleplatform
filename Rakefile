require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << ['test', 'test/singleplatform']
  t.pattern = 'test/**/test_*.rb'
end

desc "Run tests"
task :default => :test