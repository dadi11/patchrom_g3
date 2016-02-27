package com.android.server;

import android.app.ActivityManagerNative;
import android.app.AppOpsManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.UserInfo;
import android.content.res.Configuration;
import android.content.res.ObbInfo;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.net.Uri;
import android.os.Binder;
import android.os.Environment;
import android.os.Environment.UserEnvironment;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.storage.IMountService.Stub;
import android.os.storage.IMountServiceListener;
import android.os.storage.IMountShutdownObserver;
import android.os.storage.IObbActionListener;
import android.os.storage.StorageVolume;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.R;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.app.IMediaContainerService;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.Preconditions;
import com.android.internal.util.XmlUtils;
import com.android.server.NativeDaemonConnector.Command;
import com.android.server.NativeDaemonConnector.SensitiveArg;
import com.android.server.Watchdog.Monitor;
import com.android.server.am.ActivityManagerService;
import com.android.server.input.InputManagerService;
import com.android.server.pm.PackageManagerService;
import com.android.server.pm.UserManagerService;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import com.google.android.collect.Lists;
import com.google.android.collect.Maps;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;

class MountService extends Stub implements INativeDaemonConnectorCallbacks, Monitor {
    private static final int CRYPTO_ALGORITHM_KEY_SIZE = 128;
    public static final String[] CRYPTO_TYPES;
    private static final boolean DEBUG_EVENTS = false;
    private static final boolean DEBUG_OBB = false;
    private static final boolean DEBUG_UNMOUNT = false;
    static final ComponentName DEFAULT_CONTAINER_COMPONENT;
    private static final int H_FSTRIM = 5;
    private static final int H_SYSTEM_READY = 4;
    private static final int H_UNMOUNT_MS = 3;
    private static final int H_UNMOUNT_PM_DONE = 2;
    private static final int H_UNMOUNT_PM_UPDATE = 1;
    private static final String LAST_FSTRIM_FILE = "last-fstrim";
    private static final boolean LOCAL_LOGD = false;
    private static final int MAX_CONTAINERS = 250;
    private static final int MAX_UNMOUNT_RETRIES = 4;
    private static final int OBB_FLUSH_MOUNT_STATE = 5;
    private static final int OBB_MCS_BOUND = 2;
    private static final int OBB_MCS_RECONNECT = 4;
    private static final int OBB_MCS_UNBIND = 3;
    private static final int OBB_RUN_ACTION = 1;
    private static final int PBKDF2_HASH_ROUNDS = 1024;
    private static final int RETRY_UNMOUNT_DELAY = 30;
    private static final String TAG = "MountService";
    private static final String TAG_STORAGE = "storage";
    private static final String TAG_STORAGE_LIST = "StorageList";
    private static final String VOLD_TAG = "VoldConnector";
    private static final boolean WATCHDOG_ENABLE = false;
    static MountService sSelf;
    private final HashSet<String> mAsecMountSet;
    private final CountDownLatch mAsecsScanned;
    private final CountDownLatch mConnectedSignal;
    private final NativeDaemonConnector mConnector;
    private IMediaContainerService mContainerService;
    private final Context mContext;
    private final DefaultContainerConnection mDefContainerConn;
    private StorageVolume mEmulatedTemplate;
    private final Handler mHandler;
    private long mLastMaintenance;
    private final File mLastMaintenanceFile;
    private final ArrayList<MountServiceBinderListener> mListeners;
    private final ObbActionHandler mObbActionHandler;
    private final Map<IBinder, List<ObbState>> mObbMounts;
    private final Map<String, ObbState> mObbPathToStateMap;
    private PackageManagerService mPms;
    private boolean mSendUmsConnectedOnBoot;
    private volatile boolean mSystemReady;
    private boolean mUmsAvailable;
    private boolean mUmsEnabling;
    private final BroadcastReceiver mUsbReceiver;
    private final BroadcastReceiver mUserReceiver;
    @GuardedBy("mVolumesLock")
    private final HashMap<String, String> mVolumeStates;
    @GuardedBy("mVolumesLock")
    private final ArrayList<StorageVolume> mVolumes;
    @GuardedBy("mVolumesLock")
    private final HashMap<String, StorageVolume> mVolumesByPath;
    private final Object mVolumesLock;

    /* renamed from: com.android.server.MountService.1 */
    class C00601 extends BroadcastReceiver {
        C00601() {
        }

        public void onReceive(Context context, Intent intent) {
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
            if (userId != -1) {
                UserHandle user = new UserHandle(userId);
                String action = intent.getAction();
                if ("android.intent.action.USER_ADDED".equals(action)) {
                    synchronized (MountService.this.mVolumesLock) {
                        MountService.this.createEmulatedVolumeForUserLocked(user);
                    }
                } else if ("android.intent.action.USER_REMOVED".equals(action)) {
                    synchronized (MountService.this.mVolumesLock) {
                        StorageVolume volume;
                        List<StorageVolume> toRemove = Lists.newArrayList();
                        Iterator i$ = MountService.this.mVolumes.iterator();
                        while (i$.hasNext()) {
                            volume = (StorageVolume) i$.next();
                            if (user.equals(volume.getOwner())) {
                                toRemove.add(volume);
                            }
                        }
                        for (StorageVolume volume2 : toRemove) {
                            MountService.this.removeVolumeLocked(volume2);
                        }
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.MountService.2 */
    class C00612 extends BroadcastReceiver {
        C00612() {
        }

        public void onReceive(Context context, Intent intent) {
            boolean available = MountService.LOCAL_LOGD;
            if (intent.getBooleanExtra("connected", MountService.LOCAL_LOGD) && intent.getBooleanExtra("mass_storage", MountService.LOCAL_LOGD)) {
                available = true;
            }
            MountService.this.notifyShareAvailabilityChange(available);
        }
    }

    /* renamed from: com.android.server.MountService.3 */
    class C00623 extends Thread {
        C00623(String x0) {
            super(x0);
        }

        public void run() {
            try {
                Object[] objArr = new Object[MountService.OBB_MCS_BOUND];
                objArr[0] = "list";
                objArr[MountService.OBB_RUN_ACTION] = "broadcast";
                String[] arr$ = NativeDaemonEvent.filterMessageList(MountService.this.mConnector.executeForList("volume", objArr), NetdResponseCode.InterfaceListResult);
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += MountService.OBB_RUN_ACTION) {
                    StorageVolume volume;
                    String[] tok = arr$[i$].split(" ");
                    String path = tok[MountService.OBB_RUN_ACTION];
                    String state = "removed";
                    synchronized (MountService.this.mVolumesLock) {
                        volume = (StorageVolume) MountService.this.mVolumesByPath.get(path);
                    }
                    int st = Integer.parseInt(tok[MountService.OBB_MCS_BOUND]);
                    if (st == 0) {
                        state = "removed";
                    } else if (st == MountService.OBB_RUN_ACTION) {
                        state = "unmounted";
                    } else if (st == MountService.OBB_MCS_RECONNECT) {
                        state = "mounted";
                        Slog.i(MountService.TAG, "Media already mounted on daemon connection");
                    } else if (st == 7) {
                        state = "shared";
                        Slog.i(MountService.TAG, "Media shared on daemon connection");
                    } else {
                        objArr = new Object[MountService.OBB_RUN_ACTION];
                        objArr[0] = Integer.valueOf(st);
                        throw new Exception(String.format("Unexpected state %d", objArr));
                    }
                    if (state != null) {
                        MountService.this.updatePublicVolumeState(volume, state);
                    }
                }
            } catch (Exception e) {
                Slog.e(MountService.TAG, "Error processing initial volume state", e);
                StorageVolume primary = MountService.this.getPrimaryPhysicalVolume();
                if (primary != null) {
                    MountService.this.updatePublicVolumeState(primary, "removed");
                }
            }
            MountService.this.mConnectedSignal.countDown();
            if ("".equals(SystemProperties.get("vold.encrypt_progress"))) {
                MountService.this.copyLocaleFromMountService();
            }
            MountService.this.mPms.scanAvailableAsecs();
            MountService.this.mAsecsScanned.countDown();
        }
    }

    /* renamed from: com.android.server.MountService.4 */
    class C00634 extends Thread {
        final /* synthetic */ String val$path;

        C00634(String x0, String str) {
            this.val$path = str;
            super(x0);
        }

        public void run() {
            try {
                int rc = MountService.this.doMountVolume(this.val$path);
                if (rc != 0) {
                    String str = MountService.TAG;
                    Object[] objArr = new Object[MountService.OBB_RUN_ACTION];
                    objArr[0] = Integer.valueOf(rc);
                    Slog.w(str, String.format("Insertion mount failed (%d)", objArr));
                }
            } catch (Exception ex) {
                Slog.w(MountService.TAG, "Failed to mount media on insertion", ex);
            }
        }
    }

    /* renamed from: com.android.server.MountService.5 */
    class C00645 extends Thread {
        final /* synthetic */ String val$path;

        C00645(String x0, String str) {
            this.val$path = str;
            super(x0);
        }

        public void run() {
            try {
                Slog.w(MountService.TAG, "Disabling UMS after cable disconnect");
                MountService.this.doShareUnshareVolume(this.val$path, "ums", MountService.LOCAL_LOGD);
                int rc = MountService.this.doMountVolume(this.val$path);
                if (rc != 0) {
                    String str = MountService.TAG;
                    Object[] objArr = new Object[MountService.OBB_MCS_BOUND];
                    objArr[0] = this.val$path;
                    objArr[MountService.OBB_RUN_ACTION] = Integer.valueOf(rc);
                    Slog.e(str, String.format("Failed to remount {%s} on UMS enabled-disconnect (%d)", objArr));
                }
            } catch (Exception ex) {
                Slog.w(MountService.TAG, "Failed to mount media on UMS enabled-disconnect", ex);
            }
        }
    }

    /* renamed from: com.android.server.MountService.6 */
    class C00656 implements Runnable {
        C00656() {
        }

        public void run() {
            try {
                Object[] objArr = new Object[MountService.OBB_RUN_ACTION];
                objArr[0] = "restart";
                MountService.this.mConnector.execute("cryptfs", objArr);
            } catch (NativeDaemonConnectorException e) {
                Slog.e(MountService.TAG, "problem executing in background", e);
            }
        }
    }

    class DefaultContainerConnection implements ServiceConnection {
        DefaultContainerConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            MountService.this.mObbActionHandler.sendMessage(MountService.this.mObbActionHandler.obtainMessage(MountService.OBB_MCS_BOUND, IMediaContainerService.Stub.asInterface(service)));
        }

        public void onServiceDisconnected(ComponentName name) {
        }
    }

    abstract class ObbAction {
        private static final int MAX_RETRIES = 3;
        ObbState mObbState;
        private int mRetries;

        abstract void handleError();

        abstract void handleExecute() throws RemoteException, IOException;

        ObbAction(ObbState obbState) {
            this.mObbState = obbState;
        }

        public void execute(ObbActionHandler handler) {
            try {
                this.mRetries += MountService.OBB_RUN_ACTION;
                if (this.mRetries > MAX_RETRIES) {
                    Slog.w(MountService.TAG, "Failed to invoke remote methods on default container service. Giving up");
                    MountService.this.mObbActionHandler.sendEmptyMessage(MAX_RETRIES);
                    handleError();
                    return;
                }
                handleExecute();
                MountService.this.mObbActionHandler.sendEmptyMessage(MAX_RETRIES);
            } catch (RemoteException e) {
                MountService.this.mObbActionHandler.sendEmptyMessage(MountService.OBB_MCS_RECONNECT);
            } catch (Exception e2) {
                handleError();
                MountService.this.mObbActionHandler.sendEmptyMessage(MAX_RETRIES);
            }
        }

        protected ObbInfo getObbInfo() throws IOException {
            ObbInfo obbInfo;
            try {
                obbInfo = MountService.this.mContainerService.getObbInfo(this.mObbState.ownerPath);
            } catch (RemoteException e) {
                Slog.d(MountService.TAG, "Couldn't call DefaultContainerService to fetch OBB info for " + this.mObbState.ownerPath);
                obbInfo = null;
            }
            if (obbInfo != null) {
                return obbInfo;
            }
            throw new IOException("Couldn't read OBB file: " + this.mObbState.ownerPath);
        }

        protected void sendNewStatusOrIgnore(int status) {
            if (this.mObbState != null && this.mObbState.token != null) {
                try {
                    this.mObbState.token.onObbResult(this.mObbState.rawPath, this.mObbState.nonce, status);
                } catch (RemoteException e) {
                    Slog.w(MountService.TAG, "MountServiceListener went away while calling onObbStateChanged");
                }
            }
        }
    }

    class MountObbAction extends ObbAction {
        private final int mCallingUid;
        private final String mKey;

        MountObbAction(ObbState obbState, String key, int callingUid) {
            super(obbState);
            this.mKey = key;
            this.mCallingUid = callingUid;
        }

        public void handleExecute() throws IOException, RemoteException {
            MountService.this.waitForReady();
            MountService.this.warnOnNotMounted();
            ObbInfo obbInfo = getObbInfo();
            if (MountService.this.isUidOwnerOfPackageOrSystem(obbInfo.packageName, this.mCallingUid)) {
                boolean isMounted;
                synchronized (MountService.this.mObbMounts) {
                    isMounted = MountService.this.mObbPathToStateMap.containsKey(this.mObbState.rawPath);
                }
                if (isMounted) {
                    Slog.w(MountService.TAG, "Attempt to mount OBB which is already mounted: " + obbInfo.filename);
                    sendNewStatusOrIgnore(24);
                    return;
                }
                String hashedKey;
                if (this.mKey == null) {
                    hashedKey = "none";
                } else {
                    try {
                        hashedKey = new BigInteger(SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1").generateSecret(new PBEKeySpec(this.mKey.toCharArray(), obbInfo.salt, MountService.PBKDF2_HASH_ROUNDS, MountService.CRYPTO_ALGORITHM_KEY_SIZE)).getEncoded()).toString(16);
                    } catch (NoSuchAlgorithmException e) {
                        Slog.e(MountService.TAG, "Could not load PBKDF2 algorithm", e);
                        sendNewStatusOrIgnore(20);
                        return;
                    } catch (InvalidKeySpecException e2) {
                        Slog.e(MountService.TAG, "Invalid key spec when loading PBKDF2 algorithm", e2);
                        sendNewStatusOrIgnore(20);
                        return;
                    }
                }
                int rc = 0;
                try {
                    Object[] objArr = new Object[MountService.OBB_MCS_RECONNECT];
                    objArr[0] = "mount";
                    objArr[MountService.OBB_RUN_ACTION] = this.mObbState.voldPath;
                    objArr[MountService.OBB_MCS_BOUND] = new SensitiveArg(hashedKey);
                    objArr[MountService.OBB_MCS_UNBIND] = Integer.valueOf(this.mObbState.ownerGid);
                    MountService.this.mConnector.execute("obb", objArr);
                } catch (NativeDaemonConnectorException e3) {
                    if (e3.getCode() != VoldResponseCode.OpFailedStorageBusy) {
                        rc = -1;
                    }
                }
                if (rc == 0) {
                    synchronized (MountService.this.mObbMounts) {
                        MountService.this.addObbStateLocked(this.mObbState);
                    }
                    sendNewStatusOrIgnore(MountService.OBB_RUN_ACTION);
                    return;
                }
                Slog.e(MountService.TAG, "Couldn't mount OBB file: " + rc);
                sendNewStatusOrIgnore(21);
                return;
            }
            Slog.w(MountService.TAG, "Denied attempt to mount OBB " + obbInfo.filename + " which is owned by " + obbInfo.packageName);
            sendNewStatusOrIgnore(25);
        }

        public void handleError() {
            sendNewStatusOrIgnore(20);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("MountObbAction{");
            sb.append(this.mObbState);
            sb.append('}');
            return sb.toString();
        }
    }

    private final class MountServiceBinderListener implements DeathRecipient {
        final IMountServiceListener mListener;

        MountServiceBinderListener(IMountServiceListener listener) {
            this.mListener = listener;
        }

        public void binderDied() {
            synchronized (MountService.this.mListeners) {
                MountService.this.mListeners.remove(this);
                this.mListener.asBinder().unlinkToDeath(this, 0);
            }
        }
    }

    class MountServiceHandler extends Handler {
        ArrayList<UnmountCallBack> mForceUnmounts;
        boolean mUpdatingStatus;

        MountServiceHandler(Looper l) {
            super(l);
            this.mForceUnmounts = new ArrayList();
            this.mUpdatingStatus = MountService.LOCAL_LOGD;
        }

        public void handleMessage(Message msg) {
            UnmountCallBack ucb;
            switch (msg.what) {
                case MountService.OBB_RUN_ACTION /*1*/:
                    ucb = msg.obj;
                    this.mForceUnmounts.add(ucb);
                    if (!this.mUpdatingStatus) {
                        this.mUpdatingStatus = true;
                        MountService.this.mPms.updateExternalMediaStatus(MountService.LOCAL_LOGD, true);
                    }
                case MountService.OBB_MCS_BOUND /*2*/:
                    this.mUpdatingStatus = MountService.LOCAL_LOGD;
                    int size = this.mForceUnmounts.size();
                    int[] sizeArr = new int[size];
                    ActivityManagerService ams = (ActivityManagerService) ServiceManager.getService("activity");
                    int i = 0;
                    int sizeArrN = 0;
                    while (i < size) {
                        int i2;
                        int sizeArrN2;
                        ucb = (UnmountCallBack) this.mForceUnmounts.get(i);
                        String path = ucb.path;
                        boolean done = MountService.LOCAL_LOGD;
                        if (ucb.force) {
                            int[] pids = MountService.this.getStorageUsers(path);
                            if (pids == null || pids.length == 0) {
                                done = true;
                            } else {
                                ams.killPids(pids, "unmount media", true);
                                pids = MountService.this.getStorageUsers(path);
                                if (pids == null || pids.length == 0) {
                                    done = true;
                                }
                            }
                        } else {
                            done = true;
                        }
                        if (!done) {
                            i2 = ucb.retries;
                            if (r0 < MountService.OBB_MCS_RECONNECT) {
                                Slog.i(MountService.TAG, "Retrying to kill storage users again");
                                Handler access$400 = MountService.this.mHandler;
                                Handler access$4002 = MountService.this.mHandler;
                                int i3 = ucb.retries;
                                ucb.retries = i3 + MountService.OBB_RUN_ACTION;
                                access$400.sendMessageDelayed(access$4002.obtainMessage(MountService.OBB_MCS_BOUND, Integer.valueOf(i3)), 30);
                                sizeArrN2 = sizeArrN;
                                i += MountService.OBB_RUN_ACTION;
                                sizeArrN = sizeArrN2;
                            }
                        }
                        i2 = ucb.retries;
                        if (r0 >= MountService.OBB_MCS_RECONNECT) {
                            Slog.i(MountService.TAG, "Failed to unmount media inspite of 4 retries. Forcibly killing processes now");
                        }
                        sizeArrN2 = sizeArrN + MountService.OBB_RUN_ACTION;
                        sizeArr[sizeArrN] = i;
                        MountService.this.mHandler.sendMessage(MountService.this.mHandler.obtainMessage(MountService.OBB_MCS_UNBIND, ucb));
                        i += MountService.OBB_RUN_ACTION;
                        sizeArrN = sizeArrN2;
                    }
                    for (i = sizeArrN - 1; i >= 0; i--) {
                        this.mForceUnmounts.remove(sizeArr[i]);
                    }
                case MountService.OBB_MCS_UNBIND /*3*/:
                    ((UnmountCallBack) msg.obj).handleFinished();
                case MountService.OBB_MCS_RECONNECT /*4*/:
                    try {
                        MountService.this.handleSystemReady();
                    } catch (Exception ex) {
                        Slog.e(MountService.TAG, "Boot-time mount exception", ex);
                    }
                case MountService.OBB_FLUSH_MOUNT_STATE /*5*/:
                    MountService.this.waitForReady();
                    Slog.i(MountService.TAG, "Running fstrim idle maintenance");
                    try {
                        MountService.this.mLastMaintenance = System.currentTimeMillis();
                        MountService.this.mLastMaintenanceFile.setLastModified(MountService.this.mLastMaintenance);
                    } catch (Exception e) {
                        Slog.e(MountService.TAG, "Unable to record last fstrim!");
                    }
                    try {
                        MountService mountService = MountService.this;
                        Object[] objArr = new Object[MountService.OBB_RUN_ACTION];
                        objArr[0] = "dotrim";
                        r0.mConnector.execute("fstrim", objArr);
                        EventLogTags.writeFstrimStart(SystemClock.elapsedRealtime());
                    } catch (NativeDaemonConnectorException e2) {
                        Slog.e(MountService.TAG, "Failed to run fstrim!");
                    }
                    Runnable callback = msg.obj;
                    if (callback != null) {
                        callback.run();
                    }
                default:
            }
        }
    }

    static class MountShutdownLatch {
        private AtomicInteger mCount;
        private IMountShutdownObserver mObserver;

        MountShutdownLatch(IMountShutdownObserver observer, int count) {
            this.mObserver = observer;
            this.mCount = new AtomicInteger(count);
        }

        void countDown() {
            boolean sendShutdown = MountService.LOCAL_LOGD;
            if (this.mCount.decrementAndGet() == 0) {
                sendShutdown = true;
            }
            if (sendShutdown && this.mObserver != null) {
                try {
                    this.mObserver.onShutDownComplete(0);
                } catch (RemoteException e) {
                    Slog.w(MountService.TAG, "RemoteException when shutting down");
                }
            }
        }
    }

    private class ObbActionHandler extends Handler {
        private final List<ObbAction> mActions;
        private boolean mBound;

        ObbActionHandler(Looper l) {
            super(l);
            this.mBound = MountService.LOCAL_LOGD;
            this.mActions = new LinkedList();
        }

        public void handleMessage(Message msg) {
            ObbAction action;
            switch (msg.what) {
                case MountService.OBB_RUN_ACTION /*1*/:
                    action = msg.obj;
                    if (this.mBound || connectToService()) {
                        this.mActions.add(action);
                        return;
                    }
                    Slog.e(MountService.TAG, "Failed to bind to media container service");
                    action.handleError();
                case MountService.OBB_MCS_BOUND /*2*/:
                    if (msg.obj != null) {
                        MountService.this.mContainerService = (IMediaContainerService) msg.obj;
                    }
                    if (MountService.this.mContainerService == null) {
                        Slog.e(MountService.TAG, "Cannot bind to media container service");
                        for (ObbAction action2 : this.mActions) {
                            action2.handleError();
                        }
                        this.mActions.clear();
                    } else if (this.mActions.size() > 0) {
                        action2 = (ObbAction) this.mActions.get(0);
                        if (action2 != null) {
                            action2.execute(this);
                        }
                    } else {
                        Slog.w(MountService.TAG, "Empty queue");
                    }
                case MountService.OBB_MCS_UNBIND /*3*/:
                    if (this.mActions.size() > 0) {
                        this.mActions.remove(0);
                    }
                    if (this.mActions.size() != 0) {
                        MountService.this.mObbActionHandler.sendEmptyMessage(MountService.OBB_MCS_BOUND);
                    } else if (this.mBound) {
                        disconnectService();
                    }
                case MountService.OBB_MCS_RECONNECT /*4*/:
                    if (this.mActions.size() > 0) {
                        if (this.mBound) {
                            disconnectService();
                        }
                        if (!connectToService()) {
                            Slog.e(MountService.TAG, "Failed to bind to media container service");
                            for (ObbAction action22 : this.mActions) {
                                action22.handleError();
                            }
                            this.mActions.clear();
                        }
                    }
                case MountService.OBB_FLUSH_MOUNT_STATE /*5*/:
                    String path = msg.obj;
                    synchronized (MountService.this.mObbMounts) {
                        List<ObbState> obbStatesToRemove = new LinkedList();
                        for (ObbState state : MountService.this.mObbPathToStateMap.values()) {
                            if (state.canonicalPath.startsWith(path)) {
                                obbStatesToRemove.add(state);
                            }
                        }
                        for (ObbState obbState : obbStatesToRemove) {
                            MountService.this.removeObbStateLocked(obbState);
                            try {
                                obbState.token.onObbResult(obbState.rawPath, obbState.nonce, MountService.OBB_MCS_BOUND);
                            } catch (RemoteException e) {
                                Slog.i(MountService.TAG, "Couldn't send unmount notification for  OBB: " + obbState.rawPath);
                                break;
                            }
                        }
                        break;
                    }
                default:
            }
        }

        private boolean connectToService() {
            if (!MountService.this.mContext.bindService(new Intent().setComponent(MountService.DEFAULT_CONTAINER_COMPONENT), MountService.this.mDefContainerConn, MountService.OBB_RUN_ACTION)) {
                return MountService.LOCAL_LOGD;
            }
            this.mBound = true;
            return true;
        }

        private void disconnectService() {
            MountService.this.mContainerService = null;
            this.mBound = MountService.LOCAL_LOGD;
            MountService.this.mContext.unbindService(MountService.this.mDefContainerConn);
        }
    }

    class ObbState implements DeathRecipient {
        final String canonicalPath;
        final int nonce;
        final int ownerGid;
        final String ownerPath;
        final String rawPath;
        final IObbActionListener token;
        final String voldPath;

        public ObbState(String rawPath, String canonicalPath, int callingUid, IObbActionListener token, int nonce) {
            this.rawPath = rawPath;
            this.canonicalPath = canonicalPath.toString();
            int userId = UserHandle.getUserId(callingUid);
            this.ownerPath = MountService.buildObbPath(canonicalPath, userId, MountService.LOCAL_LOGD);
            this.voldPath = MountService.buildObbPath(canonicalPath, userId, true);
            this.ownerGid = UserHandle.getSharedAppGid(callingUid);
            this.token = token;
            this.nonce = nonce;
        }

        public IBinder getBinder() {
            return this.token.asBinder();
        }

        public void binderDied() {
            MountService.this.mObbActionHandler.sendMessage(MountService.this.mObbActionHandler.obtainMessage(MountService.OBB_RUN_ACTION, new UnmountObbAction(this, true)));
        }

        public void link() throws RemoteException {
            getBinder().linkToDeath(this, 0);
        }

        public void unlink() {
            getBinder().unlinkToDeath(this, 0);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder("ObbState{");
            sb.append("rawPath=").append(this.rawPath);
            sb.append(",canonicalPath=").append(this.canonicalPath);
            sb.append(",ownerPath=").append(this.ownerPath);
            sb.append(",voldPath=").append(this.voldPath);
            sb.append(",ownerGid=").append(this.ownerGid);
            sb.append(",token=").append(this.token);
            sb.append(",binder=").append(getBinder());
            sb.append('}');
            return sb.toString();
        }
    }

    class UnmountCallBack {
        final boolean force;
        final String path;
        final boolean removeEncryption;
        int retries;

        UnmountCallBack(String path, boolean force, boolean removeEncryption) {
            this.retries = 0;
            this.path = path;
            this.force = force;
            this.removeEncryption = removeEncryption;
        }

        void handleFinished() {
            MountService.this.doUnmountVolume(this.path, true, this.removeEncryption);
        }
    }

    class ShutdownCallBack extends UnmountCallBack {
        MountShutdownLatch mMountShutdownLatch;

        ShutdownCallBack(String path, MountShutdownLatch mountShutdownLatch) {
            super(path, true, MountService.LOCAL_LOGD);
            this.mMountShutdownLatch = mountShutdownLatch;
        }

        void handleFinished() {
            Slog.i(MountService.TAG, "Unmount completed: " + this.path + ", result code: " + MountService.this.doUnmountVolume(this.path, true, this.removeEncryption));
            this.mMountShutdownLatch.countDown();
        }
    }

    class UmsEnableCallBack extends UnmountCallBack {
        final String method;

        UmsEnableCallBack(String path, String method, boolean force) {
            super(path, force, MountService.LOCAL_LOGD);
            this.method = method;
        }

        void handleFinished() {
            super.handleFinished();
            MountService.this.doShareUnshareVolume(this.path, this.method, true);
        }
    }

    class UnmountObbAction extends ObbAction {
        private final boolean mForceUnmount;

        UnmountObbAction(ObbState obbState, boolean force) {
            super(obbState);
            this.mForceUnmount = force;
        }

        public void handleExecute() throws IOException {
            MountService.this.waitForReady();
            MountService.this.warnOnNotMounted();
            ObbInfo obbInfo = getObbInfo();
            synchronized (MountService.this.mObbMounts) {
                ObbState existingState = (ObbState) MountService.this.mObbPathToStateMap.get(this.mObbState.rawPath);
            }
            if (existingState == null) {
                sendNewStatusOrIgnore(23);
            } else if (existingState.ownerGid != this.mObbState.ownerGid) {
                Slog.w(MountService.TAG, "Permission denied attempting to unmount OBB " + existingState.rawPath + " (owned by GID " + existingState.ownerGid + ")");
                sendNewStatusOrIgnore(25);
            } else {
                int rc = 0;
                try {
                    Object[] objArr = new Object[MountService.OBB_MCS_BOUND];
                    objArr[0] = "unmount";
                    objArr[MountService.OBB_RUN_ACTION] = this.mObbState.voldPath;
                    Command cmd = new Command("obb", objArr);
                    if (this.mForceUnmount) {
                        cmd.appendArg("force");
                    }
                    MountService.this.mConnector.execute(cmd);
                } catch (NativeDaemonConnectorException e) {
                    int code = e.getCode();
                    if (code == VoldResponseCode.OpFailedStorageBusy) {
                        rc = -7;
                    } else if (code == VoldResponseCode.OpFailedStorageNotFound) {
                        rc = 0;
                    } else {
                        rc = -1;
                    }
                }
                if (rc == 0) {
                    synchronized (MountService.this.mObbMounts) {
                        MountService.this.removeObbStateLocked(existingState);
                    }
                    sendNewStatusOrIgnore(MountService.OBB_MCS_BOUND);
                    return;
                }
                Slog.w(MountService.TAG, "Could not unmount OBB: " + existingState);
                sendNewStatusOrIgnore(22);
            }
        }

        public void handleError() {
            sendNewStatusOrIgnore(20);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("UnmountObbAction{");
            sb.append(this.mObbState);
            sb.append(",force=");
            sb.append(this.mForceUnmount);
            sb.append('}');
            return sb.toString();
        }
    }

    class VoldResponseCode {
        public static final int AsecListResult = 111;
        public static final int AsecPathResult = 211;
        public static final int CryptfsGetfieldResult = 113;
        public static final int FstrimCompleted = 700;
        public static final int OpFailedMediaBlank = 402;
        public static final int OpFailedMediaCorrupt = 403;
        public static final int OpFailedNoMedia = 401;
        public static final int OpFailedStorageBusy = 405;
        public static final int OpFailedStorageNotFound = 406;
        public static final int OpFailedVolNotMounted = 404;
        public static final int ShareEnabledResult = 212;
        public static final int ShareStatusResult = 210;
        public static final int StorageUsersListResult = 112;
        public static final int VolumeBadRemoval = 632;
        public static final int VolumeDiskInserted = 630;
        public static final int VolumeDiskRemoved = 631;
        public static final int VolumeListResult = 110;
        public static final int VolumeStateChange = 605;
        public static final int VolumeUserLabelChange = 614;
        public static final int VolumeUuidChange = 613;

        VoldResponseCode() {
        }
    }

    class VolumeState {
        public static final int Checking = 3;
        public static final int Formatting = 6;
        public static final int Idle = 1;
        public static final int Init = -1;
        public static final int Mounted = 4;
        public static final int NoMedia = 0;
        public static final int Pending = 2;
        public static final int Shared = 7;
        public static final int SharedMnt = 8;
        public static final int Unmounting = 5;

        VolumeState() {
        }
    }

    static {
        sSelf = null;
        String[] strArr = new String[OBB_MCS_RECONNECT];
        strArr[0] = "password";
        strArr[OBB_RUN_ACTION] = "default";
        strArr[OBB_MCS_BOUND] = "pattern";
        strArr[OBB_MCS_UNBIND] = "pin";
        CRYPTO_TYPES = strArr;
        DEFAULT_CONTAINER_COMPONENT = new ComponentName("com.android.defcontainer", "com.android.defcontainer.DefaultContainerService");
    }

    void waitForAsecScan() {
        waitForLatch(this.mAsecsScanned);
    }

    private void waitForReady() {
        waitForLatch(this.mConnectedSignal);
    }

    private void waitForLatch(CountDownLatch latch) {
        while (!latch.await(5000, TimeUnit.MILLISECONDS)) {
            try {
                Slog.w(TAG, "Thread " + Thread.currentThread().getName() + " still waiting for MountService ready...");
            } catch (InterruptedException e) {
                Slog.w(TAG, "Interrupt while waiting for MountService to be ready.");
            }
        }
    }

    private boolean isReady() {
        try {
            return this.mConnectedSignal.await(0, TimeUnit.MILLISECONDS);
        } catch (InterruptedException e) {
            return LOCAL_LOGD;
        }
    }

    private void handleSystemReady() {
        Iterator i$;
        synchronized (this.mVolumesLock) {
            HashMap<String, String> snapshot = new HashMap(this.mVolumeStates);
        }
        for (Entry<String, String> entry : snapshot.entrySet()) {
            String path = (String) entry.getKey();
            String state = (String) entry.getValue();
            if (state.equals("unmounted")) {
                int rc = doMountVolume(path);
                if (rc != 0) {
                    String str = TAG;
                    Object[] objArr = new Object[OBB_RUN_ACTION];
                    objArr[0] = Integer.valueOf(rc);
                    Slog.e(str, String.format("Boot-time mount failed (%d)", objArr));
                }
            } else if (state.equals("shared")) {
                notifyVolumeStateChange(null, path, 0, 7);
            }
        }
        synchronized (this.mVolumesLock) {
            i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                StorageVolume volume = (StorageVolume) i$.next();
                if (volume.isEmulated()) {
                    updatePublicVolumeState(volume, "mounted");
                }
            }
        }
        if (this.mSendUmsConnectedOnBoot) {
            sendUmsIntent(true);
            this.mSendUmsConnectedOnBoot = LOCAL_LOGD;
        }
        MountServiceIdler.scheduleIdlePass(this.mContext);
    }

    void runIdleMaintenance(Runnable callback) {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(OBB_FLUSH_MOUNT_STATE, callback));
    }

    public void runMaintenance() {
        validatePermission("android.permission.MOUNT_UNMOUNT_FILESYSTEMS");
        runIdleMaintenance(null);
    }

    public long lastMaintenance() {
        return this.mLastMaintenance;
    }

    private void doShareUnshareVolume(String path, String method, boolean enable) {
        if (method.equals("ums")) {
            try {
                NativeDaemonConnector nativeDaemonConnector = this.mConnector;
                String str = "volume";
                Object[] objArr = new Object[OBB_MCS_UNBIND];
                objArr[0] = enable ? "share" : "unshare";
                objArr[OBB_RUN_ACTION] = path;
                objArr[OBB_MCS_BOUND] = method;
                nativeDaemonConnector.execute(str, objArr);
                return;
            } catch (NativeDaemonConnectorException e) {
                Slog.e(TAG, "Failed to share/unshare", e);
                return;
            }
        }
        Object[] objArr2 = new Object[OBB_RUN_ACTION];
        objArr2[0] = method;
        throw new IllegalArgumentException(String.format("Method %s not supported", objArr2));
    }

    private void updatePublicVolumeState(StorageVolume volume, String state) {
        String path = volume.getPath();
        synchronized (this.mVolumesLock) {
            String oldState = (String) this.mVolumeStates.put(path, state);
            volume.setState(state);
        }
        if (state.equals(oldState)) {
            String str = TAG;
            Object[] objArr = new Object[OBB_MCS_UNBIND];
            objArr[0] = state;
            objArr[OBB_RUN_ACTION] = state;
            objArr[OBB_MCS_BOUND] = path;
            Slog.w(str, String.format("Duplicate state transition (%s -> %s) for %s", objArr));
            return;
        }
        Slog.d(TAG, "volume state changed for " + path + " (" + oldState + " -> " + state + ")");
        if (volume.isPrimary() && !volume.isEmulated()) {
            if ("unmounted".equals(state)) {
                this.mPms.updateExternalMediaStatus(LOCAL_LOGD, LOCAL_LOGD);
                this.mObbActionHandler.sendMessage(this.mObbActionHandler.obtainMessage(OBB_FLUSH_MOUNT_STATE, path));
            } else if ("mounted".equals(state)) {
                this.mPms.updateExternalMediaStatus(true, LOCAL_LOGD);
            }
        }
        synchronized (this.mListeners) {
            for (int i = this.mListeners.size() - 1; i >= 0; i--) {
                try {
                    ((MountServiceBinderListener) this.mListeners.get(i)).mListener.onStorageStateChanged(path, oldState, state);
                } catch (RemoteException e) {
                    Slog.e(TAG, "Listener dead");
                    this.mListeners.remove(i);
                } catch (Exception ex) {
                    Slog.e(TAG, "Listener failed", ex);
                }
            }
        }
    }

    public void onDaemonConnected() {
        new C00623("MountService#onDaemonConnected").start();
    }

    private void copyLocaleFromMountService() {
        try {
            String systemLocale = getField("SystemLocale");
            if (!TextUtils.isEmpty(systemLocale)) {
                Slog.d(TAG, "Got locale " + systemLocale + " from mount service");
                Locale locale = Locale.forLanguageTag(systemLocale);
                Configuration config = new Configuration();
                config.setLocale(locale);
                try {
                    ActivityManagerNative.getDefault().updateConfiguration(config);
                } catch (RemoteException e) {
                    Slog.e(TAG, "Error setting system locale from mount service", e);
                }
                Slog.d(TAG, "Setting system properties to " + systemLocale + " from mount service");
                SystemProperties.set("persist.sys.language", locale.getLanguage());
                SystemProperties.set("persist.sys.country", locale.getCountry());
            }
        } catch (RemoteException e2) {
        }
    }

    public boolean onCheckHoldWakeLock(int code) {
        return LOCAL_LOGD;
    }

    public boolean onEvent(int code, String raw, String[] cooked) {
        if (code == 605) {
            notifyVolumeStateChange(cooked[OBB_MCS_BOUND], cooked[OBB_MCS_UNBIND], Integer.parseInt(cooked[7]), Integer.parseInt(cooked[10]));
        } else if (code == 613) {
            path = cooked[OBB_MCS_BOUND];
            r19 = cooked.length;
            String uuid = r0 > OBB_MCS_UNBIND ? cooked[OBB_MCS_UNBIND] : null;
            vol = (StorageVolume) this.mVolumesByPath.get(path);
            if (vol != null) {
                vol.setUuid(uuid);
            }
        } else if (code == 614) {
            path = cooked[OBB_MCS_BOUND];
            r19 = cooked.length;
            String userLabel = r0 > OBB_MCS_UNBIND ? cooked[OBB_MCS_UNBIND] : null;
            vol = (StorageVolume) this.mVolumesByPath.get(path);
            if (vol != null) {
                vol.setUserLabel(userLabel);
            }
        } else if (code != 630 && code != 631 && code != 632) {
            return LOCAL_LOGD;
        } else {
            StorageVolume volume;
            String action = null;
            String label = cooked[OBB_MCS_BOUND];
            path = cooked[OBB_MCS_UNBIND];
            try {
                String[] devTok = cooked[6].substring(OBB_RUN_ACTION, cooked[6].length() - 1).split(":");
                int major = Integer.parseInt(devTok[0]);
                int minor = Integer.parseInt(devTok[OBB_RUN_ACTION]);
            } catch (Exception ex) {
                Slog.e(TAG, "Failed to parse major/minor", ex);
            }
            synchronized (this.mVolumesLock) {
                volume = (StorageVolume) this.mVolumesByPath.get(path);
                String state = (String) this.mVolumeStates.get(path);
            }
            if (code == 630) {
                if (!(isUsbMassStorageConnected() && volume.allowMassStorage())) {
                    new C00634("MountService#VolumeDiskInserted", path).start();
                }
            } else if (code == 631) {
                if (getVolumeState(path).equals("bad_removal")) {
                    return true;
                }
                updatePublicVolumeState(volume, "unmounted");
                sendStorageIntent("android.intent.action.MEDIA_UNMOUNTED", volume, UserHandle.ALL);
                updatePublicVolumeState(volume, "removed");
                action = "android.intent.action.MEDIA_REMOVED";
            } else if (code == 632) {
                updatePublicVolumeState(volume, "unmounted");
                sendStorageIntent("android.intent.action.MEDIA_UNMOUNTED", volume, UserHandle.ALL);
                updatePublicVolumeState(volume, "bad_removal");
                action = "android.intent.action.MEDIA_BAD_REMOVAL";
            } else if (code == 700) {
                EventLogTags.writeFstrimFinish(SystemClock.elapsedRealtime());
            } else {
                String str = TAG;
                Object[] objArr = new Object[OBB_RUN_ACTION];
                objArr[0] = Integer.valueOf(code);
                Slog.e(str, String.format("Unknown code {%d}", objArr));
            }
            if (action != null) {
                sendStorageIntent(action, volume, UserHandle.ALL);
            }
        }
        return true;
    }

    private void notifyVolumeStateChange(String label, String path, int oldState, int newState) {
        synchronized (this.mVolumesLock) {
            StorageVolume volume = (StorageVolume) this.mVolumesByPath.get(path);
            String state = getVolumeState(path);
        }
        String action = null;
        if (oldState == 7 && newState != oldState) {
            sendStorageIntent("android.intent.action.MEDIA_UNSHARED", volume, UserHandle.ALL);
        }
        if (!(newState == -1 || newState == 0)) {
            if (newState == OBB_RUN_ACTION) {
                if (!(state.equals("bad_removal") || state.equals("nofs") || state.equals("unmountable") || getUmsEnabling())) {
                    updatePublicVolumeState(volume, "unmounted");
                    action = "android.intent.action.MEDIA_UNMOUNTED";
                }
                if (isUsbMassStorageConnected() && volume.allowMassStorage()) {
                    doShareUnshareVolume(path, "ums", true);
                }
            } else if (newState != OBB_MCS_BOUND) {
                if (newState == OBB_MCS_UNBIND) {
                    updatePublicVolumeState(volume, "checking");
                    action = "android.intent.action.MEDIA_CHECKING";
                } else if (newState == OBB_MCS_RECONNECT) {
                    updatePublicVolumeState(volume, "mounted");
                    action = "android.intent.action.MEDIA_MOUNTED";
                } else if (newState == OBB_FLUSH_MOUNT_STATE) {
                    action = "android.intent.action.MEDIA_EJECT";
                } else if (newState != 6) {
                    if (newState == 7) {
                        updatePublicVolumeState(volume, "unmounted");
                        sendStorageIntent("android.intent.action.MEDIA_UNMOUNTED", volume, UserHandle.ALL);
                        updatePublicVolumeState(volume, "shared");
                        action = "android.intent.action.MEDIA_SHARED";
                    } else if (newState == 8) {
                        Slog.e(TAG, "Live shared mounts not supported yet!");
                        return;
                    } else {
                        Slog.e(TAG, "Unhandled VolumeState {" + newState + "}");
                    }
                }
            }
        }
        if (action != null) {
            sendStorageIntent(action, volume, UserHandle.ALL);
        }
    }

    private int doMountVolume(String path) {
        int rc = 0;
        synchronized (this.mVolumesLock) {
            StorageVolume volume = (StorageVolume) this.mVolumesByPath.get(path);
        }
        if (volume.isEmulated() || !hasUserRestriction("no_physical_media")) {
            try {
                Object[] objArr = new Object[OBB_MCS_BOUND];
                objArr[0] = "mount";
                objArr[OBB_RUN_ACTION] = path;
                this.mConnector.execute("volume", objArr);
            } catch (NativeDaemonConnectorException e) {
                String action = null;
                int code = e.getCode();
                if (code == VoldResponseCode.OpFailedNoMedia) {
                    rc = -2;
                } else if (code == VoldResponseCode.OpFailedMediaBlank) {
                    updatePublicVolumeState(volume, "nofs");
                    action = "android.intent.action.MEDIA_NOFS";
                    rc = -3;
                } else if (code == VoldResponseCode.OpFailedMediaCorrupt) {
                    updatePublicVolumeState(volume, "unmountable");
                    action = "android.intent.action.MEDIA_UNMOUNTABLE";
                    rc = -4;
                } else {
                    rc = -1;
                }
                if (action != null) {
                    sendStorageIntent(action, volume, UserHandle.ALL);
                }
            }
            return rc;
        }
        Slog.w(TAG, "User has restriction DISALLOW_MOUNT_PHYSICAL_MEDIA; cannot mount volume.");
        return -1;
    }

    private int doUnmountVolume(String path, boolean force, boolean removeEncryption) {
        if (!getVolumeState(path).equals("mounted")) {
            return VoldResponseCode.OpFailedVolNotMounted;
        }
        Runtime.getRuntime().gc();
        this.mPms.updateExternalMediaStatus(LOCAL_LOGD, LOCAL_LOGD);
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "unmount";
            objArr[OBB_RUN_ACTION] = path;
            Command cmd = new Command("volume", objArr);
            if (removeEncryption) {
                cmd.appendArg("force_and_revert");
            } else if (force) {
                cmd.appendArg("force");
            }
            this.mConnector.execute(cmd);
            synchronized (this.mAsecMountSet) {
                this.mAsecMountSet.clear();
            }
            return 0;
        } catch (NativeDaemonConnectorException e) {
            int code = e.getCode();
            if (code == VoldResponseCode.OpFailedVolNotMounted) {
                return -5;
            }
            if (code == VoldResponseCode.OpFailedStorageBusy) {
                return -7;
            }
            return -1;
        }
    }

    private int doFormatVolume(String path) {
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "format";
            objArr[OBB_RUN_ACTION] = path;
            this.mConnector.execute("volume", objArr);
            return 0;
        } catch (NativeDaemonConnectorException e) {
            int code = e.getCode();
            if (code == VoldResponseCode.OpFailedNoMedia) {
                return -2;
            }
            if (code == VoldResponseCode.OpFailedMediaCorrupt) {
                return -4;
            }
            return -1;
        }
    }

    private boolean doGetVolumeShared(String path, String method) {
        try {
            Object[] objArr = new Object[OBB_MCS_UNBIND];
            objArr[0] = "shared";
            objArr[OBB_RUN_ACTION] = path;
            objArr[OBB_MCS_BOUND] = method;
            NativeDaemonEvent event = this.mConnector.execute("volume", objArr);
            if (event.getCode() == InputManagerService.SW_JACK_BITS) {
                return event.getMessage().endsWith("enabled");
            }
            return LOCAL_LOGD;
        } catch (NativeDaemonConnectorException e) {
            Slog.e(TAG, "Failed to read response to volume shared " + path + " " + method);
            return LOCAL_LOGD;
        }
    }

    private void notifyShareAvailabilityChange(boolean avail) {
        synchronized (this.mListeners) {
            this.mUmsAvailable = avail;
            for (int i = this.mListeners.size() - 1; i >= 0; i--) {
                try {
                    ((MountServiceBinderListener) this.mListeners.get(i)).mListener.onUsbMassStorageConnectionChanged(avail);
                } catch (RemoteException e) {
                    Slog.e(TAG, "Listener dead");
                    this.mListeners.remove(i);
                } catch (Exception ex) {
                    Slog.e(TAG, "Listener failed", ex);
                }
            }
        }
        if (this.mSystemReady) {
            sendUmsIntent(avail);
        } else {
            this.mSendUmsConnectedOnBoot = avail;
        }
        StorageVolume primary = getPrimaryPhysicalVolume();
        if (!avail && primary != null && "shared".equals(getVolumeState(primary.getPath()))) {
            new C00645("MountService#AvailabilityChange", primary.getPath()).start();
        }
    }

    private void sendStorageIntent(String action, StorageVolume volume, UserHandle user) {
        Intent intent = new Intent(action, Uri.parse("file://" + volume.getPath()));
        intent.putExtra("storage_volume", volume);
        intent.addFlags(67108864);
        Slog.d(TAG, "sendStorageIntent " + intent + " to " + user);
        this.mContext.sendBroadcastAsUser(intent, user);
    }

    private void sendUmsIntent(boolean c) {
        this.mContext.sendBroadcastAsUser(new Intent(c ? "android.intent.action.UMS_CONNECTED" : "android.intent.action.UMS_DISCONNECTED"), UserHandle.ALL);
    }

    private void validatePermission(String perm) {
        if (this.mContext.checkCallingOrSelfPermission(perm) != 0) {
            Object[] objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = perm;
            throw new SecurityException(String.format("Requires %s permission", objArr));
        }
    }

    private boolean hasUserRestriction(String restriction) {
        return ((UserManager) this.mContext.getSystemService("user")).hasUserRestriction(restriction, Binder.getCallingUserHandle());
    }

    private void validateUserRestriction(String restriction) {
        if (hasUserRestriction(restriction)) {
            throw new SecurityException("User has restriction " + restriction);
        }
    }

    private void readStorageListLocked() {
        int index;
        int index2;
        this.mVolumes.clear();
        this.mVolumeStates.clear();
        Resources resources = this.mContext.getResources();
        XmlResourceParser parser = resources.getXml(17891346);
        AttributeSet attrs = Xml.asAttributeSet(parser);
        Iterator i$;
        StorageVolume volume;
        try {
            XmlUtils.beginDocument(parser, TAG_STORAGE_LIST);
            while (true) {
                XmlUtils.nextElement(parser);
                String element = parser.getName();
                if (element == null) {
                    break;
                } else if (TAG_STORAGE.equals(element)) {
                    TypedArray a = resources.obtainAttributes(attrs, R.styleable.Storage);
                    String path = a.getString(0);
                    int descriptionId = a.getResourceId(OBB_RUN_ACTION, -1);
                    CharSequence description = a.getText(OBB_RUN_ACTION);
                    boolean primary = a.getBoolean(OBB_MCS_BOUND, LOCAL_LOGD);
                    boolean removable = a.getBoolean(OBB_MCS_UNBIND, LOCAL_LOGD);
                    boolean emulated = a.getBoolean(OBB_MCS_RECONNECT, LOCAL_LOGD);
                    int mtpReserve = a.getInt(OBB_FLUSH_MOUNT_STATE, 0);
                    boolean allowMassStorage = a.getBoolean(6, LOCAL_LOGD);
                    long maxFileSize = (((long) a.getInt(7, 0)) * 1024) * 1024;
                    String str = " removable: ";
                    str = " emulated: ";
                    str = " mtpReserve: ";
                    str = " allowMassStorage: ";
                    str = " maxFileSize: ";
                    Slog.d(TAG, "got storage path: " + path + " description: " + description + " primary: " + primary + r27 + removable + r27 + emulated + r27 + mtpReserve + r27 + allowMassStorage + r27 + maxFileSize);
                    if (emulated) {
                        this.mEmulatedTemplate = new StorageVolume(null, descriptionId, true, LOCAL_LOGD, true, mtpReserve, LOCAL_LOGD, maxFileSize, null);
                        for (UserInfo user : UserManagerService.getInstance().getUsers(LOCAL_LOGD)) {
                            createEmulatedVolumeForUserLocked(user.getUserHandle());
                        }
                    } else if (path == null || description == null) {
                        Slog.e(TAG, "Missing storage path or description in readStorageList");
                    } else {
                        volume = new StorageVolume(new File(path), descriptionId, primary, removable, emulated, mtpReserve, allowMassStorage, maxFileSize, null);
                        addVolumeLocked(volume);
                        this.mVolumeStates.put(volume.getPath(), "unmounted");
                        volume.setState("unmounted");
                    }
                    a.recycle();
                }
            }
            index = isExternalStorageEmulated() ? OBB_RUN_ACTION : 0;
            i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                volume = (StorageVolume) i$.next();
                if (!volume.isEmulated()) {
                    index2 = index + OBB_RUN_ACTION;
                    volume.setStorageId(index);
                    index = index2;
                }
            }
            parser.close();
        } catch (Throwable e) {
            throw new RuntimeException(e);
        } catch (Throwable e2) {
            throw new RuntimeException(e2);
        } catch (Throwable th) {
            index = isExternalStorageEmulated() ? OBB_RUN_ACTION : 0;
            i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                volume = (StorageVolume) i$.next();
                if (!volume.isEmulated()) {
                    index2 = index + OBB_RUN_ACTION;
                    volume.setStorageId(index);
                    index = index2;
                }
            }
            parser.close();
        }
    }

    private void createEmulatedVolumeForUserLocked(UserHandle user) {
        if (this.mEmulatedTemplate == null) {
            throw new IllegalStateException("Missing emulated volume multi-user template");
        }
        StorageVolume volume = StorageVolume.fromTemplate(this.mEmulatedTemplate, new UserEnvironment(user.getIdentifier()).getExternalStorageDirectory(), user);
        volume.setStorageId(0);
        addVolumeLocked(volume);
        if (this.mSystemReady) {
            updatePublicVolumeState(volume, "mounted");
            return;
        }
        this.mVolumeStates.put(volume.getPath(), "mounted");
        volume.setState("mounted");
    }

    private void addVolumeLocked(StorageVolume volume) {
        Slog.d(TAG, "addVolumeLocked() " + volume);
        this.mVolumes.add(volume);
        StorageVolume existing = (StorageVolume) this.mVolumesByPath.put(volume.getPath(), volume);
        if (existing != null) {
            throw new IllegalStateException("Volume at " + volume.getPath() + " already exists: " + existing);
        }
    }

    private void removeVolumeLocked(StorageVolume volume) {
        Slog.d(TAG, "removeVolumeLocked() " + volume);
        this.mVolumes.remove(volume);
        this.mVolumesByPath.remove(volume.getPath());
        this.mVolumeStates.remove(volume.getPath());
    }

    private StorageVolume getPrimaryPhysicalVolume() {
        synchronized (this.mVolumesLock) {
            Iterator i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                StorageVolume volume = (StorageVolume) i$.next();
                if (volume.isPrimary() && !volume.isEmulated()) {
                    return volume;
                }
            }
            return null;
        }
    }

    public MountService(Context context) {
        this.mVolumesLock = new Object();
        this.mVolumes = Lists.newArrayList();
        this.mVolumesByPath = Maps.newHashMap();
        this.mVolumeStates = Maps.newHashMap();
        this.mSystemReady = LOCAL_LOGD;
        this.mUmsAvailable = LOCAL_LOGD;
        this.mListeners = new ArrayList();
        this.mConnectedSignal = new CountDownLatch(OBB_RUN_ACTION);
        this.mAsecsScanned = new CountDownLatch(OBB_RUN_ACTION);
        this.mSendUmsConnectedOnBoot = LOCAL_LOGD;
        this.mAsecMountSet = new HashSet();
        this.mObbMounts = new HashMap();
        this.mObbPathToStateMap = new HashMap();
        this.mDefContainerConn = new DefaultContainerConnection();
        this.mContainerService = null;
        this.mUserReceiver = new C00601();
        this.mUsbReceiver = new C00612();
        sSelf = this;
        this.mContext = context;
        synchronized (this.mVolumesLock) {
            readStorageListLocked();
        }
        this.mPms = (PackageManagerService) ServiceManager.getService("package");
        HandlerThread hthread = new HandlerThread(TAG);
        hthread.start();
        this.mHandler = new MountServiceHandler(hthread.getLooper());
        IntentFilter userFilter = new IntentFilter();
        userFilter.addAction("android.intent.action.USER_ADDED");
        userFilter.addAction("android.intent.action.USER_REMOVED");
        this.mContext.registerReceiver(this.mUserReceiver, userFilter, null, this.mHandler);
        StorageVolume primary = getPrimaryPhysicalVolume();
        if (primary != null && primary.allowMassStorage()) {
            this.mContext.registerReceiver(this.mUsbReceiver, new IntentFilter("android.hardware.usb.action.USB_STATE"), null, this.mHandler);
        }
        this.mObbActionHandler = new ObbActionHandler(IoThread.get().getLooper());
        this.mLastMaintenanceFile = new File(new File(Environment.getDataDirectory(), "system"), LAST_FSTRIM_FILE);
        if (this.mLastMaintenanceFile.exists()) {
            this.mLastMaintenance = this.mLastMaintenanceFile.lastModified();
        } else {
            try {
                new FileOutputStream(this.mLastMaintenanceFile).close();
            } catch (IOException e) {
                Slog.e(TAG, "Unable to create fstrim record " + this.mLastMaintenanceFile.getPath());
            }
        }
        this.mConnector = new NativeDaemonConnector(this, "vold", SystemService.PHASE_SYSTEM_SERVICES_READY, VOLD_TAG, 25, null);
        new Thread(this.mConnector, VOLD_TAG).start();
    }

    public void systemReady() {
        this.mSystemReady = true;
        this.mHandler.obtainMessage(OBB_MCS_RECONNECT).sendToTarget();
    }

    public void registerListener(IMountServiceListener listener) {
        synchronized (this.mListeners) {
            MountServiceBinderListener bl = new MountServiceBinderListener(listener);
            try {
                listener.asBinder().linkToDeath(bl, 0);
                this.mListeners.add(bl);
            } catch (RemoteException e) {
                Slog.e(TAG, "Failed to link to listener death");
            }
        }
    }

    public void unregisterListener(IMountServiceListener listener) {
        synchronized (this.mListeners) {
            Iterator i$ = this.mListeners.iterator();
            while (i$.hasNext()) {
                MountServiceBinderListener bl = (MountServiceBinderListener) i$.next();
                if (bl.mListener.asBinder() == listener.asBinder()) {
                    this.mListeners.remove(this.mListeners.indexOf(bl));
                    listener.asBinder().unlinkToDeath(bl, 0);
                    return;
                }
            }
        }
    }

    public void shutdown(IMountShutdownObserver observer) {
        validatePermission("android.permission.SHUTDOWN");
        Slog.i(TAG, "Shutting down");
        synchronized (this.mVolumesLock) {
            MountShutdownLatch mountShutdownLatch = new MountShutdownLatch(observer, this.mVolumeStates.size());
            for (String path : this.mVolumeStates.keySet()) {
                String state = (String) this.mVolumeStates.get(path);
                if (state.equals("shared")) {
                    setUsbMassStorageEnabled(LOCAL_LOGD);
                } else if (state.equals("checking")) {
                    int retries;
                    int retries2 = RETRY_UNMOUNT_DELAY;
                    while (state.equals("checking")) {
                        retries = retries2 - 1;
                        if (retries2 < 0) {
                            break;
                        }
                        try {
                            Thread.sleep(1000);
                            state = Environment.getExternalStorageState();
                            retries2 = retries;
                        } catch (InterruptedException iex) {
                            Slog.e(TAG, "Interrupted while waiting for media", iex);
                        }
                    }
                    retries = retries2;
                    if (retries == 0) {
                        Slog.e(TAG, "Timed out waiting for media to check");
                    }
                }
                if (state.equals("mounted")) {
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(OBB_RUN_ACTION, new ShutdownCallBack(path, mountShutdownLatch)));
                } else if (observer != null) {
                    mountShutdownLatch.countDown();
                    Slog.i(TAG, "Unmount completed: " + path + ", result code: " + 0);
                }
            }
        }
    }

    private boolean getUmsEnabling() {
        boolean z;
        synchronized (this.mListeners) {
            z = this.mUmsEnabling;
        }
        return z;
    }

    private void setUmsEnabling(boolean enable) {
        synchronized (this.mListeners) {
            this.mUmsEnabling = enable;
        }
    }

    public boolean isUsbMassStorageConnected() {
        waitForReady();
        if (getUmsEnabling()) {
            return true;
        }
        boolean z;
        synchronized (this.mListeners) {
            z = this.mUmsAvailable;
        }
        return z;
    }

    public void setUsbMassStorageEnabled(boolean enable) {
        waitForReady();
        validatePermission("android.permission.MOUNT_UNMOUNT_FILESYSTEMS");
        validateUserRestriction("no_usb_file_transfer");
        StorageVolume primary = getPrimaryPhysicalVolume();
        if (primary != null) {
            String path = primary.getPath();
            String vs = getVolumeState(path);
            String method = "ums";
            if (enable && vs.equals("mounted")) {
                setUmsEnabling(enable);
                this.mHandler.sendMessage(this.mHandler.obtainMessage(OBB_RUN_ACTION, new UmsEnableCallBack(path, method, true)));
                setUmsEnabling(LOCAL_LOGD);
            }
            if (!enable) {
                doShareUnshareVolume(path, method, enable);
                if (doMountVolume(path) != 0) {
                    Slog.e(TAG, "Failed to remount " + path + " after disabling share method " + method);
                }
            }
        }
    }

    public boolean isUsbMassStorageEnabled() {
        waitForReady();
        StorageVolume primary = getPrimaryPhysicalVolume();
        if (primary != null) {
            return doGetVolumeShared(primary.getPath(), "ums");
        }
        return LOCAL_LOGD;
    }

    public String getVolumeState(String mountPoint) {
        String state;
        synchronized (this.mVolumesLock) {
            state = (String) this.mVolumeStates.get(mountPoint);
            if (state == null) {
                Slog.w(TAG, "getVolumeState(" + mountPoint + "): Unknown volume");
                if (SystemProperties.get("vold.encrypt_progress").length() != 0) {
                    state = "removed";
                } else {
                    throw new IllegalArgumentException();
                }
            }
        }
        return state;
    }

    public boolean isExternalStorageEmulated() {
        return this.mEmulatedTemplate != null ? true : LOCAL_LOGD;
    }

    public int mountVolume(String path) {
        validatePermission("android.permission.MOUNT_UNMOUNT_FILESYSTEMS");
        waitForReady();
        return doMountVolume(path);
    }

    public void unmountVolume(String path, boolean force, boolean removeEncryption) {
        validatePermission("android.permission.MOUNT_UNMOUNT_FILESYSTEMS");
        waitForReady();
        String volState = getVolumeState(path);
        if (!"unmounted".equals(volState) && !"removed".equals(volState) && !"shared".equals(volState) && !"unmountable".equals(volState)) {
            this.mHandler.sendMessage(this.mHandler.obtainMessage(OBB_RUN_ACTION, new UnmountCallBack(path, force, removeEncryption)));
        }
    }

    public int formatVolume(String path) {
        validatePermission("android.permission.MOUNT_FORMAT_FILESYSTEMS");
        waitForReady();
        return doFormatVolume(path);
    }

    public int[] getStorageUsers(String path) {
        validatePermission("android.permission.MOUNT_UNMOUNT_FILESYSTEMS");
        waitForReady();
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = TAG_STORAGE;
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = SoundModelContract.KEY_USERS;
            objArr[OBB_RUN_ACTION] = path;
            String[] r = NativeDaemonEvent.filterMessageList(nativeDaemonConnector.executeForList(str, objArr), HdmiCecKeycode.UI_BROADCAST_DIGITAL_CABLE);
            int[] data = new int[r.length];
            int i = 0;
            while (i < r.length) {
                String[] tok = r[i].split(" ");
                try {
                    data[i] = Integer.parseInt(tok[0]);
                    i += OBB_RUN_ACTION;
                } catch (NumberFormatException e) {
                    String str2 = TAG;
                    objArr = new Object[OBB_RUN_ACTION];
                    objArr[0] = tok[0];
                    Slog.e(str2, String.format("Error parsing pid %s", objArr));
                    return new int[0];
                }
            }
            return data;
        } catch (NativeDaemonConnectorException e2) {
            Slog.e(TAG, "Failed to retrieve storage users list", e2);
            return new int[0];
        }
    }

    private void warnOnNotMounted() {
        StorageVolume primary = getPrimaryPhysicalVolume();
        if (primary != null) {
            boolean mounted = LOCAL_LOGD;
            try {
                mounted = "mounted".equals(getVolumeState(primary.getPath()));
            } catch (IllegalArgumentException e) {
            }
            if (!mounted) {
                Slog.w(TAG, "getSecureContainerList() called when storage not mounted");
            }
        }
    }

    public String[] getSecureContainerList() {
        validatePermission("android.permission.ASEC_ACCESS");
        waitForReady();
        warnOnNotMounted();
        try {
            Object[] objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = "list";
            return NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("asec", objArr), NetdResponseCode.TetherInterfaceListResult);
        } catch (NativeDaemonConnectorException e) {
            return new String[0];
        }
    }

    public int createSecureContainer(String id, int sizeMb, String fstype, String key, int ownerUid, boolean external) {
        validatePermission("android.permission.ASEC_CREATE");
        waitForReady();
        warnOnNotMounted();
        int rc = 0;
        try {
            NativeDaemonConnector nativeDaemonConnector = this.mConnector;
            String str = "asec";
            Object[] objArr = new Object[7];
            objArr[0] = "create";
            objArr[OBB_RUN_ACTION] = id;
            objArr[OBB_MCS_BOUND] = Integer.valueOf(sizeMb);
            objArr[OBB_MCS_UNBIND] = fstype;
            objArr[OBB_MCS_RECONNECT] = new SensitiveArg(key);
            objArr[OBB_FLUSH_MOUNT_STATE] = Integer.valueOf(ownerUid);
            objArr[6] = external ? "1" : "0";
            nativeDaemonConnector.execute(str, objArr);
        } catch (NativeDaemonConnectorException e) {
            rc = -1;
        }
        if (rc == 0) {
            synchronized (this.mAsecMountSet) {
                this.mAsecMountSet.add(id);
            }
        }
        return rc;
    }

    public int resizeSecureContainer(String id, int sizeMb, String key) {
        validatePermission("android.permission.ASEC_CREATE");
        waitForReady();
        warnOnNotMounted();
        try {
            Object[] objArr = new Object[OBB_MCS_RECONNECT];
            objArr[0] = "resize";
            objArr[OBB_RUN_ACTION] = id;
            objArr[OBB_MCS_BOUND] = Integer.valueOf(sizeMb);
            objArr[OBB_MCS_UNBIND] = new SensitiveArg(key);
            this.mConnector.execute("asec", objArr);
            return 0;
        } catch (NativeDaemonConnectorException e) {
            return -1;
        }
    }

    public int finalizeSecureContainer(String id) {
        validatePermission("android.permission.ASEC_CREATE");
        warnOnNotMounted();
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "finalize";
            objArr[OBB_RUN_ACTION] = id;
            this.mConnector.execute("asec", objArr);
            return 0;
        } catch (NativeDaemonConnectorException e) {
            return -1;
        }
    }

    public int fixPermissionsSecureContainer(String id, int gid, String filename) {
        validatePermission("android.permission.ASEC_CREATE");
        warnOnNotMounted();
        try {
            Object[] objArr = new Object[OBB_MCS_RECONNECT];
            objArr[0] = "fixperms";
            objArr[OBB_RUN_ACTION] = id;
            objArr[OBB_MCS_BOUND] = Integer.valueOf(gid);
            objArr[OBB_MCS_UNBIND] = filename;
            this.mConnector.execute("asec", objArr);
            return 0;
        } catch (NativeDaemonConnectorException e) {
            return -1;
        }
    }

    public int destroySecureContainer(String id, boolean force) {
        validatePermission("android.permission.ASEC_DESTROY");
        waitForReady();
        warnOnNotMounted();
        Runtime.getRuntime().gc();
        int rc = 0;
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "destroy";
            objArr[OBB_RUN_ACTION] = id;
            Command cmd = new Command("asec", objArr);
            if (force) {
                cmd.appendArg("force");
            }
            this.mConnector.execute(cmd);
        } catch (NativeDaemonConnectorException e) {
            if (e.getCode() == VoldResponseCode.OpFailedStorageBusy) {
                rc = -7;
            } else {
                rc = -1;
            }
        }
        if (rc == 0) {
            synchronized (this.mAsecMountSet) {
                if (this.mAsecMountSet.contains(id)) {
                    this.mAsecMountSet.remove(id);
                }
            }
        }
        return rc;
    }

    public int mountSecureContainer(String id, String key, int ownerUid, boolean readOnly) {
        int i;
        validatePermission("android.permission.ASEC_MOUNT_UNMOUNT");
        waitForReady();
        warnOnNotMounted();
        synchronized (this.mAsecMountSet) {
            if (this.mAsecMountSet.contains(id)) {
                i = -6;
            } else {
                i = 0;
                try {
                    NativeDaemonConnector nativeDaemonConnector = this.mConnector;
                    String str = "asec";
                    Object[] objArr = new Object[OBB_FLUSH_MOUNT_STATE];
                    objArr[0] = "mount";
                    objArr[OBB_RUN_ACTION] = id;
                    objArr[OBB_MCS_BOUND] = new SensitiveArg(key);
                    objArr[OBB_MCS_UNBIND] = Integer.valueOf(ownerUid);
                    objArr[OBB_MCS_RECONNECT] = readOnly ? "ro" : "rw";
                    nativeDaemonConnector.execute(str, objArr);
                } catch (NativeDaemonConnectorException e) {
                    if (e.getCode() != VoldResponseCode.OpFailedStorageBusy) {
                        i = -1;
                    }
                }
                if (i == 0) {
                    synchronized (this.mAsecMountSet) {
                        this.mAsecMountSet.add(id);
                    }
                }
            }
        }
        return i;
    }

    public int unmountSecureContainer(String id, boolean force) {
        int rc;
        validatePermission("android.permission.ASEC_MOUNT_UNMOUNT");
        waitForReady();
        warnOnNotMounted();
        synchronized (this.mAsecMountSet) {
            if (this.mAsecMountSet.contains(id)) {
                Runtime.getRuntime().gc();
                rc = 0;
                try {
                    Object[] objArr = new Object[OBB_MCS_BOUND];
                    objArr[0] = "unmount";
                    objArr[OBB_RUN_ACTION] = id;
                    Command cmd = new Command("asec", objArr);
                    if (force) {
                        cmd.appendArg("force");
                    }
                    this.mConnector.execute(cmd);
                } catch (NativeDaemonConnectorException e) {
                    if (e.getCode() == VoldResponseCode.OpFailedStorageBusy) {
                        rc = -7;
                    } else {
                        rc = -1;
                    }
                }
                if (rc == 0) {
                    synchronized (this.mAsecMountSet) {
                        this.mAsecMountSet.remove(id);
                    }
                }
            } else {
                rc = -5;
            }
        }
        return rc;
    }

    public boolean isSecureContainerMounted(String id) {
        boolean contains;
        validatePermission("android.permission.ASEC_ACCESS");
        waitForReady();
        warnOnNotMounted();
        synchronized (this.mAsecMountSet) {
            contains = this.mAsecMountSet.contains(id);
        }
        return contains;
    }

    public int renameSecureContainer(String oldId, String newId) {
        validatePermission("android.permission.ASEC_RENAME");
        waitForReady();
        warnOnNotMounted();
        synchronized (this.mAsecMountSet) {
            if (this.mAsecMountSet.contains(oldId) || this.mAsecMountSet.contains(newId)) {
                return -6;
            }
            try {
                Object[] objArr = new Object[OBB_MCS_UNBIND];
                objArr[0] = "rename";
                objArr[OBB_RUN_ACTION] = oldId;
                objArr[OBB_MCS_BOUND] = newId;
                this.mConnector.execute("asec", objArr);
                return 0;
            } catch (NativeDaemonConnectorException e) {
                return -1;
            }
        }
    }

    public String getSecureContainerPath(String id) {
        validatePermission("android.permission.ASEC_ACCESS");
        waitForReady();
        warnOnNotMounted();
        Object[] objArr;
        try {
            objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "path";
            objArr[OBB_RUN_ACTION] = id;
            NativeDaemonEvent event = this.mConnector.execute("asec", objArr);
            event.checkCode(NetdResponseCode.IpFwdStatusResult);
            return event.getMessage();
        } catch (NativeDaemonConnectorException e) {
            int code = e.getCode();
            if (code == VoldResponseCode.OpFailedStorageNotFound) {
                String str = TAG;
                objArr = new Object[OBB_RUN_ACTION];
                objArr[0] = id;
                Slog.i(str, String.format("Container '%s' not found", objArr));
                return null;
            }
            objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = Integer.valueOf(code);
            throw new IllegalStateException(String.format("Unexpected response code %d", objArr));
        }
    }

    public String getSecureContainerFilesystemPath(String id) {
        Object[] objArr;
        validatePermission("android.permission.ASEC_ACCESS");
        waitForReady();
        warnOnNotMounted();
        try {
            objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "fspath";
            objArr[OBB_RUN_ACTION] = id;
            NativeDaemonEvent event = this.mConnector.execute("asec", objArr);
            event.checkCode(NetdResponseCode.IpFwdStatusResult);
            return event.getMessage();
        } catch (NativeDaemonConnectorException e) {
            int code = e.getCode();
            if (code == VoldResponseCode.OpFailedStorageNotFound) {
                String str = TAG;
                objArr = new Object[OBB_RUN_ACTION];
                objArr[0] = id;
                Slog.i(str, String.format("Container '%s' not found", objArr));
                return null;
            }
            objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = Integer.valueOf(code);
            throw new IllegalStateException(String.format("Unexpected response code %d", objArr));
        }
    }

    public void finishMediaUpdate() {
        this.mHandler.sendEmptyMessage(OBB_MCS_BOUND);
    }

    private boolean isUidOwnerOfPackageOrSystem(String packageName, int callerUid) {
        if (callerUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            return true;
        }
        if (packageName == null) {
            return LOCAL_LOGD;
        }
        if (callerUid != this.mPms.getPackageUid(packageName, UserHandle.getUserId(callerUid))) {
            return LOCAL_LOGD;
        }
        return true;
    }

    public String getMountedObbPath(String rawPath) {
        String str = null;
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        waitForReady();
        warnOnNotMounted();
        synchronized (this.mObbPathToStateMap) {
            ObbState state = (ObbState) this.mObbPathToStateMap.get(rawPath);
        }
        if (state == null) {
            Slog.w(TAG, "Failed to find OBB mounted at " + rawPath);
        } else {
            try {
                Object[] objArr = new Object[OBB_MCS_BOUND];
                objArr[0] = "path";
                objArr[OBB_RUN_ACTION] = state.voldPath;
                NativeDaemonEvent event = this.mConnector.execute("obb", objArr);
                event.checkCode(NetdResponseCode.IpFwdStatusResult);
                str = event.getMessage();
            } catch (NativeDaemonConnectorException e) {
                int code = e.getCode();
                if (code != VoldResponseCode.OpFailedStorageNotFound) {
                    Object[] objArr2 = new Object[OBB_RUN_ACTION];
                    objArr2[0] = Integer.valueOf(code);
                    throw new IllegalStateException(String.format("Unexpected response code %d", objArr2));
                }
            }
        }
        return str;
    }

    public boolean isObbMounted(String rawPath) {
        boolean containsKey;
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        synchronized (this.mObbMounts) {
            containsKey = this.mObbPathToStateMap.containsKey(rawPath);
        }
        return containsKey;
    }

    public void mountObb(String rawPath, String canonicalPath, String key, IObbActionListener token, int nonce) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        Preconditions.checkNotNull(canonicalPath, "canonicalPath cannot be null");
        Preconditions.checkNotNull(token, "token cannot be null");
        int callingUid = Binder.getCallingUid();
        this.mObbActionHandler.sendMessage(this.mObbActionHandler.obtainMessage(OBB_RUN_ACTION, new MountObbAction(new ObbState(rawPath, canonicalPath, callingUid, token, nonce), key, callingUid)));
    }

    public void unmountObb(String rawPath, boolean force, IObbActionListener token, int nonce) {
        Preconditions.checkNotNull(rawPath, "rawPath cannot be null");
        synchronized (this.mObbPathToStateMap) {
            ObbState existingState = (ObbState) this.mObbPathToStateMap.get(rawPath);
        }
        if (existingState != null) {
            String str = rawPath;
            this.mObbActionHandler.sendMessage(this.mObbActionHandler.obtainMessage(OBB_RUN_ACTION, new UnmountObbAction(new ObbState(str, existingState.canonicalPath, Binder.getCallingUid(), token, nonce), force)));
            return;
        }
        Slog.w(TAG, "Unknown OBB mount at " + rawPath);
    }

    public int getEncryptionState() {
        int i = -1;
        this.mContext.enforceCallingOrSelfPermission("android.permission.CRYPT_KEEPER", "no permission to access the crypt keeper");
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = "cryptocomplete";
            i = Integer.parseInt(this.mConnector.execute("cryptfs", objArr).getMessage());
        } catch (NumberFormatException e) {
            Slog.w(TAG, "Unable to parse result from cryptfs cryptocomplete");
        } catch (NativeDaemonConnectorException e2) {
            Slog.w(TAG, "Error in communicating with cryptfs in validating");
        }
        return i;
    }

    private String toHex(String password) {
        if (password == null) {
            return new String();
        }
        return new String(Hex.encodeHex(password.getBytes(StandardCharsets.UTF_8)));
    }

    private String fromHex(String hexPassword) {
        if (hexPassword == null) {
            return null;
        }
        try {
            return new String(Hex.decodeHex(hexPassword.toCharArray()), StandardCharsets.UTF_8);
        } catch (DecoderException e) {
            return null;
        }
    }

    public int decryptStorage(String password) {
        if (TextUtils.isEmpty(password)) {
            throw new IllegalArgumentException("password cannot be empty");
        }
        this.mContext.enforceCallingOrSelfPermission("android.permission.CRYPT_KEEPER", "no permission to access the crypt keeper");
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "checkpw";
            objArr[OBB_RUN_ACTION] = new SensitiveArg(toHex(password));
            int code = Integer.parseInt(this.mConnector.execute("cryptfs", objArr).getMessage());
            if (code != 0) {
                return code;
            }
            this.mHandler.postDelayed(new C00656(), 1000);
            return code;
        } catch (NativeDaemonConnectorException e) {
            return e.getCode();
        }
    }

    public int encryptStorage(int type, String password) {
        if (!TextUtils.isEmpty(password) || type == OBB_RUN_ACTION) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.CRYPT_KEEPER", "no permission to access the crypt keeper");
            waitForReady();
            try {
                Object[] objArr = new Object[OBB_MCS_RECONNECT];
                objArr[0] = "enablecrypto";
                objArr[OBB_RUN_ACTION] = "inplace";
                objArr[OBB_MCS_BOUND] = CRYPTO_TYPES[type];
                objArr[OBB_MCS_UNBIND] = new SensitiveArg(toHex(password));
                this.mConnector.execute("cryptfs", objArr);
                return 0;
            } catch (NativeDaemonConnectorException e) {
                return e.getCode();
            }
        }
        throw new IllegalArgumentException("password cannot be empty");
    }

    public int changeEncryptionPassword(int type, String password) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.CRYPT_KEEPER", "no permission to access the crypt keeper");
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_MCS_UNBIND];
            objArr[0] = "changepw";
            objArr[OBB_RUN_ACTION] = CRYPTO_TYPES[type];
            objArr[OBB_MCS_BOUND] = new SensitiveArg(toHex(password));
            return Integer.parseInt(this.mConnector.execute("cryptfs", objArr).getMessage());
        } catch (NativeDaemonConnectorException e) {
            return e.getCode();
        }
    }

    public int verifyEncryptionPassword(String password) throws RemoteException {
        if (Binder.getCallingUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            throw new SecurityException("no permission to access the crypt keeper");
        }
        this.mContext.enforceCallingOrSelfPermission("android.permission.CRYPT_KEEPER", "no permission to access the crypt keeper");
        if (TextUtils.isEmpty(password)) {
            throw new IllegalArgumentException("password cannot be empty");
        }
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "verifypw";
            objArr[OBB_RUN_ACTION] = new SensitiveArg(toHex(password));
            NativeDaemonEvent event = this.mConnector.execute("cryptfs", objArr);
            Slog.i(TAG, "cryptfs verifypw => " + event.getMessage());
            return Integer.parseInt(event.getMessage());
        } catch (NativeDaemonConnectorException e) {
            return e.getCode();
        }
    }

    public int getPasswordType() {
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = "getpwtype";
            NativeDaemonEvent event = this.mConnector.execute("cryptfs", objArr);
            for (int i = 0; i < CRYPTO_TYPES.length; i += OBB_RUN_ACTION) {
                if (CRYPTO_TYPES[i].equals(event.getMessage())) {
                    return i;
                }
            }
            throw new IllegalStateException("unexpected return from cryptfs");
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void setField(String field, String contents) throws RemoteException {
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_MCS_UNBIND];
            objArr[0] = "setfield";
            objArr[OBB_RUN_ACTION] = field;
            objArr[OBB_MCS_BOUND] = contents;
            NativeDaemonEvent event = this.mConnector.execute("cryptfs", objArr);
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public String getField(String field) throws RemoteException {
        waitForReady();
        try {
            Object[] objArr = new Object[OBB_MCS_BOUND];
            objArr[0] = "getfield";
            objArr[OBB_RUN_ACTION] = field;
            String[] contents = NativeDaemonEvent.filterMessageList(this.mConnector.executeForList("cryptfs", objArr), HdmiCecKeycode.CEC_KEYCODE_F1_BLUE);
            String result = new String();
            String[] arr$ = contents;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += OBB_RUN_ACTION) {
                result = result + arr$[i$];
            }
            return result;
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public String getPassword() throws RemoteException {
        if (!isReady()) {
            return new String();
        }
        try {
            Object[] objArr = new Object[OBB_RUN_ACTION];
            objArr[0] = "getpw";
            return fromHex(this.mConnector.execute("cryptfs", objArr).getMessage());
        } catch (NativeDaemonConnectorException e) {
            throw e.rethrowAsParcelableException();
        }
    }

    public void clearPassword() throws RemoteException {
        if (isReady()) {
            try {
                Object[] objArr = new Object[OBB_RUN_ACTION];
                objArr[0] = "clearpw";
                NativeDaemonEvent event = this.mConnector.execute("cryptfs", objArr);
            } catch (NativeDaemonConnectorException e) {
                throw e.rethrowAsParcelableException();
            }
        }
    }

    public int mkdirs(String callingPkg, String appPath) {
        UserEnvironment userEnv = new UserEnvironment(UserHandle.getUserId(Binder.getCallingUid()));
        ((AppOpsManager) this.mContext.getSystemService("appops")).checkPackage(Binder.getCallingUid(), callingPkg);
        try {
            appPath = new File(appPath).getCanonicalPath();
            if (!appPath.endsWith("/")) {
                appPath = appPath + "/";
            }
            String voldPath = maybeTranslatePathForVold(appPath, userEnv.buildExternalStorageAppDataDirs(callingPkg), userEnv.buildExternalStorageAppDataDirsForVold(callingPkg));
            Object[] objArr;
            if (voldPath != null) {
                try {
                    objArr = new Object[OBB_MCS_BOUND];
                    objArr[0] = "mkdirs";
                    objArr[OBB_RUN_ACTION] = voldPath;
                    this.mConnector.execute("volume", objArr);
                    return 0;
                } catch (NativeDaemonConnectorException e) {
                    return e.getCode();
                }
            }
            voldPath = maybeTranslatePathForVold(appPath, userEnv.buildExternalStorageAppObbDirs(callingPkg), userEnv.buildExternalStorageAppObbDirsForVold(callingPkg));
            if (voldPath != null) {
                try {
                    objArr = new Object[OBB_MCS_BOUND];
                    objArr[0] = "mkdirs";
                    objArr[OBB_RUN_ACTION] = voldPath;
                    this.mConnector.execute("volume", objArr);
                    return 0;
                } catch (NativeDaemonConnectorException e2) {
                    return e2.getCode();
                }
            }
            voldPath = maybeTranslatePathForVold(appPath, userEnv.buildExternalStorageAppMediaDirs(callingPkg), userEnv.buildExternalStorageAppMediaDirsForVold(callingPkg));
            if (voldPath != null) {
                try {
                    objArr = new Object[OBB_MCS_BOUND];
                    objArr[0] = "mkdirs";
                    objArr[OBB_RUN_ACTION] = voldPath;
                    this.mConnector.execute("volume", objArr);
                    return 0;
                } catch (NativeDaemonConnectorException e22) {
                    return e22.getCode();
                }
            }
            throw new SecurityException("Invalid mkdirs path: " + appPath);
        } catch (IOException e3) {
            Slog.e(TAG, "Failed to resolve " + appPath + ": " + e3);
            return -1;
        }
    }

    public static String maybeTranslatePathForVold(String path, File[] appPaths, File[] voldPaths) {
        if (appPaths.length != voldPaths.length) {
            throw new IllegalStateException("Paths must be 1:1 mapping");
        }
        for (int i = 0; i < appPaths.length; i += OBB_RUN_ACTION) {
            String appPath = appPaths[i].getAbsolutePath() + "/";
            if (path.startsWith(appPath)) {
                path = new File(voldPaths[i], path.substring(appPath.length())).getAbsolutePath();
                if (path.endsWith("/")) {
                    return path;
                }
                return path + "/";
            }
        }
        return null;
    }

    public StorageVolume[] getVolumeList() {
        boolean accessAll;
        StorageVolume[] storageVolumeArr;
        int callingUserId = UserHandle.getCallingUserId();
        if (this.mContext.checkPermission("android.permission.ACCESS_ALL_EXTERNAL_STORAGE", Binder.getCallingPid(), Binder.getCallingUid()) == 0) {
            accessAll = true;
        } else {
            accessAll = LOCAL_LOGD;
        }
        synchronized (this.mVolumesLock) {
            ArrayList<StorageVolume> filtered = Lists.newArrayList();
            Iterator i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                StorageVolume volume = (StorageVolume) i$.next();
                UserHandle owner = volume.getOwner();
                boolean ownerMatch;
                if (owner == null || owner.getIdentifier() == callingUserId) {
                    ownerMatch = true;
                } else {
                    ownerMatch = LOCAL_LOGD;
                }
                if (accessAll || ownerMatch) {
                    filtered.add(volume);
                }
            }
            storageVolumeArr = (StorageVolume[]) filtered.toArray(new StorageVolume[filtered.size()]);
        }
        return storageVolumeArr;
    }

    private void addObbStateLocked(ObbState obbState) throws RemoteException {
        IBinder binder = obbState.getBinder();
        List<ObbState> obbStates = (List) this.mObbMounts.get(binder);
        if (obbStates == null) {
            obbStates = new ArrayList();
            this.mObbMounts.put(binder, obbStates);
        } else {
            for (ObbState o : obbStates) {
                if (o.rawPath.equals(obbState.rawPath)) {
                    throw new IllegalStateException("Attempt to add ObbState twice. This indicates an error in the MountService logic.");
                }
            }
        }
        obbStates.add(obbState);
        try {
            obbState.link();
            this.mObbPathToStateMap.put(obbState.rawPath, obbState);
        } catch (RemoteException e) {
            obbStates.remove(obbState);
            if (obbStates.isEmpty()) {
                this.mObbMounts.remove(binder);
            }
            throw e;
        }
    }

    private void removeObbStateLocked(ObbState obbState) {
        IBinder binder = obbState.getBinder();
        List<ObbState> obbStates = (List) this.mObbMounts.get(binder);
        if (obbStates != null) {
            if (obbStates.remove(obbState)) {
                obbState.unlink();
            }
            if (obbStates.isEmpty()) {
                this.mObbMounts.remove(binder);
            }
        }
        this.mObbPathToStateMap.remove(obbState.rawPath);
    }

    public static String buildObbPath(String canonicalPath, int userId, boolean forVold) {
        if (!Environment.isExternalStorageEmulated()) {
            return canonicalPath;
        }
        String path = canonicalPath.toString();
        UserEnvironment userEnv = new UserEnvironment(userId);
        String externalPath = userEnv.getExternalStorageDirectory().getAbsolutePath();
        String legacyExternalPath = Environment.getLegacyExternalStorageDirectory().getAbsolutePath();
        if (path.startsWith(externalPath)) {
            path = path.substring(externalPath.length() + OBB_RUN_ACTION);
        } else if (!path.startsWith(legacyExternalPath)) {
            return canonicalPath;
        } else {
            path = path.substring(legacyExternalPath.length() + OBB_RUN_ACTION);
        }
        String obbPath = "Android/obb";
        if (path.startsWith("Android/obb")) {
            path = path.substring("Android/obb".length() + OBB_RUN_ACTION);
            UserEnvironment ownerEnv = new UserEnvironment(0);
            if (forVold) {
                return new File(ownerEnv.buildExternalStorageAndroidObbDirsForVold()[0], path).getAbsolutePath();
            }
            return new File(ownerEnv.buildExternalStorageAndroidObbDirs()[0], path).getAbsolutePath();
        } else if (forVold) {
            return new File(Environment.getEmulatedStorageSource(userId), path).getAbsolutePath();
        } else {
            return new File(userEnv.getExternalDirsForApp()[0], path).getAbsolutePath();
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        IndentingPrintWriter pw = new IndentingPrintWriter(writer, "  ", HdmiCecKeycode.UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_EQUALIZER);
        synchronized (this.mObbMounts) {
            pw.println("mObbMounts:");
            pw.increaseIndent();
            for (Entry<IBinder, List<ObbState>> e : this.mObbMounts.entrySet()) {
                Iterator i$;
                pw.println(e.getKey() + ":");
                pw.increaseIndent();
                for (ObbState obbState : (List) e.getValue()) {
                    pw.println(obbState);
                }
                pw.decreaseIndent();
            }
            pw.decreaseIndent();
            pw.println();
            pw.println("mObbPathToStateMap:");
            pw.increaseIndent();
            for (Entry<String, ObbState> e2 : this.mObbPathToStateMap.entrySet()) {
                pw.print((String) e2.getKey());
                pw.print(" -> ");
                pw.println(e2.getValue());
            }
            pw.decreaseIndent();
        }
        synchronized (this.mVolumesLock) {
            pw.println();
            pw.println("mVolumes:");
            pw.increaseIndent();
            i$ = this.mVolumes.iterator();
            while (i$.hasNext()) {
                StorageVolume volume = (StorageVolume) i$.next();
                pw.println(volume);
                pw.increaseIndent();
                pw.println("Current state: " + ((String) this.mVolumeStates.get(volume.getPath())));
                pw.decreaseIndent();
            }
            pw.decreaseIndent();
        }
        pw.println();
        pw.println("mConnection:");
        pw.increaseIndent();
        this.mConnector.dump(fd, pw, args);
        pw.decreaseIndent();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        pw.println();
        pw.print("Last maintenance: ");
        pw.println(sdf.format(new Date(this.mLastMaintenance)));
    }

    public void monitor() {
        if (this.mConnector != null) {
            this.mConnector.monitor();
        }
    }
}
