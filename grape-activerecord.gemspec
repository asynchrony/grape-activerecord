# -*- encoding: utf-8 -*-
# stub: grape-activerecord 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name        = 'grape-activerecord'
  s.version     = '0.0.1'
  s.date        = '2014-01-15'
  s.summary     = "Manages ActiveRecord connection pool via before and after hooks."
  s.description = "This is created to address the common case where we need to add a before
and after filter in GrapeAPI to maintain ActiveRecord connection pools."
  s.authors     = ["Asynchrony Solutions"]
  s.email       = 'ionic-mobile@asynchrony.com'
  s.files       = Dir["lib/**/*"] + ["README.md", "LICENSE"]

  s.homepage    = 'https://github.com/asynchrony/grape-activerecord'
  s.license     = 'MIT'

  s.required_ruby_version = ">= 1.9.2"

  s.add_dependency "grape", ">= 0.6"
  s.add_dependency "activerecord", ">= 4.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", ">= 2.14"
  s.add_development_dependency "sqlite3"
end
