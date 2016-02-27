package com.android.internal.telephony.uicc;

import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.Registrant;
import android.os.RegistrantList;
import android.preference.PreferenceManager;
import android.telephony.Rlog;
import android.text.TextUtils;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.CommandsInterface.RadioState;
import com.android.internal.telephony.cat.CatService;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccCardStatus.CardState;
import com.android.internal.telephony.uicc.IccCardStatus.PinState;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.List;

public class UiccCard {
    protected static final boolean DBG = true;
    private static final int EVENT_CARD_ADDED = 14;
    private static final int EVENT_CARD_REMOVED = 13;
    private static final int EVENT_CARRIER_PRIVILIGES_LOADED = 20;
    private static final int EVENT_CLOSE_LOGICAL_CHANNEL_DONE = 16;
    private static final int EVENT_OPEN_LOGICAL_CHANNEL_DONE = 15;
    private static final int EVENT_SIM_IO_DONE = 19;
    private static final int EVENT_TRANSMIT_APDU_BASIC_CHANNEL_DONE = 18;
    private static final int EVENT_TRANSMIT_APDU_LOGICAL_CHANNEL_DONE = 17;
    protected static final String LOG_TAG = "UiccCard";
    private static final String OPERATOR_BRAND_OVERRIDE_PREFIX = "operator_branding_";
    private RegistrantList mAbsentRegistrants;
    private CardState mCardState;
    private RegistrantList mCarrierPrivilegeRegistrants;
    private UiccCarrierPrivilegeRules mCarrierPrivilegeRules;
    private CatService mCatService;
    private int mCdmaSubscriptionAppIndex;
    private CommandsInterface mCi;
    private Context mContext;
    private int mGsmUmtsSubscriptionAppIndex;
    protected Handler mHandler;
    private int mImsSubscriptionAppIndex;
    private RadioState mLastRadioState;
    private final Object mLock;
    private int mPhoneId;
    private UICCConfig mUICCConfig;
    private UiccCardApplication[] mUiccApplications;
    private PinState mUniversalPinState;

    /* renamed from: com.android.internal.telephony.uicc.UiccCard.1 */
    class C00881 implements OnClickListener {
        C00881() {
        }

        public void onClick(DialogInterface dialog, int which) {
            synchronized (UiccCard.this.mLock) {
                if (which == -1) {
                    UiccCard.this.log("Reboot due to SIM swap");
                    ((PowerManager) UiccCard.this.mContext.getSystemService("power")).reboot("SIM is added.");
                }
            }
        }
    }

    /* renamed from: com.android.internal.telephony.uicc.UiccCard.2 */
    class C00892 extends Handler {
        C00892() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case UiccCard.EVENT_CARD_REMOVED /*13*/:
                    UiccCard.this.onIccSwap(false);
                case UiccCard.EVENT_CARD_ADDED /*14*/:
                    UiccCard.this.onIccSwap(UiccCard.DBG);
                case UiccCard.EVENT_OPEN_LOGICAL_CHANNEL_DONE /*15*/:
                case UiccCard.EVENT_CLOSE_LOGICAL_CHANNEL_DONE /*16*/:
                case UiccCard.EVENT_TRANSMIT_APDU_LOGICAL_CHANNEL_DONE /*17*/:
                case UiccCard.EVENT_TRANSMIT_APDU_BASIC_CHANNEL_DONE /*18*/:
                case UiccCard.EVENT_SIM_IO_DONE /*19*/:
                    AsyncResult ar = msg.obj;
                    if (ar.exception != null) {
                        UiccCard.this.log("Error in SIM access with exception" + ar.exception);
                    }
                    AsyncResult.forMessage((Message) ar.userObj, ar.result, ar.exception);
                    ((Message) ar.userObj).sendToTarget();
                case UiccCard.EVENT_CARRIER_PRIVILIGES_LOADED /*20*/:
                    UiccCard.this.onCarrierPriviligesLoadedMessage();
                default:
                    UiccCard.this.loge("Unknown Event " + msg.what);
            }
        }
    }

    public UiccCard(Context c, CommandsInterface ci, IccCardStatus ics) {
        this.mLock = new Object();
        this.mUiccApplications = new UiccCardApplication[8];
        this.mLastRadioState = RadioState.RADIO_UNAVAILABLE;
        this.mUICCConfig = null;
        this.mAbsentRegistrants = new RegistrantList();
        this.mCarrierPrivilegeRegistrants = new RegistrantList();
        this.mHandler = new C00892();
        log("Creating");
        this.mCardState = ics.mCardState;
        update(c, ci, ics);
    }

    public UiccCard(Context c, CommandsInterface ci, IccCardStatus ics, int phoneId) {
        this.mLock = new Object();
        this.mUiccApplications = new UiccCardApplication[8];
        this.mLastRadioState = RadioState.RADIO_UNAVAILABLE;
        this.mUICCConfig = null;
        this.mAbsentRegistrants = new RegistrantList();
        this.mCarrierPrivilegeRegistrants = new RegistrantList();
        this.mHandler = new C00892();
        this.mCardState = ics.mCardState;
        this.mPhoneId = phoneId;
        update(c, ci, ics);
    }

    protected UiccCard() {
        this.mLock = new Object();
        this.mUiccApplications = new UiccCardApplication[8];
        this.mLastRadioState = RadioState.RADIO_UNAVAILABLE;
        this.mUICCConfig = null;
        this.mAbsentRegistrants = new RegistrantList();
        this.mCarrierPrivilegeRegistrants = new RegistrantList();
        this.mHandler = new C00892();
    }

    public void dispose() {
        synchronized (this.mLock) {
            log("Disposing card");
            if (this.mCatService != null) {
                this.mCatService.dispose();
            }
            for (UiccCardApplication app : this.mUiccApplications) {
                if (app != null) {
                    app.dispose();
                }
            }
            this.mCatService = null;
            this.mUiccApplications = null;
            this.mCarrierPrivilegeRules = null;
            this.mUICCConfig = null;
        }
    }

    public void update(Context c, CommandsInterface ci, IccCardStatus ics) {
        synchronized (this.mLock) {
            CardState oldState = this.mCardState;
            this.mCardState = ics.mCardState;
            this.mUniversalPinState = ics.mUniversalPinState;
            this.mGsmUmtsSubscriptionAppIndex = ics.mGsmUmtsSubscriptionAppIndex;
            this.mCdmaSubscriptionAppIndex = ics.mCdmaSubscriptionAppIndex;
            this.mImsSubscriptionAppIndex = ics.mImsSubscriptionAppIndex;
            this.mContext = c;
            this.mCi = ci;
            if (this.mUICCConfig == null) {
                this.mUICCConfig = new UICCConfig();
            }
            log(ics.mApplications.length + " applications");
            for (int i = 0; i < this.mUiccApplications.length; i++) {
                if (this.mUiccApplications[i] == null) {
                    if (i < ics.mApplications.length) {
                        this.mUiccApplications[i] = new UiccCardApplication(this, ics.mApplications[i], this.mContext, this.mCi);
                    }
                } else if (i >= ics.mApplications.length) {
                    this.mUiccApplications[i].dispose();
                    this.mUiccApplications[i] = null;
                } else {
                    this.mUiccApplications[i].update(ics.mApplications[i], this.mContext, this.mCi);
                }
            }
            createAndUpdateCatService();
            log("Before privilege rules: " + this.mCarrierPrivilegeRules + " : " + this.mCardState);
            if (this.mCarrierPrivilegeRules == null && this.mCardState == CardState.CARDSTATE_PRESENT) {
                this.mCarrierPrivilegeRules = new UiccCarrierPrivilegeRules(this, this.mHandler.obtainMessage(EVENT_CARRIER_PRIVILIGES_LOADED));
            } else if (!(this.mCarrierPrivilegeRules == null || this.mCardState == CardState.CARDSTATE_PRESENT)) {
                this.mCarrierPrivilegeRules = null;
            }
            sanitizeApplicationIndexes();
            RadioState radioState = this.mCi.getRadioState();
            log("update: radioState=" + radioState + " mLastRadioState=" + this.mLastRadioState);
            if (radioState == RadioState.RADIO_ON && this.mLastRadioState == RadioState.RADIO_ON) {
                if (oldState != CardState.CARDSTATE_ABSENT && this.mCardState == CardState.CARDSTATE_ABSENT) {
                    log("update: notify card removed");
                    this.mAbsentRegistrants.notifyRegistrants();
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_CARD_REMOVED, null));
                } else if (oldState == CardState.CARDSTATE_ABSENT && this.mCardState != CardState.CARDSTATE_ABSENT) {
                    log("update: notify card added");
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(EVENT_CARD_ADDED, null));
                }
            }
            this.mLastRadioState = radioState;
        }
    }

    protected void createAndUpdateCatService() {
        if (this.mUiccApplications.length <= 0 || this.mUiccApplications[0] == null) {
            if (this.mCatService != null) {
                this.mCatService.dispose();
            }
            this.mCatService = null;
        } else if (this.mCatService == null) {
            this.mCatService = CatService.getInstance(this.mCi, this.mContext, this, this.mPhoneId);
        } else {
            this.mCatService.update(this.mCi, this.mContext, this);
        }
    }

    public CatService getCatService() {
        return this.mCatService;
    }

    protected void finalize() {
        log("UiccCard finalized");
    }

    private void sanitizeApplicationIndexes() {
        this.mGsmUmtsSubscriptionAppIndex = checkIndex(this.mGsmUmtsSubscriptionAppIndex, AppType.APPTYPE_SIM, AppType.APPTYPE_USIM);
        this.mCdmaSubscriptionAppIndex = checkIndex(this.mCdmaSubscriptionAppIndex, AppType.APPTYPE_RUIM, AppType.APPTYPE_CSIM);
        this.mImsSubscriptionAppIndex = checkIndex(this.mImsSubscriptionAppIndex, AppType.APPTYPE_ISIM, null);
    }

    private int checkIndex(int index, AppType expectedAppType, AppType altExpectedAppType) {
        if (this.mUiccApplications == null || index >= this.mUiccApplications.length) {
            loge("App index " + index + " is invalid since there are no applications");
            return -1;
        } else if (index < 0) {
            return -1;
        } else {
            if (this.mUiccApplications[index].getType() == expectedAppType || this.mUiccApplications[index].getType() == altExpectedAppType) {
                return index;
            }
            loge("App index " + index + " is invalid since it's not " + expectedAppType + " and not " + altExpectedAppType);
            return -1;
        }
    }

    public void registerForAbsent(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mAbsentRegistrants.add(r);
            if (this.mCardState == CardState.CARDSTATE_ABSENT) {
                r.notifyRegistrant();
            }
        }
    }

    public void unregisterForAbsent(Handler h) {
        synchronized (this.mLock) {
            this.mAbsentRegistrants.remove(h);
        }
    }

    public void registerForCarrierPrivilegeRulesLoaded(Handler h, int what, Object obj) {
        synchronized (this.mLock) {
            Registrant r = new Registrant(h, what, obj);
            this.mCarrierPrivilegeRegistrants.add(r);
            if (areCarrierPriviligeRulesLoaded()) {
                r.notifyRegistrant();
            }
        }
    }

    public void unregisterForCarrierPrivilegeRulesLoaded(Handler h) {
        synchronized (this.mLock) {
            this.mCarrierPrivilegeRegistrants.remove(h);
        }
    }

    private void onIccSwap(boolean isAdded) {
        Throwable th;
        if (this.mContext.getResources().getBoolean(17956929)) {
            log("onIccSwap: isHotSwapSupported is true, don't prompt for rebooting");
            return;
        }
        log("onIccSwap: isHotSwapSupported is false, prompt for rebooting");
        synchronized (this.mLock) {
            try {
                OnClickListener listener = new C00881();
                try {
                    String message;
                    Resources r = Resources.getSystem();
                    String title = isAdded ? r.getString(17040618) : r.getString(17040615);
                    if (isAdded) {
                        message = r.getString(17040619);
                    } else {
                        message = r.getString(17040616);
                    }
                    AlertDialog dialog = new Builder(this.mContext).setTitle(title).setMessage(message).setPositiveButton(r.getString(17040620), listener).create();
                    dialog.getWindow().setType(2003);
                    dialog.show();
                } catch (Throwable th2) {
                    th = th2;
                    OnClickListener onClickListener = listener;
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                throw th;
            }
        }
    }

    private void onCarrierPriviligesLoadedMessage() {
        synchronized (this.mLock) {
            this.mCarrierPrivilegeRegistrants.notifyRegistrants();
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean isApplicationOnIcc(com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType r4) {
        /*
        r3 = this;
        r2 = r3.mLock;
        monitor-enter(r2);
        r0 = 0;
    L_0x0004:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0022 }
        r1 = r1.length;	 Catch:{ all -> 0x0022 }
        if (r0 >= r1) goto L_0x001f;
    L_0x0009:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0022 }
        r1 = r1[r0];	 Catch:{ all -> 0x0022 }
        if (r1 == 0) goto L_0x001c;
    L_0x000f:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0022 }
        r1 = r1[r0];	 Catch:{ all -> 0x0022 }
        r1 = r1.getType();	 Catch:{ all -> 0x0022 }
        if (r1 != r4) goto L_0x001c;
    L_0x0019:
        r1 = 1;
        monitor-exit(r2);	 Catch:{ all -> 0x0022 }
    L_0x001b:
        return r1;
    L_0x001c:
        r0 = r0 + 1;
        goto L_0x0004;
    L_0x001f:
        r1 = 0;
        monitor-exit(r2);	 Catch:{ all -> 0x0022 }
        goto L_0x001b;
    L_0x0022:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0022 }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.UiccCard.isApplicationOnIcc(com.android.internal.telephony.uicc.IccCardApplicationStatus$AppType):boolean");
    }

    public CardState getCardState() {
        CardState cardState;
        synchronized (this.mLock) {
            cardState = this.mCardState;
        }
        return cardState;
    }

    public PinState getUniversalPinState() {
        PinState pinState;
        synchronized (this.mLock) {
            pinState = this.mUniversalPinState;
        }
        return pinState;
    }

    public UiccCardApplication getApplication(int family) {
        UiccCardApplication uiccCardApplication;
        synchronized (this.mLock) {
            int index = 8;
            switch (family) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    index = this.mGsmUmtsSubscriptionAppIndex;
                    break;
                case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    index = this.mCdmaSubscriptionAppIndex;
                    break;
                case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    index = this.mImsSubscriptionAppIndex;
                    break;
            }
            if (index >= 0) {
                if (index < this.mUiccApplications.length) {
                    uiccCardApplication = this.mUiccApplications[index];
                }
            }
            uiccCardApplication = null;
        }
        return uiccCardApplication;
    }

    public UiccCardApplication getApplicationIndex(int index) {
        UiccCardApplication uiccCardApplication;
        synchronized (this.mLock) {
            if (index >= 0) {
                if (index < this.mUiccApplications.length) {
                    uiccCardApplication = this.mUiccApplications[index];
                }
            }
            uiccCardApplication = null;
        }
        return uiccCardApplication;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public com.android.internal.telephony.uicc.UiccCardApplication getApplicationByType(int r4) {
        /*
        r3 = this;
        r2 = r3.mLock;
        monitor-enter(r2);
        r0 = 0;
    L_0x0004:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0029 }
        r1 = r1.length;	 Catch:{ all -> 0x0029 }
        if (r0 >= r1) goto L_0x0026;
    L_0x0009:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0029 }
        r1 = r1[r0];	 Catch:{ all -> 0x0029 }
        if (r1 == 0) goto L_0x0023;
    L_0x000f:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0029 }
        r1 = r1[r0];	 Catch:{ all -> 0x0029 }
        r1 = r1.getType();	 Catch:{ all -> 0x0029 }
        r1 = r1.ordinal();	 Catch:{ all -> 0x0029 }
        if (r1 != r4) goto L_0x0023;
    L_0x001d:
        r1 = r3.mUiccApplications;	 Catch:{ all -> 0x0029 }
        r1 = r1[r0];	 Catch:{ all -> 0x0029 }
        monitor-exit(r2);	 Catch:{ all -> 0x0029 }
    L_0x0022:
        return r1;
    L_0x0023:
        r0 = r0 + 1;
        goto L_0x0004;
    L_0x0026:
        r1 = 0;
        monitor-exit(r2);	 Catch:{ all -> 0x0029 }
        goto L_0x0022;
    L_0x0029:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0029 }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.UiccCard.getApplicationByType(int):com.android.internal.telephony.uicc.UiccCardApplication");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean resetAppWithAid(java.lang.String r6) {
        /*
        r5 = this;
        r3 = r5.mLock;
        monitor-enter(r3);
        r0 = 0;
        r1 = 0;
    L_0x0005:
        r2 = r5.mUiccApplications;	 Catch:{ all -> 0x0032 }
        r2 = r2.length;	 Catch:{ all -> 0x0032 }
        if (r1 >= r2) goto L_0x0030;
    L_0x000a:
        r2 = r5.mUiccApplications;	 Catch:{ all -> 0x0032 }
        r2 = r2[r1];	 Catch:{ all -> 0x0032 }
        if (r2 == 0) goto L_0x002d;
    L_0x0010:
        if (r6 == 0) goto L_0x0020;
    L_0x0012:
        r2 = r5.mUiccApplications;	 Catch:{ all -> 0x0032 }
        r2 = r2[r1];	 Catch:{ all -> 0x0032 }
        r2 = r2.getAid();	 Catch:{ all -> 0x0032 }
        r2 = r6.equals(r2);	 Catch:{ all -> 0x0032 }
        if (r2 == 0) goto L_0x002d;
    L_0x0020:
        r2 = r5.mUiccApplications;	 Catch:{ all -> 0x0032 }
        r2 = r2[r1];	 Catch:{ all -> 0x0032 }
        r2.dispose();	 Catch:{ all -> 0x0032 }
        r2 = r5.mUiccApplications;	 Catch:{ all -> 0x0032 }
        r4 = 0;
        r2[r1] = r4;	 Catch:{ all -> 0x0032 }
        r0 = 1;
    L_0x002d:
        r1 = r1 + 1;
        goto L_0x0005;
    L_0x0030:
        monitor-exit(r3);	 Catch:{ all -> 0x0032 }
        return r0;
    L_0x0032:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x0032 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.uicc.UiccCard.resetAppWithAid(java.lang.String):boolean");
    }

    public void iccOpenLogicalChannel(String AID, Message response) {
        this.mCi.iccOpenLogicalChannel(AID, this.mHandler.obtainMessage(EVENT_OPEN_LOGICAL_CHANNEL_DONE, response));
    }

    public void iccCloseLogicalChannel(int channel, Message response) {
        this.mCi.iccCloseLogicalChannel(channel, this.mHandler.obtainMessage(EVENT_CLOSE_LOGICAL_CHANNEL_DONE, response));
    }

    public void iccTransmitApduLogicalChannel(int channel, int cla, int command, int p1, int p2, int p3, String data, Message response) {
        this.mCi.iccTransmitApduLogicalChannel(channel, cla, command, p1, p2, p3, data, this.mHandler.obtainMessage(EVENT_TRANSMIT_APDU_LOGICAL_CHANNEL_DONE, response));
    }

    public void iccTransmitApduBasicChannel(int cla, int command, int p1, int p2, int p3, String data, Message response) {
        this.mCi.iccTransmitApduBasicChannel(cla, command, p1, p2, p3, data, this.mHandler.obtainMessage(EVENT_TRANSMIT_APDU_BASIC_CHANNEL_DONE, response));
    }

    public void iccExchangeSimIO(int fileID, int command, int p1, int p2, int p3, String pathID, Message response) {
        this.mCi.iccIO(command, fileID, pathID, p1, p2, p3, null, null, this.mHandler.obtainMessage(EVENT_SIM_IO_DONE, response));
    }

    public void sendEnvelopeWithStatus(String contents, Message response) {
        this.mCi.sendEnvelopeWithStatus(contents, response);
    }

    public int getNumApplications() {
        int count = 0;
        for (UiccCardApplication a : this.mUiccApplications) {
            if (a != null) {
                count++;
            }
        }
        return count;
    }

    public int getPhoneId() {
        return this.mPhoneId;
    }

    public boolean areCarrierPriviligeRulesLoaded() {
        return (this.mCarrierPrivilegeRules == null || this.mCarrierPrivilegeRules.areCarrierPriviligeRulesLoaded()) ? DBG : false;
    }

    public int getCarrierPrivilegeStatus(Signature signature, String packageName) {
        return this.mCarrierPrivilegeRules == null ? -1 : this.mCarrierPrivilegeRules.getCarrierPrivilegeStatus(signature, packageName);
    }

    public int getCarrierPrivilegeStatus(PackageManager packageManager, String packageName) {
        return this.mCarrierPrivilegeRules == null ? -1 : this.mCarrierPrivilegeRules.getCarrierPrivilegeStatus(packageManager, packageName);
    }

    public int getCarrierPrivilegeStatusForCurrentTransaction(PackageManager packageManager) {
        return this.mCarrierPrivilegeRules == null ? -1 : this.mCarrierPrivilegeRules.getCarrierPrivilegeStatusForCurrentTransaction(packageManager);
    }

    public List<String> getCarrierPackageNamesForIntent(PackageManager packageManager, Intent intent) {
        return this.mCarrierPrivilegeRules == null ? null : this.mCarrierPrivilegeRules.getCarrierPackageNamesForIntent(packageManager, intent);
    }

    public boolean setOperatorBrandOverride(String brand) {
        log("setOperatorBrandOverride: " + brand);
        log("current iccId: " + getIccId());
        String iccId = getIccId();
        if (TextUtils.isEmpty(iccId)) {
            return false;
        }
        Editor spEditor = PreferenceManager.getDefaultSharedPreferences(this.mContext).edit();
        String key = OPERATOR_BRAND_OVERRIDE_PREFIX + iccId;
        if (brand == null) {
            spEditor.remove(key).commit();
        } else {
            spEditor.putString(key, brand).commit();
        }
        return DBG;
    }

    public String getOperatorBrandOverride() {
        String iccId = getIccId();
        if (TextUtils.isEmpty(iccId)) {
            return null;
        }
        return PreferenceManager.getDefaultSharedPreferences(this.mContext).getString(OPERATOR_BRAND_OVERRIDE_PREFIX + iccId, null);
    }

    public String getIccId() {
        for (UiccCardApplication app : this.mUiccApplications) {
            if (app != null) {
                IccRecords ir = app.getIccRecords();
                if (!(ir == null || ir.getIccId() == null)) {
                    return ir.getIccId();
                }
            }
        }
        return null;
    }

    public UICCConfig getUICCConfig() {
        return this.mUICCConfig;
    }

    private void log(String msg) {
        Rlog.d(LOG_TAG, msg);
    }

    private void loge(String msg) {
        Rlog.e(LOG_TAG, msg);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        int i;
        pw.println("UiccCard:");
        pw.println(" mCi=" + this.mCi);
        pw.println(" mLastRadioState=" + this.mLastRadioState);
        pw.println(" mCatService=" + this.mCatService);
        pw.println(" mAbsentRegistrants: size=" + this.mAbsentRegistrants.size());
        for (i = 0; i < this.mAbsentRegistrants.size(); i++) {
            pw.println("  mAbsentRegistrants[" + i + "]=" + ((Registrant) this.mAbsentRegistrants.get(i)).getHandler());
        }
        for (i = 0; i < this.mCarrierPrivilegeRegistrants.size(); i++) {
            pw.println("  mCarrierPrivilegeRegistrants[" + i + "]=" + ((Registrant) this.mCarrierPrivilegeRegistrants.get(i)).getHandler());
        }
        pw.println(" mCardState=" + this.mCardState);
        pw.println(" mUniversalPinState=" + this.mUniversalPinState);
        pw.println(" mGsmUmtsSubscriptionAppIndex=" + this.mGsmUmtsSubscriptionAppIndex);
        pw.println(" mCdmaSubscriptionAppIndex=" + this.mCdmaSubscriptionAppIndex);
        pw.println(" mImsSubscriptionAppIndex=" + this.mImsSubscriptionAppIndex);
        pw.println(" mImsSubscriptionAppIndex=" + this.mImsSubscriptionAppIndex);
        pw.println(" mUiccApplications: length=" + this.mUiccApplications.length);
        for (i = 0; i < this.mUiccApplications.length; i++) {
            if (this.mUiccApplications[i] == null) {
                pw.println("  mUiccApplications[" + i + "]=" + null);
            } else {
                pw.println("  mUiccApplications[" + i + "]=" + this.mUiccApplications[i].getType() + " " + this.mUiccApplications[i]);
            }
        }
        pw.println();
        for (UiccCardApplication app : this.mUiccApplications) {
            if (app != null) {
                app.dump(fd, pw, args);
                pw.println();
            }
        }
        for (UiccCardApplication app2 : this.mUiccApplications) {
            if (app2 != null) {
                IccRecords ir = app2.getIccRecords();
                if (ir != null) {
                    ir.dump(fd, pw, args);
                    pw.println();
                }
            }
        }
        if (this.mCarrierPrivilegeRules == null) {
            pw.println(" mCarrierPrivilegeRules: null");
        } else {
            pw.println(" mCarrierPrivilegeRules: " + this.mCarrierPrivilegeRules);
            this.mCarrierPrivilegeRules.dump(fd, pw, args);
        }
        pw.println(" mCarrierPrivilegeRegistrants: size=" + this.mCarrierPrivilegeRegistrants.size());
        for (i = 0; i < this.mCarrierPrivilegeRegistrants.size(); i++) {
            pw.println("  mCarrierPrivilegeRegistrants[" + i + "]=" + ((Registrant) this.mCarrierPrivilegeRegistrants.get(i)).getHandler());
        }
        pw.flush();
    }
}
