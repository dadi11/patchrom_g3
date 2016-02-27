package android.net.http;

import android.content.Context;
import android.os.SystemClock;
import android.view.accessibility.AccessibilityNodeInfo;
import java.io.IOException;
import java.util.LinkedList;
import org.apache.http.HttpConnection;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpVersion;
import org.apache.http.ProtocolVersion;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;

abstract class Connection {
    private static final int DONE = 3;
    private static final int DRAIN = 2;
    private static final String HTTP_CONNECTION = "http.connection";
    private static final int MAX_PIPE = 3;
    private static final int MIN_PIPE = 2;
    private static final int READ = 1;
    private static final int RETRY_REQUEST_LIMIT = 2;
    private static final int SEND = 0;
    static final int SOCKET_TIMEOUT = 60000;
    private static int STATE_CANCEL_REQUESTED;
    private static int STATE_NORMAL;
    private static final String[] states;
    private int mActive;
    private byte[] mBuf;
    private boolean mCanPersist;
    protected SslCertificate mCertificate;
    Context mContext;
    HttpHost mHost;
    protected AndroidHttpClientConnection mHttpClientConnection;
    private HttpContext mHttpContext;
    RequestFeeder mRequestFeeder;

    abstract void closeConnection();

    abstract String getScheme();

    abstract AndroidHttpClientConnection openConnection(Request request) throws IOException;

    static {
        states = new String[]{"SEND", "READ", "DRAIN", "DONE"};
        STATE_NORMAL = SEND;
        STATE_CANCEL_REQUESTED = READ;
    }

    protected Connection(Context context, HttpHost host, RequestFeeder requestFeeder) {
        this.mHttpClientConnection = null;
        this.mCertificate = null;
        this.mActive = STATE_NORMAL;
        this.mContext = context;
        this.mHost = host;
        this.mRequestFeeder = requestFeeder;
        this.mCanPersist = false;
        this.mHttpContext = new BasicHttpContext(null);
    }

    HttpHost getHost() {
        return this.mHost;
    }

    static Connection getConnection(Context context, HttpHost host, HttpHost proxy, RequestFeeder requestFeeder) {
        if (host.getSchemeName().equals("http")) {
            return new HttpConnection(context, host, requestFeeder);
        }
        return new HttpsConnection(context, host, proxy, requestFeeder);
    }

    SslCertificate getCertificate() {
        return this.mCertificate;
    }

    void cancel() {
        this.mActive = STATE_CANCEL_REQUESTED;
        closeConnection();
    }

    void processRequests(Request firstRequest) {
        int error = SEND;
        Exception exception = null;
        LinkedList<Request> pipe = new LinkedList();
        int minPipe = RETRY_REQUEST_LIMIT;
        int maxPipe = MAX_PIPE;
        int state = SEND;
        while (state != MAX_PIPE) {
            if (this.mActive == STATE_CANCEL_REQUESTED) {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                }
                this.mActive = STATE_NORMAL;
            }
            Request req;
            switch (state) {
                case SEND /*0*/:
                    if (pipe.size() != maxPipe) {
                        if (firstRequest == null) {
                            req = this.mRequestFeeder.getRequest(this.mHost);
                        } else {
                            req = firstRequest;
                            firstRequest = null;
                        }
                        if (req != null) {
                            req.setConnection(this);
                            if (!req.mCancelled) {
                                if ((this.mHttpClientConnection != null && this.mHttpClientConnection.isOpen()) || openHttpConnection(req)) {
                                    req.mEventHandler.certificate(this.mCertificate);
                                    try {
                                        req.sendRequest(this.mHttpClientConnection);
                                    } catch (Exception e2) {
                                        exception = e2;
                                        error = -1;
                                    } catch (Exception e22) {
                                        exception = e22;
                                        error = -7;
                                    } catch (Exception e222) {
                                        exception = e222;
                                        error = -7;
                                    }
                                    if (exception == null) {
                                        pipe.addLast(req);
                                        if (!this.mCanPersist) {
                                            state = READ;
                                            break;
                                        }
                                        break;
                                    }
                                    if (httpFailure(req, error, exception) && !req.mCancelled) {
                                        pipe.addLast(req);
                                    }
                                    exception = null;
                                    if (clearPipe(pipe)) {
                                        state = MAX_PIPE;
                                    } else {
                                        state = SEND;
                                    }
                                    maxPipe = READ;
                                    minPipe = READ;
                                    break;
                                }
                                state = MAX_PIPE;
                                break;
                            }
                            req.complete();
                            break;
                        }
                        state = RETRY_REQUEST_LIMIT;
                        break;
                    }
                    state = READ;
                    break;
                    break;
                case READ /*1*/:
                case RETRY_REQUEST_LIMIT /*2*/:
                    boolean empty;
                    if (this.mRequestFeeder.haveRequest(this.mHost)) {
                        empty = false;
                    } else {
                        empty = true;
                    }
                    int pipeSize = pipe.size();
                    if (state == RETRY_REQUEST_LIMIT || pipeSize >= minPipe || empty || !this.mCanPersist) {
                        if (pipeSize != 0) {
                            req = (Request) pipe.removeFirst();
                            try {
                                req.readResponse(this.mHttpClientConnection);
                            } catch (Exception e2222) {
                                exception = e2222;
                                error = -7;
                            } catch (Exception e22222) {
                                exception = e22222;
                                error = -7;
                            } catch (Exception e222222) {
                                exception = e222222;
                                error = -7;
                            }
                            if (exception != null) {
                                if (httpFailure(req, error, exception) && !req.mCancelled) {
                                    req.reset();
                                    pipe.addFirst(req);
                                }
                                exception = null;
                                this.mCanPersist = false;
                            }
                            if (!this.mCanPersist) {
                                closeConnection();
                                this.mHttpContext.removeAttribute(HTTP_CONNECTION);
                                clearPipe(pipe);
                                maxPipe = READ;
                                minPipe = READ;
                                state = SEND;
                                break;
                            }
                            break;
                        }
                        if (empty) {
                            state = MAX_PIPE;
                        } else {
                            state = SEND;
                        }
                        break;
                    }
                    state = SEND;
                    break;
                default:
                    break;
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean clearPipe(java.util.LinkedList<android.net.http.Request> r6) {
        /*
        r5 = this;
        r0 = 1;
        r3 = r5.mRequestFeeder;
        monitor-enter(r3);
    L_0x0004:
        r2 = r6.isEmpty();	 Catch:{ all -> 0x0028 }
        if (r2 != 0) goto L_0x0017;
    L_0x000a:
        r1 = r6.removeLast();	 Catch:{ all -> 0x0028 }
        r1 = (android.net.http.Request) r1;	 Catch:{ all -> 0x0028 }
        r2 = r5.mRequestFeeder;	 Catch:{ all -> 0x0028 }
        r2.requeueRequest(r1);	 Catch:{ all -> 0x0028 }
        r0 = 0;
        goto L_0x0004;
    L_0x0017:
        if (r0 == 0) goto L_0x0024;
    L_0x0019:
        r2 = r5.mRequestFeeder;	 Catch:{ all -> 0x0028 }
        r4 = r5.mHost;	 Catch:{ all -> 0x0028 }
        r2 = r2.haveRequest(r4);	 Catch:{ all -> 0x0028 }
        if (r2 != 0) goto L_0x0026;
    L_0x0023:
        r0 = 1;
    L_0x0024:
        monitor-exit(r3);	 Catch:{ all -> 0x0028 }
        return r0;
    L_0x0026:
        r0 = 0;
        goto L_0x0024;
    L_0x0028:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0028 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.http.Connection.clearPipe(java.util.LinkedList):boolean");
    }

    private boolean openHttpConnection(Request req) {
        boolean z = true;
        long now = SystemClock.uptimeMillis();
        int error = SEND;
        Exception exception = null;
        try {
            this.mCertificate = null;
            this.mHttpClientConnection = openConnection(req);
            if (this.mHttpClientConnection != null) {
                this.mHttpClientConnection.setSocketTimeout(SOCKET_TIMEOUT);
                this.mHttpContext.setAttribute(HTTP_CONNECTION, this.mHttpClientConnection);
                if (error == 0) {
                    return true;
                }
                if (req.mFailCount < RETRY_REQUEST_LIMIT) {
                    this.mRequestFeeder.requeueRequest(req);
                    req.mFailCount += READ;
                } else {
                    httpFailure(req, error, exception);
                }
                if (error != 0) {
                    z = false;
                }
                return z;
            }
            req.mFailCount = RETRY_REQUEST_LIMIT;
            return false;
        } catch (Exception e) {
            error = -2;
            exception = e;
        } catch (Exception e2) {
            error = -6;
            req.mFailCount = RETRY_REQUEST_LIMIT;
            exception = e2;
        } catch (SSLConnectionClosedByUserException e3) {
            req.mFailCount = RETRY_REQUEST_LIMIT;
            return false;
        } catch (Exception e22) {
            req.mFailCount = RETRY_REQUEST_LIMIT;
            error = -11;
            exception = e22;
        } catch (Exception e222) {
            error = -6;
            exception = e222;
        }
    }

    private boolean httpFailure(Request req, int errorId, Exception e) {
        boolean ret = true;
        int i = req.mFailCount + READ;
        req.mFailCount = i;
        if (i >= RETRY_REQUEST_LIMIT) {
            String error;
            ret = false;
            if (errorId < 0) {
                error = ErrorStrings.getString(errorId, this.mContext);
            } else {
                Throwable cause = e.getCause();
                error = cause != null ? cause.toString() : e.getMessage();
            }
            req.mEventHandler.error(errorId, error);
            req.complete();
        }
        closeConnection();
        this.mHttpContext.removeAttribute(HTTP_CONNECTION);
        return ret;
    }

    HttpContext getHttpContext() {
        return this.mHttpContext;
    }

    private boolean keepAlive(HttpEntity entity, ProtocolVersion ver, int connType, HttpContext context) {
        boolean z = true;
        HttpConnection conn = (HttpConnection) context.getAttribute(HTTP_CONNECTION);
        if (conn != null && !conn.isOpen()) {
            return false;
        }
        if ((entity != null && entity.getContentLength() < 0 && (!entity.isChunked() || ver.lessEquals(HttpVersion.HTTP_1_0))) || connType == READ) {
            return false;
        }
        if (connType == RETRY_REQUEST_LIMIT) {
            return true;
        }
        if (ver.lessEquals(HttpVersion.HTTP_1_0)) {
            z = false;
        }
        return z;
    }

    void setCanPersist(HttpEntity entity, ProtocolVersion ver, int connType) {
        this.mCanPersist = keepAlive(entity, ver, connType, this.mHttpContext);
    }

    void setCanPersist(boolean canPersist) {
        this.mCanPersist = canPersist;
    }

    boolean getCanPersist() {
        return this.mCanPersist;
    }

    public synchronized String toString() {
        return this.mHost.toString();
    }

    byte[] getBuf() {
        if (this.mBuf == null) {
            this.mBuf = new byte[AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD];
        }
        return this.mBuf;
    }
}
