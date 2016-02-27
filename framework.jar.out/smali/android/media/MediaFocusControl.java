package android.media;

import android.app.ActivityManager;
import android.app.AppOpsManager;
import android.app.KeyguardManager;
import android.app.PendingIntent;
import android.app.PendingIntent.OnFinished;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.database.ContentObserver;
import android.location.SettingInjectorService;
import android.media.AudioService.VolumeController;
import android.media.audiopolicy.IAudioPolicyCallback;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.Parcelable;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.speech.RecognizerIntent;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.util.Slog;
import android.view.KeyEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.ConcurrentModificationException;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Stack;

public class MediaFocusControl implements OnFinished {
    protected static final boolean DEBUG_RC = false;
    protected static final boolean DEBUG_VOL = false;
    private static final Uri ENABLED_NOTIFICATION_LISTENERS_URI;
    private static final String EXTRA_WAKELOCK_ACQUIRED = "android.media.AudioService.WAKELOCK_ACQUIRED";
    protected static final String IN_VOICE_COMM_FOCUS_ID = "AudioFocus_For_Phone_Ring_And_Calls";
    private static final int MSG_RCC_GET_NOW_PLAYING_ENTRIES = 14;
    private static final int MSG_RCC_NEW_PLAYBACK_INFO = 4;
    private static final int MSG_RCC_NEW_PLAYBACK_STATE = 6;
    private static final int MSG_RCC_NEW_VOLUME_OBS = 5;
    private static final int MSG_RCC_SEEK_REQUEST = 7;
    private static final int MSG_RCC_SET_BROWSED_PLAYER = 12;
    private static final int MSG_RCC_SET_PLAY_ITEM = 13;
    private static final int MSG_RCC_UPDATE_METADATA = 8;
    private static final int MSG_RCDISPLAY_CLEAR = 1;
    private static final int MSG_RCDISPLAY_INIT_INFO = 9;
    private static final int MSG_RCDISPLAY_UPDATE = 2;
    private static final int MSG_REEVALUATE_RCD = 10;
    private static final int MSG_REEVALUATE_REMOTE = 3;
    private static final int MSG_UNREGISTER_MEDIABUTTONINTENT = 11;
    private static final int RCD_REG_FAILURE = 0;
    private static final int RCD_REG_SUCCESS_ENABLED_NOTIF = 2;
    private static final int RCD_REG_SUCCESS_PERMISSION = 1;
    private static final int RC_INFO_ALL = 15;
    private static final int RC_INFO_NONE = 0;
    private static final int SENDMSG_NOOP = 1;
    private static final int SENDMSG_QUEUE = 2;
    private static final int SENDMSG_REPLACE = 0;
    private static final String TAG = "MediaFocusControl";
    private static final int VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS = 1;
    private static final int VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS = 3;
    private static final int VOICEBUTTON_ACTION_START_VOICE_INPUT = 2;
    private static final int WAKELOCK_RELEASE_ON_FINISHED = 1980;
    private static final Object mAudioFocusLock;
    private static final Object mRingingLock;
    private final AppOpsManager mAppOps;
    private final AudioService mAudioService;
    private final ContentResolver mContentResolver;
    private final Context mContext;
    private IRemoteControlClient mCurrentRcClient;
    private int mCurrentRcClientGen;
    private PendingIntent mCurrentRcClientIntent;
    private final Object mCurrentRcLock;
    private final MediaEventHandler mEventHandler;
    private ArrayList<IAudioPolicyCallback> mFocusFollowers;
    private final Stack<FocusRequester> mFocusStack;
    private boolean mHasRemotePlayback;
    private boolean mIsRinging;
    BroadcastReceiver mKeyEventDone;
    private final KeyguardManager mKeyguardManager;
    private RemotePlaybackState mMainRemote;
    private boolean mMainRemoteIsActive;
    private final WakeLock mMediaEventWakeLock;
    private ComponentName mMediaReceiverForCalls;
    private final NotificationListenerObserver mNotifListenerObserver;
    private boolean mNotifyFocusOwnerOnDuck;
    private final Stack<PlayerRecord> mPRStack;
    private PhoneStateListener mPhoneStateListener;
    private ArrayList<DisplayInfoForServer> mRcDisplays;
    private boolean mVoiceButtonDown;
    private boolean mVoiceButtonHandled;
    private final Object mVoiceEventLock;
    private final VolumeController mVolumeController;

    /* renamed from: android.media.MediaFocusControl.1 */
    class C03701 extends PhoneStateListener {
        C03701() {
        }

        public void onCallStateChanged(int state, String incomingNumber) {
            if (state == MediaFocusControl.VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS) {
                synchronized (MediaFocusControl.mRingingLock) {
                    MediaFocusControl.this.mIsRinging = true;
                }
            } else if (state == MediaFocusControl.VOICEBUTTON_ACTION_START_VOICE_INPUT || state == 0) {
                synchronized (MediaFocusControl.mRingingLock) {
                    MediaFocusControl.this.mIsRinging = MediaFocusControl.DEBUG_VOL;
                }
            }
        }
    }

    /* renamed from: android.media.MediaFocusControl.2 */
    class C03712 extends BroadcastReceiver {
        C03712() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent != null) {
                Bundle extras = intent.getExtras();
                if (extras != null && extras.containsKey(MediaFocusControl.EXTRA_WAKELOCK_ACQUIRED)) {
                    MediaFocusControl.this.mMediaEventWakeLock.release();
                }
            }
        }
    }

    protected class AudioFocusDeathHandler implements DeathRecipient {
        private IBinder mCb;

        AudioFocusDeathHandler(IBinder cb) {
            this.mCb = cb;
        }

        public void binderDied() {
            synchronized (MediaFocusControl.mAudioFocusLock) {
                Log.w(MediaFocusControl.TAG, "  AudioFocus   audio focus client died");
                MediaFocusControl.this.removeFocusStackEntryForClient(this.mCb);
            }
        }

        public IBinder getBinder() {
            return this.mCb;
        }
    }

    private class DisplayInfoForServer implements DeathRecipient {
        private int mArtworkExpectedHeight;
        private int mArtworkExpectedWidth;
        private ComponentName mClientNotifListComp;
        private boolean mEnabled;
        private final IRemoteControlDisplay mRcDisplay;
        private final IBinder mRcDisplayBinder;
        private boolean mWantsPositionSync;

        public DisplayInfoForServer(IRemoteControlDisplay rcd, int w, int h) {
            this.mArtworkExpectedWidth = -1;
            this.mArtworkExpectedHeight = -1;
            this.mWantsPositionSync = MediaFocusControl.DEBUG_VOL;
            this.mEnabled = true;
            this.mRcDisplay = rcd;
            this.mRcDisplayBinder = rcd.asBinder();
            this.mArtworkExpectedWidth = w;
            this.mArtworkExpectedHeight = h;
        }

        public boolean init() {
            try {
                this.mRcDisplayBinder.linkToDeath(this, MediaFocusControl.SENDMSG_REPLACE);
                return true;
            } catch (RemoteException e) {
                Log.w(MediaFocusControl.TAG, "registerRemoteControlDisplay() has a dead client " + this.mRcDisplayBinder);
                return MediaFocusControl.DEBUG_VOL;
            }
        }

        public void release() {
            try {
                this.mRcDisplayBinder.unlinkToDeath(this, MediaFocusControl.SENDMSG_REPLACE);
            } catch (NoSuchElementException e) {
                Log.e(MediaFocusControl.TAG, "Error in DisplaInfoForServer.relase()", e);
            }
        }

        public void binderDied() {
            synchronized (MediaFocusControl.this.mPRStack) {
                Log.w(MediaFocusControl.TAG, "RemoteControl: display " + this.mRcDisplay + " died");
                Iterator<DisplayInfoForServer> displayIterator = MediaFocusControl.this.mRcDisplays.iterator();
                while (displayIterator.hasNext()) {
                    if (((DisplayInfoForServer) displayIterator.next()).mRcDisplay == this.mRcDisplay) {
                        displayIterator.remove();
                        return;
                    }
                }
            }
        }
    }

    private class MediaEventHandler extends Handler {
        MediaEventHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MediaFocusControl.VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS /*1*/:
                    MediaFocusControl.this.onRcDisplayClear();
                case MediaFocusControl.VOICEBUTTON_ACTION_START_VOICE_INPUT /*2*/:
                    MediaFocusControl.this.onRcDisplayUpdate((PlayerRecord) msg.obj, msg.arg1);
                case MediaFocusControl.VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS /*3*/:
                    MediaFocusControl.this.onReevaluateRemote();
                case MediaFocusControl.MSG_RCC_NEW_VOLUME_OBS /*5*/:
                    MediaFocusControl.this.onRegisterVolumeObserverForRcc(msg.arg1, (IRemoteVolumeObserver) msg.obj);
                case MediaFocusControl.MSG_RCDISPLAY_INIT_INFO /*9*/:
                    MediaFocusControl.this.onRcDisplayInitInfo((IRemoteControlDisplay) msg.obj, msg.arg1, msg.arg2);
                case MediaFocusControl.MSG_REEVALUATE_RCD /*10*/:
                    MediaFocusControl.this.onReevaluateRemoteControlDisplays();
                case MediaFocusControl.MSG_UNREGISTER_MEDIABUTTONINTENT /*11*/:
                    MediaFocusControl.this.unregisterMediaButtonIntent((PendingIntent) msg.obj);
                case MediaFocusControl.MSG_RCC_SET_BROWSED_PLAYER /*12*/:
                    Log.d(MediaFocusControl.TAG, "MSG_RCC_SET_BROWSED_PLAYER: ");
                    MediaFocusControl.this.onSetRemoteControlClientBrowsedPlayer();
                case MediaFocusControl.MSG_RCC_SET_PLAY_ITEM /*13*/:
                    Log.d(MediaFocusControl.TAG, "MSG_RCC_SET_PLAY_ITEM: " + ((Long) msg.obj).longValue());
                    MediaFocusControl.this.onSetRemoteControlClientPlayItem(msg.arg2, Long.valueOf(((Long) msg.obj).longValue()));
                case MediaFocusControl.MSG_RCC_GET_NOW_PLAYING_ENTRIES /*14*/:
                    Log.d(MediaFocusControl.TAG, "MSG_RCC_GET_NOW_PLAYING_ENTRIES: ");
                    MediaFocusControl.this.onGetRemoteControlClientNowPlayingEntries();
                default:
            }
        }
    }

    private class NotificationListenerObserver extends ContentObserver {
        NotificationListenerObserver() {
            super(MediaFocusControl.this.mEventHandler);
            MediaFocusControl.this.mContentResolver.registerContentObserver(Secure.getUriFor("enabled_notification_listeners"), MediaFocusControl.DEBUG_VOL, this);
        }

        public void onChange(boolean selfChange, Uri uri) {
            if (MediaFocusControl.ENABLED_NOTIFICATION_LISTENERS_URI.equals(uri) && !selfChange) {
                MediaFocusControl.this.postReevaluateRemoteControlDisplays();
            }
        }
    }

    protected MediaFocusControl(Looper looper, Context cntxt, VolumeController volumeCtrl, AudioService as) {
        this.mIsRinging = DEBUG_VOL;
        this.mPhoneStateListener = new C03701();
        this.mFocusStack = new Stack();
        this.mNotifyFocusOwnerOnDuck = true;
        this.mFocusFollowers = new ArrayList();
        this.mVoiceEventLock = new Object();
        this.mKeyEventDone = new C03712();
        this.mCurrentRcLock = new Object();
        this.mCurrentRcClient = null;
        this.mCurrentRcClientIntent = null;
        this.mCurrentRcClientGen = SENDMSG_REPLACE;
        this.mPRStack = new Stack();
        this.mMediaReceiverForCalls = null;
        this.mRcDisplays = new ArrayList(VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS);
        this.mEventHandler = new MediaEventHandler(looper);
        this.mContext = cntxt;
        this.mContentResolver = this.mContext.getContentResolver();
        this.mVolumeController = volumeCtrl;
        this.mAudioService = as;
        this.mMediaEventWakeLock = ((PowerManager) this.mContext.getSystemService(Context.POWER_SERVICE)).newWakeLock(VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS, "handleMediaEvent");
        this.mMainRemote = new RemotePlaybackState(-1, AudioService.getMaxStreamVolume(VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS), AudioService.getMaxStreamVolume(VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS));
        ((TelephonyManager) this.mContext.getSystemService(Context.TELEPHONY_SERVICE)).listen(this.mPhoneStateListener, 32);
        this.mAppOps = (AppOpsManager) this.mContext.getSystemService(Context.APP_OPS_SERVICE);
        this.mKeyguardManager = (KeyguardManager) this.mContext.getSystemService(Context.KEYGUARD_SERVICE);
        this.mNotifListenerObserver = new NotificationListenerObserver();
        this.mHasRemotePlayback = DEBUG_VOL;
        this.mMainRemoteIsActive = DEBUG_VOL;
        PlayerRecord.setMediaFocusControl(this);
        postReevaluateRemote();
    }

    protected void dump(PrintWriter pw) {
        dumpFocusStack(pw);
        dumpRCStack(pw);
        dumpRCCStack(pw);
        dumpRCDList(pw);
    }

    static {
        ENABLED_NOTIFICATION_LISTENERS_URI = Secure.getUriFor("enabled_notification_listeners");
        mAudioFocusLock = new Object();
        mRingingLock = new Object();
    }

    private int checkRcdRegistrationAuthorization(ComponentName listenerComp) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.MEDIA_CONTENT_CONTROL") == 0) {
            return VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
        }
        if (listenerComp != null) {
            long ident = Binder.clearCallingIdentity();
            try {
                String enabledNotifListeners = Secure.getStringForUser(this.mContext.getContentResolver(), "enabled_notification_listeners", ActivityManager.getCurrentUser());
                if (enabledNotifListeners != null) {
                    String[] components = enabledNotifListeners.split(":");
                    for (int i = SENDMSG_REPLACE; i < components.length; i += VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS) {
                        ComponentName component = ComponentName.unflattenFromString(components[i]);
                        if (component != null && listenerComp.equals(component)) {
                            return VOICEBUTTON_ACTION_START_VOICE_INPUT;
                        }
                    }
                }
                Binder.restoreCallingIdentity(ident);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return SENDMSG_REPLACE;
    }

    protected boolean registerRemoteController(IRemoteControlDisplay rcd, int w, int h, ComponentName listenerComp) {
        if (checkRcdRegistrationAuthorization(listenerComp) != 0) {
            registerRemoteControlDisplay_int(rcd, w, h, listenerComp);
            return true;
        }
        Slog.w(TAG, "Access denied to process: " + Binder.getCallingPid() + ", must have permission " + "android.permission.MEDIA_CONTENT_CONTROL" + " or be an enabled NotificationListenerService for registerRemoteController");
        return DEBUG_VOL;
    }

    protected boolean registerRemoteControlDisplay(IRemoteControlDisplay rcd, int w, int h) {
        if (checkRcdRegistrationAuthorization(null) != 0) {
            registerRemoteControlDisplay_int(rcd, w, h, null);
            return true;
        }
        Slog.w(TAG, "Access denied to process: " + Binder.getCallingPid() + ", must have permission " + "android.permission.MEDIA_CONTENT_CONTROL" + " to register IRemoteControlDisplay");
        return DEBUG_VOL;
    }

    private void postReevaluateRemoteControlDisplays() {
        sendMsg(this.mEventHandler, MSG_REEVALUATE_RCD, VOICEBUTTON_ACTION_START_VOICE_INPUT, SENDMSG_REPLACE, SENDMSG_REPLACE, null, SENDMSG_REPLACE);
    }

    private void onReevaluateRemoteControlDisplays() {
        String enabledNotifListeners = Secure.getStringForUser(this.mContext.getContentResolver(), "enabled_notification_listeners", ActivityManager.getCurrentUser());
        synchronized (mAudioFocusLock) {
            synchronized (this.mPRStack) {
                String[] enabledComponents;
                if (enabledNotifListeners == null) {
                    enabledComponents = null;
                } else {
                    enabledComponents = enabledNotifListeners.split(":");
                }
                Iterator<DisplayInfoForServer> displayIterator = this.mRcDisplays.iterator();
                while (displayIterator.hasNext()) {
                    DisplayInfoForServer di = (DisplayInfoForServer) displayIterator.next();
                    if (di.mClientNotifListComp != null) {
                        boolean wasEnabled = di.mEnabled;
                        di.mEnabled = isComponentInStringArray(di.mClientNotifListComp, enabledComponents);
                        if (wasEnabled != di.mEnabled) {
                            try {
                                di.mRcDisplay.setEnabled(di.mEnabled);
                                enableRemoteControlDisplayForClient_syncRcStack(di.mRcDisplay, di.mEnabled);
                                if (di.mEnabled) {
                                    sendMsg(this.mEventHandler, MSG_RCDISPLAY_INIT_INFO, VOICEBUTTON_ACTION_START_VOICE_INPUT, di.mArtworkExpectedWidth, di.mArtworkExpectedHeight, di.mRcDisplay, SENDMSG_REPLACE);
                                }
                            } catch (RemoteException e) {
                                Log.e(TAG, "Error en/disabling RCD: ", e);
                            }
                        } else {
                            continue;
                        }
                    }
                }
            }
        }
    }

    private boolean isComponentInStringArray(ComponentName comp, String[] enabledArray) {
        if (enabledArray == null || enabledArray.length == 0) {
            return DEBUG_VOL;
        }
        String compString = comp.flattenToString();
        for (int i = SENDMSG_REPLACE; i < enabledArray.length; i += VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS) {
            if (compString.equals(enabledArray[i])) {
                return true;
            }
        }
        return DEBUG_VOL;
    }

    private static void sendMsg(Handler handler, int msg, int existingMsgPolicy, int arg1, int arg2, Object obj, int delay) {
        if (existingMsgPolicy == 0) {
            handler.removeMessages(msg);
        } else if (existingMsgPolicy == VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS && handler.hasMessages(msg)) {
            return;
        }
        handler.sendMessageDelayed(handler.obtainMessage(msg, arg1, arg2, obj), (long) delay);
    }

    protected void discardAudioFocusOwner() {
        synchronized (mAudioFocusLock) {
            if (!this.mFocusStack.empty()) {
                FocusRequester exFocusOwner = (FocusRequester) this.mFocusStack.pop();
                exFocusOwner.handleFocusLoss(-1);
                exFocusOwner.release();
            }
        }
    }

    private void notifyTopOfAudioFocusStack() {
        if (!this.mFocusStack.empty() && canReassignAudioFocus()) {
            ((FocusRequester) this.mFocusStack.peek()).handleFocusGain(VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS);
        }
    }

    private void propagateFocusLossFromGain_syncAf(int focusGain) {
        Iterator<FocusRequester> stackIterator = this.mFocusStack.iterator();
        while (stackIterator.hasNext()) {
            ((FocusRequester) stackIterator.next()).handleExternalFocusGain(focusGain);
        }
    }

    private void dumpFocusStack(PrintWriter pw) {
        pw.println("\nAudio Focus stack entries (last is top of stack):");
        synchronized (mAudioFocusLock) {
            Iterator<FocusRequester> stackIterator = this.mFocusStack.iterator();
            while (stackIterator.hasNext()) {
                ((FocusRequester) stackIterator.next()).dump(pw);
            }
        }
        pw.println("\n Notify on duck: " + this.mNotifyFocusOwnerOnDuck + "\n");
    }

    private void removeFocusStackEntry(String clientToRemove, boolean signal, boolean notifyFocusFollowers) {
        FocusRequester fr;
        if (this.mFocusStack.empty() || !((FocusRequester) this.mFocusStack.peek()).hasSameClient(clientToRemove)) {
            Iterator<FocusRequester> stackIterator = this.mFocusStack.iterator();
            while (stackIterator.hasNext()) {
                fr = (FocusRequester) stackIterator.next();
                if (fr.hasSameClient(clientToRemove)) {
                    Log.i(TAG, "AudioFocus  removeFocusStackEntry(): removing entry for " + clientToRemove);
                    stackIterator.remove();
                    fr.release();
                }
            }
            return;
        }
        fr = (FocusRequester) this.mFocusStack.pop();
        fr.release();
        if (notifyFocusFollowers) {
            AudioFocusInfo afi = fr.toAudioFocusInfo();
            afi.clearLossReceived();
            notifyExtPolicyFocusLoss_syncAf(afi, DEBUG_VOL);
        }
        if (signal) {
            notifyTopOfAudioFocusStack();
        }
    }

    private void removeFocusStackEntryForClient(IBinder cb) {
        boolean isTopOfStackForClientToRemove = (this.mFocusStack.isEmpty() || !((FocusRequester) this.mFocusStack.peek()).hasSameBinder(cb)) ? DEBUG_VOL : true;
        Iterator<FocusRequester> stackIterator = this.mFocusStack.iterator();
        while (stackIterator.hasNext()) {
            if (((FocusRequester) stackIterator.next()).hasSameBinder(cb)) {
                Log.i(TAG, "AudioFocus  removeFocusStackEntry(): removing entry for " + cb);
                stackIterator.remove();
            }
        }
        if (isTopOfStackForClientToRemove) {
            notifyTopOfAudioFocusStack();
        }
    }

    private boolean canReassignAudioFocus() {
        if (this.mFocusStack.isEmpty() || !isLockedFocusOwner((FocusRequester) this.mFocusStack.peek())) {
            return true;
        }
        return DEBUG_VOL;
    }

    private boolean isLockedFocusOwner(FocusRequester fr) {
        return (fr.hasSameClient(IN_VOICE_COMM_FOCUS_ID) || fr.isLockedFocusOwner()) ? true : DEBUG_VOL;
    }

    private int pushBelowLockedFocusOwners(FocusRequester nfr) {
        int lastLockedFocusOwnerIndex = this.mFocusStack.size();
        for (int index = this.mFocusStack.size() - 1; index >= 0; index--) {
            if (isLockedFocusOwner((FocusRequester) this.mFocusStack.elementAt(index))) {
                lastLockedFocusOwnerIndex = index;
            }
        }
        if (lastLockedFocusOwnerIndex == this.mFocusStack.size()) {
            Log.e(TAG, "No exclusive focus owner found in propagateFocusLossFromGain_syncAf()", new Exception());
            propagateFocusLossFromGain_syncAf(nfr.getGainRequest());
            this.mFocusStack.push(nfr);
            return VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
        }
        this.mFocusStack.insertElementAt(nfr, lastLockedFocusOwnerIndex);
        return VOICEBUTTON_ACTION_START_VOICE_INPUT;
    }

    protected void setDuckingInExtPolicyAvailable(boolean available) {
        this.mNotifyFocusOwnerOnDuck = !available ? true : DEBUG_VOL;
    }

    boolean mustNotifyFocusOwnerOnDuck() {
        return this.mNotifyFocusOwnerOnDuck;
    }

    void addFocusFollower(IAudioPolicyCallback ff) {
        if (ff != null) {
            synchronized (mAudioFocusLock) {
                boolean found = DEBUG_VOL;
                Iterator i$ = this.mFocusFollowers.iterator();
                while (i$.hasNext()) {
                    if (((IAudioPolicyCallback) i$.next()).asBinder().equals(ff.asBinder())) {
                        found = true;
                        break;
                    }
                }
                if (found) {
                    return;
                }
                this.mFocusFollowers.add(ff);
            }
        }
    }

    void removeFocusFollower(IAudioPolicyCallback ff) {
        if (ff != null) {
            synchronized (mAudioFocusLock) {
                Iterator i$ = this.mFocusFollowers.iterator();
                while (i$.hasNext()) {
                    IAudioPolicyCallback pcb = (IAudioPolicyCallback) i$.next();
                    if (pcb.asBinder().equals(ff.asBinder())) {
                        this.mFocusFollowers.remove(pcb);
                        break;
                    }
                }
            }
        }
    }

    void notifyExtPolicyFocusGrant_syncAf(AudioFocusInfo afi, int requestResult) {
        Iterator i$ = this.mFocusFollowers.iterator();
        while (i$.hasNext()) {
            IAudioPolicyCallback pcb = (IAudioPolicyCallback) i$.next();
            try {
                pcb.notifyAudioFocusGrant(afi, requestResult);
            } catch (RemoteException e) {
                Log.e(TAG, "Can't call newAudioFocusLoser() on IAudioPolicyCallback " + pcb.asBinder(), e);
            }
        }
    }

    void notifyExtPolicyFocusLoss_syncAf(AudioFocusInfo afi, boolean wasDispatched) {
        Iterator i$ = this.mFocusFollowers.iterator();
        while (i$.hasNext()) {
            IAudioPolicyCallback pcb = (IAudioPolicyCallback) i$.next();
            try {
                pcb.notifyAudioFocusLoss(afi, wasDispatched);
            } catch (RemoteException e) {
                Log.e(TAG, "Can't call newAudioFocusLoser() on IAudioPolicyCallback " + pcb.asBinder(), e);
            }
        }
    }

    protected int getCurrentAudioFocus() {
        int i;
        synchronized (mAudioFocusLock) {
            if (this.mFocusStack.empty()) {
                i = SENDMSG_REPLACE;
            } else {
                i = ((FocusRequester) this.mFocusStack.peek()).getGainRequest();
            }
        }
        return i;
    }

    protected int requestAudioFocus(AudioAttributes aa, int focusChangeHint, IBinder cb, IAudioFocusDispatcher fd, String clientId, String callingPackageName, int flags) {
        Log.i(TAG, " AudioFocus  requestAudioFocus() from " + clientId + " req=" + focusChangeHint + "flags=0x" + Integer.toHexString(flags));
        if (!cb.pingBinder()) {
            Log.e(TAG, " AudioFocus DOA client for requestAudioFocus(), aborting.");
            return SENDMSG_REPLACE;
        } else if (this.mAppOps.noteOp(32, Binder.getCallingUid(), callingPackageName) != 0) {
            return SENDMSG_REPLACE;
        } else {
            synchronized (mAudioFocusLock) {
                boolean focusGrantDelayed = DEBUG_VOL;
                if (!canReassignAudioFocus()) {
                    if ((flags & VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS) == 0) {
                        return SENDMSG_REPLACE;
                    }
                    focusGrantDelayed = true;
                }
                AudioFocusDeathHandler afdh = new AudioFocusDeathHandler(cb);
                try {
                    cb.linkToDeath(afdh, SENDMSG_REPLACE);
                    if (!this.mFocusStack.empty() && ((FocusRequester) this.mFocusStack.peek()).hasSameClient(clientId)) {
                        FocusRequester fr = (FocusRequester) this.mFocusStack.peek();
                        if (fr.getGainRequest() == focusChangeHint && fr.getGrantFlags() == flags) {
                            cb.unlinkToDeath(afdh, SENDMSG_REPLACE);
                            notifyExtPolicyFocusGrant_syncAf(fr.toAudioFocusInfo(), VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS);
                            return VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
                        } else if (!focusGrantDelayed) {
                            this.mFocusStack.pop();
                            fr.release();
                        }
                    }
                    removeFocusStackEntry(clientId, DEBUG_VOL, DEBUG_VOL);
                    FocusRequester nfr = new FocusRequester(aa, focusChangeHint, flags, fd, cb, clientId, afdh, callingPackageName, Binder.getCallingUid(), this);
                    if (focusGrantDelayed) {
                        int requestResult = pushBelowLockedFocusOwners(nfr);
                        if (requestResult != 0) {
                            notifyExtPolicyFocusGrant_syncAf(nfr.toAudioFocusInfo(), requestResult);
                        }
                        return requestResult;
                    }
                    if (!this.mFocusStack.empty()) {
                        propagateFocusLossFromGain_syncAf(focusChangeHint);
                    }
                    this.mFocusStack.push(nfr);
                    notifyExtPolicyFocusGrant_syncAf(nfr.toAudioFocusInfo(), VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS);
                    return VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
                } catch (RemoteException e) {
                    Log.w(TAG, "AudioFocus  requestAudioFocus() could not link to " + cb + " binder death");
                    return SENDMSG_REPLACE;
                }
            }
        }
    }

    protected int abandonAudioFocus(IAudioFocusDispatcher fl, String clientId, AudioAttributes aa) {
        Log.i(TAG, " AudioFocus  abandonAudioFocus() from " + clientId);
        try {
            synchronized (mAudioFocusLock) {
                removeFocusStackEntry(clientId, true, true);
            }
        } catch (ConcurrentModificationException cme) {
            Log.e(TAG, "FATAL EXCEPTION AudioFocus  abandonAudioFocus() caused " + cme);
            cme.printStackTrace();
        }
        return VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
    }

    protected void unregisterAudioFocusClient(String clientId) {
        synchronized (mAudioFocusLock) {
            removeFocusStackEntry(clientId, DEBUG_VOL, true);
        }
    }

    protected void dispatchMediaKeyEvent(KeyEvent keyEvent) {
        filterMediaKeyEvent(keyEvent, DEBUG_VOL);
    }

    protected void dispatchMediaKeyEventUnderWakelock(KeyEvent keyEvent) {
        filterMediaKeyEvent(keyEvent, true);
    }

    private void filterMediaKeyEvent(KeyEvent keyEvent, boolean needWakeLock) {
        if (isValidMediaKeyEvent(keyEvent)) {
            synchronized (mRingingLock) {
                synchronized (this.mPRStack) {
                    if (this.mMediaReceiverForCalls == null || !(this.mIsRinging || this.mAudioService.getMode() == VOICEBUTTON_ACTION_START_VOICE_INPUT)) {
                        if (isValidVoiceInputKeyCode(keyEvent.getKeyCode())) {
                            filterVoiceInputKeyEvent(keyEvent, needWakeLock);
                            return;
                        } else {
                            dispatchMediaKeyEvent(keyEvent, needWakeLock);
                            return;
                        }
                    }
                    dispatchMediaKeyEventForCalls(keyEvent, needWakeLock);
                    return;
                }
            }
        } else {
            Log.e(TAG, "not dispatching invalid media key event " + keyEvent);
        }
    }

    private void dispatchMediaKeyEventForCalls(KeyEvent keyEvent, boolean needWakeLock) {
        Intent keyIntent = new Intent(Intent.ACTION_MEDIA_BUTTON, null);
        keyIntent.putExtra(Intent.EXTRA_KEY_EVENT, (Parcelable) keyEvent);
        keyIntent.setPackage(this.mMediaReceiverForCalls.getPackageName());
        if (needWakeLock) {
            this.mMediaEventWakeLock.acquire();
            keyIntent.putExtra(EXTRA_WAKELOCK_ACQUIRED, (int) WAKELOCK_RELEASE_ON_FINISHED);
        }
        long ident = Binder.clearCallingIdentity();
        try {
            this.mContext.sendOrderedBroadcastAsUser(keyIntent, UserHandle.ALL, null, this.mKeyEventDone, this.mEventHandler, -1, null, null);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void dispatchMediaKeyEvent(android.view.KeyEvent r18, boolean r19) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Exception block dominator not found, method:android.media.MediaFocusControl.dispatchMediaKeyEvent(android.view.KeyEvent, boolean):void. bs: [B:8:0x0029, B:27:0x0081]
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.searchTryCatchDominators(ProcessTryCatchRegions.java:86)
	at jadx.core.dex.visitors.regions.ProcessTryCatchRegions.process(ProcessTryCatchRegions.java:45)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.postProcessRegions(RegionMakerVisitor.java:57)
	at jadx.core.dex.visitors.regions.RegionMakerVisitor.visit(RegionMakerVisitor.java:52)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r17 = this;
        if (r19 == 0) goto L_0x0009;
    L_0x0002:
        r0 = r17;
        r2 = r0.mMediaEventWakeLock;
        r2.acquire();
    L_0x0009:
        r5 = new android.content.Intent;
        r2 = "android.intent.action.MEDIA_BUTTON";
        r3 = 0;
        r5.<init>(r2, r3);
        r2 = "android.intent.extra.KEY_EVENT";
        r0 = r18;
        r5.putExtra(r2, r0);
        r0 = r17;
        r0 = r0.mPRStack;
        r16 = r0;
        monitor-enter(r16);
        r0 = r17;	 Catch:{ all -> 0x0071 }
        r2 = r0.mPRStack;	 Catch:{ all -> 0x0071 }
        r2 = r2.empty();	 Catch:{ all -> 0x0071 }
        if (r2 != 0) goto L_0x0074;
    L_0x0029:
        r0 = r17;	 Catch:{ CanceledException -> 0x004c }
        r2 = r0.mPRStack;	 Catch:{ CanceledException -> 0x004c }
        r2 = r2.peek();	 Catch:{ CanceledException -> 0x004c }
        r2 = (android.media.PlayerRecord) r2;	 Catch:{ CanceledException -> 0x004c }
        r2 = r2.getMediaButtonIntent();	 Catch:{ CanceledException -> 0x004c }
        r0 = r17;	 Catch:{ CanceledException -> 0x004c }
        r3 = r0.mContext;	 Catch:{ CanceledException -> 0x004c }
        if (r19 == 0) goto L_0x004a;	 Catch:{ CanceledException -> 0x004c }
    L_0x003d:
        r4 = 1980; // 0x7bc float:2.775E-42 double:9.782E-321;	 Catch:{ CanceledException -> 0x004c }
    L_0x003f:
        r0 = r17;	 Catch:{ CanceledException -> 0x004c }
        r7 = r0.mEventHandler;	 Catch:{ CanceledException -> 0x004c }
        r6 = r17;	 Catch:{ CanceledException -> 0x004c }
        r2.send(r3, r4, r5, r6, r7);	 Catch:{ CanceledException -> 0x004c }
    L_0x0048:
        monitor-exit(r16);	 Catch:{ all -> 0x0071 }
        return;	 Catch:{ all -> 0x0071 }
    L_0x004a:
        r4 = 0;	 Catch:{ all -> 0x0071 }
        goto L_0x003f;	 Catch:{ all -> 0x0071 }
    L_0x004c:
        r13 = move-exception;	 Catch:{ all -> 0x0071 }
        r2 = "MediaFocusControl";	 Catch:{ all -> 0x0071 }
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0071 }
        r3.<init>();	 Catch:{ all -> 0x0071 }
        r4 = "Error sending pending intent ";	 Catch:{ all -> 0x0071 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0071 }
        r0 = r17;	 Catch:{ all -> 0x0071 }
        r4 = r0.mPRStack;	 Catch:{ all -> 0x0071 }
        r4 = r4.peek();	 Catch:{ all -> 0x0071 }
        r3 = r3.append(r4);	 Catch:{ all -> 0x0071 }
        r3 = r3.toString();	 Catch:{ all -> 0x0071 }
        android.util.Log.e(r2, r3);	 Catch:{ all -> 0x0071 }
        r13.printStackTrace();	 Catch:{ all -> 0x0071 }
        goto L_0x0048;	 Catch:{ all -> 0x0071 }
    L_0x0071:
        r2 = move-exception;	 Catch:{ all -> 0x0071 }
        monitor-exit(r16);	 Catch:{ all -> 0x0071 }
        throw r2;
    L_0x0074:
        if (r19 == 0) goto L_0x007d;
    L_0x0076:
        r2 = "android.media.AudioService.WAKELOCK_ACQUIRED";	 Catch:{ all -> 0x0071 }
        r3 = 1980; // 0x7bc float:2.775E-42 double:9.782E-321;	 Catch:{ all -> 0x0071 }
        r5.putExtra(r2, r3);	 Catch:{ all -> 0x0071 }
    L_0x007d:
        r14 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x0071 }
        r0 = r17;	 Catch:{ all -> 0x009a }
        r4 = r0.mContext;	 Catch:{ all -> 0x009a }
        r6 = android.os.UserHandle.ALL;	 Catch:{ all -> 0x009a }
        r7 = 0;	 Catch:{ all -> 0x009a }
        r0 = r17;	 Catch:{ all -> 0x009a }
        r8 = r0.mKeyEventDone;	 Catch:{ all -> 0x009a }
        r0 = r17;	 Catch:{ all -> 0x009a }
        r9 = r0.mEventHandler;	 Catch:{ all -> 0x009a }
        r10 = -1;	 Catch:{ all -> 0x009a }
        r11 = 0;	 Catch:{ all -> 0x009a }
        r12 = 0;	 Catch:{ all -> 0x009a }
        r4.sendOrderedBroadcastAsUser(r5, r6, r7, r8, r9, r10, r11, r12);	 Catch:{ all -> 0x009a }
        android.os.Binder.restoreCallingIdentity(r14);	 Catch:{ all -> 0x0071 }
        goto L_0x0048;	 Catch:{ all -> 0x0071 }
    L_0x009a:
        r2 = move-exception;	 Catch:{ all -> 0x0071 }
        android.os.Binder.restoreCallingIdentity(r14);	 Catch:{ all -> 0x0071 }
        throw r2;	 Catch:{ all -> 0x0071 }
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.dispatchMediaKeyEvent(android.view.KeyEvent, boolean):void");
    }

    private void filterVoiceInputKeyEvent(KeyEvent keyEvent, boolean needWakeLock) {
        int voiceButtonAction = VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
        int keyAction = keyEvent.getAction();
        synchronized (this.mVoiceEventLock) {
            if (keyAction == 0) {
                if (keyEvent.getRepeatCount() == 0) {
                    this.mVoiceButtonDown = true;
                    this.mVoiceButtonHandled = DEBUG_VOL;
                } else if (!(!this.mVoiceButtonDown || this.mVoiceButtonHandled || (keyEvent.getFlags() & AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS) == 0)) {
                    this.mVoiceButtonHandled = true;
                    voiceButtonAction = VOICEBUTTON_ACTION_START_VOICE_INPUT;
                }
            } else if (keyAction == VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS && this.mVoiceButtonDown) {
                this.mVoiceButtonDown = DEBUG_VOL;
                if (!(this.mVoiceButtonHandled || keyEvent.isCanceled())) {
                    voiceButtonAction = VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS;
                }
            }
        }
        switch (voiceButtonAction) {
            case VOICEBUTTON_ACTION_START_VOICE_INPUT /*2*/:
                startVoiceBasedInteractions(needWakeLock);
            case VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS /*3*/:
                sendSimulatedMediaButtonEvent(keyEvent, needWakeLock);
            default:
        }
    }

    private void sendSimulatedMediaButtonEvent(KeyEvent originalKeyEvent, boolean needWakeLock) {
        dispatchMediaKeyEvent(KeyEvent.changeAction(originalKeyEvent, SENDMSG_REPLACE), needWakeLock);
        dispatchMediaKeyEvent(KeyEvent.changeAction(originalKeyEvent, VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS), needWakeLock);
    }

    private static boolean isValidMediaKeyEvent(KeyEvent keyEvent) {
        if (keyEvent == null) {
            return DEBUG_VOL;
        }
        return KeyEvent.isMediaKey(keyEvent.getKeyCode());
    }

    private static boolean isValidVoiceInputKeyCode(int keyCode) {
        if (keyCode == 79) {
            return true;
        }
        return DEBUG_VOL;
    }

    private void startVoiceBasedInteractions(boolean needWakeLock) {
        boolean isLocked;
        Intent voiceIntent;
        boolean z = true;
        PowerManager pm = (PowerManager) this.mContext.getSystemService(Context.POWER_SERVICE);
        if (this.mKeyguardManager == null || !this.mKeyguardManager.isKeyguardLocked()) {
            isLocked = DEBUG_VOL;
        } else {
            isLocked = true;
        }
        if (isLocked || !pm.isScreenOn()) {
            voiceIntent = new Intent(RecognizerIntent.ACTION_VOICE_SEARCH_HANDS_FREE);
            String str = RecognizerIntent.EXTRA_SECURE;
            if (!(isLocked && this.mKeyguardManager.isKeyguardSecure())) {
                z = DEBUG_VOL;
            }
            voiceIntent.putExtra(str, z);
            Log.i(TAG, "voice-based interactions: about to use ACTION_VOICE_SEARCH_HANDS_FREE");
        } else {
            voiceIntent = new Intent(RecognizerIntent.ACTION_WEB_SEARCH);
            Log.i(TAG, "voice-based interactions: about to use ACTION_WEB_SEARCH");
        }
        if (needWakeLock) {
            this.mMediaEventWakeLock.acquire();
        }
        long identity = Binder.clearCallingIdentity();
        if (voiceIntent != null) {
            try {
                voiceIntent.setFlags(276824064);
                this.mContext.startActivityAsUser(voiceIntent, UserHandle.CURRENT);
            } catch (ActivityNotFoundException e) {
                Log.w(TAG, "No activity for search: " + e);
                Binder.restoreCallingIdentity(identity);
                if (needWakeLock) {
                    this.mMediaEventWakeLock.release();
                    return;
                }
                return;
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(identity);
                if (needWakeLock) {
                    this.mMediaEventWakeLock.release();
                }
            }
        }
        Binder.restoreCallingIdentity(identity);
        if (needWakeLock) {
            this.mMediaEventWakeLock.release();
        }
    }

    public void onSendFinished(PendingIntent pendingIntent, Intent intent, int resultCode, String resultData, Bundle resultExtras) {
        if (resultCode == WAKELOCK_RELEASE_ON_FINISHED) {
            this.mMediaEventWakeLock.release();
        }
    }

    private void dumpRCStack(PrintWriter pw) {
        pw.println("\nRemote Control stack entries (last is top of stack):");
        synchronized (this.mPRStack) {
            Iterator<PlayerRecord> stackIterator = this.mPRStack.iterator();
            while (stackIterator.hasNext()) {
                ((PlayerRecord) stackIterator.next()).dump(pw, true);
            }
        }
    }

    private void dumpRCCStack(PrintWriter pw) {
        pw.println("\nRemote Control Client stack entries (last is top of stack):");
        synchronized (this.mPRStack) {
            Iterator<PlayerRecord> stackIterator = this.mPRStack.iterator();
            while (stackIterator.hasNext()) {
                ((PlayerRecord) stackIterator.next()).dump(pw, DEBUG_VOL);
            }
            synchronized (this.mCurrentRcLock) {
                pw.println("\nCurrent remote control generation ID = " + this.mCurrentRcClientGen);
            }
        }
        synchronized (this.mMainRemote) {
            pw.println("\nRemote Volume State:");
            pw.println("  has remote: " + this.mHasRemotePlayback);
            pw.println("  is remote active: " + this.mMainRemoteIsActive);
            pw.println("  rccId: " + this.mMainRemote.mRccId);
            pw.println("  volume handling: " + (this.mMainRemote.mVolumeHandling == 0 ? "PLAYBACK_VOLUME_FIXED(0)" : "PLAYBACK_VOLUME_VARIABLE(1)"));
            pw.println("  volume: " + this.mMainRemote.mVolume);
            pw.println("  volume steps: " + this.mMainRemote.mVolumeMax);
        }
    }

    private void dumpRCDList(PrintWriter pw) {
        pw.println("\nRemote Control Display list entries:");
        synchronized (this.mPRStack) {
            Iterator<DisplayInfoForServer> displayIterator = this.mRcDisplays.iterator();
            while (displayIterator.hasNext()) {
                DisplayInfoForServer di = (DisplayInfoForServer) displayIterator.next();
                pw.println("  IRCD: " + di.mRcDisplay + "  -- w:" + di.mArtworkExpectedWidth + "  -- h:" + di.mArtworkExpectedHeight + "  -- wantsPosSync:" + di.mWantsPositionSync + "  -- " + (di.mEnabled ? SettingInjectorService.ENABLED_KEY : "disabled"));
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean pushMediaButtonReceiver_syncPrs(android.app.PendingIntent r13, android.content.ComponentName r14, android.os.IBinder r15) {
        /*
        r12 = this;
        r8 = r12.mPRStack;
        r8 = r8.empty();
        if (r8 == 0) goto L_0x0014;
    L_0x0008:
        r8 = r12.mPRStack;
        r9 = new android.media.PlayerRecord;
        r9.<init>(r13, r14, r15);
        r8.push(r9);
        r7 = 1;
    L_0x0013:
        return r7;
    L_0x0014:
        r8 = r12.mPRStack;
        r8 = r8.peek();
        r8 = (android.media.PlayerRecord) r8;
        r8 = r8.hasMatchingMediaButtonIntent(r13);
        if (r8 == 0) goto L_0x0024;
    L_0x0022:
        r7 = 0;
        goto L_0x0013;
    L_0x0024:
        r8 = r12.mAppOps;
        r9 = 31;
        r10 = android.os.Binder.getCallingUid();
        r11 = r13.getCreatorPackage();
        r8 = r8.noteOp(r9, r10, r11);
        if (r8 == 0) goto L_0x0038;
    L_0x0036:
        r7 = 0;
        goto L_0x0013;
    L_0x0038:
        r8 = r12.mPRStack;
        r4 = r8.lastElement();
        r4 = (android.media.PlayerRecord) r4;
        r7 = 0;
        r5 = 0;
        r8 = r12.mPRStack;
        r3 = r8.size();
        r1 = -1;
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8 = r8.size();	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r2 = r8 + -1;
        r6 = r5;
    L_0x0052:
        if (r2 < 0) goto L_0x006e;
    L_0x0054:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r5 = r8.elementAt(r2);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r5 = (android.media.PlayerRecord) r5;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r8 = r5.isPlaybackActive();	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        if (r8 == 0) goto L_0x0063;
    L_0x0062:
        r3 = r2;
    L_0x0063:
        r8 = r5.hasMatchingMediaButtonIntent(r13);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        if (r8 == 0) goto L_0x006a;
    L_0x0069:
        r1 = r2;
    L_0x006a:
        r2 = r2 + -1;
        r6 = r5;
        goto L_0x0052;
    L_0x006e:
        r8 = -1;
        if (r1 != r8) goto L_0x00b7;
    L_0x0071:
        r5 = new android.media.PlayerRecord;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r5.<init>(r13, r14, r15);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8.add(r3, r5);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        goto L_0x0013;
    L_0x007c:
        r0 = move-exception;
    L_0x007d:
        r8 = "MediaFocusControl";
        r9 = new java.lang.StringBuilder;
        r9.<init>();
        r10 = "Wrong index (inStack=";
        r9 = r9.append(r10);
        r9 = r9.append(r1);
        r10 = " lastPlaying=";
        r9 = r9.append(r10);
        r9 = r9.append(r3);
        r10 = " size=";
        r9 = r9.append(r10);
        r10 = r12.mPRStack;
        r10 = r10.size();
        r9 = r9.append(r10);
        r10 = " accessing media button stack";
        r9 = r9.append(r10);
        r9 = r9.toString();
        android.util.Log.e(r8, r9, r0);
        goto L_0x0013;
    L_0x00b7:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r8 = r8.size();	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r9 = 1;
        if (r8 <= r9) goto L_0x00ef;
    L_0x00c0:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r5 = r8.elementAt(r1);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r5 = (android.media.PlayerRecord) r5;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x00ec }
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8.removeElementAt(r1);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8 = r5.isPlaybackActive();	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        if (r8 == 0) goto L_0x00da;
    L_0x00d3:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8.push(r5);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        goto L_0x0013;
    L_0x00da:
        if (r1 <= r3) goto L_0x00e3;
    L_0x00dc:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r8.add(r3, r5);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        goto L_0x0013;
    L_0x00e3:
        r8 = r12.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        r9 = r3 + -1;
        r8.add(r9, r5);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x007c }
        goto L_0x0013;
    L_0x00ec:
        r0 = move-exception;
        r5 = r6;
        goto L_0x007d;
    L_0x00ef:
        r5 = r6;
        goto L_0x0013;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.pushMediaButtonReceiver_syncPrs(android.app.PendingIntent, android.content.ComponentName, android.os.IBinder):boolean");
    }

    private void removeMediaButtonReceiver_syncPrs(PendingIntent pi) {
        try {
            for (int index = this.mPRStack.size() - 1; index >= 0; index--) {
                PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                if (prse.hasMatchingMediaButtonIntent(pi)) {
                    prse.destroy();
                    this.mPRStack.removeElementAt(index);
                    return;
                }
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            Log.e(TAG, "Wrong index accessing media button stack, lock error? ", e);
        }
    }

    private boolean isCurrentRcController(PendingIntent pi) {
        if (this.mPRStack.empty() || !((PlayerRecord) this.mPRStack.peek()).hasMatchingMediaButtonIntent(pi)) {
            return DEBUG_VOL;
        }
        return true;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void setNewRcClientOnDisplays_syncRcsCurrc(int r7, android.app.PendingIntent r8, boolean r9) {
        /*
        r6 = this;
        r4 = r6.mPRStack;
        monitor-enter(r4);
        r3 = r6.mRcDisplays;	 Catch:{ all -> 0x0034 }
        r3 = r3.size();	 Catch:{ all -> 0x0034 }
        if (r3 <= 0) goto L_0x0037;
    L_0x000b:
        r3 = r6.mRcDisplays;	 Catch:{ all -> 0x0034 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0034 }
    L_0x0011:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0034 }
        if (r3 == 0) goto L_0x0037;
    L_0x0017:
        r0 = r1.next();	 Catch:{ all -> 0x0034 }
        r0 = (android.media.MediaFocusControl.DisplayInfoForServer) r0;	 Catch:{ all -> 0x0034 }
        r3 = r0.mRcDisplay;	 Catch:{ RemoteException -> 0x0025 }
        r3.setCurrentClientId(r7, r8, r9);	 Catch:{ RemoteException -> 0x0025 }
        goto L_0x0011;
    L_0x0025:
        r2 = move-exception;
        r3 = "MediaFocusControl";
        r5 = "Dead display in setNewRcClientOnDisplays_syncRcsCurrc()";
        android.util.Log.e(r3, r5, r2);	 Catch:{ all -> 0x0034 }
        r0.release();	 Catch:{ all -> 0x0034 }
        r1.remove();	 Catch:{ all -> 0x0034 }
        goto L_0x0011;
    L_0x0034:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0034 }
        throw r3;
    L_0x0037:
        monitor-exit(r4);	 Catch:{ all -> 0x0034 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.setNewRcClientOnDisplays_syncRcsCurrc(int, android.app.PendingIntent, boolean):void");
    }

    private void setNewRcClientGenerationOnClients_syncRcsCurrc(int newClientGeneration) {
        Iterator<PlayerRecord> stackIterator = this.mPRStack.iterator();
        while (stackIterator.hasNext()) {
            PlayerRecord se = (PlayerRecord) stackIterator.next();
            if (!(se == null || se.getRcc() == null)) {
                try {
                    se.getRcc().setCurrentClientGenerationId(newClientGeneration);
                } catch (RemoteException e) {
                    Log.w(TAG, "Dead client in setNewRcClientGenerationOnClients_syncRcsCurrc()", e);
                    stackIterator.remove();
                    se.unlinkToRcClientDeath();
                }
            }
        }
    }

    private void setNewRcClient_syncRcsCurrc(int newClientGeneration, PendingIntent newMediaIntent, boolean clearing) {
        setNewRcClientOnDisplays_syncRcsCurrc(newClientGeneration, newMediaIntent, clearing);
        setNewRcClientGenerationOnClients_syncRcsCurrc(newClientGeneration);
    }

    private void onRcDisplayClear() {
        synchronized (this.mPRStack) {
            synchronized (this.mCurrentRcLock) {
                this.mCurrentRcClientGen += VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
                setNewRcClient_syncRcsCurrc(this.mCurrentRcClientGen, null, true);
            }
        }
    }

    private void onRcDisplayUpdate(PlayerRecord prse, int flags) {
        synchronized (this.mPRStack) {
            synchronized (this.mCurrentRcLock) {
                if (this.mCurrentRcClient != null && this.mCurrentRcClient.equals(prse.getRcc())) {
                    this.mCurrentRcClientGen += VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS;
                    setNewRcClient_syncRcsCurrc(this.mCurrentRcClientGen, prse.getMediaButtonIntent(), DEBUG_VOL);
                    try {
                        this.mCurrentRcClient.onInformationRequested(this.mCurrentRcClientGen, flags);
                    } catch (RemoteException e) {
                        Log.e(TAG, "Current valid remote client is dead: " + e);
                        this.mCurrentRcClient = null;
                    }
                }
            }
        }
    }

    private void onRcDisplayInitInfo(IRemoteControlDisplay newRcd, int w, int h) {
        synchronized (this.mPRStack) {
            synchronized (this.mCurrentRcLock) {
                if (this.mCurrentRcClient != null) {
                    try {
                        newRcd.setCurrentClientId(this.mCurrentRcClientGen, this.mCurrentRcClientIntent, DEBUG_VOL);
                        try {
                            this.mCurrentRcClient.informationRequestForDisplay(newRcd, w, h);
                        } catch (RemoteException e) {
                            Log.e(TAG, "Current valid remote client is dead: ", e);
                            this.mCurrentRcClient = null;
                        }
                    } catch (RemoteException e2) {
                        Log.e(TAG, "Dead display in onRcDisplayInitInfo()", e2);
                    }
                }
            }
        }
    }

    private void clearRemoteControlDisplay_syncPrs() {
        synchronized (this.mCurrentRcLock) {
            this.mCurrentRcClient = null;
        }
        this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(VOICEBUTTON_ACTION_DISCARD_CURRENT_KEY_PRESS));
    }

    private void updateRemoteControlDisplay_syncPrs(int infoChangedFlags) {
        PlayerRecord prse = (PlayerRecord) this.mPRStack.peek();
        int infoFlagsAboutToBeUsed = infoChangedFlags;
        if (prse.getRcc() == null) {
            clearRemoteControlDisplay_syncPrs();
            return;
        }
        synchronized (this.mCurrentRcLock) {
            if (!prse.getRcc().equals(this.mCurrentRcClient)) {
                infoFlagsAboutToBeUsed = RC_INFO_ALL;
            }
            this.mCurrentRcClient = prse.getRcc();
            this.mCurrentRcClientIntent = prse.getMediaButtonIntent();
        }
        this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(VOICEBUTTON_ACTION_START_VOICE_INPUT, infoFlagsAboutToBeUsed, SENDMSG_REPLACE, prse));
    }

    private void checkUpdateRemoteControlDisplay_syncPrs(int infoChangedFlags) {
        if (this.mPRStack.isEmpty()) {
            clearRemoteControlDisplay_syncPrs();
        } else {
            updateRemoteControlDisplay_syncPrs(infoChangedFlags);
        }
    }

    protected void registerMediaButtonIntent(PendingIntent mediaIntent, ComponentName eventReceiver, IBinder token) {
        Log.i(TAG, "  Remote Control   registerMediaButtonIntent() for " + mediaIntent);
        synchronized (this.mPRStack) {
            if (pushMediaButtonReceiver_syncPrs(mediaIntent, eventReceiver, token)) {
                checkUpdateRemoteControlDisplay_syncPrs(RC_INFO_ALL);
            }
        }
    }

    protected void unregisterMediaButtonIntent(PendingIntent mediaIntent) {
        Log.i(TAG, "  Remote Control   unregisterMediaButtonIntent() for " + mediaIntent);
        synchronized (this.mPRStack) {
            boolean topOfStackWillChange = isCurrentRcController(mediaIntent);
            removeMediaButtonReceiver_syncPrs(mediaIntent);
            if (topOfStackWillChange) {
                checkUpdateRemoteControlDisplay_syncPrs(RC_INFO_ALL);
            }
        }
    }

    protected void unregisterMediaButtonIntentAsync(PendingIntent mediaIntent) {
        this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(MSG_UNREGISTER_MEDIABUTTONINTENT, SENDMSG_REPLACE, SENDMSG_REPLACE, mediaIntent));
    }

    protected void registerMediaButtonEventReceiverForCalls(ComponentName c) {
        if (this.mContext.checkCallingPermission("android.permission.MODIFY_PHONE_STATE") != 0) {
            Log.e(TAG, "Invalid permissions to register media button receiver for calls");
            return;
        }
        synchronized (this.mPRStack) {
            this.mMediaReceiverForCalls = c;
        }
    }

    protected void unregisterMediaButtonEventReceiverForCalls() {
        if (this.mContext.checkCallingPermission("android.permission.MODIFY_PHONE_STATE") != 0) {
            Log.e(TAG, "Invalid permissions to unregister media button receiver for calls");
            return;
        }
        synchronized (this.mPRStack) {
            this.mMediaReceiverForCalls = null;
        }
    }

    protected int registerRemoteControlClient(PendingIntent mediaIntent, IRemoteControlClient rcClient, String callingPackageName) {
        int rccId = -1;
        synchronized (this.mPRStack) {
            try {
                int index = this.mPRStack.size() - 1;
                while (index >= 0) {
                    PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                    if (prse.hasMatchingMediaButtonIntent(mediaIntent)) {
                        prse.resetControllerInfoForRcc(rcClient, callingPackageName, Binder.getCallingUid());
                        if (rcClient != null) {
                            rccId = prse.getRccId();
                            if (this.mRcDisplays.size() > 0) {
                                plugRemoteControlDisplaysIntoClient_syncPrs(prse.getRcc());
                            }
                        }
                    } else {
                        index--;
                    }
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                Log.e(TAG, "Wrong index accessing RC stack, lock error? ", e);
            }
            if (isCurrentRcController(mediaIntent)) {
                checkUpdateRemoteControlDisplay_syncPrs(RC_INFO_ALL);
            }
        }
        return rccId;
    }

    protected void unregisterRemoteControlClient(PendingIntent mediaIntent, IRemoteControlClient rcClient) {
        synchronized (this.mPRStack) {
            boolean topRccChange = DEBUG_VOL;
            try {
                int index = this.mPRStack.size() - 1;
                while (index >= 0) {
                    PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                    if (prse.hasMatchingMediaButtonIntent(mediaIntent) && rcClient.equals(prse.getRcc())) {
                        prse.resetControllerInfoForNoRcc();
                        topRccChange = index == this.mPRStack.size() + -1 ? true : DEBUG_VOL;
                        if (topRccChange) {
                            checkUpdateRemoteControlDisplay_syncPrs(RC_INFO_ALL);
                        }
                    } else {
                        index--;
                    }
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                Log.e(TAG, "Wrong index accessing RC stack, lock error? ", e);
            }
            if (topRccChange) {
                checkUpdateRemoteControlDisplay_syncPrs(RC_INFO_ALL);
            }
        }
    }

    private void plugRemoteControlDisplaysIntoClient_syncPrs(IRemoteControlClient rcc) {
        Iterator<DisplayInfoForServer> displayIterator = this.mRcDisplays.iterator();
        while (displayIterator.hasNext()) {
            DisplayInfoForServer di = (DisplayInfoForServer) displayIterator.next();
            try {
                rcc.plugRemoteControlDisplay(di.mRcDisplay, di.mArtworkExpectedWidth, di.mArtworkExpectedHeight);
                if (di.mWantsPositionSync) {
                    rcc.setWantsSyncForDisplay(di.mRcDisplay, true);
                }
            } catch (RemoteException e) {
                Log.e(TAG, "Error connecting RCD to RCC in RCC registration", e);
            }
        }
    }

    private void enableRemoteControlDisplayForClient_syncRcStack(IRemoteControlDisplay rcd, boolean enabled) {
        Iterator<PlayerRecord> stackIterator = this.mPRStack.iterator();
        while (stackIterator.hasNext()) {
            PlayerRecord prse = (PlayerRecord) stackIterator.next();
            if (prse.getRcc() != null) {
                try {
                    prse.getRcc().enableRemoteControlDisplay(rcd, enabled);
                } catch (RemoteException e) {
                    Log.e(TAG, "Error connecting RCD to client: ", e);
                }
            }
        }
    }

    private boolean rcDisplayIsPluggedIn_syncRcStack(IRemoteControlDisplay rcd) {
        Iterator<DisplayInfoForServer> displayIterator = this.mRcDisplays.iterator();
        while (displayIterator.hasNext()) {
            if (((DisplayInfoForServer) displayIterator.next()).mRcDisplay.asBinder().equals(rcd.asBinder())) {
                return true;
            }
        }
        return DEBUG_VOL;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void registerRemoteControlDisplay_int(android.media.IRemoteControlDisplay r18, int r19, int r20, android.content.ComponentName r21) {
        /*
        r17 = this;
        r15 = mAudioFocusLock;
        monitor-enter(r15);
        r0 = r17;
        r0 = r0.mPRStack;	 Catch:{ all -> 0x0034 }
        r16 = r0;
        monitor-enter(r16);	 Catch:{ all -> 0x0034 }
        if (r18 == 0) goto L_0x0012;
    L_0x000c:
        r4 = r17.rcDisplayIsPluggedIn_syncRcStack(r18);	 Catch:{ all -> 0x006f }
        if (r4 == 0) goto L_0x0015;
    L_0x0012:
        monitor-exit(r16);	 Catch:{ all -> 0x006f }
        monitor-exit(r15);	 Catch:{ all -> 0x0034 }
    L_0x0014:
        return;
    L_0x0015:
        r11 = new android.media.MediaFocusControl$DisplayInfoForServer;	 Catch:{ all -> 0x006f }
        r0 = r17;
        r1 = r18;
        r2 = r19;
        r3 = r20;
        r11.<init>(r1, r2, r3);	 Catch:{ all -> 0x006f }
        r4 = 1;
        r11.mEnabled = r4;	 Catch:{ all -> 0x006f }
        r0 = r21;
        r11.mClientNotifListComp = r0;	 Catch:{ all -> 0x006f }
        r4 = r11.init();	 Catch:{ all -> 0x006f }
        if (r4 != 0) goto L_0x0037;
    L_0x0031:
        monitor-exit(r16);	 Catch:{ all -> 0x006f }
        monitor-exit(r15);	 Catch:{ all -> 0x0034 }
        goto L_0x0014;
    L_0x0034:
        r4 = move-exception;
        monitor-exit(r15);	 Catch:{ all -> 0x0034 }
        throw r4;
    L_0x0037:
        r0 = r17;
        r4 = r0.mRcDisplays;	 Catch:{ all -> 0x006f }
        r4.add(r11);	 Catch:{ all -> 0x006f }
        r0 = r17;
        r4 = r0.mPRStack;	 Catch:{ all -> 0x006f }
        r14 = r4.iterator();	 Catch:{ all -> 0x006f }
    L_0x0046:
        r4 = r14.hasNext();	 Catch:{ all -> 0x006f }
        if (r4 == 0) goto L_0x0072;
    L_0x004c:
        r13 = r14.next();	 Catch:{ all -> 0x006f }
        r13 = (android.media.PlayerRecord) r13;	 Catch:{ all -> 0x006f }
        r4 = r13.getRcc();	 Catch:{ all -> 0x006f }
        if (r4 == 0) goto L_0x0046;
    L_0x0058:
        r4 = r13.getRcc();	 Catch:{ RemoteException -> 0x0066 }
        r0 = r18;
        r1 = r19;
        r2 = r20;
        r4.plugRemoteControlDisplay(r0, r1, r2);	 Catch:{ RemoteException -> 0x0066 }
        goto L_0x0046;
    L_0x0066:
        r12 = move-exception;
        r4 = "MediaFocusControl";
        r5 = "Error connecting RCD to client: ";
        android.util.Log.e(r4, r5, r12);	 Catch:{ all -> 0x006f }
        goto L_0x0046;
    L_0x006f:
        r4 = move-exception;
        monitor-exit(r16);	 Catch:{ all -> 0x006f }
        throw r4;	 Catch:{ all -> 0x0034 }
    L_0x0072:
        r0 = r17;
        r4 = r0.mEventHandler;	 Catch:{ all -> 0x006f }
        r5 = 9;
        r6 = 2;
        r10 = 0;
        r7 = r19;
        r8 = r20;
        r9 = r18;
        sendMsg(r4, r5, r6, r7, r8, r9, r10);	 Catch:{ all -> 0x006f }
        monitor-exit(r16);	 Catch:{ all -> 0x006f }
        monitor-exit(r15);	 Catch:{ all -> 0x0034 }
        goto L_0x0014;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.registerRemoteControlDisplay_int(android.media.IRemoteControlDisplay, int, int, android.content.ComponentName):void");
    }

    protected void unregisterRemoteControlDisplay(IRemoteControlDisplay rcd) {
        synchronized (this.mPRStack) {
            if (rcd == null) {
                return;
            }
            boolean displayWasPluggedIn = DEBUG_VOL;
            Iterator<DisplayInfoForServer> displayIterator = this.mRcDisplays.iterator();
            while (displayIterator.hasNext() && !displayWasPluggedIn) {
                DisplayInfoForServer di = (DisplayInfoForServer) displayIterator.next();
                if (di.mRcDisplay.asBinder().equals(rcd.asBinder())) {
                    displayWasPluggedIn = true;
                    di.release();
                    displayIterator.remove();
                }
            }
            if (displayWasPluggedIn) {
                Iterator<PlayerRecord> stackIterator = this.mPRStack.iterator();
                while (stackIterator.hasNext()) {
                    PlayerRecord prse = (PlayerRecord) stackIterator.next();
                    if (prse.getRcc() != null) {
                        try {
                            prse.getRcc().unplugRemoteControlDisplay(rcd);
                        } catch (RemoteException e) {
                            Log.e(TAG, "Error disconnecting remote control display to client: ", e);
                        }
                    }
                }
            }
            return;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void remoteControlDisplayUsesBitmapSize(android.media.IRemoteControlDisplay r10, int r11, int r12) {
        /*
        r9 = this;
        r7 = r9.mPRStack;
        monitor-enter(r7);
        r6 = r9.mRcDisplays;	 Catch:{ all -> 0x0069 }
        r2 = r6.iterator();	 Catch:{ all -> 0x0069 }
        r0 = 0;
    L_0x000a:
        r6 = r2.hasNext();	 Catch:{ all -> 0x0069 }
        if (r6 == 0) goto L_0x003e;
    L_0x0010:
        if (r0 != 0) goto L_0x003e;
    L_0x0012:
        r1 = r2.next();	 Catch:{ all -> 0x0069 }
        r1 = (android.media.MediaFocusControl.DisplayInfoForServer) r1;	 Catch:{ all -> 0x0069 }
        r6 = r1.mRcDisplay;	 Catch:{ all -> 0x0069 }
        r6 = r6.asBinder();	 Catch:{ all -> 0x0069 }
        r8 = r10.asBinder();	 Catch:{ all -> 0x0069 }
        r6 = r6.equals(r8);	 Catch:{ all -> 0x0069 }
        if (r6 == 0) goto L_0x000a;
    L_0x002a:
        r6 = r1.mArtworkExpectedWidth;	 Catch:{ all -> 0x0069 }
        if (r6 != r11) goto L_0x0036;
    L_0x0030:
        r6 = r1.mArtworkExpectedHeight;	 Catch:{ all -> 0x0069 }
        if (r6 == r12) goto L_0x000a;
    L_0x0036:
        r1.mArtworkExpectedWidth = r11;	 Catch:{ all -> 0x0069 }
        r1.mArtworkExpectedHeight = r12;	 Catch:{ all -> 0x0069 }
        r0 = 1;
        goto L_0x000a;
    L_0x003e:
        if (r0 == 0) goto L_0x006c;
    L_0x0040:
        r6 = r9.mPRStack;	 Catch:{ all -> 0x0069 }
        r5 = r6.iterator();	 Catch:{ all -> 0x0069 }
    L_0x0046:
        r6 = r5.hasNext();	 Catch:{ all -> 0x0069 }
        if (r6 == 0) goto L_0x006c;
    L_0x004c:
        r4 = r5.next();	 Catch:{ all -> 0x0069 }
        r4 = (android.media.PlayerRecord) r4;	 Catch:{ all -> 0x0069 }
        r6 = r4.getRcc();	 Catch:{ all -> 0x0069 }
        if (r6 == 0) goto L_0x0046;
    L_0x0058:
        r6 = r4.getRcc();	 Catch:{ RemoteException -> 0x0060 }
        r6.setBitmapSizeForDisplay(r10, r11, r12);	 Catch:{ RemoteException -> 0x0060 }
        goto L_0x0046;
    L_0x0060:
        r3 = move-exception;
        r6 = "MediaFocusControl";
        r8 = "Error setting bitmap size for RCD on RCC: ";
        android.util.Log.e(r6, r8, r3);	 Catch:{ all -> 0x0069 }
        goto L_0x0046;
    L_0x0069:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x0069 }
        throw r6;
    L_0x006c:
        monitor-exit(r7);	 Catch:{ all -> 0x0069 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.remoteControlDisplayUsesBitmapSize(android.media.IRemoteControlDisplay, int, int):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void remoteControlDisplayWantsPlaybackPositionSync(android.media.IRemoteControlDisplay r10, boolean r11) {
        /*
        r9 = this;
        r7 = r9.mPRStack;
        monitor-enter(r7);
        r4 = 0;
        r6 = r9.mRcDisplays;	 Catch:{ all -> 0x0059 }
        r1 = r6.iterator();	 Catch:{ all -> 0x0059 }
    L_0x000a:
        r6 = r1.hasNext();	 Catch:{ all -> 0x0059 }
        if (r6 == 0) goto L_0x002c;
    L_0x0010:
        r0 = r1.next();	 Catch:{ all -> 0x0059 }
        r0 = (android.media.MediaFocusControl.DisplayInfoForServer) r0;	 Catch:{ all -> 0x0059 }
        r6 = r0.mRcDisplay;	 Catch:{ all -> 0x0059 }
        r6 = r6.asBinder();	 Catch:{ all -> 0x0059 }
        r8 = r10.asBinder();	 Catch:{ all -> 0x0059 }
        r6 = r6.equals(r8);	 Catch:{ all -> 0x0059 }
        if (r6 == 0) goto L_0x000a;
    L_0x0028:
        r0.mWantsPositionSync = r11;	 Catch:{ all -> 0x0059 }
        r4 = 1;
    L_0x002c:
        if (r4 != 0) goto L_0x0030;
    L_0x002e:
        monitor-exit(r7);	 Catch:{ all -> 0x0059 }
    L_0x002f:
        return;
    L_0x0030:
        r6 = r9.mPRStack;	 Catch:{ all -> 0x0059 }
        r5 = r6.iterator();	 Catch:{ all -> 0x0059 }
    L_0x0036:
        r6 = r5.hasNext();	 Catch:{ all -> 0x0059 }
        if (r6 == 0) goto L_0x005c;
    L_0x003c:
        r3 = r5.next();	 Catch:{ all -> 0x0059 }
        r3 = (android.media.PlayerRecord) r3;	 Catch:{ all -> 0x0059 }
        r6 = r3.getRcc();	 Catch:{ all -> 0x0059 }
        if (r6 == 0) goto L_0x0036;
    L_0x0048:
        r6 = r3.getRcc();	 Catch:{ RemoteException -> 0x0050 }
        r6.setWantsSyncForDisplay(r10, r11);	 Catch:{ RemoteException -> 0x0050 }
        goto L_0x0036;
    L_0x0050:
        r2 = move-exception;
        r6 = "MediaFocusControl";
        r8 = "Error setting position sync flag for RCD on RCC: ";
        android.util.Log.e(r6, r8, r2);	 Catch:{ all -> 0x0059 }
        goto L_0x0036;
    L_0x0059:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x0059 }
        throw r6;
    L_0x005c:
        monitor-exit(r7);	 Catch:{ all -> 0x0059 }
        goto L_0x002f;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.remoteControlDisplayWantsPlaybackPositionSync(android.media.IRemoteControlDisplay, boolean):void");
    }

    public void setRemoteControlClientPlayItem(long uid, int scope) {
        sendMsg(this.mEventHandler, MSG_RCC_SET_PLAY_ITEM, SENDMSG_REPLACE, SENDMSG_REPLACE, scope, new Long(uid), SENDMSG_REPLACE);
    }

    private void onSetRemoteControlClientPlayItem(int scope, Long uid) {
        Log.d(TAG, "onSetRemoteControlClientPlayItem: " + uid);
        synchronized (this.mCurrentRcLock) {
            if (this.mCurrentRcClient != null) {
                try {
                    this.mCurrentRcClient.setPlayItem(scope, uid.longValue());
                } catch (RemoteException e) {
                    Log.e(TAG, "Current valid remote client is dead: " + e);
                    this.mCurrentRcClient = null;
                }
            }
        }
    }

    public void getRemoteControlClientNowPlayingEntries() {
        sendMsg(this.mEventHandler, MSG_RCC_GET_NOW_PLAYING_ENTRIES, SENDMSG_REPLACE, SENDMSG_REPLACE, SENDMSG_REPLACE, Integer.valueOf(SENDMSG_REPLACE), SENDMSG_REPLACE);
    }

    private void onGetRemoteControlClientNowPlayingEntries() {
        Log.d(TAG, "onGetRemoteControlClientNowPlayingEntries: ");
        synchronized (this.mCurrentRcLock) {
            if (this.mCurrentRcClient != null) {
                try {
                    this.mCurrentRcClient.getNowPlayingEntries();
                } catch (RemoteException e) {
                    Log.e(TAG, "Current valid remote client is dead: " + e);
                    this.mCurrentRcClient = null;
                }
            }
        }
    }

    public void setRemoteControlClientBrowsedPlayer() {
        Log.d(TAG, "setRemoteControlClientBrowsedPlayer: ");
        sendMsg(this.mEventHandler, MSG_RCC_SET_BROWSED_PLAYER, SENDMSG_REPLACE, SENDMSG_REPLACE, SENDMSG_REPLACE, Integer.valueOf(SENDMSG_REPLACE), SENDMSG_REPLACE);
    }

    private void onSetRemoteControlClientBrowsedPlayer() {
        Log.d(TAG, "onSetRemoteControlClientBrowsedPlayer: ");
        PlayerRecord prse = (PlayerRecord) this.mPRStack.peek();
        if (prse.getRcc() == null) {
            Log.d(TAG, "can not proceed with setBrowsedPlayer");
            return;
        }
        Log.d(TAG, "proceed with setBrowsedPlayer");
        try {
            Log.d(TAG, "Calling setBrowsedPlayer");
            prse.getRcc().setBrowsedPlayer();
        } catch (RemoteException e) {
            Log.e(TAG, "Current valid remote client is dead: " + e);
        }
    }

    private void onRegisterVolumeObserverForRcc(int rccId, IRemoteVolumeObserver rvo) {
        synchronized (this.mPRStack) {
            try {
                for (int index = this.mPRStack.size() - 1; index >= 0; index--) {
                    PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                    if (prse.getRccId() == rccId) {
                        prse.mRemoteVolumeObs = rvo;
                        break;
                    }
                }
            } catch (ArrayIndexOutOfBoundsException e) {
                Log.e(TAG, "Wrong index accessing media button stack, lock error? ", e);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected boolean checkUpdateRemoteStateIfActive(int r10) {
        /*
        r9 = this;
        r4 = 0;
        r3 = 1;
        r5 = r9.mPRStack;
        monitor-enter(r5);
        r6 = r9.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r6 = r6.size();	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r1 = r6 + -1;
    L_0x000d:
        if (r1 < 0) goto L_0x0057;
    L_0x000f:
        r6 = r9.mPRStack;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r2 = r6.elementAt(r1);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r2 = (android.media.PlayerRecord) r2;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r6 = r2.mPlaybackType;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        if (r6 != r3) goto L_0x0061;
    L_0x001b:
        r6 = r2.mPlaybackState;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r6 = r6.mState;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r6 = isPlaystateActive(r6);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        if (r6 == 0) goto L_0x0061;
    L_0x0025:
        r6 = r2.mPlaybackStream;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        if (r6 != r10) goto L_0x0061;
    L_0x0029:
        r6 = r9.mMainRemote;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        monitor-enter(r6);	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
        r7 = r9.mMainRemote;	 Catch:{ all -> 0x004c }
        r8 = r2.getRccId();	 Catch:{ all -> 0x004c }
        r7.mRccId = r8;	 Catch:{ all -> 0x004c }
        r7 = r9.mMainRemote;	 Catch:{ all -> 0x004c }
        r8 = r2.mPlaybackVolume;	 Catch:{ all -> 0x004c }
        r7.mVolume = r8;	 Catch:{ all -> 0x004c }
        r7 = r9.mMainRemote;	 Catch:{ all -> 0x004c }
        r8 = r2.mPlaybackVolumeMax;	 Catch:{ all -> 0x004c }
        r7.mVolumeMax = r8;	 Catch:{ all -> 0x004c }
        r7 = r9.mMainRemote;	 Catch:{ all -> 0x004c }
        r8 = r2.mPlaybackVolumeHandling;	 Catch:{ all -> 0x004c }
        r7.mVolumeHandling = r8;	 Catch:{ all -> 0x004c }
        r7 = 1;
        r9.mMainRemoteIsActive = r7;	 Catch:{ all -> 0x004c }
        monitor-exit(r6);	 Catch:{ all -> 0x004c }
        monitor-exit(r5);	 Catch:{ all -> 0x0064 }
    L_0x004b:
        return r3;
    L_0x004c:
        r3 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x004c }
        throw r3;	 Catch:{ ArrayIndexOutOfBoundsException -> 0x004f }
    L_0x004f:
        r0 = move-exception;
        r3 = "MediaFocusControl";
        r6 = "Wrong index accessing RC stack, lock error? ";
        android.util.Log.e(r3, r6, r0);	 Catch:{ all -> 0x0064 }
    L_0x0057:
        monitor-exit(r5);	 Catch:{ all -> 0x0064 }
        r5 = r9.mMainRemote;
        monitor-enter(r5);
        r3 = 0;
        r9.mMainRemoteIsActive = r3;	 Catch:{ all -> 0x0067 }
        monitor-exit(r5);	 Catch:{ all -> 0x0067 }
        r3 = r4;
        goto L_0x004b;
    L_0x0061:
        r1 = r1 + -1;
        goto L_0x000d;
    L_0x0064:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0064 }
        throw r3;
    L_0x0067:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0067 }
        throw r3;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.MediaFocusControl.checkUpdateRemoteStateIfActive(int):boolean");
    }

    protected static boolean isPlaystateActive(int playState) {
        switch (playState) {
            case VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS /*3*/:
            case MSG_RCC_NEW_PLAYBACK_INFO /*4*/:
            case MSG_RCC_NEW_VOLUME_OBS /*5*/:
            case MSG_RCC_NEW_PLAYBACK_STATE /*6*/:
            case MSG_RCC_SEEK_REQUEST /*7*/:
            case MSG_RCC_UPDATE_METADATA /*8*/:
                return true;
            default:
                return DEBUG_VOL;
        }
    }

    private void sendVolumeUpdateToRemote(int rccId, int direction) {
        if (direction != 0) {
            IRemoteVolumeObserver rvo = null;
            synchronized (this.mPRStack) {
                try {
                    for (int index = this.mPRStack.size() - 1; index >= 0; index--) {
                        PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                        if (prse.getRccId() == rccId) {
                            rvo = prse.mRemoteVolumeObs;
                            break;
                        }
                    }
                } catch (ArrayIndexOutOfBoundsException e) {
                    Log.e(TAG, "Wrong index accessing media button stack, lock error? ", e);
                }
            }
            if (rvo != null) {
                try {
                    rvo.dispatchRemoteVolumeUpdate(direction, -1);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Error dispatching relative volume update", e2);
                }
            }
        }
    }

    protected int getRemoteStreamMaxVolume() {
        int i;
        synchronized (this.mMainRemote) {
            if (this.mMainRemote.mRccId == -1) {
                i = SENDMSG_REPLACE;
            } else {
                i = this.mMainRemote.mVolumeMax;
            }
        }
        return i;
    }

    protected int getRemoteStreamVolume() {
        int i;
        synchronized (this.mMainRemote) {
            if (this.mMainRemote.mRccId == -1) {
                i = SENDMSG_REPLACE;
            } else {
                i = this.mMainRemote.mVolume;
            }
        }
        return i;
    }

    protected void setRemoteStreamVolume(int vol) {
        synchronized (this.mMainRemote) {
            if (this.mMainRemote.mRccId == -1) {
                return;
            }
            int rccId = this.mMainRemote.mRccId;
            IRemoteVolumeObserver rvo = null;
            synchronized (this.mPRStack) {
                try {
                    for (int index = this.mPRStack.size() - 1; index >= 0; index--) {
                        PlayerRecord prse = (PlayerRecord) this.mPRStack.elementAt(index);
                        if (prse.getRccId() == rccId) {
                            rvo = prse.mRemoteVolumeObs;
                            break;
                        }
                    }
                } catch (ArrayIndexOutOfBoundsException e) {
                    Log.e(TAG, "Wrong index accessing media button stack, lock error? ", e);
                }
            }
            if (rvo != null) {
                try {
                    rvo.dispatchRemoteVolumeUpdate(SENDMSG_REPLACE, vol);
                } catch (RemoteException e2) {
                    Log.e(TAG, "Error dispatching absolute volume update", e2);
                }
            }
        }
    }

    protected void postReevaluateRemote() {
        sendMsg(this.mEventHandler, VOICEBUTTON_ACTION_SIMULATE_KEY_PRESS, VOICEBUTTON_ACTION_START_VOICE_INPUT, SENDMSG_REPLACE, SENDMSG_REPLACE, null, SENDMSG_REPLACE);
    }

    private void onReevaluateRemote() {
    }
}
