package android.net;

import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.Log;
import com.android.net.IProxyService;
import com.android.net.IProxyService.Stub;
import com.google.android.collect.Lists;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.Proxy;
import java.net.Proxy.Type;
import java.net.ProxySelector;
import java.net.SocketAddress;
import java.net.URI;
import java.util.List;

public class PacProxySelector extends ProxySelector {
    private static final String PROXY = "PROXY ";
    public static final String PROXY_SERVICE = "com.android.net.IProxyService";
    private static final String SOCKS = "SOCKS ";
    private static final String TAG = "PacProxySelector";
    private final List<Proxy> mDefaultList;
    private IProxyService mProxyService;

    public PacProxySelector() {
        this.mProxyService = Stub.asInterface(ServiceManager.getService(PROXY_SERVICE));
        if (this.mProxyService == null) {
            Log.e(TAG, "PacManager: no proxy service");
        }
        this.mDefaultList = Lists.newArrayList(new Proxy[]{Proxy.NO_PROXY});
    }

    public List<Proxy> select(URI uri) {
        if (this.mProxyService == null) {
            this.mProxyService = Stub.asInterface(ServiceManager.getService(PROXY_SERVICE));
        }
        if (this.mProxyService == null) {
            Log.e(TAG, "select: no proxy service return NO_PROXY");
            return Lists.newArrayList(new Proxy[]{Proxy.NO_PROXY});
        }
        String urlString;
        String response = null;
        try {
            urlString = uri.toURL().toString();
        } catch (MalformedURLException e) {
            urlString = uri.getHost();
        }
        try {
            response = this.mProxyService.resolvePacFile(uri.getHost(), urlString);
        } catch (RemoteException e2) {
            e2.printStackTrace();
        }
        if (response == null) {
            return this.mDefaultList;
        }
        return parseResponse(response);
    }

    private static List<Proxy> parseResponse(String response) {
        String[] split = response.split(";");
        List<Proxy> ret = Lists.newArrayList();
        for (String s : split) {
            String trimmed = s.trim();
            if (trimmed.equals("DIRECT")) {
                ret.add(Proxy.NO_PROXY);
            } else if (trimmed.startsWith(PROXY)) {
                proxy = proxyFromHostPort(Type.HTTP, trimmed.substring(PROXY.length()));
                if (proxy != null) {
                    ret.add(proxy);
                }
            } else if (trimmed.startsWith(SOCKS)) {
                proxy = proxyFromHostPort(Type.SOCKS, trimmed.substring(SOCKS.length()));
                if (proxy != null) {
                    ret.add(proxy);
                }
            }
        }
        if (ret.size() == 0) {
            ret.add(Proxy.NO_PROXY);
        }
        return ret;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static java.net.Proxy proxyFromHostPort(java.net.Proxy.Type r7, java.lang.String r8) {
        /*
        r4 = ":";
        r2 = r8.split(r4);	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r4 = 0;
        r1 = r2[r4];	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r4 = 1;
        r4 = r2[r4];	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r3 = java.lang.Integer.parseInt(r4);	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r4 = new java.net.Proxy;	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r5 = java.net.InetSocketAddress.createUnresolved(r1, r3);	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
        r4.<init>(r7, r5);	 Catch:{ NumberFormatException -> 0x003f, ArrayIndexOutOfBoundsException -> 0x001a }
    L_0x0019:
        return r4;
    L_0x001a:
        r0 = move-exception;
    L_0x001b:
        r4 = "PacProxySelector";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "Unable to parse proxy ";
        r5 = r5.append(r6);
        r5 = r5.append(r8);
        r6 = " ";
        r5 = r5.append(r6);
        r5 = r5.append(r0);
        r5 = r5.toString();
        android.util.Log.d(r4, r5);
        r4 = 0;
        goto L_0x0019;
    L_0x003f:
        r0 = move-exception;
        goto L_0x001b;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.PacProxySelector.proxyFromHostPort(java.net.Proxy$Type, java.lang.String):java.net.Proxy");
    }

    public void connectFailed(URI uri, SocketAddress address, IOException failure) {
    }
}
