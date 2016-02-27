package com.android.server.lights;

import android.content.Context;
import android.os.Handler;
import android.os.IHardwareService.Stub;
import android.os.Message;
import android.os.Trace;
import com.android.server.SystemService;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class LightsService extends SystemService {
    static final boolean DEBUG = false;
    static final String TAG = "LightsService";
    private Handler mH;
    private final Stub mLegacyFlashlightHack;
    final LightImpl[] mLights;
    private long mNativePointer;
    private final LightsManager mService;

    /* renamed from: com.android.server.lights.LightsService.1 */
    class C03351 extends Stub {
        private static final String FLASHLIGHT_FILE = "/sys/class/leds/spotlight/brightness";

        C03351() {
        }

        public boolean getFlashlightEnabled() {
            try {
                FileInputStream fis = new FileInputStream(FLASHLIGHT_FILE);
                int result = fis.read();
                fis.close();
                if (result != 48) {
                    return true;
                }
                return LightsService.DEBUG;
            } catch (Exception e) {
                return LightsService.DEBUG;
            }
        }

        public void setFlashlightEnabled(boolean on) {
            Context context = LightsService.this.getContext();
            if (context.checkCallingOrSelfPermission("android.permission.FLASHLIGHT") == 0 || context.checkCallingOrSelfPermission("android.permission.HARDWARE_TEST") == 0) {
                try {
                    FileOutputStream fos = new FileOutputStream(FLASHLIGHT_FILE);
                    byte[] bytes = new byte[2];
                    bytes[0] = (byte) (on ? 49 : 48);
                    bytes[1] = (byte) 10;
                    fos.write(bytes);
                    fos.close();
                    return;
                } catch (Exception e) {
                    return;
                }
            }
            throw new SecurityException("Requires FLASHLIGHT or HARDWARE_TEST permission");
        }
    }

    /* renamed from: com.android.server.lights.LightsService.2 */
    class C03362 extends LightsManager {
        C03362() {
        }

        public Light getLight(int id) {
            if (id < 8) {
                return LightsService.this.mLights[id];
            }
            return null;
        }
    }

    /* renamed from: com.android.server.lights.LightsService.3 */
    class C03373 extends Handler {
        C03373() {
        }

        public void handleMessage(Message msg) {
            msg.obj.stopFlashing();
        }
    }

    private final class LightImpl extends Light {
        private int mColor;
        private boolean mFlashing;
        private int mId;
        private int mMode;
        private int mOffMS;
        private int mOnMS;

        private LightImpl(int id) {
            this.mId = id;
        }

        public void setBrightness(int brightness) {
            setBrightness(brightness, 0);
        }

        public void setBrightness(int brightness, int brightnessMode) {
            synchronized (this) {
                int color = brightness & 255;
                setLightLocked(color | ((-16777216 | (color << 16)) | (color << 8)), 0, 0, 0, brightnessMode);
            }
        }

        public void setColor(int color) {
            synchronized (this) {
                setLightLocked(color, 0, 0, 0, 0);
            }
        }

        public void setFlashing(int color, int mode, int onMS, int offMS) {
            synchronized (this) {
                setLightLocked(color, mode, onMS, offMS, 0);
            }
        }

        public void pulse() {
            pulse(16777215, 7);
        }

        public void pulse(int color, int onMS) {
            synchronized (this) {
                if (this.mColor == 0 && !this.mFlashing) {
                    setLightLocked(color, 2, onMS, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, 0);
                    this.mColor = 0;
                    LightsService.this.mH.sendMessageDelayed(Message.obtain(LightsService.this.mH, 1, this), (long) onMS);
                }
            }
        }

        public void turnOff() {
            synchronized (this) {
                setLightLocked(0, 0, 0, 0, 0);
            }
        }

        private void stopFlashing() {
            synchronized (this) {
                setLightLocked(this.mColor, 0, 0, 0, 0);
            }
        }

        private void setLightLocked(int color, int mode, int onMS, int offMS, int brightnessMode) {
            if (color != this.mColor || mode != this.mMode || onMS != this.mOnMS || offMS != this.mOffMS) {
                this.mColor = color;
                this.mMode = mode;
                this.mOnMS = onMS;
                this.mOffMS = offMS;
                Trace.traceBegin(131072, "setLight(" + this.mId + ", " + color + ")");
                try {
                    LightsService.setLight_native(LightsService.this.mNativePointer, this.mId, color, mode, onMS, offMS, brightnessMode);
                } finally {
                    Trace.traceEnd(131072);
                }
            }
        }
    }

    private static native void finalize_native(long j);

    private static native long init_native();

    static native void setLight_native(long j, int i, int i2, int i3, int i4, int i5, int i6);

    public LightsService(Context context) {
        super(context);
        this.mLights = new LightImpl[8];
        this.mLegacyFlashlightHack = new C03351();
        this.mService = new C03362();
        this.mH = new C03373();
        this.mNativePointer = init_native();
        for (int i = 0; i < 8; i++) {
            this.mLights[i] = new LightImpl(i, null);
        }
    }

    public void onStart() {
        publishBinderService("hardware", this.mLegacyFlashlightHack);
        publishLocalService(LightsManager.class, this.mService);
    }

    protected void finalize() throws Throwable {
        finalize_native(this.mNativePointer);
        super.finalize();
    }
}
