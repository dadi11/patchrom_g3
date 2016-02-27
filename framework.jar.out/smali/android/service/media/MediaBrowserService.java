package android.service.media;

import android.app.Service;
import android.content.Intent;
import android.content.pm.ParceledListSlice;
import android.media.browse.MediaBrowser.MediaItem;
import android.media.session.MediaSession.Token;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import android.service.media.IMediaBrowserService.Stub;
import android.util.ArrayMap;
import android.util.Log;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;

public abstract class MediaBrowserService extends Service {
    private static final boolean DBG = false;
    public static final String SERVICE_INTERFACE = "android.media.browse.MediaBrowserService";
    private static final String TAG = "MediaBrowserService";
    private ServiceBinder mBinder;
    private final ArrayMap<IBinder, ConnectionRecord> mConnections;
    private final Handler mHandler;
    Token mSession;

    /* renamed from: android.service.media.MediaBrowserService.1 */
    class C06771 implements Runnable {
        final /* synthetic */ Token val$token;

        C06771(Token token) {
            this.val$token = token;
        }

        public void run() {
            for (IBinder key : MediaBrowserService.this.mConnections.keySet()) {
                ConnectionRecord connection = (ConnectionRecord) MediaBrowserService.this.mConnections.get(key);
                try {
                    connection.callbacks.onConnect(connection.root.getRootId(), this.val$token, connection.root.getExtras());
                } catch (RemoteException e) {
                    Log.w(MediaBrowserService.TAG, "Connection for " + connection.pkg + " is no longer valid.");
                    MediaBrowserService.this.mConnections.remove(key);
                }
            }
        }
    }

    /* renamed from: android.service.media.MediaBrowserService.2 */
    class C06782 implements Runnable {
        final /* synthetic */ String val$parentId;

        C06782(String str) {
            this.val$parentId = str;
        }

        public void run() {
            for (IBinder binder : MediaBrowserService.this.mConnections.keySet()) {
                ConnectionRecord connection = (ConnectionRecord) MediaBrowserService.this.mConnections.get(binder);
                if (connection.subscriptions.contains(this.val$parentId)) {
                    MediaBrowserService.this.performLoadChildren(this.val$parentId, connection);
                }
            }
        }
    }

    public class Result<T> {
        private Object mDebug;
        private boolean mDetachCalled;
        private boolean mSendResultCalled;

        Result(Object debug) {
            this.mDebug = debug;
        }

        public void sendResult(T result) {
            if (this.mSendResultCalled) {
                throw new IllegalStateException("sendResult() called twice for: " + this.mDebug);
            }
            this.mSendResultCalled = true;
            onResultSent(result);
        }

        public void detach() {
            if (this.mDetachCalled) {
                throw new IllegalStateException("detach() called when detach() had already been called for: " + this.mDebug);
            } else if (this.mSendResultCalled) {
                throw new IllegalStateException("detach() called when sendResult() had already been called for: " + this.mDebug);
            } else {
                this.mDetachCalled = true;
            }
        }

        boolean isDone() {
            return (this.mDetachCalled || this.mSendResultCalled) ? true : MediaBrowserService.DBG;
        }

        void onResultSent(T t) {
        }
    }

    /* renamed from: android.service.media.MediaBrowserService.3 */
    class C06793 extends Result<List<MediaItem>> {
        final /* synthetic */ ConnectionRecord val$connection;
        final /* synthetic */ String val$parentId;

        C06793(Object x0, String str, ConnectionRecord connectionRecord) {
            this.val$parentId = str;
            this.val$connection = connectionRecord;
            super(x0);
        }

        void onResultSent(List<MediaItem> list) {
            if (list == null) {
                throw new IllegalStateException("onLoadChildren sent null list for id " + this.val$parentId);
            } else if (MediaBrowserService.this.mConnections.get(this.val$connection.callbacks.asBinder()) == this.val$connection) {
                try {
                    this.val$connection.callbacks.onLoadChildren(this.val$parentId, new ParceledListSlice(list));
                } catch (RemoteException e) {
                    Log.w(MediaBrowserService.TAG, "Calling onLoadChildren() failed for id=" + this.val$parentId + " package=" + this.val$connection.pkg);
                }
            }
        }
    }

    public static final class BrowserRoot {
        private final Bundle mExtras;
        private final String mRootId;

        public BrowserRoot(String rootId, Bundle extras) {
            if (rootId == null) {
                throw new IllegalArgumentException("The root id in BrowserRoot cannot be null. Use null for BrowserRoot instead.");
            }
            this.mRootId = rootId;
            this.mExtras = extras;
        }

        public String getRootId() {
            return this.mRootId;
        }

        public Bundle getExtras() {
            return this.mExtras;
        }
    }

    private class ConnectionRecord {
        IMediaBrowserServiceCallbacks callbacks;
        String pkg;
        BrowserRoot root;
        Bundle rootHints;
        HashSet<String> subscriptions;

        private ConnectionRecord() {
            this.subscriptions = new HashSet();
        }
    }

    private class ServiceBinder extends Stub {

        /* renamed from: android.service.media.MediaBrowserService.ServiceBinder.1 */
        class C06801 implements Runnable {
            final /* synthetic */ IMediaBrowserServiceCallbacks val$callbacks;
            final /* synthetic */ String val$pkg;
            final /* synthetic */ Bundle val$rootHints;
            final /* synthetic */ int val$uid;

            C06801(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks, String str, Bundle bundle, int i) {
                this.val$callbacks = iMediaBrowserServiceCallbacks;
                this.val$pkg = str;
                this.val$rootHints = bundle;
                this.val$uid = i;
            }

            public void run() {
                IBinder b = this.val$callbacks.asBinder();
                MediaBrowserService.this.mConnections.remove(b);
                ConnectionRecord connection = new ConnectionRecord(null);
                connection.pkg = this.val$pkg;
                connection.rootHints = this.val$rootHints;
                connection.callbacks = this.val$callbacks;
                connection.root = MediaBrowserService.this.onGetRoot(this.val$pkg, this.val$uid, this.val$rootHints);
                if (connection.root == null) {
                    Log.i(MediaBrowserService.TAG, "No root for client " + this.val$pkg + " from service " + getClass().getName());
                    try {
                        this.val$callbacks.onConnectFailed();
                        return;
                    } catch (RemoteException e) {
                        Log.w(MediaBrowserService.TAG, "Calling onConnectFailed() failed. Ignoring. pkg=" + this.val$pkg);
                        return;
                    }
                }
                try {
                    MediaBrowserService.this.mConnections.put(b, connection);
                    if (MediaBrowserService.this.mSession != null) {
                        this.val$callbacks.onConnect(connection.root.getRootId(), MediaBrowserService.this.mSession, connection.root.getExtras());
                    }
                } catch (RemoteException e2) {
                    Log.w(MediaBrowserService.TAG, "Calling onConnect() failed. Dropping client. pkg=" + this.val$pkg);
                    MediaBrowserService.this.mConnections.remove(b);
                }
            }
        }

        /* renamed from: android.service.media.MediaBrowserService.ServiceBinder.2 */
        class C06812 implements Runnable {
            final /* synthetic */ IMediaBrowserServiceCallbacks val$callbacks;

            C06812(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks) {
                this.val$callbacks = iMediaBrowserServiceCallbacks;
            }

            public void run() {
                if (((ConnectionRecord) MediaBrowserService.this.mConnections.remove(this.val$callbacks.asBinder())) == null) {
                }
            }
        }

        /* renamed from: android.service.media.MediaBrowserService.ServiceBinder.3 */
        class C06823 implements Runnable {
            final /* synthetic */ IMediaBrowserServiceCallbacks val$callbacks;
            final /* synthetic */ String val$id;

            C06823(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks, String str) {
                this.val$callbacks = iMediaBrowserServiceCallbacks;
                this.val$id = str;
            }

            public void run() {
                ConnectionRecord connection = (ConnectionRecord) MediaBrowserService.this.mConnections.get(this.val$callbacks.asBinder());
                if (connection == null) {
                    Log.w(MediaBrowserService.TAG, "addSubscription for callback that isn't registered id=" + this.val$id);
                } else {
                    MediaBrowserService.this.addSubscription(this.val$id, connection);
                }
            }
        }

        /* renamed from: android.service.media.MediaBrowserService.ServiceBinder.4 */
        class C06834 implements Runnable {
            final /* synthetic */ IMediaBrowserServiceCallbacks val$callbacks;
            final /* synthetic */ String val$id;

            C06834(IMediaBrowserServiceCallbacks iMediaBrowserServiceCallbacks, String str) {
                this.val$callbacks = iMediaBrowserServiceCallbacks;
                this.val$id = str;
            }

            public void run() {
                ConnectionRecord connection = (ConnectionRecord) MediaBrowserService.this.mConnections.get(this.val$callbacks.asBinder());
                if (connection == null) {
                    Log.w(MediaBrowserService.TAG, "removeSubscription for callback that isn't registered id=" + this.val$id);
                } else if (!connection.subscriptions.remove(this.val$id)) {
                    Log.w(MediaBrowserService.TAG, "removeSubscription called for " + this.val$id + " which is not subscribed");
                }
            }
        }

        private ServiceBinder() {
        }

        public void connect(String pkg, Bundle rootHints, IMediaBrowserServiceCallbacks callbacks) {
            int uid = Binder.getCallingUid();
            if (MediaBrowserService.this.isValidPackage(pkg, uid)) {
                MediaBrowserService.this.mHandler.post(new C06801(callbacks, pkg, rootHints, uid));
                return;
            }
            throw new IllegalArgumentException("Package/uid mismatch: uid=" + uid + " package=" + pkg);
        }

        public void disconnect(IMediaBrowserServiceCallbacks callbacks) {
            MediaBrowserService.this.mHandler.post(new C06812(callbacks));
        }

        public void addSubscription(String id, IMediaBrowserServiceCallbacks callbacks) {
            MediaBrowserService.this.mHandler.post(new C06823(callbacks, id));
        }

        public void removeSubscription(String id, IMediaBrowserServiceCallbacks callbacks) {
            MediaBrowserService.this.mHandler.post(new C06834(callbacks, id));
        }
    }

    public abstract BrowserRoot onGetRoot(String str, int i, Bundle bundle);

    public abstract void onLoadChildren(String str, Result<List<MediaItem>> result);

    public MediaBrowserService() {
        this.mConnections = new ArrayMap();
        this.mHandler = new Handler();
    }

    public void onCreate() {
        super.onCreate();
        this.mBinder = new ServiceBinder();
    }

    public IBinder onBind(Intent intent) {
        if (SERVICE_INTERFACE.equals(intent.getAction())) {
            return this.mBinder;
        }
        return null;
    }

    public void dump(FileDescriptor fd, PrintWriter writer, String[] args) {
    }

    public void setSessionToken(Token token) {
        if (token == null) {
            throw new IllegalArgumentException("Session token may not be null.");
        } else if (this.mSession != null) {
            throw new IllegalStateException("The session token has already been set.");
        } else {
            this.mSession = token;
            this.mHandler.post(new C06771(token));
        }
    }

    public Token getSessionToken() {
        return this.mSession;
    }

    public void notifyChildrenChanged(String parentId) {
        if (parentId == null) {
            throw new IllegalArgumentException("parentId cannot be null in notifyChildrenChanged");
        }
        this.mHandler.post(new C06782(parentId));
    }

    private boolean isValidPackage(String pkg, int uid) {
        if (pkg == null) {
            return DBG;
        }
        for (String equals : getPackageManager().getPackagesForUid(uid)) {
            if (equals.equals(pkg)) {
                return true;
            }
        }
        return DBG;
    }

    private void addSubscription(String id, ConnectionRecord connection) {
        if (connection.subscriptions.add(id)) {
            performLoadChildren(id, connection);
        }
    }

    private void performLoadChildren(String parentId, ConnectionRecord connection) {
        Result<List<MediaItem>> result = new C06793(parentId, parentId, connection);
        onLoadChildren(parentId, result);
        if (!result.isDone()) {
            throw new IllegalStateException("onLoadChildren must call detach() or sendResult() before returning for package=" + connection.pkg + " id=" + parentId);
        }
    }
}
