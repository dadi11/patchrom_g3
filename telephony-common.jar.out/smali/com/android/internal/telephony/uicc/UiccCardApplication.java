package com.android.internal.telephony.uicc;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.telephony.Rlog;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.PersoSubState;
import com.android.internal.telephony.uicc.IccCardStatus.PinState;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class UiccCardApplication {
    public static final int AUTH_CONTEXT_EAP_AKA = 129;
    public static final int AUTH_CONTEXT_EAP_SIM = 128;
    public static final int AUTH_CONTEXT_UNDEFINED = -1;
    private static final boolean DBG = true;
    private static final int EVENT_CHANGE_FACILITY_FDN_DONE = 5;
    private static final int EVENT_CHANGE_FACILITY_LOCK_DONE = 7;
    private static final int EVENT_CHANGE_PIN1_DONE = 2;
    private static final int EVENT_CHANGE_PIN2_DONE = 3;
    private static final int EVENT_PIN1_PUK1_DONE = 1;
    private static final int EVENT_PIN2_PUK2_DONE = 8;
    private static final int EVENT_QUERY_FACILITY_FDN_DONE = 4;
    private static final int EVENT_QUERY_FACILITY_LOCK_DONE = 6;
    private static final int EVENT_RADIO_UNAVAILABLE = 9;
    private static final String LOG_TAG = "UiccCardApplication";
    private String mAid;
    private String mAppLabel;
    private AppState mAppState;
    private AppType mAppType;
    private int mAuthContext;
    private CommandsInterface mCi;
    private Context mContext;
    private boolean mDesiredFdnEnabled;
    private boolean mDesiredPinLocked;
    private boolean mDestroyed;
    private Handler mHandler;
    private boolean mIccFdnAvailable;
    private boolean mIccFdnEnabled;
    private IccFileHandler mIccFh;
    private boolean mIccLockEnabled;
    private IccRecords mIccRecords;
    private final Object mLock;
    private RegistrantList mNetworkLockedRegistrants;
    private PersoSubState mPersoSubState;
    private boolean mPin1Replaced;
    private PinState mPin1State;
    private PinState mPin2State;
    private RegistrantList mPinLockedRegistrants;
    private RegistrantList mReadyRegistrants;
    private UiccCard mUiccCard;

    /* renamed from: com.android.internal.telephony.uicc.UiccCardApplication.1 */
    class C00901 extends Handler {
        C00901() {
        }

        public void handleMessage(Message msg) {
            if (UiccCardApplication.this.mDestroyed) {
                UiccCardApplication.this.loge("Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
                return;
            }
            switch (msg.what) {
                case UiccCardApplication.EVENT_PIN1_PUK1_DONE /*1*/:
                case UiccCardApplication.EVENT_CHANGE_PIN1_DONE /*2*/:
                case UiccCardApplication.EVENT_CHANGE_PIN2_DONE /*3*/:
                case UiccCardApplication.EVENT_PIN2_PUK2_DONE /*8*/:
                    int attemptsRemaining = UiccCardApplication.AUTH_CONTEXT_UNDEFINED;
                    AsyncResult ar = msg.obj;
                    if (!(ar.exception == null || ar.result == null)) {
                        attemptsRemaining = UiccCardApplication.this.parsePinPukErrorResult(ar);
                    }
                    Message response = ar.userObj;
                    AsyncResult.forMessage(response).exception = ar.exception;
                    response.arg1 = attemptsRemaining;
                    response.sendToTarget();
                case UiccCardApplication.EVENT_QUERY_FACILITY_FDN_DONE /*4*/:
                    UiccCardApplication.this.onQueryFdnEnabled((AsyncResult) msg.obj);
                case UiccCardApplication.EVENT_CHANGE_FACILITY_FDN_DONE /*5*/:
                    UiccCardApplication.this.onChangeFdnDone((AsyncResult) msg.obj);
                case UiccCardApplication.EVENT_QUERY_FACILITY_LOCK_DONE /*6*/:
                    UiccCardApplication.this.onQueryFacilityLock((AsyncResult) msg.obj);
                case UiccCardApplication.EVENT_CHANGE_FACILITY_LOCK_DONE /*7*/:
                    UiccCardApplication.this.onChangeFacilityLock((AsyncResult) msg.obj);
                case UiccCardApplication.EVENT_RADIO_UNAVAILABLE /*9*/:
                    UiccCardApplication.this.log("handleMessage (EVENT_RADIO_UNAVAILABLE)");
                    UiccCardApplication.this.mAppState = AppState.APPSTATE_UNKNOWN;
                default:
                    UiccCardApplication.this.loge("Unknown Event " + msg.what);
            }
        }
    }

    /* renamed from: com.android.internal.telephony.uicc.UiccCardApplication.2 */
    static /* synthetic */ class C00912 {
        static final /* synthetic */ int[] f12x5a34abf5;
        static final /* synthetic */ int[] f13xe6a897ea;

        static {
            f13xe6a897ea = new int[PinState.values().length];
            try {
                f13xe6a897ea[PinState.PINSTATE_DISABLED.ordinal()] = UiccCardApplication.EVENT_PIN1_PUK1_DONE;
            } catch (NoSuchFieldError e) {
            }
            try {
                f13xe6a897ea[PinState.PINSTATE_ENABLED_NOT_VERIFIED.ordinal()] = UiccCardApplication.EVENT_CHANGE_PIN1_DONE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f13xe6a897ea[PinState.PINSTATE_ENABLED_VERIFIED.ordinal()] = UiccCardApplication.EVENT_CHANGE_PIN2_DONE;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f13xe6a897ea[PinState.PINSTATE_ENABLED_BLOCKED.ordinal()] = UiccCardApplication.EVENT_QUERY_FACILITY_FDN_DONE;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f13xe6a897ea[PinState.PINSTATE_ENABLED_PERM_BLOCKED.ordinal()] = UiccCardApplication.EVENT_CHANGE_FACILITY_FDN_DONE;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f13xe6a897ea[PinState.PINSTATE_UNKNOWN.ordinal()] = UiccCardApplication.EVENT_QUERY_FACILITY_LOCK_DONE;
            } catch (NoSuchFieldError e6) {
            }
            f12x5a34abf5 = new int[AppType.values().length];
            try {
                f12x5a34abf5[AppType.APPTYPE_SIM.ordinal()] = UiccCardApplication.EVENT_PIN1_PUK1_DONE;
            } catch (NoSuchFieldError e7) {
            }
            try {
                f12x5a34abf5[AppType.APPTYPE_RUIM.ordinal()] = UiccCardApplication.EVENT_CHANGE_PIN1_DONE;
            } catch (NoSuchFieldError e8) {
            }
            try {
                f12x5a34abf5[AppType.APPTYPE_USIM.ordinal()] = UiccCardApplication.EVENT_CHANGE_PIN2_DONE;
            } catch (NoSuchFieldError e9) {
            }
            try {
                f12x5a34abf5[AppType.APPTYPE_CSIM.ordinal()] = UiccCardApplication.EVENT_QUERY_FACILITY_FDN_DONE;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f12x5a34abf5[AppType.APPTYPE_ISIM.ordinal()] = UiccCardApplication.EVENT_CHANGE_FACILITY_FDN_DONE;
            } catch (NoSuchFieldError e11) {
            }
        }
    }

    UiccCardApplication(UiccCard uiccCard, IccCardApplicationStatus as, Context c, CommandsInterface ci) {
        boolean z = DBG;
        this.mLock = new Object();
        this.mIccFdnAvailable = DBG;
        this.mReadyRegistrants = new RegistrantList();
        this.mPinLockedRegistrants = new RegistrantList();
        this.mNetworkLockedRegistrants = new RegistrantList();
        this.mHandler = new C00901();
        log("Creating UiccApp: " + as);
        this.mUiccCard = uiccCard;
        this.mAppState = as.app_state;
        this.mAppType = as.app_type;
        this.mAuthContext = getAuthContext(this.mAppType);
        this.mPersoSubState = as.perso_substate;
        this.mAid = as.aid;
        this.mAppLabel = as.app_label;
        if (as.pin1_replaced == 0) {
            z = false;
        }
        this.mPin1Replaced = z;
        this.mPin1State = as.pin1;
        this.mPin2State = as.pin2;
        this.mContext = c;
        this.mCi = ci;
        this.mIccFh = createIccFileHandler(as.app_type);
        this.mIccRecords = createIccRecords(as.app_type, this.mContext, this.mCi);
        if (this.mAppState == AppState.APPSTATE_READY) {
            queryFdn();
            queryPin1State();
        }
        this.mCi.registerForNotAvailable(this.mHandler, EVENT_RADIO_UNAVAILABLE, null);
    }

    void update(IccCardApplicationStatus as, Context c, CommandsInterface ci) {
        synchronized (this.mLock) {
            if (this.mDestroyed) {
                loge("Application updated after destroyed! Fix me!");
                return;
            }
            log(this.mAppType + " update. New " + as);
            this.mContext = c;
            this.mCi = ci;
            AppType oldAppType = this.mAppType;
            AppState oldAppState = this.mAppState;
            PersoSubState oldPersoSubState = this.mPersoSubState;
            this.mAppType = as.app_type;
            this.mAuthContext = getAuthContext(this.mAppType);
            this.mAppState = as.app_state;
            this.mPersoSubState = as.perso_substate;
            this.mAid = as.aid;
            this.mAppLabel = as.app_label;
            this.mPin1Replaced = as.pin1_replaced != 0 ? DBG : false;
            this.mPin1State = as.pin1;
            this.mPin2State = as.pin2;
            if (this.mAppType != oldAppType) {
                if (this.mIccFh != null) {
                    this.mIccFh.dispose();
                }
                if (this.mIccRecords != null) {
                    this.mIccRecords.dispose();
                }
                this.mIccFh = createIccFileHandler(as.app_type);
                this.mIccRecords = createIccRecords(as.app_type, c, ci);
            }
            if (this.mPersoSubState != oldPersoSubState && this.mPersoSubState == PersoSubState.PERSOSUBSTATE_SIM_NETWORK) {
                notifyNetworkLockedRegistrantsIfNeeded(null);
            }
            if (this.mAppState != oldAppState) {
                log(oldAppType + " changed state: " + oldAppState + " -> " + this.mAppState);
                if (this.mAppState == AppState.APPSTATE_READY) {
                    queryFdn();
                    queryPin1State();
                }
                notifyPinLockedRegistrantsIfNeeded(null);
                notifyReadyRegistrantsIfNeeded(null);
            }
        }
    }

    void dispose() {
        synchronized (this.mLock) {
            log(this.mAppType + " being Disposed");
            this.mDestroyed = DBG;
            if (this.mIccRecords != null) {
                this.mIccRecords.dispose();
            }
            if (this.mIccFh != null) {
                this.mIccFh.dispose();
            }
            this.mIccRecords = null;
            this.mIccFh = null;
            this.mCi.unregisterForNotAvailable(this.mHandler);
        }
    }

    private IccRecords createIccRecords(AppType type, Context c, CommandsInterface ci) {
        if (type == AppType.APPTYPE_USIM || type == AppType.APPTYPE_SIM) {
            return new SIMRecords(this, c, ci);
        }
        if (type == AppType.APPTYPE_RUIM || type == AppType.APPTYPE_CSIM) {
            return new RuimRecords(this, c, ci);
        }
        if (type == AppType.APPTYPE_ISIM) {
            return new IsimUiccRecords(this, c, ci);
        }
        return null;
    }

    private IccFileHandler createIccFileHandler(AppType type) {
        switch (C00912.f12x5a34abf5[type.ordinal()]) {
            case EVENT_PIN1_PUK1_DONE /*1*/:
                return new SIMFileHandler(this, this.mAid, this.mCi);
            case EVENT_CHANGE_PIN1_DONE /*2*/:
                return new RuimFileHandler(this, this.mAid, this.mCi);
            case EVENT_CHANGE_PIN2_DONE /*3*/:
                return new UsimFileHandler(this, this.mAid, this.mCi);
            case EVENT_QUERY_FACILITY_FDN_DONE /*4*/:
                return new CsimFileHandler(this, this.mAid, this.mCi);
            case EVENT_CHANGE_FACILITY_FDN_DONE /*5*/:
                return new IsimFileHandler(this, this.mAid, this.mCi);
            default:
                return null;
        }
    }

    void queryFdn() {
        this.mCi.queryFacilityLockForApp(CommandsInterface.CB_FACILITY_BA_FD, "", EVENT_CHANGE_FACILITY_LOCK_DONE, this.mAid, this.mHandler.obtainMessage(EVENT_QUERY_FACILITY_FDN_DONE));
    }

    private void onQueryFdnEnabled(AsyncResult ar) {
        synchronized (this.mLock) {
            if (ar.exception != null) {
                log("Error in querying facility lock:" + ar.exception);
                return;
            }
            int[] result = (int[]) ar.result;
            if (result.length != 0) {
                if (result[0] == EVENT_CHANGE_PIN1_DONE) {
                    this.mIccFdnEnabled = false;
                    this.mIccFdnAvailable = false;
                } else {
                    boolean z;
                    if (result[0] == EVENT_PIN1_PUK1_DONE) {
                        z = DBG;
                    } else {
                        z = false;
                    }
                    this.mIccFdnEnabled = z;
                    this.mIccFdnAvailable = DBG;
                }
                log("Query facility FDN : FDN service available: " + this.mIccFdnAvailable + " enabled: " + this.mIccFdnEnabled);
            } else {
                loge("Bogus facility lock response");
            }
        }
    }

    private void onChangeFdnDone(AsyncResult ar) {
        synchronized (this.mLock) {
            int attemptsRemaining = AUTH_CONTEXT_UNDEFINED;
            if (ar.exception == null) {
                this.mIccFdnEnabled = this.mDesiredFdnEnabled;
                log("EVENT_CHANGE_FACILITY_FDN_DONE: mIccFdnEnabled=" + this.mIccFdnEnabled);
            } else {
                attemptsRemaining = parsePinPukErrorResult(ar);
                loge("Error change facility fdn with exception " + ar.exception);
            }
            Message response = ar.userObj;
            response.arg1 = attemptsRemaining;
            AsyncResult.forMessage(response).exception = ar.exception;
            response.sendToTarget();
        }
    }

    private void queryPin1State() {
        this.mCi.queryFacilityLockForApp(CommandsInterface.CB_FACILITY_BA_SIM, "", EVENT_CHANGE_FACILITY_LOCK_DONE, this.mAid, this.mHandler.obtainMessage(EVENT_QUERY_FACILITY_LOCK_DONE));
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void onQueryFacilityLock(android.os.AsyncResult r7) {
        /*
        r6 = this;
        r3 = 0;
        r4 = r6.mLock;
        monitor-enter(r4);
        r2 = r7.exception;	 Catch:{ all -> 0x007e }
        if (r2 == 0) goto L_0x0022;
    L_0x0008:
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007e }
        r2.<init>();	 Catch:{ all -> 0x007e }
        r3 = "Error in querying facility lock:";
        r2 = r2.append(r3);	 Catch:{ all -> 0x007e }
        r3 = r7.exception;	 Catch:{ all -> 0x007e }
        r2 = r2.append(r3);	 Catch:{ all -> 0x007e }
        r2 = r2.toString();	 Catch:{ all -> 0x007e }
        r6.log(r2);	 Catch:{ all -> 0x007e }
        monitor-exit(r4);	 Catch:{ all -> 0x007e }
    L_0x0021:
        return;
    L_0x0022:
        r2 = r7.result;	 Catch:{ all -> 0x007e }
        r2 = (int[]) r2;	 Catch:{ all -> 0x007e }
        r0 = r2;
        r0 = (int[]) r0;	 Catch:{ all -> 0x007e }
        r1 = r0;
        r2 = r1.length;	 Catch:{ all -> 0x007e }
        if (r2 == 0) goto L_0x0097;
    L_0x002d:
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007e }
        r2.<init>();	 Catch:{ all -> 0x007e }
        r5 = "Query facility lock : ";
        r2 = r2.append(r5);	 Catch:{ all -> 0x007e }
        r5 = 0;
        r5 = r1[r5];	 Catch:{ all -> 0x007e }
        r2 = r2.append(r5);	 Catch:{ all -> 0x007e }
        r2 = r2.toString();	 Catch:{ all -> 0x007e }
        r6.log(r2);	 Catch:{ all -> 0x007e }
        r2 = 0;
        r2 = r1[r2];	 Catch:{ all -> 0x007e }
        if (r2 == 0) goto L_0x0081;
    L_0x004b:
        r2 = 1;
    L_0x004c:
        r6.mIccLockEnabled = r2;	 Catch:{ all -> 0x007e }
        r2 = r6.mIccLockEnabled;	 Catch:{ all -> 0x007e }
        if (r2 == 0) goto L_0x0057;
    L_0x0052:
        r2 = r6.mPinLockedRegistrants;	 Catch:{ all -> 0x007e }
        r2.notifyRegistrants();	 Catch:{ all -> 0x007e }
    L_0x0057:
        r2 = com.android.internal.telephony.uicc.UiccCardApplication.C00912.f13xe6a897ea;	 Catch:{ all -> 0x007e }
        r3 = r6.mPin1State;	 Catch:{ all -> 0x007e }
        r3 = r3.ordinal();	 Catch:{ all -> 0x007e }
        r2 = r2[r3];	 Catch:{ all -> 0x007e }
        switch(r2) {
            case 1: goto L_0x0083;
            case 2: goto L_0x008d;
            case 3: goto L_0x008d;
            case 4: goto L_0x008d;
            case 5: goto L_0x008d;
            default: goto L_0x0064;
        };	 Catch:{ all -> 0x007e }
    L_0x0064:
        r2 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007e }
        r2.<init>();	 Catch:{ all -> 0x007e }
        r3 = "Ignoring: pin1state=";
        r2 = r2.append(r3);	 Catch:{ all -> 0x007e }
        r3 = r6.mPin1State;	 Catch:{ all -> 0x007e }
        r2 = r2.append(r3);	 Catch:{ all -> 0x007e }
        r2 = r2.toString();	 Catch:{ all -> 0x007e }
        r6.log(r2);	 Catch:{ all -> 0x007e }
    L_0x007c:
        monitor-exit(r4);	 Catch:{ all -> 0x007e }
        goto L_0x0021;
    L_0x007e:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x007e }
        throw r2;
    L_0x0081:
        r2 = r3;
        goto L_0x004c;
    L_0x0083:
        r2 = r6.mIccLockEnabled;	 Catch:{ all -> 0x007e }
        if (r2 == 0) goto L_0x007c;
    L_0x0087:
        r2 = "QUERY_FACILITY_LOCK:enabled GET_SIM_STATUS.Pin1:disabled. Fixme";
        r6.loge(r2);	 Catch:{ all -> 0x007e }
        goto L_0x007c;
    L_0x008d:
        r2 = r6.mIccLockEnabled;	 Catch:{ all -> 0x007e }
        if (r2 != 0) goto L_0x0064;
    L_0x0091:
        r2 = "QUERY_FACILITY_LOCK:disabled GET_SIM_STATUS.Pin1:enabled. Fixme";
        r6.loge(r2);	 Catch:{ all -> 0x007e }
        goto L_0x0064;
    L_0x0097:
        r2 = "Bogus facility lock response";
        r6.loge(r2);	 Catch:{ all -> 0x007e }
        goto L_0x007c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.UiccCardApplication.onQueryFacilityLock(android.os.AsyncResult):void");
    }

    private void onChangeFacilityLock(AsyncResult ar) {
        synchronized (this.mLock) {
            int attemptsRemaining = AUTH_CONTEXT_UNDEFINED;
            if (ar.exception == null) {
                this.mIccLockEnabled = this.mDesiredPinLocked;
                log("EVENT_CHANGE_FACILITY_LOCK_DONE: mIccLockEnabled= " + this.mIccLockEnabled);
            } else {
                attemptsRemaining = parsePinPukErrorResult(ar);
                loge("Error change facility lock with exception " + ar.exception);
            }
            Message response = ar.userObj;
            AsyncResult.forMessage(response).exception = ar.exception;
            response.arg1 = attemptsRemaining;
            response.sendToTarget();
        }
    }

    private int parsePinPukErrorResult(AsyncResult ar) {
        int[] result = (int[]) ar.result;
        if (result == null) {
            return AUTH_CONTEXT_UNDEFINED;
        }
        int length = result.length;
        int attemptsRemaining = AUTH_CONTEXT_UNDEFINED;
        if (length > 0) {
            attemptsRemaining = result[0];
        }
        log("parsePinPukErrorResult: attemptsRemaining=" + attemptsRemaining);
        return attemptsRemaining;
    }

    public void registerForReady(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mReadyRegistrants.add(r);
            notifyReadyRegistrantsIfNeeded(r);
        }
    }

    public void unregisterForReady(Handler h) {
        synchronized (this.mLock) {
            this.mReadyRegistrants.remove(h);
        }
    }

    public void registerForLocked(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mPinLockedRegistrants.add(r);
            notifyPinLockedRegistrantsIfNeeded(r);
        }
    }

    public void unregisterForLocked(Handler h) {
        synchronized (this.mLock) {
            this.mPinLockedRegistrants.remove(h);
        }
    }

    public void registerForNetworkLocked(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mNetworkLockedRegistrants.add(r);
            notifyNetworkLockedRegistrantsIfNeeded(r);
        }
    }

    public void unregisterForNetworkLocked(Handler h) {
        synchronized (this.mLock) {
            this.mNetworkLockedRegistrants.remove(h);
        }
    }

    private void notifyReadyRegistrantsIfNeeded(Registrant r) {
        if (this.mDestroyed || this.mAppState != AppState.APPSTATE_READY) {
            return;
        }
        if (this.mPin1State == PinState.PINSTATE_ENABLED_NOT_VERIFIED || this.mPin1State == PinState.PINSTATE_ENABLED_BLOCKED || this.mPin1State == PinState.PINSTATE_ENABLED_PERM_BLOCKED) {
            loge("Sanity check failed! APPSTATE is ready while PIN1 is not verified!!!");
        } else if (r == null) {
            log("Notifying registrants: READY");
            this.mReadyRegistrants.notifyRegistrants();
        } else {
            log("Notifying 1 registrant: READY");
            r.notifyRegistrant(new AsyncResult(null, null, null));
        }
    }

    private void notifyPinLockedRegistrantsIfNeeded(Registrant r) {
        if (!this.mDestroyed) {
            if (this.mAppState != AppState.APPSTATE_PIN && this.mAppState != AppState.APPSTATE_PUK) {
                return;
            }
            if (this.mPin1State == PinState.PINSTATE_ENABLED_VERIFIED || this.mPin1State == PinState.PINSTATE_DISABLED) {
                loge("Sanity check failed! APPSTATE is locked while PIN1 is not!!!");
            } else if (r == null) {
                log("Notifying registrants: LOCKED");
                this.mPinLockedRegistrants.notifyRegistrants();
            } else {
                log("Notifying 1 registrant: LOCKED");
                r.notifyRegistrant(new AsyncResult(null, null, null));
            }
        }
    }

    private void notifyNetworkLockedRegistrantsIfNeeded(Registrant r) {
        if (this.mDestroyed || this.mAppState != AppState.APPSTATE_SUBSCRIPTION_PERSO || this.mPersoSubState != PersoSubState.PERSOSUBSTATE_SIM_NETWORK) {
            return;
        }
        if (r == null) {
            log("Notifying registrants: NETWORK_LOCKED");
            this.mNetworkLockedRegistrants.notifyRegistrants();
            return;
        }
        log("Notifying 1 registrant: NETWORK_LOCED");
        r.notifyRegistrant(new AsyncResult(null, null, null));
    }

    public AppState getState() {
        AppState appState;
        synchronized (this.mLock) {
            appState = this.mAppState;
        }
        return appState;
    }

    public AppType getType() {
        AppType appType;
        synchronized (this.mLock) {
            appType = this.mAppType;
        }
        return appType;
    }

    public int getAuthContext() {
        int i;
        synchronized (this.mLock) {
            i = this.mAuthContext;
        }
        return i;
    }

    private static int getAuthContext(AppType appType) {
        switch (C00912.f12x5a34abf5[appType.ordinal()]) {
            case EVENT_PIN1_PUK1_DONE /*1*/:
                return AUTH_CONTEXT_EAP_SIM;
            case EVENT_CHANGE_PIN2_DONE /*3*/:
                return AUTH_CONTEXT_EAP_AKA;
            default:
                return AUTH_CONTEXT_UNDEFINED;
        }
    }

    public PersoSubState getPersoSubState() {
        PersoSubState persoSubState;
        synchronized (this.mLock) {
            persoSubState = this.mPersoSubState;
        }
        return persoSubState;
    }

    public String getAid() {
        String str;
        synchronized (this.mLock) {
            str = this.mAid;
        }
        return str;
    }

    public String getAppLabel() {
        return this.mAppLabel;
    }

    public PinState getPin1State() {
        PinState universalPinState;
        synchronized (this.mLock) {
            if (this.mPin1Replaced) {
                universalPinState = this.mUiccCard.getUniversalPinState();
            } else {
                universalPinState = this.mPin1State;
            }
        }
        return universalPinState;
    }

    public IccFileHandler getIccFileHandler() {
        IccFileHandler iccFileHandler;
        synchronized (this.mLock) {
            iccFileHandler = this.mIccFh;
        }
        return iccFileHandler;
    }

    public IccRecords getIccRecords() {
        IccRecords iccRecords;
        synchronized (this.mLock) {
            iccRecords = this.mIccRecords;
        }
        return iccRecords;
    }

    public void supplyPin(String pin, Message onComplete) {
        synchronized (this.mLock) {
            this.mCi.supplyIccPinForApp(pin, this.mAid, this.mHandler.obtainMessage(EVENT_PIN1_PUK1_DONE, onComplete));
        }
    }

    public void supplyPuk(String puk, String newPin, Message onComplete) {
        synchronized (this.mLock) {
            this.mCi.supplyIccPukForApp(puk, newPin, this.mAid, this.mHandler.obtainMessage(EVENT_PIN1_PUK1_DONE, onComplete));
        }
    }

    public void supplyPin2(String pin2, Message onComplete) {
        synchronized (this.mLock) {
            this.mCi.supplyIccPin2ForApp(pin2, this.mAid, this.mHandler.obtainMessage(EVENT_PIN2_PUK2_DONE, onComplete));
        }
    }

    public void supplyPuk2(String puk2, String newPin2, Message onComplete) {
        synchronized (this.mLock) {
            this.mCi.supplyIccPuk2ForApp(puk2, newPin2, this.mAid, this.mHandler.obtainMessage(EVENT_PIN2_PUK2_DONE, onComplete));
        }
    }

    public void supplyNetworkDepersonalization(String pin, Message onComplete) {
        synchronized (this.mLock) {
            log("supplyNetworkDepersonalization");
            this.mCi.supplyNetworkDepersonalization(pin, onComplete);
        }
    }

    public boolean getIccLockEnabled() {
        return this.mIccLockEnabled;
    }

    public boolean getIccFdnEnabled() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mIccFdnEnabled;
        }
        return z;
    }

    public boolean getIccFdnAvailable() {
        return this.mIccFdnAvailable;
    }

    public void setIccLockEnabled(boolean enabled, String password, Message onComplete) {
        synchronized (this.mLock) {
            this.mDesiredPinLocked = enabled;
            this.mCi.setFacilityLockForApp(CommandsInterface.CB_FACILITY_BA_SIM, enabled, password, EVENT_CHANGE_FACILITY_LOCK_DONE, this.mAid, this.mHandler.obtainMessage(EVENT_CHANGE_FACILITY_LOCK_DONE, onComplete));
        }
    }

    public void setIccFdnEnabled(boolean enabled, String password, Message onComplete) {
        synchronized (this.mLock) {
            this.mDesiredFdnEnabled = enabled;
            this.mCi.setFacilityLockForApp(CommandsInterface.CB_FACILITY_BA_FD, enabled, password, 15, this.mAid, this.mHandler.obtainMessage(EVENT_CHANGE_FACILITY_FDN_DONE, onComplete));
        }
    }

    public void changeIccLockPassword(String oldPassword, String newPassword, Message onComplete) {
        synchronized (this.mLock) {
            log("changeIccLockPassword");
            this.mCi.changeIccPinForApp(oldPassword, newPassword, this.mAid, this.mHandler.obtainMessage(EVENT_CHANGE_PIN1_DONE, onComplete));
        }
    }

    public void changeIccFdnPassword(String oldPassword, String newPassword, Message onComplete) {
        synchronized (this.mLock) {
            log("changeIccFdnPassword");
            this.mCi.changeIccPin2ForApp(oldPassword, newPassword, this.mAid, this.mHandler.obtainMessage(EVENT_CHANGE_PIN2_DONE, onComplete));
        }
    }

    public boolean getIccPin2Blocked() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mPin2State == PinState.PINSTATE_ENABLED_BLOCKED ? DBG : false;
        }
        return z;
    }

    public boolean getIccPuk2Blocked() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mPin2State == PinState.PINSTATE_ENABLED_PERM_BLOCKED ? DBG : false;
        }
        return z;
    }

    public int getPhoneId() {
        return this.mUiccCard.getPhoneId();
    }

    protected UiccCard getUiccCard() {
        return this.mUiccCard;
    }

    public UICCConfig getUICCConfig() {
        return this.mUiccCard.getUICCConfig();
    }

    private void log(String msg) {
        Rlog.d(LOG_TAG, msg);
    }

    private void loge(String msg) {
        Rlog.e(LOG_TAG, msg);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("UiccCardApplication: " + this);
        pw.println(" mUiccCard=" + this.mUiccCard);
        pw.println(" mAppState=" + this.mAppState);
        pw.println(" mAppType=" + this.mAppType);
        pw.println(" mPersoSubState=" + this.mPersoSubState);
        pw.println(" mAid=" + this.mAid);
        pw.println(" mAppLabel=" + this.mAppLabel);
        pw.println(" mPin1Replaced=" + this.mPin1Replaced);
        pw.println(" mPin1State=" + this.mPin1State);
        pw.println(" mPin2State=" + this.mPin2State);
        pw.println(" mIccFdnEnabled=" + this.mIccFdnEnabled);
        pw.println(" mDesiredFdnEnabled=" + this.mDesiredFdnEnabled);
        pw.println(" mIccLockEnabled=" + this.mIccLockEnabled);
        pw.println(" mDesiredPinLocked=" + this.mDesiredPinLocked);
        pw.println(" mCi=" + this.mCi);
        pw.println(" mIccRecords=" + this.mIccRecords);
        pw.println(" mIccFh=" + this.mIccFh);
        pw.println(" mDestroyed=" + this.mDestroyed);
        pw.println(" mReadyRegistrants: size=" + this.mReadyRegistrants.size());
        for (i = 0; i < this.mReadyRegistrants.size(); i += EVENT_PIN1_PUK1_DONE) {
            pw.println("  mReadyRegistrants[" + i + "]=" + ((Registrant) this.mReadyRegistrants.get(i)).getHandler());
        }
        pw.println(" mPinLockedRegistrants: size=" + this.mPinLockedRegistrants.size());
        for (i = 0; i < this.mPinLockedRegistrants.size(); i += EVENT_PIN1_PUK1_DONE) {
            pw.println("  mPinLockedRegistrants[" + i + "]=" + ((Registrant) this.mPinLockedRegistrants.get(i)).getHandler());
        }
        pw.println(" mNetworkLockedRegistrants: size=" + this.mNetworkLockedRegistrants.size());
        for (i = 0; i < this.mNetworkLockedRegistrants.size(); i += EVENT_PIN1_PUK1_DONE) {
            pw.println("  mNetworkLockedRegistrants[" + i + "]=" + ((Registrant) this.mNetworkLockedRegistrants.get(i)).getHandler());
        }
        pw.flush();
    }
}
