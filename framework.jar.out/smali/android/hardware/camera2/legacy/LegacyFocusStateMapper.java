package android.hardware.camera2.legacy;

import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.AutoFocusMoveCallback;
import android.hardware.Camera.Parameters;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.utils.ParamsUtils;
import android.util.Log;
import android.widget.Toast;
import com.android.internal.util.Preconditions;
import java.util.Objects;

public class LegacyFocusStateMapper {
    private static String TAG;
    private static final boolean VERBOSE;
    private String mAfModePrevious;
    private int mAfRun;
    private int mAfState;
    private int mAfStatePrevious;
    private final Camera mCamera;
    private final Object mLock;

    /* renamed from: android.hardware.camera2.legacy.LegacyFocusStateMapper.1 */
    class C02621 implements AutoFocusMoveCallback {
        final /* synthetic */ String val$afMode;
        final /* synthetic */ int val$currentAfRun;

        C02621(int i, String str) {
            this.val$currentAfRun = i;
            this.val$afMode = str;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onAutoFocusMoving(boolean r8, android.hardware.Camera r9) {
            /*
            r7 = this;
            r3 = 1;
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;
            r4 = r2.mLock;
            monitor-enter(r4);
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;	 Catch:{ all -> 0x009c }
            r0 = r2.mAfRun;	 Catch:{ all -> 0x009c }
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.VERBOSE;	 Catch:{ all -> 0x009c }
            if (r2 == 0) goto L_0x0045;
        L_0x0014:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x009c }
            r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
            r5.<init>();	 Catch:{ all -> 0x009c }
            r6 = "onAutoFocusMoving - start ";
            r5 = r5.append(r6);	 Catch:{ all -> 0x009c }
            r5 = r5.append(r8);	 Catch:{ all -> 0x009c }
            r6 = " latest AF run ";
            r5 = r5.append(r6);	 Catch:{ all -> 0x009c }
            r5 = r5.append(r0);	 Catch:{ all -> 0x009c }
            r6 = ", last AF run ";
            r5 = r5.append(r6);	 Catch:{ all -> 0x009c }
            r6 = r7.val$currentAfRun;	 Catch:{ all -> 0x009c }
            r5 = r5.append(r6);	 Catch:{ all -> 0x009c }
            r5 = r5.toString();	 Catch:{ all -> 0x009c }
            android.util.Log.v(r2, r5);	 Catch:{ all -> 0x009c }
        L_0x0045:
            r2 = r7.val$currentAfRun;	 Catch:{ all -> 0x009c }
            if (r2 == r0) goto L_0x0068;
        L_0x0049:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x009c }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
            r3.<init>();	 Catch:{ all -> 0x009c }
            r5 = "onAutoFocusMoving - ignoring move callbacks from old af run";
            r3 = r3.append(r5);	 Catch:{ all -> 0x009c }
            r5 = r7.val$currentAfRun;	 Catch:{ all -> 0x009c }
            r3 = r3.append(r5);	 Catch:{ all -> 0x009c }
            r3 = r3.toString();	 Catch:{ all -> 0x009c }
            android.util.Log.d(r2, r3);	 Catch:{ all -> 0x009c }
            monitor-exit(r4);	 Catch:{ all -> 0x009c }
        L_0x0067:
            return;
        L_0x0068:
            if (r8 == 0) goto L_0x009f;
        L_0x006a:
            r1 = r3;
        L_0x006b:
            r5 = r7.val$afMode;	 Catch:{ all -> 0x009c }
            r2 = -1;
            r6 = r5.hashCode();	 Catch:{ all -> 0x009c }
            switch(r6) {
                case -194628547: goto L_0x00ab;
                case 910005312: goto L_0x00a1;
                default: goto L_0x0075;
            };	 Catch:{ all -> 0x009c }
        L_0x0075:
            switch(r2) {
                case 0: goto L_0x0095;
                case 1: goto L_0x0095;
                default: goto L_0x0078;
            };	 Catch:{ all -> 0x009c }
        L_0x0078:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x009c }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009c }
            r3.<init>();	 Catch:{ all -> 0x009c }
            r5 = "onAutoFocus - got unexpected onAutoFocus in mode ";
            r3 = r3.append(r5);	 Catch:{ all -> 0x009c }
            r5 = r7.val$afMode;	 Catch:{ all -> 0x009c }
            r3 = r3.append(r5);	 Catch:{ all -> 0x009c }
            r3 = r3.toString();	 Catch:{ all -> 0x009c }
            android.util.Log.w(r2, r3);	 Catch:{ all -> 0x009c }
        L_0x0095:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;	 Catch:{ all -> 0x009c }
            r2.mAfState = r1;	 Catch:{ all -> 0x009c }
            monitor-exit(r4);	 Catch:{ all -> 0x009c }
            goto L_0x0067;
        L_0x009c:
            r2 = move-exception;
            monitor-exit(r4);	 Catch:{ all -> 0x009c }
            throw r2;
        L_0x009f:
            r1 = 2;
            goto L_0x006b;
        L_0x00a1:
            r3 = "continuous-picture";
            r3 = r5.equals(r3);	 Catch:{ all -> 0x009c }
            if (r3 == 0) goto L_0x0075;
        L_0x00a9:
            r2 = 0;
            goto L_0x0075;
        L_0x00ab:
            r6 = "continuous-video";
            r5 = r5.equals(r6);	 Catch:{ all -> 0x009c }
            if (r5 == 0) goto L_0x0075;
        L_0x00b3:
            r2 = r3;
            goto L_0x0075;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.legacy.LegacyFocusStateMapper.1.onAutoFocusMoving(boolean, android.hardware.Camera):void");
        }
    }

    /* renamed from: android.hardware.camera2.legacy.LegacyFocusStateMapper.2 */
    class C02632 implements AutoFocusCallback {
        final /* synthetic */ String val$afMode;
        final /* synthetic */ int val$currentAfRun;

        C02632(int i, String str) {
            this.val$currentAfRun = i;
            this.val$afMode = str;
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onAutoFocus(boolean r10, android.hardware.Camera r11) {
            /*
            r9 = this;
            r5 = 2;
            r4 = 1;
            r2 = 0;
            r3 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;
            r6 = r3.mLock;
            monitor-enter(r6);
            r3 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;	 Catch:{ all -> 0x00a3 }
            r0 = r3.mAfRun;	 Catch:{ all -> 0x00a3 }
            r3 = android.hardware.camera2.legacy.LegacyFocusStateMapper.VERBOSE;	 Catch:{ all -> 0x00a3 }
            if (r3 == 0) goto L_0x0047;
        L_0x0016:
            r3 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x00a3 }
            r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a3 }
            r7.<init>();	 Catch:{ all -> 0x00a3 }
            r8 = "onAutoFocus - success ";
            r7 = r7.append(r8);	 Catch:{ all -> 0x00a3 }
            r7 = r7.append(r10);	 Catch:{ all -> 0x00a3 }
            r8 = " latest AF run ";
            r7 = r7.append(r8);	 Catch:{ all -> 0x00a3 }
            r7 = r7.append(r0);	 Catch:{ all -> 0x00a3 }
            r8 = ", last AF run ";
            r7 = r7.append(r8);	 Catch:{ all -> 0x00a3 }
            r8 = r9.val$currentAfRun;	 Catch:{ all -> 0x00a3 }
            r7 = r7.append(r8);	 Catch:{ all -> 0x00a3 }
            r7 = r7.toString();	 Catch:{ all -> 0x00a3 }
            android.util.Log.v(r3, r7);	 Catch:{ all -> 0x00a3 }
        L_0x0047:
            r3 = r9.val$currentAfRun;	 Catch:{ all -> 0x00a3 }
            if (r0 == r3) goto L_0x006e;
        L_0x004b:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x00a3 }
            r3 = "onAutoFocus - ignoring AF callback (old run %d, new run %d)";
            r4 = 2;
            r4 = new java.lang.Object[r4];	 Catch:{ all -> 0x00a3 }
            r5 = 0;
            r7 = r9.val$currentAfRun;	 Catch:{ all -> 0x00a3 }
            r7 = java.lang.Integer.valueOf(r7);	 Catch:{ all -> 0x00a3 }
            r4[r5] = r7;	 Catch:{ all -> 0x00a3 }
            r5 = 1;
            r7 = java.lang.Integer.valueOf(r0);	 Catch:{ all -> 0x00a3 }
            r4[r5] = r7;	 Catch:{ all -> 0x00a3 }
            r3 = java.lang.String.format(r3, r4);	 Catch:{ all -> 0x00a3 }
            android.util.Log.d(r2, r3);	 Catch:{ all -> 0x00a3 }
            monitor-exit(r6);	 Catch:{ all -> 0x00a3 }
        L_0x006d:
            return;
        L_0x006e:
            if (r10 == 0) goto L_0x00a6;
        L_0x0070:
            r1 = 4;
        L_0x0071:
            r7 = r9.val$afMode;	 Catch:{ all -> 0x00a3 }
            r3 = -1;
            r8 = r7.hashCode();	 Catch:{ all -> 0x00a3 }
            switch(r8) {
                case -194628547: goto L_0x00bb;
                case 3005871: goto L_0x00a8;
                case 103652300: goto L_0x00c5;
                case 910005312: goto L_0x00b1;
                default: goto L_0x007b;
            };	 Catch:{ all -> 0x00a3 }
        L_0x007b:
            r2 = r3;
        L_0x007c:
            switch(r2) {
                case 0: goto L_0x009c;
                case 1: goto L_0x009c;
                case 2: goto L_0x009c;
                case 3: goto L_0x009c;
                default: goto L_0x007f;
            };	 Catch:{ all -> 0x00a3 }
        L_0x007f:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.TAG;	 Catch:{ all -> 0x00a3 }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a3 }
            r3.<init>();	 Catch:{ all -> 0x00a3 }
            r4 = "onAutoFocus - got unexpected onAutoFocus in mode ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x00a3 }
            r4 = r9.val$afMode;	 Catch:{ all -> 0x00a3 }
            r3 = r3.append(r4);	 Catch:{ all -> 0x00a3 }
            r3 = r3.toString();	 Catch:{ all -> 0x00a3 }
            android.util.Log.w(r2, r3);	 Catch:{ all -> 0x00a3 }
        L_0x009c:
            r2 = android.hardware.camera2.legacy.LegacyFocusStateMapper.this;	 Catch:{ all -> 0x00a3 }
            r2.mAfState = r1;	 Catch:{ all -> 0x00a3 }
            monitor-exit(r6);	 Catch:{ all -> 0x00a3 }
            goto L_0x006d;
        L_0x00a3:
            r2 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x00a3 }
            throw r2;
        L_0x00a6:
            r1 = 5;
            goto L_0x0071;
        L_0x00a8:
            r4 = "auto";
            r4 = r7.equals(r4);	 Catch:{ all -> 0x00a3 }
            if (r4 == 0) goto L_0x007b;
        L_0x00b0:
            goto L_0x007c;
        L_0x00b1:
            r2 = "continuous-picture";
            r2 = r7.equals(r2);	 Catch:{ all -> 0x00a3 }
            if (r2 == 0) goto L_0x007b;
        L_0x00b9:
            r2 = r4;
            goto L_0x007c;
        L_0x00bb:
            r2 = "continuous-video";
            r2 = r7.equals(r2);	 Catch:{ all -> 0x00a3 }
            if (r2 == 0) goto L_0x007b;
        L_0x00c3:
            r2 = r5;
            goto L_0x007c;
        L_0x00c5:
            r2 = "macro";
            r2 = r7.equals(r2);	 Catch:{ all -> 0x00a3 }
            if (r2 == 0) goto L_0x007b;
        L_0x00ce:
            r2 = 3;
            goto L_0x007c;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.hardware.camera2.legacy.LegacyFocusStateMapper.2.onAutoFocus(boolean, android.hardware.Camera):void");
        }
    }

    static {
        TAG = "LegacyFocusStateMapper";
        VERBOSE = Log.isLoggable(TAG, 2);
    }

    public LegacyFocusStateMapper(Camera camera) {
        this.mAfStatePrevious = 0;
        this.mAfModePrevious = null;
        this.mLock = new Object();
        this.mAfRun = 0;
        this.mAfState = 0;
        this.mCamera = (Camera) Preconditions.checkNotNull(camera, "camera must not be null");
    }

    public void processRequestTriggers(CaptureRequest captureRequest, Parameters parameters) {
        int currentAfRun;
        Preconditions.checkNotNull(captureRequest, "captureRequest must not be null");
        int afTrigger = ((Integer) ParamsUtils.getOrDefault(captureRequest, CaptureRequest.CONTROL_AF_TRIGGER, Integer.valueOf(0))).intValue();
        String afMode = parameters.getFocusMode();
        if (!Objects.equals(this.mAfModePrevious, afMode)) {
            if (VERBOSE) {
                Log.v(TAG, "processRequestTriggers - AF mode switched from " + this.mAfModePrevious + " to " + afMode);
            }
            synchronized (this.mLock) {
                this.mAfRun++;
                this.mAfState = 0;
            }
            this.mCamera.cancelAutoFocus();
        }
        this.mAfModePrevious = afMode;
        synchronized (this.mLock) {
            currentAfRun = this.mAfRun;
        }
        AutoFocusMoveCallback afMoveCallback = new C02621(currentAfRun, afMode);
        Object obj = -1;
        switch (afMode.hashCode()) {
            case -194628547:
                if (afMode.equals(Parameters.FOCUS_MODE_CONTINUOUS_VIDEO)) {
                    obj = 3;
                    break;
                }
                break;
            case 3005871:
                if (afMode.equals(Parameters.WHITE_BALANCE_AUTO)) {
                    obj = null;
                    break;
                }
                break;
            case 103652300:
                if (afMode.equals(Parameters.FOCUS_MODE_MACRO)) {
                    obj = 1;
                    break;
                }
                break;
            case 910005312:
                if (afMode.equals(Parameters.FOCUS_MODE_CONTINUOUS_PICTURE)) {
                    obj = 2;
                    break;
                }
                break;
        }
        switch (obj) {
            case Toast.LENGTH_SHORT /*0*/:
            case Toast.LENGTH_LONG /*1*/:
            case Action.MERGE_IGNORE /*2*/:
            case SetDrawableParameters.TAG /*3*/:
                this.mCamera.setAutoFocusMoveCallback(afMoveCallback);
                break;
        }
        switch (afTrigger) {
            case Toast.LENGTH_SHORT /*0*/:
            case Toast.LENGTH_LONG /*1*/:
                int afStateAfterStart;
                obj = -1;
                switch (afMode.hashCode()) {
                    case -194628547:
                        if (afMode.equals(Parameters.FOCUS_MODE_CONTINUOUS_VIDEO)) {
                            obj = 3;
                            break;
                        }
                        break;
                    case 3005871:
                        if (afMode.equals(Parameters.WHITE_BALANCE_AUTO)) {
                            obj = null;
                            break;
                        }
                        break;
                    case 103652300:
                        if (afMode.equals(Parameters.FOCUS_MODE_MACRO)) {
                            obj = 1;
                            break;
                        }
                        break;
                    case 910005312:
                        if (afMode.equals(Parameters.FOCUS_MODE_CONTINUOUS_PICTURE)) {
                            obj = 2;
                            break;
                        }
                        break;
                }
                switch (obj) {
                    case Toast.LENGTH_SHORT /*0*/:
                    case Toast.LENGTH_LONG /*1*/:
                        afStateAfterStart = 3;
                        break;
                    case Action.MERGE_IGNORE /*2*/:
                    case SetDrawableParameters.TAG /*3*/:
                        afStateAfterStart = 1;
                        break;
                    default:
                        afStateAfterStart = 0;
                        break;
                }
                synchronized (this.mLock) {
                    currentAfRun = this.mAfRun + 1;
                    this.mAfRun = currentAfRun;
                    this.mAfState = afStateAfterStart;
                    break;
                }
                if (VERBOSE) {
                    Log.v(TAG, "processRequestTriggers - got AF_TRIGGER_START, new AF run is " + currentAfRun);
                }
                if (afStateAfterStart != 0) {
                    this.mCamera.autoFocus(new C02632(currentAfRun, afMode));
                }
            case Action.MERGE_IGNORE /*2*/:
                synchronized (this.mLock) {
                    int updatedAfRun;
                    synchronized (this.mLock) {
                        updatedAfRun = this.mAfRun + 1;
                        this.mAfRun = updatedAfRun;
                        this.mAfState = 0;
                        break;
                    }
                    this.mCamera.cancelAutoFocus();
                    if (VERBOSE) {
                        Log.v(TAG, "processRequestTriggers - got AF_TRIGGER_CANCEL, new AF run is " + updatedAfRun);
                    }
                    break;
                }
            default:
                Log.w(TAG, "processRequestTriggers - ignoring unknown control.afTrigger = " + afTrigger);
        }
    }

    public void mapResultTriggers(CameraMetadataNative result) {
        int newAfState;
        Preconditions.checkNotNull(result, "result must not be null");
        synchronized (this.mLock) {
            newAfState = this.mAfState;
        }
        if (VERBOSE && newAfState != this.mAfStatePrevious) {
            Log.v(TAG, String.format("mapResultTriggers - afState changed from %s to %s", new Object[]{afStateToString(this.mAfStatePrevious), afStateToString(newAfState)}));
        }
        result.set(CaptureResult.CONTROL_AF_STATE, Integer.valueOf(newAfState));
        this.mAfStatePrevious = newAfState;
    }

    private static String afStateToString(int afState) {
        switch (afState) {
            case Toast.LENGTH_SHORT /*0*/:
                return "INACTIVE";
            case Toast.LENGTH_LONG /*1*/:
                return "PASSIVE_SCAN";
            case Action.MERGE_IGNORE /*2*/:
                return "PASSIVE_FOCUSED";
            case SetDrawableParameters.TAG /*3*/:
                return "ACTIVE_SCAN";
            case ViewGroupAction.TAG /*4*/:
                return "FOCUSED_LOCKED";
            case ReflectionActionWithoutParams.TAG /*5*/:
                return "NOT_FOCUSED_LOCKED";
            case SetEmptyView.TAG /*6*/:
                return "PASSIVE_UNFOCUSED";
            default:
                return "UNKNOWN(" + afState + ")";
        }
    }
}
