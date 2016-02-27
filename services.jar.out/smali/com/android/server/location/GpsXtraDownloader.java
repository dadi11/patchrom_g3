package com.android.server.location;

import android.content.Context;
import android.net.Proxy;
import android.net.http.AndroidHttpClient;
import android.text.TextUtils;
import android.util.Log;
import java.io.DataInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.params.ConnRouteParams;

public class GpsXtraDownloader {
    private static final boolean DEBUG;
    private static final String DEFAULT_USER_AGENT = "Android";
    private static final String TAG = "GpsXtraDownloader";
    private final Context mContext;
    private int mNextServerIndex;
    private final String mUserAgent;
    private final String[] mXtraServers;

    static {
        DEBUG = Log.isLoggable(TAG, 3);
    }

    GpsXtraDownloader(Context context, Properties properties) {
        this.mContext = context;
        int count = 0;
        String server1 = properties.getProperty("XTRA_SERVER_1");
        String server2 = properties.getProperty("XTRA_SERVER_2");
        String server3 = properties.getProperty("XTRA_SERVER_3");
        if (server1 != null) {
            count = 0 + 1;
        }
        if (server2 != null) {
            count++;
        }
        if (server3 != null) {
            count++;
        }
        String agent = properties.getProperty("XTRA_USER_AGENT");
        if (TextUtils.isEmpty(agent)) {
            this.mUserAgent = DEFAULT_USER_AGENT;
        } else {
            this.mUserAgent = agent;
        }
        if (count == 0) {
            Log.e(TAG, "No XTRA servers were specified in the GPS configuration");
            this.mXtraServers = null;
            return;
        }
        int count2;
        this.mXtraServers = new String[count];
        if (server1 != null) {
            count2 = 0 + 1;
            this.mXtraServers[0] = server1;
        } else {
            count2 = 0;
        }
        if (server2 != null) {
            count = count2 + 1;
            this.mXtraServers[count2] = server2;
            count2 = count;
        }
        if (server3 != null) {
            count = count2 + 1;
            this.mXtraServers[count2] = server3;
        } else {
            count = count2;
        }
        this.mNextServerIndex = new Random().nextInt(count);
    }

    byte[] downloadXtraData() {
        boolean useProxy;
        String proxyHost = Proxy.getHost(this.mContext);
        int proxyPort = Proxy.getPort(this.mContext);
        if (proxyHost == null || proxyPort == -1) {
            useProxy = DEBUG;
        } else {
            useProxy = true;
        }
        byte[] result = null;
        int startIndex = this.mNextServerIndex;
        if (this.mXtraServers == null) {
            return null;
        }
        while (result == null) {
            result = doDownload(this.mXtraServers[this.mNextServerIndex], useProxy, proxyHost, proxyPort);
            this.mNextServerIndex++;
            if (this.mNextServerIndex == this.mXtraServers.length) {
                this.mNextServerIndex = 0;
            }
            if (this.mNextServerIndex == startIndex) {
                break;
            }
        }
        return result;
    }

    protected byte[] doDownload(String url, boolean isProxySet, String proxyHost, int proxyPort) {
        if (DEBUG) {
            Log.d(TAG, "Downloading XTRA data from " + url);
        }
        AndroidHttpClient client = null;
        try {
            if (DEBUG) {
                Log.d(TAG, "XTRA user agent: " + this.mUserAgent);
            }
            client = AndroidHttpClient.newInstance(this.mUserAgent);
            HttpUriRequest req = new HttpGet(url);
            if (isProxySet) {
                ConnRouteParams.setDefaultProxy(req.getParams(), new HttpHost(proxyHost, proxyPort));
            }
            req.addHeader("Accept", "*/*, application/vnd.wap.mms-message, application/vnd.wap.sic");
            req.addHeader("x-wap-profile", "http://www.openmobilealliance.org/tech/profiles/UAPROF/ccppschema-20021212#");
            HttpResponse response = client.execute(req);
            StatusLine status = response.getStatusLine();
            if (status.getStatusCode() != 200) {
                if (DEBUG) {
                    Log.d(TAG, "HTTP error: " + status.getReasonPhrase());
                }
                if (client == null) {
                    return null;
                }
                client.close();
                return null;
            }
            HttpEntity entity = response.getEntity();
            byte[] body = null;
            if (entity != null) {
                DataInputStream dis;
                try {
                    if (entity.getContentLength() > 0) {
                        body = new byte[((int) entity.getContentLength())];
                        dis = new DataInputStream(entity.getContent());
                        dis.readFully(body);
                        dis.close();
                    }
                } catch (IOException e) {
                    Log.e(TAG, "Unexpected IOException.", e);
                } catch (Throwable th) {
                    if (entity != null) {
                        entity.consumeContent();
                    }
                }
                if (entity != null) {
                    entity.consumeContent();
                }
            }
            if (client == null) {
                return body;
            }
            client.close();
            return body;
        } catch (Exception e2) {
            try {
                if (DEBUG) {
                    Log.d(TAG, "error " + e2);
                }
                if (client != null) {
                    client.close();
                }
                return null;
            } catch (Throwable th2) {
                if (client != null) {
                    client.close();
                }
            }
        }
    }
}
