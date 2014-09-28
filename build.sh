#!/usr/bin/env bash

# Ruby build script that will:
#
# * prepare gem set
# * update bundles
# * invoke rake

# prepare version of Ruby environment
RVM_GEMSET=$(cat .ruby-version .ruby-gemset | tr "\\n" "@" | sed 's/@$//')
echo "Using ${RVM_GEMSET} gemset ..."
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm"
[[ -s /usr/local/rvm/scripts/rvm ]] && . /usr/local/rvm/scripts/rvm
rvm --create --install use ${RVM_GEMSET}

# prepare bundler
export BUNDLE_GEMFILE=${PWD}/Gemfile
which bundle | grep ${RVM_GEMSET} >/dev/null || gem install bundler --no-rdoc --no-ri
bundle check >/dev/null || bundle install

# run ruby build with parameters
bundle exec rake -f Rakefile $@
