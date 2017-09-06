require "bundler/gem_tasks"
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("fast_try") do |ext|
  ext.lib_dir = "lib/fast_try"
end

task :default => [:clobber, :compile, :spec]
