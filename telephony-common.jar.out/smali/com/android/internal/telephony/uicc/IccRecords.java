package com.android.internal.telephony.uicc;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.Registrant;
import android.os.RegistrantList;
import android.telephony.TelephonyManager;
import android.util.Base64;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class IccRecords extends Handler implements IccConstants {
    protected static final boolean DBG = true;
    private static final int EVENT_AKA_AUTHENTICATE_DONE = 90;
    protected static final int EVENT_APP_READY = 1;
    public static final int EVENT_CFI = 1;
    public static final int EVENT_GET_ICC_RECORD_DONE = 100;
    public static final int EVENT_MWI = 0;
    protected static final int EVENT_SET_MSISDN_DONE = 30;
    public static final int EVENT_SPN = 2;
    public static final int SPN_RULE_SHOW_PLMN = 2;
    public static final int SPN_RULE_SHOW_SPN = 1;
    protected static final int UNINITIALIZED = -1;
    protected static final int UNKNOWN = 0;
    private IccIoResult auth_rsp;
    protected AdnRecordCache mAdnCache;
    protected CommandsInterface mCi;
    protected Context mContext;
    protected AtomicBoolean mDestroyed;
    protected IccFileHandler mFh;
    protected String mGid1;
    protected String mIccId;
    protected String mImsi;
    protected RegistrantList mImsiReadyRegistrants;
    protected boolean mIsVoiceMailFixed;
    private final Object mLock;
    protected int mMailboxIndex;
    protected int mMncLength;
    protected String mMsisdn;
    protected String mMsisdnTag;
    protected RegistrantList mNetworkSelectionModeAutomaticRegistrants;
    protected String mNewMsisdn;
    protected String mNewMsisdnTag;
    protected RegistrantList mNewSmsRegistrants;
    protected String mNewVoiceMailNum;
    protected String mNewVoiceMailTag;
    protected UiccCardApplication mParentApp;
    protected RegistrantList mRecordsEventsRegistrants;
    protected RegistrantList mRecordsLoadedRegistrants;
    protected boolean mRecordsRequested;
    protected int mRecordsToLoad;
    private String mSpn;
    protected TelephonyManager mTelephonyManager;
    protected String mVoiceMailNum;
    protected String mVoiceMailTag;

    public interface IccRecordLoaded {
        String getEfName();

        void onRecordLoaded(AsyncResult asyncResult);
    }

    public abstract int getDisplayRule(String str);

    public abstract int getVoiceMessageCount();

    protected abstract void log(String str);

    protected abstract void loge(String str);

    protected abstract void onAllRecordsLoaded();

    public abstract void onReady();

    protected abstract void onRecordLoaded();

    public abstract void onRefresh(boolean z, int[] iArr);

    public abstract void setVoiceMailNumber(String str, String str2, Message message);

    public abstract void setVoiceMessageWaiting(int i, int i2);

    public String toString() {
        return "mDestroyed=" + this.mDestroyed + " mContext=" + this.mContext + " mCi=" + this.mCi + " mFh=" + this.mFh + " mParentApp=" + this.mParentApp + " recordsLoadedRegistrants=" + this.mRecordsLoadedRegistrants + " mImsiReadyRegistrants=" + this.mImsiReadyRegistrants + " mRecordsEventsRegistrants=" + this.mRecordsEventsRegistrants + " mNewSmsRegistrants=" + this.mNewSmsRegistrants + " mNetworkSelectionModeAutomaticRegistrants=" + this.mNetworkSelectionModeAutomaticRegistrants + " recordsToLoad=" + this.mRecordsToLoad + " adnCache=" + this.mAdnCache + " recordsRequested=" + this.mRecordsRequested + " iccid=" + this.mIccId + " msisdnTag=" + this.mMsisdnTag + " voiceMailNum=" + this.mVoiceMailNum + " voiceMailTag=" + this.mVoiceMailTag + " newVoiceMailNum=" + this.mNewVoiceMailNum + " newVoiceMailTag=" + this.mNewVoiceMailTag + " isVoiceMailFixed=" + this.mIsVoiceMailFixed + " mImsi=" + this.mImsi + " mncLength=" + this.mMncLength + " mailboxIndex=" + this.mMailboxIndex + " spn=" + this.mSpn;
    }

    public IccRecords(UiccCardApplication app, Context c, CommandsInterface ci) {
        this.mDestroyed = new AtomicBoolean(false);
        this.mRecordsLoadedRegistrants = new RegistrantList();
        this.mImsiReadyRegistrants = new RegistrantList();
        this.mRecordsEventsRegistrants = new RegistrantList();
        this.mNewSmsRegistrants = new RegistrantList();
        this.mNetworkSelectionModeAutomaticRegistrants = new RegistrantList();
        this.mRecordsRequested = false;
        this.mMsisdn = null;
        this.mMsisdnTag = null;
        this.mNewMsisdn = null;
        this.mNewMsisdnTag = null;
        this.mVoiceMailNum = null;
        this.mVoiceMailTag = null;
        this.mNewVoiceMailNum = null;
        this.mNewVoiceMailTag = null;
        this.mIsVoiceMailFixed = false;
        this.mMncLength = UNINITIALIZED;
        this.mMailboxIndex = EVENT_MWI;
        this.mLock = new Object();
        this.mContext = c;
        this.mCi = ci;
        this.mFh = app.getIccFileHandler();
        this.mParentApp = app;
        this.mTelephonyManager = (TelephonyManager) this.mContext.getSystemService("phone");
    }

    public void dispose() {
        this.mDestroyed.set(DBG);
        this.mParentApp = null;
        this.mFh = null;
        this.mCi = null;
        this.mContext = null;
    }

    public AdnRecordCache getAdnCache() {
        return this.mAdnCache;
    }

    public String getIccId() {
        return this.mIccId;
    }

    public void registerForRecordsLoaded(Handler h, int what, Object obj) {
        if (!this.mDestroyed.get()) {
            Registrant r = new Registrant(h, what, obj);
            this.mRecordsLoadedRegistrants.add(r);
            if (this.mRecordsToLoad == 0 && this.mRecordsRequested == DBG) {
                r.notifyRegistrant(new AsyncResult(null, null, null));
            }
        }
    }

    public void unregisterForRecordsLoaded(Handler h) {
        this.mRecordsLoadedRegistrants.remove(h);
    }

    public void registerForImsiReady(Handler h, int what, Object obj) {
        if (!this.mDestroyed.get()) {
            Registrant r = new Registrant(h, what, obj);
            this.mImsiReadyRegistrants.add(r);
            if (this.mImsi != null) {
                r.notifyRegistrant(new AsyncResult(null, null, null));
            }
        }
    }

    public void unregisterForImsiReady(Handler h) {
        this.mImsiReadyRegistrants.remove(h);
    }

    public void registerForRecordsEvents(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mRecordsEventsRegistrants.add(r);
        r.notifyResult(Integer.valueOf(EVENT_MWI));
        r.notifyResult(Integer.valueOf(SPN_RULE_SHOW_SPN));
    }

    public void unregisterForRecordsEvents(Handler h) {
        this.mRecordsEventsRegistrants.remove(h);
    }

    public void registerForNewSms(Handler h, int what, Object obj) {
        this.mNewSmsRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForNewSms(Handler h) {
        this.mNewSmsRegistrants.remove(h);
    }

    public void registerForNetworkSelectionModeAutomatic(Handler h, int what, Object obj) {
        this.mNetworkSelectionModeAutomaticRegistrants.add(new Registrant(h, what, obj));
    }

    public void unregisterForNetworkSelectionModeAutomatic(Handler h) {
        this.mNetworkSelectionModeAutomaticRegistrants.remove(h);
    }

    public String getIMSI() {
        return null;
    }

    public void setImsi(String imsi) {
        this.mImsi = imsi;
        this.mImsiReadyRegistrants.notifyRegistrants();
    }

    public String getNAI() {
        return null;
    }

    public String getMsisdnNumber() {
        return this.mMsisdn;
    }

    public String getGid1() {
        return null;
    }

    public void setMsisdnNumber(String alphaTag, String number, Message onComplete) {
        this.mMsisdn = number;
        this.mMsisdnTag = alphaTag;
        log("Set MSISDN: " + this.mMsisdnTag + " " + this.mMsisdn);
        new AdnRecordLoader(this.mFh).updateEF(new AdnRecord(this.mMsisdnTag, this.mMsisdn), IccConstants.EF_MSISDN, IccConstants.EF_EXT1, SPN_RULE_SHOW_SPN, null, obtainMessage(EVENT_SET_MSISDN_DONE, onComplete));
    }

    public String getMsisdnAlphaTag() {
        return this.mMsisdnTag;
    }

    public String getVoiceMailNumber() {
        return this.mVoiceMailNum;
    }

    public String getServiceProviderName() {
        String providerName = this.mSpn;
        UiccCardApplication parentApp = this.mParentApp;
        if (parentApp != null) {
            UiccCard card = parentApp.getUiccCard();
            if (card != null) {
                String brandOverride = card.getOperatorBrandOverride();
                if (brandOverride != null) {
                    log("getServiceProviderName: override");
                    providerName = brandOverride;
                } else {
                    log("getServiceProviderName: no brandOverride");
                }
            } else {
                log("getServiceProviderName: card is null");
            }
        } else {
            log("getServiceProviderName: mParentApp is null");
        }
        log("getServiceProviderName: providerName=" + providerName);
        return providerName;
    }

    protected void setServiceProviderName(String spn) {
        this.mSpn = spn;
    }

    public String getVoiceMailAlphaTag() {
        return this.mVoiceMailTag;
    }

    protected void onIccRefreshInit() {
        this.mAdnCache.reset();
        UiccCardApplication parentApp = this.mParentApp;
        if (parentApp != null && parentApp.getState() == AppState.APPSTATE_READY) {
            sendMessage(obtainMessage(SPN_RULE_SHOW_SPN));
        }
    }

    public boolean getRecordsLoaded() {
        if (this.mRecordsToLoad == 0 && this.mRecordsRequested == DBG) {
            return DBG;
        }
        return false;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void handleMessage(android.os.Message r7) {
        /*
        r6 = this;
        r4 = r7.what;
        switch(r4) {
            case 90: goto L_0x006f;
            case 100: goto L_0x0009;
            default: goto L_0x0005;
        };
    L_0x0005:
        super.handleMessage(r7);
    L_0x0008:
        return;
    L_0x0009:
        r0 = r7.obj;	 Catch:{ RuntimeException -> 0x004f }
        r0 = (android.os.AsyncResult) r0;	 Catch:{ RuntimeException -> 0x004f }
        r3 = r0.userObj;	 Catch:{ RuntimeException -> 0x004f }
        r3 = (com.android.internal.telephony.uicc.IccRecords.IccRecordLoaded) r3;	 Catch:{ RuntimeException -> 0x004f }
        r4 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x004f }
        r4.<init>();	 Catch:{ RuntimeException -> 0x004f }
        r5 = r3.getEfName();	 Catch:{ RuntimeException -> 0x004f }
        r4 = r4.append(r5);	 Catch:{ RuntimeException -> 0x004f }
        r5 = " LOADED";
        r4 = r4.append(r5);	 Catch:{ RuntimeException -> 0x004f }
        r4 = r4.toString();	 Catch:{ RuntimeException -> 0x004f }
        r6.log(r4);	 Catch:{ RuntimeException -> 0x004f }
        r4 = r0.exception;	 Catch:{ RuntimeException -> 0x004f }
        if (r4 == 0) goto L_0x004b;
    L_0x002f:
        r4 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x004f }
        r4.<init>();	 Catch:{ RuntimeException -> 0x004f }
        r5 = "Record Load Exception: ";
        r4 = r4.append(r5);	 Catch:{ RuntimeException -> 0x004f }
        r5 = r0.exception;	 Catch:{ RuntimeException -> 0x004f }
        r4 = r4.append(r5);	 Catch:{ RuntimeException -> 0x004f }
        r4 = r4.toString();	 Catch:{ RuntimeException -> 0x004f }
        r6.loge(r4);	 Catch:{ RuntimeException -> 0x004f }
    L_0x0047:
        r6.onRecordLoaded();
        goto L_0x0008;
    L_0x004b:
        r3.onRecordLoaded(r0);	 Catch:{ RuntimeException -> 0x004f }
        goto L_0x0047;
    L_0x004f:
        r2 = move-exception;
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x006a }
        r4.<init>();	 Catch:{ all -> 0x006a }
        r5 = "Exception parsing SIM record: ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x006a }
        r4 = r4.append(r2);	 Catch:{ all -> 0x006a }
        r4 = r4.toString();	 Catch:{ all -> 0x006a }
        r6.loge(r4);	 Catch:{ all -> 0x006a }
        r6.onRecordLoaded();
        goto L_0x0008;
    L_0x006a:
        r4 = move-exception;
        r6.onRecordLoaded();
        throw r4;
    L_0x006f:
        r0 = r7.obj;
        r0 = (android.os.AsyncResult) r0;
        r4 = 0;
        r6.auth_rsp = r4;
        r4 = "EVENT_AKA_AUTHENTICATE_DONE";
        r6.log(r4);
        r4 = r0.exception;
        if (r4 == 0) goto L_0x00a5;
    L_0x007f:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Exception ICC SIM AKA: ";
        r4 = r4.append(r5);
        r5 = r0.exception;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r6.loge(r4);
    L_0x0097:
        r5 = r6.mLock;
        monitor-enter(r5);
        r4 = r6.mLock;	 Catch:{ all -> 0x00a2 }
        r4.notifyAll();	 Catch:{ all -> 0x00a2 }
        monitor-exit(r5);	 Catch:{ all -> 0x00a2 }
        goto L_0x0008;
    L_0x00a2:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x00a2 }
        throw r4;
    L_0x00a5:
        r4 = r0.result;	 Catch:{ Exception -> 0x00c4 }
        r4 = (com.android.internal.telephony.uicc.IccIoResult) r4;	 Catch:{ Exception -> 0x00c4 }
        r6.auth_rsp = r4;	 Catch:{ Exception -> 0x00c4 }
        r4 = new java.lang.StringBuilder;	 Catch:{ Exception -> 0x00c4 }
        r4.<init>();	 Catch:{ Exception -> 0x00c4 }
        r5 = "ICC SIM AKA: auth_rsp = ";
        r4 = r4.append(r5);	 Catch:{ Exception -> 0x00c4 }
        r5 = r6.auth_rsp;	 Catch:{ Exception -> 0x00c4 }
        r4 = r4.append(r5);	 Catch:{ Exception -> 0x00c4 }
        r4 = r4.toString();	 Catch:{ Exception -> 0x00c4 }
        r6.log(r4);	 Catch:{ Exception -> 0x00c4 }
        goto L_0x0097;
    L_0x00c4:
        r1 = move-exception;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "Failed to parse ICC SIM AKA contents: ";
        r4 = r4.append(r5);
        r4 = r4.append(r1);
        r4 = r4.toString();
        r6.loge(r4);
        goto L_0x0097;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.IccRecords.handleMessage(android.os.Message):void");
    }

    public boolean isCspPlmnEnabled() {
        return false;
    }

    public String getOperatorNumeric() {
        return null;
    }

    public boolean getVoiceCallForwardingFlag() {
        return false;
    }

    public void setVoiceCallForwardingFlag(int line, boolean enable, String number) {
    }

    public boolean isProvisioned() {
        return DBG;
    }

    public IsimRecords getIsimRecords() {
        return null;
    }

    public UsimServiceTable getUsimServiceTable() {
        return null;
    }

    protected void setSystemProperty(String key, String val) {
        TelephonyManager.getDefault();
        TelephonyManager.setTelephonyProperty(this.mParentApp.getPhoneId(), key, val);
        log("[key, value]=" + key + ", " + val);
    }

    public String getIccSimChallengeResponse(int authContext, String data) {
        log("getIccSimChallengeResponse:");
        try {
            synchronized (this.mLock) {
                CommandsInterface ci = this.mCi;
                UiccCardApplication parentApp = this.mParentApp;
                if (ci == null || parentApp == null) {
                    loge("getIccSimChallengeResponse: Fail, ci or parentApp is null");
                    return null;
                }
                ci.requestIccSimAuthentication(authContext, data, parentApp.getAid(), obtainMessage(EVENT_AKA_AUTHENTICATE_DONE));
                try {
                    this.mLock.wait();
                    log("getIccSimChallengeResponse: return auth_rsp");
                    return Base64.encodeToString(this.auth_rsp.payload, SPN_RULE_SHOW_PLMN);
                } catch (InterruptedException e) {
                    loge("getIccSimChallengeResponse: Fail, interrupted while trying to request Icc Sim Auth");
                    return null;
                }
            }
        } catch (Exception e2) {
            loge("getIccSimChallengeResponse: Fail while trying to request Icc Sim Auth");
            return null;
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("IccRecords: " + this);
        pw.println(" mDestroyed=" + this.mDestroyed);
        pw.println(" mCi=" + this.mCi);
        pw.println(" mFh=" + this.mFh);
        pw.println(" mParentApp=" + this.mParentApp);
        pw.println(" recordsLoadedRegistrants: size=" + this.mRecordsLoadedRegistrants.size());
        for (i = EVENT_MWI; i < this.mRecordsLoadedRegistrants.size(); i += SPN_RULE_SHOW_SPN) {
            pw.println("  recordsLoadedRegistrants[" + i + "]=" + ((Registrant) this.mRecordsLoadedRegistrants.get(i)).getHandler());
        }
        pw.println(" mImsiReadyRegistrants: size=" + this.mImsiReadyRegistrants.size());
        for (i = EVENT_MWI; i < this.mImsiReadyRegistrants.size(); i += SPN_RULE_SHOW_SPN) {
            pw.println("  mImsiReadyRegistrants[" + i + "]=" + ((Registrant) this.mImsiReadyRegistrants.get(i)).getHandler());
        }
        pw.println(" mRecordsEventsRegistrants: size=" + this.mRecordsEventsRegistrants.size());
        for (i = EVENT_MWI; i < this.mRecordsEventsRegistrants.size(); i += SPN_RULE_SHOW_SPN) {
            pw.println("  mRecordsEventsRegistrants[" + i + "]=" + ((Registrant) this.mRecordsEventsRegistrants.get(i)).getHandler());
        }
        pw.println(" mNewSmsRegistrants: size=" + this.mNewSmsRegistrants.size());
        for (i = EVENT_MWI; i < this.mNewSmsRegistrants.size(); i += SPN_RULE_SHOW_SPN) {
            pw.println("  mNewSmsRegistrants[" + i + "]=" + ((Registrant) this.mNewSmsRegistrants.get(i)).getHandler());
        }
        pw.println(" mNetworkSelectionModeAutomaticRegistrants: size=" + this.mNetworkSelectionModeAutomaticRegistrants.size());
        for (i = EVENT_MWI; i < this.mNetworkSelectionModeAutomaticRegistrants.size(); i += SPN_RULE_SHOW_SPN) {
            pw.println("  mNetworkSelectionModeAutomaticRegistrants[" + i + "]=" + ((Registrant) this.mNetworkSelectionModeAutomaticRegistrants.get(i)).getHandler());
        }
        pw.println(" mRecordsRequested=" + this.mRecordsRequested);
        pw.println(" mRecordsToLoad=" + this.mRecordsToLoad);
        pw.println(" mRdnCache=" + this.mAdnCache);
        pw.println(" iccid=" + this.mIccId);
        pw.println(" mMsisdn=" + this.mMsisdn);
        pw.println(" mMsisdnTag=" + this.mMsisdnTag);
        pw.println(" mVoiceMailNum=" + this.mVoiceMailNum);
        pw.println(" mVoiceMailTag=" + this.mVoiceMailTag);
        pw.println(" mNewVoiceMailNum=" + this.mNewVoiceMailNum);
        pw.println(" mNewVoiceMailTag=" + this.mNewVoiceMailTag);
        pw.println(" mIsVoiceMailFixed=" + this.mIsVoiceMailFixed);
        pw.println(" mImsi=" + this.mImsi);
        pw.println(" mMncLength=" + this.mMncLength);
        pw.println(" mMailboxIndex=" + this.mMailboxIndex);
        pw.println(" mSpn=" + this.mSpn);
        pw.flush();
    }
}
