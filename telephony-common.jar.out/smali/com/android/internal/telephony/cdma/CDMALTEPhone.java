package com.android.internal.telephony.cdma;

import android.content.ContentValues;
import android.content.Context;
import android.database.SQLException;
import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.SystemProperties;
import android.provider.Telephony.Carriers;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.DctConstants.State;
import com.android.internal.telephony.MccTable;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.PhoneNotifier;
import com.android.internal.telephony.PhoneProxy;
import com.android.internal.telephony.PhoneSubInfo;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.dataconnection.DcTracker;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IsimRecords;
import com.android.internal.telephony.uicc.IsimUiccRecords;
import com.android.internal.telephony.uicc.RuimRecords;
import com.android.internal.telephony.uicc.SIMRecords;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;

public class CDMALTEPhone extends CDMAPhone {
    private static final boolean DBG = true;
    static final String LOG_LTE_TAG = "CDMALTEPhone";
    private IsimUiccRecords mIsimUiccRecords;
    private SIMRecords mSimRecords;

    /* renamed from: com.android.internal.telephony.cdma.CDMALTEPhone.1 */
    static /* synthetic */ class C00391 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$DctConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.RETRYING.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.FAILED.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.IDLE.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTED.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.DISCONNECTING.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.SCANNING.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
        }
    }

    public CDMALTEPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, int phoneId) {
        this(context, ci, notifier, false, phoneId);
    }

    public CDMALTEPhone(Context context, CommandsInterface ci, PhoneNotifier notifier, boolean unitTestMode, int phoneId) {
        super(context, ci, notifier, phoneId);
        Rlog.d("CDMAPhone", "CDMALTEPhone: constructor: sub = " + this.mPhoneId);
        this.mDcTracker = new DcTracker(this);
    }

    protected void initSstIcc() {
        this.mSST = new CdmaLteServiceStateTracker(this);
    }

    public void dispose() {
        synchronized (PhoneProxy.lockForRadioTechnologyChange) {
            if (this.mSimRecords != null) {
                this.mSimRecords.unregisterForRecordsLoaded(this);
            }
            super.dispose();
        }
    }

    public void removeReferences() {
        super.removeReferences();
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                super.handleMessage(msg);
            default:
                if (this.mIsTheCurrentActivePhone) {
                    switch (msg.what) {
                        case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                            this.mSimRecordsLoadedRegistrants.notifyRegistrants();
                            return;
                        default:
                            super.handleMessage(msg);
                            return;
                    }
                }
                Rlog.e("CDMAPhone", "Received message " + msg + "[" + msg.what + "] while being destroyed. Ignoring.");
        }
    }

    public DataState getDataConnectionState(String apnType) {
        DataState ret = DataState.DISCONNECTED;
        if (this.mSST != null) {
            if (this.mDcTracker.isApnTypeEnabled(apnType)) {
                switch (C00391.$SwitchMap$com$android$internal$telephony$DctConstants$State[this.mDcTracker.getState(apnType).ordinal()]) {
                    case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                        ret = DataState.DISCONNECTED;
                        break;
                    case CharacterSets.ISO_8859_1 /*4*/:
                    case CharacterSets.ISO_8859_2 /*5*/:
                        if (this.mCT.mState != PhoneConstants.State.IDLE && !this.mSST.isConcurrentVoiceAndDataAllowed()) {
                            ret = DataState.SUSPENDED;
                            break;
                        }
                        ret = DataState.CONNECTED;
                        break;
                    case CharacterSets.ISO_8859_3 /*6*/:
                    case CharacterSets.ISO_8859_4 /*7*/:
                        ret = DataState.CONNECTING;
                        break;
                    default:
                        break;
                }
            }
            ret = DataState.DISCONNECTED;
        } else {
            ret = DataState.DISCONNECTED;
        }
        log("getDataConnectionState apnType=" + apnType + " ret=" + ret);
        return ret;
    }

    boolean updateCurrentCarrierInProvider(String operatorNumeric) {
        boolean retVal;
        if (this.mUiccController.getUiccCardApplication(this.mPhoneId, 1) == null) {
            log("updateCurrentCarrierInProvider APP_FAM_3GPP == null");
            retVal = super.updateCurrentCarrierInProvider(operatorNumeric);
        } else {
            log("updateCurrentCarrierInProvider not updated");
            retVal = DBG;
        }
        log("updateCurrentCarrierInProvider X retVal=" + retVal);
        return retVal;
    }

    public boolean updateCurrentCarrierInProvider() {
        long currentDds = (long) SubscriptionManager.getDefaultDataSubId();
        String operatorNumeric = getOperatorNumeric();
        Rlog.d("CDMAPhone", "updateCurrentCarrierInProvider: mSubscription = " + getSubId() + " currentDds = " + currentDds + " operatorNumeric = " + operatorNumeric);
        if (!TextUtils.isEmpty(operatorNumeric) && ((long) getSubId()) == currentDds) {
            try {
                Uri uri = Uri.withAppendedPath(Carriers.CONTENT_URI, Carriers.CURRENT);
                ContentValues map = new ContentValues();
                map.put(Carriers.NUMERIC, operatorNumeric);
                this.mContext.getContentResolver().insert(uri, map);
                return DBG;
            } catch (SQLException e) {
                Rlog.e("CDMAPhone", "Can't store current operator", e);
            }
        }
        return false;
    }

    public String getSubscriberId() {
        return this.mSimRecords != null ? this.mSimRecords.getIMSI() : "";
    }

    public String getGroupIdLevel1() {
        return this.mSimRecords != null ? this.mSimRecords.getGid1() : "";
    }

    public String getImei() {
        return this.mImei;
    }

    public String getDeviceSvn() {
        return this.mImeiSv;
    }

    public IsimRecords getIsimRecords() {
        return this.mIsimUiccRecords;
    }

    public String getMsisdn() {
        return this.mSimRecords != null ? this.mSimRecords.getMsisdnNumber() : null;
    }

    public void getAvailableNetworks(Message response) {
        this.mCi.getAvailableNetworks(response);
    }

    protected void onUpdateIccAvailability() {
        if (this.mSimRecords != null) {
            this.mSimRecords.unregisterForRecordsLoaded(this);
        }
        if (this.mUiccController != null) {
            UiccCardApplication newUiccApplication = this.mUiccController.getUiccCardApplication(this.mPhoneId, 3);
            IsimUiccRecords newIsimUiccRecords = null;
            if (newUiccApplication != null) {
                newIsimUiccRecords = (IsimUiccRecords) newUiccApplication.getIccRecords();
            }
            this.mIsimUiccRecords = newIsimUiccRecords;
            newUiccApplication = this.mUiccController.getUiccCardApplication(this.mPhoneId, 1);
            SIMRecords newSimRecords = null;
            if (newUiccApplication != null) {
                newSimRecords = (SIMRecords) newUiccApplication.getIccRecords();
            }
            this.mSimRecords = newSimRecords;
            if (this.mSimRecords != null) {
                this.mSimRecords.registerForRecordsLoaded(this, 3, null);
            }
            super.onUpdateIccAvailability();
        }
    }

    protected void init(Context context, PhoneNotifier notifier) {
        this.mCi.setPhoneType(2);
        this.mCT = new CdmaCallTracker(this);
        this.mCdmaSSM = CdmaSubscriptionSourceManager.getInstance(context, this.mCi, this, 27, null);
        this.mRuimPhoneBookInterfaceManager = new RuimPhoneBookInterfaceManager(this);
        this.mSubInfo = new PhoneSubInfo(this);
        this.mEriManager = new EriManager(this, context, 0);
        this.mCi.registerForAvailable(this, 1, null);
        this.mCi.registerForOffOrNotAvailable(this, 8, null);
        this.mCi.registerForOn(this, 5, null);
        this.mCi.setOnSuppServiceNotification(this, 2, null);
        this.mSST.registerForNetworkAttached(this, 19, null);
        this.mCi.setEmergencyCallbackMode(this, 25, null);
        this.mCi.registerForExitEmergencyCallbackMode(this, 26, null);
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(1, "CDMAPhone");
        this.mIsPhoneInEcmState = SystemProperties.get("ril.cdma.inecmmode", "false").equals("true");
        if (this.mIsPhoneInEcmState) {
            this.mCi.exitEmergencyCallbackMode(obtainMessage(26));
        }
        this.mCarrierOtaSpNumSchema = TelephonyManager.from(this.mContext).getOtaSpNumberSchemaForPhone(getPhoneId(), "");
        setProperties();
    }

    private void setProperties() {
        TelephonyManager tm = TelephonyManager.from(this.mContext);
        tm.setPhoneType(getPhoneId(), 2);
        String operatorAlpha = SystemProperties.get("ro.cdma.home.operator.alpha");
        if (!TextUtils.isEmpty(operatorAlpha)) {
            tm.setSimOperatorNameForPhone(getPhoneId(), operatorAlpha);
        }
        String operatorNumeric = SystemProperties.get(PROPERTY_CDMA_HOME_OPERATOR_NUMERIC);
        log("update icc_operator_numeric=" + operatorNumeric);
        if (!TextUtils.isEmpty(operatorNumeric)) {
            tm.setSimOperatorNumericForPhone(getPhoneId(), operatorNumeric);
            SubscriptionController.getInstance().setMccMnc(operatorNumeric, getSubId());
            setIsoCountryProperty(operatorNumeric);
            log("update mccmnc=" + operatorNumeric);
            MccTable.updateMccMncConfiguration(this.mContext, operatorNumeric, false);
        }
        updateCurrentCarrierInProvider();
    }

    public void setSystemProperty(String property, String value) {
        if (!getUnitTestMode()) {
            TelephonyManager.setTelephonyProperty(this.mPhoneId, property, value);
        }
    }

    public String getSystemProperty(String property, String defValue) {
        if (getUnitTestMode()) {
            return null;
        }
        return TelephonyManager.getTelephonyProperty(this.mPhoneId, property, defValue);
    }

    public void updateDataConnectionTracker() {
        ((DcTracker) this.mDcTracker).update();
    }

    public void setInternalDataEnabled(boolean enable, Message onCompleteMsg) {
        ((DcTracker) this.mDcTracker).setInternalDataEnabled(enable, onCompleteMsg);
    }

    public boolean setInternalDataEnabledFlag(boolean enable) {
        return ((DcTracker) this.mDcTracker).setInternalDataEnabledFlag(enable);
    }

    public String getOperatorNumeric() {
        String operatorNumeric = null;
        IccRecords curIccRecords = null;
        if (this.mCdmaSubscriptionSource == 1) {
            operatorNumeric = SystemProperties.get("ro.cdma.home.operator.numeric");
        } else if (this.mCdmaSubscriptionSource == 0) {
            curIccRecords = this.mSimRecords;
            if (curIccRecords != null) {
                operatorNumeric = curIccRecords.getOperatorNumeric();
            } else {
                curIccRecords = (IccRecords) this.mIccRecords.get();
                if (curIccRecords != null && (curIccRecords instanceof RuimRecords)) {
                    operatorNumeric = ((RuimRecords) curIccRecords).getRUIMOperatorNumeric();
                }
            }
        }
        if (operatorNumeric == null) {
            Rlog.e("CDMAPhone", "getOperatorNumeric: Cannot retrieve operatorNumeric: mCdmaSubscriptionSource = " + this.mCdmaSubscriptionSource + " mIccRecords = " + (curIccRecords != null ? Boolean.valueOf(curIccRecords.getRecordsLoaded()) : null));
        }
        Rlog.d("CDMAPhone", "getOperatorNumeric: mCdmaSubscriptionSource = " + this.mCdmaSubscriptionSource + " operatorNumeric = " + operatorNumeric);
        return operatorNumeric;
    }

    public void registerForAllDataDisconnected(Handler h, int what, Object obj) {
        ((DcTracker) this.mDcTracker).registerForAllDataDisconnected(h, what, obj);
    }

    public void unregisterForAllDataDisconnected(Handler h) {
        ((DcTracker) this.mDcTracker).unregisterForAllDataDisconnected(h);
    }

    public void registerForSimRecordsLoaded(Handler h, int what, Object obj) {
        this.mSimRecordsLoadedRegistrants.addUnique(h, what, obj);
    }

    public void unregisterForSimRecordsLoaded(Handler h) {
        this.mSimRecordsLoadedRegistrants.remove(h);
    }

    protected void log(String s) {
        Rlog.d(LOG_LTE_TAG, s);
    }

    protected void loge(String s) {
        Rlog.e(LOG_LTE_TAG, s);
    }

    protected void loge(String s, Throwable e) {
        Rlog.e(LOG_LTE_TAG, s, e);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("CDMALTEPhone extends:");
        super.dump(fd, pw, args);
    }
}
