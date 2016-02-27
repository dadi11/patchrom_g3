package android.os.storage;

import android.content.ContentResolver;
import android.content.Context;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Parcelable;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.storage.IMountServiceListener.Stub;
import android.provider.Settings.Global;
import android.util.Log;
import android.util.SparseArray;
import com.android.internal.util.Preconditions;
import com.google.android.collect.Lists;
import java.io.File;
import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class StorageManager {
    public static final int CRYPT_TYPE_DEFAULT = 1;
    public static final int CRYPT_TYPE_PASSWORD = 0;
    public static final int CRYPT_TYPE_PATTERN = 2;
    public static final int CRYPT_TYPE_PIN = 3;
    private static final long DEFAULT_FULL_THRESHOLD_BYTES = 1048576;
    private static final long DEFAULT_THRESHOLD_MAX_BYTES = 524288000;
    private static final int DEFAULT_THRESHOLD_PERCENTAGE = 10;
    public static final String OWNER_INFO_KEY = "OwnerInfo";
    public static final String PATTERN_VISIBLE_KEY = "PatternVisible";
    public static final String SYSTEM_LOCALE_KEY = "SystemLocale";
    private static final String TAG = "StorageManager";
    private MountServiceBinderListener mBinderListener;
    private List<ListenerDelegate> mListeners;
    private final IMountService mMountService;
    private final AtomicInteger mNextNonce;
    private final ObbActionListener mObbActionListener;
    private final ContentResolver mResolver;
    private final Looper mTgtLooper;

    private class ListenerDelegate {
        private final Handler mHandler;
        final StorageEventListener mStorageEventListener;

        /* renamed from: android.os.storage.StorageManager.ListenerDelegate.1 */
        class C06251 extends Handler {
            final /* synthetic */ StorageManager val$this$0;

            C06251(Looper x0, StorageManager storageManager) {
                this.val$this$0 = storageManager;
                super(x0);
            }

            public void handleMessage(Message msg) {
                StorageEvent e = msg.obj;
                if (msg.what == StorageManager.CRYPT_TYPE_DEFAULT) {
                    ListenerDelegate.this.mStorageEventListener.onUsbMassStorageConnectionChanged(((UmsConnectionChangedStorageEvent) e).available);
                } else if (msg.what == StorageManager.CRYPT_TYPE_PATTERN) {
                    StorageStateChangedStorageEvent ev = (StorageStateChangedStorageEvent) e;
                    ListenerDelegate.this.mStorageEventListener.onStorageStateChanged(ev.path, ev.oldState, ev.newState);
                } else {
                    Log.e(StorageManager.TAG, "Unsupported event " + msg.what);
                }
            }
        }

        ListenerDelegate(StorageEventListener listener) {
            this.mStorageEventListener = listener;
            this.mHandler = new C06251(StorageManager.this.mTgtLooper, StorageManager.this);
        }

        StorageEventListener getListener() {
            return this.mStorageEventListener;
        }

        void sendShareAvailabilityChanged(boolean available) {
            this.mHandler.sendMessage(new UmsConnectionChangedStorageEvent(available).getMessage());
        }

        void sendStorageStateChanged(String path, String oldState, String newState) {
            this.mHandler.sendMessage(new StorageStateChangedStorageEvent(path, oldState, newState).getMessage());
        }
    }

    private class MountServiceBinderListener extends Stub {
        private MountServiceBinderListener() {
        }

        public void onUsbMassStorageConnectionChanged(boolean available) {
            int size = StorageManager.this.mListeners.size();
            for (int i = StorageManager.CRYPT_TYPE_PASSWORD; i < size; i += StorageManager.CRYPT_TYPE_DEFAULT) {
                ((ListenerDelegate) StorageManager.this.mListeners.get(i)).sendShareAvailabilityChanged(available);
            }
        }

        public void onStorageStateChanged(String path, String oldState, String newState) {
            int size = StorageManager.this.mListeners.size();
            for (int i = StorageManager.CRYPT_TYPE_PASSWORD; i < size; i += StorageManager.CRYPT_TYPE_DEFAULT) {
                ((ListenerDelegate) StorageManager.this.mListeners.get(i)).sendStorageStateChanged(path, oldState, newState);
            }
        }
    }

    private class ObbActionListener extends IObbActionListener.Stub {
        private SparseArray<ObbListenerDelegate> mListeners;

        private ObbActionListener() {
            this.mListeners = new SparseArray();
        }

        public void onObbResult(String filename, int nonce, int status) {
            synchronized (this.mListeners) {
                ObbListenerDelegate delegate = (ObbListenerDelegate) this.mListeners.get(nonce);
                if (delegate != null) {
                    this.mListeners.remove(nonce);
                }
            }
            if (delegate != null) {
                delegate.sendObbStateChanged(filename, status);
            }
        }

        public int addListener(OnObbStateChangeListener listener) {
            ObbListenerDelegate delegate = new ObbListenerDelegate(listener);
            synchronized (this.mListeners) {
                this.mListeners.put(delegate.nonce, delegate);
            }
            return delegate.nonce;
        }
    }

    private class ObbListenerDelegate {
        private final Handler mHandler;
        private final WeakReference<OnObbStateChangeListener> mObbEventListenerRef;
        private final int nonce;

        /* renamed from: android.os.storage.StorageManager.ObbListenerDelegate.1 */
        class C06261 extends Handler {
            final /* synthetic */ StorageManager val$this$0;

            C06261(Looper x0, StorageManager storageManager) {
                this.val$this$0 = storageManager;
                super(x0);
            }

            public void handleMessage(Message msg) {
                OnObbStateChangeListener changeListener = ObbListenerDelegate.this.getListener();
                if (changeListener != null) {
                    StorageEvent e = msg.obj;
                    if (msg.what == StorageManager.CRYPT_TYPE_PIN) {
                        ObbStateChangedStorageEvent ev = (ObbStateChangedStorageEvent) e;
                        changeListener.onObbStateChange(ev.path, ev.state);
                        return;
                    }
                    Log.e(StorageManager.TAG, "Unsupported event " + msg.what);
                }
            }
        }

        ObbListenerDelegate(OnObbStateChangeListener listener) {
            this.nonce = StorageManager.this.getNextNonce();
            this.mObbEventListenerRef = new WeakReference(listener);
            this.mHandler = new C06261(StorageManager.this.mTgtLooper, StorageManager.this);
        }

        OnObbStateChangeListener getListener() {
            if (this.mObbEventListenerRef == null) {
                return null;
            }
            return (OnObbStateChangeListener) this.mObbEventListenerRef.get();
        }

        void sendObbStateChanged(String path, int state) {
            this.mHandler.sendMessage(new ObbStateChangedStorageEvent(path, state).getMessage());
        }
    }

    private class StorageEvent {
        static final int EVENT_OBB_STATE_CHANGED = 3;
        static final int EVENT_STORAGE_STATE_CHANGED = 2;
        static final int EVENT_UMS_CONNECTION_CHANGED = 1;
        private Message mMessage;

        public StorageEvent(int what) {
            this.mMessage = Message.obtain();
            this.mMessage.what = what;
            this.mMessage.obj = this;
        }

        public Message getMessage() {
            return this.mMessage;
        }
    }

    private class ObbStateChangedStorageEvent extends StorageEvent {
        public final String path;
        public final int state;

        public ObbStateChangedStorageEvent(String path, int state) {
            super(StorageManager.CRYPT_TYPE_PIN);
            this.path = path;
            this.state = state;
        }
    }

    private class StorageStateChangedStorageEvent extends StorageEvent {
        public String newState;
        public String oldState;
        public String path;

        public StorageStateChangedStorageEvent(String p, String oldS, String newS) {
            super(StorageManager.CRYPT_TYPE_PATTERN);
            this.path = p;
            this.oldState = oldS;
            this.newState = newS;
        }
    }

    private class UmsConnectionChangedStorageEvent extends StorageEvent {
        public boolean available;

        public UmsConnectionChangedStorageEvent(boolean a) {
            super(StorageManager.CRYPT_TYPE_DEFAULT);
            this.available = a;
        }
    }

    private int getNextNonce() {
        return this.mNextNonce.getAndIncrement();
    }

    public static StorageManager from(Context context) {
        return (StorageManager) context.getSystemService(Context.STORAGE_SERVICE);
    }

    public StorageManager(ContentResolver resolver, Looper tgtLooper) throws RemoteException {
        this.mListeners = new ArrayList();
        this.mNextNonce = new AtomicInteger(CRYPT_TYPE_PASSWORD);
        this.mObbActionListener = new ObbActionListener();
        this.mResolver = resolver;
        this.mTgtLooper = tgtLooper;
        this.mMountService = IMountService.Stub.asInterface(ServiceManager.getService("mount"));
        if (this.mMountService == null) {
            Log.e(TAG, "Unable to connect to mount service! - is it running yet?");
        }
    }

    public void registerListener(StorageEventListener listener) {
        if (listener != null) {
            synchronized (this.mListeners) {
                if (this.mBinderListener == null) {
                    try {
                        this.mBinderListener = new MountServiceBinderListener();
                        this.mMountService.registerListener(this.mBinderListener);
                    } catch (RemoteException e) {
                        Log.e(TAG, "Register mBinderListener failed");
                        return;
                    }
                }
                this.mListeners.add(new ListenerDelegate(listener));
            }
        }
    }

    public void unregisterListener(StorageEventListener listener) {
        if (listener != null) {
            synchronized (this.mListeners) {
                int size = this.mListeners.size();
                for (int i = CRYPT_TYPE_PASSWORD; i < size; i += CRYPT_TYPE_DEFAULT) {
                    if (((ListenerDelegate) this.mListeners.get(i)).getListener() == listener) {
                        this.mListeners.remove(i);
                        break;
                    }
                }
                if (this.mListeners.size() == 0 && this.mBinderListener != null) {
                    try {
                        this.mMountService.unregisterListener(this.mBinderListener);
                    } catch (RemoteException e) {
                        Log.e(TAG, "Unregister mBinderListener failed");
                        return;
                    }
                }
            }
        }
    }

    public void enableUsbMassStorage() {
        try {
            this.mMountService.setUsbMassStorageEnabled(true);
        } catch (Exception ex) {
            Log.e(TAG, "Failed to enable UMS", ex);
        }
    }

    public void disableUsbMassStorage() {
        try {
            this.mMountService.setUsbMassStorageEnabled(false);
        } catch (Exception ex) {
            Log.e(TAG, "Failed to disable UMS", ex);
        }
    }

    public boolean isUsbMassStorageConnected() {
        try {
            return this.mMountService.isUsbMassStorageConnected();
        } catch (Exception ex) {
            Log.e(TAG, "Failed to get UMS connection state", ex);
            return false;
        }
    }

    public boolean isUsbMassStorageEnabled() {
        try {
            return this.mMountService.isUsbMassStorageEnabled();
        } catch (RemoteException rex) {
            Log.e(TAG, "Failed to get UMS enable state", rex);
            return false;
        }
    }

    public boolean mountObb(String rawPath, String key, OnObbStateChangeListener listener) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        Preconditions.checkNotNull(listener, "listener cannot be null");
        try {
            String str = rawPath;
            String str2 = key;
            this.mMountService.mountObb(str, new File(rawPath).getCanonicalPath(), str2, this.mObbActionListener, this.mObbActionListener.addListener(listener));
            return true;
        } catch (IOException e) {
            throw new IllegalArgumentException("Failed to resolve path: " + rawPath, e);
        } catch (RemoteException e2) {
            Log.e(TAG, "Failed to mount OBB", e2);
            return false;
        }
    }

    public boolean unmountObb(String rawPath, boolean force, OnObbStateChangeListener listener) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        Preconditions.checkNotNull(listener, "listener cannot be null");
        try {
            this.mMountService.unmountObb(rawPath, force, this.mObbActionListener, this.mObbActionListener.addListener(listener));
            return true;
        } catch (RemoteException e) {
            Log.e(TAG, "Failed to mount OBB", e);
            return false;
        }
    }

    public boolean isObbMounted(String rawPath) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        try {
            return this.mMountService.isObbMounted(rawPath);
        } catch (RemoteException e) {
            Log.e(TAG, "Failed to check if OBB is mounted", e);
            return false;
        }
    }

    public String getMountedObbPath(String rawPath) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        try {
            return this.mMountService.getMountedObbPath(rawPath);
        } catch (RemoteException e) {
            Log.e(TAG, "Failed to find mounted path for OBB", e);
            return null;
        }
    }

    public String getVolumeState(String mountPoint) {
        if (this.mMountService == null) {
            return Environment.MEDIA_REMOVED;
        }
        try {
            return this.mMountService.getVolumeState(mountPoint);
        } catch (RemoteException e) {
            Log.e(TAG, "Failed to get volume state", e);
            return null;
        }
    }

    public StorageVolume[] getVolumeList() {
        if (this.mMountService == null) {
            return new StorageVolume[CRYPT_TYPE_PASSWORD];
        }
        try {
            Parcelable[] list = this.mMountService.getVolumeList();
            if (list == null) {
                return new StorageVolume[CRYPT_TYPE_PASSWORD];
            }
            int length = list.length;
            StorageVolume[] result = new StorageVolume[length];
            for (int i = CRYPT_TYPE_PASSWORD; i < length; i += CRYPT_TYPE_DEFAULT) {
                result[i] = (StorageVolume) list[i];
            }
            return result;
        } catch (RemoteException e) {
            Log.e(TAG, "Failed to get volume list", e);
            return null;
        }
    }

    public String[] getVolumePaths() {
        StorageVolume[] volumes = getVolumeList();
        if (volumes == null) {
            return null;
        }
        int count = volumes.length;
        String[] paths = new String[count];
        for (int i = CRYPT_TYPE_PASSWORD; i < count; i += CRYPT_TYPE_DEFAULT) {
            paths[i] = volumes[i].getPath();
        }
        return paths;
    }

    public StorageVolume getPrimaryVolume() {
        return getPrimaryVolume(getVolumeList());
    }

    public static StorageVolume getPrimaryVolume(StorageVolume[] volumes) {
        StorageVolume[] arr$ = volumes;
        int len$ = arr$.length;
        for (int i$ = CRYPT_TYPE_PASSWORD; i$ < len$; i$ += CRYPT_TYPE_DEFAULT) {
            StorageVolume volume = arr$[i$];
            if (volume.isPrimary()) {
                return volume;
            }
        }
        Log.w(TAG, "No primary storage defined");
        return null;
    }

    public long getStorageBytesUntilLow(File path) {
        return path.getUsableSpace() - getStorageFullBytes(path);
    }

    public long getStorageLowBytes(File path) {
        return Math.min((path.getTotalSpace() * ((long) Global.getInt(this.mResolver, "sys_storage_threshold_percentage", DEFAULT_THRESHOLD_PERCENTAGE))) / 100, Global.getLong(this.mResolver, "sys_storage_threshold_max_bytes", DEFAULT_THRESHOLD_MAX_BYTES));
    }

    public long getStorageFullBytes(File path) {
        return Global.getLong(this.mResolver, "sys_storage_full_threshold_bytes", DEFAULT_FULL_THRESHOLD_BYTES);
    }

    public static ArrayList<StorageVolume> getPhysicalExternalVolume(StorageVolume[] volumesphy) {
        int count = volumesphy.length;
        ArrayList<StorageVolume> volumes = Lists.newArrayList();
        for (int i = CRYPT_TYPE_PASSWORD; i < count; i += CRYPT_TYPE_DEFAULT) {
            if (!volumesphy[i].isEmulated()) {
                volumes.add(volumesphy[i]);
            }
        }
        return volumes;
    }
}
