package com.android.server;

import android.app.ActivityManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.os.UserHandle;
import android.telephony.CellInfo;
import android.telephony.CellLocation;
import android.telephony.DataConnectionRealTimeInfo;
import android.telephony.PreciseCallState;
import android.telephony.PreciseDataConnectionState;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.telephony.VoLteServiceState;
import android.text.TextUtils;
import android.text.format.Time;
import com.android.internal.app.IBatteryStats;
import com.android.internal.telephony.DefaultPhoneNotifier;
import com.android.internal.telephony.IOnSubscriptionsChangedListener;
import com.android.internal.telephony.IPhoneStateListener;
import com.android.internal.telephony.ITelephonyRegistry.Stub;
import com.android.server.am.BatteryStatsService;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

class TelephonyRegistry extends Stub {
    private static final boolean DBG = false;
    private static final boolean DBG_LOC = false;
    private static final int MSG_UPDATE_DEFAULT_SUB = 2;
    private static final int MSG_USER_SWITCHED = 1;
    static final int PHONE_STATE_PERMISSION_MASK = 16620;
    static final int PRECISE_PHONE_STATE_PERMISSION_MASK = 6144;
    private static final String TAG = "TelephonyRegistry";
    private static final boolean VDBG = false;
    private boolean hasNotifySubscriptionInfoChangedOccurred;
    private LogSSC[] logSSC;
    private int mBackgroundCallState;
    private final IBatteryStats mBatteryStats;
    private final BroadcastReceiver mBroadcastReceiver;
    private boolean[] mCallForwarding;
    private String[] mCallIncomingNumber;
    private int[] mCallState;
    private ArrayList<List<CellInfo>> mCellInfo;
    private Bundle[] mCellLocation;
    private ArrayList<String> mConnectedApns;
    private final Context mContext;
    private int[] mDataActivity;
    private String[] mDataConnectionApn;
    private LinkProperties[] mDataConnectionLinkProperties;
    private NetworkCapabilities[] mDataConnectionNetworkCapabilities;
    private int[] mDataConnectionNetworkType;
    private boolean[] mDataConnectionPossible;
    private String[] mDataConnectionReason;
    private int[] mDataConnectionState;
    private DataConnectionRealTimeInfo mDcRtInfo;
    private int mDefaultPhoneId;
    private int mDefaultSubId;
    private int mForegroundCallState;
    private final Handler mHandler;
    private boolean[] mMessageWaiting;
    private int mNumPhones;
    private int mOtaspMode;
    private PreciseCallState mPreciseCallState;
    private PreciseDataConnectionState mPreciseDataConnectionState;
    private final ArrayList<Record> mRecords;
    private final ArrayList<IBinder> mRemoveList;
    private int mRingingCallState;
    private ServiceState[] mServiceState;
    private SignalStrength[] mSignalStrength;
    private VoLteServiceState mVoLteServiceState;
    private int next;

    /* renamed from: com.android.server.TelephonyRegistry.1 */
    class C00831 extends Handler {
        C00831() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case TelephonyRegistry.MSG_USER_SWITCHED /*1*/:
                    int numPhones = TelephonyManager.getDefault().getPhoneCount();
                    for (int sub = 0; sub < numPhones; sub += TelephonyRegistry.MSG_USER_SWITCHED) {
                        TelephonyRegistry.this.notifyCellLocationForSubscriber(sub, TelephonyRegistry.this.mCellLocation[sub]);
                    }
                case TelephonyRegistry.MSG_UPDATE_DEFAULT_SUB /*2*/:
                    int newDefaultPhoneId = msg.arg1;
                    int newDefaultSubId = ((Integer) msg.obj).intValue();
                    synchronized (TelephonyRegistry.this.mRecords) {
                        Iterator i$ = TelephonyRegistry.this.mRecords.iterator();
                        while (i$.hasNext()) {
                            Record r = (Record) i$.next();
                            if (r.subId == Integer.MAX_VALUE) {
                                TelephonyRegistry.this.checkPossibleMissNotify(r, newDefaultPhoneId);
                            }
                        }
                        TelephonyRegistry.this.handleRemoveListLocked();
                        break;
                    }
                    TelephonyRegistry.this.mDefaultSubId = newDefaultSubId;
                    TelephonyRegistry.this.mDefaultPhoneId = newDefaultPhoneId;
                default:
            }
        }
    }

    /* renamed from: com.android.server.TelephonyRegistry.2 */
    class C00842 extends BroadcastReceiver {
        C00842() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_SWITCHED".equals(action)) {
                TelephonyRegistry.this.mHandler.sendMessage(TelephonyRegistry.this.mHandler.obtainMessage(TelephonyRegistry.MSG_USER_SWITCHED, intent.getIntExtra("android.intent.extra.user_handle", 0), 0));
            } else if (action.equals("android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED")) {
                Integer newDefaultSubIdObj = new Integer(intent.getIntExtra("subscription", SubscriptionManager.getDefaultSubId()));
                int newDefaultPhoneId = intent.getIntExtra("slot", SubscriptionManager.getPhoneId(TelephonyRegistry.this.mDefaultSubId));
                if (!TelephonyRegistry.this.validatePhoneId(newDefaultPhoneId)) {
                    return;
                }
                if (!newDefaultSubIdObj.equals(Integer.valueOf(TelephonyRegistry.this.mDefaultSubId)) || newDefaultPhoneId != TelephonyRegistry.this.mDefaultPhoneId) {
                    TelephonyRegistry.this.mHandler.sendMessage(TelephonyRegistry.this.mHandler.obtainMessage(TelephonyRegistry.MSG_UPDATE_DEFAULT_SUB, newDefaultPhoneId, 0, newDefaultSubIdObj));
                }
            }
        }
    }

    private static class LogSSC {
        private int mPhoneId;
        private String mS;
        private ServiceState mState;
        private int mSubId;
        private Time mTime;

        private LogSSC() {
        }

        public void set(Time t, String s, int subId, int phoneId, ServiceState state) {
            this.mTime = t;
            this.mS = s;
            this.mSubId = subId;
            this.mPhoneId = phoneId;
            this.mState = state;
        }

        public String toString() {
            return this.mS + " Time " + this.mTime.toString() + " mSubId " + this.mSubId + " mPhoneId " + this.mPhoneId + "  mState " + this.mState;
        }
    }

    private static class Record {
        IBinder binder;
        IPhoneStateListener callback;
        int callerUid;
        int events;
        IOnSubscriptionsChangedListener onSubscriptionsChangedListenerCallback;
        int phoneId;
        String pkgForDebug;
        int subId;

        private Record() {
            this.subId = -1;
            this.phoneId = -1;
        }

        boolean matchPhoneStateListenerEvent(int events) {
            return (this.callback == null || (this.events & events) == 0) ? TelephonyRegistry.DBG_LOC : true;
        }

        boolean matchOnSubscriptionsChangedListener() {
            return this.onSubscriptionsChangedListenerCallback != null ? true : TelephonyRegistry.DBG_LOC;
        }

        public String toString() {
            return "{pkgForDebug=" + this.pkgForDebug + " binder=" + this.binder + " callback=" + this.callback + " onSubscriptionsChangedListenererCallback=" + this.onSubscriptionsChangedListenerCallback + " callerUid=" + this.callerUid + " subId=" + this.subId + " phoneId=" + this.phoneId + " events=" + Integer.toHexString(this.events) + "}";
        }
    }

    TelephonyRegistry(Context context) {
        int i;
        this.mRemoveList = new ArrayList();
        this.mRecords = new ArrayList();
        this.hasNotifySubscriptionInfoChangedOccurred = DBG_LOC;
        this.mOtaspMode = MSG_USER_SWITCHED;
        this.mCellInfo = null;
        this.mVoLteServiceState = new VoLteServiceState();
        this.mDefaultSubId = -1;
        this.mDefaultPhoneId = -1;
        this.mDcRtInfo = new DataConnectionRealTimeInfo();
        this.mRingingCallState = 0;
        this.mForegroundCallState = 0;
        this.mBackgroundCallState = 0;
        this.mPreciseCallState = new PreciseCallState();
        this.mPreciseDataConnectionState = new PreciseDataConnectionState();
        this.mHandler = new C00831();
        this.mBroadcastReceiver = new C00842();
        this.logSSC = new LogSSC[10];
        this.next = 0;
        CellLocation location = CellLocation.getEmpty();
        this.mContext = context;
        this.mBatteryStats = BatteryStatsService.getService();
        this.mConnectedApns = new ArrayList();
        int numPhones = TelephonyManager.getDefault().getPhoneCount();
        this.mNumPhones = numPhones;
        this.mCallState = new int[numPhones];
        this.mDataActivity = new int[numPhones];
        this.mDataConnectionState = new int[numPhones];
        this.mDataConnectionNetworkType = new int[numPhones];
        this.mCallIncomingNumber = new String[numPhones];
        this.mServiceState = new ServiceState[numPhones];
        this.mSignalStrength = new SignalStrength[numPhones];
        this.mMessageWaiting = new boolean[numPhones];
        this.mDataConnectionPossible = new boolean[numPhones];
        this.mDataConnectionReason = new String[numPhones];
        this.mDataConnectionApn = new String[numPhones];
        this.mCallForwarding = new boolean[numPhones];
        this.mCellLocation = new Bundle[numPhones];
        this.mDataConnectionLinkProperties = new LinkProperties[numPhones];
        this.mDataConnectionNetworkCapabilities = new NetworkCapabilities[numPhones];
        this.mCellInfo = new ArrayList();
        for (i = 0; i < numPhones; i += MSG_USER_SWITCHED) {
            this.mCallState[i] = 0;
            this.mDataActivity[i] = 0;
            this.mDataConnectionState[i] = -1;
            this.mCallIncomingNumber[i] = "";
            this.mServiceState[i] = new ServiceState();
            this.mSignalStrength[i] = new SignalStrength();
            this.mMessageWaiting[i] = DBG_LOC;
            this.mCallForwarding[i] = DBG_LOC;
            this.mDataConnectionPossible[i] = DBG_LOC;
            this.mDataConnectionReason[i] = "";
            this.mDataConnectionApn[i] = "";
            this.mCellLocation[i] = new Bundle();
            this.mCellInfo.add(i, null);
        }
        if (location != null) {
            for (i = 0; i < numPhones; i += MSG_USER_SWITCHED) {
                location.fillInNotifierBundle(this.mCellLocation[i]);
            }
        }
        this.mConnectedApns = new ArrayList();
    }

    public void systemRunning() {
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.USER_SWITCHED");
        filter.addAction("android.intent.action.USER_REMOVED");
        filter.addAction("android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED");
        log("systemRunning register for intents");
        this.mContext.registerReceiver(this.mBroadcastReceiver, filter);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void addOnSubscriptionsChangedListener(java.lang.String r11, com.android.internal.telephony.IOnSubscriptionsChangedListener r12) {
        /*
        r10 = this;
        r2 = android.os.UserHandle.getCallingUserId();
        r5 = android.os.UserHandle.myUserId();
        r10.checkOnSubscriptionsChangedListenerPermission();
        r6 = 0;
        r9 = r10.mRecords;
        monitor-enter(r9);
        r1 = r12.asBinder();	 Catch:{ all -> 0x004f }
        r8 = r10.mRecords;	 Catch:{ all -> 0x004f }
        r0 = r8.size();	 Catch:{ all -> 0x004f }
        r4 = 0;
        r7 = r6;
    L_0x001b:
        if (r4 >= r0) goto L_0x0041;
    L_0x001d:
        r8 = r10.mRecords;	 Catch:{ all -> 0x005f }
        r6 = r8.get(r4);	 Catch:{ all -> 0x005f }
        r6 = (com.android.server.TelephonyRegistry.Record) r6;	 Catch:{ all -> 0x005f }
        r8 = r6.binder;	 Catch:{ all -> 0x004f }
        if (r1 != r8) goto L_0x003d;
    L_0x0029:
        r6.onSubscriptionsChangedListenerCallback = r12;	 Catch:{ all -> 0x004f }
        r6.pkgForDebug = r11;	 Catch:{ all -> 0x004f }
        r6.callerUid = r2;	 Catch:{ all -> 0x004f }
        r8 = 0;
        r6.events = r8;	 Catch:{ all -> 0x004f }
        r8 = r10.hasNotifySubscriptionInfoChangedOccurred;	 Catch:{ all -> 0x004f }
        if (r8 == 0) goto L_0x0059;
    L_0x0036:
        r8 = r6.onSubscriptionsChangedListenerCallback;	 Catch:{ RemoteException -> 0x0052 }
        r8.onSubscriptionsChanged();	 Catch:{ RemoteException -> 0x0052 }
    L_0x003b:
        monitor-exit(r9);	 Catch:{ all -> 0x004f }
        return;
    L_0x003d:
        r4 = r4 + 1;
        r7 = r6;
        goto L_0x001b;
    L_0x0041:
        r6 = new com.android.server.TelephonyRegistry$Record;	 Catch:{ all -> 0x005f }
        r8 = 0;
        r6.<init>();	 Catch:{ all -> 0x005f }
        r6.binder = r1;	 Catch:{ all -> 0x004f }
        r8 = r10.mRecords;	 Catch:{ all -> 0x004f }
        r8.add(r6);	 Catch:{ all -> 0x004f }
        goto L_0x0029;
    L_0x004f:
        r8 = move-exception;
    L_0x0050:
        monitor-exit(r9);	 Catch:{ all -> 0x004f }
        throw r8;
    L_0x0052:
        r3 = move-exception;
        r8 = r6.binder;	 Catch:{ all -> 0x004f }
        r10.remove(r8);	 Catch:{ all -> 0x004f }
        goto L_0x003b;
    L_0x0059:
        r8 = "listen oscl: hasNotifySubscriptionInfoChangedOccurred==false no callback";
        log(r8);	 Catch:{ all -> 0x004f }
        goto L_0x003b;
    L_0x005f:
        r8 = move-exception;
        r6 = r7;
        goto L_0x0050;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.addOnSubscriptionsChangedListener(java.lang.String, com.android.internal.telephony.IOnSubscriptionsChangedListener):void");
    }

    public void removeOnSubscriptionsChangedListener(String pkgForDebug, IOnSubscriptionsChangedListener callback) {
        remove(callback.asBinder());
    }

    private void checkOnSubscriptionsChangedListenerPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PHONE_STATE", null);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifySubscriptionInfoChanged() {
        /*
        r6 = this;
        r4 = r6.mRecords;
        monitor-enter(r4);
        r3 = r6.hasNotifySubscriptionInfoChangedOccurred;	 Catch:{ all -> 0x0052 }
        if (r3 != 0) goto L_0x0023;
    L_0x0007:
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0052 }
        r3.<init>();	 Catch:{ all -> 0x0052 }
        r5 = "notifySubscriptionInfoChanged: first invocation mRecords.size=";
        r3 = r3.append(r5);	 Catch:{ all -> 0x0052 }
        r5 = r6.mRecords;	 Catch:{ all -> 0x0052 }
        r5 = r5.size();	 Catch:{ all -> 0x0052 }
        r3 = r3.append(r5);	 Catch:{ all -> 0x0052 }
        r3 = r3.toString();	 Catch:{ all -> 0x0052 }
        log(r3);	 Catch:{ all -> 0x0052 }
    L_0x0023:
        r3 = 1;
        r6.hasNotifySubscriptionInfoChangedOccurred = r3;	 Catch:{ all -> 0x0052 }
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0052 }
        r3.clear();	 Catch:{ all -> 0x0052 }
        r3 = r6.mRecords;	 Catch:{ all -> 0x0052 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0052 }
    L_0x0031:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0052 }
        if (r3 == 0) goto L_0x0055;
    L_0x0037:
        r2 = r1.next();	 Catch:{ all -> 0x0052 }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x0052 }
        r3 = r2.matchOnSubscriptionsChangedListener();	 Catch:{ all -> 0x0052 }
        if (r3 == 0) goto L_0x0031;
    L_0x0043:
        r3 = r2.onSubscriptionsChangedListenerCallback;	 Catch:{ RemoteException -> 0x0049 }
        r3.onSubscriptionsChanged();	 Catch:{ RemoteException -> 0x0049 }
        goto L_0x0031;
    L_0x0049:
        r0 = move-exception;
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0052 }
        r5 = r2.binder;	 Catch:{ all -> 0x0052 }
        r3.add(r5);	 Catch:{ all -> 0x0052 }
        goto L_0x0031;
    L_0x0052:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0052 }
        throw r3;
    L_0x0055:
        r6.handleRemoveListLocked();	 Catch:{ all -> 0x0052 }
        monitor-exit(r4);	 Catch:{ all -> 0x0052 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifySubscriptionInfoChanged():void");
    }

    public void listen(String pkgForDebug, IPhoneStateListener callback, int events, boolean notifyNow) {
        listenForSubscriber(Integer.MAX_VALUE, pkgForDebug, callback, events, notifyNow);
    }

    public void listenForSubscriber(int subId, String pkgForDebug, IPhoneStateListener callback, int events, boolean notifyNow) {
        listen(pkgForDebug, callback, events, notifyNow, subId);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void listen(java.lang.String r16, com.android.internal.telephony.IPhoneStateListener r17, int r18, boolean r19, int r20) {
        /*
        r15 = this;
        r3 = android.os.UserHandle.getCallingUserId();
        r7 = android.os.UserHandle.myUserId();
        if (r18 == 0) goto L_0x01c8;
    L_0x000a:
        r0 = r18;
        r15.checkListenerPermission(r0);
        r12 = r15.mRecords;
        monitor-enter(r12);
        r9 = 0;
        r2 = r17.asBinder();	 Catch:{ all -> 0x014f }
        r11 = r15.mRecords;	 Catch:{ all -> 0x014f }
        r1 = r11.size();	 Catch:{ all -> 0x014f }
        r6 = 0;
        r10 = r9;
    L_0x001f:
        if (r6 >= r1) goto L_0x0140;
    L_0x0021:
        r11 = r15.mRecords;	 Catch:{ all -> 0x01d1 }
        r9 = r11.get(r6);	 Catch:{ all -> 0x01d1 }
        r9 = (com.android.server.TelephonyRegistry.Record) r9;	 Catch:{ all -> 0x01d1 }
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        if (r2 != r11) goto L_0x013b;
    L_0x002d:
        r0 = r17;
        r9.callback = r0;	 Catch:{ all -> 0x014f }
        r0 = r16;
        r9.pkgForDebug = r0;	 Catch:{ all -> 0x014f }
        r9.callerUid = r3;	 Catch:{ all -> 0x014f }
        r11 = android.telephony.SubscriptionManager.isValidSubscriptionId(r20);	 Catch:{ all -> 0x014f }
        if (r11 != 0) goto L_0x0152;
    L_0x003d:
        r11 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r9.subId = r11;	 Catch:{ all -> 0x014f }
    L_0x0042:
        r11 = r9.subId;	 Catch:{ all -> 0x014f }
        r11 = android.telephony.SubscriptionManager.getPhoneId(r11);	 Catch:{ all -> 0x014f }
        r9.phoneId = r11;	 Catch:{ all -> 0x014f }
        r8 = r9.phoneId;	 Catch:{ all -> 0x014f }
        r0 = r18;
        r9.events = r0;	 Catch:{ all -> 0x014f }
        if (r19 == 0) goto L_0x0139;
    L_0x0052:
        r11 = r15.validatePhoneId(r8);	 Catch:{ all -> 0x014f }
        if (r11 == 0) goto L_0x0139;
    L_0x0058:
        r11 = r18 & 1;
        if (r11 == 0) goto L_0x006a;
    L_0x005c:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0158 }
        r13 = new android.telephony.ServiceState;	 Catch:{ RemoteException -> 0x0158 }
        r14 = r15.mServiceState;	 Catch:{ RemoteException -> 0x0158 }
        r14 = r14[r8];	 Catch:{ RemoteException -> 0x0158 }
        r13.<init>(r14);	 Catch:{ RemoteException -> 0x0158 }
        r11.onServiceStateChanged(r13);	 Catch:{ RemoteException -> 0x0158 }
    L_0x006a:
        r11 = r18 & 2;
        if (r11 == 0) goto L_0x0080;
    L_0x006e:
        r11 = r15.mSignalStrength;	 Catch:{ RemoteException -> 0x0160 }
        r11 = r11[r8];	 Catch:{ RemoteException -> 0x0160 }
        r5 = r11.getGsmSignalStrength();	 Catch:{ RemoteException -> 0x0160 }
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0160 }
        r13 = 99;
        if (r5 != r13) goto L_0x007d;
    L_0x007c:
        r5 = -1;
    L_0x007d:
        r11.onSignalStrengthChanged(r5);	 Catch:{ RemoteException -> 0x0160 }
    L_0x0080:
        r11 = r18 & 4;
        if (r11 == 0) goto L_0x008d;
    L_0x0084:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0168 }
        r13 = r15.mMessageWaiting;	 Catch:{ RemoteException -> 0x0168 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0168 }
        r11.onMessageWaitingIndicatorChanged(r13);	 Catch:{ RemoteException -> 0x0168 }
    L_0x008d:
        r11 = r18 & 8;
        if (r11 == 0) goto L_0x009a;
    L_0x0091:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0170 }
        r13 = r15.mCallForwarding;	 Catch:{ RemoteException -> 0x0170 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0170 }
        r11.onCallForwardingIndicatorChanged(r13);	 Catch:{ RemoteException -> 0x0170 }
    L_0x009a:
        r11 = 16;
        r11 = r15.validateEventsAndUserLocked(r9, r11);	 Catch:{ all -> 0x014f }
        if (r11 == 0) goto L_0x00b0;
    L_0x00a2:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0178 }
        r13 = new android.os.Bundle;	 Catch:{ RemoteException -> 0x0178 }
        r14 = r15.mCellLocation;	 Catch:{ RemoteException -> 0x0178 }
        r14 = r14[r8];	 Catch:{ RemoteException -> 0x0178 }
        r13.<init>(r14);	 Catch:{ RemoteException -> 0x0178 }
        r11.onCellLocationChanged(r13);	 Catch:{ RemoteException -> 0x0178 }
    L_0x00b0:
        r11 = r18 & 32;
        if (r11 == 0) goto L_0x00c1;
    L_0x00b4:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0180 }
        r13 = r15.mCallState;	 Catch:{ RemoteException -> 0x0180 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0180 }
        r14 = r15.mCallIncomingNumber;	 Catch:{ RemoteException -> 0x0180 }
        r14 = r14[r8];	 Catch:{ RemoteException -> 0x0180 }
        r11.onCallStateChanged(r13, r14);	 Catch:{ RemoteException -> 0x0180 }
    L_0x00c1:
        r11 = r18 & 64;
        if (r11 == 0) goto L_0x00d2;
    L_0x00c5:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0188 }
        r13 = r15.mDataConnectionState;	 Catch:{ RemoteException -> 0x0188 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0188 }
        r14 = r15.mDataConnectionNetworkType;	 Catch:{ RemoteException -> 0x0188 }
        r14 = r14[r8];	 Catch:{ RemoteException -> 0x0188 }
        r11.onDataConnectionStateChanged(r13, r14);	 Catch:{ RemoteException -> 0x0188 }
    L_0x00d2:
        r0 = r18;
        r11 = r0 & 128;
        if (r11 == 0) goto L_0x00e1;
    L_0x00d8:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0190 }
        r13 = r15.mDataActivity;	 Catch:{ RemoteException -> 0x0190 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0190 }
        r11.onDataActivity(r13);	 Catch:{ RemoteException -> 0x0190 }
    L_0x00e1:
        r0 = r18;
        r11 = r0 & 256;
        if (r11 == 0) goto L_0x00f0;
    L_0x00e7:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x0198 }
        r13 = r15.mSignalStrength;	 Catch:{ RemoteException -> 0x0198 }
        r13 = r13[r8];	 Catch:{ RemoteException -> 0x0198 }
        r11.onSignalStrengthsChanged(r13);	 Catch:{ RemoteException -> 0x0198 }
    L_0x00f0:
        r0 = r18;
        r11 = r0 & 512;
        if (r11 == 0) goto L_0x00fd;
    L_0x00f6:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x01a0 }
        r13 = r15.mOtaspMode;	 Catch:{ RemoteException -> 0x01a0 }
        r11.onOtaspChanged(r13);	 Catch:{ RemoteException -> 0x01a0 }
    L_0x00fd:
        r11 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r11 = r15.validateEventsAndUserLocked(r9, r11);	 Catch:{ all -> 0x014f }
        if (r11 == 0) goto L_0x0112;
    L_0x0105:
        r13 = r9.callback;	 Catch:{ RemoteException -> 0x01a8 }
        r11 = r15.mCellInfo;	 Catch:{ RemoteException -> 0x01a8 }
        r11 = r11.get(r8);	 Catch:{ RemoteException -> 0x01a8 }
        r11 = (java.util.List) r11;	 Catch:{ RemoteException -> 0x01a8 }
        r13.onCellInfoChanged(r11);	 Catch:{ RemoteException -> 0x01a8 }
    L_0x0112:
        r0 = r18;
        r11 = r0 & 8192;
        if (r11 == 0) goto L_0x011f;
    L_0x0118:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x01b0 }
        r13 = r15.mDcRtInfo;	 Catch:{ RemoteException -> 0x01b0 }
        r11.onDataConnectionRealTimeInfoChanged(r13);	 Catch:{ RemoteException -> 0x01b0 }
    L_0x011f:
        r0 = r18;
        r11 = r0 & 2048;
        if (r11 == 0) goto L_0x012c;
    L_0x0125:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x01b8 }
        r13 = r15.mPreciseCallState;	 Catch:{ RemoteException -> 0x01b8 }
        r11.onPreciseCallStateChanged(r13);	 Catch:{ RemoteException -> 0x01b8 }
    L_0x012c:
        r0 = r18;
        r11 = r0 & 4096;
        if (r11 == 0) goto L_0x0139;
    L_0x0132:
        r11 = r9.callback;	 Catch:{ RemoteException -> 0x01c0 }
        r13 = r15.mPreciseDataConnectionState;	 Catch:{ RemoteException -> 0x01c0 }
        r11.onPreciseDataConnectionStateChanged(r13);	 Catch:{ RemoteException -> 0x01c0 }
    L_0x0139:
        monitor-exit(r12);	 Catch:{ all -> 0x014f }
    L_0x013a:
        return;
    L_0x013b:
        r6 = r6 + 1;
        r10 = r9;
        goto L_0x001f;
    L_0x0140:
        r9 = new com.android.server.TelephonyRegistry$Record;	 Catch:{ all -> 0x01d1 }
        r11 = 0;
        r9.<init>();	 Catch:{ all -> 0x01d1 }
        r9.binder = r2;	 Catch:{ all -> 0x014f }
        r11 = r15.mRecords;	 Catch:{ all -> 0x014f }
        r11.add(r9);	 Catch:{ all -> 0x014f }
        goto L_0x002d;
    L_0x014f:
        r11 = move-exception;
    L_0x0150:
        monitor-exit(r12);	 Catch:{ all -> 0x014f }
        throw r11;
    L_0x0152:
        r0 = r20;
        r9.subId = r0;	 Catch:{ all -> 0x014f }
        goto L_0x0042;
    L_0x0158:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x006a;
    L_0x0160:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x0080;
    L_0x0168:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x008d;
    L_0x0170:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x009a;
    L_0x0178:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00b0;
    L_0x0180:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00c1;
    L_0x0188:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00d2;
    L_0x0190:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00e1;
    L_0x0198:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00f0;
    L_0x01a0:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x00fd;
    L_0x01a8:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x0112;
    L_0x01b0:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x011f;
    L_0x01b8:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x012c;
    L_0x01c0:
        r4 = move-exception;
        r11 = r9.binder;	 Catch:{ all -> 0x014f }
        r15.remove(r11);	 Catch:{ all -> 0x014f }
        goto L_0x0139;
    L_0x01c8:
        r11 = r17.asBinder();
        r15.remove(r11);
        goto L_0x013a;
    L_0x01d1:
        r11 = move-exception;
        r9 = r10;
        goto L_0x0150;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.listen(java.lang.String, com.android.internal.telephony.IPhoneStateListener, int, boolean, int):void");
    }

    private void remove(IBinder binder) {
        synchronized (this.mRecords) {
            int recordCount = this.mRecords.size();
            for (int i = 0; i < recordCount; i += MSG_USER_SWITCHED) {
                if (((Record) this.mRecords.get(i)).binder == binder) {
                    this.mRecords.remove(i);
                    return;
                }
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyCallState(int r8, java.lang.String r9) {
        /*
        r7 = this;
        r6 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r3 = "notifyCallState()";
        r3 = r7.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x000c;
    L_0x000b:
        return;
    L_0x000c:
        r4 = r7.mRecords;
        monitor-enter(r4);
        r3 = r7.mRecords;	 Catch:{ all -> 0x003c }
        r1 = r3.iterator();	 Catch:{ all -> 0x003c }
    L_0x0015:
        r3 = r1.hasNext();	 Catch:{ all -> 0x003c }
        if (r3 == 0) goto L_0x003f;
    L_0x001b:
        r2 = r1.next();	 Catch:{ all -> 0x003c }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x003c }
        r3 = 32;
        r3 = r2.matchPhoneStateListenerEvent(r3);	 Catch:{ all -> 0x003c }
        if (r3 == 0) goto L_0x0015;
    L_0x0029:
        r3 = r2.subId;	 Catch:{ all -> 0x003c }
        if (r3 != r6) goto L_0x0015;
    L_0x002d:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x0033 }
        r3.onCallStateChanged(r8, r9);	 Catch:{ RemoteException -> 0x0033 }
        goto L_0x0015;
    L_0x0033:
        r0 = move-exception;
        r3 = r7.mRemoveList;	 Catch:{ all -> 0x003c }
        r5 = r2.binder;	 Catch:{ all -> 0x003c }
        r3.add(r5);	 Catch:{ all -> 0x003c }
        goto L_0x0015;
    L_0x003c:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x003c }
        throw r3;
    L_0x003f:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x003c }
        monitor-exit(r4);	 Catch:{ all -> 0x003c }
        r7.broadcastCallStateChanged(r8, r9, r6);
        goto L_0x000b;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyCallState(int, java.lang.String):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyCallStateForSubscriber(int r8, int r9, java.lang.String r10) {
        /*
        r7 = this;
        r4 = "notifyCallState()";
        r4 = r7.checkNotifyPermission(r4);
        if (r4 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r5 = r7.mRecords;
        monitor-enter(r5);
        r2 = android.telephony.SubscriptionManager.getPhoneId(r8);	 Catch:{ all -> 0x0052 }
        r4 = r7.validatePhoneId(r2);	 Catch:{ all -> 0x0052 }
        if (r4 == 0) goto L_0x0055;
    L_0x0016:
        r4 = r7.mCallState;	 Catch:{ all -> 0x0052 }
        r4[r2] = r9;	 Catch:{ all -> 0x0052 }
        r4 = r7.mCallIncomingNumber;	 Catch:{ all -> 0x0052 }
        r4[r2] = r10;	 Catch:{ all -> 0x0052 }
        r4 = r7.mRecords;	 Catch:{ all -> 0x0052 }
        r1 = r4.iterator();	 Catch:{ all -> 0x0052 }
    L_0x0024:
        r4 = r1.hasNext();	 Catch:{ all -> 0x0052 }
        if (r4 == 0) goto L_0x0055;
    L_0x002a:
        r3 = r1.next();	 Catch:{ all -> 0x0052 }
        r3 = (com.android.server.TelephonyRegistry.Record) r3;	 Catch:{ all -> 0x0052 }
        r4 = 32;
        r4 = r3.matchPhoneStateListenerEvent(r4);	 Catch:{ all -> 0x0052 }
        if (r4 == 0) goto L_0x0024;
    L_0x0038:
        r4 = r3.subId;	 Catch:{ all -> 0x0052 }
        if (r4 != r8) goto L_0x0024;
    L_0x003c:
        r4 = r3.subId;	 Catch:{ all -> 0x0052 }
        r6 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        if (r4 == r6) goto L_0x0024;
    L_0x0043:
        r4 = r3.callback;	 Catch:{ RemoteException -> 0x0049 }
        r4.onCallStateChanged(r9, r10);	 Catch:{ RemoteException -> 0x0049 }
        goto L_0x0024;
    L_0x0049:
        r0 = move-exception;
        r4 = r7.mRemoveList;	 Catch:{ all -> 0x0052 }
        r6 = r3.binder;	 Catch:{ all -> 0x0052 }
        r4.add(r6);	 Catch:{ all -> 0x0052 }
        goto L_0x0024;
    L_0x0052:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0052 }
        throw r4;
    L_0x0055:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x0052 }
        monitor-exit(r5);	 Catch:{ all -> 0x0052 }
        r7.broadcastCallStateChanged(r9, r10, r8);
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyCallStateForSubscriber(int, int, java.lang.String):void");
    }

    public void notifyServiceStateForPhoneId(int phoneId, int subId, ServiceState state) {
        if (checkNotifyPermission("notifyServiceState()")) {
            synchronized (this.mRecords) {
                if (validatePhoneId(phoneId)) {
                    this.mServiceState[phoneId] = state;
                    logServiceStateChanged("notifyServiceStateForSubscriber", subId, phoneId, state);
                    Iterator i$ = this.mRecords.iterator();
                    while (i$.hasNext()) {
                        Record r = (Record) i$.next();
                        if (r.matchPhoneStateListenerEvent(MSG_USER_SWITCHED) && idMatch(r.subId, subId, phoneId)) {
                            try {
                                r.callback.onServiceStateChanged(new ServiceState(state));
                            } catch (RemoteException e) {
                                this.mRemoveList.add(r.binder);
                            }
                        }
                    }
                } else {
                    log("notifyServiceStateForSubscriber: INVALID phoneId=" + phoneId);
                }
                handleRemoveListLocked();
            }
            broadcastServiceStateChanged(state, subId);
        }
    }

    public void notifySignalStrength(SignalStrength signalStrength) {
        notifySignalStrengthForSubscriber(Integer.MAX_VALUE, signalStrength);
    }

    public void notifySignalStrengthForSubscriber(int subId, SignalStrength signalStrength) {
        if (checkNotifyPermission("notifySignalStrength()")) {
            synchronized (this.mRecords) {
                int phoneId = SubscriptionManager.getPhoneId(subId);
                if (validatePhoneId(phoneId)) {
                    this.mSignalStrength[phoneId] = signalStrength;
                    Iterator i$ = this.mRecords.iterator();
                    while (i$.hasNext()) {
                        Record r = (Record) i$.next();
                        if (r.matchPhoneStateListenerEvent(DumpState.DUMP_VERIFIERS) && idMatch(r.subId, subId, phoneId)) {
                            try {
                                r.callback.onSignalStrengthsChanged(new SignalStrength(signalStrength));
                            } catch (RemoteException e) {
                                this.mRemoveList.add(r.binder);
                            }
                        }
                        if (r.matchPhoneStateListenerEvent(MSG_UPDATE_DEFAULT_SUB) && idMatch(r.subId, subId, phoneId)) {
                            try {
                                int ss;
                                int gsmSignalStrength = signalStrength.getGsmSignalStrength();
                                if (gsmSignalStrength == 99) {
                                    ss = -1;
                                } else {
                                    ss = gsmSignalStrength;
                                }
                                r.callback.onSignalStrengthChanged(ss);
                            } catch (RemoteException e2) {
                                this.mRemoveList.add(r.binder);
                            }
                        }
                    }
                } else {
                    log("notifySignalStrengthForSubscriber: invalid phoneId=" + phoneId);
                }
                handleRemoveListLocked();
            }
            broadcastSignalStrengthChanged(signalStrength, subId);
        }
    }

    public void notifyCellInfo(List<CellInfo> cellInfo) {
        notifyCellInfoForSubscriber(Integer.MAX_VALUE, cellInfo);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyCellInfoForSubscriber(int r8, java.util.List<android.telephony.CellInfo> r9) {
        /*
        r7 = this;
        r4 = "notifyCellInfo()";
        r4 = r7.checkNotifyPermission(r4);
        if (r4 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r5 = r7.mRecords;
        monitor-enter(r5);
        r2 = android.telephony.SubscriptionManager.getPhoneId(r8);	 Catch:{ all -> 0x004c }
        r4 = r7.validatePhoneId(r2);	 Catch:{ all -> 0x004c }
        if (r4 == 0) goto L_0x004f;
    L_0x0016:
        r4 = r7.mCellInfo;	 Catch:{ all -> 0x004c }
        r4.set(r2, r9);	 Catch:{ all -> 0x004c }
        r4 = r7.mRecords;	 Catch:{ all -> 0x004c }
        r1 = r4.iterator();	 Catch:{ all -> 0x004c }
    L_0x0021:
        r4 = r1.hasNext();	 Catch:{ all -> 0x004c }
        if (r4 == 0) goto L_0x004f;
    L_0x0027:
        r3 = r1.next();	 Catch:{ all -> 0x004c }
        r3 = (com.android.server.TelephonyRegistry.Record) r3;	 Catch:{ all -> 0x004c }
        r4 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r4 = r7.validateEventsAndUserLocked(r3, r4);	 Catch:{ all -> 0x004c }
        if (r4 == 0) goto L_0x0021;
    L_0x0035:
        r4 = r3.subId;	 Catch:{ all -> 0x004c }
        r4 = r7.idMatch(r4, r8, r2);	 Catch:{ all -> 0x004c }
        if (r4 == 0) goto L_0x0021;
    L_0x003d:
        r4 = r3.callback;	 Catch:{ RemoteException -> 0x0043 }
        r4.onCellInfoChanged(r9);	 Catch:{ RemoteException -> 0x0043 }
        goto L_0x0021;
    L_0x0043:
        r0 = move-exception;
        r4 = r7.mRemoveList;	 Catch:{ all -> 0x004c }
        r6 = r3.binder;	 Catch:{ all -> 0x004c }
        r4.add(r6);	 Catch:{ all -> 0x004c }
        goto L_0x0021;
    L_0x004c:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x004c }
        throw r4;
    L_0x004f:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x004c }
        monitor-exit(r5);	 Catch:{ all -> 0x004c }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyCellInfoForSubscriber(int, java.util.List):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyDataConnectionRealTimeInfo(android.telephony.DataConnectionRealTimeInfo r7) {
        /*
        r6 = this;
        r3 = "notifyDataConnectionRealTimeInfo()";
        r3 = r6.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r4 = r6.mRecords;
        monitor-enter(r4);
        r6.mDcRtInfo = r7;	 Catch:{ all -> 0x0039 }
        r3 = r6.mRecords;	 Catch:{ all -> 0x0039 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0039 }
    L_0x0014:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0039 }
        if (r3 == 0) goto L_0x003c;
    L_0x001a:
        r2 = r1.next();	 Catch:{ all -> 0x0039 }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x0039 }
        r3 = 8192; // 0x2000 float:1.14794E-41 double:4.0474E-320;
        r3 = r6.validateEventsAndUserLocked(r2, r3);	 Catch:{ all -> 0x0039 }
        if (r3 == 0) goto L_0x0014;
    L_0x0028:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x0030 }
        r5 = r6.mDcRtInfo;	 Catch:{ RemoteException -> 0x0030 }
        r3.onDataConnectionRealTimeInfoChanged(r5);	 Catch:{ RemoteException -> 0x0030 }
        goto L_0x0014;
    L_0x0030:
        r0 = move-exception;
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0039 }
        r5 = r2.binder;	 Catch:{ all -> 0x0039 }
        r3.add(r5);	 Catch:{ all -> 0x0039 }
        goto L_0x0014;
    L_0x0039:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0039 }
        throw r3;
    L_0x003c:
        r6.handleRemoveListLocked();	 Catch:{ all -> 0x0039 }
        monitor-exit(r4);	 Catch:{ all -> 0x0039 }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyDataConnectionRealTimeInfo(android.telephony.DataConnectionRealTimeInfo):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyMessageWaitingChangedForPhoneId(int r7, int r8, boolean r9) {
        /*
        r6 = this;
        r3 = "notifyMessageWaitingChanged()";
        r3 = r6.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r4 = r6.mRecords;
        monitor-enter(r4);
        r3 = r6.validatePhoneId(r7);	 Catch:{ all -> 0x0046 }
        if (r3 == 0) goto L_0x0049;
    L_0x0012:
        r3 = r6.mMessageWaiting;	 Catch:{ all -> 0x0046 }
        r3[r7] = r9;	 Catch:{ all -> 0x0046 }
        r3 = r6.mRecords;	 Catch:{ all -> 0x0046 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0046 }
    L_0x001c:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0046 }
        if (r3 == 0) goto L_0x0049;
    L_0x0022:
        r2 = r1.next();	 Catch:{ all -> 0x0046 }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x0046 }
        r3 = 4;
        r3 = r2.matchPhoneStateListenerEvent(r3);	 Catch:{ all -> 0x0046 }
        if (r3 == 0) goto L_0x001c;
    L_0x002f:
        r3 = r2.subId;	 Catch:{ all -> 0x0046 }
        r3 = r6.idMatch(r3, r8, r7);	 Catch:{ all -> 0x0046 }
        if (r3 == 0) goto L_0x001c;
    L_0x0037:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x003d }
        r3.onMessageWaitingIndicatorChanged(r9);	 Catch:{ RemoteException -> 0x003d }
        goto L_0x001c;
    L_0x003d:
        r0 = move-exception;
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0046 }
        r5 = r2.binder;	 Catch:{ all -> 0x0046 }
        r3.add(r5);	 Catch:{ all -> 0x0046 }
        goto L_0x001c;
    L_0x0046:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0046 }
        throw r3;
    L_0x0049:
        r6.handleRemoveListLocked();	 Catch:{ all -> 0x0046 }
        monitor-exit(r4);	 Catch:{ all -> 0x0046 }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyMessageWaitingChangedForPhoneId(int, int, boolean):void");
    }

    public void notifyCallForwardingChanged(boolean cfi) {
        notifyCallForwardingChangedForSubscriber(Integer.MAX_VALUE, cfi);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyCallForwardingChangedForSubscriber(int r8, boolean r9) {
        /*
        r7 = this;
        r4 = "notifyCallForwardingChanged()";
        r4 = r7.checkNotifyPermission(r4);
        if (r4 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r5 = r7.mRecords;
        monitor-enter(r5);
        r2 = android.telephony.SubscriptionManager.getPhoneId(r8);	 Catch:{ all -> 0x004b }
        r4 = r7.validatePhoneId(r2);	 Catch:{ all -> 0x004b }
        if (r4 == 0) goto L_0x004e;
    L_0x0016:
        r4 = r7.mCallForwarding;	 Catch:{ all -> 0x004b }
        r4[r2] = r9;	 Catch:{ all -> 0x004b }
        r4 = r7.mRecords;	 Catch:{ all -> 0x004b }
        r1 = r4.iterator();	 Catch:{ all -> 0x004b }
    L_0x0020:
        r4 = r1.hasNext();	 Catch:{ all -> 0x004b }
        if (r4 == 0) goto L_0x004e;
    L_0x0026:
        r3 = r1.next();	 Catch:{ all -> 0x004b }
        r3 = (com.android.server.TelephonyRegistry.Record) r3;	 Catch:{ all -> 0x004b }
        r4 = 8;
        r4 = r3.matchPhoneStateListenerEvent(r4);	 Catch:{ all -> 0x004b }
        if (r4 == 0) goto L_0x0020;
    L_0x0034:
        r4 = r3.subId;	 Catch:{ all -> 0x004b }
        r4 = r7.idMatch(r4, r8, r2);	 Catch:{ all -> 0x004b }
        if (r4 == 0) goto L_0x0020;
    L_0x003c:
        r4 = r3.callback;	 Catch:{ RemoteException -> 0x0042 }
        r4.onCallForwardingIndicatorChanged(r9);	 Catch:{ RemoteException -> 0x0042 }
        goto L_0x0020;
    L_0x0042:
        r0 = move-exception;
        r4 = r7.mRemoveList;	 Catch:{ all -> 0x004b }
        r6 = r3.binder;	 Catch:{ all -> 0x004b }
        r4.add(r6);	 Catch:{ all -> 0x004b }
        goto L_0x0020;
    L_0x004b:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x004b }
        throw r4;
    L_0x004e:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x004b }
        monitor-exit(r5);	 Catch:{ all -> 0x004b }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyCallForwardingChangedForSubscriber(int, boolean):void");
    }

    public void notifyDataActivity(int state) {
        notifyDataActivityForSubscriber(Integer.MAX_VALUE, state);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyDataActivityForSubscriber(int r8, int r9) {
        /*
        r7 = this;
        r4 = "notifyDataActivity()";
        r4 = r7.checkNotifyPermission(r4);
        if (r4 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r5 = r7.mRecords;
        monitor-enter(r5);
        r2 = android.telephony.SubscriptionManager.getPhoneId(r8);	 Catch:{ all -> 0x0043 }
        r4 = r7.validatePhoneId(r2);	 Catch:{ all -> 0x0043 }
        if (r4 == 0) goto L_0x0046;
    L_0x0016:
        r4 = r7.mDataActivity;	 Catch:{ all -> 0x0043 }
        r4[r2] = r9;	 Catch:{ all -> 0x0043 }
        r4 = r7.mRecords;	 Catch:{ all -> 0x0043 }
        r1 = r4.iterator();	 Catch:{ all -> 0x0043 }
    L_0x0020:
        r4 = r1.hasNext();	 Catch:{ all -> 0x0043 }
        if (r4 == 0) goto L_0x0046;
    L_0x0026:
        r3 = r1.next();	 Catch:{ all -> 0x0043 }
        r3 = (com.android.server.TelephonyRegistry.Record) r3;	 Catch:{ all -> 0x0043 }
        r4 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r4 = r3.matchPhoneStateListenerEvent(r4);	 Catch:{ all -> 0x0043 }
        if (r4 == 0) goto L_0x0020;
    L_0x0034:
        r4 = r3.callback;	 Catch:{ RemoteException -> 0x003a }
        r4.onDataActivity(r9);	 Catch:{ RemoteException -> 0x003a }
        goto L_0x0020;
    L_0x003a:
        r0 = move-exception;
        r4 = r7.mRemoveList;	 Catch:{ all -> 0x0043 }
        r6 = r3.binder;	 Catch:{ all -> 0x0043 }
        r4.add(r6);	 Catch:{ all -> 0x0043 }
        goto L_0x0020;
    L_0x0043:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0043 }
        throw r4;
    L_0x0046:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x0043 }
        monitor-exit(r5);	 Catch:{ all -> 0x0043 }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyDataActivityForSubscriber(int, int):void");
    }

    public void notifyDataConnection(int state, boolean isDataConnectivityPossible, String reason, String apn, String apnType, LinkProperties linkProperties, NetworkCapabilities networkCapabilities, int networkType, boolean roaming) {
        notifyDataConnectionForSubscriber(Integer.MAX_VALUE, state, isDataConnectivityPossible, reason, apn, apnType, linkProperties, networkCapabilities, networkType, roaming);
    }

    public void notifyDataConnectionForSubscriber(int subId, int state, boolean isDataConnectivityPossible, String reason, String apn, String apnType, LinkProperties linkProperties, NetworkCapabilities networkCapabilities, int networkType, boolean roaming) {
        if (checkNotifyPermission("notifyDataConnection()")) {
            synchronized (this.mRecords) {
                int phoneId = SubscriptionManager.getPhoneId(subId);
                if (validatePhoneId(phoneId)) {
                    Iterator i$;
                    Record r;
                    boolean modified = DBG_LOC;
                    if (state == MSG_UPDATE_DEFAULT_SUB) {
                        if (!this.mConnectedApns.contains(apnType)) {
                            this.mConnectedApns.add(apnType);
                            if (this.mDataConnectionState[phoneId] != state) {
                                this.mDataConnectionState[phoneId] = state;
                                modified = true;
                            }
                        }
                    } else if (this.mConnectedApns.remove(apnType) && this.mConnectedApns.isEmpty()) {
                        this.mDataConnectionState[phoneId] = state;
                        modified = true;
                    }
                    this.mDataConnectionPossible[phoneId] = isDataConnectivityPossible;
                    this.mDataConnectionReason[phoneId] = reason;
                    this.mDataConnectionLinkProperties[phoneId] = linkProperties;
                    this.mDataConnectionNetworkCapabilities[phoneId] = networkCapabilities;
                    if (this.mDataConnectionNetworkType[phoneId] != networkType) {
                        this.mDataConnectionNetworkType[phoneId] = networkType;
                        modified = true;
                    }
                    if (modified) {
                        i$ = this.mRecords.iterator();
                        while (i$.hasNext()) {
                            r = (Record) i$.next();
                            if (r.matchPhoneStateListenerEvent(64)) {
                                if (idMatch(r.subId, subId, phoneId)) {
                                    try {
                                        log("Notify data connection state changed on sub: " + subId);
                                        r.callback.onDataConnectionStateChanged(this.mDataConnectionState[phoneId], this.mDataConnectionNetworkType[phoneId]);
                                    } catch (RemoteException e) {
                                        this.mRemoveList.add(r.binder);
                                    }
                                } else {
                                    continue;
                                }
                            }
                        }
                        handleRemoveListLocked();
                    }
                    this.mPreciseDataConnectionState = new PreciseDataConnectionState(state, networkType, apnType, apn, reason, linkProperties, "");
                    i$ = this.mRecords.iterator();
                    while (i$.hasNext()) {
                        r = (Record) i$.next();
                        if (r.matchPhoneStateListenerEvent(DumpState.DUMP_VERSION)) {
                            try {
                                r.callback.onPreciseDataConnectionStateChanged(this.mPreciseDataConnectionState);
                            } catch (RemoteException e2) {
                                this.mRemoveList.add(r.binder);
                            }
                        }
                    }
                }
                handleRemoveListLocked();
            }
            broadcastDataConnectionStateChanged(state, isDataConnectivityPossible, reason, apn, apnType, linkProperties, networkCapabilities, roaming, subId);
            broadcastPreciseDataConnectionStateChanged(state, networkType, apnType, apn, reason, linkProperties, "");
        }
    }

    public void notifyDataConnectionFailed(String reason, String apnType) {
        notifyDataConnectionFailedForSubscriber(Integer.MAX_VALUE, reason, apnType);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyDataConnectionFailedForSubscriber(int r13, java.lang.String r14, java.lang.String r15) {
        /*
        r12 = this;
        r0 = "notifyDataConnectionFailed()";
        r0 = r12.checkNotifyPermission(r0);
        if (r0 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r11 = r12.mRecords;
        monitor-enter(r11);
        r0 = new android.telephony.PreciseDataConnectionState;	 Catch:{ all -> 0x0047 }
        r1 = -1;
        r2 = 0;
        r4 = "";
        r6 = 0;
        r7 = "";
        r3 = r15;
        r5 = r14;
        r0.<init>(r1, r2, r3, r4, r5, r6, r7);	 Catch:{ all -> 0x0047 }
        r12.mPreciseDataConnectionState = r0;	 Catch:{ all -> 0x0047 }
        r0 = r12.mRecords;	 Catch:{ all -> 0x0047 }
        r9 = r0.iterator();	 Catch:{ all -> 0x0047 }
    L_0x0022:
        r0 = r9.hasNext();	 Catch:{ all -> 0x0047 }
        if (r0 == 0) goto L_0x004a;
    L_0x0028:
        r10 = r9.next();	 Catch:{ all -> 0x0047 }
        r10 = (com.android.server.TelephonyRegistry.Record) r10;	 Catch:{ all -> 0x0047 }
        r0 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r0 = r10.matchPhoneStateListenerEvent(r0);	 Catch:{ all -> 0x0047 }
        if (r0 == 0) goto L_0x0022;
    L_0x0036:
        r0 = r10.callback;	 Catch:{ RemoteException -> 0x003e }
        r1 = r12.mPreciseDataConnectionState;	 Catch:{ RemoteException -> 0x003e }
        r0.onPreciseDataConnectionStateChanged(r1);	 Catch:{ RemoteException -> 0x003e }
        goto L_0x0022;
    L_0x003e:
        r8 = move-exception;
        r0 = r12.mRemoveList;	 Catch:{ all -> 0x0047 }
        r1 = r10.binder;	 Catch:{ all -> 0x0047 }
        r0.add(r1);	 Catch:{ all -> 0x0047 }
        goto L_0x0022;
    L_0x0047:
        r0 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0047 }
        throw r0;
    L_0x004a:
        r12.handleRemoveListLocked();	 Catch:{ all -> 0x0047 }
        monitor-exit(r11);	 Catch:{ all -> 0x0047 }
        r12.broadcastDataConnectionFailed(r14, r15, r13);
        r1 = -1;
        r2 = 0;
        r4 = "";
        r6 = 0;
        r7 = "";
        r0 = r12;
        r3 = r15;
        r5 = r14;
        r0.broadcastPreciseDataConnectionStateChanged(r1, r2, r3, r4, r5, r6, r7);
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyDataConnectionFailedForSubscriber(int, java.lang.String, java.lang.String):void");
    }

    public void notifyCellLocation(Bundle cellLocation) {
        notifyCellLocationForSubscriber(Integer.MAX_VALUE, cellLocation);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyCellLocationForSubscriber(int r8, android.os.Bundle r9) {
        /*
        r7 = this;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "notifyCellLocationForSubscriber: subId=";
        r4 = r4.append(r5);
        r4 = r4.append(r8);
        r5 = " cellLocation=";
        r4 = r4.append(r5);
        r4 = r4.append(r9);
        r4 = r4.toString();
        log(r4);
        r4 = "notifyCellLocation()";
        r4 = r7.checkNotifyPermission(r4);
        if (r4 != 0) goto L_0x0029;
    L_0x0028:
        return;
    L_0x0029:
        r5 = r7.mRecords;
        monitor-enter(r5);
        r2 = android.telephony.SubscriptionManager.getPhoneId(r8);	 Catch:{ all -> 0x0070 }
        r4 = r7.validatePhoneId(r2);	 Catch:{ all -> 0x0070 }
        if (r4 == 0) goto L_0x0073;
    L_0x0036:
        r4 = r7.mCellLocation;	 Catch:{ all -> 0x0070 }
        r4[r2] = r9;	 Catch:{ all -> 0x0070 }
        r4 = r7.mRecords;	 Catch:{ all -> 0x0070 }
        r1 = r4.iterator();	 Catch:{ all -> 0x0070 }
    L_0x0040:
        r4 = r1.hasNext();	 Catch:{ all -> 0x0070 }
        if (r4 == 0) goto L_0x0073;
    L_0x0046:
        r3 = r1.next();	 Catch:{ all -> 0x0070 }
        r3 = (com.android.server.TelephonyRegistry.Record) r3;	 Catch:{ all -> 0x0070 }
        r4 = 16;
        r4 = r7.validateEventsAndUserLocked(r3, r4);	 Catch:{ all -> 0x0070 }
        if (r4 == 0) goto L_0x0040;
    L_0x0054:
        r4 = r3.subId;	 Catch:{ all -> 0x0070 }
        r4 = r7.idMatch(r4, r8, r2);	 Catch:{ all -> 0x0070 }
        if (r4 == 0) goto L_0x0040;
    L_0x005c:
        r4 = r3.callback;	 Catch:{ RemoteException -> 0x0067 }
        r6 = new android.os.Bundle;	 Catch:{ RemoteException -> 0x0067 }
        r6.<init>(r9);	 Catch:{ RemoteException -> 0x0067 }
        r4.onCellLocationChanged(r6);	 Catch:{ RemoteException -> 0x0067 }
        goto L_0x0040;
    L_0x0067:
        r0 = move-exception;
        r4 = r7.mRemoveList;	 Catch:{ all -> 0x0070 }
        r6 = r3.binder;	 Catch:{ all -> 0x0070 }
        r4.add(r6);	 Catch:{ all -> 0x0070 }
        goto L_0x0040;
    L_0x0070:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0070 }
        throw r4;
    L_0x0073:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x0070 }
        monitor-exit(r5);	 Catch:{ all -> 0x0070 }
        goto L_0x0028;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyCellLocationForSubscriber(int, android.os.Bundle):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyOtaspChanged(int r7) {
        /*
        r6 = this;
        r3 = "notifyOtaspChanged()";
        r3 = r6.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r4 = r6.mRecords;
        monitor-enter(r4);
        r6.mOtaspMode = r7;	 Catch:{ all -> 0x0037 }
        r3 = r6.mRecords;	 Catch:{ all -> 0x0037 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0037 }
    L_0x0014:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0037 }
        if (r3 == 0) goto L_0x003a;
    L_0x001a:
        r2 = r1.next();	 Catch:{ all -> 0x0037 }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x0037 }
        r3 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        r3 = r2.matchPhoneStateListenerEvent(r3);	 Catch:{ all -> 0x0037 }
        if (r3 == 0) goto L_0x0014;
    L_0x0028:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x002e }
        r3.onOtaspChanged(r7);	 Catch:{ RemoteException -> 0x002e }
        goto L_0x0014;
    L_0x002e:
        r0 = move-exception;
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0037 }
        r5 = r2.binder;	 Catch:{ all -> 0x0037 }
        r3.add(r5);	 Catch:{ all -> 0x0037 }
        goto L_0x0014;
    L_0x0037:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        throw r3;
    L_0x003a:
        r6.handleRemoveListLocked();	 Catch:{ all -> 0x0037 }
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyOtaspChanged(int):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyPreciseCallState(int r12, int r13, int r14) {
        /*
        r11 = this;
        r10 = -1;
        r0 = "notifyPreciseCallState()";
        r0 = r11.checkNotifyPermission(r0);
        if (r0 != 0) goto L_0x000a;
    L_0x0009:
        return;
    L_0x000a:
        r9 = r11.mRecords;
        monitor-enter(r9);
        r11.mRingingCallState = r12;	 Catch:{ all -> 0x004a }
        r11.mForegroundCallState = r13;	 Catch:{ all -> 0x004a }
        r11.mBackgroundCallState = r14;	 Catch:{ all -> 0x004a }
        r0 = new android.telephony.PreciseCallState;	 Catch:{ all -> 0x004a }
        r4 = -1;
        r5 = -1;
        r1 = r12;
        r2 = r13;
        r3 = r14;
        r0.<init>(r1, r2, r3, r4, r5);	 Catch:{ all -> 0x004a }
        r11.mPreciseCallState = r0;	 Catch:{ all -> 0x004a }
        r0 = r11.mRecords;	 Catch:{ all -> 0x004a }
        r7 = r0.iterator();	 Catch:{ all -> 0x004a }
    L_0x0025:
        r0 = r7.hasNext();	 Catch:{ all -> 0x004a }
        if (r0 == 0) goto L_0x004d;
    L_0x002b:
        r8 = r7.next();	 Catch:{ all -> 0x004a }
        r8 = (com.android.server.TelephonyRegistry.Record) r8;	 Catch:{ all -> 0x004a }
        r0 = 2048; // 0x800 float:2.87E-42 double:1.0118E-320;
        r0 = r8.matchPhoneStateListenerEvent(r0);	 Catch:{ all -> 0x004a }
        if (r0 == 0) goto L_0x0025;
    L_0x0039:
        r0 = r8.callback;	 Catch:{ RemoteException -> 0x0041 }
        r1 = r11.mPreciseCallState;	 Catch:{ RemoteException -> 0x0041 }
        r0.onPreciseCallStateChanged(r1);	 Catch:{ RemoteException -> 0x0041 }
        goto L_0x0025;
    L_0x0041:
        r6 = move-exception;
        r0 = r11.mRemoveList;	 Catch:{ all -> 0x004a }
        r1 = r8.binder;	 Catch:{ all -> 0x004a }
        r0.add(r1);	 Catch:{ all -> 0x004a }
        goto L_0x0025;
    L_0x004a:
        r0 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x004a }
        throw r0;
    L_0x004d:
        r11.handleRemoveListLocked();	 Catch:{ all -> 0x004a }
        monitor-exit(r9);	 Catch:{ all -> 0x004a }
        r0 = r11;
        r1 = r12;
        r2 = r13;
        r3 = r14;
        r4 = r10;
        r5 = r10;
        r0.broadcastPreciseCallStateChanged(r1, r2, r3, r4, r5);
        goto L_0x0009;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyPreciseCallState(int, int, int):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyDisconnectCause(int r11, int r12) {
        /*
        r10 = this;
        r0 = "notifyDisconnectCause()";
        r0 = r10.checkNotifyPermission(r0);
        if (r0 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r9 = r10.mRecords;
        monitor-enter(r9);
        r0 = new android.telephony.PreciseCallState;	 Catch:{ all -> 0x0046 }
        r1 = r10.mRingingCallState;	 Catch:{ all -> 0x0046 }
        r2 = r10.mForegroundCallState;	 Catch:{ all -> 0x0046 }
        r3 = r10.mBackgroundCallState;	 Catch:{ all -> 0x0046 }
        r4 = r11;
        r5 = r12;
        r0.<init>(r1, r2, r3, r4, r5);	 Catch:{ all -> 0x0046 }
        r10.mPreciseCallState = r0;	 Catch:{ all -> 0x0046 }
        r0 = r10.mRecords;	 Catch:{ all -> 0x0046 }
        r7 = r0.iterator();	 Catch:{ all -> 0x0046 }
    L_0x0021:
        r0 = r7.hasNext();	 Catch:{ all -> 0x0046 }
        if (r0 == 0) goto L_0x0049;
    L_0x0027:
        r8 = r7.next();	 Catch:{ all -> 0x0046 }
        r8 = (com.android.server.TelephonyRegistry.Record) r8;	 Catch:{ all -> 0x0046 }
        r0 = 2048; // 0x800 float:2.87E-42 double:1.0118E-320;
        r0 = r8.matchPhoneStateListenerEvent(r0);	 Catch:{ all -> 0x0046 }
        if (r0 == 0) goto L_0x0021;
    L_0x0035:
        r0 = r8.callback;	 Catch:{ RemoteException -> 0x003d }
        r1 = r10.mPreciseCallState;	 Catch:{ RemoteException -> 0x003d }
        r0.onPreciseCallStateChanged(r1);	 Catch:{ RemoteException -> 0x003d }
        goto L_0x0021;
    L_0x003d:
        r6 = move-exception;
        r0 = r10.mRemoveList;	 Catch:{ all -> 0x0046 }
        r1 = r8.binder;	 Catch:{ all -> 0x0046 }
        r0.add(r1);	 Catch:{ all -> 0x0046 }
        goto L_0x0021;
    L_0x0046:
        r0 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x0046 }
        throw r0;
    L_0x0049:
        r10.handleRemoveListLocked();	 Catch:{ all -> 0x0046 }
        monitor-exit(r9);	 Catch:{ all -> 0x0046 }
        r1 = r10.mRingingCallState;
        r2 = r10.mForegroundCallState;
        r3 = r10.mBackgroundCallState;
        r0 = r10;
        r4 = r11;
        r5 = r12;
        r0.broadcastPreciseCallStateChanged(r1, r2, r3, r4, r5);
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyDisconnectCause(int, int):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyPreciseDataConnectionFailed(java.lang.String r13, java.lang.String r14, java.lang.String r15, java.lang.String r16) {
        /*
        r12 = this;
        r0 = "notifyPreciseDataConnectionFailed()";
        r0 = r12.checkNotifyPermission(r0);
        if (r0 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r11 = r12.mRecords;
        monitor-enter(r11);
        r0 = new android.telephony.PreciseDataConnectionState;	 Catch:{ all -> 0x0046 }
        r1 = -1;
        r2 = 0;
        r6 = 0;
        r3 = r14;
        r4 = r15;
        r5 = r13;
        r7 = r16;
        r0.<init>(r1, r2, r3, r4, r5, r6, r7);	 Catch:{ all -> 0x0046 }
        r12.mPreciseDataConnectionState = r0;	 Catch:{ all -> 0x0046 }
        r0 = r12.mRecords;	 Catch:{ all -> 0x0046 }
        r9 = r0.iterator();	 Catch:{ all -> 0x0046 }
    L_0x0021:
        r0 = r9.hasNext();	 Catch:{ all -> 0x0046 }
        if (r0 == 0) goto L_0x0049;
    L_0x0027:
        r10 = r9.next();	 Catch:{ all -> 0x0046 }
        r10 = (com.android.server.TelephonyRegistry.Record) r10;	 Catch:{ all -> 0x0046 }
        r0 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r0 = r10.matchPhoneStateListenerEvent(r0);	 Catch:{ all -> 0x0046 }
        if (r0 == 0) goto L_0x0021;
    L_0x0035:
        r0 = r10.callback;	 Catch:{ RemoteException -> 0x003d }
        r1 = r12.mPreciseDataConnectionState;	 Catch:{ RemoteException -> 0x003d }
        r0.onPreciseDataConnectionStateChanged(r1);	 Catch:{ RemoteException -> 0x003d }
        goto L_0x0021;
    L_0x003d:
        r8 = move-exception;
        r0 = r12.mRemoveList;	 Catch:{ all -> 0x0046 }
        r1 = r10.binder;	 Catch:{ all -> 0x0046 }
        r0.add(r1);	 Catch:{ all -> 0x0046 }
        goto L_0x0021;
    L_0x0046:
        r0 = move-exception;
        monitor-exit(r11);	 Catch:{ all -> 0x0046 }
        throw r0;
    L_0x0049:
        r12.handleRemoveListLocked();	 Catch:{ all -> 0x0046 }
        monitor-exit(r11);	 Catch:{ all -> 0x0046 }
        r1 = -1;
        r2 = 0;
        r6 = 0;
        r0 = r12;
        r3 = r14;
        r4 = r15;
        r5 = r13;
        r7 = r16;
        r0.broadcastPreciseDataConnectionStateChanged(r1, r2, r3, r4, r5, r6, r7);
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyPreciseDataConnectionFailed(java.lang.String, java.lang.String, java.lang.String, java.lang.String):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyVoLteServiceStateChanged(android.telephony.VoLteServiceState r8) {
        /*
        r7 = this;
        r3 = "notifyVoLteServiceStateChanged()";
        r3 = r7.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r4 = r7.mRecords;
        monitor-enter(r4);
        r7.mVoLteServiceState = r8;	 Catch:{ all -> 0x003e }
        r3 = r7.mRecords;	 Catch:{ all -> 0x003e }
        r1 = r3.iterator();	 Catch:{ all -> 0x003e }
    L_0x0014:
        r3 = r1.hasNext();	 Catch:{ all -> 0x003e }
        if (r3 == 0) goto L_0x0041;
    L_0x001a:
        r2 = r1.next();	 Catch:{ all -> 0x003e }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x003e }
        r3 = 16384; // 0x4000 float:2.2959E-41 double:8.0948E-320;
        r3 = r2.matchPhoneStateListenerEvent(r3);	 Catch:{ all -> 0x003e }
        if (r3 == 0) goto L_0x0014;
    L_0x0028:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x0035 }
        r5 = new android.telephony.VoLteServiceState;	 Catch:{ RemoteException -> 0x0035 }
        r6 = r7.mVoLteServiceState;	 Catch:{ RemoteException -> 0x0035 }
        r5.<init>(r6);	 Catch:{ RemoteException -> 0x0035 }
        r3.onVoLteServiceStateChanged(r5);	 Catch:{ RemoteException -> 0x0035 }
        goto L_0x0014;
    L_0x0035:
        r0 = move-exception;
        r3 = r7.mRemoveList;	 Catch:{ all -> 0x003e }
        r5 = r2.binder;	 Catch:{ all -> 0x003e }
        r3.add(r5);	 Catch:{ all -> 0x003e }
        goto L_0x0014;
    L_0x003e:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x003e }
        throw r3;
    L_0x0041:
        r7.handleRemoveListLocked();	 Catch:{ all -> 0x003e }
        monitor-exit(r4);	 Catch:{ all -> 0x003e }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyVoLteServiceStateChanged(android.telephony.VoLteServiceState):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void notifyOemHookRawEventForSubscriber(int r7, byte[] r8) {
        /*
        r6 = this;
        r3 = "notifyOemHookRawEventForSubscriber";
        r3 = r6.checkNotifyPermission(r3);
        if (r3 != 0) goto L_0x0009;
    L_0x0008:
        return;
    L_0x0009:
        r4 = r6.mRecords;
        monitor-enter(r4);
        r3 = r6.mRecords;	 Catch:{ all -> 0x0041 }
        r1 = r3.iterator();	 Catch:{ all -> 0x0041 }
    L_0x0012:
        r3 = r1.hasNext();	 Catch:{ all -> 0x0041 }
        if (r3 == 0) goto L_0x0044;
    L_0x0018:
        r2 = r1.next();	 Catch:{ all -> 0x0041 }
        r2 = (com.android.server.TelephonyRegistry.Record) r2;	 Catch:{ all -> 0x0041 }
        r3 = 32768; // 0x8000 float:4.5918E-41 double:1.61895E-319;
        r3 = r2.matchPhoneStateListenerEvent(r3);	 Catch:{ all -> 0x0041 }
        if (r3 == 0) goto L_0x0012;
    L_0x0027:
        r3 = r2.subId;	 Catch:{ all -> 0x0041 }
        if (r3 == r7) goto L_0x0032;
    L_0x002b:
        r3 = r2.subId;	 Catch:{ all -> 0x0041 }
        r5 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        if (r3 != r5) goto L_0x0012;
    L_0x0032:
        r3 = r2.callback;	 Catch:{ RemoteException -> 0x0038 }
        r3.onOemHookRawEvent(r8);	 Catch:{ RemoteException -> 0x0038 }
        goto L_0x0012;
    L_0x0038:
        r0 = move-exception;
        r3 = r6.mRemoveList;	 Catch:{ all -> 0x0041 }
        r5 = r2.binder;	 Catch:{ all -> 0x0041 }
        r3.add(r5);	 Catch:{ all -> 0x0041 }
        goto L_0x0012;
    L_0x0041:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0041 }
        throw r3;
    L_0x0044:
        r6.handleRemoveListLocked();	 Catch:{ all -> 0x0041 }
        monitor-exit(r4);	 Catch:{ all -> 0x0041 }
        goto L_0x0008;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.TelephonyRegistry.notifyOemHookRawEventForSubscriber(int, byte[]):void");
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump telephony.registry from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mRecords) {
            int recordCount = this.mRecords.size();
            pw.println("last known state:");
            for (int i = 0; i < TelephonyManager.getDefault().getPhoneCount(); i += MSG_USER_SWITCHED) {
                pw.println("  Phone Id=" + i);
                pw.println("  mCallState=" + this.mCallState[i]);
                pw.println("  mCallIncomingNumber=" + this.mCallIncomingNumber[i]);
                pw.println("  mServiceState=" + this.mServiceState[i]);
                pw.println("  mSignalStrength=" + this.mSignalStrength[i]);
                pw.println("  mMessageWaiting=" + this.mMessageWaiting[i]);
                pw.println("  mCallForwarding=" + this.mCallForwarding[i]);
                pw.println("  mDataActivity=" + this.mDataActivity[i]);
                pw.println("  mDataConnectionState=" + this.mDataConnectionState[i]);
                pw.println("  mDataConnectionPossible=" + this.mDataConnectionPossible[i]);
                pw.println("  mDataConnectionReason=" + this.mDataConnectionReason[i]);
                pw.println("  mDataConnectionApn=" + this.mDataConnectionApn[i]);
                pw.println("  mDataConnectionLinkProperties=" + this.mDataConnectionLinkProperties[i]);
                pw.println("  mDataConnectionNetworkCapabilities=" + this.mDataConnectionNetworkCapabilities[i]);
                pw.println("  mCellLocation=" + this.mCellLocation[i]);
                pw.println("  mCellInfo=" + this.mCellInfo.get(i));
            }
            pw.println("  mDcRtInfo=" + this.mDcRtInfo);
            pw.println("registrations: count=" + recordCount);
            Iterator i$ = this.mRecords.iterator();
            while (i$.hasNext()) {
                pw.println("  " + ((Record) i$.next()));
            }
        }
    }

    private void broadcastServiceStateChanged(ServiceState state, int subId) {
        long ident = Binder.clearCallingIdentity();
        try {
            this.mBatteryStats.notePhoneState(state.getState());
        } catch (RemoteException e) {
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
        Intent intent = new Intent("android.intent.action.SERVICE_STATE");
        Bundle data = new Bundle();
        state.fillInNotifierBundle(data);
        intent.putExtras(data);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void broadcastSignalStrengthChanged(SignalStrength signalStrength, int subId) {
        long ident = Binder.clearCallingIdentity();
        try {
            this.mBatteryStats.notePhoneSignalStrength(signalStrength);
        } catch (RemoteException e) {
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
        Intent intent = new Intent("android.intent.action.SIG_STR");
        intent.addFlags(536870912);
        Bundle data = new Bundle();
        signalStrength.fillInNotifierBundle(data);
        intent.putExtras(data);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void broadcastCallStateChanged(int state, String incomingNumber, int subId) {
        long ident = Binder.clearCallingIdentity();
        if (state == 0) {
            try {
                this.mBatteryStats.notePhoneOff();
            } catch (RemoteException e) {
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        } else {
            this.mBatteryStats.notePhoneOn();
        }
        Binder.restoreCallingIdentity(ident);
        Intent intent = new Intent("android.intent.action.PHONE_STATE");
        intent.putExtra("state", DefaultPhoneNotifier.convertCallState(state).toString());
        if (!TextUtils.isEmpty(incomingNumber)) {
            intent.putExtra("incoming_number", incomingNumber);
        }
        intent.putExtra("subscription", subId);
        this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL, "android.permission.READ_PHONE_STATE");
    }

    private void broadcastDataConnectionStateChanged(int state, boolean isDataConnectivityPossible, String reason, String apn, String apnType, LinkProperties linkProperties, NetworkCapabilities networkCapabilities, boolean roaming, int subId) {
        Intent intent = new Intent("android.intent.action.ANY_DATA_STATE");
        intent.putExtra("state", DefaultPhoneNotifier.convertDataState(state).toString());
        if (!isDataConnectivityPossible) {
            intent.putExtra("networkUnvailable", true);
        }
        if (reason != null) {
            intent.putExtra("reason", reason);
        }
        if (linkProperties != null) {
            intent.putExtra("linkProperties", linkProperties);
            String iface = linkProperties.getInterfaceName();
            if (iface != null) {
                intent.putExtra("iface", iface);
            }
        }
        if (networkCapabilities != null) {
            intent.putExtra("networkCapabilities", networkCapabilities);
        }
        if (roaming) {
            intent.putExtra("networkRoaming", true);
        }
        intent.putExtra("apn", apn);
        intent.putExtra("apnType", apnType);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void broadcastDataConnectionFailed(String reason, String apnType, int subId) {
        Intent intent = new Intent("android.intent.action.DATA_CONNECTION_FAILED");
        intent.putExtra("reason", reason);
        intent.putExtra("apnType", apnType);
        intent.putExtra("subscription", subId);
        this.mContext.sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void broadcastPreciseCallStateChanged(int ringingCallState, int foregroundCallState, int backgroundCallState, int disconnectCause, int preciseDisconnectCause) {
        Intent intent = new Intent("android.intent.action.PRECISE_CALL_STATE");
        intent.putExtra("ringing_state", ringingCallState);
        intent.putExtra("foreground_state", foregroundCallState);
        intent.putExtra("background_state", backgroundCallState);
        intent.putExtra("disconnect_cause", disconnectCause);
        intent.putExtra("precise_disconnect_cause", preciseDisconnectCause);
        this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL, "android.permission.READ_PRECISE_PHONE_STATE");
    }

    private void broadcastPreciseDataConnectionStateChanged(int state, int networkType, String apnType, String apn, String reason, LinkProperties linkProperties, String failCause) {
        Intent intent = new Intent("android.intent.action.PRECISE_DATA_CONNECTION_STATE_CHANGED");
        intent.putExtra("state", state);
        intent.putExtra("networkType", networkType);
        if (reason != null) {
            intent.putExtra("reason", reason);
        }
        if (apnType != null) {
            intent.putExtra("apnType", apnType);
        }
        if (apn != null) {
            intent.putExtra("apn", apn);
        }
        if (linkProperties != null) {
            intent.putExtra("linkProperties", linkProperties);
        }
        if (failCause != null) {
            intent.putExtra("failCause", failCause);
        }
        this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL, "android.permission.READ_PRECISE_PHONE_STATE");
    }

    private boolean checkNotifyPermission(String method) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.MODIFY_PHONE_STATE") == 0) {
            return true;
        }
        String msg = "Modify Phone State Permission Denial: " + method + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid();
        return DBG_LOC;
    }

    private void checkListenerPermission(int events) {
        if ((events & 16) != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_COARSE_LOCATION", null);
        }
        if ((events & DumpState.DUMP_PREFERRED_XML) != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_COARSE_LOCATION", null);
        }
        if ((events & PHONE_STATE_PERMISSION_MASK) != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PHONE_STATE", null);
        }
        if ((events & PRECISE_PHONE_STATE_PERMISSION_MASK) != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PRECISE_PHONE_STATE", null);
        }
        if ((32768 & events) != 0) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.READ_PRIVILEGED_PHONE_STATE", null);
        }
    }

    private void handleRemoveListLocked() {
        if (this.mRemoveList.size() > 0) {
            Iterator i$ = this.mRemoveList.iterator();
            while (i$.hasNext()) {
                remove((IBinder) i$.next());
            }
            this.mRemoveList.clear();
        }
    }

    private boolean validateEventsAndUserLocked(Record r, int events) {
        long callingIdentity = Binder.clearCallingIdentity();
        try {
            boolean valid = (r.callerUid == ActivityManager.getCurrentUser() && r.matchPhoneStateListenerEvent(events)) ? true : DBG_LOC;
            Binder.restoreCallingIdentity(callingIdentity);
            return valid;
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(callingIdentity);
        }
    }

    private boolean validatePhoneId(int phoneId) {
        return (phoneId < 0 || phoneId >= this.mNumPhones) ? DBG_LOC : true;
    }

    private static void log(String s) {
        Rlog.d(TAG, s);
    }

    private void logServiceStateChanged(String s, int subId, int phoneId, ServiceState state) {
        if (this.logSSC != null && this.logSSC.length != 0) {
            if (this.logSSC[this.next] == null) {
                this.logSSC[this.next] = new LogSSC();
            }
            Time t = new Time();
            t.setToNow();
            this.logSSC[this.next].set(t, s, subId, phoneId, state);
            int i = this.next + MSG_USER_SWITCHED;
            this.next = i;
            if (i >= this.logSSC.length) {
                this.next = 0;
            }
        }
    }

    private void toStringLogSSC(String prompt) {
        if (this.logSSC == null || this.logSSC.length == 0 || (this.next == 0 && this.logSSC[this.next] == null)) {
            log(prompt + ": logSSC is empty");
            return;
        }
        log(prompt + ": logSSC.length=" + this.logSSC.length + " next=" + this.next);
        int i = this.next;
        if (this.logSSC[i] == null) {
            i = 0;
        }
        do {
            log(this.logSSC[i].toString());
            i += MSG_USER_SWITCHED;
            if (i >= this.logSSC.length) {
                i = 0;
            }
        } while (i != this.next);
        log(prompt + ": ----------------");
    }

    boolean idMatch(int rSubId, int subId, int phoneId) {
        if (subId < 0) {
            if (this.mDefaultPhoneId == phoneId) {
                return true;
            }
            return DBG_LOC;
        } else if (rSubId == Integer.MAX_VALUE) {
            if (subId != this.mDefaultSubId) {
                return DBG_LOC;
            }
            return true;
        } else if (rSubId != subId) {
            return DBG_LOC;
        } else {
            return true;
        }
    }

    private void checkPossibleMissNotify(Record r, int phoneId) {
        int events = r.events;
        if ((events & MSG_USER_SWITCHED) != 0) {
            try {
                r.callback.onServiceStateChanged(new ServiceState(this.mServiceState[phoneId]));
            } catch (RemoteException e) {
                this.mRemoveList.add(r.binder);
            }
        }
        if ((events & DumpState.DUMP_VERIFIERS) != 0) {
            try {
                r.callback.onSignalStrengthsChanged(new SignalStrength(this.mSignalStrength[phoneId]));
            } catch (RemoteException e2) {
                this.mRemoveList.add(r.binder);
            }
        }
        if ((events & MSG_UPDATE_DEFAULT_SUB) != 0) {
            try {
                int gsmSignalStrength = this.mSignalStrength[phoneId].getGsmSignalStrength();
                IPhoneStateListener iPhoneStateListener = r.callback;
                if (gsmSignalStrength == 99) {
                    gsmSignalStrength = -1;
                }
                iPhoneStateListener.onSignalStrengthChanged(gsmSignalStrength);
            } catch (RemoteException e3) {
                this.mRemoveList.add(r.binder);
            }
        }
        if (validateEventsAndUserLocked(r, DumpState.DUMP_PREFERRED_XML)) {
            try {
                r.callback.onCellInfoChanged((List) this.mCellInfo.get(phoneId));
            } catch (RemoteException e4) {
                this.mRemoveList.add(r.binder);
            }
        }
        if ((events & 4) != 0) {
            try {
                r.callback.onMessageWaitingIndicatorChanged(this.mMessageWaiting[phoneId]);
            } catch (RemoteException e5) {
                this.mRemoveList.add(r.binder);
            }
        }
        if ((events & 8) != 0) {
            try {
                r.callback.onCallForwardingIndicatorChanged(this.mCallForwarding[phoneId]);
            } catch (RemoteException e6) {
                this.mRemoveList.add(r.binder);
            }
        }
        if (validateEventsAndUserLocked(r, 16)) {
            try {
                r.callback.onCellLocationChanged(new Bundle(this.mCellLocation[phoneId]));
            } catch (RemoteException e7) {
                this.mRemoveList.add(r.binder);
            }
        }
        if ((events & 64) != 0) {
            try {
                r.callback.onDataConnectionStateChanged(this.mDataConnectionState[phoneId], this.mDataConnectionNetworkType[phoneId]);
            } catch (RemoteException e8) {
                this.mRemoveList.add(r.binder);
            }
        }
    }
}
