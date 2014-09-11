#!/usr/bin/rake

# References
#
# http://en.wikipedia.org/wiki/Rake_(software)
# http://www.ruby-doc.org/core-1.9.3/doc/rake/rakefile_rdoc.html

desc "build and test ruby load XML script"
task :default => :help

desc "Run loadxml help.\nFor Rakefile help call, rake -D"
task :help do
  ruby "loadxml.rb -h"
end

desc "Check Ruby script syntax"
task :check do
  ruby "-c -W2 loadxml.rb"
end

desc "Run script without parameters"
task :run do
  ruby "loadxml.rb"
end

desc "Run script with test XML file"
task :test => :run do
  ruby "loadxml.rb -v test.xml"
end

#EOF
