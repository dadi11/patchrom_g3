package android.net.http;

import android.app.ActivityThread;
import android.app.AppOpsManager;
import android.content.ContentResolver;
import android.content.Context;
import android.net.SSLCertificateSocketFactory;
import android.net.SSLSessionCache;
import android.os.Binder;
import android.os.Looper;
import android.os.Trace;
import android.security.KeyChain;
import android.util.Base64;
import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.http.HttpDateTime;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.params.HttpClientParams;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.entity.AbstractHttpEntity;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.RequestWrapper;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.BasicHttpProcessor;
import org.apache.http.protocol.HttpContext;

@Deprecated
public final class AndroidHttpClient implements HttpClient {
    public static long DEFAULT_SYNC_MIN_GZIP_BYTES = 0;
    private static final int SOCKET_OPERATION_TIMEOUT = 60000;
    private static final String TAG = "AndroidHttpClient";
    private static final HttpRequestInterceptor sThreadCheckInterceptor;
    private static String[] textContentTypes;
    private volatile LoggingConfiguration curlConfiguration;
    private final HttpClient delegate;
    private RuntimeException mLeakedException;

    /* renamed from: android.net.http.AndroidHttpClient.1 */
    static class C05121 implements HttpRequestInterceptor {
        C05121() {
        }

        public void process(HttpRequest request, HttpContext context) {
            if (Looper.myLooper() != null && Looper.myLooper() == Looper.getMainLooper()) {
                throw new RuntimeException("This thread forbids HTTP requests");
            }
        }
    }

    /* renamed from: android.net.http.AndroidHttpClient.2 */
    class C05132 extends DefaultHttpClient {
        C05132(ClientConnectionManager x0, HttpParams x1) {
            super(x0, x1);
        }

        protected BasicHttpProcessor createHttpProcessor() {
            BasicHttpProcessor processor = super.createHttpProcessor();
            processor.addRequestInterceptor(AndroidHttpClient.sThreadCheckInterceptor);
            processor.addRequestInterceptor(new CurlLogger(null));
            return processor;
        }

        protected HttpContext createHttpContext() {
            HttpContext context = new BasicHttpContext();
            context.setAttribute("http.authscheme-registry", getAuthSchemes());
            context.setAttribute("http.cookiespec-registry", getCookieSpecs());
            context.setAttribute("http.auth.credentials-provider", getCredentialsProvider());
            return context;
        }
    }

    private class CurlLogger implements HttpRequestInterceptor {
        private CurlLogger() {
        }

        public void process(HttpRequest request, HttpContext context) throws HttpException, IOException {
            LoggingConfiguration configuration = AndroidHttpClient.this.curlConfiguration;
            if (configuration != null && configuration.isLoggable() && (request instanceof HttpUriRequest)) {
                configuration.println(AndroidHttpClient.toCurl((HttpUriRequest) request, false));
            }
        }
    }

    private static class LoggingConfiguration {
        private final int level;
        private final String tag;

        private LoggingConfiguration(String tag, int level) {
            this.tag = tag;
            this.level = level;
        }

        private boolean isLoggable() {
            return Log.isLoggable(this.tag, this.level);
        }

        private void println(String message) {
            Log.println(this.level, this.tag, message);
        }
    }

    static {
        DEFAULT_SYNC_MIN_GZIP_BYTES = 256;
        textContentTypes = new String[]{"text/", "application/xml", "application/json"};
        sThreadCheckInterceptor = new C05121();
    }

    @Deprecated
    public static AndroidHttpClient newInstance(String userAgent, Context context) {
        HttpParams params = new BasicHttpParams();
        HttpConnectionParams.setStaleCheckingEnabled(params, false);
        HttpConnectionParams.setConnectionTimeout(params, SOCKET_OPERATION_TIMEOUT);
        HttpConnectionParams.setSoTimeout(params, SOCKET_OPERATION_TIMEOUT);
        HttpConnectionParams.setSocketBufferSize(params, AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
        HttpClientParams.setRedirecting(params, false);
        SSLSessionCache sessionCache = context == null ? null : new SSLSessionCache(context);
        HttpProtocolParams.setUserAgent(params, userAgent);
        SchemeRegistry schemeRegistry = new SchemeRegistry();
        schemeRegistry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        schemeRegistry.register(new Scheme("https", SSLCertificateSocketFactory.getHttpSocketFactory(SOCKET_OPERATION_TIMEOUT, sessionCache), 443));
        return new AndroidHttpClient(new ThreadSafeClientConnManager(params, schemeRegistry), params);
    }

    @Deprecated
    public static AndroidHttpClient newInstance(String userAgent) {
        return newInstance(userAgent, null);
    }

    private AndroidHttpClient(ClientConnectionManager ccm, HttpParams params) {
        this.mLeakedException = new IllegalStateException("AndroidHttpClient created and never closed");
        this.delegate = new C05132(ccm, params);
    }

    protected void finalize() throws Throwable {
        super.finalize();
        if (this.mLeakedException != null) {
            Log.e(TAG, "Leak found", this.mLeakedException);
            this.mLeakedException = null;
        }
    }

    public static void modifyRequestToAcceptGzipResponse(HttpRequest request) {
        request.addHeader("Accept-Encoding", "gzip");
    }

    public static InputStream getUngzippedContent(HttpEntity entity) throws IOException {
        InputStream responseStream = entity.getContent();
        if (responseStream == null) {
            return responseStream;
        }
        Header header = entity.getContentEncoding();
        if (header == null) {
            return responseStream;
        }
        String contentEncoding = header.getValue();
        if (contentEncoding == null) {
            return responseStream;
        }
        if (contentEncoding.contains("gzip")) {
            responseStream = new GZIPInputStream(responseStream);
        }
        return responseStream;
    }

    public void close() {
        if (this.mLeakedException != null) {
            getConnectionManager().shutdown();
            this.mLeakedException = null;
        }
    }

    public HttpParams getParams() {
        return this.delegate.getParams();
    }

    public ClientConnectionManager getConnectionManager() {
        return this.delegate.getConnectionManager();
    }

    private boolean isMmsRequest() {
        if (this.delegate.getParams() == null || this.delegate.getParams().getParameter("http.useragent") == null || !this.delegate.getParams().getParameter("http.useragent").toString().contains("Android-Mms")) {
            return false;
        }
        return true;
    }

    private boolean checkMmsOps() {
        if (((AppOpsManager) ActivityThread.currentApplication().getSystemService(Context.APP_OPS_SERVICE)).noteOp(50, Binder.getCallingUid(), ActivityThread.currentPackageName()) != 0) {
            return false;
        }
        return true;
    }

    private String getMethod(HttpUriRequest request) {
        if (request != null) {
            return request.getMethod();
        }
        return null;
    }

    private String getMethod(HttpRequest request) {
        if (request == null || request.getRequestLine() == null) {
            return null;
        }
        return request.getRequestLine().getMethod();
    }

    private boolean checkMmsSendPermission(String method) {
        if (isMmsRequest() && method.equals("POST")) {
            return checkMmsOps();
        }
        return true;
    }

    public HttpResponse execute(HttpUriRequest request) throws IOException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(request);
        }
        throw new IOException("Permission denied");
    }

    public HttpResponse execute(HttpUriRequest request, HttpContext context) throws IOException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(request, context);
        }
        throw new IOException("Permission denied");
    }

    public HttpResponse execute(HttpHost target, HttpRequest request) throws IOException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(target, request);
        }
        throw new IOException("Permission denied");
    }

    public HttpResponse execute(HttpHost target, HttpRequest request, HttpContext context) throws IOException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(target, request, context);
        }
        throw new IOException("Permission denied");
    }

    public <T> T execute(HttpUriRequest request, ResponseHandler<? extends T> responseHandler) throws IOException, ClientProtocolException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(request, responseHandler);
        }
        throw new IOException("Permission denied");
    }

    public <T> T execute(HttpUriRequest request, ResponseHandler<? extends T> responseHandler, HttpContext context) throws IOException, ClientProtocolException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(request, responseHandler, context);
        }
        throw new IOException("Permission denied");
    }

    public <T> T execute(HttpHost target, HttpRequest request, ResponseHandler<? extends T> responseHandler) throws IOException, ClientProtocolException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(target, request, responseHandler);
        }
        throw new IOException("Permission denied");
    }

    public <T> T execute(HttpHost target, HttpRequest request, ResponseHandler<? extends T> responseHandler, HttpContext context) throws IOException, ClientProtocolException {
        if (checkMmsSendPermission(getMethod(request))) {
            return this.delegate.execute(target, request, responseHandler, context);
        }
        throw new IOException("Permission denied");
    }

    public static AbstractHttpEntity getCompressedEntity(byte[] data, ContentResolver resolver) throws IOException {
        if (((long) data.length) < getMinGzipSize(resolver)) {
            return new ByteArrayEntity(data);
        }
        ByteArrayOutputStream arr = new ByteArrayOutputStream();
        OutputStream zipper = new GZIPOutputStream(arr);
        zipper.write(data);
        zipper.close();
        AbstractHttpEntity entity = new ByteArrayEntity(arr.toByteArray());
        entity.setContentEncoding("gzip");
        return entity;
    }

    public static long getMinGzipSize(ContentResolver resolver) {
        return DEFAULT_SYNC_MIN_GZIP_BYTES;
    }

    public void enableCurlLogging(String name, int level) {
        if (name == null) {
            throw new NullPointerException(KeyChain.EXTRA_NAME);
        } else if (level < 2 || level > 7) {
            throw new IllegalArgumentException("Level is out of range [2..7]");
        } else {
            this.curlConfiguration = new LoggingConfiguration(level, null);
        }
    }

    public void disableCurlLogging() {
        this.curlConfiguration = null;
    }

    private static String toCurl(HttpUriRequest request, boolean logAuthToken) throws IOException {
        StringBuilder builder = new StringBuilder();
        builder.append("curl ");
        builder.append("-X ");
        builder.append(request.getMethod());
        builder.append(" ");
        for (Header header : request.getAllHeaders()) {
            if (logAuthToken || !(header.getName().equals("Authorization") || header.getName().equals("Cookie"))) {
                builder.append("--header \"");
                builder.append(header.toString().trim());
                builder.append("\" ");
            }
        }
        URI uri = request.getURI();
        if (request instanceof RequestWrapper) {
            HttpRequest original = ((RequestWrapper) request).getOriginal();
            if (original instanceof HttpUriRequest) {
                uri = ((HttpUriRequest) original).getURI();
            }
        }
        builder.append("\"");
        builder.append(uri);
        builder.append("\"");
        if (request instanceof HttpEntityEnclosingRequest) {
            HttpEntity entity = ((HttpEntityEnclosingRequest) request).getEntity();
            if (entity != null && entity.isRepeatable()) {
                if (entity.getContentLength() < Trace.TRACE_TAG_CAMERA) {
                    ByteArrayOutputStream stream = new ByteArrayOutputStream();
                    entity.writeTo(stream);
                    if (isBinaryContent(request)) {
                        builder.insert(0, "echo '" + Base64.encodeToString(stream.toByteArray(), 2) + "' | base64 -d > /tmp/$$.bin; ");
                        builder.append(" --data-binary @/tmp/$$.bin");
                    } else {
                        builder.append(" --data-ascii \"").append(stream.toString()).append("\"");
                    }
                } else {
                    builder.append(" [TOO MUCH DATA TO INCLUDE]");
                }
            }
        }
        return builder.toString();
    }

    private static boolean isBinaryContent(HttpUriRequest request) {
        Header[] headers = request.getHeaders(Headers.CONTENT_ENCODING);
        if (headers != null) {
            for (Header header : headers) {
                if ("gzip".equalsIgnoreCase(header.getValue())) {
                    return true;
                }
            }
        }
        headers = request.getHeaders(Headers.CONTENT_TYPE);
        if (headers == null) {
            return true;
        }
        for (Header header2 : headers) {
            for (String contentType : textContentTypes) {
                if (header2.getValue().startsWith(contentType)) {
                    return false;
                }
            }
        }
        return true;
    }

    public static long parseDate(String dateString) {
        return HttpDateTime.parse(dateString);
    }
}
