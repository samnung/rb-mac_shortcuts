# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'mac_shortcuts/version'


Gem::Specification.new do |s|
  s.name        = 'mac_shortcuts'
  s.version     = MacShortcuts::VERSION
  s.summary     = 'Command line tool to modify custom shortcuts in Mac applications.'
  s.description = "Command line tool to modify custom shortcuts in Mac applications.\n"
                  'For now just adding.'
  s.authors     = ['Roman Kříž']
  s.email       = 'roman@kriz.io'

  s.homepage    = 'https://github.com/samnung/rb-mac_shortcuts'
  s.license     = 'MIT'

  s.files       = Dir['bin/**/*'] + Dir['lib/**/*'] + ["#{s.name}.gemspec"]
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  s.add_runtime_dependency 'claide', '~> 0.8'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rspec', '~> 3.2'
end
