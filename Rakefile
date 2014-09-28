#!/usr/bin/rake

# References
#
# https://rubygems.org/gems/rake
# http://en.wikipedia.org/wiki/Rake_(software)
# http://www.ruby-doc.org/core-1.9.3/doc/rake/rakefile_rdoc.html

require 'rake/clean'
require 'rdoc/task'
require 'rubocop/rake_task'

srcs = FileList.new('*.rb', 'Rakefile')
desc 'build and test ruby load XML script'
task default: :run

desc 'Show help'
task :help do
  puts <<HELP
For Rakefile help call:
  rake -D
Or
  rake -T
To cleanup unused Gems use:
  bundle clean --force -V
Using
  test.xml - as test file
HELP
  ruby 'loadxml.rb -h'
end

desc 'Show bundle and Gem information'
task :info do
  system 'gem environment'
  system 'bundle list'
  puts 'Showing stale gems:'
  system 'gem stale'
end

desc 'Run script without parameters'
task :run do
  ruby 'loadxml.rb'
end

desc 'Run script with test XML file'
task test: :check do
  ruby 'loadxml.rb -v test.xml'
end

desc 'Check project syntax'
RuboCop::RakeTask.new(:check) do |task|
  # run standard syntax check first
  ruby "-c #{srcs}"
  # files to check
  task.patterns = srcs
  # show failures in simple format
  task.formatters = ['simple']
  # continue on finding errors
  task.fail_on_error = false
  # show it working
  task.verbose = true
end

desc 'Document project'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.main = 'README.md'
  rdoc.options << '--all'
  rdoc.rdoc_dir = 'rdocs'
  # rdoc.rdoc_files.include('CHANGES')
  # rdoc.rdoc_files.include('LICENSE')
  # rdoc.rdoc_files.include('VERSION')
  rdoc.title = ENV['title'] || 'Ruby Load XML Example'
end
