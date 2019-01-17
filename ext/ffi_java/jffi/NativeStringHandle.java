package ffi.jffi;

import ffi.MemoryIO;
import org.jruby.util.ByteList;

/**
*
*/
final class NativeStringHandle {
    final ByteList bl;
    final MemoryIO memory;

    NativeStringHandle(MemoryIO memory, ByteList bl) {
        this.memory = memory;
        this.bl = bl;
    }
}
