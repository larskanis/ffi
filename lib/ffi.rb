if RUBY_ENGINE == 'jruby'
  require 'ffi_java'
  # TODO: this class should be loaded automatically
  org.jruby.ext.ffi.FfiJavaService.new.basicLoad(JRuby.runtime)
else
  begin
    require RUBY_VERSION.split('.')[0, 2].join('.') + '/ffi_c'
  rescue Exception
    require 'ffi_c'
  end
end

require 'ffi/ffi'
