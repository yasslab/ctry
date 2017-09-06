require 'benchmark/ips'

require 'fast_try'

class Object
  alias fast_try try
  alias fast_try! try!
end

class NilClass
  alias fast_try try
  alias fast_try! try!
end

require 'active_support'
require 'active_support/core_ext/object/try'

puts "nil: nonexisting method"
Benchmark.ips do |x|
  x.report('try') { nil.try(:foo) }
  x.report('fast_try') { nil.fast_try(:foo) }
  x.compare!
end

puts "nil: nonexisting method with args"
Benchmark.ips do |x|
  x.report('try') { nil.try(:foo, :bar) }
  x.report('fast_try') { nil.fast_try(:foo, :bar) }
  x.compare!
end

puts "nil: method call"
Benchmark.ips do |x|
  x.report('try') { nil.try(:size) }
  x.report('try!') { nil.try!(:size) }
  x.report('fast_try') { nil.fast_try(:size) }
  x.report('fast_try!') { nil.fast_try!(:size) }
  x.report('&.') { nil&.size }
  x.compare!
end

puts "nil: argument forwarding"
Benchmark.ips do |x|
  x.report('try') { nil.try(:sub, "foo", "bar") }
  x.report('try!') { nil.try!(:sub, "foo", "bar") }
  x.report('fast_try') { nil.fast_try(:sub, "foo", "bar") }
  x.report('fast_try') { nil.fast_try!(:sub, "foo", "bar") }
  x.report('&.') { nil&.sub("foo", "bar") }
  x.compare!
end

puts "nil: block forwarding"
Benchmark.ips do |x|
  x.report('try') { nil.try(:sub, "foo") { "bar" } }
  x.report('try!') { nil.try!(:sub, "foo") { "bar" } }
  x.report('fast_try') { nil.fast_try(:sub, "foo") { "bar" } }
  x.report('fast_try!') { nil.fast_try!(:sub, "foo") { "bar" } }
  x.report('&.') { nil&.sub("foo") { "bar" } }
  x.compare!
end

puts "nil: only block"
Benchmark.ips do |x|
  x.report('try') { nil.try { "bar" } }
  x.report('try!') { nil.try! { "bar" } }
  x.report('fast_try') { nil.fast_try { "bar" } }
  x.report('fast_try!') { nil.fast_try! { "bar" } }
  x.report('&.') { nil&.instance_eval { "bar" } }
  x.compare!
end




puts "nonexisting method"
Benchmark.ips do |x|
  x.report('try') { "foo".try(:foo) }
  x.report('fast_try') { "foo".fast_try(:foo) }
  x.compare!
end

puts "nonexisting method with args"
Benchmark.ips do |x|
  x.report('try') { "foo".try(:foo, :bar) }
  x.report('fast_try') { "foo".fast_try(:foo, :bar) }
  x.compare!
end

puts "method call"
Benchmark.ips do |x|
  x.report('try') { "foo".try(:size) }
  x.report('try!') { "foo".try!(:size) }
  x.report('fast_try') { "foo".fast_try(:size) }
  x.report('fast_try!') { "foo".fast_try!(:size) }
  x.report('&.') { "foo"&.size }
  x.compare!
end

puts "argument forwarding"
Benchmark.ips do |x|
  x.report('try') { "foo".try(:sub, "foo", "bar") }
  x.report('try!') { "foo".try!(:sub, "foo", "bar") }
  x.report('fast_try') { "foo".fast_try(:sub, "foo", "bar") }
  x.report('fast_try') { "foo".fast_try!(:sub, "foo", "bar") }
  x.report('&.') { "foo"&.sub("foo", "bar") }
  x.compare!
end

puts "block forwarding"
Benchmark.ips do |x|
  x.report('try') { "foo".try(:sub, "foo") { "bar" } }
  x.report('try!') { "foo".try!(:sub, "foo") { "bar" } }
  x.report('fast_try') { "foo".fast_try(:sub, "foo") { "bar" } }
  x.report('fast_try!') { "foo".fast_try!(:sub, "foo") { "bar" } }
  x.report('&.') { "foo"&.sub("foo") { "bar" } }
  x.compare!
end

puts "only block"
Benchmark.ips do |x|
  x.report('try') { "foo".try { "bar" } }
  x.report('try!') { "foo".try! { "bar" } }
  x.report('fast_try') { "foo".fast_try { "bar" } }
  x.report('fast_try!') { "foo".fast_try! { "bar" } }
  x.report('&.') { "foo"&.instance_eval { "bar" } }
  x.compare!
end
