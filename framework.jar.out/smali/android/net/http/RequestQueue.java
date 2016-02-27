package android.net.http;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Proxy;
import android.net.WebAddress;
import android.util.Log;
import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.http.HttpHost;

public class RequestQueue implements RequestFeeder {
    private static final int CONNECTION_COUNT = 4;
    private final ActivePool mActivePool;
    private final ConnectivityManager mConnectivityManager;
    private final Context mContext;
    private final LinkedHashMap<HttpHost, LinkedList<Request>> mPending;
    private BroadcastReceiver mProxyChangeReceiver;
    private HttpHost mProxyHost;

    /* renamed from: android.net.http.RequestQueue.1 */
    class C05171 extends BroadcastReceiver {
        C05171() {
        }

        public void onReceive(Context ctx, Intent intent) {
            RequestQueue.this.setProxyConfig();
        }
    }

    interface ConnectionManager {
        Connection getConnection(Context context, HttpHost httpHost);

        HttpHost getProxyHost();

        boolean recycleConnection(Connection connection);
    }

    class ActivePool implements ConnectionManager {
        private int mConnectionCount;
        IdleCache mIdleCache;
        ConnectionThread[] mThreads;
        private int mTotalConnection;
        private int mTotalRequest;

        ActivePool(int connectionCount) {
            this.mIdleCache = new IdleCache();
            this.mConnectionCount = connectionCount;
            this.mThreads = new ConnectionThread[this.mConnectionCount];
            for (int i = 0; i < this.mConnectionCount; i++) {
                this.mThreads[i] = new ConnectionThread(RequestQueue.this.mContext, i, this, RequestQueue.this);
            }
        }

        void startup() {
            for (int i = 0; i < this.mConnectionCount; i++) {
                this.mThreads[i].start();
            }
        }

        void shutdown() {
            for (int i = 0; i < this.mConnectionCount; i++) {
                this.mThreads[i].requestStop();
            }
        }

        void startConnectionThread() {
            synchronized (RequestQueue.this) {
                RequestQueue.this.notify();
            }
        }

        public void startTiming() {
            for (int i = 0; i < this.mConnectionCount; i++) {
                ConnectionThread rt = this.mThreads[i];
                rt.mCurrentThreadTime = -1;
                rt.mTotalThreadTime = 0;
            }
            this.mTotalRequest = 0;
            this.mTotalConnection = 0;
        }

        public void stopTiming() {
            int totalTime = 0;
            for (int i = 0; i < this.mConnectionCount; i++) {
                ConnectionThread rt = this.mThreads[i];
                if (rt.mCurrentThreadTime != -1) {
                    totalTime = (int) (((long) totalTime) + rt.mTotalThreadTime);
                }
                rt.mCurrentThreadTime = 0;
            }
            Log.d("Http", "Http thread used " + totalTime + " ms " + " for " + this.mTotalRequest + " requests and " + this.mTotalConnection + " new connections");
        }

        void logState() {
            StringBuilder dump = new StringBuilder();
            for (int i = 0; i < this.mConnectionCount; i++) {
                dump.append(this.mThreads[i] + "\n");
            }
            HttpLog.m1v(dump.toString());
        }

        public HttpHost getProxyHost() {
            return RequestQueue.this.mProxyHost;
        }

        void disablePersistence() {
            for (int i = 0; i < this.mConnectionCount; i++) {
                Connection connection = this.mThreads[i].mConnection;
                if (connection != null) {
                    connection.setCanPersist(false);
                }
            }
            this.mIdleCache.clear();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        android.net.http.ConnectionThread getThread(org.apache.http.HttpHost r6) {
            /*
            r5 = this;
            r4 = android.net.http.RequestQueue.this;
            monitor-enter(r4);
            r2 = 0;
        L_0x0004:
            r3 = r5.mThreads;	 Catch:{ all -> 0x0021 }
            r3 = r3.length;	 Catch:{ all -> 0x0021 }
            if (r2 >= r3) goto L_0x001e;
        L_0x0009:
            r3 = r5.mThreads;	 Catch:{ all -> 0x0021 }
            r1 = r3[r2];	 Catch:{ all -> 0x0021 }
            r0 = r1.mConnection;	 Catch:{ all -> 0x0021 }
            if (r0 == 0) goto L_0x001b;
        L_0x0011:
            r3 = r0.mHost;	 Catch:{ all -> 0x0021 }
            r3 = r3.equals(r6);	 Catch:{ all -> 0x0021 }
            if (r3 == 0) goto L_0x001b;
        L_0x0019:
            monitor-exit(r4);	 Catch:{ all -> 0x0021 }
        L_0x001a:
            return r1;
        L_0x001b:
            r2 = r2 + 1;
            goto L_0x0004;
        L_0x001e:
            monitor-exit(r4);	 Catch:{ all -> 0x0021 }
            r1 = 0;
            goto L_0x001a;
        L_0x0021:
            r3 = move-exception;
            monitor-exit(r4);	 Catch:{ all -> 0x0021 }
            throw r3;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.http.RequestQueue.ActivePool.getThread(org.apache.http.HttpHost):android.net.http.ConnectionThread");
        }

        public Connection getConnection(Context context, HttpHost host) {
            host = RequestQueue.this.determineHost(host);
            Connection con = this.mIdleCache.getConnection(host);
            if (con != null) {
                return con;
            }
            this.mTotalConnection++;
            return Connection.getConnection(RequestQueue.this.mContext, host, RequestQueue.this.mProxyHost, RequestQueue.this);
        }

        public boolean recycleConnection(Connection connection) {
            return this.mIdleCache.cacheConnection(connection.getHost(), connection);
        }
    }

    private static class SyncFeeder implements RequestFeeder {
        private Request mRequest;

        SyncFeeder() {
        }

        public Request getRequest() {
            Request r = this.mRequest;
            this.mRequest = null;
            return r;
        }

        public Request getRequest(HttpHost host) {
            return getRequest();
        }

        public boolean haveRequest(HttpHost host) {
            return this.mRequest != null;
        }

        public void requeueRequest(Request r) {
            this.mRequest = r;
        }
    }

    public RequestQueue(Context context) {
        this(context, CONNECTION_COUNT);
    }

    public RequestQueue(Context context, int connectionCount) {
        this.mProxyHost = null;
        this.mContext = context;
        this.mPending = new LinkedHashMap(32);
        this.mActivePool = new ActivePool(connectionCount);
        this.mActivePool.startup();
        this.mConnectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    }

    public synchronized void enablePlatformNotifications() {
        if (this.mProxyChangeReceiver == null) {
            this.mProxyChangeReceiver = new C05171();
            this.mContext.registerReceiver(this.mProxyChangeReceiver, new IntentFilter(Proxy.PROXY_CHANGE_ACTION));
        }
        setProxyConfig();
    }

    public synchronized void disablePlatformNotifications() {
        if (this.mProxyChangeReceiver != null) {
            this.mContext.unregisterReceiver(this.mProxyChangeReceiver);
            this.mProxyChangeReceiver = null;
        }
    }

    private synchronized void setProxyConfig() {
        NetworkInfo info = this.mConnectivityManager.getActiveNetworkInfo();
        if (info == null || info.getType() != 1) {
            String host = Proxy.getHost(this.mContext);
            if (host == null) {
                this.mProxyHost = null;
            } else {
                this.mActivePool.disablePersistence();
                this.mProxyHost = new HttpHost(host, Proxy.getPort(this.mContext), "http");
            }
        } else {
            this.mProxyHost = null;
        }
    }

    public HttpHost getProxyHost() {
        return this.mProxyHost;
    }

    public RequestHandle queueRequest(String url, String method, Map<String, String> headers, EventHandler eventHandler, InputStream bodyProvider, int bodyLength) {
        return queueRequest(url, new WebAddress(url), method, headers, eventHandler, bodyProvider, bodyLength);
    }

    public RequestHandle queueRequest(String url, WebAddress uri, String method, Map<String, String> headers, EventHandler eventHandler, InputStream bodyProvider, int bodyLength) {
        if (eventHandler == null) {
            eventHandler = new LoggingEventHandler();
        }
        Request req = new Request(method, new HttpHost(uri.getHost(), uri.getPort(), uri.getScheme()), this.mProxyHost, uri.getPath(), bodyProvider, bodyLength, eventHandler, headers);
        queueRequest(req, false);
        this.mActivePool.mTotalRequest = this.mActivePool.mTotalRequest + 1;
        this.mActivePool.startConnectionThread();
        return new RequestHandle(this, url, uri, method, headers, bodyProvider, bodyLength, req);
    }

    public RequestHandle queueSynchronousRequest(String url, WebAddress uri, String method, Map<String, String> headers, EventHandler eventHandler, InputStream bodyProvider, int bodyLength) {
        HttpHost host = new HttpHost(uri.getHost(), uri.getPort(), uri.getScheme());
        return new RequestHandle(this, url, uri, method, headers, bodyProvider, bodyLength, new Request(method, host, this.mProxyHost, uri.getPath(), bodyProvider, bodyLength, eventHandler, headers), Connection.getConnection(this.mContext, determineHost(host), this.mProxyHost, new SyncFeeder()));
    }

    private HttpHost determineHost(HttpHost host) {
        return (this.mProxyHost == null || "https".equals(host.getSchemeName())) ? host : this.mProxyHost;
    }

    synchronized boolean requestsPending() {
        return !this.mPending.isEmpty();
    }

    synchronized void dump() {
        HttpLog.m1v("dump()");
        StringBuilder dump = new StringBuilder();
        if (!this.mPending.isEmpty()) {
            int count;
            Iterator<Entry<HttpHost, LinkedList<Request>>> iter = this.mPending.entrySet().iterator();
            int count2 = 0;
            while (iter.hasNext()) {
                Entry<HttpHost, LinkedList<Request>> entry = (Entry) iter.next();
                count = count2 + 1;
                StringBuilder line = new StringBuilder(TtmlUtils.TAG_P + count2 + " " + ((HttpHost) entry.getKey()).getHostName() + " ");
                ListIterator reqIter = ((LinkedList) entry.getValue()).listIterator(0);
                while (iter.hasNext()) {
                    line.append(((Request) iter.next()) + " ");
                }
                dump.append(line);
                dump.append("\n");
                count2 = count;
            }
            count = count2;
        }
        HttpLog.m1v(dump.toString());
    }

    public synchronized Request getRequest() {
        Request ret;
        ret = null;
        if (!this.mPending.isEmpty()) {
            ret = removeFirst(this.mPending);
        }
        return ret;
    }

    public synchronized Request getRequest(HttpHost host) {
        Request ret;
        ret = null;
        if (this.mPending.containsKey(host)) {
            LinkedList<Request> reqList = (LinkedList) this.mPending.get(host);
            ret = (Request) reqList.removeFirst();
            if (reqList.isEmpty()) {
                this.mPending.remove(host);
            }
        }
        return ret;
    }

    public synchronized boolean haveRequest(HttpHost host) {
        return this.mPending.containsKey(host);
    }

    public void requeueRequest(Request request) {
        queueRequest(request, true);
    }

    public void shutdown() {
        this.mActivePool.shutdown();
    }

    protected synchronized void queueRequest(Request request, boolean head) {
        LinkedList<Request> reqList;
        HttpHost host = request.mProxyHost == null ? request.mHost : request.mProxyHost;
        if (this.mPending.containsKey(host)) {
            reqList = (LinkedList) this.mPending.get(host);
        } else {
            reqList = new LinkedList();
            this.mPending.put(host, reqList);
        }
        if (head) {
            reqList.addFirst(request);
        } else {
            reqList.add(request);
        }
    }

    public void startTiming() {
        this.mActivePool.startTiming();
    }

    public void stopTiming() {
        this.mActivePool.stopTiming();
    }

    private Request removeFirst(LinkedHashMap<HttpHost, LinkedList<Request>> requestQueue) {
        Request ret = null;
        Iterator<Entry<HttpHost, LinkedList<Request>>> iter = requestQueue.entrySet().iterator();
        if (iter.hasNext()) {
            Entry<HttpHost, LinkedList<Request>> entry = (Entry) iter.next();
            LinkedList<Request> reqList = (LinkedList) entry.getValue();
            ret = (Request) reqList.removeFirst();
            if (reqList.isEmpty()) {
                requestQueue.remove(entry.getKey());
            }
        }
        return ret;
    }
}
