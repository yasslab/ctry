require "bundler/gem_tasks"
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("fast_try")

task :default => [:clobber, :compile, :spec]
