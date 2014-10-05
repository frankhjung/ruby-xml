#!/usr/bin/env ruby
# coding: utf-8

require_relative 'lib/employees'
require 'trollop'

#
# Command line options
#
opts = Trollop.options do
  version "#{File.basename($PROGRAM_NAME)} 0.1.0 © 2013 Frank H Jung"
  banner <<-USAGE

  NAME

  #{File.basename($PROGRAM_NAME)} - a Ruby example to show XML processing

  SYNOPSIS

  #{File.basename($PROGRAM_NAME)} [options] <filename>

  OPTIONS

  USAGE
  opt :verbose, 'Verbose output', default: false, short: '-v'
  opt :file, 'XML filename to read',
      default: 'test.xml', short: '-f', type: String
end

#
# MAIN
#

Trollop.die :file, 'must exist' unless File.exist?(opts[:file]) if opts[:file]

# load Employees data from XML
employees = Employees.new
employees.load(opts[:file])

# show for 2012
test = 0
turnover = employees.get_all_by_year(2012)
puts "(#{test+=1}) show a results for 2012 = #{turnover}\n"

# show for foo for 2011
turnover = employees.get_by_year('foo', 2011)
puts "(#{test+=1}) show results for foo in 2011 = #{turnover}\n"

# show for foo for 2012
turnover = employees.get_by_year('foo', 2012)
puts "(#{test+=1}) show results for foo in 2012 = #{turnover}\n"

# show for foo for 2013
turnover = employees.get_by_year('foo', 2013)
puts "(#{test+=1}) show results for foo in 2013 = #{turnover}\n"

# show for foo
turnover = employees.get_by_name('foo')
puts "(#{test+=1}) show results for foo (total) = #{turnover}\n"

# show for id = 003 = foo
turnover = employees.get_by_id('003')
puts "(#{test+=1}) show results for 003 (total) = #{turnover}\n"

#  dump xml file
if opts[:verbose]
  puts "(#{test+=1}) dump XML file\n"
  File.open(opts[:file], 'r') do |file|
    printf "\tContents of %s:\n", opts[:file]
    file.each_line { |line| puts "\t#{line}" }
  end
end
