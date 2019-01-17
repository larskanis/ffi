
package ffi.jffi;

import com.kenai.jffi.CallContextCache;
import com.kenai.jffi.CallingConvention;
import org.jruby.Ruby;

/**
 * Holds information for creating JFFI functions
 */
class NativeFunctionInfo {
    final ffi.Type returnType;
    final ffi.Type[] parameterTypes;
    final com.kenai.jffi.Type jffiReturnType;
    final com.kenai.jffi.Type[] jffiParameterTypes;
    final com.kenai.jffi.CallingConvention convention;
    final com.kenai.jffi.CallContext callContext;

    public NativeFunctionInfo(Ruby runtime, ffi.Type returnType,
            ffi.Type[] parameterTypes, CallingConvention convention) {
        this.returnType = returnType;
        this.parameterTypes = parameterTypes;
        this.jffiReturnType = FFIUtil.getFFIType(returnType);
        if (jffiReturnType == null) {
            throw runtime.newTypeError("invalid FFI return type: " + returnType);
        }

        this.jffiParameterTypes = new com.kenai.jffi.Type[parameterTypes.length];
        for (int i = 0; i < parameterTypes.length; ++i) {
            jffiParameterTypes[i] = FFIUtil.getFFIType(parameterTypes[i]);
            if (jffiParameterTypes[i] == null) {
                throw runtime.newTypeError("invalid FFI parameter type: " + parameterTypes[i]);
            }
        }

        this.callContext = CallContextCache.getInstance().getCallContext(jffiReturnType, jffiParameterTypes, convention);
        this.convention = convention;
    }
}
