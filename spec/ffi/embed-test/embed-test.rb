#!/usr/bin/env ruby
#
# This file is part of ruby-ffi.
# For licensing, see LICENSE.SPECS
#

# This test specifically avoids calling native code through FFI.
# Instead, the stock extension mechanism is used. The reason is
# that the C extension initializes FFI and then calls a callback
# which deadlocked in earlier FFI versions, see
# https://github.com/ffi/ffi/issues/527
 
EXT = File.expand_path("ext/embed_test.so", File.dirname(__FILE__))

old = Dir.pwd
Dir.chdir(File.dirname(EXT))

nul = File.open("/dev/null")
make = system('type gmake', { :out => nul, :err => nul }) && 'gmake' || 'make'

# create Makefile if nessary
load("extconf.rb", true) unless File.exists?("Makefile")

# compile if necessary
unless (system(make, "-q")) then
  output = system(make)
  if $?.exitstatus != 0
    puts "ERROR:\n#{output}"
    raise "Unable to compile \"#{lib}\""
  end
end

Dir.chdir(old)

require EXT
EmbedTest::testfunc
