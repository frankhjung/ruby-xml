require 'rake/clean'
require 'rdoc/task'
require 'rubocop/rake_task'

task default: :test
task cleanall: [:clean, :clobber]
task all: [:clean, :clobber, :check, :test, :doc]

tests = FileList.new('tests/test_*.rb')
srcs = FileList.new('main.rb', 'lib/*.rb')

desc 'Show help'
task :help do
  puts <<HELP
For Rakefile help call:
  rake -D
Or
  rake -T
To cleanup unused Gems use:
  bundle clean --force -V
HELP
end

desc 'Show bundle and Gem information'
task :info do
  # showing RVM information:
  system 'rvm info'
  # system 'rvm list'
  # showing Gem information:
  # system 'gem list --local'
  system 'gem environment'
  # showing bundle information
  system 'bundle list'
  puts 'Showing stale gems:'
  system 'gem stale'
end

desc 'Install bundles'
task :bundles do
  system 'bundle check'
  system 'bundle install'
  # system 'bundle update'
  system 'bundle list --verbose'
end

desc 'Check project syntax with RuboCop'
RuboCop::RakeTask.new(:check) do |task|
  # run standard syntax check first
  # ruby "-c #{srcs}"
  # files to check
  task.patterns = ['Rakefile'] + srcs + tests
  # report format: simple, progress, files, offenses, clang, disabled
  task.formatters = ['simple']
  # continue on finding errors
  task.fail_on_error = false
  # show it working
  task.verbose = true
end

desc 'Test classes'
task :test do
  tests.each do |test|
    ruby test
  end
end

desc 'Run script with test XML file (verbose)'
task :run do
  ruby 'main.rb -v --file data/test.xml'
end

desc 'Document project'
RDoc::Task.new(:doc) do |task|
  task.main = 'README.md'
  task.options << '--all'
  task.rdoc_dir = 'rdocs'
  task.rdoc_files.include(srcs + tests)
  # task.rdoc_files.include('CHANGES')
  task.rdoc_files.include('LICENSE')
  # task.rdoc_files.include('VERSION')
  task.title = ENV['title'] || 'Ruby Load XML Example'
end

CLEAN.include('**/*.bak', '**/*~')
CLOBBER.include('rdocs/', 'pkg/')
