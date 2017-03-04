# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rt_bart/version'

Gem::Specification.new do |spec|
  spec.name          = "rt_bart"
  spec.version       = RtBart::VERSION
  spec.authors       = ["bentonwong"]
  spec.email         = ["bentonwong@gmail.com"]

  spec.summary       = %q{Real time BART.gov departure information from CLI interface}
  spec.description   = %q{This gem will provide a simple and quick way to get real time departures and individual station information from a CLI interface for every station in the Bay Area Rapid Transit (BART) system.}
  spec.homepage      = "https://github.com/bentonwong/rt_bart"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "exe"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
