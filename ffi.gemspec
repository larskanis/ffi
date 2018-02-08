require File.expand_path("../lib/#{File.basename(__FILE__, '.gemspec')}/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'ffi'
  s.version = FFI::VERSION
  s.author = 'Wayne Meissner'
  s.email = 'wmeissner@gmail.com'
  s.homepage = 'http://wiki.github.com/ffi/ffi'
  s.summary = 'Ruby FFI'
  s.description = 'Ruby FFI library'
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f =~ /^(bench|gen|libtest|nbproject|spec)/
  end
  s.files += `git --git-dir ext/ffi_c/libffi/.git ls-files -z`.split("\x0").map do |f|
    File.join("ext/ffi_c/libffi", f)
  end
  s.files += %w[
          configure config.guess config.sub install-sh ltmain.sh missing
          fficonfig.h.in Makefile.in include/Makefile.in testsuite/Makefile.in
          man/Makefile.in doc/Makefile.in
  ].map do |f|
    File.join("ext/ffi_c/libffi", f)
  end
  s.extensions << 'ext/ffi_c/extconf.rb'
  s.has_rdoc = false
  s.rdoc_options = %w[--exclude=ext/ffi_c/.*\.o$ --exclude=ffi_c\.(bundle|so)$]
  s.license = 'BSD-3-Clause'
  s.require_paths << 'ext/ffi_c'
  s.required_ruby_version = '>= 1.9'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'rake-compiler', '~> 1.0'
  s.add_development_dependency 'rake-compiler-dock', '~> 0.6.2'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rubygems-tasks', "~> 0.2.4"
end
