#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/employees'
require 'minitest'
require 'minitest/autorun'
# require 'version'

# Test Employees class to read and process an XML document.
#
# Author:: Frank Jung
# License:: see LICENSE
#
# = References
#
# * Tested with:
#
#   ruby 1.9.3p484 (2013-11-22 revision 43786) [x86_64-linux].
#   ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-linux]
#
# * MiniTest:
#
#   https://github.com/seattlerb/minitest
#
class TestEmployees < Minitest::Test
  # create employees class and load testfile
  def setup
    @employees = Employees.new
    assert_instance_of(Employees, @employees)
    file = File.expand_path('../data/test.xml', File.dirname(__FILE__))
    @employees.load(File.new(file))
  end

  # load of bad file
  def test_bad_file
    file = 'bad_file'
    assert_raises RuntimeError do
      @employees.load(file)
    end
  end

  # get good employee by id
  def test_good_by_id
    assert_equal(440_000, @employees.get_by_id('003'))
  end

  # get bad employee by id
  def test_bad_by_id
    assert_equal(nil, @employees.get_by_id('007'))
  end

  # get good employee by name
  def test_good_by_name
    assert_equal(560_000, @employees.get_by_name('bar'))
  end

  # get bad employee by name
  def test_bad_by_name
    assert_equal(nil, @employees.get_by_name('xxx'))
  end

  # get good employee by year
  def test_good_by_year
    assert_equal(140_000, @employees.get_by_year('foo', 2012))
    assert_equal(140_000, @employees.get_by_year('foo', '2012'))
  end

  # get bad employee by year
  def test_bad_by_year
    assert_equal(nil, @employees.get_by_year('foo', 2008))
    assert_equal(nil, @employees.get_by_year('xxx', 2012))
  end

  # get good all by year
  def test_good_all_by_year
    assert_equal(270_000, @employees.get_all_by_year(2012))
    assert_equal(270_000, @employees.get_all_by_year('2012'))
  end

  # get bad all by year
  def test_bad_all_by_year
    assert_equal(nil, @employees.get_all_by_year(2008))
    assert_equal(nil, @employees.get_all_by_year('2008'))
  end
end
