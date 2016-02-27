package android.hardware.camera2.legacy;

import android.os.Process;
import android.util.AndroidException;
import android.widget.Toast;

public class LegacyExceptionUtils {
    private static final String TAG = "LegacyExceptionUtils";

    public static class BufferQueueAbandonedException extends AndroidException {
        public BufferQueueAbandonedException(String name) {
            super(name);
        }

        public BufferQueueAbandonedException(String name, Throwable cause) {
            super(name, cause);
        }

        public BufferQueueAbandonedException(Exception cause) {
            super(cause);
        }
    }

    public static int throwOnError(int errorFlag) throws BufferQueueAbandonedException {
        switch (errorFlag) {
            case Process.THREAD_PRIORITY_URGENT_AUDIO /*-19*/:
                throw new BufferQueueAbandonedException();
            case Toast.LENGTH_SHORT /*0*/:
                return 0;
            default:
                if (errorFlag >= 0) {
                    return errorFlag;
                }
                throw new UnsupportedOperationException("Unknown error " + errorFlag);
        }
    }

    private LegacyExceptionUtils() {
        throw new AssertionError();
    }
}
