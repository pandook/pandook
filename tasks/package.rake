require 'rubygems'
require 'rubygems/package_task'

spec = eval(File.read('pandook.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end
