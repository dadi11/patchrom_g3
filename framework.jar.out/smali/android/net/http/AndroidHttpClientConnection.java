package android.net.http;

import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.SocketException;
import org.apache.http.HttpConnection;
import org.apache.http.HttpConnectionMetrics;
import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpException;
import org.apache.http.HttpInetConnection;
import org.apache.http.HttpRequest;
import org.apache.http.entity.BasicHttpEntity;
import org.apache.http.impl.HttpConnectionMetricsImpl;
import org.apache.http.impl.entity.EntitySerializer;
import org.apache.http.impl.entity.StrictContentLengthStrategy;
import org.apache.http.impl.io.ChunkedInputStream;
import org.apache.http.impl.io.ContentLengthInputStream;
import org.apache.http.impl.io.HttpRequestWriter;
import org.apache.http.impl.io.IdentityInputStream;
import org.apache.http.impl.io.SocketInputBuffer;
import org.apache.http.impl.io.SocketOutputBuffer;
import org.apache.http.io.HttpMessageWriter;
import org.apache.http.io.SessionInputBuffer;
import org.apache.http.io.SessionOutputBuffer;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;

public class AndroidHttpClientConnection implements HttpInetConnection, HttpConnection {
    private final EntitySerializer entityserializer;
    private SessionInputBuffer inbuffer;
    private int maxHeaderCount;
    private int maxLineLength;
    private HttpConnectionMetricsImpl metrics;
    private volatile boolean open;
    private SessionOutputBuffer outbuffer;
    private HttpMessageWriter requestWriter;
    private Socket socket;

    public AndroidHttpClientConnection() {
        this.inbuffer = null;
        this.outbuffer = null;
        this.requestWriter = null;
        this.metrics = null;
        this.socket = null;
        this.entityserializer = new EntitySerializer(new StrictContentLengthStrategy());
    }

    public void bind(Socket socket, HttpParams params) throws IOException {
        if (socket == null) {
            throw new IllegalArgumentException("Socket may not be null");
        } else if (params == null) {
            throw new IllegalArgumentException("HTTP parameters may not be null");
        } else {
            assertNotOpen();
            socket.setTcpNoDelay(HttpConnectionParams.getTcpNoDelay(params));
            socket.setSoTimeout(HttpConnectionParams.getSoTimeout(params));
            int linger = HttpConnectionParams.getLinger(params);
            if (linger >= 0) {
                socket.setSoLinger(linger > 0, linger);
            }
            this.socket = socket;
            int buffersize = HttpConnectionParams.getSocketBufferSize(params);
            this.inbuffer = new SocketInputBuffer(socket, buffersize, params);
            this.outbuffer = new SocketOutputBuffer(socket, buffersize, params);
            this.maxHeaderCount = params.getIntParameter("http.connection.max-header-count", -1);
            this.maxLineLength = params.getIntParameter("http.connection.max-line-length", -1);
            this.requestWriter = new HttpRequestWriter(this.outbuffer, null, params);
            this.metrics = new HttpConnectionMetricsImpl(this.inbuffer.getMetrics(), this.outbuffer.getMetrics());
            this.open = true;
        }
    }

    public String toString() {
        StringBuilder buffer = new StringBuilder();
        buffer.append(getClass().getSimpleName()).append("[");
        if (isOpen()) {
            buffer.append(getRemotePort());
        } else {
            buffer.append("closed");
        }
        buffer.append("]");
        return buffer.toString();
    }

    private void assertNotOpen() {
        if (this.open) {
            throw new IllegalStateException("Connection is already open");
        }
    }

    private void assertOpen() {
        if (!this.open) {
            throw new IllegalStateException("Connection is not open");
        }
    }

    public boolean isOpen() {
        return this.open && this.socket != null && this.socket.isConnected();
    }

    public InetAddress getLocalAddress() {
        if (this.socket != null) {
            return this.socket.getLocalAddress();
        }
        return null;
    }

    public int getLocalPort() {
        if (this.socket != null) {
            return this.socket.getLocalPort();
        }
        return -1;
    }

    public InetAddress getRemoteAddress() {
        if (this.socket != null) {
            return this.socket.getInetAddress();
        }
        return null;
    }

    public int getRemotePort() {
        if (this.socket != null) {
            return this.socket.getPort();
        }
        return -1;
    }

    public void setSocketTimeout(int timeout) {
        assertOpen();
        if (this.socket != null) {
            try {
                this.socket.setSoTimeout(timeout);
            } catch (SocketException e) {
            }
        }
    }

    public int getSocketTimeout() {
        int i = -1;
        if (this.socket != null) {
            try {
                i = this.socket.getSoTimeout();
            } catch (SocketException e) {
            }
        }
        return i;
    }

    public void shutdown() throws IOException {
        this.open = false;
        Socket tmpsocket = this.socket;
        if (tmpsocket != null) {
            tmpsocket.close();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void close() throws java.io.IOException {
        /*
        r1 = this;
        r0 = r1.open;
        if (r0 != 0) goto L_0x0005;
    L_0x0004:
        return;
    L_0x0005:
        r0 = 0;
        r1.open = r0;
        r1.doFlush();
        r0 = r1.socket;	 Catch:{ IOException -> 0x001f, UnsupportedOperationException -> 0x001b }
        r0.shutdownOutput();	 Catch:{ IOException -> 0x001f, UnsupportedOperationException -> 0x001b }
    L_0x0010:
        r0 = r1.socket;	 Catch:{ IOException -> 0x001d, UnsupportedOperationException -> 0x001b }
        r0.shutdownInput();	 Catch:{ IOException -> 0x001d, UnsupportedOperationException -> 0x001b }
    L_0x0015:
        r0 = r1.socket;
        r0.close();
        goto L_0x0004;
    L_0x001b:
        r0 = move-exception;
        goto L_0x0015;
    L_0x001d:
        r0 = move-exception;
        goto L_0x0015;
    L_0x001f:
        r0 = move-exception;
        goto L_0x0010;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.http.AndroidHttpClientConnection.close():void");
    }

    public void sendRequestHeader(HttpRequest request) throws HttpException, IOException {
        if (request == null) {
            throw new IllegalArgumentException("HTTP request may not be null");
        }
        assertOpen();
        this.requestWriter.write(request);
        this.metrics.incrementRequestCount();
    }

    public void sendRequestEntity(HttpEntityEnclosingRequest request) throws HttpException, IOException {
        if (request == null) {
            throw new IllegalArgumentException("HTTP request may not be null");
        }
        assertOpen();
        if (request.getEntity() != null) {
            this.entityserializer.serialize(this.outbuffer, request, request.getEntity());
        }
    }

    protected void doFlush() throws IOException {
        this.outbuffer.flush();
    }

    public void flush() throws IOException {
        assertOpen();
        doFlush();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public org.apache.http.StatusLine parseResponseHeader(android.net.http.Headers r15) throws java.io.IOException, org.apache.http.ParseException {
        /*
        r14 = this;
        r14.assertOpen();
        r1 = new org.apache.http.util.CharArrayBuffer;
        r10 = 64;
        r1.<init>(r10);
        r10 = r14.inbuffer;
        r10 = r10.readLine(r1);
        r11 = -1;
        if (r10 != r11) goto L_0x001b;
    L_0x0013:
        r10 = new org.apache.http.NoHttpResponseException;
        r11 = "The target server failed to respond";
        r10.<init>(r11);
        throw r10;
    L_0x001b:
        r10 = org.apache.http.message.BasicLineParser.DEFAULT;
        r11 = new org.apache.http.message.ParserCursor;
        r12 = 0;
        r13 = r1.length();
        r11.<init>(r12, r13);
        r9 = r10.parseStatusLine(r1, r11);
        r8 = r9.getStatusCode();
        r6 = 0;
        r3 = 0;
    L_0x0031:
        if (r1 != 0) goto L_0x0059;
    L_0x0033:
        r1 = new org.apache.http.util.CharArrayBuffer;
        r10 = 64;
        r1.<init>(r10);
    L_0x003a:
        r10 = r14.inbuffer;
        r4 = r10.readLine(r1);
        r10 = -1;
        if (r4 == r10) goto L_0x004a;
    L_0x0043:
        r10 = r1.length();
        r11 = 1;
        if (r10 >= r11) goto L_0x005d;
    L_0x004a:
        if (r6 == 0) goto L_0x004f;
    L_0x004c:
        r15.parseHeader(r6);
    L_0x004f:
        r10 = 200; // 0xc8 float:2.8E-43 double:9.9E-322;
        if (r8 < r10) goto L_0x0058;
    L_0x0053:
        r10 = r14.metrics;
        r10.incrementResponseCount();
    L_0x0058:
        return r9;
    L_0x0059:
        r1.clear();
        goto L_0x003a;
    L_0x005d:
        r10 = 0;
        r2 = r1.charAt(r10);
        r10 = 32;
        if (r2 == r10) goto L_0x006a;
    L_0x0066:
        r10 = 9;
        if (r2 != r10) goto L_0x00bb;
    L_0x006a:
        if (r6 == 0) goto L_0x00bb;
    L_0x006c:
        r7 = 0;
        r5 = r1.length();
    L_0x0071:
        if (r7 >= r5) goto L_0x007f;
    L_0x0073:
        r0 = r1.charAt(r7);
        r10 = 32;
        if (r0 == r10) goto L_0x009b;
    L_0x007b:
        r10 = 9;
        if (r0 == r10) goto L_0x009b;
    L_0x007f:
        r10 = r14.maxLineLength;
        if (r10 <= 0) goto L_0x009e;
    L_0x0083:
        r10 = r6.length();
        r10 = r10 + 1;
        r11 = r1.length();
        r10 = r10 + r11;
        r10 = r10 - r7;
        r11 = r14.maxLineLength;
        if (r10 <= r11) goto L_0x009e;
    L_0x0093:
        r10 = new java.io.IOException;
        r11 = "Maximum line length limit exceeded";
        r10.<init>(r11);
        throw r10;
    L_0x009b:
        r7 = r7 + 1;
        goto L_0x0071;
    L_0x009e:
        r10 = 32;
        r6.append(r10);
        r10 = r1.length();
        r10 = r10 - r7;
        r6.append(r1, r7, r10);
    L_0x00ab:
        r10 = r14.maxHeaderCount;
        if (r10 <= 0) goto L_0x0031;
    L_0x00af:
        r10 = r14.maxHeaderCount;
        if (r3 < r10) goto L_0x0031;
    L_0x00b3:
        r10 = new java.io.IOException;
        r11 = "Maximum header count exceeded";
        r10.<init>(r11);
        throw r10;
    L_0x00bb:
        if (r6 == 0) goto L_0x00c0;
    L_0x00bd:
        r15.parseHeader(r6);
    L_0x00c0:
        r3 = r3 + 1;
        r6 = r1;
        r1 = 0;
        goto L_0x00ab;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.http.AndroidHttpClientConnection.parseResponseHeader(android.net.http.Headers):org.apache.http.StatusLine");
    }

    public HttpEntity receiveResponseEntity(Headers headers) {
        assertOpen();
        BasicHttpEntity entity = new BasicHttpEntity();
        long len = determineLength(headers);
        if (len == -2) {
            entity.setChunked(true);
            entity.setContentLength(-1);
            entity.setContent(new ChunkedInputStream(this.inbuffer));
        } else if (len == -1) {
            entity.setChunked(false);
            entity.setContentLength(-1);
            entity.setContent(new IdentityInputStream(this.inbuffer));
        } else {
            entity.setChunked(false);
            entity.setContentLength(len);
            entity.setContent(new ContentLengthInputStream(this.inbuffer, len));
        }
        String contentTypeHeader = headers.getContentType();
        if (contentTypeHeader != null) {
            entity.setContentType(contentTypeHeader);
        }
        String contentEncodingHeader = headers.getContentEncoding();
        if (contentEncodingHeader != null) {
            entity.setContentEncoding(contentEncodingHeader);
        }
        return entity;
    }

    private long determineLength(Headers headers) {
        long transferEncoding = headers.getTransferEncoding();
        if (transferEncoding < 0) {
            return transferEncoding;
        }
        long contentlen = headers.getContentLength();
        if (contentlen > -1) {
            return contentlen;
        }
        return -1;
    }

    public boolean isStale() {
        assertOpen();
        try {
            this.inbuffer.isDataAvailable(1);
            return false;
        } catch (IOException e) {
            return true;
        }
    }

    public HttpConnectionMetrics getMetrics() {
        return this.metrics;
    }
}
