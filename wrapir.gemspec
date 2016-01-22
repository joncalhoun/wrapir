# $:.unshift(File.join(File.dirname(__FILE__), 'lib'))

spec = Gem::Specification.new do |s|
  s.name = 'wrapir'
  s.summary = 'A Ruby DSL for creating API libraries'
  s.description = ''
  s.homepage = 'https://www.github.com/joncalhoun/wrapir'
  s.authors = ['Jon Calhoun']
  s.email = ['joncalhoun@gmail.com']
  s.version = '1.0.0'
  s.license = 'MIT'

  s.files = Dir["**/*"] - Dir["*.gem"] - Dir["bin/**/*"] - Dir["bin"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ['lib']

  # s.add_dependency('wrapir', '~> 0.0.0')
  # s.add_dependency('mime-types', '>= 1.25', '< 3.0')
  # s.add_dependency('json', '~> 1.8.1')

  s.add_development_dependency('mocha', '~> 0.13.2')
  s.add_development_dependency('shoulda', '~> 3.4.0')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('rake')
end

