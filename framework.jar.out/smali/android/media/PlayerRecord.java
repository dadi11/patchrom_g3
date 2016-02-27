package android.media;

import android.app.PendingIntent;
import android.content.ComponentName;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.RemoteException;
import android.util.Log;
import android.view.WindowManager.LayoutParams;
import android.widget.SpellChecker;
import android.widget.Toast;
import java.io.PrintWriter;
import java.util.NoSuchElementException;

class PlayerRecord implements DeathRecipient {
    private static final boolean DEBUG = false;
    private static final String TAG = "MediaFocusControl";
    public static MediaFocusControl sController;
    private static int sLastRccId;
    private String mCallingPackageName;
    private int mCallingUid;
    private final PendingIntent mMediaIntent;
    public RccPlaybackState mPlaybackState;
    public int mPlaybackStream;
    public int mPlaybackType;
    public int mPlaybackVolume;
    public int mPlaybackVolumeHandling;
    public int mPlaybackVolumeMax;
    private IRemoteControlClient mRcClient;
    private RcClientDeathHandler mRcClientDeathHandler;
    private int mRccId;
    private final ComponentName mReceiverComponent;
    public IRemoteVolumeObserver mRemoteVolumeObs;
    private IBinder mToken;

    private class RcClientDeathHandler implements DeathRecipient {
        private final IBinder mCb;
        private final PendingIntent mMediaIntent;

        RcClientDeathHandler(IBinder cb, PendingIntent pi) {
            this.mCb = cb;
            this.mMediaIntent = pi;
        }

        public void binderDied() {
            Log.w(PlayerRecord.TAG, "  RemoteControlClient died");
            PlayerRecord.sController.registerRemoteControlClient(this.mMediaIntent, null, null);
            PlayerRecord.sController.postReevaluateRemote();
        }

        public IBinder getBinder() {
            return this.mCb;
        }
    }

    protected static class RccPlaybackState {
        public long mPositionMs;
        public float mSpeed;
        public int mState;

        public RccPlaybackState(int state, long positionMs, float speed) {
            this.mState = state;
            this.mPositionMs = positionMs;
            this.mSpeed = speed;
        }

        public void reset() {
            this.mState = 1;
            this.mPositionMs = -1;
            this.mSpeed = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        }

        public String toString() {
            return stateToString() + ", " + posToString() + ", " + this.mSpeed + "X";
        }

        private String posToString() {
            if (this.mPositionMs == -1) {
                return "PLAYBACK_POSITION_INVALID";
            }
            if (this.mPositionMs == RemoteControlClient.PLAYBACK_POSITION_ALWAYS_UNKNOWN) {
                return "PLAYBACK_POSITION_ALWAYS_UNKNOWN";
            }
            return String.valueOf(this.mPositionMs) + "ms";
        }

        private String stateToString() {
            switch (this.mState) {
                case Toast.LENGTH_SHORT /*0*/:
                    return "PLAYSTATE_NONE";
                case Toast.LENGTH_LONG /*1*/:
                    return "PLAYSTATE_STOPPED";
                case Action.MERGE_IGNORE /*2*/:
                    return "PLAYSTATE_PAUSED";
                case SetDrawableParameters.TAG /*3*/:
                    return "PLAYSTATE_PLAYING";
                case ViewGroupAction.TAG /*4*/:
                    return "PLAYSTATE_FAST_FORWARDING";
                case ReflectionActionWithoutParams.TAG /*5*/:
                    return "PLAYSTATE_REWINDING";
                case SetEmptyView.TAG /*6*/:
                    return "PLAYSTATE_SKIPPING_FORWARDS";
                case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                    return "PLAYSTATE_SKIPPING_BACKWARDS";
                case SetPendingIntentTemplate.TAG /*8*/:
                    return "PLAYSTATE_BUFFERING";
                case SetOnClickFillInIntent.TAG /*9*/:
                    return "PLAYSTATE_ERROR";
                default:
                    return "[invalid playstate]";
            }
        }
    }

    protected static class RemotePlaybackState {
        int mRccId;
        int mVolume;
        int mVolumeHandling;
        int mVolumeMax;

        protected RemotePlaybackState(int id, int vol, int volMax) {
            this.mRccId = id;
            this.mVolume = vol;
            this.mVolumeMax = volMax;
            this.mVolumeHandling = 1;
        }
    }

    static {
        sLastRccId = 0;
    }

    void dump(PrintWriter pw, boolean registrationInfo) {
        if (registrationInfo) {
            pw.println("  pi: " + this.mMediaIntent + " -- pack: " + this.mCallingPackageName + "  -- ercvr: " + this.mReceiverComponent + "  -- client: " + this.mRcClient + "  -- uid: " + this.mCallingUid + "  -- type: " + this.mPlaybackType + "  state: " + this.mPlaybackState);
        } else {
            pw.println("  uid: " + this.mCallingUid + "  -- id: " + this.mRccId + "  -- type: " + this.mPlaybackType + "  -- state: " + this.mPlaybackState + "  -- vol handling: " + this.mPlaybackVolumeHandling + "  -- vol: " + this.mPlaybackVolume + "  -- volMax: " + this.mPlaybackVolumeMax + "  -- volObs: " + this.mRemoteVolumeObs);
        }
    }

    protected static void setMediaFocusControl(MediaFocusControl mfc) {
        sController = mfc;
    }

    protected PlayerRecord(PendingIntent mediaIntent, ComponentName eventReceiver, IBinder token) {
        this.mRccId = -1;
        this.mMediaIntent = mediaIntent;
        this.mReceiverComponent = eventReceiver;
        this.mToken = token;
        this.mCallingUid = -1;
        this.mRcClient = null;
        int i = sLastRccId + 1;
        sLastRccId = i;
        this.mRccId = i;
        this.mPlaybackState = new RccPlaybackState(1, -1, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
        resetPlaybackInfo();
        if (this.mToken != null) {
            try {
                this.mToken.linkToDeath(this, 0);
            } catch (RemoteException e) {
                sController.unregisterMediaButtonIntentAsync(this.mMediaIntent);
            }
        }
    }

    protected int getRccId() {
        return this.mRccId;
    }

    protected IRemoteControlClient getRcc() {
        return this.mRcClient;
    }

    protected ComponentName getMediaButtonReceiver() {
        return this.mReceiverComponent;
    }

    protected PendingIntent getMediaButtonIntent() {
        return this.mMediaIntent;
    }

    protected boolean hasMatchingMediaButtonIntent(PendingIntent pi) {
        if (this.mToken != null) {
            return this.mMediaIntent.equals(pi);
        }
        if (this.mReceiverComponent != null) {
            return this.mReceiverComponent.equals(pi.getIntent().getComponent());
        }
        return DEBUG;
    }

    protected boolean isPlaybackActive() {
        return MediaFocusControl.isPlaystateActive(this.mPlaybackState.mState);
    }

    protected void resetControllerInfoForRcc(IRemoteControlClient rcClient, String callingPackageName, int uid) {
        if (this.mRcClientDeathHandler != null) {
            unlinkToRcClientDeath();
        }
        this.mRcClient = rcClient;
        this.mCallingPackageName = callingPackageName;
        this.mCallingUid = uid;
        if (rcClient == null) {
            resetPlaybackInfo();
            return;
        }
        IBinder b = this.mRcClient.asBinder();
        RcClientDeathHandler rcdh = new RcClientDeathHandler(b, this.mMediaIntent);
        try {
            b.linkToDeath(rcdh, 0);
        } catch (RemoteException e) {
            Log.w(TAG, "registerRemoteControlClient() has a dead client " + b);
            this.mRcClient = null;
        }
        this.mRcClientDeathHandler = rcdh;
    }

    protected void resetControllerInfoForNoRcc() {
        unlinkToRcClientDeath();
        this.mRcClient = null;
        this.mCallingPackageName = null;
    }

    public void resetPlaybackInfo() {
        this.mPlaybackType = 0;
        this.mPlaybackVolume = 15;
        this.mPlaybackVolumeMax = 15;
        this.mPlaybackVolumeHandling = 1;
        this.mPlaybackStream = 3;
        this.mPlaybackState.reset();
        this.mRemoteVolumeObs = null;
    }

    public void unlinkToRcClientDeath() {
        if (this.mRcClientDeathHandler != null && this.mRcClientDeathHandler.mCb != null) {
            try {
                this.mRcClientDeathHandler.mCb.unlinkToDeath(this.mRcClientDeathHandler, 0);
                this.mRcClientDeathHandler = null;
            } catch (NoSuchElementException e) {
                Log.e(TAG, "Error in unlinkToRcClientDeath()", e);
            }
        }
    }

    public void destroy() {
        unlinkToRcClientDeath();
        if (this.mToken != null) {
            this.mToken.unlinkToDeath(this, 0);
            this.mToken = null;
        }
    }

    public void binderDied() {
        sController.unregisterMediaButtonIntentAsync(this.mMediaIntent);
    }

    protected void finalize() throws Throwable {
        destroy();
        super.finalize();
    }
}
