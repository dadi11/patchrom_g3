package android.webkit;

import android.app.ActivityManagerInternal;
import android.app.AppGlobals;
import android.app.Application;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.ProxyInfo;
import android.os.Build;
import android.os.Process;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.StrictMode;
import android.os.StrictMode.ThreadPolicy;
import android.os.SystemProperties;
import android.os.Trace;
import android.text.TextUtils;
import android.util.AndroidRuntimeException;
import android.util.Log;
import android.view.WindowManager.LayoutParams;
import android.webkit.IWebViewUpdateService.Stub;
import com.android.server.LocalServices;
import dalvik.system.VMRuntime;
import java.io.File;

public final class WebViewFactory {
    private static final long CHROMIUM_WEBVIEW_DEFAULT_VMSIZE_BYTES = 104857600;
    private static final String CHROMIUM_WEBVIEW_FACTORY = "com.android.webview.chromium.WebViewChromiumFactoryProvider";
    private static final String CHROMIUM_WEBVIEW_NATIVE_RELRO_32 = "/data/misc/shared_relro/libwebviewchromium32.relro";
    private static final String CHROMIUM_WEBVIEW_NATIVE_RELRO_64 = "/data/misc/shared_relro/libwebviewchromium64.relro";
    public static final String CHROMIUM_WEBVIEW_VMSIZE_SIZE_PROPERTY = "persist.sys.webview.vmsize";
    private static final boolean DEBUG = false;
    private static final String LOGTAG = "WebViewFactory";
    private static final String NULL_WEBVIEW_FACTORY = "com.android.webview.nullwebview.NullWebViewFactoryProvider";
    private static boolean sAddressSpaceReserved;
    private static PackageInfo sPackageInfo;
    private static WebViewFactoryProvider sProviderInstance;
    private static final Object sProviderLock;

    /* renamed from: android.webkit.WebViewFactory.1 */
    static class C09131 implements Runnable {
        final /* synthetic */ String val$abi;
        final /* synthetic */ boolean val$is64Bit;

        C09131(String str, boolean z) {
            this.val$abi = str;
            this.val$is64Bit = z;
        }

        public void run() {
            try {
                Log.e(WebViewFactory.LOGTAG, "relro file creator for " + this.val$abi + " crashed. Proceeding without");
                WebViewFactory.getUpdateService().notifyRelroCreationCompleted(this.val$is64Bit, WebViewFactory.DEBUG);
            } catch (RemoteException e) {
                Log.e(WebViewFactory.LOGTAG, "Cannot reach WebViewUpdateService. " + e.getMessage());
            }
        }
    }

    private static class RelroFileCreator {
        private RelroFileCreator() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public static void main(java.lang.String[] r8) {
            /*
            r7 = 0;
            r2 = 0;
            r3 = dalvik.system.VMRuntime.getRuntime();
            r1 = r3.is64Bit();
            r3 = r8.length;	 Catch:{ all -> 0x00e1 }
            r4 = 2;
            if (r3 != r4) goto L_0x0018;
        L_0x000e:
            r3 = 0;
            r3 = r8[r3];	 Catch:{ all -> 0x00e1 }
            if (r3 == 0) goto L_0x0018;
        L_0x0013:
            r3 = 1;
            r3 = r8[r3];	 Catch:{ all -> 0x00e1 }
            if (r3 != 0) goto L_0x0051;
        L_0x0018:
            r3 = "WebViewFactory";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e1 }
            r4.<init>();	 Catch:{ all -> 0x00e1 }
            r5 = "Invalid RelroFileCreator args: ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r5 = java.util.Arrays.toString(r8);	 Catch:{ all -> 0x00e1 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r4 = r4.toString();	 Catch:{ all -> 0x00e1 }
            android.util.Log.e(r3, r4);	 Catch:{ all -> 0x00e1 }
            r3 = android.webkit.WebViewFactory.getUpdateService();	 Catch:{ RemoteException -> 0x0048 }
            r3.notifyRelroCreationCompleted(r1, r2);	 Catch:{ RemoteException -> 0x0048 }
        L_0x003b:
            if (r2 != 0) goto L_0x0044;
        L_0x003d:
            r3 = "WebViewFactory";
            r4 = "failed to create relro file";
            android.util.Log.e(r3, r4);
        L_0x0044:
            java.lang.System.exit(r7);
        L_0x0047:
            return;
        L_0x0048:
            r0 = move-exception;
            r3 = "WebViewFactory";
            r4 = "error notifying update service";
            android.util.Log.e(r3, r4, r0);
            goto L_0x003b;
        L_0x0051:
            r3 = "WebViewFactory";
            r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00e1 }
            r4.<init>();	 Catch:{ all -> 0x00e1 }
            r5 = "RelroFileCreator (64bit = ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r4 = r4.append(r1);	 Catch:{ all -> 0x00e1 }
            r5 = "), ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r5 = " 32-bit lib: ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r5 = 0;
            r5 = r8[r5];	 Catch:{ all -> 0x00e1 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r5 = ", 64-bit lib: ";
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r5 = 1;
            r5 = r8[r5];	 Catch:{ all -> 0x00e1 }
            r4 = r4.append(r5);	 Catch:{ all -> 0x00e1 }
            r4 = r4.toString();	 Catch:{ all -> 0x00e1 }
            android.util.Log.v(r3, r4);	 Catch:{ all -> 0x00e1 }
            r3 = android.webkit.WebViewFactory.sAddressSpaceReserved;	 Catch:{ all -> 0x00e1 }
            if (r3 != 0) goto L_0x00b3;
        L_0x008f:
            r3 = "WebViewFactory";
            r4 = "can't create relro file; address space not reserved";
            android.util.Log.e(r3, r4);	 Catch:{ all -> 0x00e1 }
            r3 = android.webkit.WebViewFactory.getUpdateService();	 Catch:{ RemoteException -> 0x00aa }
            r3.notifyRelroCreationCompleted(r1, r2);	 Catch:{ RemoteException -> 0x00aa }
        L_0x009d:
            if (r2 != 0) goto L_0x00a6;
        L_0x009f:
            r3 = "WebViewFactory";
            r4 = "failed to create relro file";
            android.util.Log.e(r3, r4);
        L_0x00a6:
            java.lang.System.exit(r7);
            goto L_0x0047;
        L_0x00aa:
            r0 = move-exception;
            r3 = "WebViewFactory";
            r4 = "error notifying update service";
            android.util.Log.e(r3, r4, r0);
            goto L_0x009d;
        L_0x00b3:
            r3 = 0;
            r3 = r8[r3];	 Catch:{ all -> 0x00e1 }
            r4 = 1;
            r4 = r8[r4];	 Catch:{ all -> 0x00e1 }
            r5 = "/data/misc/shared_relro/libwebviewchromium32.relro";
            r6 = "/data/misc/shared_relro/libwebviewchromium64.relro";
            r2 = android.webkit.WebViewFactory.nativeCreateRelroFile(r3, r4, r5, r6);	 Catch:{ all -> 0x00e1 }
            if (r2 == 0) goto L_0x00c3;
        L_0x00c3:
            r3 = android.webkit.WebViewFactory.getUpdateService();	 Catch:{ RemoteException -> 0x00d8 }
            r3.notifyRelroCreationCompleted(r1, r2);	 Catch:{ RemoteException -> 0x00d8 }
        L_0x00ca:
            if (r2 != 0) goto L_0x00d3;
        L_0x00cc:
            r3 = "WebViewFactory";
            r4 = "failed to create relro file";
            android.util.Log.e(r3, r4);
        L_0x00d3:
            java.lang.System.exit(r7);
            goto L_0x0047;
        L_0x00d8:
            r0 = move-exception;
            r3 = "WebViewFactory";
            r4 = "error notifying update service";
            android.util.Log.e(r3, r4, r0);
            goto L_0x00ca;
        L_0x00e1:
            r3 = move-exception;
            r4 = android.webkit.WebViewFactory.getUpdateService();	 Catch:{ RemoteException -> 0x00f6 }
            r4.notifyRelroCreationCompleted(r1, r2);	 Catch:{ RemoteException -> 0x00f6 }
        L_0x00e9:
            if (r2 != 0) goto L_0x00f2;
        L_0x00eb:
            r4 = "WebViewFactory";
            r5 = "failed to create relro file";
            android.util.Log.e(r4, r5);
        L_0x00f2:
            java.lang.System.exit(r7);
            throw r3;
        L_0x00f6:
            r0 = move-exception;
            r4 = "WebViewFactory";
            r5 = "error notifying update service";
            android.util.Log.e(r4, r5, r0);
            goto L_0x00e9;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.webkit.WebViewFactory.RelroFileCreator.main(java.lang.String[]):void");
        }
    }

    private static native boolean nativeCreateRelroFile(String str, String str2, String str3, String str4);

    private static native boolean nativeLoadWithRelroFile(String str, String str2, String str3, String str4);

    private static native boolean nativeReserveAddressSpace(long j);

    static {
        sProviderLock = new Object();
        sAddressSpaceReserved = DEBUG;
    }

    public static String getWebViewPackageName() {
        Application initialApp = AppGlobals.getInitialApplication();
        String pkg = initialApp.getString(17039434);
        return isPackageInstalled(initialApp, pkg) ? pkg : "com.android.webview";
    }

    public static PackageInfo getLoadedPackageInfo() {
        return sPackageInfo;
    }

    static WebViewFactoryProvider getProvider() {
        WebViewFactoryProvider webViewFactoryProvider;
        synchronized (sProviderLock) {
            if (sProviderInstance != null) {
                webViewFactoryProvider = sProviderInstance;
            } else {
                int uid = Process.myUid();
                if (uid == 0 || uid == LayoutParams.TYPE_APPLICATION_PANEL) {
                    throw new UnsupportedOperationException("For security reasons, WebView is not allowed in privileged processes");
                }
                Trace.traceBegin(16, "WebViewFactory.getProvider()");
                long j;
                try {
                    Trace.traceBegin(16, "WebViewFactory.loadNativeLibrary()");
                    loadNativeLibrary();
                    Trace.traceEnd(16);
                    j = 16;
                    Trace.traceBegin(16, "WebViewFactory.getFactoryClass()");
                    try {
                        Class<WebViewFactoryProvider> providerClass = getFactoryClass();
                        Trace.traceEnd(j);
                        ThreadPolicy oldPolicy = StrictMode.allowThreadDiskReads();
                        Trace.traceBegin(16, "providerClass.newInstance()");
                        try {
                            sProviderInstance = (WebViewFactoryProvider) providerClass.getConstructor(new Class[]{WebViewDelegate.class}).newInstance(new Object[]{new WebViewDelegate()});
                            try {
                                webViewFactoryProvider = sProviderInstance;
                                Trace.traceEnd(16);
                                StrictMode.setThreadPolicy(oldPolicy);
                                Trace.traceEnd(16);
                            } catch (Exception e) {
                                Log.e(LOGTAG, "error instantiating provider", e);
                                throw new AndroidRuntimeException(e);
                            } catch (Throwable th) {
                                Trace.traceEnd(16);
                                StrictMode.setThreadPolicy(oldPolicy);
                            }
                        } catch (Exception e2) {
                            sProviderInstance = (WebViewFactoryProvider) providerClass.newInstance();
                        }
                    } catch (ClassNotFoundException e3) {
                        Log.e(LOGTAG, "error loading provider", e3);
                        throw new AndroidRuntimeException(e3);
                    } catch (Throwable th2) {
                        Trace.traceEnd(16);
                    }
                } finally {
                    j = 16;
                    Trace.traceEnd(16);
                }
            }
        }
        return webViewFactoryProvider;
    }

    private static Class<WebViewFactoryProvider> getFactoryClass() throws ClassNotFoundException {
        Class<WebViewFactoryProvider> cls;
        Application initialApplication = AppGlobals.getInitialApplication();
        try {
            String packageName = getWebViewPackageName();
            sPackageInfo = initialApplication.getPackageManager().getPackageInfo(packageName, 0);
            Log.i(LOGTAG, "Loading " + packageName + " version " + sPackageInfo.versionName + " (code " + sPackageInfo.versionCode + ")");
            Context webViewContext = initialApplication.createPackageContext(packageName, 3);
            initialApplication.getAssets().addAssetPath(webViewContext.getApplicationInfo().sourceDir);
            ClassLoader clazzLoader = webViewContext.getClassLoader();
            Trace.traceBegin(16, "Class.forName()");
            cls = Class.forName(CHROMIUM_WEBVIEW_FACTORY, true, clazzLoader);
            Trace.traceEnd(16);
        } catch (NameNotFoundException e) {
            try {
                cls = Class.forName(NULL_WEBVIEW_FACTORY);
            } catch (ClassNotFoundException e2) {
                Log.e(LOGTAG, "Chromium WebView package does not exist", e);
                throw new AndroidRuntimeException(e);
            }
        } catch (Throwable th) {
            Trace.traceEnd(16);
        }
        return cls;
    }

    public static void prepareWebViewInZygote() {
        try {
            System.loadLibrary("webviewchromium_loader");
            long addressSpaceToReserve = SystemProperties.getLong(CHROMIUM_WEBVIEW_VMSIZE_SIZE_PROPERTY, CHROMIUM_WEBVIEW_DEFAULT_VMSIZE_BYTES);
            sAddressSpaceReserved = nativeReserveAddressSpace(addressSpaceToReserve);
            if (!sAddressSpaceReserved) {
                Log.e(LOGTAG, "reserving " + addressSpaceToReserve + " bytes of address space failed");
            }
        } catch (Throwable t) {
            Log.e(LOGTAG, "error preparing native loader", t);
        }
    }

    public static void prepareWebViewInSystemServer() {
        String[] nativePaths = null;
        try {
            nativePaths = getWebViewNativeLibraryPaths();
        } catch (Throwable t) {
            Log.e(LOGTAG, "error preparing webview native library", t);
        }
        prepareWebViewInSystemServer(nativePaths);
    }

    private static void prepareWebViewInSystemServer(String[] nativeLibraryPaths) {
        if (Build.SUPPORTED_32_BIT_ABIS.length > 0) {
            createRelroFile(DEBUG, nativeLibraryPaths);
        }
        if (Build.SUPPORTED_64_BIT_ABIS.length > 0) {
            createRelroFile(true, nativeLibraryPaths);
        }
    }

    public static void onWebViewUpdateInstalled() {
        String[] nativeLibs = null;
        try {
            nativeLibs = getWebViewNativeLibraryPaths();
            if (nativeLibs != null) {
                long newVmSize = 0;
                for (String path : nativeLibs) {
                    if (path != null) {
                        File f = new File(path);
                        if (f.exists()) {
                            long length = f.length();
                            if (length > newVmSize) {
                                newVmSize = length;
                            }
                        }
                    }
                }
                newVmSize = Math.max(2 * newVmSize, CHROMIUM_WEBVIEW_DEFAULT_VMSIZE_BYTES);
                Log.d(LOGTAG, "Setting new address space to " + newVmSize);
                SystemProperties.set(CHROMIUM_WEBVIEW_VMSIZE_SIZE_PROPERTY, Long.toString(newVmSize));
            }
        } catch (Throwable t) {
            Log.e(LOGTAG, "error preparing webview native library", t);
        }
        prepareWebViewInSystemServer(nativeLibs);
    }

    private static String[] getWebViewNativeLibraryPaths() throws NameNotFoundException {
        String path64;
        String path32;
        String NATIVE_LIB_FILE_NAME = "libwebviewchromium.so";
        ApplicationInfo ai = AppGlobals.getInitialApplication().getPackageManager().getApplicationInfo(getWebViewPackageName(), 0);
        boolean primaryArchIs64bit = VMRuntime.is64BitAbi(ai.primaryCpuAbi);
        if (TextUtils.isEmpty(ai.secondaryCpuAbi)) {
            if (primaryArchIs64bit) {
                path64 = ai.nativeLibraryDir;
                path32 = ProxyInfo.LOCAL_EXCL_LIST;
            } else {
                path32 = ai.nativeLibraryDir;
                path64 = ProxyInfo.LOCAL_EXCL_LIST;
            }
        } else if (primaryArchIs64bit) {
            path64 = ai.nativeLibraryDir;
            path32 = ai.secondaryNativeLibraryDir;
        } else {
            path64 = ai.secondaryNativeLibraryDir;
            path32 = ai.nativeLibraryDir;
        }
        if (!TextUtils.isEmpty(path32)) {
            path32 = path32 + "/libwebviewchromium.so";
        }
        if (!TextUtils.isEmpty(path64)) {
            path64 = path64 + "/libwebviewchromium.so";
        }
        return new String[]{path32, path64};
    }

    private static void createRelroFile(boolean is64Bit, String[] nativeLibraryPaths) {
        String abi;
        if (is64Bit) {
            abi = Build.SUPPORTED_64_BIT_ABIS[0];
        } else {
            abi = Build.SUPPORTED_32_BIT_ABIS[0];
        }
        Runnable crashHandler = new C09131(abi, is64Bit);
        if (nativeLibraryPaths != null) {
            try {
                if (!(nativeLibraryPaths[0] == null || nativeLibraryPaths[1] == null)) {
                    if (((ActivityManagerInternal) LocalServices.getService(ActivityManagerInternal.class)).startIsolatedProcess(RelroFileCreator.class.getName(), nativeLibraryPaths, "WebViewLoader-" + abi, abi, Process.SHARED_RELRO_UID, crashHandler) <= 0) {
                        throw new Exception("Failed to start the relro file creator process");
                    }
                    return;
                }
            } catch (Throwable t) {
                Log.e(LOGTAG, "error starting relro file creator for abi " + abi, t);
                crashHandler.run();
                return;
            }
        }
        throw new IllegalArgumentException("Native library paths to the WebView RelRo process must not be null!");
    }

    private static void loadNativeLibrary() {
        if (sAddressSpaceReserved) {
            try {
                getUpdateService().waitForRelroCreationCompleted(VMRuntime.getRuntime().is64Bit());
                try {
                    String[] args = getWebViewNativeLibraryPaths();
                    if (!nativeLoadWithRelroFile(args[0], args[1], CHROMIUM_WEBVIEW_NATIVE_RELRO_32, CHROMIUM_WEBVIEW_NATIVE_RELRO_64)) {
                        Log.w(LOGTAG, "failed to load with relro file, proceeding without");
                        return;
                    }
                    return;
                } catch (NameNotFoundException e) {
                    Log.e(LOGTAG, "Failed to list WebView package libraries for loadNativeLibrary", e);
                    return;
                }
            } catch (RemoteException e2) {
                Log.e(LOGTAG, "error waiting for relro creation, proceeding without", e2);
                return;
            }
        }
        Log.e(LOGTAG, "can't load with relro file; address space not reserved");
    }

    private static boolean isPackageInstalled(Context context, String packageName) {
        try {
            return context.getPackageManager().getPackageInfo(packageName, 0) != null ? true : DEBUG;
        } catch (NameNotFoundException e) {
            return DEBUG;
        }
    }

    private static IWebViewUpdateService getUpdateService() {
        return Stub.asInterface(ServiceManager.getService("webviewupdate"));
    }
}
