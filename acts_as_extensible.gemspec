# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_extensible/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_extensible"
  s.version     = ActsAsExtensible::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Kittrell"]
  s.email       = ["ben@doodlekit.com"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "acts_as_extensible"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
