Gem::Specification.new do |spec|
  spec.name          = "ctry"
  spec.version       = "0.0.1"
  spec.authors       = ["Seiei Miyagi"]
  spec.email         = ["hanachin@gmail.com"]

  spec.summary       = %q{try/try! implementation}
  spec.homepage      = "https://github.com/yasslab/ctry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/ctry/extconf.rb"]

  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "benchmark-ips"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
end
