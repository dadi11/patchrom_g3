package android.media.browse;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.ParceledListSlice;
import android.media.MediaDescription;
import android.media.session.MediaSession.Token;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.service.media.IMediaBrowserService;
import android.service.media.IMediaBrowserService.Stub;
import android.service.media.IMediaBrowserServiceCallbacks;
import android.service.media.MediaBrowserService;
import android.text.TextUtils;
import android.util.ArrayMap;
import android.util.Log;
import java.lang.ref.WeakReference;
import java.util.Collections;
import java.util.List;

public final class MediaBrowser {
    private static final int CONNECT_STATE_CONNECTED = 2;
    private static final int CONNECT_STATE_CONNECTING = 1;
    private static final int CONNECT_STATE_DISCONNECTED = 0;
    private static final int CONNECT_STATE_SUSPENDED = 3;
    private static final boolean DBG = false;
    private static final String TAG = "MediaBrowser";
    private final ConnectionCallback mCallback;
    private final Context mContext;
    private Bundle mExtras;
    private final Handler mHandler;
    private Token mMediaSessionToken;
    private final Bundle mRootHints;
    private String mRootId;
    private IMediaBrowserService mServiceBinder;
    private IMediaBrowserServiceCallbacks mServiceCallbacks;
    private final ComponentName mServiceComponent;
    private MediaServiceConnection mServiceConnection;
    private int mState;
    private final ArrayMap<String, Subscription> mSubscriptions;

    /* renamed from: android.media.browse.MediaBrowser.1 */
    class C04151 implements Runnable {
        final /* synthetic */ ServiceConnection val$thisConnection;

        C04151(ServiceConnection serviceConnection) {
            this.val$thisConnection = serviceConnection;
        }

        public void run() {
            if (this.val$thisConnection == MediaBrowser.this.mServiceConnection) {
                MediaBrowser.this.forceCloseConnection();
                MediaBrowser.this.mCallback.onConnectionFailed();
            }
        }
    }

    /* renamed from: android.media.browse.MediaBrowser.2 */
    class C04162 implements Runnable {
        final /* synthetic */ IMediaBrowserServiceCallbacks val$callback;
        final /* synthetic */ Bundle val$extra;
        final /* synthetic */ String val$root;
        final /* synthetic */ Token val$session;

        C04162(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks, String str, Token token, Bundle bundle) {
            this.val$callback = iMediaBrowserServiceCallbacks;
            this.val$root = str;
            this.val$session = token;
            this.val$extra = bundle;
        }

        public void run() {
            if (!MediaBrowser.this.isCurrent(this.val$callback, "onConnect")) {
                return;
            }
            if (MediaBrowser.this.mState != MediaBrowser.CONNECT_STATE_CONNECTING) {
                Log.w(MediaBrowser.TAG, "onConnect from service while mState=" + MediaBrowser.getStateLabel(MediaBrowser.this.mState) + "... ignoring");
                return;
            }
            MediaBrowser.this.mRootId = this.val$root;
            MediaBrowser.this.mMediaSessionToken = this.val$session;
            MediaBrowser.this.mExtras = this.val$extra;
            MediaBrowser.this.mState = MediaBrowser.CONNECT_STATE_CONNECTED;
            MediaBrowser.this.mCallback.onConnected();
            for (String id : MediaBrowser.this.mSubscriptions.keySet()) {
                try {
                    MediaBrowser.this.mServiceBinder.addSubscription(id, MediaBrowser.this.mServiceCallbacks);
                } catch (RemoteException e) {
                    Log.d(MediaBrowser.TAG, "addSubscription failed with RemoteException parentId=" + id);
                }
            }
        }
    }

    /* renamed from: android.media.browse.MediaBrowser.3 */
    class C04173 implements Runnable {
        final /* synthetic */ IMediaBrowserServiceCallbacks val$callback;

        C04173(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks) {
            this.val$callback = iMediaBrowserServiceCallbacks;
        }

        public void run() {
            Log.e(MediaBrowser.TAG, "onConnectFailed for " + MediaBrowser.this.mServiceComponent);
            if (!MediaBrowser.this.isCurrent(this.val$callback, "onConnectFailed")) {
                return;
            }
            if (MediaBrowser.this.mState != MediaBrowser.CONNECT_STATE_CONNECTING) {
                Log.w(MediaBrowser.TAG, "onConnect from service while mState=" + MediaBrowser.getStateLabel(MediaBrowser.this.mState) + "... ignoring");
                return;
            }
            MediaBrowser.this.forceCloseConnection();
            MediaBrowser.this.mCallback.onConnectionFailed();
        }
    }

    /* renamed from: android.media.browse.MediaBrowser.4 */
    class C04184 implements Runnable {
        final /* synthetic */ IMediaBrowserServiceCallbacks val$callback;
        final /* synthetic */ ParceledListSlice val$list;
        final /* synthetic */ String val$parentId;

        C04184(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks, ParceledListSlice parceledListSlice, String str) {
            this.val$callback = iMediaBrowserServiceCallbacks;
            this.val$list = parceledListSlice;
            this.val$parentId = str;
        }

        public void run() {
            if (MediaBrowser.this.isCurrent(this.val$callback, "onLoadChildren")) {
                List<MediaItem> data = this.val$list.getList();
                if (data == null) {
                    data = Collections.emptyList();
                }
                Subscription subscription = (Subscription) MediaBrowser.this.mSubscriptions.get(this.val$parentId);
                if (subscription != null) {
                    subscription.callback.onChildrenLoaded(this.val$parentId, data);
                }
            }
        }
    }

    public static class ConnectionCallback {
        public void onConnected() {
        }

        public void onConnectionSuspended() {
        }

        public void onConnectionFailed() {
        }
    }

    public static class MediaItem implements Parcelable {
        public static final Creator<MediaItem> CREATOR;
        public static final int FLAG_BROWSABLE = 1;
        public static final int FLAG_PLAYABLE = 2;
        private final MediaDescription mDescription;
        private final int mFlags;

        /* renamed from: android.media.browse.MediaBrowser.MediaItem.1 */
        static class C04191 implements Creator<MediaItem> {
            C04191() {
            }

            public MediaItem createFromParcel(Parcel in) {
                return new MediaItem(null);
            }

            public MediaItem[] newArray(int size) {
                return new MediaItem[size];
            }
        }

        public MediaItem(MediaDescription description, int flags) {
            if (description == null) {
                throw new IllegalArgumentException("description cannot be null");
            } else if (TextUtils.isEmpty(description.getMediaId())) {
                throw new IllegalArgumentException("description must have a non-empty media id");
            } else {
                this.mFlags = flags;
                this.mDescription = description;
            }
        }

        private MediaItem(Parcel in) {
            this.mFlags = in.readInt();
            this.mDescription = (MediaDescription) MediaDescription.CREATOR.createFromParcel(in);
        }

        public int describeContents() {
            return MediaBrowser.CONNECT_STATE_DISCONNECTED;
        }

        public void writeToParcel(Parcel out, int flags) {
            out.writeInt(this.mFlags);
            this.mDescription.writeToParcel(out, flags);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder("MediaItem{");
            sb.append("mFlags=").append(this.mFlags);
            sb.append(", mDescription=").append(this.mDescription);
            sb.append('}');
            return sb.toString();
        }

        static {
            CREATOR = new C04191();
        }

        public int getFlags() {
            return this.mFlags;
        }

        public boolean isBrowsable() {
            return (this.mFlags & FLAG_BROWSABLE) != 0 ? true : MediaBrowser.DBG;
        }

        public boolean isPlayable() {
            return (this.mFlags & FLAG_PLAYABLE) != 0 ? true : MediaBrowser.DBG;
        }

        public MediaDescription getDescription() {
            return this.mDescription;
        }

        public String getMediaId() {
            return this.mDescription.getMediaId();
        }
    }

    private class MediaServiceConnection implements ServiceConnection {
        private MediaServiceConnection() {
        }

        public void onServiceConnected(ComponentName name, IBinder binder) {
            if (isCurrent("onServiceConnected")) {
                MediaBrowser.this.mServiceBinder = Stub.asInterface(binder);
                MediaBrowser.this.mServiceCallbacks = MediaBrowser.this.getNewServiceCallbacks();
                MediaBrowser.this.mState = MediaBrowser.CONNECT_STATE_CONNECTING;
                try {
                    MediaBrowser.this.mServiceBinder.connect(MediaBrowser.this.mContext.getPackageName(), MediaBrowser.this.mRootHints, MediaBrowser.this.mServiceCallbacks);
                } catch (RemoteException e) {
                    Log.w(MediaBrowser.TAG, "RemoteException during connect for " + MediaBrowser.this.mServiceComponent);
                }
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            if (isCurrent("onServiceDisconnected")) {
                MediaBrowser.this.mServiceBinder = null;
                MediaBrowser.this.mServiceCallbacks = null;
                MediaBrowser.this.mState = MediaBrowser.CONNECT_STATE_SUSPENDED;
                MediaBrowser.this.mCallback.onConnectionSuspended();
            }
        }

        private boolean isCurrent(String funcName) {
            if (MediaBrowser.this.mServiceConnection == this) {
                return true;
            }
            if (MediaBrowser.this.mState != 0) {
                Log.i(MediaBrowser.TAG, funcName + " for " + MediaBrowser.this.mServiceComponent + " with mServiceConnection=" + MediaBrowser.this.mServiceConnection + " this=" + this);
            }
            return MediaBrowser.DBG;
        }
    }

    private static class ServiceCallbacks extends IMediaBrowserServiceCallbacks.Stub {
        private WeakReference<MediaBrowser> mMediaBrowser;

        public ServiceCallbacks(MediaBrowser mediaBrowser) {
            this.mMediaBrowser = new WeakReference(mediaBrowser);
        }

        public void onConnect(String root, Token session, Bundle extras) {
            MediaBrowser mediaBrowser = (MediaBrowser) this.mMediaBrowser.get();
            if (mediaBrowser != null) {
                mediaBrowser.onServiceConnected(this, root, session, extras);
            }
        }

        public void onConnectFailed() {
            MediaBrowser mediaBrowser = (MediaBrowser) this.mMediaBrowser.get();
            if (mediaBrowser != null) {
                mediaBrowser.onConnectionFailed(this);
            }
        }

        public void onLoadChildren(String parentId, ParceledListSlice list) {
            MediaBrowser mediaBrowser = (MediaBrowser) this.mMediaBrowser.get();
            if (mediaBrowser != null) {
                mediaBrowser.onLoadChildren(this, parentId, list);
            }
        }
    }

    private static class Subscription {
        SubscriptionCallback callback;
        final String id;

        Subscription(String id) {
            this.id = id;
        }
    }

    public static abstract class SubscriptionCallback {
        public void onChildrenLoaded(String parentId, List<MediaItem> list) {
        }

        public void onError(String id) {
        }
    }

    public MediaBrowser(Context context, ComponentName serviceComponent, ConnectionCallback callback, Bundle rootHints) {
        this.mHandler = new Handler();
        this.mSubscriptions = new ArrayMap();
        this.mState = CONNECT_STATE_DISCONNECTED;
        if (context == null) {
            throw new IllegalArgumentException("context must not be null");
        } else if (serviceComponent == null) {
            throw new IllegalArgumentException("service component must not be null");
        } else if (callback == null) {
            throw new IllegalArgumentException("connection callback must not be null");
        } else {
            this.mContext = context;
            this.mServiceComponent = serviceComponent;
            this.mCallback = callback;
            this.mRootHints = rootHints;
        }
    }

    public void connect() {
        if (this.mState != 0) {
            throw new IllegalStateException("connect() called while not disconnected (state=" + getStateLabel(this.mState) + ")");
        } else if (this.mServiceBinder != null) {
            throw new RuntimeException("mServiceBinder should be null. Instead it is " + this.mServiceBinder);
        } else if (this.mServiceCallbacks != null) {
            throw new RuntimeException("mServiceCallbacks should be null. Instead it is " + this.mServiceCallbacks);
        } else {
            this.mState = CONNECT_STATE_CONNECTING;
            Intent intent = new Intent(MediaBrowserService.SERVICE_INTERFACE);
            intent.setComponent(this.mServiceComponent);
            ServiceConnection thisConnection = new MediaServiceConnection();
            this.mServiceConnection = thisConnection;
            boolean bound = DBG;
            try {
                bound = this.mContext.bindService(intent, this.mServiceConnection, CONNECT_STATE_CONNECTING);
            } catch (Exception e) {
                Log.e(TAG, "Failed binding to service " + this.mServiceComponent);
            }
            if (!bound) {
                this.mHandler.post(new C04151(thisConnection));
            }
        }
    }

    public void disconnect() {
        if (this.mServiceCallbacks != null) {
            try {
                this.mServiceBinder.disconnect(this.mServiceCallbacks);
            } catch (RemoteException e) {
                Log.w(TAG, "RemoteException during connect for " + this.mServiceComponent);
            }
        }
        forceCloseConnection();
    }

    private void forceCloseConnection() {
        if (this.mServiceConnection != null) {
            this.mContext.unbindService(this.mServiceConnection);
        }
        this.mState = CONNECT_STATE_DISCONNECTED;
        this.mServiceConnection = null;
        this.mServiceBinder = null;
        this.mServiceCallbacks = null;
        this.mRootId = null;
        this.mMediaSessionToken = null;
    }

    public boolean isConnected() {
        return this.mState == CONNECT_STATE_CONNECTED ? true : DBG;
    }

    public ComponentName getServiceComponent() {
        if (isConnected()) {
            return this.mServiceComponent;
        }
        throw new IllegalStateException("getServiceComponent() called while not connected (state=" + this.mState + ")");
    }

    public String getRoot() {
        if (isConnected()) {
            return this.mRootId;
        }
        throw new IllegalStateException("getSessionToken() called while not connected (state=" + getStateLabel(this.mState) + ")");
    }

    public Bundle getExtras() {
        if (isConnected()) {
            return this.mExtras;
        }
        throw new IllegalStateException("getExtras() called while not connected (state=" + getStateLabel(this.mState) + ")");
    }

    public Token getSessionToken() {
        if (isConnected()) {
            return this.mMediaSessionToken;
        }
        throw new IllegalStateException("getSessionToken() called while not connected (state=" + this.mState + ")");
    }

    public void subscribe(String parentId, SubscriptionCallback callback) {
        if (parentId == null) {
            throw new IllegalArgumentException("parentId is null");
        } else if (callback == null) {
            throw new IllegalArgumentException("callback is null");
        } else {
            Subscription sub = (Subscription) this.mSubscriptions.get(parentId);
            boolean newSubscription = sub == null ? true : DBG;
            if (newSubscription) {
                sub = new Subscription(parentId);
                this.mSubscriptions.put(parentId, sub);
            }
            sub.callback = callback;
            if (this.mState == CONNECT_STATE_CONNECTED && newSubscription) {
                try {
                    this.mServiceBinder.addSubscription(parentId, this.mServiceCallbacks);
                } catch (RemoteException e) {
                    Log.d(TAG, "addSubscription failed with RemoteException parentId=" + parentId);
                }
            }
        }
    }

    public void unsubscribe(String parentId) {
        if (parentId == null) {
            throw new IllegalArgumentException("parentId is null");
        }
        Subscription sub = (Subscription) this.mSubscriptions.remove(parentId);
        if (this.mState == CONNECT_STATE_CONNECTED && sub != null) {
            try {
                this.mServiceBinder.removeSubscription(parentId, this.mServiceCallbacks);
            } catch (RemoteException e) {
                Log.d(TAG, "removeSubscription failed with RemoteException parentId=" + parentId);
            }
        }
    }

    private static String getStateLabel(int state) {
        switch (state) {
            case CONNECT_STATE_DISCONNECTED /*0*/:
                return "CONNECT_STATE_DISCONNECTED";
            case CONNECT_STATE_CONNECTING /*1*/:
                return "CONNECT_STATE_CONNECTING";
            case CONNECT_STATE_CONNECTED /*2*/:
                return "CONNECT_STATE_CONNECTED";
            case CONNECT_STATE_SUSPENDED /*3*/:
                return "CONNECT_STATE_SUSPENDED";
            default:
                return "UNKNOWN/" + state;
        }
    }

    private final void onServiceConnected(IMediaBrowserServiceCallbacks callback, String root, Token session, Bundle extra) {
        this.mHandler.post(new C04162(callback, root, session, extra));
    }

    private final void onConnectionFailed(IMediaBrowserServiceCallbacks callback) {
        this.mHandler.post(new C04173(callback));
    }

    private final void onLoadChildren(IMediaBrowserServiceCallbacks callback, String parentId, ParceledListSlice list) {
        this.mHandler.post(new C04184(callback, list, parentId));
    }

    private boolean isCurrent(IMediaBrowserServiceCallbacks callback, String funcName) {
        if (this.mServiceCallbacks == callback) {
            return true;
        }
        if (this.mState != 0) {
            Log.i(TAG, funcName + " for " + this.mServiceComponent + " with mServiceConnection=" + this.mServiceCallbacks + " this=" + this);
        }
        return DBG;
    }

    private ServiceCallbacks getNewServiceCallbacks() {
        return new ServiceCallbacks(this);
    }

    void dump() {
        Log.d(TAG, "MediaBrowser...");
        Log.d(TAG, "  mServiceComponent=" + this.mServiceComponent);
        Log.d(TAG, "  mCallback=" + this.mCallback);
        Log.d(TAG, "  mRootHints=" + this.mRootHints);
        Log.d(TAG, "  mState=" + getStateLabel(this.mState));
        Log.d(TAG, "  mServiceConnection=" + this.mServiceConnection);
        Log.d(TAG, "  mServiceBinder=" + this.mServiceBinder);
        Log.d(TAG, "  mServiceCallbacks=" + this.mServiceCallbacks);
        Log.d(TAG, "  mRootId=" + this.mRootId);
        Log.d(TAG, "  mMediaSessionToken=" + this.mMediaSessionToken);
    }
}
