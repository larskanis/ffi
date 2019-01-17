package ffi.jffi;

import com.kenai.jffi.ObjectParameterType;
import ffi.MemoryIO;
import ffi.MemoryObject;

/**
 *
 */
final class MemoryObjectParameterStrategy extends PointerParameterStrategy {
    MemoryObjectParameterStrategy(boolean isDirect) {
        super(isDirect, false, ObjectParameterType.create(ObjectParameterType.ARRAY, ObjectParameterType.ComponentType.BYTE));
    }

    public final MemoryIO getMemoryIO(Object parameter) {
        return ((MemoryObject) parameter).getMemoryIO();
    }
}
