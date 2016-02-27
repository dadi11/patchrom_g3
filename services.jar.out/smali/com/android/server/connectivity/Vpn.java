package com.android.server.connectivity;

import android.app.AppGlobals;
import android.app.AppOpsManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.net.IConnectivityManager;
import android.net.INetworkManagementEventObserver;
import android.net.IpPrefix;
import android.net.LinkAddress;
import android.net.LinkProperties;
import android.net.LocalSocket;
import android.net.Network;
import android.net.NetworkAgent;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkMisc;
import android.net.RouteInfo;
import android.net.UidRange;
import android.os.Binder;
import android.os.IBinder;
import android.os.INetworkManagementService;
import android.os.Looper;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.security.KeyStore;
import android.util.Log;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.net.LegacyVpnInfo;
import com.android.internal.net.VpnConfig;
import com.android.internal.net.VpnProfile;
import com.android.server.net.BaseNetworkObserver;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.IOException;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicInteger;
import libcore.io.IoUtils;

public class Vpn {
    private static final boolean LOGD = true;
    private static final String NETWORKTYPE = "VPN";
    private static final String TAG = "Vpn";
    private VpnConfig mConfig;
    private final IConnectivityManager mConnService;
    private Connection mConnection;
    private Context mContext;
    private volatile boolean mEnableTeardown;
    private String mInterface;
    private LegacyVpnRunner mLegacyVpnRunner;
    private final Looper mLooper;
    private final INetworkManagementService mNetd;
    private NetworkAgent mNetworkAgent;
    private final NetworkCapabilities mNetworkCapabilities;
    private NetworkInfo mNetworkInfo;
    private INetworkManagementEventObserver mObserver;
    private int mOwnerUID;
    private String mPackage;
    private PendingIntent mStatusIntent;
    private final int mUserHandle;
    private BroadcastReceiver mUserIntentReceiver;
    @GuardedBy("this")
    private List<UidRange> mVpnUsers;

    /* renamed from: com.android.server.connectivity.Vpn.1 */
    class C01721 extends BroadcastReceiver {
        C01721() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int userHandle = intent.getIntExtra("android.intent.extra.user_handle", -10000);
            if (userHandle != -10000) {
                if ("android.intent.action.USER_ADDED".equals(action)) {
                    Vpn.this.onUserAdded(userHandle);
                } else if ("android.intent.action.USER_REMOVED".equals(action)) {
                    Vpn.this.onUserRemoved(userHandle);
                }
            }
        }
    }

    /* renamed from: com.android.server.connectivity.Vpn.2 */
    class C01732 extends NetworkAgent {
        C01732(Looper x0, Context x1, String x2, NetworkInfo x3, NetworkCapabilities x4, LinkProperties x5, int x6, NetworkMisc x7) {
            super(x0, x1, x2, x3, x4, x5, x6, x7);
        }

        public void unwanted() {
        }
    }

    /* renamed from: com.android.server.connectivity.Vpn.3 */
    class C01743 extends BaseNetworkObserver {
        C01743() {
        }

        public void interfaceStatusChanged(String interfaze, boolean up) {
            synchronized (Vpn.this) {
                if (!up) {
                    if (Vpn.this.mLegacyVpnRunner != null) {
                        Vpn.this.mLegacyVpnRunner.check(interfaze);
                    }
                }
            }
        }

        public void interfaceRemoved(String interfaze) {
            synchronized (Vpn.this) {
                if (interfaze.equals(Vpn.this.mInterface) && Vpn.this.jniCheck(interfaze) == 0) {
                    Vpn.this.mStatusIntent = null;
                    Vpn.this.mVpnUsers = null;
                    Vpn.this.mInterface = null;
                    if (Vpn.this.mConnection != null) {
                        Vpn.this.mContext.unbindService(Vpn.this.mConnection);
                        Vpn.this.mConnection = null;
                        Vpn.this.agentDisconnect();
                    } else if (Vpn.this.mLegacyVpnRunner != null) {
                        Vpn.this.mLegacyVpnRunner.exit();
                        Vpn.this.mLegacyVpnRunner = null;
                    }
                }
            }
        }
    }

    private class Connection implements ServiceConnection {
        private IBinder mService;

        private Connection() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            this.mService = service;
        }

        public void onServiceDisconnected(ComponentName name) {
            this.mService = null;
        }
    }

    private class LegacyVpnRunner extends Thread {
        private static final String TAG = "LegacyVpnRunner";
        private final String[][] mArguments;
        private final BroadcastReceiver mBroadcastReceiver;
        private final String[] mDaemons;
        private final AtomicInteger mOuterConnection;
        private final String mOuterInterface;
        private final LocalSocket[] mSockets;
        private long mTimer;

        /* renamed from: com.android.server.connectivity.Vpn.LegacyVpnRunner.1 */
        class C01751 extends BroadcastReceiver {
            C01751() {
            }

            public void onReceive(Context context, Intent intent) {
                if (Vpn.this.mEnableTeardown && intent.getAction().equals("android.net.conn.CONNECTIVITY_CHANGE") && intent.getIntExtra("networkType", -1) == LegacyVpnRunner.this.mOuterConnection.get()) {
                    NetworkInfo info = (NetworkInfo) intent.getExtra("networkInfo");
                    if (info != null && !info.isConnectedOrConnecting()) {
                        try {
                            Vpn.this.mObserver.interfaceStatusChanged(LegacyVpnRunner.this.mOuterInterface, false);
                        } catch (RemoteException e) {
                        }
                    }
                }
            }
        }

        private void monitorDaemons() {
            /* JADX: method processing error */
/*
            Error: jadx.core.utils.exceptions.JadxRuntimeException: Incorrect nodes count for selectOther: B:31:0x006a in [B:21:0x0062, B:31:0x006a, B:30:0x0055, B:29:0x0036]
	at jadx.core.utils.BlockUtils.selectOther(BlockUtils.java:53)
	at jadx.core.dex.instructions.IfNode.initBlocks(IfNode.java:62)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.initBlocksInIfNodes(BlockFinish.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.visit(BlockFinish.java:33)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:14)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
            /*
            r8 = this;
            r6 = com.android.server.connectivity.Vpn.this;
            r6 = r6.mNetworkInfo;
            r6 = r6.isConnected();
            if (r6 != 0) goto L_0x000d;
        L_0x000c:
            return;
        L_0x000d:
            r6 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
            java.lang.Thread.sleep(r6);	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r3 = 0;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
        L_0x0013:
            r6 = r8.mDaemons;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r6 = r6.length;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            if (r3 >= r6) goto L_0x000d;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
        L_0x0018:
            r6 = r8.mArguments;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r6 = r6[r3];	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            if (r6 == 0) goto L_0x003c;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
        L_0x001e:
            r6 = r8.mDaemons;	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r6 = r6[r3];	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r6 = android.os.SystemService.isStopped(r6);	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            if (r6 == 0) goto L_0x003c;
        L_0x0028:
            r0 = r8.mDaemons;
            r5 = r0.length;
            r4 = 0;
        L_0x002c:
            if (r4 >= r5) goto L_0x0036;
        L_0x002e:
            r1 = r0[r4];
            android.os.SystemService.stop(r1);
            r4 = r4 + 1;
            goto L_0x002c;
        L_0x0036:
            r6 = com.android.server.connectivity.Vpn.this;
            r6.agentDisconnect();
            goto L_0x000c;
        L_0x003c:
            r3 = r3 + 1;
            goto L_0x0013;
        L_0x003f:
            r2 = move-exception;
            r6 = "LegacyVpnRunner";	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r7 = "interrupted during monitorDaemons(); stopping services";	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            android.util.Log.d(r6, r7);	 Catch:{ InterruptedException -> 0x003f, all -> 0x005b }
            r0 = r8.mDaemons;
            r5 = r0.length;
            r4 = 0;
        L_0x004b:
            if (r4 >= r5) goto L_0x0055;
        L_0x004d:
            r1 = r0[r4];
            android.os.SystemService.stop(r1);
            r4 = r4 + 1;
            goto L_0x004b;
        L_0x0055:
            r6 = com.android.server.connectivity.Vpn.this;
            r6.agentDisconnect();
            goto L_0x000c;
        L_0x005b:
            r6 = move-exception;
            r0 = r8.mDaemons;
            r5 = r0.length;
            r4 = 0;
        L_0x0060:
            if (r4 >= r5) goto L_0x006a;
        L_0x0062:
            r1 = r0[r4];
            android.os.SystemService.stop(r1);
            r4 = r4 + 1;
            goto L_0x0060;
        L_0x006a:
            r7 = com.android.server.connectivity.Vpn.this;
            r7.agentDisconnect();
            throw r6;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.connectivity.Vpn.LegacyVpnRunner.monitorDaemons():void");
        }

        public LegacyVpnRunner(VpnConfig config, String[] racoon, String[] mtpd) {
            super(TAG);
            this.mOuterConnection = new AtomicInteger(-1);
            this.mTimer = -1;
            this.mBroadcastReceiver = new C01751();
            Vpn.this.mConfig = config;
            this.mDaemons = new String[]{"racoon", "mtpd"};
            this.mArguments = new String[][]{racoon, mtpd};
            this.mSockets = new LocalSocket[this.mDaemons.length];
            this.mOuterInterface = Vpn.this.mConfig.interfaze;
            try {
                this.mOuterConnection.set(Vpn.this.mConnService.findConnectionTypeForIface(this.mOuterInterface));
            } catch (Exception e) {
                this.mOuterConnection.set(-1);
            }
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
            Vpn.this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
        }

        public void check(String interfaze) {
            if (interfaze.equals(this.mOuterInterface)) {
                Log.i(TAG, "Legacy VPN is going down with " + interfaze);
                exit();
            }
        }

        public void exit() {
            interrupt();
            for (LocalSocket socket : this.mSockets) {
                IoUtils.closeQuietly(socket);
            }
            Vpn.this.agentDisconnect();
            try {
                Vpn.this.mContext.unregisterReceiver(this.mBroadcastReceiver);
            } catch (IllegalArgumentException e) {
            }
        }

        public void run() {
            Log.v(TAG, "Waiting");
            synchronized (TAG) {
                Log.v(TAG, "Executing");
                execute();
                monitorDaemons();
            }
        }

        private void checkpoint(boolean yield) throws InterruptedException {
            long j = 1;
            long now = SystemClock.elapsedRealtime();
            if (this.mTimer == -1) {
                this.mTimer = now;
                Thread.sleep(1);
            } else if (now - this.mTimer <= 60000) {
                if (yield) {
                    j = 200;
                }
                Thread.sleep(j);
            } else {
                Vpn.this.updateState(DetailedState.FAILED, "checkpoint");
                throw new IllegalStateException("Time is up");
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private void execute() {
            /*
            r28 = this;
            r17 = 0;
            r24 = 0;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r8 = r0.mDaemons;	 Catch:{ Exception -> 0x0029 }
            r0 = r8.length;	 Catch:{ Exception -> 0x0029 }
            r18 = r0;
            r15 = 0;
        L_0x0013:
            r0 = r18;
            if (r15 >= r0) goto L_0x0060;
        L_0x0017:
            r10 = r8[r15];	 Catch:{ Exception -> 0x0029 }
        L_0x0019:
            r24 = android.os.SystemService.isStopped(r10);	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x005d;
        L_0x001f:
            r24 = 1;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            goto L_0x0019;
        L_0x0029:
            r12 = move-exception;
            r24 = "LegacyVpnRunner";
            r25 = "Aborting";
            r0 = r24;
            r1 = r25;
            android.util.Log.i(r0, r1, r12);	 Catch:{ all -> 0x0078 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0078 }
            r24 = r0;
            r25 = android.net.NetworkInfo.DetailedState.FAILED;	 Catch:{ all -> 0x0078 }
            r26 = r12.getMessage();	 Catch:{ all -> 0x0078 }
            r24.updateState(r25, r26);	 Catch:{ all -> 0x0078 }
            r28.exit();	 Catch:{ all -> 0x0078 }
            if (r17 != 0) goto L_0x0529;
        L_0x0049:
            r0 = r28;
            r8 = r0.mDaemons;
            r0 = r8.length;
            r18 = r0;
            r15 = 0;
        L_0x0051:
            r0 = r18;
            if (r15 >= r0) goto L_0x0529;
        L_0x0055:
            r10 = r8[r15];
            android.os.SystemService.stop(r10);
            r15 = r15 + 1;
            goto L_0x0051;
        L_0x005d:
            r15 = r15 + 1;
            goto L_0x0013;
        L_0x0060:
            r23 = new java.io.File;	 Catch:{ Exception -> 0x0029 }
            r24 = "/data/misc/vpn/state";
            r23.<init>(r24);	 Catch:{ Exception -> 0x0029 }
            r23.delete();	 Catch:{ Exception -> 0x0029 }
            r24 = r23.exists();	 Catch:{ Exception -> 0x0029 }
            if (r24 == 0) goto L_0x008f;
        L_0x0070:
            r24 = new java.lang.IllegalStateException;	 Catch:{ Exception -> 0x0029 }
            r25 = "Cannot delete the state";
            r24.<init>(r25);	 Catch:{ Exception -> 0x0029 }
            throw r24;	 Catch:{ Exception -> 0x0029 }
        L_0x0078:
            r24 = move-exception;
            if (r17 != 0) goto L_0x054c;
        L_0x007b:
            r0 = r28;
            r8 = r0.mDaemons;
            r0 = r8.length;
            r18 = r0;
            r15 = 0;
        L_0x0083:
            r0 = r18;
            if (r15 >= r0) goto L_0x054c;
        L_0x0087:
            r10 = r8[r15];
            android.os.SystemService.stop(r10);
            r15 = r15 + 1;
            goto L_0x0083;
        L_0x008f:
            r24 = new java.io.File;	 Catch:{ Exception -> 0x0029 }
            r25 = "/data/misc/vpn/abort";
            r24.<init>(r25);	 Catch:{ Exception -> 0x0029 }
            r24.delete();	 Catch:{ Exception -> 0x0029 }
            r17 = 1;
            r21 = 0;
            r0 = r28;
            r8 = r0.mArguments;	 Catch:{ Exception -> 0x0029 }
            r0 = r8.length;	 Catch:{ Exception -> 0x0029 }
            r18 = r0;
            r15 = 0;
        L_0x00a5:
            r0 = r18;
            if (r15 >= r0) goto L_0x00b7;
        L_0x00a9:
            r7 = r8[r15];	 Catch:{ Exception -> 0x0029 }
            if (r21 != 0) goto L_0x00af;
        L_0x00ad:
            if (r7 == 0) goto L_0x00b4;
        L_0x00af:
            r21 = 1;
        L_0x00b1:
            r15 = r15 + 1;
            goto L_0x00a5;
        L_0x00b4:
            r21 = 0;
            goto L_0x00b1;
        L_0x00b7:
            if (r21 != 0) goto L_0x00fa;
        L_0x00b9:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24.agentDisconnect();	 Catch:{ Exception -> 0x0029 }
            if (r17 != 0) goto L_0x00d8;
        L_0x00c4:
            r0 = r28;
            r8 = r0.mDaemons;
            r0 = r8.length;
            r18 = r0;
            r15 = 0;
        L_0x00cc:
            r0 = r18;
            if (r15 >= r0) goto L_0x00d8;
        L_0x00d0:
            r10 = r8[r15];
            android.os.SystemService.stop(r10);
            r15 = r15 + 1;
            goto L_0x00cc;
        L_0x00d8:
            if (r17 == 0) goto L_0x00f0;
        L_0x00da:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24 = r24.mNetworkInfo;
            r24 = r24.getDetailedState();
            r25 = android.net.NetworkInfo.DetailedState.CONNECTING;
            r0 = r24;
            r1 = r25;
            if (r0 != r1) goto L_0x00f9;
        L_0x00f0:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24.agentDisconnect();
        L_0x00f9:
            return;
        L_0x00fa:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r25 = android.net.NetworkInfo.DetailedState.CONNECTING;	 Catch:{ Exception -> 0x0029 }
            r26 = "execute";
            r24.updateState(r25, r26);	 Catch:{ Exception -> 0x0029 }
            r14 = 0;
        L_0x0108:
            r0 = r28;
            r0 = r0.mDaemons;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r0 = r24;
            r0 = r0.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r0 = r24;
            if (r14 >= r0) goto L_0x0214;
        L_0x0117:
            r0 = r28;
            r0 = r0.mArguments;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r7 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            if (r7 != 0) goto L_0x0124;
        L_0x0121:
            r14 = r14 + 1;
            goto L_0x0108;
        L_0x0124:
            r0 = r28;
            r0 = r0.mDaemons;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r10 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            android.os.SystemService.start(r10);	 Catch:{ Exception -> 0x0029 }
        L_0x012f:
            r24 = android.os.SystemService.isRunning(r10);	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x013f;
        L_0x0135:
            r24 = 1;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            goto L_0x012f;
        L_0x013f:
            r0 = r28;
            r0 = r0.mSockets;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r25 = new android.net.LocalSocket;	 Catch:{ Exception -> 0x0029 }
            r25.<init>();	 Catch:{ Exception -> 0x0029 }
            r24[r14] = r25;	 Catch:{ Exception -> 0x0029 }
            r5 = new android.net.LocalSocketAddress;	 Catch:{ Exception -> 0x0029 }
            r24 = android.net.LocalSocketAddress.Namespace.RESERVED;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r5.<init>(r10, r0);	 Catch:{ Exception -> 0x0029 }
        L_0x0155:
            r0 = r28;
            r0 = r0.mSockets;	 Catch:{ Exception -> 0x01a2 }
            r24 = r0;
            r24 = r24[r14];	 Catch:{ Exception -> 0x01a2 }
            r0 = r24;
            r0.connect(r5);	 Catch:{ Exception -> 0x01a2 }
            r0 = r28;
            r0 = r0.mSockets;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            r25 = 500; // 0x1f4 float:7.0E-43 double:2.47E-321;
            r24.setSoTimeout(r25);	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = r0.mSockets;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            r19 = r24.getOutputStream();	 Catch:{ Exception -> 0x0029 }
            r8 = r7;
            r0 = r8.length;	 Catch:{ Exception -> 0x0029 }
            r18 = r0;
            r15 = 0;
        L_0x0180:
            r0 = r18;
            if (r15 >= r0) goto L_0x01d4;
        L_0x0184:
            r6 = r8[r15];	 Catch:{ Exception -> 0x0029 }
            r24 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r9 = r6.getBytes(r0);	 Catch:{ Exception -> 0x0029 }
            r0 = r9.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r25 = 65535; // 0xffff float:9.1834E-41 double:3.23786E-319;
            r0 = r24;
            r1 = r25;
            if (r0 < r1) goto L_0x01ad;
        L_0x019a:
            r24 = new java.lang.IllegalArgumentException;	 Catch:{ Exception -> 0x0029 }
            r25 = "Argument is too large";
            r24.<init>(r25);	 Catch:{ Exception -> 0x0029 }
            throw r24;	 Catch:{ Exception -> 0x0029 }
        L_0x01a2:
            r24 = move-exception;
            r24 = 1;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            goto L_0x0155;
        L_0x01ad:
            r0 = r9.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24 >> 8;
            r0 = r19;
            r1 = r24;
            r0.write(r1);	 Catch:{ Exception -> 0x0029 }
            r0 = r9.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r0 = r19;
            r1 = r24;
            r0.write(r1);	 Catch:{ Exception -> 0x0029 }
            r0 = r19;
            r0.write(r9);	 Catch:{ Exception -> 0x0029 }
            r24 = 0;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            r15 = r15 + 1;
            goto L_0x0180;
        L_0x01d4:
            r24 = 255; // 0xff float:3.57E-43 double:1.26E-321;
            r0 = r19;
            r1 = r24;
            r0.write(r1);	 Catch:{ Exception -> 0x0029 }
            r24 = 255; // 0xff float:3.57E-43 double:1.26E-321;
            r0 = r19;
            r1 = r24;
            r0.write(r1);	 Catch:{ Exception -> 0x0029 }
            r19.flush();	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = r0.mSockets;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            r16 = r24.getInputStream();	 Catch:{ Exception -> 0x0029 }
        L_0x01f5:
            r24 = r16.read();	 Catch:{ Exception -> 0x056e }
            r25 = -1;
            r0 = r24;
            r1 = r25;
            if (r0 == r1) goto L_0x0121;
        L_0x0201:
            r24 = 1;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
            goto L_0x01f5;
        L_0x020b:
            r24 = 1;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ Exception -> 0x0029 }
        L_0x0214:
            r24 = r23.exists();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x0260;
        L_0x021a:
            r14 = 0;
        L_0x021b:
            r0 = r28;
            r0 = r0.mDaemons;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r0 = r24;
            r0 = r0.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r0 = r24;
            if (r14 >= r0) goto L_0x020b;
        L_0x022a:
            r0 = r28;
            r0 = r0.mDaemons;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r10 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = r0.mArguments;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24[r14];	 Catch:{ Exception -> 0x0029 }
            if (r24 == 0) goto L_0x025d;
        L_0x023c:
            r24 = android.os.SystemService.isRunning(r10);	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x025d;
        L_0x0242:
            r24 = new java.lang.IllegalStateException;	 Catch:{ Exception -> 0x0029 }
            r25 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x0029 }
            r25.<init>();	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r25 = r0.append(r10);	 Catch:{ Exception -> 0x0029 }
            r26 = " is dead";
            r25 = r25.append(r26);	 Catch:{ Exception -> 0x0029 }
            r25 = r25.toString();	 Catch:{ Exception -> 0x0029 }
            r24.<init>(r25);	 Catch:{ Exception -> 0x0029 }
            throw r24;	 Catch:{ Exception -> 0x0029 }
        L_0x025d:
            r14 = r14 + 1;
            goto L_0x021b;
        L_0x0260:
            r24 = 0;
            r25 = 0;
            r24 = android.os.FileUtils.readTextFile(r23, r24, r25);	 Catch:{ Exception -> 0x0029 }
            r25 = "\n";
            r26 = -1;
            r20 = r24.split(r25, r26);	 Catch:{ Exception -> 0x0029 }
            r0 = r20;
            r0 = r0.length;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r25 = 7;
            r0 = r24;
            r1 = r25;
            if (r0 == r1) goto L_0x0285;
        L_0x027d:
            r24 = new java.lang.IllegalStateException;	 Catch:{ Exception -> 0x0029 }
            r25 = "Cannot parse the state";
            r24.<init>(r25);	 Catch:{ Exception -> 0x0029 }
            throw r24;	 Catch:{ Exception -> 0x0029 }
        L_0x0285:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r25 = 0;
            r25 = r20[r25];	 Catch:{ Exception -> 0x0029 }
            r25 = r25.trim();	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r1 = r24;
            r1.interfaze = r0;	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r25 = 1;
            r25 = r20[r25];	 Catch:{ Exception -> 0x0029 }
            r24.addLegacyAddresses(r25);	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.routes;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            if (r24 == 0) goto L_0x02d6;
        L_0x02c0:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.routes;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.isEmpty();	 Catch:{ Exception -> 0x0029 }
            if (r24 == 0) goto L_0x02e7;
        L_0x02d6:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r25 = 2;
            r25 = r20[r25];	 Catch:{ Exception -> 0x0029 }
            r24.addLegacyRoutes(r25);	 Catch:{ Exception -> 0x0029 }
        L_0x02e7:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.dnsServers;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            if (r24 == 0) goto L_0x030f;
        L_0x02f9:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.dnsServers;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.size();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x0339;
        L_0x030f:
            r24 = 3;
            r24 = r20[r24];	 Catch:{ Exception -> 0x0029 }
            r11 = r24.trim();	 Catch:{ Exception -> 0x0029 }
            r24 = r11.isEmpty();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x0339;
        L_0x031d:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r25 = " ";
            r0 = r25;
            r25 = r11.split(r0);	 Catch:{ Exception -> 0x0029 }
            r25 = java.util.Arrays.asList(r25);	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r1 = r24;
            r1.dnsServers = r0;	 Catch:{ Exception -> 0x0029 }
        L_0x0339:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.searchDomains;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            if (r24 == 0) goto L_0x0361;
        L_0x034b:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r0 = r24;
            r0 = r0.searchDomains;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.size();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x038d;
        L_0x0361:
            r24 = 4;
            r24 = r20[r24];	 Catch:{ Exception -> 0x0029 }
            r22 = r24.trim();	 Catch:{ Exception -> 0x0029 }
            r24 = r22.isEmpty();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x038d;
        L_0x036f:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ Exception -> 0x0029 }
            r25 = " ";
            r0 = r22;
            r1 = r25;
            r25 = r0.split(r1);	 Catch:{ Exception -> 0x0029 }
            r25 = java.util.Arrays.asList(r25);	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r1 = r24;
            r1.searchDomains = r0;	 Catch:{ Exception -> 0x0029 }
        L_0x038d:
            r24 = 5;
            r13 = r20[r24];	 Catch:{ Exception -> 0x0029 }
            r24 = r13.isEmpty();	 Catch:{ Exception -> 0x0029 }
            if (r24 != 0) goto L_0x03c6;
        L_0x0397:
            r4 = java.net.InetAddress.parseNumericAddress(r13);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r0 = r4 instanceof java.net.Inet4Address;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            if (r24 == 0) goto L_0x043a;
        L_0x03a1:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r0 = r24;
            r0 = r0.routes;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            r25 = new android.net.RouteInfo;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r26 = new android.net.IpPrefix;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r27 = 32;
            r0 = r26;
            r1 = r27;
            r0.<init>(r4, r1);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r27 = 9;
            r25.<init>(r26, r27);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24.add(r25);	 Catch:{ IllegalArgumentException -> 0x0467 }
        L_0x03c6:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ Exception -> 0x0029 }
            r25 = r0;
            monitor-enter(r25);	 Catch:{ Exception -> 0x0029 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ all -> 0x0437 }
            r26 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0437 }
            r0 = r26;
            r2 = r24;
            r2.startTime = r0;	 Catch:{ all -> 0x0437 }
            r24 = 0;
            r0 = r28;
            r1 = r24;
            r0.checkpoint(r1);	 Catch:{ all -> 0x0437 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r24 = r0;
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r26 = r0;
            r26 = r26.mConfig;	 Catch:{ all -> 0x0437 }
            r0 = r26;
            r0 = r0.interfaze;	 Catch:{ all -> 0x0437 }
            r26 = r0;
            r0 = r24;
            r1 = r26;
            r24 = r0.jniCheck(r1);	 Catch:{ all -> 0x0437 }
            if (r24 != 0) goto L_0x04ac;
        L_0x040a:
            r24 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x0437 }
            r26 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0437 }
            r26.<init>();	 Catch:{ all -> 0x0437 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r27 = r0;
            r27 = r27.mConfig;	 Catch:{ all -> 0x0437 }
            r0 = r27;
            r0 = r0.interfaze;	 Catch:{ all -> 0x0437 }
            r27 = r0;
            r26 = r26.append(r27);	 Catch:{ all -> 0x0437 }
            r27 = " is gone";
            r26 = r26.append(r27);	 Catch:{ all -> 0x0437 }
            r26 = r26.toString();	 Catch:{ all -> 0x0437 }
            r0 = r24;
            r1 = r26;
            r0.<init>(r1);	 Catch:{ all -> 0x0437 }
            throw r24;	 Catch:{ all -> 0x0437 }
        L_0x0437:
            r24 = move-exception;
            monitor-exit(r25);	 Catch:{ all -> 0x0437 }
            throw r24;	 Catch:{ Exception -> 0x0029 }
        L_0x043a:
            r0 = r4 instanceof java.net.Inet6Address;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            if (r24 == 0) goto L_0x0490;
        L_0x0440:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            r24 = r24.mConfig;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r0 = r24;
            r0 = r0.routes;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24 = r0;
            r25 = new android.net.RouteInfo;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r26 = new android.net.IpPrefix;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r27 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
            r0 = r26;
            r1 = r27;
            r0.<init>(r4, r1);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r27 = 9;
            r25.<init>(r26, r27);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r24.add(r25);	 Catch:{ IllegalArgumentException -> 0x0467 }
            goto L_0x03c6;
        L_0x0467:
            r12 = move-exception;
            r24 = "LegacyVpnRunner";
            r25 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x0029 }
            r25.<init>();	 Catch:{ Exception -> 0x0029 }
            r26 = "Exception constructing throw route to ";
            r25 = r25.append(r26);	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r25 = r0.append(r13);	 Catch:{ Exception -> 0x0029 }
            r26 = ": ";
            r25 = r25.append(r26);	 Catch:{ Exception -> 0x0029 }
            r0 = r25;
            r25 = r0.append(r12);	 Catch:{ Exception -> 0x0029 }
            r25 = r25.toString();	 Catch:{ Exception -> 0x0029 }
            android.util.Log.e(r24, r25);	 Catch:{ Exception -> 0x0029 }
            goto L_0x03c6;
        L_0x0490:
            r24 = "LegacyVpnRunner";
            r25 = new java.lang.StringBuilder;	 Catch:{ IllegalArgumentException -> 0x0467 }
            r25.<init>();	 Catch:{ IllegalArgumentException -> 0x0467 }
            r26 = "Unknown IP address family for VPN endpoint: ";
            r25 = r25.append(r26);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r0 = r25;
            r25 = r0.append(r13);	 Catch:{ IllegalArgumentException -> 0x0467 }
            r25 = r25.toString();	 Catch:{ IllegalArgumentException -> 0x0467 }
            android.util.Log.e(r24, r25);	 Catch:{ IllegalArgumentException -> 0x0467 }
            goto L_0x03c6;
        L_0x04ac:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r24 = r0;
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r26 = r0;
            r26 = r26.mConfig;	 Catch:{ all -> 0x0437 }
            r0 = r26;
            r0 = r0.interfaze;	 Catch:{ all -> 0x0437 }
            r26 = r0;
            r0 = r24;
            r1 = r26;
            r0.mInterface = r1;	 Catch:{ all -> 0x0437 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r24 = r0;
            r26 = new java.util.ArrayList;	 Catch:{ all -> 0x0437 }
            r26.<init>();	 Catch:{ all -> 0x0437 }
            r0 = r24;
            r1 = r26;
            r0.mVpnUsers = r1;	 Catch:{ all -> 0x0437 }
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;	 Catch:{ all -> 0x0437 }
            r24 = r0;
            r24.agentConnect();	 Catch:{ all -> 0x0437 }
            r24 = "LegacyVpnRunner";
            r26 = "Connected!";
            r0 = r24;
            r1 = r26;
            android.util.Log.i(r0, r1);	 Catch:{ all -> 0x0437 }
            monitor-exit(r25);	 Catch:{ all -> 0x0437 }
            if (r17 != 0) goto L_0x0506;
        L_0x04f2:
            r0 = r28;
            r8 = r0.mDaemons;
            r0 = r8.length;
            r18 = r0;
            r15 = 0;
        L_0x04fa:
            r0 = r18;
            if (r15 >= r0) goto L_0x0506;
        L_0x04fe:
            r10 = r8[r15];
            android.os.SystemService.stop(r10);
            r15 = r15 + 1;
            goto L_0x04fa;
        L_0x0506:
            if (r17 == 0) goto L_0x051e;
        L_0x0508:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24 = r24.mNetworkInfo;
            r24 = r24.getDetailedState();
            r25 = android.net.NetworkInfo.DetailedState.CONNECTING;
            r0 = r24;
            r1 = r25;
            if (r0 != r1) goto L_0x00f9;
        L_0x051e:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24.agentDisconnect();
            goto L_0x00f9;
        L_0x0529:
            if (r17 == 0) goto L_0x0541;
        L_0x052b:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24 = r24.mNetworkInfo;
            r24 = r24.getDetailedState();
            r25 = android.net.NetworkInfo.DetailedState.CONNECTING;
            r0 = r24;
            r1 = r25;
            if (r0 != r1) goto L_0x00f9;
        L_0x0541:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r24 = r0;
            r24.agentDisconnect();
            goto L_0x00f9;
        L_0x054c:
            if (r17 == 0) goto L_0x0564;
        L_0x054e:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r25 = r0;
            r25 = r25.mNetworkInfo;
            r25 = r25.getDetailedState();
            r26 = android.net.NetworkInfo.DetailedState.CONNECTING;
            r0 = r25;
            r1 = r26;
            if (r0 != r1) goto L_0x056d;
        L_0x0564:
            r0 = r28;
            r0 = com.android.server.connectivity.Vpn.this;
            r25 = r0;
            r25.agentDisconnect();
        L_0x056d:
            throw r24;
        L_0x056e:
            r24 = move-exception;
            goto L_0x0201;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.connectivity.Vpn.LegacyVpnRunner.execute():void");
        }
    }

    private native boolean jniAddAddress(String str, String str2, int i);

    private native int jniCheck(String str);

    private native int jniCreate(int i);

    private native boolean jniDelAddress(String str, String str2, int i);

    private native String jniGetName(int i);

    private native void jniReset(String str);

    private native int jniSetAddresses(String str, String str2);

    public Vpn(Looper looper, Context context, INetworkManagementService netService, IConnectivityManager connService, int userHandle) {
        this.mEnableTeardown = LOGD;
        this.mVpnUsers = null;
        this.mUserIntentReceiver = null;
        this.mObserver = new C01743();
        this.mContext = context;
        this.mNetd = netService;
        this.mConnService = connService;
        this.mUserHandle = userHandle;
        this.mLooper = looper;
        this.mPackage = "[Legacy VPN]";
        this.mOwnerUID = getAppUid(this.mPackage, this.mUserHandle);
        try {
            netService.registerObserver(this.mObserver);
        } catch (RemoteException e) {
            Log.wtf(TAG, "Problem registering observer", e);
        }
        if (userHandle == 0) {
            this.mUserIntentReceiver = new C01721();
            IntentFilter intentFilter = new IntentFilter();
            intentFilter.addAction("android.intent.action.USER_ADDED");
            intentFilter.addAction("android.intent.action.USER_REMOVED");
            this.mContext.registerReceiverAsUser(this.mUserIntentReceiver, UserHandle.ALL, intentFilter, null, null);
        }
        this.mNetworkInfo = new NetworkInfo(17, 0, NETWORKTYPE, "");
        this.mNetworkCapabilities = new NetworkCapabilities();
        this.mNetworkCapabilities.addTransportType(4);
        this.mNetworkCapabilities.removeCapability(15);
    }

    public void setEnableTeardown(boolean enableTeardown) {
        this.mEnableTeardown = enableTeardown;
    }

    private void updateState(DetailedState detailedState, String reason) {
        Log.d(TAG, "setting state=" + detailedState + ", reason=" + reason);
        this.mNetworkInfo.setDetailedState(detailedState, reason, null);
        if (this.mNetworkAgent != null) {
            this.mNetworkAgent.sendNetworkInfo(this.mNetworkInfo);
        }
    }

    public synchronized boolean prepare(String oldPackage, String newPackage) {
        boolean z = LOGD;
        synchronized (this) {
            if (oldPackage != null) {
                if (getAppUid(oldPackage, this.mUserHandle) != this.mOwnerUID) {
                    if (oldPackage.equals("[Legacy VPN]") || !isVpnUserPreConsented(oldPackage)) {
                        z = false;
                    } else {
                        prepareInternal(oldPackage);
                    }
                }
            }
            if (newPackage != null) {
                if (newPackage.equals("[Legacy VPN]") || getAppUid(newPackage, this.mUserHandle) != this.mOwnerUID) {
                    enforceControlPermission();
                    prepareInternal(newPackage);
                }
            }
        }
        return z;
    }

    private void prepareInternal(String newPackage) {
        long token = Binder.clearCallingIdentity();
        if (this.mInterface != null) {
            this.mStatusIntent = null;
            agentDisconnect();
            jniReset(this.mInterface);
            this.mInterface = null;
            this.mVpnUsers = null;
        }
        if (this.mConnection != null) {
            try {
                this.mConnection.mService.transact(16777215, Parcel.obtain(), null, 1);
            } catch (Exception e) {
            }
            try {
                this.mContext.unbindService(this.mConnection);
                this.mConnection = null;
            } catch (Exception e2) {
                Log.wtf(TAG, "Failed to disallow UID " + this.mOwnerUID + " to call protect() " + e2);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(token);
            }
        } else if (this.mLegacyVpnRunner != null) {
            this.mLegacyVpnRunner.exit();
            this.mLegacyVpnRunner = null;
        }
        this.mNetd.denyProtect(this.mOwnerUID);
        Log.i(TAG, "Switched from " + this.mPackage + " to " + newPackage);
        this.mPackage = newPackage;
        this.mOwnerUID = getAppUid(newPackage, this.mUserHandle);
        try {
            this.mNetd.allowProtect(this.mOwnerUID);
        } catch (Exception e22) {
            Log.wtf(TAG, "Failed to allow UID " + this.mOwnerUID + " to call protect() " + e22);
        }
        this.mConfig = null;
        updateState(DetailedState.IDLE, "prepare");
        Binder.restoreCallingIdentity(token);
    }

    public void setPackageAuthorization(boolean authorized) {
        enforceControlPermission();
        if (this.mPackage != null && !"[Legacy VPN]".equals(this.mPackage)) {
            long token = Binder.clearCallingIdentity();
            try {
                ((AppOpsManager) this.mContext.getSystemService("appops")).setMode(47, this.mOwnerUID, this.mPackage, authorized ? 0 : 1);
            } catch (Exception e) {
                Log.wtf(TAG, "Failed to set app ops for package " + this.mPackage, e);
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }
    }

    private boolean isVpnUserPreConsented(String packageName) {
        return ((AppOpsManager) this.mContext.getSystemService("appops")).noteOpNoThrow(47, Binder.getCallingUid(), packageName) == 0 ? LOGD : false;
    }

    private int getAppUid(String app, int userHandle) {
        if ("[Legacy VPN]".equals(app)) {
            return Process.myUid();
        }
        try {
            return this.mContext.getPackageManager().getPackageUid(app, userHandle);
        } catch (NameNotFoundException e) {
            return -1;
        }
    }

    public NetworkInfo getNetworkInfo() {
        return this.mNetworkInfo;
    }

    private LinkProperties makeLinkProperties() {
        boolean allowIPv4 = this.mConfig.allowIPv4;
        boolean allowIPv6 = this.mConfig.allowIPv6;
        LinkProperties lp = new LinkProperties();
        lp.setInterfaceName(this.mInterface);
        if (this.mConfig.addresses != null) {
            for (LinkAddress address : this.mConfig.addresses) {
                lp.addLinkAddress(address);
                allowIPv4 |= address.getAddress() instanceof Inet4Address;
                allowIPv6 |= address.getAddress() instanceof Inet6Address;
            }
        }
        if (this.mConfig.routes != null) {
            for (RouteInfo route : this.mConfig.routes) {
                lp.addRoute(route);
                InetAddress address2 = route.getDestination().getAddress();
                allowIPv4 |= address2 instanceof Inet4Address;
                allowIPv6 |= address2 instanceof Inet6Address;
            }
        }
        if (this.mConfig.dnsServers != null) {
            for (String dnsServer : this.mConfig.dnsServers) {
                address2 = InetAddress.parseNumericAddress(dnsServer);
                lp.addDnsServer(address2);
                allowIPv4 |= address2 instanceof Inet4Address;
                allowIPv6 |= address2 instanceof Inet6Address;
            }
        }
        if (!allowIPv4) {
            lp.addRoute(new RouteInfo(new IpPrefix(Inet4Address.ANY, 0), 7));
        }
        if (!allowIPv6) {
            lp.addRoute(new RouteInfo(new IpPrefix(Inet6Address.ANY, 0), 7));
        }
        StringBuilder buffer = new StringBuilder();
        if (this.mConfig.searchDomains != null) {
            for (String domain : this.mConfig.searchDomains) {
                buffer.append(domain).append(' ');
            }
        }
        lp.setDomains(buffer.toString().trim());
        return lp;
    }

    private void agentConnect() {
        LinkProperties lp = makeLinkProperties();
        if (lp.hasIPv4DefaultRoute() || lp.hasIPv6DefaultRoute()) {
            this.mNetworkCapabilities.addCapability(12);
        } else {
            this.mNetworkCapabilities.removeCapability(12);
        }
        this.mNetworkInfo.setIsAvailable(LOGD);
        this.mNetworkInfo.setDetailedState(DetailedState.CONNECTED, null, null);
        NetworkMisc networkMisc = new NetworkMisc();
        networkMisc.allowBypass = this.mConfig.allowBypass;
        long token = Binder.clearCallingIdentity();
        try {
            this.mNetworkAgent = new C01732(this.mLooper, this.mContext, NETWORKTYPE, this.mNetworkInfo, this.mNetworkCapabilities, lp, 0, networkMisc);
            addVpnUserLocked(this.mUserHandle);
            if (this.mUserHandle == 0) {
                token = Binder.clearCallingIdentity();
                try {
                    List<UserInfo> users = UserManager.get(this.mContext).getUsers();
                    for (UserInfo user : users) {
                        if (user.isRestricted()) {
                            addVpnUserLocked(user.id);
                        }
                    }
                } finally {
                    Binder.restoreCallingIdentity(token);
                }
            }
            this.mNetworkAgent.addUidRanges((UidRange[]) this.mVpnUsers.toArray(new UidRange[this.mVpnUsers.size()]));
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    private void agentDisconnect(NetworkInfo networkInfo, NetworkAgent networkAgent) {
        networkInfo.setIsAvailable(false);
        networkInfo.setDetailedState(DetailedState.DISCONNECTED, null, null);
        if (networkAgent != null) {
            networkAgent.sendNetworkInfo(networkInfo);
        }
    }

    private void agentDisconnect(NetworkAgent networkAgent) {
        agentDisconnect(new NetworkInfo(this.mNetworkInfo), networkAgent);
    }

    private void agentDisconnect() {
        if (this.mNetworkInfo.isConnected()) {
            agentDisconnect(this.mNetworkInfo, this.mNetworkAgent);
            this.mNetworkAgent = null;
        }
    }

    public synchronized ParcelFileDescriptor establish(VpnConfig config) {
        ParcelFileDescriptor parcelFileDescriptor;
        UserManager mgr = UserManager.get(this.mContext);
        if (Binder.getCallingUid() != this.mOwnerUID) {
            parcelFileDescriptor = null;
        } else {
            Intent intent = new Intent("android.net.VpnService");
            intent.setClassName(this.mPackage, config.user);
            long token = Binder.clearCallingIdentity();
            try {
                if (!mgr.getUserInfo(this.mUserHandle).isRestricted()) {
                    if (!mgr.hasUserRestriction("no_config_vpn")) {
                        ResolveInfo info = AppGlobals.getPackageManager().resolveService(intent, null, 0, this.mUserHandle);
                        if (info == null) {
                            throw new SecurityException("Cannot find " + config.user);
                        }
                        if ("android.permission.BIND_VPN_SERVICE".equals(info.serviceInfo.permission)) {
                            Binder.restoreCallingIdentity(token);
                            VpnConfig oldConfig = this.mConfig;
                            String oldInterface = this.mInterface;
                            Connection oldConnection = this.mConnection;
                            NetworkAgent oldNetworkAgent = this.mNetworkAgent;
                            this.mNetworkAgent = null;
                            List<UidRange> oldUsers = this.mVpnUsers;
                            parcelFileDescriptor = ParcelFileDescriptor.adoptFd(jniCreate(config.mtu));
                            try {
                                updateState(DetailedState.CONNECTING, "establish");
                                String interfaze = jniGetName(parcelFileDescriptor.getFd());
                                StringBuilder builder = new StringBuilder();
                                for (LinkAddress address : config.addresses) {
                                    builder.append(" " + address);
                                }
                                if (jniSetAddresses(interfaze, builder.toString()) < 1) {
                                    throw new IllegalArgumentException("At least one address must be specified");
                                }
                                Connection connection = new Connection(null);
                                if (this.mContext.bindServiceAsUser(intent, connection, 1, new UserHandle(this.mUserHandle))) {
                                    this.mConnection = connection;
                                    this.mInterface = interfaze;
                                    config.user = this.mPackage;
                                    config.interfaze = this.mInterface;
                                    config.startTime = SystemClock.elapsedRealtime();
                                    this.mConfig = config;
                                    this.mVpnUsers = new ArrayList();
                                    agentConnect();
                                    if (oldConnection != null) {
                                        this.mContext.unbindService(oldConnection);
                                    }
                                    agentDisconnect(oldNetworkAgent);
                                    if (!(oldInterface == null || oldInterface.equals(interfaze))) {
                                        jniReset(oldInterface);
                                    }
                                    IoUtils.setBlocking(parcelFileDescriptor.getFileDescriptor(), config.blocking);
                                    String str = config.user;
                                    Log.i(TAG, "Established by " + r0 + " on " + this.mInterface);
                                } else {
                                    throw new IllegalStateException("Cannot bind " + config.user);
                                }
                            } catch (IOException e) {
                                throw new IllegalStateException("Cannot set tunnel's fd as blocking=" + config.blocking, e);
                            } catch (RuntimeException e2) {
                                IoUtils.closeQuietly(parcelFileDescriptor);
                                agentDisconnect();
                                this.mConfig = oldConfig;
                                this.mConnection = oldConnection;
                                this.mVpnUsers = oldUsers;
                                this.mNetworkAgent = oldNetworkAgent;
                                this.mInterface = oldInterface;
                                throw e2;
                            }
                        }
                        throw new SecurityException(config.user + " does not require " + "android.permission.BIND_VPN_SERVICE");
                    }
                }
                throw new SecurityException("Restricted users cannot establish VPNs");
            } catch (RemoteException e3) {
                throw new SecurityException("Cannot find " + config.user);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(token);
            }
        }
        return parcelFileDescriptor;
    }

    private boolean isRunningLocked() {
        return (this.mNetworkAgent == null || this.mInterface == null) ? false : LOGD;
    }

    private boolean isCallerEstablishedOwnerLocked() {
        return (isRunningLocked() && Binder.getCallingUid() == this.mOwnerUID) ? LOGD : false;
    }

    private SortedSet<Integer> getAppsUids(List<String> packageNames, int userHandle) {
        SortedSet<Integer> uids = new TreeSet();
        for (String app : packageNames) {
            int uid = getAppUid(app, userHandle);
            if (uid != -1) {
                uids.add(Integer.valueOf(uid));
            }
        }
        return uids;
    }

    private void addVpnUserLocked(int userHandle) {
        if (this.mVpnUsers == null) {
            throw new IllegalStateException("VPN is not active");
        }
        int start;
        int uid;
        if (this.mConfig.allowedApplications != null) {
            start = -1;
            int stop = -1;
            for (Integer intValue : getAppsUids(this.mConfig.allowedApplications, userHandle)) {
                uid = intValue.intValue();
                if (start == -1) {
                    start = uid;
                } else if (uid != stop + 1) {
                    this.mVpnUsers.add(new UidRange(start, stop));
                    start = uid;
                }
                stop = uid;
            }
            if (start != -1) {
                this.mVpnUsers.add(new UidRange(start, stop));
            }
        } else if (this.mConfig.disallowedApplications != null) {
            UidRange userRange = UidRange.createForUser(userHandle);
            start = userRange.start;
            for (Integer intValue2 : getAppsUids(this.mConfig.disallowedApplications, userHandle)) {
                uid = intValue2.intValue();
                if (uid == start) {
                    start++;
                } else {
                    this.mVpnUsers.add(new UidRange(start, uid - 1));
                    start = uid + 1;
                }
            }
            if (start <= userRange.stop) {
                this.mVpnUsers.add(new UidRange(start, userRange.stop));
            }
        } else {
            this.mVpnUsers.add(UidRange.createForUser(userHandle));
        }
        prepareStatusIntent();
    }

    private List<UidRange> uidRangesForUser(int userHandle) {
        UidRange userRange = UidRange.createForUser(userHandle);
        List<UidRange> ranges = new ArrayList();
        for (UidRange range : this.mVpnUsers) {
            if (range.start >= userRange.start && range.stop <= userRange.stop) {
                ranges.add(range);
            }
        }
        return ranges;
    }

    private void removeVpnUserLocked(int userHandle) {
        if (this.mVpnUsers == null) {
            throw new IllegalStateException("VPN is not active");
        }
        List<UidRange> ranges = uidRangesForUser(userHandle);
        if (this.mNetworkAgent != null) {
            this.mNetworkAgent.removeUidRanges((UidRange[]) ranges.toArray(new UidRange[ranges.size()]));
        }
        this.mVpnUsers.removeAll(ranges);
        this.mStatusIntent = null;
    }

    private void onUserAdded(int userHandle) {
        synchronized (this) {
            if (UserManager.get(this.mContext).getUserInfo(userHandle).isRestricted()) {
                try {
                    addVpnUserLocked(userHandle);
                    if (this.mNetworkAgent != null) {
                        List<UidRange> ranges = uidRangesForUser(userHandle);
                        this.mNetworkAgent.addUidRanges((UidRange[]) ranges.toArray(new UidRange[ranges.size()]));
                    }
                } catch (Exception e) {
                    Log.wtf(TAG, "Failed to add restricted user to owner", e);
                }
            }
        }
    }

    private void onUserRemoved(int userHandle) {
        synchronized (this) {
            if (UserManager.get(this.mContext).getUserInfo(userHandle).isRestricted()) {
                try {
                    removeVpnUserLocked(userHandle);
                } catch (Exception e) {
                    Log.wtf(TAG, "Failed to remove restricted user to owner", e);
                }
            }
        }
    }

    public VpnConfig getVpnConfig() {
        enforceControlPermission();
        return this.mConfig;
    }

    @Deprecated
    public synchronized void interfaceStatusChanged(String iface, boolean up) {
        try {
            this.mObserver.interfaceStatusChanged(iface, up);
        } catch (RemoteException e) {
        }
    }

    private void enforceControlPermission() {
        this.mContext.enforceCallingPermission("android.permission.CONTROL_VPN", "Unauthorized Caller");
    }

    private void prepareStatusIntent() {
        long token = Binder.clearCallingIdentity();
        try {
            this.mStatusIntent = VpnConfig.getIntentForStatusPanel(this.mContext);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public synchronized boolean addAddress(String address, int prefixLength) {
        boolean success;
        if (isCallerEstablishedOwnerLocked()) {
            success = jniAddAddress(this.mInterface, address, prefixLength);
            this.mNetworkAgent.sendLinkProperties(makeLinkProperties());
        } else {
            success = false;
        }
        return success;
    }

    public synchronized boolean removeAddress(String address, int prefixLength) {
        boolean success;
        if (isCallerEstablishedOwnerLocked()) {
            success = jniDelAddress(this.mInterface, address, prefixLength);
            this.mNetworkAgent.sendLinkProperties(makeLinkProperties());
        } else {
            success = false;
        }
        return success;
    }

    public synchronized boolean setUnderlyingNetworks(Network[] networks) {
        boolean z;
        if (isCallerEstablishedOwnerLocked()) {
            if (networks == null) {
                this.mConfig.underlyingNetworks = null;
            } else {
                this.mConfig.underlyingNetworks = new Network[networks.length];
                for (int i = 0; i < networks.length; i++) {
                    if (networks[i] == null) {
                        this.mConfig.underlyingNetworks[i] = null;
                    } else {
                        this.mConfig.underlyingNetworks[i] = new Network(networks[i].netId);
                    }
                }
            }
            z = LOGD;
        } else {
            z = false;
        }
        return z;
    }

    public synchronized Network[] getUnderlyingNetworks() {
        Network[] networkArr;
        if (isRunningLocked()) {
            networkArr = this.mConfig.underlyingNetworks;
        } else {
            networkArr = null;
        }
        return networkArr;
    }

    public synchronized boolean appliesToUid(int uid) {
        boolean z = false;
        synchronized (this) {
            if (isRunningLocked()) {
                for (UidRange uidRange : this.mVpnUsers) {
                    if (uidRange.start <= uid && uid <= uidRange.stop) {
                        z = LOGD;
                        break;
                    }
                }
            }
        }
        return z;
    }

    private static RouteInfo findIPv4DefaultRoute(LinkProperties prop) {
        for (RouteInfo route : prop.getAllRoutes()) {
            if (route.isDefaultRoute() && (route.getGateway() instanceof Inet4Address)) {
                return route;
            }
        }
        throw new IllegalStateException("Unable to find IPv4 default gateway");
    }

    public void startLegacyVpn(VpnProfile profile, KeyStore keyStore, LinkProperties egress) {
        enforceControlPermission();
        long token = Binder.clearCallingIdentity();
        try {
            startLegacyVpnPrivileged(profile, keyStore, egress);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public void startLegacyVpnPrivileged(VpnProfile profile, KeyStore keyStore, LinkProperties egress) {
        if (keyStore.isUnlocked()) {
            UserManager mgr = UserManager.get(this.mContext);
            if (mgr.getUserInfo(this.mUserHandle).isRestricted() || mgr.hasUserRestriction("no_config_vpn")) {
                throw new SecurityException("Restricted users cannot establish VPNs");
            }
            byte[] value;
            RouteInfo ipv4DefaultRoute = findIPv4DefaultRoute(egress);
            String gateway = ipv4DefaultRoute.getGateway().getHostAddress();
            String iface = ipv4DefaultRoute.getInterface();
            String privateKey = "";
            String userCert = "";
            String caCert = "";
            String serverCert = "";
            if (!profile.ipsecUserCert.isEmpty()) {
                privateKey = "USRPKEY_" + profile.ipsecUserCert;
                value = keyStore.get("USRCERT_" + profile.ipsecUserCert);
                userCert = value == null ? null : new String(value, StandardCharsets.UTF_8);
            }
            if (!profile.ipsecCaCert.isEmpty()) {
                value = keyStore.get("CACERT_" + profile.ipsecCaCert);
                caCert = value == null ? null : new String(value, StandardCharsets.UTF_8);
            }
            if (!profile.ipsecServerCert.isEmpty()) {
                value = keyStore.get("USRCERT_" + profile.ipsecServerCert);
                serverCert = value == null ? null : new String(value, StandardCharsets.UTF_8);
            }
            if (privateKey == null || userCert == null || caCert == null || serverCert == null) {
                throw new IllegalStateException("Cannot load credentials");
            }
            String[] racoon = null;
            switch (profile.type) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    racoon = new String[]{iface, profile.server, "udppsk", profile.ipsecIdentifier, profile.ipsecSecret, "1701"};
                    break;
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    racoon = new String[]{iface, profile.server, "udprsa", privateKey, userCert, caCert, serverCert, "1701"};
                    break;
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    racoon = new String[]{iface, profile.server, "xauthpsk", profile.ipsecIdentifier, profile.ipsecSecret, profile.username, profile.password, "", gateway};
                    break;
                case C0569H.DO_TRAVERSAL /*4*/:
                    racoon = new String[]{iface, profile.server, "xauthrsa", privateKey, userCert, caCert, serverCert, profile.username, profile.password, "", gateway};
                    break;
                case C0569H.ADD_STARTING /*5*/:
                    racoon = new String[]{iface, profile.server, "hybridrsa", caCert, serverCert, profile.username, profile.password, "", gateway};
                    break;
            }
            String[] mtpd = null;
            switch (profile.type) {
                case AppTransition.TRANSIT_NONE /*0*/:
                    mtpd = new String[20];
                    mtpd[0] = iface;
                    mtpd[1] = "pptp";
                    mtpd[2] = profile.server;
                    mtpd[3] = "1723";
                    mtpd[4] = "name";
                    mtpd[5] = profile.username;
                    mtpd[6] = "password";
                    mtpd[7] = profile.password;
                    mtpd[8] = "linkname";
                    mtpd[9] = "vpn";
                    mtpd[10] = "refuse-eap";
                    mtpd[11] = "nodefaultroute";
                    mtpd[12] = "usepeerdns";
                    mtpd[13] = "idle";
                    mtpd[14] = "1800";
                    mtpd[15] = "mtu";
                    mtpd[16] = "1400";
                    mtpd[17] = "mru";
                    mtpd[18] = "1400";
                    mtpd[19] = profile.mppe ? "+mppe" : "nomppe";
                    break;
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    mtpd = new String[]{iface, "l2tp", profile.server, "1701", profile.l2tpSecret, "name", profile.username, "password", profile.password, "linkname", "vpn", "refuse-eap", "nodefaultroute", "usepeerdns", "idle", "1800", "mtu", "1400", "mru", "1400"};
                    break;
            }
            VpnConfig config = new VpnConfig();
            config.legacy = LOGD;
            config.user = profile.key;
            config.interfaze = iface;
            config.session = profile.name;
            config.addLegacyRoutes(profile.routes);
            if (!profile.dnsServers.isEmpty()) {
                config.dnsServers = Arrays.asList(profile.dnsServers.split(" +"));
            }
            if (!profile.searchDomains.isEmpty()) {
                config.searchDomains = Arrays.asList(profile.searchDomains.split(" +"));
            }
            startLegacyVpn(config, racoon, mtpd);
            return;
        }
        throw new IllegalStateException("KeyStore isn't unlocked");
    }

    private synchronized void startLegacyVpn(VpnConfig config, String[] racoon, String[] mtpd) {
        stopLegacyVpnPrivileged();
        prepareInternal("[Legacy VPN]");
        updateState(DetailedState.CONNECTING, "startLegacyVpn");
        this.mLegacyVpnRunner = new LegacyVpnRunner(config, racoon, mtpd);
        this.mLegacyVpnRunner.start();
    }

    public synchronized void stopLegacyVpnPrivileged() {
        if (this.mLegacyVpnRunner != null) {
            this.mLegacyVpnRunner.exit();
            this.mLegacyVpnRunner = null;
            synchronized ("LegacyVpnRunner") {
            }
        }
    }

    public synchronized LegacyVpnInfo getLegacyVpnInfo() {
        LegacyVpnInfo legacyVpnInfo;
        enforceControlPermission();
        if (this.mLegacyVpnRunner == null) {
            legacyVpnInfo = null;
        } else {
            legacyVpnInfo = new LegacyVpnInfo();
            legacyVpnInfo.key = this.mConfig.user;
            legacyVpnInfo.state = LegacyVpnInfo.stateFromNetworkInfo(this.mNetworkInfo);
            if (this.mNetworkInfo.isConnected()) {
                legacyVpnInfo.intent = this.mStatusIntent;
            }
        }
        return legacyVpnInfo;
    }

    public VpnConfig getLegacyVpnConfig() {
        if (this.mLegacyVpnRunner != null) {
            return this.mConfig;
        }
        return null;
    }
}
