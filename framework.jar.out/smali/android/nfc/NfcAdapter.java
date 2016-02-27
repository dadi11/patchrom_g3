package android.nfc;

import android.app.Activity;
import android.app.ActivityThread;
import android.app.AppOpsManager;
import android.app.OnActivityPausedListener;
import android.app.PendingIntent;
import android.content.ContentResolver;
import android.content.Context;
import android.content.IntentFilter;
import android.content.pm.IPackageManager;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.nfc.INfcUnlockHandler.Stub;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.Log;
import java.util.HashMap;

public final class NfcAdapter {
    public static final String ACTION_ADAPTER_STATE_CHANGED = "android.nfc.action.ADAPTER_STATE_CHANGED";
    public static final String ACTION_HANDOVER_TRANSFER_DONE = "android.nfc.action.HANDOVER_TRANSFER_DONE";
    public static final String ACTION_HANDOVER_TRANSFER_STARTED = "android.nfc.action.HANDOVER_TRANSFER_STARTED";
    public static final String ACTION_NDEF_DISCOVERED = "android.nfc.action.NDEF_DISCOVERED";
    public static final String ACTION_TAG_DISCOVERED = "android.nfc.action.TAG_DISCOVERED";
    public static final String ACTION_TAG_LEFT_FIELD = "android.nfc.action.TAG_LOST";
    public static final String ACTION_TECH_DISCOVERED = "android.nfc.action.TECH_DISCOVERED";
    public static final String EXTRA_ADAPTER_STATE = "android.nfc.extra.ADAPTER_STATE";
    public static final String EXTRA_HANDOVER_TRANSFER_STATUS = "android.nfc.extra.HANDOVER_TRANSFER_STATUS";
    public static final String EXTRA_HANDOVER_TRANSFER_URI = "android.nfc.extra.HANDOVER_TRANSFER_URI";
    public static final String EXTRA_ID = "android.nfc.extra.ID";
    public static final String EXTRA_NDEF_MESSAGES = "android.nfc.extra.NDEF_MESSAGES";
    public static final String EXTRA_READER_PRESENCE_CHECK_DELAY = "presence";
    public static final String EXTRA_TAG = "android.nfc.extra.TAG";
    public static final int FLAG_NDEF_PUSH_NO_CONFIRM = 1;
    public static final int FLAG_READER_NFC_A = 1;
    public static final int FLAG_READER_NFC_B = 2;
    public static final int FLAG_READER_NFC_BARCODE = 16;
    public static final int FLAG_READER_NFC_F = 4;
    public static final int FLAG_READER_NFC_V = 8;
    public static final int FLAG_READER_NO_PLATFORM_SOUNDS = 256;
    public static final int FLAG_READER_SKIP_NDEF_CHECK = 128;
    public static final int HANDOVER_TRANSFER_STATUS_FAILURE = 1;
    public static final int HANDOVER_TRANSFER_STATUS_SUCCESS = 0;
    public static final int STATE_OFF = 1;
    public static final int STATE_ON = 3;
    public static final int STATE_TURNING_OFF = 4;
    public static final int STATE_TURNING_ON = 2;
    static final String TAG = "NFC";
    static INfcCardEmulation sCardEmulationService;
    static boolean sIsInitialized;
    static HashMap<Context, NfcAdapter> sNfcAdapters;
    static NfcAdapter sNullContextNfcAdapter;
    static INfcAdapter sService;
    static INfcTag sTagService;
    private final AppOpsManager mAppOps;
    final Context mContext;
    OnActivityPausedListener mForegroundDispatchListener;
    final Object mLock;
    final NfcActivityManager mNfcActivityManager;
    final HashMap<NfcUnlockHandler, INfcUnlockHandler> mNfcUnlockHandlers;

    /* renamed from: android.nfc.NfcAdapter.1 */
    class C05651 implements OnActivityPausedListener {
        C05651() {
        }

        public void onPaused(Activity activity) {
            NfcAdapter.this.disableForegroundDispatchInternal(activity, true);
        }
    }

    /* renamed from: android.nfc.NfcAdapter.2 */
    class C05662 extends Stub {
        final /* synthetic */ NfcUnlockHandler val$unlockHandler;

        C05662(NfcUnlockHandler nfcUnlockHandler) {
            this.val$unlockHandler = nfcUnlockHandler;
        }

        public boolean onUnlockAttempted(Tag tag) throws RemoteException {
            return this.val$unlockHandler.onUnlockAttempted(tag);
        }
    }

    public interface CreateBeamUrisCallback {
        Uri[] createBeamUris(NfcEvent nfcEvent);
    }

    public interface CreateNdefMessageCallback {
        NdefMessage createNdefMessage(NfcEvent nfcEvent);
    }

    public interface NfcUnlockHandler {
        boolean onUnlockAttempted(Tag tag);
    }

    public interface OnNdefPushCompleteCallback {
        void onNdefPushComplete(NfcEvent nfcEvent);
    }

    public interface ReaderCallback {
        void onTagDiscovered(Tag tag);
    }

    static {
        sIsInitialized = false;
        sNfcAdapters = new HashMap();
    }

    private static boolean hasNfcFeature() {
        boolean z = false;
        IPackageManager pm = ActivityThread.getPackageManager();
        if (pm == null) {
            Log.e(TAG, "Cannot get package manager, assuming no NFC feature");
        } else {
            try {
                z = pm.hasSystemFeature(PackageManager.FEATURE_NFC);
            } catch (RemoteException e) {
                Log.e(TAG, "Package manager query failed, assuming no NFC feature", e);
            }
        }
        return z;
    }

    public static synchronized NfcAdapter getNfcAdapter(Context context) {
        NfcAdapter nfcAdapter;
        synchronized (NfcAdapter.class) {
            if (!sIsInitialized) {
                if (hasNfcFeature()) {
                    sService = getServiceInterface();
                    if (sService == null) {
                        Log.e(TAG, "could not retrieve NFC service");
                        throw new UnsupportedOperationException();
                    }
                    try {
                        sTagService = sService.getNfcTagInterface();
                        sCardEmulationService = sService.getNfcCardEmulationInterface();
                        sIsInitialized = true;
                    } catch (RemoteException e) {
                        Log.e(TAG, "could not retrieve card emulation service");
                        throw new UnsupportedOperationException();
                    } catch (RemoteException e2) {
                        Log.e(TAG, "could not retrieve NFC Tag service");
                        throw new UnsupportedOperationException();
                    }
                }
                Log.v(TAG, "this device does not have NFC support");
                throw new UnsupportedOperationException();
            }
            if (context == null) {
                if (sNullContextNfcAdapter == null) {
                    sNullContextNfcAdapter = new NfcAdapter(null);
                }
                nfcAdapter = sNullContextNfcAdapter;
            } else {
                nfcAdapter = (NfcAdapter) sNfcAdapters.get(context);
                if (nfcAdapter == null) {
                    nfcAdapter = new NfcAdapter(context);
                    sNfcAdapters.put(context, nfcAdapter);
                }
            }
        }
        return nfcAdapter;
    }

    private static INfcAdapter getServiceInterface() {
        IBinder b = ServiceManager.getService(Context.NFC_SERVICE);
        if (b == null) {
            return null;
        }
        return INfcAdapter.Stub.asInterface(b);
    }

    public static NfcAdapter getDefaultAdapter(Context context) {
        if (context == null) {
            throw new IllegalArgumentException("context cannot be null");
        }
        context = context.getApplicationContext();
        if (context == null) {
            throw new IllegalArgumentException("context not associated with any application (using a mock context?)");
        }
        NfcManager manager = (NfcManager) context.getSystemService(Context.NFC_SERVICE);
        if (manager == null) {
            return null;
        }
        return manager.getDefaultAdapter();
    }

    @Deprecated
    public static NfcAdapter getDefaultAdapter() {
        Log.w(TAG, "WARNING: NfcAdapter.getDefaultAdapter() is deprecated, use NfcAdapter.getDefaultAdapter(Context) instead", new Exception());
        return getNfcAdapter(null);
    }

    NfcAdapter(Context context) {
        this.mForegroundDispatchListener = new C05651();
        this.mContext = context;
        this.mNfcActivityManager = new NfcActivityManager(this);
        this.mNfcUnlockHandlers = new HashMap();
        this.mLock = new Object();
        this.mAppOps = (AppOpsManager) context.getSystemService(Context.APP_OPS_SERVICE);
    }

    public Context getContext() {
        return this.mContext;
    }

    public INfcAdapter getService() {
        isEnabled();
        return sService;
    }

    public INfcTag getTagService() {
        isEnabled();
        return sTagService;
    }

    public INfcCardEmulation getCardEmulationService() {
        isEnabled();
        return sCardEmulationService;
    }

    public void attemptDeadServiceRecovery(Exception e) {
        Log.e(TAG, "NFC service dead - attempting to recover", e);
        INfcAdapter service = getServiceInterface();
        if (service == null) {
            Log.e(TAG, "could not retrieve NFC service during service recovery");
            return;
        }
        sService = service;
        try {
            sTagService = service.getNfcTagInterface();
            try {
                sCardEmulationService = service.getNfcCardEmulationInterface();
            } catch (RemoteException e2) {
                Log.e(TAG, "could not retrieve NFC card emulation service during service recovery");
            }
        } catch (RemoteException e3) {
            Log.e(TAG, "could not retrieve NFC tag service during service recovery");
        }
    }

    public boolean isEnabled() {
        try {
            return sService.getState() == STATE_ON;
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public int getAdapterState() {
        try {
            return sService.getState();
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return STATE_OFF;
        }
    }

    public boolean enable() {
        boolean z = false;
        if (this.mAppOps.noteOp(54) == 0) {
            try {
                z = sService.enable();
            } catch (RemoteException e) {
                attemptDeadServiceRecovery(e);
            }
        }
        return z;
    }

    public boolean disable() {
        try {
            return sService.disable(true);
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public boolean disable(boolean persist) {
        try {
            return sService.disable(persist);
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public void pausePolling(int timeoutInMs) {
        try {
            sService.pausePolling(timeoutInMs);
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
        }
    }

    public void resumePolling() {
        try {
            sService.resumePolling();
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
        }
    }

    public void setBeamPushUris(Uri[] uris, Activity activity) {
        if (activity == null) {
            throw new NullPointerException("activity cannot be null");
        }
        if (uris != null) {
            Uri[] arr$ = uris;
            int len$ = arr$.length;
            for (int i$ = HANDOVER_TRANSFER_STATUS_SUCCESS; i$ < len$; i$ += STATE_OFF) {
                Uri uri = arr$[i$];
                if (uri == null) {
                    throw new NullPointerException("Uri not allowed to be null");
                }
                String scheme = uri.getScheme();
                if (scheme == null || !(scheme.equalsIgnoreCase(ContentResolver.SCHEME_FILE) || scheme.equalsIgnoreCase(ContentResolver.SCHEME_CONTENT))) {
                    throw new IllegalArgumentException("URI needs to have either scheme file or scheme content");
                }
            }
        }
        this.mNfcActivityManager.setNdefPushContentUri(activity, uris);
    }

    public void setBeamPushUrisCallback(CreateBeamUrisCallback callback, Activity activity) {
        if (activity == null) {
            throw new NullPointerException("activity cannot be null");
        }
        this.mNfcActivityManager.setNdefPushContentUriCallback(activity, callback);
    }

    public void setNdefPushMessage(NdefMessage message, Activity activity, Activity... activities) {
        int targetSdkVersion = getSdkVersion();
        if (activity == null) {
            try {
                throw new NullPointerException("activity cannot be null");
            } catch (IllegalStateException e) {
                if (targetSdkVersion < FLAG_READER_NFC_BARCODE) {
                    Log.e(TAG, "Cannot call API with Activity that has already been destroyed", e);
                    return;
                }
                throw e;
            }
        }
        this.mNfcActivityManager.setNdefPushMessage(activity, message, HANDOVER_TRANSFER_STATUS_SUCCESS);
        Activity[] arr$ = activities;
        int len$ = arr$.length;
        for (int i$ = HANDOVER_TRANSFER_STATUS_SUCCESS; i$ < len$; i$ += STATE_OFF) {
            Activity a = arr$[i$];
            if (a == null) {
                throw new NullPointerException("activities cannot contain null");
            }
            this.mNfcActivityManager.setNdefPushMessage(a, message, HANDOVER_TRANSFER_STATUS_SUCCESS);
        }
    }

    public void setNdefPushMessage(NdefMessage message, Activity activity, int flags) {
        if (activity == null) {
            throw new NullPointerException("activity cannot be null");
        }
        this.mNfcActivityManager.setNdefPushMessage(activity, message, flags);
    }

    public void setNdefPushMessageCallback(CreateNdefMessageCallback callback, Activity activity, Activity... activities) {
        int targetSdkVersion = getSdkVersion();
        if (activity == null) {
            try {
                throw new NullPointerException("activity cannot be null");
            } catch (IllegalStateException e) {
                if (targetSdkVersion < FLAG_READER_NFC_BARCODE) {
                    Log.e(TAG, "Cannot call API with Activity that has already been destroyed", e);
                    return;
                }
                throw e;
            }
        }
        this.mNfcActivityManager.setNdefPushMessageCallback(activity, callback, HANDOVER_TRANSFER_STATUS_SUCCESS);
        Activity[] arr$ = activities;
        int len$ = arr$.length;
        for (int i$ = HANDOVER_TRANSFER_STATUS_SUCCESS; i$ < len$; i$ += STATE_OFF) {
            Activity a = arr$[i$];
            if (a == null) {
                throw new NullPointerException("activities cannot contain null");
            }
            this.mNfcActivityManager.setNdefPushMessageCallback(a, callback, HANDOVER_TRANSFER_STATUS_SUCCESS);
        }
    }

    public void setNdefPushMessageCallback(CreateNdefMessageCallback callback, Activity activity, int flags) {
        if (activity == null) {
            throw new NullPointerException("activity cannot be null");
        }
        this.mNfcActivityManager.setNdefPushMessageCallback(activity, callback, flags);
    }

    public void setOnNdefPushCompleteCallback(OnNdefPushCompleteCallback callback, Activity activity, Activity... activities) {
        int targetSdkVersion = getSdkVersion();
        if (activity == null) {
            try {
                throw new NullPointerException("activity cannot be null");
            } catch (IllegalStateException e) {
                if (targetSdkVersion < FLAG_READER_NFC_BARCODE) {
                    Log.e(TAG, "Cannot call API with Activity that has already been destroyed", e);
                    return;
                }
                throw e;
            }
        }
        this.mNfcActivityManager.setOnNdefPushCompleteCallback(activity, callback);
        Activity[] arr$ = activities;
        int len$ = arr$.length;
        for (int i$ = HANDOVER_TRANSFER_STATUS_SUCCESS; i$ < len$; i$ += STATE_OFF) {
            Activity a = arr$[i$];
            if (a == null) {
                throw new NullPointerException("activities cannot contain null");
            }
            this.mNfcActivityManager.setOnNdefPushCompleteCallback(a, callback);
        }
    }

    public void enableForegroundDispatch(Activity activity, PendingIntent intent, IntentFilter[] filters, String[][] techLists) {
        if (activity == null || intent == null) {
            throw new NullPointerException();
        } else if (activity.isResumed()) {
            TechListParcel parcel = null;
            if (techLists != null) {
                try {
                    if (techLists.length > 0) {
                        parcel = new TechListParcel(techLists);
                    }
                } catch (RemoteException e) {
                    attemptDeadServiceRecovery(e);
                    return;
                }
            }
            ActivityThread.currentActivityThread().registerOnActivityPausedListener(activity, this.mForegroundDispatchListener);
            sService.setForegroundDispatch(intent, filters, parcel);
        } else {
            throw new IllegalStateException("Foreground dispatch can only be enabled when your activity is resumed");
        }
    }

    public void disableForegroundDispatch(Activity activity) {
        ActivityThread.currentActivityThread().unregisterOnActivityPausedListener(activity, this.mForegroundDispatchListener);
        disableForegroundDispatchInternal(activity, false);
    }

    void disableForegroundDispatchInternal(Activity activity, boolean force) {
        try {
            sService.setForegroundDispatch(null, null, null);
            if (!force && !activity.isResumed()) {
                throw new IllegalStateException("You must disable foreground dispatching while your activity is still resumed");
            }
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
        }
    }

    public void enableReaderMode(Activity activity, ReaderCallback callback, int flags, Bundle extras) {
        this.mNfcActivityManager.enableReaderMode(activity, callback, flags, extras);
    }

    public void disableReaderMode(Activity activity) {
        this.mNfcActivityManager.disableReaderMode(activity);
    }

    public boolean invokeBeam(Activity activity) {
        if (activity == null) {
            throw new NullPointerException("activity may not be null.");
        }
        enforceResumed(activity);
        try {
            sService.invokeBeam();
            return true;
        } catch (RemoteException e) {
            Log.e(TAG, "invokeBeam: NFC process has died.");
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public boolean invokeBeam(BeamShareData shareData) {
        try {
            Log.e(TAG, "invokeBeamInternal()");
            sService.invokeBeamInternal(shareData);
            return true;
        } catch (RemoteException e) {
            Log.e(TAG, "invokeBeam: NFC process has died.");
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    @Deprecated
    public void enableForegroundNdefPush(Activity activity, NdefMessage message) {
        if (activity == null || message == null) {
            throw new NullPointerException();
        }
        enforceResumed(activity);
        this.mNfcActivityManager.setNdefPushMessage(activity, message, HANDOVER_TRANSFER_STATUS_SUCCESS);
    }

    @Deprecated
    public void disableForegroundNdefPush(Activity activity) {
        if (activity == null) {
            throw new NullPointerException();
        }
        enforceResumed(activity);
        this.mNfcActivityManager.setNdefPushMessage(activity, null, HANDOVER_TRANSFER_STATUS_SUCCESS);
        this.mNfcActivityManager.setNdefPushMessageCallback(activity, null, HANDOVER_TRANSFER_STATUS_SUCCESS);
        this.mNfcActivityManager.setOnNdefPushCompleteCallback(activity, null);
    }

    public boolean enableNdefPush() {
        try {
            return sService.enableNdefPush();
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public boolean disableNdefPush() {
        try {
            return sService.disableNdefPush();
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public boolean isNdefPushEnabled() {
        try {
            return sService.isNdefPushEnabled();
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public void dispatch(Tag tag) {
        if (tag == null) {
            throw new NullPointerException("tag cannot be null");
        }
        try {
            sService.dispatch(tag);
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
        }
    }

    public void setP2pModes(int initiatorModes, int targetModes) {
        try {
            sService.setP2pModes(initiatorModes, targetModes);
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
        }
    }

    public boolean addNfcUnlockHandler(NfcUnlockHandler unlockHandler, String[] tagTechnologies) {
        if (tagTechnologies.length == 0) {
            return false;
        }
        try {
            synchronized (this.mLock) {
                if (this.mNfcUnlockHandlers.containsKey(unlockHandler)) {
                    sService.removeNfcUnlockHandler((INfcUnlockHandler) this.mNfcUnlockHandlers.get(unlockHandler));
                    this.mNfcUnlockHandlers.remove(unlockHandler);
                }
                Stub iHandler = new C05662(unlockHandler);
                sService.addNfcUnlockHandler(iHandler, Tag.getTechCodesFromStrings(tagTechnologies));
                this.mNfcUnlockHandlers.put(unlockHandler, iHandler);
            }
            return true;
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        } catch (IllegalArgumentException e2) {
            Log.e(TAG, "Unable to register LockscreenDispatch", e2);
            return false;
        }
    }

    public boolean removeNfcUnlockHandler(NfcUnlockHandler unlockHandler) {
        try {
            synchronized (this.mLock) {
                if (this.mNfcUnlockHandlers.containsKey(unlockHandler)) {
                    sService.removeNfcUnlockHandler((INfcUnlockHandler) this.mNfcUnlockHandlers.remove(unlockHandler));
                }
            }
            return true;
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return false;
        }
    }

    public INfcAdapterExtras getNfcAdapterExtrasInterface() {
        if (this.mContext == null) {
            throw new UnsupportedOperationException("You need a context on NfcAdapter to use the  NFC extras APIs");
        }
        try {
            return sService.getNfcAdapterExtrasInterface(this.mContext.getPackageName());
        } catch (RemoteException e) {
            attemptDeadServiceRecovery(e);
            return null;
        }
    }

    void enforceResumed(Activity activity) {
        if (!activity.isResumed()) {
            throw new IllegalStateException("API cannot be called while activity is paused");
        }
    }

    int getSdkVersion() {
        if (this.mContext == null) {
            return 9;
        }
        return this.mContext.getApplicationInfo().targetSdkVersion;
    }
}
