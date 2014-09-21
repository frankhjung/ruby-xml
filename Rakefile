#!/usr/bin/rake

# References
#
# https://rubygems.org/gems/rake
# http://en.wikipedia.org/wiki/Rake_(software)
# http://www.ruby-doc.org/core-1.9.3/doc/rake/rakefile_rdoc.html

require 'rake/clean'

desc 'build and test ruby load XML script'
task default: :help

desc "Run loadxml help.\nFor Rakefile help call, rake -D"
task :help do
  ruby 'loadxml.rb -h'
end

desc 'Check Ruby script syntax'
task :check do
  ruby '-c -w loadxml.rb'
  system 'rubocop Rakefile loadxml.rb'
end

desc 'Run script without parameters'
task run: :check do
  ruby 'loadxml.rb'
end

desc 'Run script with test XML file'
task test: :run do
  ruby 'loadxml.rb -v test.xml'
end
