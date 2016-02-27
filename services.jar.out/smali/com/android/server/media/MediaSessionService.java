package com.android.server.media;

import android.app.ActivityManager;
import android.app.KeyguardManager;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.PendingIntent.OnFinished;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.database.ContentObserver;
import android.media.AudioManager;
import android.media.AudioSystem;
import android.media.IAudioService;
import android.media.IRemoteVolumeController;
import android.media.session.IActiveSessionsListener;
import android.media.session.ISession;
import android.media.session.ISessionCallback;
import android.media.session.ISessionManager.Stub;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.ResultReceiver;
import android.os.ServiceManager;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import android.view.KeyEvent;
import com.android.server.SystemService;
import com.android.server.Watchdog;
import com.android.server.Watchdog.Monitor;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class MediaSessionService extends SystemService implements Monitor {
    private static final boolean DEBUG;
    private static final String TAG = "MediaSessionService";
    private static final int WAKELOCK_TIMEOUT = 5000;
    private final ArrayList<MediaSessionRecord> mAllSessions;
    private AudioManager mAudioManager;
    private IAudioService mAudioService;
    private ContentResolver mContentResolver;
    private int mCurrentUserId;
    private final MessageHandler mHandler;
    final IBinder mICallback;
    private KeyguardManager mKeyguardManager;
    private final Object mLock;
    private final WakeLock mMediaEventWakeLock;
    private final MediaSessionStack mPriorityStack;
    private IRemoteVolumeController mRvc;
    private final SessionManagerImpl mSessionManagerImpl;
    private final ArrayList<SessionsListenerRecord> mSessionsListeners;
    private SettingsObserver mSettingsObserver;
    private final boolean mUseMasterVolume;
    private final SparseArray<UserRecord> mUserRecords;

    final class MessageHandler extends Handler {
        private static final int MSG_SESSIONS_CHANGED = 1;

        MessageHandler() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MSG_SESSIONS_CHANGED /*1*/:
                    MediaSessionService.this.pushSessionsChanged(msg.arg1);
                default:
            }
        }

        public void post(int what, int arg1, int arg2) {
            obtainMessage(what, arg1, arg2).sendToTarget();
        }
    }

    class SessionManagerImpl extends Stub {
        private static final String EXTRA_WAKELOCK_ACQUIRED = "android.media.AudioService.WAKELOCK_ACQUIRED";
        private static final int WAKELOCK_RELEASE_ON_FINISHED = 1980;
        BroadcastReceiver mKeyEventDone;
        private KeyEventWakeLockReceiver mKeyEventReceiver;
        private boolean mVoiceButtonDown;
        private boolean mVoiceButtonHandled;

        /* renamed from: com.android.server.media.MediaSessionService.SessionManagerImpl.1 */
        class C03781 extends BroadcastReceiver {
            C03781() {
            }

            public void onReceive(Context context, Intent intent) {
                if (intent != null) {
                    Bundle extras = intent.getExtras();
                    if (extras != null) {
                        synchronized (MediaSessionService.this.mLock) {
                            if (extras.containsKey(SessionManagerImpl.EXTRA_WAKELOCK_ACQUIRED) && MediaSessionService.this.mMediaEventWakeLock.isHeld()) {
                                MediaSessionService.this.mMediaEventWakeLock.release();
                            }
                        }
                    }
                }
            }
        }

        class KeyEventWakeLockReceiver extends ResultReceiver implements Runnable, OnFinished {
            private final Handler mHandler;
            private int mLastTimeoutId;
            private int mRefCount;

            public KeyEventWakeLockReceiver(Handler handler) {
                super(handler);
                this.mRefCount = 0;
                this.mLastTimeoutId = 0;
                this.mHandler = handler;
            }

            public void onTimeout() {
                synchronized (MediaSessionService.this.mLock) {
                    if (this.mRefCount == 0) {
                        return;
                    }
                    this.mLastTimeoutId++;
                    this.mRefCount = 0;
                    releaseWakeLockLocked();
                }
            }

            public void aquireWakeLockLocked() {
                if (this.mRefCount == 0) {
                    MediaSessionService.this.mMediaEventWakeLock.acquire();
                }
                this.mRefCount++;
                this.mHandler.removeCallbacks(this);
                this.mHandler.postDelayed(this, 5000);
            }

            public void run() {
                onTimeout();
            }

            protected void onReceiveResult(int resultCode, Bundle resultData) {
                if (resultCode >= this.mLastTimeoutId) {
                    synchronized (MediaSessionService.this.mLock) {
                        if (this.mRefCount > 0) {
                            this.mRefCount--;
                            if (this.mRefCount == 0) {
                                releaseWakeLockLocked();
                            }
                        }
                    }
                }
            }

            private void releaseWakeLockLocked() {
                MediaSessionService.this.mMediaEventWakeLock.release();
                this.mHandler.removeCallbacks(this);
            }

            public void onSendFinished(PendingIntent pendingIntent, Intent intent, int resultCode, String resultData, Bundle resultExtras) {
                onReceiveResult(resultCode, null);
            }
        }

        SessionManagerImpl() {
            this.mVoiceButtonDown = MediaSessionService.DEBUG;
            this.mVoiceButtonHandled = MediaSessionService.DEBUG;
            this.mKeyEventReceiver = new KeyEventWakeLockReceiver(MediaSessionService.this.mHandler);
            this.mKeyEventDone = new C03781();
        }

        public ISession createSession(String packageName, ISessionCallback cb, String tag, int userId) throws RemoteException {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                MediaSessionService.this.enforcePackageName(packageName, uid);
                int resolvedUserId = ActivityManager.handleIncomingUser(pid, uid, userId, MediaSessionService.DEBUG, true, "createSession", packageName);
                if (cb == null) {
                    throw new IllegalArgumentException("Controller callback cannot be null");
                }
                ISession sessionBinder = MediaSessionService.this.createSessionInternal(pid, uid, resolvedUserId, packageName, cb, tag).getSessionBinder();
                return sessionBinder;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public List<IBinder> getSessions(ComponentName componentName, int userId) {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                int resolvedUserId = verifySessionsRequest(componentName, userId, pid, uid);
                ArrayList<IBinder> binders = new ArrayList();
                synchronized (MediaSessionService.this.mLock) {
                    ArrayList<MediaSessionRecord> records = MediaSessionService.this.mPriorityStack.getActiveSessions(resolvedUserId);
                    int size = records.size();
                    for (int i = 0; i < size; i++) {
                        binders.add(((MediaSessionRecord) records.get(i)).getControllerBinder().asBinder());
                    }
                }
                return binders;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void addSessionsListener(IActiveSessionsListener listener, ComponentName componentName, int userId) throws RemoteException {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                int resolvedUserId = verifySessionsRequest(componentName, userId, pid, uid);
                synchronized (MediaSessionService.this.mLock) {
                    if (MediaSessionService.this.findIndexOfSessionsListenerLocked(listener) != -1) {
                        Log.w(MediaSessionService.TAG, "ActiveSessionsListener is already added, ignoring");
                        return;
                    }
                    SessionsListenerRecord record = new SessionsListenerRecord(listener, componentName, resolvedUserId, pid, uid);
                    try {
                        listener.asBinder().linkToDeath(record, 0);
                        MediaSessionService.this.mSessionsListeners.add(record);
                        Binder.restoreCallingIdentity(token);
                    } catch (RemoteException e) {
                        Log.e(MediaSessionService.TAG, "ActiveSessionsListener is dead, ignoring it", e);
                        Binder.restoreCallingIdentity(token);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void removeSessionsListener(IActiveSessionsListener listener) throws RemoteException {
            synchronized (MediaSessionService.this.mLock) {
                int index = MediaSessionService.this.findIndexOfSessionsListenerLocked(listener);
                if (index != -1) {
                    SessionsListenerRecord record = (SessionsListenerRecord) MediaSessionService.this.mSessionsListeners.remove(index);
                    try {
                        record.mListener.asBinder().unlinkToDeath(record, 0);
                    } catch (Exception e) {
                    }
                }
            }
        }

        public void dispatchMediaKeyEvent(KeyEvent keyEvent, boolean needWakeLock) {
            if (keyEvent == null || !KeyEvent.isMediaKey(keyEvent.getKeyCode())) {
                Log.w(MediaSessionService.TAG, "Attempted to dispatch null or non-media key event.");
                return;
            }
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                if (isUserSetupComplete()) {
                    synchronized (MediaSessionService.this.mLock) {
                        UserRecord user = (UserRecord) MediaSessionService.this.mUserRecords.get(MediaSessionService.this.mCurrentUserId);
                        if (user == null) {
                            Log.e(MediaSessionService.TAG, "Invalid UserRecord for current user : " + MediaSessionService.this.mCurrentUserId);
                            Binder.restoreCallingIdentity(token);
                            return;
                        }
                        MediaSessionRecord session = MediaSessionService.this.mPriorityStack.getDefaultMediaButtonSession(MediaSessionService.this.mCurrentUserId, user.mLastMediaButtonReceiver == null ? true : MediaSessionService.DEBUG);
                        if (isVoiceKey(keyEvent.getKeyCode())) {
                            handleVoiceKeyEventLocked(keyEvent, needWakeLock, session);
                        } else {
                            dispatchMediaKeyEventLocked(keyEvent, needWakeLock, session);
                        }
                        Binder.restoreCallingIdentity(token);
                        return;
                    }
                }
                Slog.i(MediaSessionService.TAG, "Not dispatching media key event because user setup is in progress.");
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void dispatchAdjustVolume(int suggestedStream, int delta, int flags) {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                synchronized (MediaSessionService.this.mLock) {
                    dispatchAdjustVolumeLocked(suggestedStream, delta, flags, MediaSessionService.this.mPriorityStack.getDefaultVolumeSession(MediaSessionService.this.mCurrentUserId));
                }
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public void setRemoteVolumeController(IRemoteVolumeController rvc) {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long token = Binder.clearCallingIdentity();
            try {
                MediaSessionService.this.enforceStatusBarPermission("listen for volume changes", pid, uid);
                MediaSessionService.this.mRvc = rvc;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public boolean isGlobalPriorityActive() {
            return MediaSessionService.this.mPriorityStack.isGlobalPriorityActive();
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (MediaSessionService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump MediaSessionService from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
                return;
            }
            pw.println("MEDIA SESSION SERVICE (dumpsys media_session)");
            pw.println();
            synchronized (MediaSessionService.this.mLock) {
                int i;
                pw.println(MediaSessionService.this.mSessionsListeners.size() + " sessions listeners.");
                int count = MediaSessionService.this.mAllSessions.size();
                pw.println(count + " Sessions:");
                for (i = 0; i < count; i++) {
                    ((MediaSessionRecord) MediaSessionService.this.mAllSessions.get(i)).dump(pw, "");
                    pw.println();
                }
                MediaSessionService.this.mPriorityStack.dump(pw, "");
                pw.println("User Records:");
                count = MediaSessionService.this.mUserRecords.size();
                for (i = 0; i < count; i++) {
                    UserRecord user = (UserRecord) MediaSessionService.this.mUserRecords.get(i);
                    if (user != null) {
                        user.dumpLocked(pw, "");
                    }
                }
            }
        }

        private int verifySessionsRequest(ComponentName componentName, int userId, int pid, int uid) {
            String packageName = null;
            if (componentName != null) {
                packageName = componentName.getPackageName();
                MediaSessionService.this.enforcePackageName(packageName, uid);
            }
            int resolvedUserId = ActivityManager.handleIncomingUser(pid, uid, userId, true, true, "getSessions", packageName);
            MediaSessionService.this.enforceMediaPermissions(componentName, pid, uid, resolvedUserId);
            return resolvedUserId;
        }

        private void dispatchAdjustVolumeLocked(int suggestedStream, int direction, int flags, MediaSessionRecord session) {
            if (MediaSessionService.DEBUG) {
                Log.d(MediaSessionService.TAG, "Adjusting session " + (session == null ? null : session.toString()) + " by " + direction + ". flags=" + flags + ", suggestedStream=" + suggestedStream);
            }
            boolean preferSuggestedStream = MediaSessionService.DEBUG;
            if (isValidLocalStreamType(suggestedStream) && AudioSystem.isStreamActive(suggestedStream, 0)) {
                preferSuggestedStream = true;
            }
            if (session != null && !preferSuggestedStream) {
                session.adjustVolume(direction, flags, MediaSessionService.this.getContext().getPackageName(), UserHandle.myUserId(), true);
            } else if ((flags & DumpState.DUMP_PREFERRED) == 0 || AudioSystem.isStreamActive(3, 0)) {
                try {
                    String packageName = MediaSessionService.this.getContext().getOpPackageName();
                    if (MediaSessionService.this.mUseMasterVolume) {
                        boolean isMasterMute = MediaSessionService.this.mAudioService.isMasterMute();
                        if (direction == -99) {
                            boolean z;
                            IAudioService access$2600 = MediaSessionService.this.mAudioService;
                            if (isMasterMute) {
                                z = MediaSessionService.DEBUG;
                            } else {
                                z = true;
                            }
                            access$2600.setMasterMute(z, flags, packageName, MediaSessionService.this.mICallback);
                            return;
                        }
                        MediaSessionService.this.mAudioService.adjustMasterVolume(direction, flags, packageName);
                        if (isMasterMute && direction != 0) {
                            MediaSessionService.this.mAudioService.setMasterMute(MediaSessionService.DEBUG, flags, packageName, MediaSessionService.this.mICallback);
                            return;
                        }
                        return;
                    }
                    boolean isStreamMute = MediaSessionService.this.mAudioService.isStreamMute(suggestedStream);
                    if (direction == -99) {
                        MediaSessionService.this.mAudioManager.setStreamMute(suggestedStream, !isStreamMute ? true : MediaSessionService.DEBUG);
                        return;
                    }
                    MediaSessionService.this.mAudioService.adjustSuggestedStreamVolume(direction, suggestedStream, flags, packageName);
                    if (isStreamMute && direction != 0) {
                        MediaSessionService.this.mAudioManager.setStreamMute(suggestedStream, MediaSessionService.DEBUG);
                    }
                } catch (RemoteException e) {
                    Log.e(MediaSessionService.TAG, "Error adjusting default volume.", e);
                }
            } else if (MediaSessionService.DEBUG) {
                Log.d(MediaSessionService.TAG, "No active session to adjust, skipping media only volume event");
            }
        }

        private void handleVoiceKeyEventLocked(KeyEvent keyEvent, boolean needWakeLock, MediaSessionRecord session) {
            if (session == null || !session.hasFlag(65536)) {
                int action = keyEvent.getAction();
                boolean isLongPress;
                if ((keyEvent.getFlags() & DumpState.DUMP_PROVIDERS) != 0) {
                    isLongPress = true;
                } else {
                    isLongPress = MediaSessionService.DEBUG;
                }
                if (action == 0) {
                    if (keyEvent.getRepeatCount() == 0) {
                        this.mVoiceButtonDown = true;
                        this.mVoiceButtonHandled = MediaSessionService.DEBUG;
                        return;
                    } else if (this.mVoiceButtonDown && !this.mVoiceButtonHandled && isLongPress) {
                        this.mVoiceButtonHandled = true;
                        startVoiceInput(needWakeLock);
                        return;
                    } else {
                        return;
                    }
                } else if (action == 1 && this.mVoiceButtonDown) {
                    this.mVoiceButtonDown = MediaSessionService.DEBUG;
                    if (!this.mVoiceButtonHandled && !keyEvent.isCanceled()) {
                        dispatchMediaKeyEventLocked(KeyEvent.changeAction(keyEvent, 0), needWakeLock, session);
                        dispatchMediaKeyEventLocked(keyEvent, needWakeLock, session);
                        return;
                    }
                    return;
                } else {
                    return;
                }
            }
            dispatchMediaKeyEventLocked(keyEvent, needWakeLock, session);
        }

        private void dispatchMediaKeyEventLocked(KeyEvent keyEvent, boolean needWakeLock, MediaSessionRecord session) {
            if (session != null) {
                int access$2800;
                if (MediaSessionService.DEBUG) {
                    Log.d(MediaSessionService.TAG, "Sending media key to " + session.toString());
                }
                if (needWakeLock) {
                    this.mKeyEventReceiver.aquireWakeLockLocked();
                }
                if (needWakeLock) {
                    access$2800 = this.mKeyEventReceiver.mLastTimeoutId;
                } else {
                    access$2800 = -1;
                }
                session.sendMediaButton(keyEvent, access$2800, this.mKeyEventReceiver);
                return;
            }
            UserRecord user = (UserRecord) MediaSessionService.this.mUserRecords.get(ActivityManager.getCurrentUser());
            if (user == null || user.mLastMediaButtonReceiver == null) {
                if (MediaSessionService.DEBUG) {
                    Log.d(MediaSessionService.TAG, "Sending media key ordered broadcast");
                }
                if (needWakeLock) {
                    MediaSessionService.this.mMediaEventWakeLock.acquire();
                }
                Intent keyIntent = new Intent("android.intent.action.MEDIA_BUTTON", null);
                keyIntent.putExtra("android.intent.extra.KEY_EVENT", keyEvent);
                if (needWakeLock) {
                    keyIntent.putExtra(EXTRA_WAKELOCK_ACQUIRED, WAKELOCK_RELEASE_ON_FINISHED);
                }
                MediaSessionService.this.getContext().sendOrderedBroadcastAsUser(keyIntent, UserHandle.ALL, null, this.mKeyEventDone, MediaSessionService.this.mHandler, -1, null, null);
                return;
            }
            if (MediaSessionService.DEBUG) {
                Log.d(MediaSessionService.TAG, "Sending media key to last known PendingIntent");
            }
            if (needWakeLock) {
                this.mKeyEventReceiver.aquireWakeLockLocked();
            }
            Intent mediaButtonIntent = new Intent("android.intent.action.MEDIA_BUTTON");
            mediaButtonIntent.putExtra("android.intent.extra.KEY_EVENT", keyEvent);
            try {
                user.mLastMediaButtonReceiver.send(MediaSessionService.this.getContext(), needWakeLock ? this.mKeyEventReceiver.mLastTimeoutId : -1, mediaButtonIntent, this.mKeyEventReceiver, null);
            } catch (CanceledException e) {
                Log.i(MediaSessionService.TAG, "Error sending key event to media button receiver " + user.mLastMediaButtonReceiver, e);
            }
        }

        private void startVoiceInput(boolean needWakeLock) {
            boolean isLocked;
            Intent voiceIntent;
            boolean z = true;
            PowerManager pm = (PowerManager) MediaSessionService.this.getContext().getSystemService("power");
            if (MediaSessionService.this.mKeyguardManager == null || !MediaSessionService.this.mKeyguardManager.isKeyguardLocked()) {
                isLocked = MediaSessionService.DEBUG;
            } else {
                isLocked = true;
            }
            if (isLocked || !pm.isScreenOn()) {
                voiceIntent = new Intent("android.speech.action.VOICE_SEARCH_HANDS_FREE");
                String str = "android.speech.extras.EXTRA_SECURE";
                if (!(isLocked && MediaSessionService.this.mKeyguardManager.isKeyguardSecure())) {
                    z = MediaSessionService.DEBUG;
                }
                voiceIntent.putExtra(str, z);
                Log.i(MediaSessionService.TAG, "voice-based interactions: about to use ACTION_VOICE_SEARCH_HANDS_FREE");
            } else {
                voiceIntent = new Intent("android.speech.action.WEB_SEARCH");
                Log.i(MediaSessionService.TAG, "voice-based interactions: about to use ACTION_WEB_SEARCH");
            }
            if (needWakeLock) {
                MediaSessionService.this.mMediaEventWakeLock.acquire();
            }
            if (voiceIntent != null) {
                try {
                    voiceIntent.setFlags(276824064);
                    MediaSessionService.this.getContext().startActivityAsUser(voiceIntent, UserHandle.CURRENT);
                } catch (ActivityNotFoundException e) {
                    Log.w(MediaSessionService.TAG, "No activity for search: " + e);
                    if (needWakeLock) {
                        MediaSessionService.this.mMediaEventWakeLock.release();
                        return;
                    }
                    return;
                } catch (Throwable th) {
                    if (needWakeLock) {
                        MediaSessionService.this.mMediaEventWakeLock.release();
                    }
                }
            }
            if (needWakeLock) {
                MediaSessionService.this.mMediaEventWakeLock.release();
            }
        }

        private boolean isVoiceKey(int keyCode) {
            return keyCode == 79 ? true : MediaSessionService.DEBUG;
        }

        private boolean isUserSetupComplete() {
            return Secure.getIntForUser(MediaSessionService.this.getContext().getContentResolver(), "user_setup_complete", 0, -2) != 0 ? true : MediaSessionService.DEBUG;
        }

        private boolean isValidLocalStreamType(int streamType) {
            return (streamType < 0 || streamType > 5) ? MediaSessionService.DEBUG : true;
        }
    }

    final class SessionsListenerRecord implements DeathRecipient {
        private final ComponentName mComponentName;
        private final IActiveSessionsListener mListener;
        private final int mPid;
        private final int mUid;
        private final int mUserId;

        public SessionsListenerRecord(IActiveSessionsListener listener, ComponentName componentName, int userId, int pid, int uid) {
            this.mListener = listener;
            this.mComponentName = componentName;
            this.mUserId = userId;
            this.mPid = pid;
            this.mUid = uid;
        }

        public void binderDied() {
            synchronized (MediaSessionService.this.mLock) {
                MediaSessionService.this.mSessionsListeners.remove(this);
            }
        }
    }

    final class SettingsObserver extends ContentObserver {
        private final Uri mSecureSettingsUri;

        private SettingsObserver() {
            super(null);
            this.mSecureSettingsUri = Secure.getUriFor("enabled_notification_listeners");
        }

        private void observe() {
            MediaSessionService.this.mContentResolver.registerContentObserver(this.mSecureSettingsUri, MediaSessionService.DEBUG, this, -1);
        }

        public void onChange(boolean selfChange, Uri uri) {
            MediaSessionService.this.updateActiveSessionListeners();
        }
    }

    final class UserRecord {
        private PendingIntent mLastMediaButtonReceiver;
        private final ArrayList<MediaSessionRecord> mSessions;
        private final int mUserId;

        public UserRecord(Context context, int userId) {
            this.mSessions = new ArrayList();
            this.mUserId = userId;
        }

        public void startLocked() {
        }

        public void stopLocked() {
        }

        public void destroyLocked() {
            for (int i = this.mSessions.size() - 1; i >= 0; i--) {
                MediaSessionService.this.destroySessionLocked((MediaSessionRecord) this.mSessions.get(i));
            }
        }

        public ArrayList<MediaSessionRecord> getSessionsLocked() {
            return this.mSessions;
        }

        public void addSessionLocked(MediaSessionRecord session) {
            this.mSessions.add(session);
        }

        public void removeSessionLocked(MediaSessionRecord session) {
            this.mSessions.remove(session);
        }

        public void dumpLocked(PrintWriter pw, String prefix) {
            pw.println(prefix + "Record for user " + this.mUserId);
            String indent = prefix + "  ";
            pw.println(indent + "MediaButtonReceiver:" + this.mLastMediaButtonReceiver);
            int size = this.mSessions.size();
            pw.println(indent + size + " Sessions:");
            for (int i = 0; i < size; i++) {
                pw.println(indent + ((MediaSessionRecord) this.mSessions.get(i)).toString());
            }
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
    }

    public MediaSessionService(Context context) {
        super(context);
        this.mICallback = new Binder();
        this.mAllSessions = new ArrayList();
        this.mUserRecords = new SparseArray();
        this.mSessionsListeners = new ArrayList();
        this.mLock = new Object();
        this.mHandler = new MessageHandler();
        this.mCurrentUserId = -1;
        this.mSessionManagerImpl = new SessionManagerImpl();
        this.mPriorityStack = new MediaSessionStack();
        this.mMediaEventWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(1, "handleMediaEvent");
        this.mUseMasterVolume = context.getResources().getBoolean(17956881);
    }

    public void onStart() {
        publishBinderService("media_session", this.mSessionManagerImpl);
        Watchdog.getInstance().addMonitor(this);
        updateUser();
        this.mKeyguardManager = (KeyguardManager) getContext().getSystemService("keyguard");
        this.mAudioService = getAudioService();
        this.mAudioManager = (AudioManager) getContext().getSystemService("audio");
        this.mContentResolver = getContext().getContentResolver();
        this.mSettingsObserver = new SettingsObserver();
        this.mSettingsObserver.observe();
    }

    private IAudioService getAudioService() {
        return IAudioService.Stub.asInterface(ServiceManager.getService("audio"));
    }

    public void updateSession(MediaSessionRecord record) {
        synchronized (this.mLock) {
            if (this.mAllSessions.contains(record)) {
                this.mPriorityStack.onSessionStateChange(record);
                this.mHandler.post(1, record.getUserId(), 0);
                return;
            }
            Log.d(TAG, "Unknown session updated. Ignoring.");
        }
    }

    public void notifyRemoteVolumeChanged(int flags, MediaSessionRecord session) {
        if (this.mRvc != null) {
            try {
                this.mRvc.remoteVolumeChanged(session.getControllerBinder(), flags);
            } catch (Exception e) {
                Log.wtf(TAG, "Error sending volume change to system UI.", e);
            }
        }
    }

    public void onSessionPlaystateChange(MediaSessionRecord record, int oldState, int newState) {
        synchronized (this.mLock) {
            if (this.mAllSessions.contains(record)) {
                boolean updateSessions = this.mPriorityStack.onPlaystateChange(record, oldState, newState);
                if (updateSessions) {
                    this.mHandler.post(1, record.getUserId(), 0);
                    return;
                }
                return;
            }
            Log.d(TAG, "Unknown session changed playback state. Ignoring.");
        }
    }

    public void onSessionPlaybackTypeChanged(MediaSessionRecord record) {
        synchronized (this.mLock) {
            if (this.mAllSessions.contains(record)) {
                pushRemoteVolumeUpdateLocked(record.getUserId());
                return;
            }
            Log.d(TAG, "Unknown session changed playback type. Ignoring.");
        }
    }

    public void onStartUser(int userHandle) {
        updateUser();
    }

    public void onSwitchUser(int userHandle) {
        updateUser();
    }

    public void onStopUser(int userHandle) {
        synchronized (this.mLock) {
            UserRecord user = (UserRecord) this.mUserRecords.get(userHandle);
            if (user != null) {
                destroyUserLocked(user);
            }
        }
    }

    public void monitor() {
        synchronized (this.mLock) {
        }
    }

    protected void enforcePhoneStatePermission(int pid, int uid) {
        if (getContext().checkPermission("android.permission.MODIFY_PHONE_STATE", pid, uid) != 0) {
            throw new SecurityException("Must hold the MODIFY_PHONE_STATE permission.");
        }
    }

    void sessionDied(MediaSessionRecord session) {
        synchronized (this.mLock) {
            destroySessionLocked(session);
        }
    }

    void destroySession(MediaSessionRecord session) {
        synchronized (this.mLock) {
            destroySessionLocked(session);
        }
    }

    private void updateUser() {
        synchronized (this.mLock) {
            int userId = ActivityManager.getCurrentUser();
            if (this.mCurrentUserId != userId) {
                int oldUserId = this.mCurrentUserId;
                this.mCurrentUserId = userId;
                UserRecord oldUser = (UserRecord) this.mUserRecords.get(oldUserId);
                if (oldUser != null) {
                    oldUser.stopLocked();
                }
                getOrCreateUser(userId).startLocked();
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void updateActiveSessionListeners() {
        /*
        r8 = this;
        r4 = r8.mLock;
        monitor-enter(r4);
        r3 = r8.mSessionsListeners;	 Catch:{ all -> 0x0064 }
        r3 = r3.size();	 Catch:{ all -> 0x0064 }
        r1 = r3 + -1;
    L_0x000b:
        if (r1 < 0) goto L_0x0062;
    L_0x000d:
        r3 = r8.mSessionsListeners;	 Catch:{ all -> 0x0064 }
        r2 = r3.get(r1);	 Catch:{ all -> 0x0064 }
        r2 = (com.android.server.media.MediaSessionService.SessionsListenerRecord) r2;	 Catch:{ all -> 0x0064 }
        r3 = r2.mComponentName;	 Catch:{ SecurityException -> 0x002b }
        r5 = r2.mPid;	 Catch:{ SecurityException -> 0x002b }
        r6 = r2.mUid;	 Catch:{ SecurityException -> 0x002b }
        r7 = r2.mUserId;	 Catch:{ SecurityException -> 0x002b }
        r8.enforceMediaPermissions(r3, r5, r6, r7);	 Catch:{ SecurityException -> 0x002b }
    L_0x0028:
        r1 = r1 + -1;
        goto L_0x000b;
    L_0x002b:
        r0 = move-exception;
        r3 = "MediaSessionService";
        r5 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0064 }
        r5.<init>();	 Catch:{ all -> 0x0064 }
        r6 = "ActiveSessionsListener ";
        r5 = r5.append(r6);	 Catch:{ all -> 0x0064 }
        r6 = r2.mComponentName;	 Catch:{ all -> 0x0064 }
        r5 = r5.append(r6);	 Catch:{ all -> 0x0064 }
        r6 = " is no longer authorized. Disconnecting.";
        r5 = r5.append(r6);	 Catch:{ all -> 0x0064 }
        r5 = r5.toString();	 Catch:{ all -> 0x0064 }
        android.util.Log.i(r3, r5);	 Catch:{ all -> 0x0064 }
        r3 = r8.mSessionsListeners;	 Catch:{ all -> 0x0064 }
        r3.remove(r1);	 Catch:{ all -> 0x0064 }
        r3 = r2.mListener;	 Catch:{ Exception -> 0x0060 }
        r5 = new java.util.ArrayList;	 Catch:{ Exception -> 0x0060 }
        r5.<init>();	 Catch:{ Exception -> 0x0060 }
        r3.onActiveSessionsChanged(r5);	 Catch:{ Exception -> 0x0060 }
        goto L_0x0028;
    L_0x0060:
        r3 = move-exception;
        goto L_0x0028;
    L_0x0062:
        monitor-exit(r4);	 Catch:{ all -> 0x0064 }
        return;
    L_0x0064:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0064 }
        throw r3;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.media.MediaSessionService.updateActiveSessionListeners():void");
    }

    private void destroyUserLocked(UserRecord user) {
        user.stopLocked();
        user.destroyLocked();
        this.mUserRecords.remove(user.mUserId);
    }

    private void destroySessionLocked(MediaSessionRecord session) {
        UserRecord user = (UserRecord) this.mUserRecords.get(session.getUserId());
        if (user != null) {
            user.removeSessionLocked(session);
        }
        this.mPriorityStack.removeSession(session);
        this.mAllSessions.remove(session);
        try {
            session.getCallback().asBinder().unlinkToDeath(session, 0);
        } catch (Exception e) {
        }
        session.onDestroy();
        this.mHandler.post(1, session.getUserId(), 0);
    }

    private void enforcePackageName(String packageName, int uid) {
        if (TextUtils.isEmpty(packageName)) {
            throw new IllegalArgumentException("packageName may not be empty");
        }
        String[] packages = getContext().getPackageManager().getPackagesForUid(uid);
        int packageCount = packages.length;
        int i = 0;
        while (i < packageCount) {
            if (!packageName.equals(packages[i])) {
                i++;
            } else {
                return;
            }
        }
        throw new IllegalArgumentException("packageName is not owned by the calling process");
    }

    private void enforceMediaPermissions(ComponentName compName, int pid, int uid, int resolvedUserId) {
        if (getContext().checkPermission("android.permission.MEDIA_CONTENT_CONTROL", pid, uid) != 0 && !isEnabledNotificationListener(compName, UserHandle.getUserId(uid), resolvedUserId)) {
            throw new SecurityException("Missing permission to control media.");
        }
    }

    private void enforceStatusBarPermission(String action, int pid, int uid) {
        if (getContext().checkPermission("android.permission.STATUS_BAR_SERVICE", pid, uid) != 0) {
            throw new SecurityException("Only system ui may " + action);
        }
    }

    private boolean isEnabledNotificationListener(ComponentName compName, int userId, int forUserId) {
        if (userId != forUserId) {
            return DEBUG;
        }
        if (DEBUG) {
            Log.d(TAG, "Checking if enabled notification listener " + compName);
        }
        if (compName == null) {
            return DEBUG;
        }
        String enabledNotifListeners = Secure.getStringForUser(this.mContentResolver, "enabled_notification_listeners", userId);
        if (enabledNotifListeners != null) {
            String[] components = enabledNotifListeners.split(":");
            int i = 0;
            while (i < components.length) {
                ComponentName component = ComponentName.unflattenFromString(components[i]);
                if (component == null || !compName.equals(component)) {
                    i++;
                } else {
                    if (DEBUG) {
                        Log.d(TAG, "ok to get sessions: " + component + " is authorized notification listener");
                    }
                    return true;
                }
            }
        }
        if (!DEBUG) {
            return DEBUG;
        }
        Log.d(TAG, "not ok to get sessions, " + compName + " is not in list of ENABLED_NOTIFICATION_LISTENERS for user " + userId);
        return DEBUG;
    }

    private MediaSessionRecord createSessionInternal(int callerPid, int callerUid, int userId, String callerPackageName, ISessionCallback cb, String tag) throws RemoteException {
        MediaSessionRecord createSessionLocked;
        synchronized (this.mLock) {
            createSessionLocked = createSessionLocked(callerPid, callerUid, userId, callerPackageName, cb, tag);
        }
        return createSessionLocked;
    }

    private MediaSessionRecord createSessionLocked(int callerPid, int callerUid, int userId, String callerPackageName, ISessionCallback cb, String tag) {
        MediaSessionRecord session = new MediaSessionRecord(callerPid, callerUid, userId, callerPackageName, cb, tag, this, this.mHandler);
        try {
            cb.asBinder().linkToDeath(session, 0);
            this.mAllSessions.add(session);
            this.mPriorityStack.addSession(session);
            getOrCreateUser(userId).addSessionLocked(session);
            this.mHandler.post(1, userId, 0);
            if (DEBUG) {
                Log.d(TAG, "Created session for package " + callerPackageName + " with tag " + tag);
            }
            return session;
        } catch (RemoteException e) {
            throw new RuntimeException("Media Session owner died prematurely.", e);
        }
    }

    private UserRecord getOrCreateUser(int userId) {
        UserRecord user = (UserRecord) this.mUserRecords.get(userId);
        if (user != null) {
            return user;
        }
        user = new UserRecord(getContext(), userId);
        this.mUserRecords.put(userId, user);
        return user;
    }

    private int findIndexOfSessionsListenerLocked(IActiveSessionsListener listener) {
        for (int i = this.mSessionsListeners.size() - 1; i >= 0; i--) {
            if (((SessionsListenerRecord) this.mSessionsListeners.get(i)).mListener.asBinder() == listener.asBinder()) {
                return i;
            }
        }
        return -1;
    }

    private boolean isSessionDiscoverable(MediaSessionRecord record) {
        return record.isActive();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void pushSessionsChanged(int r10) {
        /*
        r9 = this;
        r7 = r9.mLock;
        monitor-enter(r7);
        r6 = r9.mPriorityStack;	 Catch:{ all -> 0x007e }
        r3 = r6.getActiveSessions(r10);	 Catch:{ all -> 0x007e }
        r4 = r3.size();	 Catch:{ all -> 0x007e }
        if (r4 <= 0) goto L_0x0027;
    L_0x000f:
        r6 = 0;
        r6 = r3.get(r6);	 Catch:{ all -> 0x007e }
        r6 = (com.android.server.media.MediaSessionRecord) r6;	 Catch:{ all -> 0x007e }
        r8 = 0;
        r6 = r6.isPlaybackActive(r8);	 Catch:{ all -> 0x007e }
        if (r6 == 0) goto L_0x0027;
    L_0x001d:
        r6 = 0;
        r6 = r3.get(r6);	 Catch:{ all -> 0x007e }
        r6 = (com.android.server.media.MediaSessionRecord) r6;	 Catch:{ all -> 0x007e }
        r9.rememberMediaButtonReceiverLocked(r6);	 Catch:{ all -> 0x007e }
    L_0x0027:
        r5 = new java.util.ArrayList;	 Catch:{ all -> 0x007e }
        r5.<init>();	 Catch:{ all -> 0x007e }
        r1 = 0;
    L_0x002d:
        if (r1 >= r4) goto L_0x0044;
    L_0x002f:
        r8 = new android.media.session.MediaSession$Token;	 Catch:{ all -> 0x007e }
        r6 = r3.get(r1);	 Catch:{ all -> 0x007e }
        r6 = (com.android.server.media.MediaSessionRecord) r6;	 Catch:{ all -> 0x007e }
        r6 = r6.getControllerBinder();	 Catch:{ all -> 0x007e }
        r8.<init>(r6);	 Catch:{ all -> 0x007e }
        r5.add(r8);	 Catch:{ all -> 0x007e }
        r1 = r1 + 1;
        goto L_0x002d;
    L_0x0044:
        r9.pushRemoteVolumeUpdateLocked(r10);	 Catch:{ all -> 0x007e }
        r6 = r9.mSessionsListeners;	 Catch:{ all -> 0x007e }
        r6 = r6.size();	 Catch:{ all -> 0x007e }
        r1 = r6 + -1;
    L_0x004f:
        if (r1 < 0) goto L_0x0081;
    L_0x0051:
        r6 = r9.mSessionsListeners;	 Catch:{ all -> 0x007e }
        r2 = r6.get(r1);	 Catch:{ all -> 0x007e }
        r2 = (com.android.server.media.MediaSessionService.SessionsListenerRecord) r2;	 Catch:{ all -> 0x007e }
        r6 = r2.mUserId;	 Catch:{ all -> 0x007e }
        r8 = -1;
        if (r6 == r8) goto L_0x0066;
    L_0x0060:
        r6 = r2.mUserId;	 Catch:{ all -> 0x007e }
        if (r6 != r10) goto L_0x006d;
    L_0x0066:
        r6 = r2.mListener;	 Catch:{ RemoteException -> 0x0070 }
        r6.onActiveSessionsChanged(r5);	 Catch:{ RemoteException -> 0x0070 }
    L_0x006d:
        r1 = r1 + -1;
        goto L_0x004f;
    L_0x0070:
        r0 = move-exception;
        r6 = "MediaSessionService";
        r8 = "Dead ActiveSessionsListener in pushSessionsChanged, removing";
        android.util.Log.w(r6, r8, r0);	 Catch:{ all -> 0x007e }
        r6 = r9.mSessionsListeners;	 Catch:{ all -> 0x007e }
        r6.remove(r1);	 Catch:{ all -> 0x007e }
        goto L_0x006d;
    L_0x007e:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x007e }
        throw r6;
    L_0x0081:
        monitor-exit(r7);	 Catch:{ all -> 0x007e }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.media.MediaSessionService.pushSessionsChanged(int):void");
    }

    private void pushRemoteVolumeUpdateLocked(int userId) {
        if (this.mRvc != null) {
            try {
                MediaSessionRecord record = this.mPriorityStack.getDefaultRemoteSession(userId);
                this.mRvc.updateRemoteController(record == null ? null : record.getControllerBinder());
            } catch (RemoteException e) {
                Log.wtf(TAG, "Error sending default remote volume to sys ui.", e);
            }
        }
    }

    private void rememberMediaButtonReceiverLocked(MediaSessionRecord record) {
        PendingIntent receiver = record.getMediaButtonReceiver();
        UserRecord user = (UserRecord) this.mUserRecords.get(record.getUserId());
        if (receiver != null && user != null) {
            user.mLastMediaButtonReceiver = receiver;
        }
    }
}
