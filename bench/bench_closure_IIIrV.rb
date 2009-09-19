require File.expand_path(File.join(File.dirname(__FILE__), "bench_helper"))

module LibTest
  extend FFI::Library
  ffi_lib LIBTEST_PATH
  callback :closureIIIrV, [ :int, :int, :int ], :void
  attach_function :ffi_bench, :testClosureIIIrV, [ :closureIIIrV, :int, :int, :int ], :void
  def self.rb_bench(&block); yield; end
end
unless RUBY_PLATFORM == "java" && JRUBY_VERSION < "1.3.0"
  require 'dl'
  require 'dl/import'
  module LibTest
    if RUBY_VERSION >= "1.9.0"
      extend DL::Importer
    else
      extend DL::Importable
    end
    dlload LIBTEST_PATH
    extern "int returnInt()"
  end
end

puts "Benchmark [ ], :void closure block performance, #{ITER}x calls"
10.times {
  puts Benchmark.measure {
    ITER.times { LibTest.ffi_bench(1, 2, 3) { } }
  }
}

puts "Benchmark [ ], :void pre-allocated function performance, #{ITER}x calls"
10.times {
  fn = FFI::Function.new(:void, [ :int, :int, :int ]) {}
  puts Benchmark.measure {
    ITER.times { LibTest.ffi_bench(fn, 1, 2, 3) }
  }
}

#unless RUBY_PLATFORM == "java" && JRUBY_VERSION < "1.3.0"
#puts "Benchmark DL void bench() performance, #{ITER}x calls"
#10.times {
#  puts Benchmark.measure {
#    ITER.times { LibTest.returnInt }
#  }
#}
#end

puts "Benchmark ruby method(no arg)  performance, #{ITER}x calls"
10.times {
  puts Benchmark.measure {
    ITER.times { LibTest.rb_bench {} }
  }
}

