#!/usr/bin/env ruby

require_relative '../lib/manifest'
require 'minitest'
require 'minitest/autorun'

# Test manifest - a class to read and process an XML document.
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
class TestManifest < Minitest::Test
  # create manifest class and load test file
  def setup
    @manifest = Manifest.new
    assert_instance_of(Manifest, @manifest)
    file = File.expand_path('../data/maven-metadata.xml',
                            File.dirname(__FILE__))
    @manifest.load(File.new(file))
  end

  # load of bad file
  def test_bad_file
    file = 'bad_file'
    assert_raises RuntimeError do
      @manifest.load(file)
    end
  end

  # retrieve latest version from manifest
  def test_latest
    assert_equal('2.3.0', @manifest.latest)
    refute_kind_of(REXML::Element, @manifest.latest)
    assert_kind_of(String, @manifest.latest)
  end

  # retrieve release version from manifest
  def test_release
    assert_equal('2.3.0', @manifest.release)
    refute_kind_of(REXML::Element, @manifest.release)
    assert_kind_of(String, @manifest.release)
  end

  # retrieve list of versions from manifest
  def test_versions
    versions = @manifest.versions
    refute_nil(versions)
    assert_equal(13, versions.length)
    assert_equal('0.4.0', versions.sort[0])
    assert_equal('2.3.0', versions.sort[-1])
    assert_includes(versions, '1.3.2')
  end
end
