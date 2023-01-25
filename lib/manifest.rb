#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rexml/document'
require 'rexml/xpath'

#
# Process a Maven manifest to version information for this artefact.
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
class Manifest
  include REXML
  # Default contructor with source XML containing employees data
  def initialize
    @doc = nil
  end

  # Load versions from maven manifest (XML) document
  def load(file)
    raise unless File.exist?(file)

    @doc = Document.new(File.new(file))
    raise unless @doc
  end

  # Retrieve latest version from manifest
  def latest
    latest = XPath.first(@doc, '/metadata/versioning/latest')
    return unless latest

    latest.text
  end

  # Retrieve release version from manifest
  def release
    release = XPath.first(@doc, '/metadata/versioning/release')
    return unless release

    release.text
  end

  # Retrieve a list of versions from manifest
  def versions
    versions = XPath.each(@doc, '/metadata/versioning/versions/version')
    return unless versions

    versions.map(&:text)
  end
end
