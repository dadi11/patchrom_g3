package android.net.http;

import android.media.MediaFile;
import android.view.KeyEvent;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.message.BasicHttpEntityEnclosingRequest;
import org.apache.http.message.BasicHttpRequest;
import org.apache.http.protocol.RequestContent;

class Request {
    private static final String ACCEPT_ENCODING_HEADER = "Accept-Encoding";
    private static final String CONTENT_LENGTH_HEADER = "content-length";
    private static final String HOST_HEADER = "Host";
    private static RequestContent requestContentProcessor;
    private int mBodyLength;
    private InputStream mBodyProvider;
    volatile boolean mCancelled;
    private final Object mClientResource;
    private Connection mConnection;
    EventHandler mEventHandler;
    int mFailCount;
    HttpHost mHost;
    BasicHttpRequest mHttpRequest;
    private boolean mLoadingPaused;
    String mPath;
    HttpHost mProxyHost;
    private int mReceivedBytes;

    static {
        requestContentProcessor = new RequestContent();
    }

    Request(String method, HttpHost host, HttpHost proxyHost, String path, InputStream bodyProvider, int bodyLength, EventHandler eventHandler, Map<String, String> headers) {
        this.mCancelled = false;
        this.mFailCount = 0;
        this.mReceivedBytes = 0;
        this.mClientResource = new Object();
        this.mLoadingPaused = false;
        this.mEventHandler = eventHandler;
        this.mHost = host;
        this.mProxyHost = proxyHost;
        this.mPath = path;
        this.mBodyProvider = bodyProvider;
        this.mBodyLength = bodyLength;
        if (bodyProvider != null || "POST".equalsIgnoreCase(method)) {
            this.mHttpRequest = new BasicHttpEntityEnclosingRequest(method, getUri());
            if (bodyProvider != null) {
                setBodyProvider(bodyProvider, bodyLength);
            }
        } else {
            this.mHttpRequest = new BasicHttpRequest(method, getUri());
        }
        addHeader(HOST_HEADER, getHostPort());
        addHeader(ACCEPT_ENCODING_HEADER, "gzip");
        addHeaders(headers);
    }

    synchronized void setLoadingPaused(boolean pause) {
        this.mLoadingPaused = pause;
        if (!this.mLoadingPaused) {
            notify();
        }
    }

    void setConnection(Connection connection) {
        this.mConnection = connection;
    }

    EventHandler getEventHandler() {
        return this.mEventHandler;
    }

    void addHeader(String name, String value) {
        String damage;
        if (name == null) {
            damage = "Null http header name";
            HttpLog.m0e(damage);
            throw new NullPointerException(damage);
        } else if (value == null || value.length() == 0) {
            damage = "Null or empty value for header \"" + name + "\"";
            HttpLog.m0e(damage);
            throw new RuntimeException(damage);
        } else {
            this.mHttpRequest.addHeader(name, value);
        }
    }

    void addHeaders(Map<String, String> headers) {
        if (headers != null) {
            for (Entry<String, String> entry : headers.entrySet()) {
                addHeader((String) entry.getKey(), (String) entry.getValue());
            }
        }
    }

    void sendRequest(AndroidHttpClientConnection httpClientConnection) throws HttpException, IOException {
        if (!this.mCancelled) {
            requestContentProcessor.process(this.mHttpRequest, this.mConnection.getHttpContext());
            httpClientConnection.sendRequestHeader(this.mHttpRequest);
            if (this.mHttpRequest instanceof HttpEntityEnclosingRequest) {
                httpClientConnection.sendRequestEntity((HttpEntityEnclosingRequest) this.mHttpRequest);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void readResponse(android.net.http.AndroidHttpClientConnection r26) throws java.io.IOException, org.apache.http.ParseException {
        /*
        r25 = this;
        r0 = r25;
        r0 = r0.mCancelled;
        r21 = r0;
        if (r21 == 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r18 = 0;
        r10 = 0;
        r26.flush();
        r17 = 0;
        r11 = new android.net.http.Headers;
        r11.<init>();
    L_0x0016:
        r0 = r26;
        r18 = r0.parseResponseHeader(r11);
        r17 = r18.getStatusCode();
        r21 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
        r0 = r17;
        r1 = r21;
        if (r0 < r1) goto L_0x0016;
    L_0x0028:
        r20 = r18.getProtocolVersion();
        r0 = r25;
        r0 = r0.mEventHandler;
        r21 = r0;
        r22 = r20.getMajor();
        r23 = r20.getMinor();
        r24 = r18.getReasonPhrase();
        r0 = r21;
        r1 = r22;
        r2 = r23;
        r3 = r17;
        r4 = r24;
        r0.status(r1, r2, r3, r4);
        r0 = r25;
        r0 = r0.mEventHandler;
        r21 = r0;
        r0 = r21;
        r0.headers(r11);
        r9 = 0;
        r0 = r25;
        r0 = r0.mHttpRequest;
        r21 = r0;
        r0 = r21;
        r1 = r17;
        r10 = canResponseHaveBody(r0, r1);
        if (r10 == 0) goto L_0x006d;
    L_0x0067:
        r0 = r26;
        r9 = r0.receiveResponseEntity(r11);
    L_0x006d:
        r21 = "bytes";
        r22 = r11.getAcceptRanges();
        r19 = r21.equalsIgnoreCase(r22);
        if (r9 == 0) goto L_0x00f0;
    L_0x0079:
        r12 = r9.getContent();
        r6 = r9.getContentEncoding();
        r15 = 0;
        r5 = 0;
        r7 = 0;
        if (r6 == 0) goto L_0x0115;
    L_0x0086:
        r21 = r6.getValue();	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r22 = "gzip";
        r21 = r21.equals(r22);	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        if (r21 == 0) goto L_0x0115;
    L_0x0092:
        r16 = new java.util.zip.GZIPInputStream;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r0 = r16;
        r0.<init>(r12);	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r15 = r16;
    L_0x009b:
        r0 = r25;
        r0 = r0.mConnection;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = r0;
        r5 = r21.getBuf();	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r13 = 0;
        r0 = r5.length;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = r0;
        r14 = r21 / 2;
    L_0x00ab:
        r21 = -1;
        r0 = r21;
        if (r13 == r0) goto L_0x0150;
    L_0x00b1:
        monitor-enter(r25);	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
    L_0x00b2:
        r0 = r25;
        r0 = r0.mLoadingPaused;	 Catch:{ all -> 0x00da }
        r21 = r0;
        if (r21 == 0) goto L_0x0117;
    L_0x00ba:
        r25.wait();	 Catch:{ InterruptedException -> 0x00be }
        goto L_0x00b2;
    L_0x00be:
        r8 = move-exception;
        r21 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00da }
        r21.<init>();	 Catch:{ all -> 0x00da }
        r22 = "Interrupted exception whilst network thread paused at WebCore's request. ";
        r21 = r21.append(r22);	 Catch:{ all -> 0x00da }
        r22 = r8.getMessage();	 Catch:{ all -> 0x00da }
        r21 = r21.append(r22);	 Catch:{ all -> 0x00da }
        r21 = r21.toString();	 Catch:{ all -> 0x00da }
        android.net.http.HttpLog.m0e(r21);	 Catch:{ all -> 0x00da }
        goto L_0x00b2;
    L_0x00da:
        r21 = move-exception;
        monitor-exit(r25);	 Catch:{ all -> 0x00da }
        throw r21;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
    L_0x00dd:
        r8 = move-exception;
        if (r7 <= 0) goto L_0x00eb;
    L_0x00e0:
        r0 = r25;
        r0 = r0.mEventHandler;	 Catch:{ all -> 0x0177 }
        r21 = r0;
        r0 = r21;
        r0.data(r5, r7);	 Catch:{ all -> 0x0177 }
    L_0x00eb:
        if (r15 == 0) goto L_0x00f0;
    L_0x00ed:
        r15.close();
    L_0x00f0:
        r0 = r25;
        r0 = r0.mConnection;
        r21 = r0;
        r22 = r18.getProtocolVersion();
        r23 = r11.getConnectionType();
        r0 = r21;
        r1 = r22;
        r2 = r23;
        r0.setCanPersist(r9, r1, r2);
        r0 = r25;
        r0 = r0.mEventHandler;
        r21 = r0;
        r21.endData();
        r25.complete();
        goto L_0x0008;
    L_0x0115:
        r15 = r12;
        goto L_0x009b;
    L_0x0117:
        monitor-exit(r25);	 Catch:{ all -> 0x00da }
        r0 = r5.length;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = r0;
        r21 = r21 - r7;
        r0 = r21;
        r13 = r15.read(r5, r7, r0);	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = -1;
        r0 = r21;
        if (r13 == r0) goto L_0x013a;
    L_0x0129:
        r7 = r7 + r13;
        if (r19 == 0) goto L_0x013a;
    L_0x012c:
        r0 = r25;
        r0 = r0.mReceivedBytes;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = r0;
        r21 = r21 + r13;
        r0 = r21;
        r1 = r25;
        r1.mReceivedBytes = r0;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
    L_0x013a:
        r21 = -1;
        r0 = r21;
        if (r13 == r0) goto L_0x0142;
    L_0x0140:
        if (r7 < r14) goto L_0x00ab;
    L_0x0142:
        r0 = r25;
        r0 = r0.mEventHandler;	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r21 = r0;
        r0 = r21;
        r0.data(r5, r7);	 Catch:{ EOFException -> 0x00dd, IOException -> 0x0156 }
        r7 = 0;
        goto L_0x00ab;
    L_0x0150:
        if (r15 == 0) goto L_0x00f0;
    L_0x0152:
        r15.close();
        goto L_0x00f0;
    L_0x0156:
        r8 = move-exception;
        r21 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
        r0 = r17;
        r1 = r21;
        if (r0 == r1) goto L_0x0167;
    L_0x015f:
        r21 = 206; // 0xce float:2.89E-43 double:1.02E-321;
        r0 = r17;
        r1 = r21;
        if (r0 != r1) goto L_0x017e;
    L_0x0167:
        if (r19 == 0) goto L_0x0176;
    L_0x0169:
        if (r7 <= 0) goto L_0x0176;
    L_0x016b:
        r0 = r25;
        r0 = r0.mEventHandler;	 Catch:{ all -> 0x0177 }
        r21 = r0;
        r0 = r21;
        r0.data(r5, r7);	 Catch:{ all -> 0x0177 }
    L_0x0176:
        throw r8;	 Catch:{ all -> 0x0177 }
    L_0x0177:
        r21 = move-exception;
        if (r15 == 0) goto L_0x017d;
    L_0x017a:
        r15.close();
    L_0x017d:
        throw r21;
    L_0x017e:
        if (r15 == 0) goto L_0x00f0;
    L_0x0180:
        r15.close();
        goto L_0x00f0;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.http.Request.readResponse(android.net.http.AndroidHttpClientConnection):void");
    }

    synchronized void cancel() {
        this.mLoadingPaused = false;
        notify();
        this.mCancelled = true;
        if (this.mConnection != null) {
            this.mConnection.cancel();
        }
    }

    String getHostPort() {
        String myScheme = this.mHost.getSchemeName();
        int myPort = this.mHost.getPort();
        if ((myPort == 80 || !myScheme.equals("http")) && (myPort == 443 || !myScheme.equals("https"))) {
            return this.mHost.getHostName();
        }
        return this.mHost.toHostString();
    }

    String getUri() {
        if (this.mProxyHost == null || this.mHost.getSchemeName().equals("https")) {
            return this.mPath;
        }
        return this.mHost.getSchemeName() + "://" + getHostPort() + this.mPath;
    }

    public String toString() {
        return this.mPath;
    }

    void reset() {
        this.mHttpRequest.removeHeaders(CONTENT_LENGTH_HEADER);
        if (this.mBodyProvider != null) {
            try {
                this.mBodyProvider.reset();
            } catch (IOException e) {
            }
            setBodyProvider(this.mBodyProvider, this.mBodyLength);
        }
        if (this.mReceivedBytes > 0) {
            this.mFailCount = 0;
            HttpLog.m1v("*** Request.reset() to range:" + this.mReceivedBytes);
            this.mHttpRequest.setHeader("Range", "bytes=" + this.mReceivedBytes + "-");
        }
    }

    void waitUntilComplete() {
        synchronized (this.mClientResource) {
            try {
                this.mClientResource.wait();
            } catch (InterruptedException e) {
            }
        }
    }

    void complete() {
        synchronized (this.mClientResource) {
            this.mClientResource.notifyAll();
        }
    }

    private static boolean canResponseHaveBody(HttpRequest request, int status) {
        if ("HEAD".equalsIgnoreCase(request.getRequestLine().getMethod()) || status < KeyEvent.KEYCODE_BUTTON_13 || status == KeyEvent.KEYCODE_LANGUAGE_SWITCH || status == MediaFile.FILE_TYPE_PCM) {
            return false;
        }
        return true;
    }

    private void setBodyProvider(InputStream bodyProvider, int bodyLength) {
        if (bodyProvider.markSupported()) {
            bodyProvider.mark(ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED);
            ((BasicHttpEntityEnclosingRequest) this.mHttpRequest).setEntity(new InputStreamEntity(bodyProvider, (long) bodyLength));
            return;
        }
        throw new IllegalArgumentException("bodyProvider must support mark()");
    }

    public void handleSslErrorResponse(boolean proceed) {
        HttpsConnection connection = (HttpsConnection) this.mConnection;
        if (connection != null) {
            connection.restartConnection(proceed);
        }
    }

    void error(int errorId, int resourceId) {
        this.mEventHandler.error(errorId, this.mConnection.mContext.getText(resourceId).toString());
    }
}
