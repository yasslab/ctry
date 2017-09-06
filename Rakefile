require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"

task :build => :compile

Rake::ExtensionTask.new("fast_try")

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end

task :default => [:clobber, :compile, :test]
