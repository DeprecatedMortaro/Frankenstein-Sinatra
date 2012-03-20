# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "frankenstein-sinatra/version"

Gem::Specification.new do |s|

  s.name        = "frankenstein-sinatra"
  s.version     = FrankensteinSinatra::VERSION
  s.authors     = ["Christian Mortaro"]
  s.email       = ["mortaro@towsta.com"]
  s.homepage    = ""
  s.summary     = "Sinatra is a new kind of monster!"
  s.description = "Aditional flesh for frank sinatra's body"

  s.rubyforge_project = "frankenstein-sinatra"

  s.add_dependency "json"
  s.add_dependency "compass"
  s.add_dependency "haml"
  s.add_dependency "sinatra"
  s.add_dependency "i18n-router"
  s.add_dependency "pony"
  s.add_dependency "coffee-script"
  s.add_dependency "active_support"

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'shotgun'
  s.add_development_dependency 'heroku'


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
