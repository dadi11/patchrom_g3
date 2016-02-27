package android.graphics;

import android.view.inputmethod.EditorInfo;

@Deprecated
public class AvoidXfermode extends Xfermode {

    public enum Mode {
        AVOID(0),
        TARGET(1);
        
        final int nativeInt;

        private Mode(int nativeInt) {
            this.nativeInt = nativeInt;
        }
    }

    private static native long nativeCreate(int i, int i2, int i3);

    public AvoidXfermode(int opColor, int tolerance, Mode mode) {
        if (tolerance < 0 || tolerance > EditorInfo.IME_MASK_ACTION) {
            throw new IllegalArgumentException("tolerance must be 0..255");
        }
        this.native_instance = nativeCreate(opColor, tolerance, mode.nativeInt);
    }
}
