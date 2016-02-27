package android.net.http;

import android.content.Context;
import android.media.AudioSystem;
import android.security.KeyChain;
import android.util.Log;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.org.conscrypt.FileClientSessionCache;
import com.android.org.conscrypt.OpenSSLContextImpl;
import com.android.org.conscrypt.SSLClientSessionCache;
import java.io.File;
import java.io.IOException;
import java.net.Socket;
import java.security.KeyManagementException;
import java.security.cert.X509Certificate;
import java.util.Locale;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.apache.http.Header;
import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.ParseException;
import org.apache.http.ProtocolVersion;
import org.apache.http.StatusLine;
import org.apache.http.message.BasicHttpRequest;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;

public class HttpsConnection extends Connection {
    private static SSLSocketFactory mSslSocketFactory;
    private boolean mAborted;
    private HttpHost mProxyHost;
    private Object mSuspendLock;
    private boolean mSuspended;

    /* renamed from: android.net.http.HttpsConnection.1 */
    static class C05151 implements X509TrustManager {
        C05151() {
        }

        public X509Certificate[] getAcceptedIssuers() {
            return null;
        }

        public void checkClientTrusted(X509Certificate[] certs, String authType) {
        }

        public void checkServerTrusted(X509Certificate[] certs, String authType) {
        }
    }

    public /* bridge */ /* synthetic */ String toString() {
        return super.toString();
    }

    static {
        mSslSocketFactory = null;
        initializeEngine(null);
    }

    public static void initializeEngine(File sessionDir) {
        SSLClientSessionCache cache = null;
        if (sessionDir != null) {
            try {
                Log.d("HttpsConnection", "Caching SSL sessions in " + sessionDir + ".");
                cache = FileClientSessionCache.usingDirectory(sessionDir);
            } catch (KeyManagementException e) {
                throw new RuntimeException(e);
            } catch (IOException e2) {
                throw new RuntimeException(e2);
            }
        }
        OpenSSLContextImpl sslContext = new OpenSSLContextImpl();
        sslContext.engineInit(null, new TrustManager[]{new C05151()}, null);
        sslContext.engineGetClientSessionContext().setPersistentCache(cache);
        synchronized (HttpsConnection.class) {
            mSslSocketFactory = sslContext.engineGetSocketFactory();
        }
    }

    private static synchronized SSLSocketFactory getSocketFactory() {
        SSLSocketFactory sSLSocketFactory;
        synchronized (HttpsConnection.class) {
            sSLSocketFactory = mSslSocketFactory;
        }
        return sSLSocketFactory;
    }

    HttpsConnection(Context context, HttpHost host, HttpHost proxy, RequestFeeder requestFeeder) {
        super(context, host, requestFeeder);
        this.mSuspendLock = new Object();
        this.mSuspended = false;
        this.mAborted = false;
        this.mProxyHost = proxy;
    }

    void setCertificate(SslCertificate certificate) {
        this.mCertificate = certificate;
    }

    AndroidHttpClientConnection openConnection(Request req) throws IOException {
        Socket sslSock;
        String errorMessage;
        IOException e;
        Socket socket;
        SSLSocket sslSock2 = null;
        if (this.mProxyHost != null) {
            AndroidHttpClientConnection proxyConnection = null;
            try {
                Socket socket2 = new Socket(this.mProxyHost.getHostName(), this.mProxyHost.getPort());
                try {
                    socket2.setSoTimeout(60000);
                    AndroidHttpClientConnection proxyConnection2 = new AndroidHttpClientConnection();
                    try {
                        HttpParams params = new BasicHttpParams();
                        HttpConnectionParams.setSocketBufferSize(params, AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
                        proxyConnection2.bind(socket2, params);
                        Headers headers = new Headers();
                        try {
                            int statusCode;
                            StatusLine statusLine;
                            BasicHttpRequest basicHttpRequest = new BasicHttpRequest("CONNECT", this.mHost.toHostString());
                            for (Header h : req.mHttpRequest.getAllHeaders()) {
                                String headerName = h.getName().toLowerCase(Locale.ROOT);
                                if (!headerName.startsWith(AudioSystem.DEVICE_OUT_PROXY_NAME)) {
                                    if (!headerName.equals("keep-alive")) {
                                        if (!headerName.equals(KeyChain.EXTRA_HOST)) {
                                        }
                                    }
                                }
                                basicHttpRequest.addHeader(h);
                            }
                            proxyConnection2.sendRequestHeader(basicHttpRequest);
                            proxyConnection2.flush();
                            do {
                                statusLine = proxyConnection2.parseResponseHeader(headers);
                                statusCode = statusLine.getStatusCode();
                            } while (statusCode < 200);
                            if (statusCode == 200) {
                                try {
                                    sslSock = (SSLSocket) getSocketFactory().createSocket(socket2, this.mHost.getHostName(), this.mHost.getPort(), true);
                                } catch (IOException e2) {
                                    if (sslSock2 != null) {
                                        sslSock2.close();
                                    }
                                    errorMessage = e2.getMessage();
                                    if (errorMessage == null) {
                                        errorMessage = "failed to create an SSL socket";
                                    }
                                    throw new IOException(errorMessage);
                                }
                            }
                            ProtocolVersion version = statusLine.getProtocolVersion();
                            req.mEventHandler.status(version.getMajor(), version.getMinor(), statusCode, statusLine.getReasonPhrase());
                            req.mEventHandler.headers(headers);
                            req.mEventHandler.endData();
                            proxyConnection2.close();
                            return null;
                        } catch (ParseException e3) {
                            errorMessage = e3.getMessage();
                            if (errorMessage == null) {
                                errorMessage = "failed to send a CONNECT request";
                            }
                            throw new IOException(errorMessage);
                        } catch (HttpException e4) {
                            errorMessage = e4.getMessage();
                            if (errorMessage == null) {
                                errorMessage = "failed to send a CONNECT request";
                            }
                            throw new IOException(errorMessage);
                        } catch (IOException e22) {
                            errorMessage = e22.getMessage();
                            if (errorMessage == null) {
                                errorMessage = "failed to send a CONNECT request";
                            }
                            throw new IOException(errorMessage);
                        }
                    } catch (IOException e5) {
                        e22 = e5;
                        socket = socket2;
                        proxyConnection = proxyConnection2;
                        if (proxyConnection != null) {
                            proxyConnection.close();
                        }
                        errorMessage = e22.getMessage();
                        if (errorMessage == null) {
                            errorMessage = "failed to establish a connection to the proxy";
                        }
                        throw new IOException(errorMessage);
                    }
                } catch (IOException e6) {
                    e22 = e6;
                    socket = socket2;
                    if (proxyConnection != null) {
                        proxyConnection.close();
                    }
                    errorMessage = e22.getMessage();
                    if (errorMessage == null) {
                        errorMessage = "failed to establish a connection to the proxy";
                    }
                    throw new IOException(errorMessage);
                }
            } catch (IOException e7) {
                e22 = e7;
                if (proxyConnection != null) {
                    proxyConnection.close();
                }
                errorMessage = e22.getMessage();
                if (errorMessage == null) {
                    errorMessage = "failed to establish a connection to the proxy";
                }
                throw new IOException(errorMessage);
            }
        }
        try {
            sslSock2 = (SSLSocket) getSocketFactory().createSocket(this.mHost.getHostName(), this.mHost.getPort());
            sslSock2.setSoTimeout(60000);
        } catch (IOException e222) {
            if (sslSock2 != null) {
                sslSock2.close();
            }
            errorMessage = e222.getMessage();
            if (errorMessage == null) {
                errorMessage = "failed to create an SSL socket";
            }
            throw new IOException(errorMessage);
        }
        SslError error = CertificateChainValidator.getInstance().doHandshakeAndValidateServerCertificates(this, sslSock, this.mHost.getHostName());
        if (error != null) {
            synchronized (this.mSuspendLock) {
                this.mSuspended = true;
            }
            if (req.getEventHandler().handleSslErrorRequest(error)) {
                synchronized (this.mSuspendLock) {
                    if (this.mSuspended) {
                        try {
                            this.mSuspendLock.wait(600000);
                            if (this.mSuspended) {
                                this.mSuspended = false;
                                this.mAborted = true;
                            }
                        } catch (InterruptedException e8) {
                        }
                    }
                    if (this.mAborted) {
                        sslSock.close();
                        throw new SSLConnectionClosedByUserException("connection closed by the user");
                    }
                }
            } else {
                throw new IOException("failed to handle " + error);
            }
        }
        AndroidHttpClientConnection conn = new AndroidHttpClientConnection();
        BasicHttpParams params2 = new BasicHttpParams();
        params2.setIntParameter("http.socket.buffer-size", AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
        conn.bind(sslSock, params2);
        return conn;
    }

    void closeConnection() {
        if (this.mSuspended) {
            restartConnection(false);
        }
        try {
            if (this.mHttpClientConnection != null && this.mHttpClientConnection.isOpen()) {
                this.mHttpClientConnection.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    void restartConnection(boolean proceed) {
        boolean z = false;
        synchronized (this.mSuspendLock) {
            if (this.mSuspended) {
                this.mSuspended = false;
                if (!proceed) {
                    z = true;
                }
                this.mAborted = z;
                this.mSuspendLock.notify();
            }
        }
    }

    String getScheme() {
        return "https";
    }
}
