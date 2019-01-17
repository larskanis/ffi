if RUBY_ENGINE == 'jruby'
  require 'ffi/ffi_java'
else
  begin
    require RUBY_VERSION.split('.')[0, 2].join('.') + '/ffi_c'
  rescue Exception
    require 'ffi_c'
  end
end

require 'ffi/ffi'
