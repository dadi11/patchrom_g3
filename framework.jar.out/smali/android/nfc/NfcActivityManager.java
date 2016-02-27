package android.nfc;

import android.app.Activity;
import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.ContentProvider;
import android.content.ContentResolver;
import android.net.Uri;
import android.nfc.IAppCallback.Stub;
import android.nfc.NfcAdapter.CreateBeamUrisCallback;
import android.nfc.NfcAdapter.CreateNdefMessageCallback;
import android.nfc.NfcAdapter.OnNdefPushCompleteCallback;
import android.nfc.NfcAdapter.ReaderCallback;
import android.os.Binder;
import android.os.Bundle;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.Log;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public final class NfcActivityManager extends Stub implements ActivityLifecycleCallbacks {
    static final Boolean DBG;
    static final String TAG = "NFC";
    final List<NfcActivityState> mActivities;
    final NfcAdapter mAdapter;
    final List<NfcApplicationState> mApps;
    final NfcEvent mDefaultEvent;

    class NfcActivityState {
        Activity activity;
        int flags;
        NdefMessage ndefMessage;
        CreateNdefMessageCallback ndefMessageCallback;
        OnNdefPushCompleteCallback onNdefPushCompleteCallback;
        ReaderCallback readerCallback;
        Bundle readerModeExtras;
        int readerModeFlags;
        boolean resumed;
        Binder token;
        CreateBeamUrisCallback uriCallback;
        Uri[] uris;

        public NfcActivityState(Activity activity) {
            this.resumed = false;
            this.ndefMessage = null;
            this.ndefMessageCallback = null;
            this.onNdefPushCompleteCallback = null;
            this.uriCallback = null;
            this.uris = null;
            this.flags = 0;
            this.readerModeFlags = 0;
            this.readerCallback = null;
            this.readerModeExtras = null;
            if (activity.getWindow().isDestroyed()) {
                throw new IllegalStateException("activity is already destroyed");
            }
            this.resumed = activity.isResumed();
            this.activity = activity;
            this.token = new Binder();
            NfcActivityManager.this.registerApplication(activity.getApplication());
        }

        public void destroy() {
            NfcActivityManager.this.unregisterApplication(this.activity.getApplication());
            this.resumed = false;
            this.activity = null;
            this.ndefMessage = null;
            this.ndefMessageCallback = null;
            this.onNdefPushCompleteCallback = null;
            this.uriCallback = null;
            this.uris = null;
            this.readerModeFlags = 0;
            this.token = null;
        }

        public String toString() {
            StringBuilder s = new StringBuilder("[").append(" ");
            s.append(this.ndefMessage).append(" ").append(this.ndefMessageCallback).append(" ");
            s.append(this.uriCallback).append(" ");
            if (this.uris != null) {
                for (Uri uri : this.uris) {
                    s.append(this.onNdefPushCompleteCallback).append(" ").append(uri).append("]");
                }
            }
            return s.toString();
        }
    }

    class NfcApplicationState {
        final Application app;
        int refCount;

        public NfcApplicationState(Application app) {
            this.refCount = 0;
            this.app = app;
        }

        public void register() {
            this.refCount++;
            if (this.refCount == 1) {
                this.app.registerActivityLifecycleCallbacks(NfcActivityManager.this);
            }
        }

        public void unregister() {
            this.refCount--;
            if (this.refCount == 0) {
                this.app.unregisterActivityLifecycleCallbacks(NfcActivityManager.this);
            } else if (this.refCount < 0) {
                Log.e(NfcActivityManager.TAG, "-ve refcount for " + this.app);
            }
        }
    }

    static {
        DBG = Boolean.valueOf(false);
    }

    NfcApplicationState findAppState(Application app) {
        for (NfcApplicationState appState : this.mApps) {
            if (appState.app == app) {
                return appState;
            }
        }
        return null;
    }

    void registerApplication(Application app) {
        NfcApplicationState appState = findAppState(app);
        if (appState == null) {
            appState = new NfcApplicationState(app);
            this.mApps.add(appState);
        }
        appState.register();
    }

    void unregisterApplication(Application app) {
        NfcApplicationState appState = findAppState(app);
        if (appState == null) {
            Log.e(TAG, "app was not registered " + app);
        } else {
            appState.unregister();
        }
    }

    synchronized NfcActivityState findActivityState(Activity activity) {
        NfcActivityState state;
        for (NfcActivityState state2 : this.mActivities) {
            if (state2.activity == activity) {
                break;
            }
        }
        state2 = null;
        return state2;
    }

    synchronized NfcActivityState getActivityState(Activity activity) {
        NfcActivityState state;
        state = findActivityState(activity);
        if (state == null) {
            state = new NfcActivityState(activity);
            this.mActivities.add(state);
        }
        return state;
    }

    synchronized NfcActivityState findResumedActivityState() {
        NfcActivityState state;
        for (NfcActivityState state2 : this.mActivities) {
            if (state2.resumed) {
                break;
            }
        }
        state2 = null;
        return state2;
    }

    synchronized void destroyActivityState(Activity activity) {
        NfcActivityState activityState = findActivityState(activity);
        if (activityState != null) {
            activityState.destroy();
            this.mActivities.remove(activityState);
        }
    }

    public NfcActivityManager(NfcAdapter adapter) {
        this.mAdapter = adapter;
        this.mActivities = new LinkedList();
        this.mApps = new ArrayList(1);
        this.mDefaultEvent = new NfcEvent(this.mAdapter);
    }

    public void enableReaderMode(Activity activity, ReaderCallback callback, int flags, Bundle extras) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.readerCallback = callback;
            state.readerModeFlags = flags;
            state.readerModeExtras = extras;
            Binder token = state.token;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            setReaderMode(token, flags, extras);
        }
    }

    public void disableReaderMode(Activity activity) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.readerCallback = null;
            state.readerModeFlags = 0;
            state.readerModeExtras = null;
            Binder token = state.token;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            setReaderMode(token, 0, null);
        }
    }

    public void setReaderMode(Binder token, int flags, Bundle extras) {
        if (DBG.booleanValue()) {
            Log.d(TAG, "Setting reader mode");
        }
        try {
            NfcAdapter.sService.setReaderMode(token, this, flags, extras);
        } catch (RemoteException e) {
            this.mAdapter.attemptDeadServiceRecovery(e);
        }
    }

    public void setNdefPushContentUri(Activity activity, Uri[] uris) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.uris = uris;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            requestNfcServiceCallback();
        } else {
            verifyNfcPermission();
        }
    }

    public void setNdefPushContentUriCallback(Activity activity, CreateBeamUrisCallback callback) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.uriCallback = callback;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            requestNfcServiceCallback();
        } else {
            verifyNfcPermission();
        }
    }

    public void setNdefPushMessage(Activity activity, NdefMessage message, int flags) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.ndefMessage = message;
            state.flags = flags;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            requestNfcServiceCallback();
        } else {
            verifyNfcPermission();
        }
    }

    public void setNdefPushMessageCallback(Activity activity, CreateNdefMessageCallback callback, int flags) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.ndefMessageCallback = callback;
            state.flags = flags;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            requestNfcServiceCallback();
        } else {
            verifyNfcPermission();
        }
    }

    public void setOnNdefPushCompleteCallback(Activity activity, OnNdefPushCompleteCallback callback) {
        synchronized (this) {
            NfcActivityState state = getActivityState(activity);
            state.onNdefPushCompleteCallback = callback;
            boolean isResumed = state.resumed;
        }
        if (isResumed) {
            requestNfcServiceCallback();
        } else {
            verifyNfcPermission();
        }
    }

    void requestNfcServiceCallback() {
        try {
            NfcAdapter.sService.setAppCallback(this);
        } catch (RemoteException e) {
            this.mAdapter.attemptDeadServiceRecovery(e);
        }
    }

    void verifyNfcPermission() {
        try {
            NfcAdapter.sService.verifyNfcPermission();
        } catch (RemoteException e) {
            this.mAdapter.attemptDeadServiceRecovery(e);
        }
    }

    public BeamShareData createBeamShareData() {
        synchronized (this) {
            NfcActivityState state = findResumedActivityState();
            if (state == null) {
                return null;
            }
            CreateNdefMessageCallback ndefCallback = state.ndefMessageCallback;
            CreateBeamUrisCallback urisCallback = state.uriCallback;
            NdefMessage message = state.ndefMessage;
            Uri[] uris = state.uris;
            int flags = state.flags;
            Activity activity = state.activity;
            if (ndefCallback != null) {
                message = ndefCallback.createNdefMessage(this.mDefaultEvent);
            }
            if (urisCallback != null) {
                uris = urisCallback.createBeamUris(this.mDefaultEvent);
                if (uris != null) {
                    ArrayList<Uri> validUris = new ArrayList();
                    for (Uri uri : uris) {
                        if (uri == null) {
                            Log.e(TAG, "Uri not allowed to be null.");
                        } else {
                            String scheme = uri.getScheme();
                            if (scheme == null || !(scheme.equalsIgnoreCase(ContentResolver.SCHEME_FILE) || scheme.equalsIgnoreCase(ContentResolver.SCHEME_CONTENT))) {
                                Log.e(TAG, "Uri needs to have either scheme file or scheme content");
                            } else {
                                validUris.add(ContentProvider.maybeAddUserId(uri, UserHandle.myUserId()));
                            }
                        }
                    }
                    uris = (Uri[]) validUris.toArray(new Uri[validUris.size()]);
                }
            }
            if (uris != null && uris.length > 0) {
                for (Uri uri2 : uris) {
                    activity.grantUriPermission("com.android.nfc", uri2, 1);
                }
            }
            return new BeamShareData(message, uris, UserHandle.CURRENT, flags);
        }
    }

    public void onNdefPushComplete() {
        synchronized (this) {
            NfcActivityState state = findResumedActivityState();
            if (state == null) {
                return;
            }
            OnNdefPushCompleteCallback callback = state.onNdefPushCompleteCallback;
            if (callback != null) {
                callback.onNdefPushComplete(this.mDefaultEvent);
            }
        }
    }

    public void onTagDiscovered(Tag tag) throws RemoteException {
        synchronized (this) {
            NfcActivityState state = findResumedActivityState();
            if (state == null) {
                return;
            }
            ReaderCallback callback = state.readerCallback;
            if (callback != null) {
                callback.onTagDiscovered(tag);
            }
        }
    }

    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
    }

    public void onActivityStarted(Activity activity) {
    }

    public void onActivityResumed(Activity activity) {
        synchronized (this) {
            NfcActivityState state = findActivityState(activity);
            if (DBG.booleanValue()) {
                Log.d(TAG, "onResume() for " + activity + " " + state);
            }
            if (state == null) {
                return;
            }
            state.resumed = true;
            Binder token = state.token;
            int readerModeFlags = state.readerModeFlags;
            Bundle readerModeExtras = state.readerModeExtras;
            if (readerModeFlags != 0) {
                setReaderMode(token, readerModeFlags, readerModeExtras);
            }
            requestNfcServiceCallback();
        }
    }

    public void onActivityPaused(Activity activity) {
        synchronized (this) {
            NfcActivityState state = findActivityState(activity);
            if (DBG.booleanValue()) {
                Log.d(TAG, "onPause() for " + activity + " " + state);
            }
            if (state == null) {
                return;
            }
            boolean readerModeFlagsSet;
            state.resumed = false;
            Binder token = state.token;
            if (state.readerModeFlags != 0) {
                readerModeFlagsSet = true;
            } else {
                readerModeFlagsSet = false;
            }
            if (readerModeFlagsSet) {
                setReaderMode(token, 0, null);
            }
        }
    }

    public void onActivityStopped(Activity activity) {
    }

    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
    }

    public void onActivityDestroyed(Activity activity) {
        synchronized (this) {
            NfcActivityState state = findActivityState(activity);
            if (DBG.booleanValue()) {
                Log.d(TAG, "onDestroy() for " + activity + " " + state);
            }
            if (state != null) {
                destroyActivityState(activity);
            }
        }
    }
}
