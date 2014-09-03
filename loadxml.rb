#!/usr/bin/env ruby
# coding: utf-8

require 'json'
require 'trollop'
require 'xmlsimple'

#
# Command line options
#

opts = Trollop::options do
    version "#{File.basename($0)} 0.0.1 © 2013 Frank H Jung"
    banner <<-USAGE
    
NAME

    #{File.basename($0)} - a Ruby example program to show XML processing

SYNOPSIS

    #{File.basename($0)} [options] <filename>

OPTIONS
    
USAGE
    opt :verbose, "Verbose output", :default => false, :short => '-v'
    opt :file, "XML filename to read", :default => 'test.xml', :short => '-f', :type => String
end

Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]

#
# MAIN
# 

# read in xml document
companies = XmlSimple.xml_in(opts[:file], { 
    'KeyAttr' => 'name',
    'ForceArray' => [ 'year' ],
    'ContentKey' => '-content' 
})

# show a specific year
puts "(1) show a specific year\n"
turnover = companies['turnover']['year'].find { |year| year['id'] == "2012"}
puts "\tYear 2012 has turnover of #{turnover['content']}\n\n"

# show all years
puts "(2) show all years\n"
companies['turnover']['year'].each { |year| 
    puts "\tYear #{year['id']} has turnover of #{year['content']}\n"
}
puts "\n"

#  dump xml file
if opts[:verbose]
    puts "(3) dump XML file\n"
    File.open(opts[:file], 'r') do | xmlDoc |
        puts "\tContents of #{opts[:file]}:"
        xmlDoc.each_line { |line| puts "\t#{line}" }
    end
    puts "\n"
end

# dump xml document
if opts[:verbose]
    puts "(4) Dump the XML that was read\n"
    puts JSON.pretty_generate(companies)
end
