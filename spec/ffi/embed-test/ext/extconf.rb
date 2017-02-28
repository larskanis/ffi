#!/usr/bin/env ruby
#
# This file is part of ruby-ffi.
# For licensing, see LICENSE.SPECS
#

if !defined?(RUBY_ENGINE) || RUBY_ENGINE == 'ruby' || RUBY_ENGINE == 'rbx'
  require "mkmf"

  extension_name = "embed_test"
  dir_config(extension_name)
  create_makefile(extension_name)
end
