# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','pandook','version.rb'])
spec = Gem::Specification.new do |s|
  s.name             = 'pandook'
  s.version          = Pandook::VERSION
  s.author           = 'Xiao Hanyu'
  s.email            = 'xiaohanyu1988@gmail.com'
  s.homepage         = 'http://pandook.com'
  s.license          = 'MIT'
  s.platform         = Gem::Platform::RUBY
  s.summary          = 'pandook == pandoc + book'
  s.files            = `git ls-files`.split("\n")
  s.require_paths << 'lib'
  s.has_rdoc         = true
  s.extra_rdoc_files = ['README.org','pandook.rdoc']
  s.rdoc_options << '--title' << 'pandook' << '--main' << 'README.rdoc' << '-ri'
  s.bindir           = 'bin'
  s.executables << 'pandook'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.13.4')
end
