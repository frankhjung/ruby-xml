#!/usr/bin/env ruby
# coding: utf-8

require 'rexml/document'

#
# Process employees from XML source.
#
# Could also use REXML::XPath, but this is simple enough as is.
#
# To do thi include this declaration:
#
#   require 'rexml/xpath'
#
# Author:: Frank Jung
# License:: see LICENSE
#
# = References
#
# * REXML
#
#   http://ruby-doc.org/stdlib-1.9.3/libdoc/rexml/rdoc/REXML.html
#
class Employees
  include REXML
  # Default contructor with source XML containing employees data
  def initialize
    @doc = nil
  end

  # Load employees data from XML
  def load(file)
    fail unless File.exist?(file)
    @doc = Document.new(file)
    fail unless @doc
  end

  # Get employee turnover by id
  def get_by_id(id)
    turnovers =
      @doc.elements.to_a("/company/employee[@id='#{id}']/turnover/year")
    return if turnovers.empty?
    turnovers.map { |t| t.text.to_i }.reduce(:+)
  end

  # Get employee turnover by name
  def get_by_name(name)
    turnovers =
      @doc.elements.to_a("/company/employee[@name='#{name}']/turnover/year")
    return if turnovers.empty?
    turnovers.map { |t| t.text.to_i }.reduce(:+)
  end

  # Get an employee turnover for year
  def get_by_year(name, year)
    turnovers =
      @doc
      .elements
      .to_a("/company/employee[@name='#{name}']/turnover/year[@id='#{year}']")
    return if turnovers.empty?
    turnovers.map { |t| t.text.to_i }.reduce(:+)
  end

  # Get all employee turnover for year
  def get_all_by_year(year)
    turnovers =
      @doc.elements.to_a("/company/employee/turnover/year[@id='#{year}']")
    return if turnovers.empty?
    turnovers.map { |t| t.text.to_i }.reduce(:+)
  end
end
