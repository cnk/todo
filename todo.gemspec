# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','todo','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'todo'
  s.version = Todo::VERSION
  s.author = 'Cynthia Kiser'
  s.email = 'cnk@caltech.edu'
  s.homepage = 'http://blog.cynthiakiser.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command-line to do application from Building Awesome Command-Line Applications in Ruby'
  s.description = 'Command line suite to create, list, and mark as done to do items in one or more to do lists.'
# Add your other files here if you make them
  s.files = %w(
bin/todo
lib/todo/version.rb
lib/todo.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options << '--title' << 'todo' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'todo'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.4.1')
end
