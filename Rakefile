#!/usr/bin/rake

desc "build and test ruby load XML script"
task :default => :help

desc "Run loadxml help.\nFor Rakefile help call, rake -D"

task :help do
    ruby "loadxml.rb -h"
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
