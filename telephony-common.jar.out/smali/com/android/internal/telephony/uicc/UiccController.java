package com.android.internal.telephony.uicc;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemProperties;
import android.telephony.Rlog;
import android.telephony.TelephonyManager;
import android.text.format.Time;
import com.android.internal.telephony.CommandsInterface;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.LinkedList;

public class UiccController extends Handler {
    public static final int APP_FAM_3GPP = 1;
    public static final int APP_FAM_3GPP2 = 2;
    public static final int APP_FAM_IMS = 3;
    private static final boolean DBG = true;
    private static final String DECRYPT_STATE = "trigger_restart_framework";
    private static final int EVENT_GET_ICC_STATUS_DONE = 2;
    private static final int EVENT_ICC_STATUS_CHANGED = 1;
    private static final int EVENT_RADIO_UNAVAILABLE = 3;
    private static final int EVENT_SIM_REFRESH = 4;
    private static final String LOG_TAG = "UiccController";
    private static final int MAX_PROACTIVE_COMMANDS_TO_LOG = 20;
    private static UiccController mInstance;
    private static final Object mLock;
    private LinkedList<String> mCardLogs;
    private CommandsInterface[] mCis;
    private Context mContext;
    protected RegistrantList mIccChangedRegistrants;
    private UiccCard[] mUiccCards;

    static {
        mLock = new Object();
    }

    public static UiccController make(Context c, CommandsInterface[] ci) {
        UiccController uiccController;
        synchronized (mLock) {
            if (mInstance != null) {
                throw new RuntimeException("MSimUiccController.make() should only be called once");
            }
            mInstance = new UiccController(c, ci);
            uiccController = mInstance;
        }
        return uiccController;
    }

    private UiccController(Context c, CommandsInterface[] ci) {
        this.mUiccCards = new UiccCard[TelephonyManager.getDefault().getPhoneCount()];
        this.mIccChangedRegistrants = new RegistrantList();
        this.mCardLogs = new LinkedList();
        log("Creating UiccController");
        this.mContext = c;
        this.mCis = ci;
        for (int i = 0; i < this.mCis.length; i += EVENT_ICC_STATUS_CHANGED) {
            Integer index = new Integer(i);
            this.mCis[i].registerForIccStatusChanged(this, EVENT_ICC_STATUS_CHANGED, index);
            if (DECRYPT_STATE.equals(SystemProperties.get("vold.decrypt"))) {
                this.mCis[i].registerForAvailable(this, EVENT_ICC_STATUS_CHANGED, index);
            } else {
                this.mCis[i].registerForOn(this, EVENT_ICC_STATUS_CHANGED, index);
            }
            this.mCis[i].registerForNotAvailable(this, EVENT_RADIO_UNAVAILABLE, index);
            this.mCis[i].registerForIccRefresh(this, EVENT_SIM_REFRESH, index);
        }
    }

    public static UiccController getInstance() {
        UiccController uiccController;
        synchronized (mLock) {
            if (mInstance == null) {
                throw new RuntimeException("UiccController.getInstance can't be called before make()");
            }
            uiccController = mInstance;
        }
        return uiccController;
    }

    public UiccCard getUiccCard(int phoneId) {
        UiccCard uiccCard;
        synchronized (mLock) {
            if (isValidCardIndex(phoneId)) {
                uiccCard = this.mUiccCards[phoneId];
            } else {
                uiccCard = null;
            }
        }
        return uiccCard;
    }

    public UiccCard[] getUiccCards() {
        UiccCard[] uiccCardArr;
        synchronized (mLock) {
            uiccCardArr = (UiccCard[]) this.mUiccCards.clone();
        }
        return uiccCardArr;
    }

    public IccRecords getIccRecords(int phoneId, int family) {
        IccRecords iccRecords;
        synchronized (mLock) {
            UiccCardApplication app = getUiccCardApplication(phoneId, family);
            if (app != null) {
                iccRecords = app.getIccRecords();
            } else {
                iccRecords = null;
            }
        }
        return iccRecords;
    }

    public IccFileHandler getIccFileHandler(int phoneId, int family) {
        IccFileHandler iccFileHandler;
        synchronized (mLock) {
            UiccCardApplication app = getUiccCardApplication(phoneId, family);
            if (app != null) {
                iccFileHandler = app.getIccFileHandler();
            } else {
                iccFileHandler = null;
            }
        }
        return iccFileHandler;
    }

    public void registerForIccChanged(Handler h, int what, Object obj) {
        synchronized (mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mIccChangedRegistrants.add(r);
            r.notifyRegistrant();
        }
    }

    public void unregisterForIccChanged(Handler h) {
        synchronized (mLock) {
            this.mIccChangedRegistrants.remove(h);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void handleMessage(android.os.Message r8) {
        /*
        r7 = this;
        r3 = mLock;
        monitor-enter(r3);
        r1 = r7.getCiIndex(r8);	 Catch:{ all -> 0x0061 }
        r2 = r1.intValue();	 Catch:{ all -> 0x0061 }
        if (r2 < 0) goto L_0x0016;
    L_0x000d:
        r2 = r1.intValue();	 Catch:{ all -> 0x0061 }
        r4 = r7.mCis;	 Catch:{ all -> 0x0061 }
        r4 = r4.length;	 Catch:{ all -> 0x0061 }
        if (r2 < r4) goto L_0x003c;
    L_0x0016:
        r2 = "UiccController";
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0061 }
        r4.<init>();	 Catch:{ all -> 0x0061 }
        r5 = "Invalid index : ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0061 }
        r4 = r4.append(r1);	 Catch:{ all -> 0x0061 }
        r5 = " received with event ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0061 }
        r5 = r8.what;	 Catch:{ all -> 0x0061 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0061 }
        r4 = r4.toString();	 Catch:{ all -> 0x0061 }
        android.telephony.Rlog.e(r2, r4);	 Catch:{ all -> 0x0061 }
        monitor-exit(r3);	 Catch:{ all -> 0x0061 }
    L_0x003b:
        return;
    L_0x003c:
        r0 = r8.obj;	 Catch:{ all -> 0x0061 }
        r0 = (android.os.AsyncResult) r0;	 Catch:{ all -> 0x0061 }
        r2 = r8.what;	 Catch:{ all -> 0x0061 }
        switch(r2) {
            case 1: goto L_0x0064;
            case 2: goto L_0x007a;
            case 3: goto L_0x0083;
            case 4: goto L_0x00b3;
            default: goto L_0x0045;
        };	 Catch:{ all -> 0x0061 }
    L_0x0045:
        r2 = "UiccController";
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0061 }
        r4.<init>();	 Catch:{ all -> 0x0061 }
        r5 = " Unknown Event ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0061 }
        r5 = r8.what;	 Catch:{ all -> 0x0061 }
        r4 = r4.append(r5);	 Catch:{ all -> 0x0061 }
        r4 = r4.toString();	 Catch:{ all -> 0x0061 }
        android.telephony.Rlog.e(r2, r4);	 Catch:{ all -> 0x0061 }
    L_0x005f:
        monitor-exit(r3);	 Catch:{ all -> 0x0061 }
        goto L_0x003b;
    L_0x0061:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0061 }
        throw r2;
    L_0x0064:
        r2 = "Received EVENT_ICC_STATUS_CHANGED, calling getIccCardStatus";
        r7.log(r2);	 Catch:{ all -> 0x0061 }
        r2 = r7.mCis;	 Catch:{ all -> 0x0061 }
        r4 = r1.intValue();	 Catch:{ all -> 0x0061 }
        r2 = r2[r4];	 Catch:{ all -> 0x0061 }
        r4 = 2;
        r4 = r7.obtainMessage(r4, r1);	 Catch:{ all -> 0x0061 }
        r2.getIccCardStatus(r4);	 Catch:{ all -> 0x0061 }
        goto L_0x005f;
    L_0x007a:
        r2 = "Received EVENT_GET_ICC_STATUS_DONE";
        r7.log(r2);	 Catch:{ all -> 0x0061 }
        r7.onGetIccCardStatusDone(r0, r1);	 Catch:{ all -> 0x0061 }
        goto L_0x005f;
    L_0x0083:
        r2 = "EVENT_RADIO_UNAVAILABLE, dispose card";
        r7.log(r2);	 Catch:{ all -> 0x0061 }
        r2 = r7.mUiccCards;	 Catch:{ all -> 0x0061 }
        r4 = r1.intValue();	 Catch:{ all -> 0x0061 }
        r2 = r2[r4];	 Catch:{ all -> 0x0061 }
        if (r2 == 0) goto L_0x009d;
    L_0x0092:
        r2 = r7.mUiccCards;	 Catch:{ all -> 0x0061 }
        r4 = r1.intValue();	 Catch:{ all -> 0x0061 }
        r2 = r2[r4];	 Catch:{ all -> 0x0061 }
        r2.dispose();	 Catch:{ all -> 0x0061 }
    L_0x009d:
        r2 = r7.mUiccCards;	 Catch:{ all -> 0x0061 }
        r4 = r1.intValue();	 Catch:{ all -> 0x0061 }
        r5 = 0;
        r2[r4] = r5;	 Catch:{ all -> 0x0061 }
        r2 = r7.mIccChangedRegistrants;	 Catch:{ all -> 0x0061 }
        r4 = new android.os.AsyncResult;	 Catch:{ all -> 0x0061 }
        r5 = 0;
        r6 = 0;
        r4.<init>(r5, r1, r6);	 Catch:{ all -> 0x0061 }
        r2.notifyRegistrants(r4);	 Catch:{ all -> 0x0061 }
        goto L_0x005f;
    L_0x00b3:
        r2 = "Received EVENT_SIM_REFRESH";
        r7.log(r2);	 Catch:{ all -> 0x0061 }
        r7.onSimRefresh(r0, r1);	 Catch:{ all -> 0x0061 }
        goto L_0x005f;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.UiccController.handleMessage(android.os.Message):void");
    }

    private Integer getCiIndex(Message msg) {
        Integer index = new Integer(0);
        if (msg == null) {
            return index;
        }
        if (msg.obj != null && (msg.obj instanceof Integer)) {
            return msg.obj;
        }
        if (msg.obj == null || !(msg.obj instanceof AsyncResult)) {
            return index;
        }
        AsyncResult ar = msg.obj;
        if (ar.userObj == null || !(ar.userObj instanceof Integer)) {
            return index;
        }
        return ar.userObj;
    }

    public UiccCardApplication getUiccCardApplication(int phoneId, int family) {
        UiccCardApplication uiccCardApplication;
        synchronized (mLock) {
            if (!isValidCardIndex(phoneId) || this.mUiccCards[phoneId] == null) {
                uiccCardApplication = null;
            } else {
                uiccCardApplication = this.mUiccCards[phoneId].getApplication(family);
            }
        }
        return uiccCardApplication;
    }

    private synchronized void onGetIccCardStatusDone(AsyncResult ar, Integer index) {
        if (ar.exception != null) {
            Rlog.e(LOG_TAG, "Error getting ICC status. RIL_REQUEST_GET_ICC_STATUS should never return an error", ar.exception);
        } else if (isValidCardIndex(index.intValue())) {
            IccCardStatus status = ar.result;
            if (this.mUiccCards[index.intValue()] == null) {
                this.mUiccCards[index.intValue()] = new UiccCard(this.mContext, this.mCis[index.intValue()], status, index.intValue());
            } else {
                this.mUiccCards[index.intValue()].update(this.mContext, this.mCis[index.intValue()], status);
            }
            log("Notifying IccChangedRegistrants");
            this.mIccChangedRegistrants.notifyRegistrants(new AsyncResult(null, index, null));
        } else {
            Rlog.e(LOG_TAG, "onGetIccCardStatusDone: invalid index : " + index);
        }
    }

    private void onSimRefresh(AsyncResult ar, Integer index) {
        if (ar.exception != null) {
            Rlog.e(LOG_TAG, "Sim REFRESH with exception: " + ar.exception);
        } else if (isValidCardIndex(index.intValue())) {
            IccRefreshResponse resp = ar.result;
            Rlog.d(LOG_TAG, "onSimRefresh: " + resp);
            if (this.mUiccCards[index.intValue()] == null) {
                Rlog.e(LOG_TAG, "onSimRefresh: refresh on null card : " + index);
            } else if (resp.refreshResult != EVENT_GET_ICC_STATUS_DONE) {
                Rlog.d(LOG_TAG, "Ignoring non reset refresh: " + resp);
            } else {
                Rlog.d(LOG_TAG, "Handling refresh reset: " + resp);
                if (this.mUiccCards[index.intValue()].resetAppWithAid(resp.aid)) {
                    if (this.mContext.getResources().getBoolean(17956983)) {
                        this.mCis[index.intValue()].setRadioPower(false, null);
                    } else {
                        this.mCis[index.intValue()].getIccCardStatus(obtainMessage(EVENT_GET_ICC_STATUS_DONE));
                    }
                    this.mIccChangedRegistrants.notifyRegistrants(new AsyncResult(null, index, null));
                }
            }
        } else {
            Rlog.e(LOG_TAG, "onSimRefresh: invalid index : " + index);
        }
    }

    private boolean isValidCardIndex(int index) {
        return (index < 0 || index >= this.mUiccCards.length) ? false : DBG;
    }

    private void log(String string) {
        Rlog.d(LOG_TAG, string);
    }

    public void addCardLog(String data) {
        Time t = new Time();
        t.setToNow();
        this.mCardLogs.addLast(t.format("%m-%d %H:%M:%S") + " " + data);
        if (this.mCardLogs.size() > MAX_PROACTIVE_COMMANDS_TO_LOG) {
            this.mCardLogs.removeFirst();
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("UiccController: " + this);
        pw.println(" mContext=" + this.mContext);
        pw.println(" mInstance=" + mInstance);
        pw.println(" mIccChangedRegistrants: size=" + this.mIccChangedRegistrants.size());
        for (i = 0; i < this.mIccChangedRegistrants.size(); i += EVENT_ICC_STATUS_CHANGED) {
            pw.println("  mIccChangedRegistrants[" + i + "]=" + ((Registrant) this.mIccChangedRegistrants.get(i)).getHandler());
        }
        pw.println();
        pw.flush();
        pw.println(" mUiccCards: size=" + this.mUiccCards.length);
        for (i = 0; i < this.mUiccCards.length; i += EVENT_ICC_STATUS_CHANGED) {
            if (this.mUiccCards[i] == null) {
                pw.println("  mUiccCards[" + i + "]=null");
            } else {
                pw.println("  mUiccCards[" + i + "]=" + this.mUiccCards[i]);
                this.mUiccCards[i].dump(fd, pw, args);
            }
        }
        pw.println("mCardLogs: ");
        for (i = 0; i < this.mCardLogs.size(); i += EVENT_ICC_STATUS_CHANGED) {
            pw.println("  " + ((String) this.mCardLogs.get(i)));
        }
    }
}
