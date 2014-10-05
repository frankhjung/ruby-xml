#!/usr/bin/env ruby
# coding: utf-8

# Load a properties file into a hash.
class LoadProperties
  # returns the complete properties file as a list
  attr_reader :as_list
  # returns just properties as a hash
  attr_reader :as_hash

  # Default constructor
  def initialize
    @as_list = []
    @as_hash = {}
  end

  # Parse a properties file
  # * Load cleansed lines into an array
  # * Load key values into a hash
  def parse(file)
    return unless File.file?(file)
    IO.foreach(file) do |line|
      work = line.strip
      if work.empty?
        next
      elsif '#' == work[0] then
        @as_list << work
      elsif work.include? '=' then
        k, v = work.split('=')
        append k, v
      end
    end
  end

  private

  # write only valid properties to list and hash
  def append(key, value)
    return unless key
    k = key.strip
    return unless k.length > 0
    v = value ? value.strip : ''
    @as_hash[k] = v
    @as_list << k + '=' + v
  end
end

#
# MAIN
#
loadprop = LoadProperties.new
loadprop.parse('test.properties')

# list
puts 'Show processed properties list:'
puts loadprop.as_list

# hash
hash = loadprop.as_hash
puts 'Show in key order:'
keys = hash.keys.sort
keys.each { |k| puts k + '=' + hash[k] }

puts 'Show in value order:'
inverted = hash.invert
values = inverted.keys.sort
values.each { |v| puts inverted[v] + '=' + v }
