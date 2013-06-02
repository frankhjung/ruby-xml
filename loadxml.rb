#!/usr/bin/ruby -w

# global
require 'rubygems'
require 'bundler/setup'

# local to application
require 'json'
require 'trollop'
require 'xmlsimple'

opts = Trollop::options do
  version "loadxml 0.0.1 (c) 2013 Frank H Jung"
  banner <<-USAGE
    
NAME

    loadxml - a Ruby example program to show XML processing

SYNOPSIS

    loadxml [options] <filename>

OPTIONS
    
USAGE
# options
    opt :verbose, "Verbose output", :default => false, :short => '-v'
    opt :file, "XML filename to read", :default => 'test.xml', :short => '-f', :type => String
end

Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]

#
# MAIN
# 

verbose = opts[:verbose]
filename = opts[:file]
example = 0

#  dump xml file
if verbose
    example += 1
    puts "(#{example}) dump xml file\n"
    File.open(filename, 'r') do | xmlDoc |
        puts "\tContents of #{filename}:"
        xmlDoc.each_line { |line| puts "\t#{line.dump}\n" }
    end
end

# read in xml document
companies = XmlSimple.xml_in(filename, { 
    'KeyAttr' => 'name',
    'ForceArray' => [ 'year' ],
    'ContentKey' => '-content' 
})
# dump xml document
if verbose
    example += 1
    puts "(#{example}) Dump the XML that was read\n"
    puts JSON.pretty_generate(companies)
    puts "\n"
end

# show a specific year
example += 1
puts "(#{example}) show a specific year\n"
turnover = companies['turnover']['year'].find { |year| year['id'] == "2012"}
puts "\tYear 2012 has turnover of #{turnover['content']}\n\n"

# show all years
example += 1
puts "(#{example}) show all years\n"
companies['turnover']['year'].each { |year| 
    puts "\tYear #{year['id']} has turnover of #{year['content']}\n"
}
puts "\n"
