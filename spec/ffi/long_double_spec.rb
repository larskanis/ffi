#
# This file is part of ruby-ffi.
# For licensing, see LICENSE.SPECS
#

require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))
require 'bigdecimal'

# long double not yet supported on TruffleRuby
describe ":long_double arguments and return values", if: RUBY_PLATFORM !~ /mingw|mswin/ do
  module LibTest
    extend FFI::Library
    ffi_lib TestLibrary::PATH
    attach_function :add_f128, [ :long_double, :long_double ], :long_double
    attach_function :ret_f128, [ :long_double ], :long_double
  end

  it "returns first parameter" do
    expect(LibTest.ret_f128(0.1)).to be_within(0.01).of(0.1)
  end

  it "returns first parameter with high precision", if: FFI::Platform::LONG_DOUBLE_SIZE > 64 do
    ld =        BigDecimal("1.234567890123456789")
    tolerance = BigDecimal("0.0000000000000000001")
    expect(LibTest.ret_f128(ld)).to be_within(tolerance).of(ld)
  end

  it "add two long double numbers" do
    expect(LibTest.add_f128(0.1, 0.2)).to be_within(0.01).of(0.3)
  end
end if RUBY_ENGINE != "truffleruby"
