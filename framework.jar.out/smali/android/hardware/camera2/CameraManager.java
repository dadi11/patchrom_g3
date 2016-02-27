package android.hardware.camera2;

import android.content.Context;
import android.hardware.CameraInfo;
import android.hardware.ICameraService;
import android.hardware.ICameraServiceListener.Stub;
import android.hardware.camera2.CameraDevice.StateCallback;
import android.hardware.camera2.impl.CameraDeviceImpl;
import android.hardware.camera2.impl.CameraMetadataNative;
import android.hardware.camera2.legacy.CameraDeviceUserShim;
import android.hardware.camera2.legacy.LegacyMetadataMapper;
import android.hardware.camera2.utils.BinderHolder;
import android.hardware.camera2.utils.CameraBinderDecorator;
import android.hardware.camera2.utils.CameraRuntimeException;
import android.hardware.camera2.utils.CameraServiceBinderDecorator;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.ArrayMap;
import android.util.Log;
import android.view.WindowManager.LayoutParams;
import java.util.ArrayList;

public final class CameraManager {
    private static final int API_VERSION_1 = 1;
    private static final int API_VERSION_2 = 2;
    private static final String TAG = "CameraManager";
    private static final int USE_CALLING_UID = -1;
    private final boolean DEBUG;
    private final Context mContext;
    private ArrayList<String> mDeviceIdList;
    private final Object mLock;

    public static abstract class AvailabilityCallback {
        public void onCameraAvailable(String cameraId) {
        }

        public void onCameraUnavailable(String cameraId) {
        }
    }

    private static final class CameraManagerGlobal extends Stub implements DeathRecipient {
        private static final String CAMERA_SERVICE_BINDER_NAME = "media.camera";
        public static final int STATUS_ENUMERATING = 2;
        public static final int STATUS_NOT_AVAILABLE = Integer.MIN_VALUE;
        public static final int STATUS_NOT_PRESENT = 0;
        public static final int STATUS_PRESENT = 1;
        private static final String TAG = "CameraManagerGlobal";
        private static final CameraManagerGlobal gCameraManager;
        private final boolean DEBUG;
        private final ArrayMap<AvailabilityCallback, Handler> mCallbackMap;
        private ICameraService mCameraService;
        private final ArrayMap<String, Integer> mDeviceStatus;
        private final Object mLock;

        /* renamed from: android.hardware.camera2.CameraManager.CameraManagerGlobal.1 */
        class C02131 implements Runnable {
            final /* synthetic */ AvailabilityCallback val$callback;
            final /* synthetic */ String val$id;

            C02131(AvailabilityCallback availabilityCallback, String str) {
                this.val$callback = availabilityCallback;
                this.val$id = str;
            }

            public void run() {
                this.val$callback.onCameraAvailable(this.val$id);
            }
        }

        /* renamed from: android.hardware.camera2.CameraManager.CameraManagerGlobal.2 */
        class C02142 implements Runnable {
            final /* synthetic */ AvailabilityCallback val$callback;
            final /* synthetic */ String val$id;

            C02142(AvailabilityCallback availabilityCallback, String str) {
                this.val$callback = availabilityCallback;
                this.val$id = str;
            }

            public void run() {
                this.val$callback.onCameraUnavailable(this.val$id);
            }
        }

        static {
            gCameraManager = new CameraManagerGlobal();
        }

        private CameraManagerGlobal() {
            this.DEBUG = Log.isLoggable(TAG, 3);
            this.mDeviceStatus = new ArrayMap();
            this.mCallbackMap = new ArrayMap();
            this.mLock = new Object();
        }

        public static CameraManagerGlobal get() {
            return gCameraManager;
        }

        public IBinder asBinder() {
            return this;
        }

        public ICameraService getCameraService() {
            ICameraService iCameraService;
            synchronized (this.mLock) {
                if (this.mCameraService == null) {
                    Log.i(TAG, "getCameraService: Reconnecting to camera service");
                    connectCameraServiceLocked();
                    if (this.mCameraService == null) {
                        Log.e(TAG, "Camera service is unavailable");
                    }
                }
                iCameraService = this.mCameraService;
            }
            return iCameraService;
        }

        private void connectCameraServiceLocked() {
            this.mCameraService = null;
            IBinder cameraServiceBinder = ServiceManager.getService(CAMERA_SERVICE_BINDER_NAME);
            if (cameraServiceBinder != null) {
                try {
                    cameraServiceBinder.linkToDeath(this, STATUS_NOT_PRESENT);
                    ICameraService cameraService = (ICameraService) CameraServiceBinderDecorator.newInstance(ICameraService.Stub.asInterface(cameraServiceBinder));
                    try {
                        CameraBinderDecorator.throwOnError(CameraMetadataNative.nativeSetupGlobalVendorTagDescriptor());
                    } catch (CameraRuntimeException e) {
                        handleRecoverableSetupErrors(e, "Failed to set up vendor tags");
                    }
                    try {
                        cameraService.addListener(this);
                        this.mCameraService = cameraService;
                    } catch (CameraRuntimeException e2) {
                        throw new IllegalStateException("Failed to register a camera service listener", e2.asChecked());
                    } catch (RemoteException e3) {
                    }
                } catch (RemoteException e4) {
                }
            }
        }

        private void handleRecoverableSetupErrors(CameraRuntimeException e, String msg) {
            int problem = e.getReason();
            switch (problem) {
                case STATUS_ENUMERATING /*2*/:
                    Log.w(TAG, msg + ": " + CameraAccessException.getDefaultMessage(problem));
                default:
                    throw new IllegalStateException(msg, e.asChecked());
            }
        }

        private boolean isAvailable(int status) {
            switch (status) {
                case STATUS_PRESENT /*1*/:
                    return true;
                default:
                    return false;
            }
        }

        private boolean validStatus(int status) {
            switch (status) {
                case STATUS_NOT_AVAILABLE /*-2147483648*/:
                case STATUS_NOT_PRESENT /*0*/:
                case STATUS_PRESENT /*1*/:
                case STATUS_ENUMERATING /*2*/:
                    return true;
                default:
                    return false;
            }
        }

        private void postSingleUpdate(AvailabilityCallback callback, Handler handler, String id, int status) {
            if (isAvailable(status)) {
                handler.post(new C02131(callback, id));
            } else {
                handler.post(new C02142(callback, id));
            }
        }

        private void updateCallbackLocked(AvailabilityCallback callback, Handler handler) {
            for (int i = STATUS_NOT_PRESENT; i < this.mDeviceStatus.size(); i += STATUS_PRESENT) {
                postSingleUpdate(callback, handler, (String) this.mDeviceStatus.keyAt(i), ((Integer) this.mDeviceStatus.valueAt(i)).intValue());
            }
        }

        private void onStatusChangedLocked(int status, String id) {
            if (this.DEBUG) {
                String str = TAG;
                Object[] objArr = new Object[STATUS_ENUMERATING];
                objArr[STATUS_NOT_PRESENT] = id;
                objArr[STATUS_PRESENT] = Integer.valueOf(status);
                Log.v(str, String.format("Camera id %s has status changed to 0x%x", objArr));
            }
            if (validStatus(status)) {
                Integer oldStatus = (Integer) this.mDeviceStatus.put(id, Integer.valueOf(status));
                if (oldStatus == null || oldStatus.intValue() != status) {
                    if (oldStatus == null || isAvailable(status) != isAvailable(oldStatus.intValue())) {
                        int callbackCount = this.mCallbackMap.size();
                        for (int i = STATUS_NOT_PRESENT; i < callbackCount; i += STATUS_PRESENT) {
                            postSingleUpdate((AvailabilityCallback) this.mCallbackMap.keyAt(i), (Handler) this.mCallbackMap.valueAt(i), id, status);
                        }
                        return;
                    } else if (this.DEBUG) {
                        str = TAG;
                        objArr = new Object[STATUS_ENUMERATING];
                        objArr[STATUS_NOT_PRESENT] = Boolean.valueOf(isAvailable(oldStatus.intValue()));
                        objArr[STATUS_PRESENT] = Boolean.valueOf(isAvailable(status));
                        Log.v(str, String.format("Device status was previously available (%b),  and is now again available (%b)so no new client visible update will be sent", objArr));
                        return;
                    } else {
                        return;
                    }
                } else if (this.DEBUG) {
                    str = TAG;
                    objArr = new Object[STATUS_PRESENT];
                    objArr[STATUS_NOT_PRESENT] = Integer.valueOf(status);
                    Log.v(str, String.format("Device status changed to 0x%x, which is what it already was", objArr));
                    return;
                } else {
                    return;
                }
            }
            str = TAG;
            objArr = new Object[STATUS_ENUMERATING];
            objArr[STATUS_NOT_PRESENT] = id;
            objArr[STATUS_PRESENT] = Integer.valueOf(status);
            Log.e(str, String.format("Ignoring invalid device %s status 0x%x", objArr));
        }

        public void registerAvailabilityCallback(AvailabilityCallback callback, Handler handler) {
            synchronized (this.mLock) {
                if (((Handler) this.mCallbackMap.put(callback, handler)) == null) {
                    updateCallbackLocked(callback, handler);
                }
            }
        }

        public void unregisterAvailabilityCallback(AvailabilityCallback callback) {
            synchronized (this.mLock) {
                this.mCallbackMap.remove(callback);
            }
        }

        public void onStatusChanged(int status, int cameraId) throws RemoteException {
            synchronized (this.mLock) {
                onStatusChangedLocked(status, String.valueOf(cameraId));
            }
        }

        public void binderDied() {
            synchronized (this.mLock) {
                if (this.mCameraService == null) {
                    return;
                }
                this.mCameraService = null;
                for (int i = STATUS_NOT_PRESENT; i < this.mDeviceStatus.size(); i += STATUS_PRESENT) {
                    onStatusChangedLocked(STATUS_PRESENT, (String) this.mDeviceStatus.keyAt(i));
                }
            }
        }
    }

    public CameraManager(Context context) {
        this.mLock = new Object();
        this.DEBUG = Log.isLoggable(TAG, 3);
        synchronized (this.mLock) {
            this.mContext = context;
        }
    }

    public String[] getCameraIdList() throws CameraAccessException {
        String[] strArr;
        synchronized (this.mLock) {
            strArr = (String[]) getOrCreateDeviceIdListLocked().toArray(new String[0]);
        }
        return strArr;
    }

    public void registerAvailabilityCallback(AvailabilityCallback callback, Handler handler) {
        if (handler == null) {
            Looper looper = Looper.myLooper();
            if (looper == null) {
                throw new IllegalArgumentException("No handler given, and current thread has no looper!");
            }
            handler = new Handler(looper);
        }
        CameraManagerGlobal.get().registerAvailabilityCallback(callback, handler);
    }

    public void unregisterAvailabilityCallback(AvailabilityCallback callback) {
        CameraManagerGlobal.get().unregisterAvailabilityCallback(callback);
    }

    public CameraCharacteristics getCameraCharacteristics(String cameraId) throws CameraAccessException {
        CameraCharacteristics characteristics;
        synchronized (this.mLock) {
            if (getOrCreateDeviceIdListLocked().contains(cameraId)) {
                int id = Integer.valueOf(cameraId).intValue();
                ICameraService cameraService = CameraManagerGlobal.get().getCameraService();
                if (cameraService == null) {
                    throw new CameraAccessException((int) API_VERSION_2, "Camera service is currently unavailable");
                }
                try {
                    if (supportsCamera2ApiLocked(cameraId)) {
                        CameraMetadataNative info = new CameraMetadataNative();
                        cameraService.getCameraCharacteristics(id, info);
                        characteristics = new CameraCharacteristics(info);
                    } else {
                        String[] outParameters = new String[API_VERSION_1];
                        cameraService.getLegacyParameters(id, outParameters);
                        String parameters = outParameters[0];
                        CameraInfo info2 = new CameraInfo();
                        cameraService.getCameraInfo(id, info2);
                        characteristics = LegacyMetadataMapper.createCharacteristics(parameters, info2);
                    }
                } catch (CameraRuntimeException e) {
                    throw e.asChecked();
                } catch (RemoteException e2) {
                    throw new CameraAccessException(API_VERSION_2, "Camera service is currently unavailable", e2);
                }
            }
            Object[] objArr = new Object[API_VERSION_1];
            objArr[0] = cameraId;
            throw new IllegalArgumentException(String.format("Camera id %s does not match any currently connected camera device", objArr));
        }
        return characteristics;
    }

    private CameraDevice openCameraDeviceUserAsync(String cameraId, StateCallback callback, Handler handler) throws CameraAccessException {
        CameraCharacteristics characteristics = getCameraCharacteristics(cameraId);
        try {
            CameraDevice device;
            synchronized (this.mLock) {
                ICameraDeviceUser cameraUser = null;
                CameraDevice deviceImpl = new CameraDeviceImpl(cameraId, callback, handler, characteristics);
                BinderHolder holder = new BinderHolder();
                ICameraDeviceCallbacks callbacks = deviceImpl.getCallbacks();
                int id = Integer.parseInt(cameraId);
                try {
                    if (supportsCamera2ApiLocked(cameraId)) {
                        ICameraService cameraService = CameraManagerGlobal.get().getCameraService();
                        if (cameraService == null) {
                            throw new CameraRuntimeException((int) API_VERSION_2, "Camera service is currently unavailable");
                        }
                        cameraService.connectDevice(callbacks, id, this.mContext.getPackageName(), USE_CALLING_UID, holder);
                        cameraUser = ICameraDeviceUser.Stub.asInterface(holder.getBinder());
                        deviceImpl.setRemoteDevice(cameraUser);
                        device = deviceImpl;
                    } else {
                        Log.i(TAG, "Using legacy camera HAL.");
                        cameraUser = CameraDeviceUserShim.connectBinderShim(callbacks, id);
                        deviceImpl.setRemoteDevice(cameraUser);
                        device = deviceImpl;
                    }
                } catch (CameraRuntimeException e) {
                    if (e.getReason() == LayoutParams.TYPE_APPLICATION_PANEL) {
                        throw new AssertionError("Should've gone down the shim path");
                    } else if (e.getReason() == 4 || e.getReason() == 5 || e.getReason() == API_VERSION_1 || e.getReason() == API_VERSION_2 || e.getReason() == 3) {
                        deviceImpl.setRemoteFailure(e);
                        if (e.getReason() == API_VERSION_1 || e.getReason() == API_VERSION_2) {
                            throw e.asChecked();
                        }
                    } else {
                        throw e;
                    }
                } catch (RemoteException e2) {
                    CameraRuntimeException ce = new CameraRuntimeException(API_VERSION_2, "Camera service is currently unavailable", e2);
                    deviceImpl.setRemoteFailure(ce);
                    throw ce.asChecked();
                }
            }
            return device;
        } catch (NumberFormatException e3) {
            throw new IllegalArgumentException("Expected cameraId to be numeric, but it was: " + cameraId);
        } catch (CameraRuntimeException e4) {
            throw e4.asChecked();
        }
    }

    public void openCamera(String cameraId, StateCallback callback, Handler handler) throws CameraAccessException {
        if (cameraId == null) {
            throw new IllegalArgumentException("cameraId was null");
        } else if (callback == null) {
            throw new IllegalArgumentException("callback was null");
        } else {
            if (handler == null) {
                if (Looper.myLooper() != null) {
                    handler = new Handler();
                } else {
                    throw new IllegalArgumentException("Looper doesn't exist in the calling thread");
                }
            }
            openCameraDeviceUserAsync(cameraId, callback, handler);
        }
    }

    private ArrayList<String> getOrCreateDeviceIdListLocked() throws CameraAccessException {
        if (this.mDeviceIdList == null) {
            ICameraService cameraService = CameraManagerGlobal.get().getCameraService();
            ArrayList<String> deviceIdList = new ArrayList();
            if (cameraService == null) {
                return deviceIdList;
            }
            try {
                int numCameras = cameraService.getNumberOfCameras();
                CameraMetadataNative info = new CameraMetadataNative();
                int i = 0;
                while (i < numCameras) {
                    boolean isDeviceSupported = false;
                    try {
                        cameraService.getCameraCharacteristics(i, info);
                        if (info.isEmpty()) {
                            throw new AssertionError("Expected to get non-empty characteristics");
                        }
                        isDeviceSupported = true;
                        if (isDeviceSupported) {
                            deviceIdList.add(String.valueOf(i));
                        } else {
                            Log.w(TAG, "Error querying camera device " + i + " for listing.");
                        }
                        i += API_VERSION_1;
                    } catch (IllegalArgumentException e) {
                    } catch (CameraRuntimeException e2) {
                        if (e2.getReason() != API_VERSION_2) {
                            throw e2.asChecked();
                        }
                    } catch (RemoteException e3) {
                        deviceIdList.clear();
                        return deviceIdList;
                    }
                }
                this.mDeviceIdList = deviceIdList;
            } catch (CameraRuntimeException e22) {
                throw e22.asChecked();
            } catch (RemoteException e4) {
                return deviceIdList;
            }
        }
        return this.mDeviceIdList;
    }

    private boolean supportsCamera2ApiLocked(String cameraId) {
        return supportsCameraApiLocked(cameraId, API_VERSION_2);
    }

    private boolean supportsCameraApiLocked(String cameraId, int apiVersion) {
        int id = Integer.parseInt(cameraId);
        try {
            ICameraService cameraService = CameraManagerGlobal.get().getCameraService();
            if (cameraService == null) {
                return false;
            }
            int res = cameraService.supportsCameraApi(id, apiVersion);
            if (res == 0) {
                return true;
            }
            throw new AssertionError("Unexpected value " + res);
        } catch (CameraRuntimeException e) {
            if (e.getReason() == LayoutParams.TYPE_APPLICATION_PANEL) {
                return false;
            }
            throw e;
        } catch (RemoteException e2) {
            return false;
        }
    }
}
