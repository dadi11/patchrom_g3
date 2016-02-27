package com.android.internal.telephony.dataconnection;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources.NotFoundException;
import android.database.ContentObserver;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.net.NetworkConfig;
import android.net.NetworkUtils;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.AsyncResult;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.os.RegistrantList;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Telephony.Carriers;
import android.provider.Telephony.Mms.Part;
import android.provider.Telephony.TextBasedSmsColumns;
import android.provider.Telephony.ThreadsColumns;
import android.telephony.CellLocation;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.telephony.cdma.CdmaCellLocation;
import android.telephony.gsm.GsmCellLocation;
import android.text.TextUtils;
import android.util.EventLog;
import com.android.internal.telephony.DctConstants.State;
import com.android.internal.telephony.EventLogTags;
import com.android.internal.telephony.HbpcdLookup;
import com.android.internal.telephony.ITelephony.Stub;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneConstants;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.android.internal.telephony.ServiceStateTracker;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cdma.CDMALTEPhone;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.gsm.GSMPhone;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.util.ArrayUtils;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicBoolean;

public final class DcTracker extends DcTrackerBase {
    static final String APN_ID = "apn_id";
    private static final int POLL_PDP_MILLIS = 5000;
    static final Uri PREFERAPN_NO_UPDATE_URI_USING_SUBID;
    private static final int PROVISIONING_SPINNER_TIMEOUT_MILLIS = 120000;
    private static final String PUPPET_MASTER_RADIO_STRESS_TEST = "gsm.defaultpdpcontext.active";
    protected final String LOG_TAG;
    private RegistrantList mAllDataDisconnectedRegistrants;
    private ApnChangeObserver mApnObserver;
    private AtomicBoolean mAttached;
    private boolean mCanSetPreferApn;
    private boolean mDeregistrationAlarmState;
    private ArrayList<Message> mDisconnectAllCompleteMsgList;
    protected int mDisconnectPendingCount;
    private PendingIntent mImsDeregistrationDelayIntent;
    public boolean mImsRegistrationState;
    private final String mProvisionActionName;
    private BroadcastReceiver mProvisionBroadcastReceiver;
    private ProgressDialog mProvisioningSpinner;
    private boolean mReregisterOnReconnectFailure;
    private ApnContext mWaitCleanUpApnContext;

    /* renamed from: com.android.internal.telephony.dataconnection.DcTracker.1 */
    static /* synthetic */ class C00571 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$DctConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$DctConstants$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTED.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.DISCONNECTING.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.RETRYING.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.CONNECTING.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.IDLE.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.SCANNING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$DctConstants$State[State.FAILED.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
        }
    }

    private class ApnChangeObserver extends ContentObserver {
        public ApnChangeObserver() {
            super(DcTracker.this.mDataConnectionTracker);
        }

        public void onChange(boolean selfChange) {
            DcTracker.this.sendMessage(DcTracker.this.obtainMessage(270355));
        }
    }

    private class ProvisionNotificationBroadcastReceiver extends BroadcastReceiver {
        private final String mNetworkOperator;
        private final String mProvisionUrl;

        public ProvisionNotificationBroadcastReceiver(String provisionUrl, String networkOperator) {
            this.mNetworkOperator = networkOperator;
            this.mProvisionUrl = provisionUrl;
        }

        private void setEnableFailFastMobileData(int enabled) {
            DcTracker.this.sendMessage(DcTracker.this.obtainMessage(270372, enabled, 0));
        }

        private void enableMobileProvisioning() {
            Message msg = DcTracker.this.obtainMessage(270373);
            msg.setData(Bundle.forPair("provisioningUrl", this.mProvisionUrl));
            DcTracker.this.sendMessage(msg);
        }

        public void onReceive(Context context, Intent intent) {
            DcTracker.this.mProvisioningSpinner = new ProgressDialog(context);
            DcTracker.this.mProvisioningSpinner.setTitle(this.mNetworkOperator);
            DcTracker.this.mProvisioningSpinner.setMessage(context.getText(17040875));
            DcTracker.this.mProvisioningSpinner.setIndeterminate(true);
            DcTracker.this.mProvisioningSpinner.setCancelable(true);
            DcTracker.this.mProvisioningSpinner.getWindow().setType(2009);
            DcTracker.this.mProvisioningSpinner.show();
            DcTracker.this.sendMessageDelayed(DcTracker.this.obtainMessage(270378, DcTracker.this.mProvisioningSpinner), 120000);
            DcTracker.this.setRadio(true);
            setEnableFailFastMobileData(1);
            enableMobileProvisioning();
        }
    }

    private enum RetryFailures {
        ALWAYS,
        ONLY_ON_CHANGE
    }

    static {
        PREFERAPN_NO_UPDATE_URI_USING_SUBID = Uri.parse("content://telephony/carriers/preferapn_no_update/subId/");
    }

    public DcTracker(PhoneBase p) {
        super(p);
        this.LOG_TAG = "DCT";
        this.mDisconnectAllCompleteMsgList = new ArrayList();
        this.mAllDataDisconnectedRegistrants = new RegistrantList();
        this.mDisconnectPendingCount = 0;
        this.mReregisterOnReconnectFailure = false;
        this.mCanSetPreferApn = false;
        this.mAttached = new AtomicBoolean(false);
        this.mImsRegistrationState = false;
        this.mWaitCleanUpApnContext = null;
        this.mDeregistrationAlarmState = false;
        this.mImsDeregistrationDelayIntent = null;
        log("GsmDCT.constructor");
        this.mDataConnectionTracker = this;
        update();
        this.mApnObserver = new ApnChangeObserver();
        p.getContext().getContentResolver().registerContentObserver(Carriers.CONTENT_URI, true, this.mApnObserver);
        initApnContexts();
        for (ApnContext apnContext : this.mApnContexts.values()) {
            IntentFilter filter = new IntentFilter();
            filter.addAction("com.android.internal.telephony.data-reconnect." + apnContext.getApnType());
            filter.addAction("com.android.internal.telephony.data-restart-trysetup." + apnContext.getApnType());
            this.mPhone.getContext().registerReceiver(this.mIntentReceiver, filter, null, this.mPhone);
        }
        initEmergencyApnSetting();
        addEmergencyApnSetting();
        this.mProvisionActionName = "com.android.internal.telephony.PROVISION" + p.getPhoneId();
    }

    protected void registerForAllEvents() {
        this.mPhone.mCi.registerForAvailable(this, 270337, null);
        this.mPhone.mCi.registerForOffOrNotAvailable(this, 270342, null);
        this.mPhone.mCi.registerForDataNetworkStateChanged(this, 270340, null);
        this.mPhone.getCallTracker().registerForVoiceCallEnded(this, 270344, null);
        this.mPhone.getCallTracker().registerForVoiceCallStarted(this, 270343, null);
        this.mPhone.getServiceStateTracker().registerForDataConnectionAttached(this, 270352, null);
        this.mPhone.getServiceStateTracker().registerForDataConnectionDetached(this, 270345, null);
        this.mPhone.getServiceStateTracker().registerForDataRoamingOn(this, 270347, null);
        this.mPhone.getServiceStateTracker().registerForDataRoamingOff(this, 270348, null);
        this.mPhone.getServiceStateTracker().registerForPsRestrictedEnabled(this, 270358, null);
        this.mPhone.getServiceStateTracker().registerForPsRestrictedDisabled(this, 270359, null);
        this.mPhone.getServiceStateTracker().registerForDataRegStateOrRatChanged(this, 270377, null);
    }

    public void dispose() {
        log("DcTracker.dispose");
        if (this.mProvisionBroadcastReceiver != null) {
            this.mPhone.getContext().unregisterReceiver(this.mProvisionBroadcastReceiver);
            this.mProvisionBroadcastReceiver = null;
        }
        if (this.mProvisioningSpinner != null) {
            this.mProvisioningSpinner.dismiss();
            this.mProvisioningSpinner = null;
        }
        cleanUpAllConnections(true, null);
        super.dispose();
        this.mPhone.getContext().getContentResolver().unregisterContentObserver(this.mApnObserver);
        this.mApnContexts.clear();
        this.mPrioritySortedApnContexts.clear();
        destroyDataConnections();
    }

    protected void unregisterForAllEvents() {
        this.mPhone.mCi.unregisterForAvailable(this);
        this.mPhone.mCi.unregisterForOffOrNotAvailable(this);
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null) {
            r.unregisterForRecordsLoaded(this);
            this.mIccRecords.set(null);
        }
        this.mPhone.mCi.unregisterForDataNetworkStateChanged(this);
        this.mPhone.getCallTracker().unregisterForVoiceCallEnded(this);
        this.mPhone.getCallTracker().unregisterForVoiceCallStarted(this);
        this.mPhone.getServiceStateTracker().unregisterForDataConnectionAttached(this);
        this.mPhone.getServiceStateTracker().unregisterForDataConnectionDetached(this);
        this.mPhone.getServiceStateTracker().unregisterForDataRoamingOn(this);
        this.mPhone.getServiceStateTracker().unregisterForDataRoamingOff(this);
        this.mPhone.getServiceStateTracker().unregisterForPsRestrictedEnabled(this);
        this.mPhone.getServiceStateTracker().unregisterForPsRestrictedDisabled(this);
    }

    public void incApnRefCount(String name) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(name);
        if (apnContext != null) {
            apnContext.incRefCount();
        }
    }

    public void decApnRefCount(String name) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(name);
        if (apnContext != null) {
            apnContext.decRefCount();
        }
    }

    public boolean isApnSupported(String name) {
        if (name == null) {
            loge("isApnSupported: name=null");
            return false;
        } else if (((ApnContext) this.mApnContexts.get(name)) != null) {
            return true;
        } else {
            loge("Request for unsupported mobile name: " + name);
            return false;
        }
    }

    public int getApnPriority(String name) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(name);
        if (apnContext == null) {
            loge("Request for unsupported mobile name: " + name);
        }
        return apnContext.priority;
    }

    private void setRadio(boolean on) {
        try {
            Stub.asInterface(ServiceManager.checkService("phone")).setRadio(on);
        } catch (Exception e) {
        }
    }

    public boolean isApnTypeActive(String type) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(type);
        if (apnContext == null || apnContext.getDcAc() == null) {
            return false;
        }
        return true;
    }

    public boolean isDataPossible(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext == null) {
            return false;
        }
        boolean dataAllowed;
        boolean possible;
        boolean apnContextIsEnabled = apnContext.isEnabled();
        State apnContextState = apnContext.getState();
        boolean apnTypePossible;
        if (apnContextIsEnabled && apnContextState == State.FAILED) {
            apnTypePossible = false;
        } else {
            apnTypePossible = true;
        }
        if (apnContext.getApnType().equals("emergency") || isDataAllowed()) {
            dataAllowed = true;
        } else {
            dataAllowed = false;
        }
        if (dataAllowed && apnTypePossible) {
            possible = true;
        } else {
            possible = false;
        }
        return possible;
    }

    protected void finalize() {
        log("finalize");
    }

    protected void supplyMessenger() {
        ConnectivityManager cm = (ConnectivityManager) this.mPhone.getContext().getSystemService("connectivity");
        cm.supplyMessenger(0, new Messenger(this));
        cm.supplyMessenger(2, new Messenger(this));
        cm.supplyMessenger(3, new Messenger(this));
        cm.supplyMessenger(4, new Messenger(this));
        cm.supplyMessenger(5, new Messenger(this));
        cm.supplyMessenger(10, new Messenger(this));
        cm.supplyMessenger(11, new Messenger(this));
        cm.supplyMessenger(12, new Messenger(this));
        cm.supplyMessenger(15, new Messenger(this));
    }

    private ApnContext addApnContext(String type, NetworkConfig networkConfig) {
        ApnContext apnContext = new ApnContext(this.mPhone.getContext(), type, "DCT", networkConfig, this);
        this.mApnContexts.put(type, apnContext);
        this.mPrioritySortedApnContexts.add(apnContext);
        return apnContext;
    }

    protected void initApnContexts() {
        log("initApnContexts: E");
        for (String networkConfigString : this.mPhone.getContext().getResources().getStringArray(17235981)) {
            ApnContext apnContext;
            NetworkConfig networkConfig = new NetworkConfig(networkConfigString);
            switch (networkConfig.type) {
                case CharacterSets.ANY_CHARSET /*0*/:
                    apnContext = addApnContext("default", networkConfig);
                    break;
                case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    apnContext = addApnContext("mms", networkConfig);
                    break;
                case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    apnContext = addApnContext("supl", networkConfig);
                    break;
                case CharacterSets.ISO_8859_1 /*4*/:
                    apnContext = addApnContext("dun", networkConfig);
                    break;
                case CharacterSets.ISO_8859_2 /*5*/:
                    apnContext = addApnContext("hipri", networkConfig);
                    break;
                case CharacterSets.ISO_8859_7 /*10*/:
                    apnContext = addApnContext("fota", networkConfig);
                    break;
                case CharacterSets.ISO_8859_8 /*11*/:
                    apnContext = addApnContext("ims", networkConfig);
                    break;
                case CharacterSets.ISO_8859_9 /*12*/:
                    apnContext = addApnContext("cbs", networkConfig);
                    break;
                case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                    apnContext = addApnContext("ia", networkConfig);
                    break;
                case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                    apnContext = addApnContext("emergency", networkConfig);
                    break;
                default:
                    log("initApnContexts: skipping unknown type=" + networkConfig.type);
                    continue;
            }
            log("initApnContexts: apnContext=" + apnContext);
        }
        log("initApnContexts: X mApnContexts=" + this.mApnContexts);
    }

    public LinkProperties getLinkProperties(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext != null) {
            DcAsyncChannel dcac = apnContext.getDcAc();
            if (dcac != null) {
                log("return link properites for " + apnType);
                return dcac.getLinkPropertiesSync();
            }
        }
        log("return new LinkProperties");
        return new LinkProperties();
    }

    public NetworkCapabilities getNetworkCapabilities(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext != null) {
            DcAsyncChannel dataConnectionAc = apnContext.getDcAc();
            if (dataConnectionAc != null) {
                log("get active pdp is not null, return NetworkCapabilities for " + apnType);
                return dataConnectionAc.getNetworkCapabilitiesSync();
            }
        }
        log("return new NetworkCapabilities");
        return new NetworkCapabilities();
    }

    public String[] getActiveApnTypes() {
        log("get all active apn types");
        ArrayList<String> result = new ArrayList();
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (this.mAttached.get() && apnContext.isReady()) {
                result.add(apnContext.getApnType());
            }
        }
        return (String[]) result.toArray(new String[0]);
    }

    public String getActiveApnString(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext != null) {
            ApnSetting apnSetting = apnContext.getApnSetting();
            if (apnSetting != null) {
                return apnSetting.apn;
            }
        }
        return null;
    }

    public boolean isApnTypeEnabled(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext == null) {
            return false;
        }
        return apnContext.isEnabled();
    }

    protected void setState(State s) {
        log("setState should not be used in GSM" + s);
    }

    public State getState(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext != null) {
            return apnContext.getState();
        }
        return State.FAILED;
    }

    protected boolean isProvisioningApn(String apnType) {
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
        if (apnContext != null) {
            return apnContext.isProvisioningApn();
        }
        return false;
    }

    public State getOverallState() {
        boolean isConnecting = false;
        boolean isFailed = true;
        boolean isAnyEnabled = false;
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (apnContext.isEnabled()) {
                isAnyEnabled = true;
                switch (C00571.$SwitchMap$com$android$internal$telephony$DctConstants$State[apnContext.getState().ordinal()]) {
                    case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                        log("overall state is CONNECTED");
                        return State.CONNECTED;
                    case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    case CharacterSets.ISO_8859_1 /*4*/:
                        isConnecting = true;
                        isFailed = false;
                        break;
                    case CharacterSets.ISO_8859_2 /*5*/:
                    case CharacterSets.ISO_8859_3 /*6*/:
                        isFailed = false;
                        break;
                    default:
                        isAnyEnabled = true;
                        break;
                }
            }
        }
        if (!isAnyEnabled) {
            log("overall state is IDLE");
            return State.IDLE;
        } else if (isConnecting) {
            log("overall state is CONNECTING");
            return State.CONNECTING;
        } else if (isFailed) {
            log("overall state is FAILED");
            return State.FAILED;
        } else {
            log("overall state is IDLE");
            return State.IDLE;
        }
    }

    protected boolean isApnTypeAvailable(String type) {
        if (type.equals("dun") && fetchDunApn() != null) {
            return true;
        }
        if (this.mAllApnSettings != null) {
            Iterator i$ = this.mAllApnSettings.iterator();
            while (i$.hasNext()) {
                if (((ApnSetting) i$.next()).canHandleType(type)) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean getAnyDataEnabled() {
        boolean z = false;
        synchronized (this.mDataEnabledLock) {
            if (this.mInternalDataEnabled && this.mUserDataEnabled && sPolicyDataEnabled) {
                for (ApnContext apnContext : this.mApnContexts.values()) {
                    if (isDataAllowed(apnContext)) {
                        z = true;
                        break;
                    }
                }
            }
        }
        return z;
    }

    public boolean getAnyDataEnabled(boolean checkUserDataEnabled) {
        boolean z = false;
        synchronized (this.mDataEnabledLock) {
            if (!this.mInternalDataEnabled || ((checkUserDataEnabled && !this.mUserDataEnabled) || (checkUserDataEnabled && !sPolicyDataEnabled))) {
            } else {
                for (ApnContext apnContext : this.mApnContexts.values()) {
                    if (isDataAllowed(apnContext)) {
                        z = true;
                        break;
                    }
                }
            }
        }
        return z;
    }

    private boolean isDataAllowed(ApnContext apnContext) {
        return apnContext.isReady() && isDataAllowed();
    }

    protected void onDataConnectionDetached() {
        log("onDataConnectionDetached: stop polling and notify detached");
        stopNetStatPoll();
        stopDataStallAlarm();
        notifyDataConnection(Phone.REASON_DATA_DETACHED);
        this.mAttached.set(false);
    }

    private void onDataConnectionAttached() {
        log("onDataConnectionAttached");
        this.mAttached.set(true);
        if (getOverallState() == State.CONNECTED) {
            log("onDataConnectionAttached: start polling notify attached");
            startNetStatPoll();
            startDataStallAlarm(false);
            notifyDataConnection(Phone.REASON_DATA_ATTACHED);
        } else {
            notifyOffApnsOfAvailability(Phone.REASON_DATA_ATTACHED);
        }
        if (this.mAutoAttachOnCreationConfig) {
            this.mAutoAttachOnCreation = true;
        }
        setupDataOnConnectableApns(Phone.REASON_DATA_ATTACHED);
    }

    protected boolean isDataAllowed() {
        boolean allowed = true;
        synchronized (this.mDataEnabledLock) {
            boolean internalDataEnabled = this.mInternalDataEnabled;
        }
        boolean attachedState = this.mAttached.get();
        boolean desiredPowerState = this.mPhone.getServiceStateTracker().getDesiredPowerState();
        IccRecords r = (IccRecords) this.mIccRecords.get();
        boolean recordsLoaded = false;
        if (r != null) {
            recordsLoaded = r.getRecordsLoaded();
            log("isDataAllowed getRecordsLoaded=" + recordsLoaded);
        }
        boolean psRestricted = this.mIsPsRestricted;
        if (TelephonyManager.getDefault().getPhoneCount() > 1) {
            attachedState = true;
            psRestricted = false;
        }
        boolean defaultDataSelected = SubscriptionManager.isValidSubscriptionId(SubscriptionManager.getDefaultDataSubId());
        PhoneConstants.State state = PhoneConstants.State.IDLE;
        if (this.mPhone.getCallTracker() != null) {
            state = this.mPhone.getCallTracker().getState();
        }
        if (!((attachedState || this.mAutoAttachOnCreation) && recordsLoaded && ((state == PhoneConstants.State.IDLE || this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed()) && internalDataEnabled && defaultDataSelected && ((!this.mPhone.getServiceState().getDataRoaming() || getDataOnRoamingEnabled()) && !psRestricted && desiredPowerState)))) {
            allowed = false;
        }
        if (!allowed) {
            String reason = "";
            if (!(attachedState || this.mAutoAttachOnCreation)) {
                reason = reason + " - Attached= " + attachedState;
            }
            if (!recordsLoaded) {
                reason = reason + " - SIM not loaded";
            }
            if (!(state == PhoneConstants.State.IDLE || this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed())) {
                reason = (reason + " - PhoneState= " + state) + " - Concurrent voice and data not allowed";
            }
            if (!internalDataEnabled) {
                reason = reason + " - mInternalDataEnabled= false";
            }
            if (!defaultDataSelected) {
                reason = reason + " - defaultDataSelected= false";
            }
            if (this.mPhone.getServiceState().getDataRoaming() && !getDataOnRoamingEnabled()) {
                reason = reason + " - Roaming and data roaming not enabled";
            }
            if (this.mIsPsRestricted) {
                reason = reason + " - mIsPsRestricted= true";
            }
            if (!desiredPowerState) {
                reason = reason + " - desiredPowerState= false";
            }
            log("isDataAllowed: not allowed due to" + reason);
        }
        return allowed;
    }

    private void setupDataOnConnectableApns(String reason) {
        setupDataOnConnectableApns(reason, RetryFailures.ALWAYS);
    }

    private void setupDataOnConnectableApns(String reason, RetryFailures retryFailures) {
        log("setupDataOnConnectableApns: " + reason);
        ArrayList<ApnSetting> waitingApns = null;
        Iterator i$ = this.mPrioritySortedApnContexts.iterator();
        while (i$.hasNext()) {
            ApnContext apnContext = (ApnContext) i$.next();
            log("setupDataOnConnectableApns: apnContext " + apnContext);
            if (apnContext.getState() == State.FAILED) {
                if (retryFailures == RetryFailures.ALWAYS) {
                    apnContext.setState(State.IDLE);
                } else if (apnContext.isConcurrentVoiceAndDataAllowed() || !this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed()) {
                    int radioTech = this.mPhone.getServiceState().getRilDataRadioTechnology();
                    ArrayList<ApnSetting> originalApns = apnContext.getOriginalWaitingApns();
                    if (!(originalApns == null || originalApns.isEmpty())) {
                        waitingApns = buildWaitingApns(apnContext.getApnType(), radioTech);
                        if (!(originalApns.size() == waitingApns.size() && originalApns.containsAll(waitingApns))) {
                            apnContext.setState(State.IDLE);
                        }
                    }
                } else {
                    apnContext.setState(State.IDLE);
                }
            }
            if (apnContext.isConnectable()) {
                log("setupDataOnConnectableApns: isConnectable() call trySetupData");
                apnContext.setReason(reason);
                trySetupData(apnContext, waitingApns);
            }
        }
    }

    private boolean trySetupData(ApnContext apnContext) {
        return trySetupData(apnContext, null);
    }

    private boolean trySetupData(ApnContext apnContext, ArrayList<ApnSetting> waitingApns) {
        boolean checkUserDataEnabled = true;
        log("trySetupData for type:" + apnContext.getApnType() + " due to " + apnContext.getReason() + " apnContext=" + apnContext);
        log("trySetupData with mIsPsRestricted=" + this.mIsPsRestricted);
        if (this.mPhone.getSimulatedRadioControl() != null) {
            apnContext.setState(State.CONNECTED);
            this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
            log("trySetupData: X We're on the simulator; assuming connected retValue=true");
            return true;
        }
        boolean isEmergencyApn = apnContext.getApnType().equals("emergency");
        ServiceStateTracker sst = this.mPhone.getServiceStateTracker();
        boolean desiredPowerState = sst.getDesiredPowerState();
        if (apnContext.getApnType().equals("ims")) {
            checkUserDataEnabled = false;
        }
        if (apnContext.isConnectable() && (isEmergencyApn || (isDataAllowed(apnContext) && getAnyDataEnabled(checkUserDataEnabled) && !isEmergency()))) {
            if (apnContext.getState() == State.FAILED) {
                log("trySetupData: make a FAILED ApnContext IDLE so its reusable");
                apnContext.setState(State.IDLE);
            }
            int radioTech = this.mPhone.getServiceState().getRilDataRadioTechnology();
            apnContext.setConcurrentVoiceAndDataAllowed(sst.isConcurrentVoiceAndDataAllowed());
            if (apnContext.getState() == State.IDLE) {
                if (waitingApns == null) {
                    waitingApns = buildWaitingApns(apnContext.getApnType(), radioTech);
                }
                if (waitingApns.isEmpty()) {
                    notifyNoData(DcFailCause.MISSING_UNKNOWN_APN, apnContext);
                    notifyOffApnsOfAvailability(apnContext.getReason());
                    log("trySetupData: X No APN found retValue=false");
                    return false;
                }
                apnContext.setWaitingApns(waitingApns);
                log("trySetupData: Create from mAllApnSettings : " + apnListToString(this.mAllApnSettings));
            }
            if (apnContext.getWaitingApns() == null) {
                log("trySetupData: call setupData, waitingApns : null");
            } else {
                log("trySetupData: call setupData, waitingApns : " + apnListToString(apnContext.getWaitingApns()));
            }
            boolean retValue = setupData(apnContext, radioTech);
            notifyOffApnsOfAvailability(apnContext.getReason());
            log("trySetupData: X retValue=" + retValue);
            return retValue;
        }
        if (!apnContext.getApnType().equals("default") && apnContext.isConnectable()) {
            this.mPhone.notifyDataConnectionFailed(apnContext.getReason(), apnContext.getApnType());
        }
        notifyOffApnsOfAvailability(apnContext.getReason());
        log("trySetupData: X apnContext not 'ready' retValue=false");
        return false;
    }

    protected void notifyOffApnsOfAvailability(String reason) {
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (!this.mAttached.get() || !apnContext.isReady()) {
                this.mPhone.notifyDataConnection(reason != null ? reason : apnContext.getReason(), apnContext.getApnType(), DataState.DISCONNECTED);
            }
        }
    }

    protected boolean cleanUpAllConnections(boolean tearDown, String reason) {
        log("cleanUpAllConnections: tearDown=" + tearDown + " reason=" + reason);
        boolean didDisconnect = false;
        boolean specificdisable = false;
        if (!TextUtils.isEmpty(reason)) {
            specificdisable = reason.equals(Phone.REASON_DATA_SPECIFIC_DISABLED);
        }
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (!apnContext.isDisconnected()) {
                didDisconnect = true;
            }
            if (!specificdisable) {
                apnContext.setReason(reason);
                cleanUpConnection(tearDown, apnContext);
            } else if (!apnContext.getApnType().equals("ims")) {
                log("ApnConextType: " + apnContext.getApnType());
                apnContext.setReason(reason);
                cleanUpConnection(tearDown, apnContext);
            }
        }
        stopNetStatPoll();
        stopDataStallAlarm();
        this.mRequestedApnType = "default";
        log("cleanUpConnection: mDisconnectPendingCount = " + this.mDisconnectPendingCount);
        if (tearDown && this.mDisconnectPendingCount == 0) {
            notifyDataDisconnectComplete();
            notifyAllDataDisconnected();
        }
        return didDisconnect;
    }

    protected void onCleanUpAllConnections(String cause) {
        cleanUpAllConnections(true, cause);
    }

    protected void cleanUpConnection(boolean tearDown, ApnContext apnContext) {
        if (apnContext == null) {
            log("cleanUpConnection: apn context is null");
            return;
        }
        DcAsyncChannel dcac = apnContext.getDcAc();
        log("cleanUpConnection: E tearDown=" + tearDown + " reason=" + apnContext.getReason() + " apnContext=" + apnContext);
        if (!tearDown) {
            if (dcac != null) {
                dcac.reqReset();
            }
            apnContext.setState(State.IDLE);
            this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
            apnContext.setDataConnectionAc(null);
        } else if (apnContext.isDisconnected()) {
            apnContext.setState(State.IDLE);
            if (!apnContext.isReady()) {
                if (dcac != null) {
                    log("cleanUpConnection: teardown, disconnected, !ready apnContext=" + apnContext);
                    dcac.tearDown(apnContext, "", null);
                }
                apnContext.setDataConnectionAc(null);
            }
        } else if (dcac == null) {
            apnContext.setState(State.IDLE);
            this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
        } else if (apnContext.getState() != State.DISCONNECTING) {
            boolean disconnectAll = false;
            if ("dun".equals(apnContext.getApnType()) && teardownForDun()) {
                log("cleanUpConnection: disconnectAll DUN connection");
                disconnectAll = true;
            }
            log("cleanUpConnection: tearing down" + (disconnectAll ? " all" : "") + "apnContext=" + apnContext);
            Message msg = obtainMessage(270351, apnContext);
            if (disconnectAll) {
                apnContext.getDcAc().tearDownAll(apnContext.getReason(), msg);
            } else {
                apnContext.getDcAc().tearDown(apnContext, apnContext.getReason(), msg);
            }
            apnContext.setState(State.DISCONNECTING);
            this.mDisconnectPendingCount++;
        }
        if (dcac != null) {
            cancelReconnectAlarm(apnContext);
        }
        log("cleanUpConnection: X tearDown=" + tearDown + " reason=" + apnContext.getReason() + " apnContext=" + apnContext + " dcac=" + apnContext.getDcAc());
    }

    private boolean teardownForDun() {
        if (!ServiceState.isCdma(this.mPhone.getServiceState().getRilDataRadioTechnology()) && fetchDunApn() == null) {
            return false;
        }
        return true;
    }

    private void cancelReconnectAlarm(ApnContext apnContext) {
        if (apnContext != null) {
            PendingIntent intent = apnContext.getReconnectIntent();
            if (intent != null) {
                ((AlarmManager) this.mPhone.getContext().getSystemService("alarm")).cancel(intent);
                apnContext.setReconnectIntent(null);
            }
        }
    }

    private String[] parseTypes(String types) {
        if (types != null && !types.equals("")) {
            return types.split(",");
        }
        return new String[]{CharacterSets.MIMENAME_ANY_CHARSET};
    }

    private boolean imsiMatches(String imsiDB, String imsiSIM) {
        int len = imsiDB.length();
        if (len <= 0 || len > imsiSIM.length()) {
            return false;
        }
        int idx = 0;
        while (idx < len) {
            char c = imsiDB.charAt(idx);
            if (c != 'x' && c != 'X' && c != imsiSIM.charAt(idx)) {
                return false;
            }
            idx++;
        }
        return true;
    }

    protected boolean mvnoMatches(IccRecords r, String mvnoType, String mvnoMatchData) {
        if (mvnoType.equalsIgnoreCase("spn")) {
            if (r.getServiceProviderName() != null && r.getServiceProviderName().equalsIgnoreCase(mvnoMatchData)) {
                return true;
            }
        } else if (mvnoType.equalsIgnoreCase("imsi")) {
            String imsiSIM = r.getIMSI();
            if (imsiSIM != null && imsiMatches(mvnoMatchData, imsiSIM)) {
                return true;
            }
        } else if (mvnoType.equalsIgnoreCase("gid")) {
            String gid1 = r.getGid1();
            int mvno_match_data_length = mvnoMatchData.length();
            if (gid1 != null && gid1.length() >= mvno_match_data_length && gid1.substring(0, mvno_match_data_length).equalsIgnoreCase(mvnoMatchData)) {
                return true;
            }
        }
        return false;
    }

    protected boolean isPermanentFail(DcFailCause dcFailCause) {
        return dcFailCause.isPermanentFail() && !(this.mAttached.get() && dcFailCause == DcFailCause.SIGNAL_LOST);
    }

    private ApnSetting makeApnSetting(Cursor cursor) {
        boolean z;
        boolean z2;
        String[] types = parseTypes(cursor.getString(cursor.getColumnIndexOrThrow(ThreadsColumns.TYPE)));
        int i = cursor.getInt(cursor.getColumnIndexOrThrow(HbpcdLookup.ID));
        String string = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.NUMERIC));
        String string2 = cursor.getString(cursor.getColumnIndexOrThrow(Part.NAME));
        String string3 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.APN));
        String trimV4AddrZeros = NetworkUtils.trimV4AddrZeros(cursor.getString(cursor.getColumnIndexOrThrow(Carriers.PROXY)));
        String string4 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.PORT));
        String trimV4AddrZeros2 = NetworkUtils.trimV4AddrZeros(cursor.getString(cursor.getColumnIndexOrThrow(Carriers.MMSC)));
        String trimV4AddrZeros3 = NetworkUtils.trimV4AddrZeros(cursor.getString(cursor.getColumnIndexOrThrow(Carriers.MMSPROXY)));
        String string5 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.MMSPORT));
        String string6 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.USER));
        String string7 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.PASSWORD));
        int i2 = cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.AUTH_TYPE));
        String string8 = cursor.getString(cursor.getColumnIndexOrThrow(TextBasedSmsColumns.PROTOCOL));
        String string9 = cursor.getString(cursor.getColumnIndexOrThrow(Carriers.ROAMING_PROTOCOL));
        if (cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.CARRIER_ENABLED)) == 1) {
            z = true;
        } else {
            z = false;
        }
        int i3 = cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.BEARER));
        int i4 = cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.PROFILE_ID));
        if (cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.MODEM_COGNITIVE)) == 1) {
            z2 = true;
        } else {
            z2 = false;
        }
        return new ApnSetting(i, string, string2, string3, trimV4AddrZeros, string4, trimV4AddrZeros2, trimV4AddrZeros3, string5, string6, string7, i2, types, string8, string9, z, i3, i4, z2, cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.MAX_CONNS)), cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.WAIT_TIME)), cursor.getInt(cursor.getColumnIndexOrThrow(Carriers.MAX_CONNS_TIME)), cursor.getInt(cursor.getColumnIndexOrThrow(TextBasedSmsColumns.MTU)), cursor.getString(cursor.getColumnIndexOrThrow(Carriers.MVNO_TYPE)), cursor.getString(cursor.getColumnIndexOrThrow(Carriers.MVNO_MATCH_DATA)));
    }

    private ArrayList<ApnSetting> createApnList(Cursor cursor) {
        ArrayList<ApnSetting> result;
        ArrayList<ApnSetting> mnoApns = new ArrayList();
        ArrayList<ApnSetting> mvnoApns = new ArrayList();
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (cursor.moveToFirst()) {
            do {
                ApnSetting apn = makeApnSetting(cursor);
                if (apn != null) {
                    if (!apn.hasMvnoParams()) {
                        mnoApns.add(apn);
                    } else if (r != null && mvnoMatches(r, apn.mvnoType, apn.mvnoMatchData)) {
                        mvnoApns.add(apn);
                    }
                }
            } while (cursor.moveToNext());
        }
        if (mvnoApns.isEmpty()) {
            result = mnoApns;
        } else {
            result = mvnoApns;
        }
        log("createApnList: X result=" + result);
        return result;
    }

    private boolean dataConnectionNotInUse(DcAsyncChannel dcac) {
        log("dataConnectionNotInUse: check if dcac is inuse dcac=" + dcac);
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (apnContext.getDcAc() == dcac) {
                log("dataConnectionNotInUse: in use by apnContext=" + apnContext);
                return false;
            }
        }
        log("dataConnectionNotInUse: tearDownAll");
        dcac.tearDownAll("No connection", null);
        log("dataConnectionNotInUse: not in use return true");
        return true;
    }

    private DcAsyncChannel findFreeDataConnection() {
        for (DcAsyncChannel dcac : this.mDataConnectionAcHashMap.values()) {
            if (dcac.isInactiveSync() && dataConnectionNotInUse(dcac)) {
                log("findFreeDataConnection: found free DataConnection= dcac=" + dcac);
                return dcac;
            }
        }
        log("findFreeDataConnection: NO free DataConnection");
        return null;
    }

    private boolean setupData(ApnContext apnContext, int radioTech) {
        log("setupData: apnContext=" + apnContext);
        DcAsyncChannel dcac = null;
        ApnSetting apnSetting = apnContext.getNextWaitingApn();
        if (apnSetting == null) {
            log("setupData: return for no apn found!");
            return false;
        }
        int profileId = apnSetting.profileId;
        if (profileId == 0) {
            profileId = getApnProfileID(apnContext.getApnType());
        }
        if (!(apnContext.getApnType() == "dun" && teardownForDun())) {
            dcac = checkForCompatibleConnectedApnContext(apnContext);
            if (dcac != null) {
                ApnSetting dcacApnSetting = dcac.getApnSettingSync();
                if (dcacApnSetting != null) {
                    apnSetting = dcacApnSetting;
                }
            }
        }
        if (dcac == null) {
            if (isOnlySingleDcAllowed(radioTech)) {
                if (isHigherPriorityApnContextActive(apnContext)) {
                    log("setupData: Higher priority ApnContext active.  Ignoring call");
                    return false;
                } else if (cleanUpAllConnections(true, Phone.REASON_SINGLE_PDN_ARBITRATION)) {
                    log("setupData: Some calls are disconnecting first.  Wait and retry");
                    return false;
                } else {
                    log("setupData: Single pdp. Continue setting up data call.");
                }
            }
            dcac = findFreeDataConnection();
            if (dcac == null) {
                dcac = createDataConnection();
            }
            if (dcac == null) {
                log("setupData: No free DataConnection and couldn't create one, WEIRD");
                return false;
            }
        }
        log("setupData: dcac=" + dcac + " apnSetting=" + apnSetting);
        apnContext.setDataConnectionAc(dcac);
        apnContext.setApnSetting(apnSetting);
        apnContext.setState(State.CONNECTING);
        this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
        Message msg = obtainMessage();
        msg.what = 270336;
        msg.obj = apnContext;
        dcac.bringUp(apnContext, getInitialMaxRetry(), profileId, radioTech, this.mAutoAttachOnCreation, msg);
        log("setupData: initing!");
        return true;
    }

    private void onApnChanged() {
        boolean isDisconnected;
        boolean z = true;
        State overallState = getOverallState();
        if (overallState == State.IDLE || overallState == State.FAILED) {
            isDisconnected = true;
        } else {
            isDisconnected = false;
        }
        if (this.mPhone instanceof GSMPhone) {
            ((GSMPhone) this.mPhone).updateCurrentCarrierInProvider();
        }
        log("onApnChanged: createAllApnList and cleanUpAllConnections");
        createAllApnList();
        setInitialAttachApn();
        if (isDisconnected) {
            z = false;
        }
        cleanUpConnectionsOnUpdatedApns(z);
        if (this.mPhone.getSubId() == SubscriptionManager.getDefaultDataSubId()) {
            setupDataOnConnectableApns(Phone.REASON_APN_CHANGED);
        }
    }

    private DcAsyncChannel findDataConnectionAcByCid(int cid) {
        for (DcAsyncChannel dcac : this.mDataConnectionAcHashMap.values()) {
            if (dcac.getCidSync() == cid) {
                return dcac;
            }
        }
        return null;
    }

    protected void gotoIdleAndNotifyDataConnection(String reason) {
        log("gotoIdleAndNotifyDataConnection: reason=" + reason);
        notifyDataConnection(reason);
        this.mActiveApn = null;
    }

    private boolean isHigherPriorityApnContextActive(ApnContext apnContext) {
        Iterator i$ = this.mPrioritySortedApnContexts.iterator();
        while (i$.hasNext()) {
            ApnContext otherContext = (ApnContext) i$.next();
            if (apnContext.getApnType().equalsIgnoreCase(otherContext.getApnType())) {
                return false;
            }
            if (otherContext.isEnabled() && otherContext.getState() != State.FAILED) {
                return true;
            }
        }
        return false;
    }

    private boolean isOnlySingleDcAllowed(int rilRadioTech) {
        int[] singleDcRats = this.mPhone.getContext().getResources().getIntArray(17236015);
        boolean onlySingleDcAllowed = false;
        if (Build.IS_DEBUGGABLE && SystemProperties.getBoolean("persist.telephony.test.singleDc", false)) {
            onlySingleDcAllowed = true;
        }
        if (singleDcRats != null) {
            for (int i = 0; i < singleDcRats.length && !onlySingleDcAllowed; i++) {
                if (rilRadioTech == singleDcRats[i]) {
                    onlySingleDcAllowed = true;
                }
            }
        }
        log("isOnlySingleDcAllowed(" + rilRadioTech + "): " + onlySingleDcAllowed);
        return onlySingleDcAllowed;
    }

    protected void restartRadio() {
        log("restartRadio: ************TURN OFF RADIO**************");
        cleanUpAllConnections(true, Phone.REASON_RADIO_TURNED_OFF);
        this.mPhone.getServiceStateTracker().powerOffRadioSafely(this);
        SystemProperties.set("net.ppp.reset-by-timeout", String.valueOf(Integer.parseInt(SystemProperties.get("net.ppp.reset-by-timeout", "0")) + 1));
    }

    private boolean retryAfterDisconnected(ApnContext apnContext) {
        if (Phone.REASON_RADIO_TURNED_OFF.equals(apnContext.getReason()) || (isOnlySingleDcAllowed(this.mPhone.getServiceState().getRilDataRadioTechnology()) && isHigherPriorityApnContextActive(apnContext))) {
            return false;
        }
        return true;
    }

    private void startAlarmForReconnect(int delay, ApnContext apnContext) {
        String apnType = apnContext.getApnType();
        Intent intent = new Intent("com.android.internal.telephony.data-reconnect." + apnType);
        intent.putExtra("reconnect_alarm_extra_reason", apnContext.getReason());
        intent.putExtra("reconnect_alarm_extra_type", apnType);
        intent.putExtra("subscription", SubscriptionManager.getDefaultDataSubId());
        log("startAlarmForReconnect: delay=" + delay + " action=" + intent.getAction() + " apn=" + apnContext);
        PendingIntent alarmIntent = PendingIntent.getBroadcast(this.mPhone.getContext(), 0, intent, 134217728);
        apnContext.setReconnectIntent(alarmIntent);
        this.mAlarmManager.set(2, SystemClock.elapsedRealtime() + ((long) delay), alarmIntent);
    }

    private void startAlarmForRestartTrySetup(int delay, ApnContext apnContext) {
        String apnType = apnContext.getApnType();
        Intent intent = new Intent("com.android.internal.telephony.data-restart-trysetup." + apnType);
        intent.putExtra("restart_trysetup_alarm_extra_type", apnType);
        log("startAlarmForRestartTrySetup: delay=" + delay + " action=" + intent.getAction() + " apn=" + apnContext);
        PendingIntent alarmIntent = PendingIntent.getBroadcast(this.mPhone.getContext(), 0, intent, 134217728);
        apnContext.setReconnectIntent(alarmIntent);
        this.mAlarmManager.set(2, SystemClock.elapsedRealtime() + ((long) delay), alarmIntent);
    }

    private void notifyNoData(DcFailCause lastFailCauseCode, ApnContext apnContext) {
        log("notifyNoData: type=" + apnContext.getApnType());
        if (isPermanentFail(lastFailCauseCode) && !apnContext.getApnType().equals("default")) {
            this.mPhone.notifyDataConnectionFailed(apnContext.getReason(), apnContext.getApnType());
        }
    }

    private void onRecordsLoaded() {
        log("onRecordsLoaded: createAllApnList");
        this.mAutoAttachOnCreationConfig = this.mPhone.getContext().getResources().getBoolean(17957004);
        createAllApnList();
        setInitialAttachApn();
        if (this.mPhone.mCi.getRadioState().isOn()) {
            log("onRecordsLoaded: notifying data availability");
            notifyOffApnsOfAvailability(Phone.REASON_SIM_LOADED);
        }
        setupDataOnConnectableApns(Phone.REASON_SIM_LOADED);
    }

    private void onSimNotReady() {
        log("onSimNotReady");
        cleanUpAllConnections(true, Phone.REASON_SIM_NOT_READY);
        this.mAllApnSettings = null;
        this.mAutoAttachOnCreationConfig = false;
    }

    protected void onSetDependencyMet(String apnType, boolean met) {
        if (!"hipri".equals(apnType)) {
            ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnType);
            if (apnContext == null) {
                loge("onSetDependencyMet: ApnContext not found in onSetDependencyMet(" + apnType + ", " + met + ")");
                return;
            }
            applyNewState(apnContext, apnContext.isEnabled(), met);
            if ("default".equals(apnType)) {
                apnContext = (ApnContext) this.mApnContexts.get("hipri");
                if (apnContext != null) {
                    applyNewState(apnContext, apnContext.isEnabled(), met);
                }
            }
        }
    }

    private void applyNewState(ApnContext apnContext, boolean enabled, boolean met) {
        boolean cleanup = false;
        boolean trySetup = false;
        log("applyNewState(" + apnContext.getApnType() + ", " + enabled + "(" + apnContext.isEnabled() + "), " + met + "(" + apnContext.getDependencyMet() + "))");
        if (apnContext.isReady()) {
            cleanup = true;
            if (enabled && met) {
                switch (C00571.$SwitchMap$com$android$internal$telephony$DctConstants$State[apnContext.getState().ordinal()]) {
                    case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    case CharacterSets.ISO_8859_1 /*4*/:
                    case CharacterSets.ISO_8859_3 /*6*/:
                        log("applyNewState: 'ready' so return");
                        return;
                    case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    case CharacterSets.ISO_8859_2 /*5*/:
                    case CharacterSets.ISO_8859_4 /*7*/:
                        trySetup = true;
                        apnContext.setReason(Phone.REASON_DATA_ENABLED);
                        break;
                }
            } else if (met) {
                apnContext.setReason(Phone.REASON_DATA_DISABLED);
                cleanup = apnContext.getApnType() == "dun" && teardownForDun();
            } else {
                apnContext.setReason(Phone.REASON_DATA_DEPENDENCY_UNMET);
            }
        } else if (enabled && met) {
            if (apnContext.isEnabled()) {
                apnContext.setReason(Phone.REASON_DATA_DEPENDENCY_MET);
            } else {
                apnContext.setReason(Phone.REASON_DATA_ENABLED);
            }
            if (apnContext.getState() == State.FAILED) {
                apnContext.setState(State.IDLE);
            }
            trySetup = true;
        }
        apnContext.setEnabled(enabled);
        apnContext.setDependencyMet(met);
        if (cleanup) {
            cleanUpConnection(true, apnContext);
        }
        if (trySetup) {
            trySetupData(apnContext);
        }
    }

    private DcAsyncChannel checkForCompatibleConnectedApnContext(ApnContext apnContext) {
        String apnType = apnContext.getApnType();
        ApnSetting dunSetting = null;
        if ("dun".equals(apnType)) {
            dunSetting = fetchDunApn();
        }
        log("checkForCompatibleConnectedApnContext: apnContext=" + apnContext);
        DcAsyncChannel potentialDcac = null;
        ApnContext potentialApnCtx = null;
        for (ApnContext curApnCtx : this.mApnContexts.values()) {
            DcAsyncChannel curDcac = curApnCtx.getDcAc();
            log("curDcac: " + curDcac);
            if (curDcac != null) {
                ApnSetting apnSetting = curApnCtx.getApnSetting();
                log("apnSetting: " + apnSetting);
                if (dunSetting == null) {
                    if (apnSetting != null && apnSetting.canHandleType(apnType)) {
                        switch (C00571.$SwitchMap$com$android$internal$telephony$DctConstants$State[curApnCtx.getState().ordinal()]) {
                            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                                log("checkForCompatibleConnectedApnContext: found canHandle conn=" + curDcac + " curApnCtx=" + curApnCtx);
                                return curDcac;
                            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                            case CharacterSets.ISO_8859_1 /*4*/:
                                potentialDcac = curDcac;
                                potentialApnCtx = curApnCtx;
                                break;
                            default:
                                break;
                        }
                    }
                } else if (dunSetting.equals(apnSetting)) {
                    switch (C00571.$SwitchMap$com$android$internal$telephony$DctConstants$State[curApnCtx.getState().ordinal()]) {
                        case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                            log("checkForCompatibleConnectedApnContext: found dun conn=" + curDcac + " curApnCtx=" + curApnCtx);
                            return curDcac;
                        case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                        case CharacterSets.ISO_8859_1 /*4*/:
                            potentialDcac = curDcac;
                            potentialApnCtx = curApnCtx;
                            break;
                        default:
                            break;
                    }
                } else {
                    continue;
                }
            }
        }
        if (potentialDcac != null) {
            log("checkForCompatibleConnectedApnContext: found potential conn=" + potentialDcac + " curApnCtx=" + potentialApnCtx);
            return potentialDcac;
        }
        log("checkForCompatibleConnectedApnContext: NO conn apnContext=" + apnContext);
        return null;
    }

    protected void onEnableApn(int apnId, int enabled) {
        boolean z = true;
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnIdToType(apnId));
        if (apnContext == null) {
            loge("onEnableApn(" + apnId + ", " + enabled + "): NO ApnContext");
            return;
        }
        log("onEnableApn: apnContext=" + apnContext + " call applyNewState");
        if (enabled != 1) {
            z = false;
        }
        applyNewState(apnContext, z, apnContext.getDependencyMet());
    }

    protected boolean onTrySetupData(String reason) {
        log("onTrySetupData: reason=" + reason);
        setupDataOnConnectableApns(reason);
        return true;
    }

    protected boolean onTrySetupData(ApnContext apnContext) {
        log("onTrySetupData: apnContext=" + apnContext);
        return trySetupData(apnContext);
    }

    protected void onRoamingOff() {
        log("onRoamingOff");
        if (!this.mUserDataEnabled) {
            return;
        }
        if (getDataOnRoamingEnabled()) {
            notifyDataConnection(Phone.REASON_ROAMING_OFF);
            return;
        }
        notifyOffApnsOfAvailability(Phone.REASON_ROAMING_OFF);
        setupDataOnConnectableApns(Phone.REASON_ROAMING_OFF);
    }

    protected void onRoamingOn() {
        log("onRoamingOn");
        if (!this.mUserDataEnabled) {
            return;
        }
        if (getDataOnRoamingEnabled()) {
            log("onRoamingOn: setup data on roaming");
            setupDataOnConnectableApns(Phone.REASON_ROAMING_ON);
            notifyDataConnection(Phone.REASON_ROAMING_ON);
            return;
        }
        log("onRoamingOn: Tear down data connection on roaming.");
        cleanUpAllConnections(true, Phone.REASON_ROAMING_ON);
        notifyOffApnsOfAvailability(Phone.REASON_ROAMING_ON);
    }

    protected void onRadioAvailable() {
        log("onRadioAvailable");
        if (this.mPhone.getSimulatedRadioControl() != null) {
            notifyDataConnection(null);
            log("onRadioAvailable: We're on the simulator; assuming data is connected");
        }
        IccRecords r = (IccRecords) this.mIccRecords.get();
        if (r != null && r.getRecordsLoaded()) {
            notifyOffApnsOfAvailability(null);
        }
        if (getOverallState() != State.IDLE) {
            cleanUpConnection(true, null);
        }
    }

    protected void onRadioOffOrNotAvailable() {
        this.mReregisterOnReconnectFailure = false;
        if (this.mPhone.getSimulatedRadioControl() != null) {
            log("We're on the simulator; assuming radio off is meaningless");
        } else {
            log("onRadioOffOrNotAvailable: is off and clean up all connections");
            cleanUpAllConnections(false, Phone.REASON_RADIO_TURNED_OFF);
        }
        notifyOffApnsOfAvailability(null);
    }

    protected void completeConnection(ApnContext apnContext) {
        boolean isProvApn = apnContext.isProvisioningApn();
        log("completeConnection: successful, notify the world apnContext=" + apnContext);
        if (this.mIsProvisioning && !TextUtils.isEmpty(this.mProvisioningUrl)) {
            log("completeConnection: MOBILE_PROVISIONING_ACTION url=" + this.mProvisioningUrl);
            Intent newIntent = Intent.makeMainSelectorActivity("android.intent.action.MAIN", "android.intent.category.APP_BROWSER");
            newIntent.setData(Uri.parse(this.mProvisioningUrl));
            newIntent.setFlags(272629760);
            try {
                this.mPhone.getContext().startActivity(newIntent);
            } catch (ActivityNotFoundException e) {
                loge("completeConnection: startActivityAsUser failed" + e);
            }
        }
        this.mIsProvisioning = false;
        this.mProvisioningUrl = null;
        if (this.mProvisioningSpinner != null) {
            sendMessage(obtainMessage(270378, this.mProvisioningSpinner));
        }
        this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
        startNetStatPoll();
        startDataStallAlarm(false);
    }

    protected void onDataSetupComplete(AsyncResult ar) {
        ApnSetting apn;
        DcFailCause cause = DcFailCause.UNKNOWN;
        boolean handleError = false;
        if (ar.userObj instanceof ApnContext) {
            ApnContext apnContext = ar.userObj;
            if (ar.exception == null) {
                DcAsyncChannel dcac = apnContext.getDcAc();
                if (dcac == null) {
                    log("onDataSetupComplete: no connection to DC, handle as error");
                    cause = DcFailCause.CONNECTION_TO_DATACONNECTIONAC_BROKEN;
                    handleError = true;
                } else {
                    apn = apnContext.getApnSetting();
                    log("onDataSetupComplete: success apn=" + (apn == null ? "unknown" : apn.apn));
                    if (!(apn == null || apn.proxy == null)) {
                        if (apn.proxy.length() != 0) {
                            try {
                                String port = apn.port;
                                if (TextUtils.isEmpty(port)) {
                                    port = "8080";
                                }
                                dcac.setLinkPropertiesHttpProxySync(new ProxyInfo(apn.proxy, Integer.parseInt(port), null));
                            } catch (NumberFormatException e) {
                                loge("onDataSetupComplete: NumberFormatException making ProxyProperties (" + apn.port + "): " + e);
                            }
                        }
                    }
                    if (TextUtils.equals(apnContext.getApnType(), "default")) {
                        SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "true");
                        if (this.mCanSetPreferApn && this.mPreferredApn == null) {
                            log("onDataSetupComplete: PREFERED APN is null");
                            this.mPreferredApn = apn;
                            if (this.mPreferredApn != null) {
                                setPreferredApn(this.mPreferredApn.id);
                            }
                        }
                    } else {
                        SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "false");
                    }
                    apnContext.setState(State.CONNECTED);
                    boolean isProvApn = apnContext.isProvisioningApn();
                    ConnectivityManager cm = ConnectivityManager.from(this.mPhone.getContext());
                    if (this.mProvisionBroadcastReceiver != null) {
                        this.mPhone.getContext().unregisterReceiver(this.mProvisionBroadcastReceiver);
                        this.mProvisionBroadcastReceiver = null;
                    }
                    if (!isProvApn || this.mIsProvisioning) {
                        cm.setProvisioningNotificationVisible(false, 0, this.mProvisionActionName);
                        completeConnection(apnContext);
                    } else {
                        log("onDataSetupComplete: successful, BUT send connected to prov apn as mIsProvisioning:" + this.mIsProvisioning + " == false" + " && (isProvisioningApn:" + isProvApn + " == true");
                        this.mProvisionBroadcastReceiver = new ProvisionNotificationBroadcastReceiver(cm.getMobileProvisioningUrl(), TelephonyManager.getDefault().getNetworkOperatorName());
                        this.mPhone.getContext().registerReceiver(this.mProvisionBroadcastReceiver, new IntentFilter(this.mProvisionActionName));
                        cm.setProvisioningNotificationVisible(true, 0, this.mProvisionActionName);
                        setRadio(false);
                        Intent intent = new Intent("android.intent.action.DATA_CONNECTION_CONNECTED_TO_PROVISIONING_APN");
                        intent.putExtra(Carriers.APN, apnContext.getApnSetting().apn);
                        intent.putExtra("apnType", apnContext.getApnType());
                        String apnType = apnContext.getApnType();
                        LinkProperties linkProperties = getLinkProperties(apnType);
                        if (linkProperties != null) {
                            intent.putExtra("linkProperties", linkProperties);
                            String iface = linkProperties.getInterfaceName();
                            if (iface != null) {
                                intent.putExtra("iface", iface);
                            }
                        }
                        NetworkCapabilities networkCapabilities = getNetworkCapabilities(apnType);
                        if (networkCapabilities != null) {
                            intent.putExtra("networkCapabilities", networkCapabilities);
                        }
                        this.mPhone.getContext().sendBroadcastAsUser(intent, UserHandle.ALL);
                    }
                    log("onDataSetupComplete: SETUP complete type=" + apnContext.getApnType() + ", reason:" + apnContext.getReason());
                }
            } else {
                cause = (DcFailCause) ar.result;
                apn = apnContext.getApnSetting();
                String str = "onDataSetupComplete: error apn=%s cause=%s";
                Object[] objArr = new Object[2];
                objArr[0] = apn == null ? "unknown" : apn.apn;
                objArr[1] = cause;
                log(String.format(str, objArr));
                if (cause.isEventLoggable()) {
                    int cid = getCellLocationId();
                    EventLog.writeEvent(EventLogTags.PDP_SETUP_FAIL, new Object[]{Integer.valueOf(cause.ordinal()), Integer.valueOf(cid), Integer.valueOf(TelephonyManager.getDefault().getNetworkType())});
                }
                apn = apnContext.getApnSetting();
                this.mPhone.notifyPreciseDataConnectionFailed(apnContext.getReason(), apnContext.getApnType(), apn != null ? apn.apn : "unknown", cause.toString());
                if (isPermanentFail(cause)) {
                    apnContext.decWaitingApnsPermFailCount();
                }
                apnContext.removeWaitingApn(apnContext.getApnSetting());
                if (apnContext.getWaitingApns() == null) {
                    log(String.format("onDataSetupComplete: WaitingApns.size = null WaitingApnsPermFailureCountDown=%d", new Object[]{Integer.valueOf(apnContext.getWaitingApnsPermFailCount())}));
                } else {
                    log(String.format("onDataSetupComplete: WaitingApns.size=%d WaitingApnsPermFailureCountDown=%d", new Object[]{Integer.valueOf(apnContext.getWaitingApns().size()), Integer.valueOf(apnContext.getWaitingApnsPermFailCount())}));
                }
                handleError = true;
            }
            if (handleError) {
                onDataSetupCompleteError(ar);
            }
            if (!this.mInternalDataEnabled) {
                cleanUpAllConnections(null);
                return;
            }
            return;
        }
        throw new RuntimeException("onDataSetupComplete: No apnContext");
    }

    private int getApnDelay() {
        if (this.mFailFast) {
            return SystemProperties.getInt("persist.radio.apn_ff_delay", 3000);
        }
        return SystemProperties.getInt("persist.radio.apn_delay", 20000);
    }

    protected void onDataSetupCompleteError(AsyncResult ar) {
        String reason = "";
        if (ar.userObj instanceof ApnContext) {
            ApnContext apnContext = ar.userObj;
            if (apnContext.getWaitingApns() == null || apnContext.getWaitingApns().isEmpty()) {
                apnContext.setState(State.FAILED);
                this.mPhone.notifyDataConnection(Phone.REASON_APN_FAILED, apnContext.getApnType());
                apnContext.setDataConnectionAc(null);
                if (apnContext.getWaitingApnsPermFailCount() == 0) {
                    log("onDataSetupCompleteError: All APN's had permanent failures, stop retrying");
                    return;
                }
                int delay = getApnDelay();
                log("onDataSetupCompleteError: Not all APN's had permanent failures delay=" + delay);
                startAlarmForRestartTrySetup(delay, apnContext);
                return;
            }
            log("onDataSetupCompleteError: Try next APN");
            apnContext.setState(State.SCANNING);
            startAlarmForReconnect(getApnDelay(), apnContext);
            return;
        }
        throw new RuntimeException("onDataSetupCompleteError: No apnContext");
    }

    protected void onDisconnectDone(int connId, AsyncResult ar) {
        if (ar.userObj instanceof ApnContext) {
            ApnContext apnContext = ar.userObj;
            log("onDisconnectDone: EVENT_DISCONNECT_DONE apnContext=" + apnContext);
            apnContext.setState(State.IDLE);
            this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
            if (isDisconnected() && this.mPhone.getServiceStateTracker().processPendingRadioPowerOffAfterDataOff()) {
                log("onDisconnectDone: radio will be turned off, no retries");
                apnContext.setApnSetting(null);
                apnContext.setDataConnectionAc(null);
                if (this.mDisconnectPendingCount > 0) {
                    this.mDisconnectPendingCount--;
                }
                if (this.mDisconnectPendingCount == 0) {
                    notifyDataDisconnectComplete();
                    notifyAllDataDisconnected();
                    return;
                }
                return;
            }
            if (this.mAttached.get() && apnContext.isReady() && retryAfterDisconnected(apnContext)) {
                SystemProperties.set(PUPPET_MASTER_RADIO_STRESS_TEST, "false");
                log("onDisconnectDone: attached, ready and retry after disconnect");
                startAlarmForReconnect(getApnDelay(), apnContext);
            } else {
                boolean restartRadioAfterProvisioning = this.mPhone.getContext().getResources().getBoolean(17956982);
                if (apnContext.isProvisioningApn() && restartRadioAfterProvisioning) {
                    log("onDisconnectDone: restartRadio after provisioning");
                    restartRadio();
                }
                apnContext.setApnSetting(null);
                apnContext.setDataConnectionAc(null);
                if (isOnlySingleDcAllowed(this.mPhone.getServiceState().getRilDataRadioTechnology())) {
                    log("onDisconnectDone: isOnlySigneDcAllowed true so setup single apn");
                    setupDataOnConnectableApns(Phone.REASON_SINGLE_PDN_ARBITRATION);
                } else {
                    log("onDisconnectDone: not retrying");
                }
            }
            if (this.mDisconnectPendingCount > 0) {
                this.mDisconnectPendingCount--;
            }
            if (this.mDisconnectPendingCount == 0) {
                apnContext.setConcurrentVoiceAndDataAllowed(this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed());
                notifyDataDisconnectComplete();
                notifyAllDataDisconnected();
                return;
            }
            return;
        }
        loge("onDisconnectDone: Invalid ar in onDisconnectDone, ignore");
    }

    protected void onDisconnectDcRetrying(int connId, AsyncResult ar) {
        if (ar.userObj instanceof ApnContext) {
            ApnContext apnContext = ar.userObj;
            apnContext.setState(State.RETRYING);
            log("onDisconnectDcRetrying: apnContext=" + apnContext);
            this.mPhone.notifyDataConnection(apnContext.getReason(), apnContext.getApnType());
            return;
        }
        loge("onDisconnectDcRetrying: Invalid ar in onDisconnectDone, ignore");
    }

    protected void onVoiceCallStarted() {
        log("onVoiceCallStarted");
        this.mInVoiceCall = true;
        if (isConnected() && !this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed()) {
            log("onVoiceCallStarted stop polling");
            stopNetStatPoll();
            stopDataStallAlarm();
            notifyDataConnection(Phone.REASON_VOICE_CALL_STARTED);
        }
    }

    protected void onVoiceCallEnded() {
        log("onVoiceCallEnded");
        this.mInVoiceCall = false;
        if (isConnected()) {
            if (this.mPhone.getServiceStateTracker().isConcurrentVoiceAndDataAllowed()) {
                resetPollStats();
            } else {
                startNetStatPoll();
                startDataStallAlarm(false);
                notifyDataConnection(Phone.REASON_VOICE_CALL_ENDED);
            }
        }
        setupDataOnConnectableApns(Phone.REASON_VOICE_CALL_ENDED);
    }

    protected void onCleanUpConnection(boolean tearDown, int apnId, String reason) {
        log("onCleanUpConnection");
        ApnContext apnContext = (ApnContext) this.mApnContexts.get(apnIdToType(apnId));
        if (apnContext != null) {
            apnContext.setReason(reason);
            cleanUpConnection(tearDown, apnContext);
        }
    }

    protected boolean isConnected() {
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (apnContext.getState() == State.CONNECTED) {
                return true;
            }
        }
        return false;
    }

    public boolean isDisconnected() {
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (!apnContext.isDisconnected()) {
                return false;
            }
        }
        return true;
    }

    protected void notifyDataConnection(String reason) {
        log("notifyDataConnection: reason=" + reason);
        for (ApnContext apnContext : this.mApnContexts.values()) {
            if (this.mAttached.get() && apnContext.isReady()) {
                log("notifyDataConnection: type:" + apnContext.getApnType());
                this.mPhone.notifyDataConnection(reason != null ? reason : apnContext.getReason(), apnContext.getApnType());
            }
        }
        notifyOffApnsOfAvailability(reason);
    }

    private void createAllApnList() {
        this.mAllApnSettings = new ArrayList();
        IccRecords r = (IccRecords) this.mIccRecords.get();
        String operator = r != null ? r.getOperatorNumeric() : "";
        if (operator != null) {
            String selection = "numeric = '" + operator + "'";
            log("createAllApnList: selection=" + selection);
            Cursor cursor = this.mPhone.getContext().getContentResolver().query(Carriers.CONTENT_URI, null, selection, null, null);
            if (cursor != null) {
                if (cursor.getCount() > 0) {
                    this.mAllApnSettings = createApnList(cursor);
                }
                cursor.close();
            }
        }
        addEmergencyApnSetting();
        dedupeApnSettings();
        if (this.mAllApnSettings.isEmpty()) {
            log("createAllApnList: No APN found for carrier: " + operator);
            this.mPreferredApn = null;
        } else {
            this.mPreferredApn = getPreferredApn();
            if (!(this.mPreferredApn == null || this.mPreferredApn.numeric.equals(operator))) {
                this.mPreferredApn = null;
                setPreferredApn(-1);
            }
            log("createAllApnList: mPreferredApn=" + this.mPreferredApn);
        }
        log("createAllApnList: X mAllApnSettings=" + this.mAllApnSettings);
        setDataProfilesAsNeeded();
    }

    private void dedupeApnSettings() {
        ArrayList<ApnSetting> resultApns = new ArrayList();
        for (int i = 0; i < this.mAllApnSettings.size() - 1; i++) {
            ApnSetting first = (ApnSetting) this.mAllApnSettings.get(i);
            int j = i + 1;
            while (j < this.mAllApnSettings.size()) {
                ApnSetting second = (ApnSetting) this.mAllApnSettings.get(j);
                if (apnsSimilar(first, second)) {
                    ApnSetting newApn = mergeApns(first, second);
                    this.mAllApnSettings.set(i, newApn);
                    first = newApn;
                    this.mAllApnSettings.remove(j);
                } else {
                    j++;
                }
            }
        }
    }

    private boolean apnTypeSameAny(ApnSetting first, ApnSetting second) {
        int index1 = 0;
        while (index1 < first.types.length) {
            int index2 = 0;
            while (index2 < second.types.length) {
                if (first.types[index1].equals(CharacterSets.MIMENAME_ANY_CHARSET) || second.types[index2].equals(CharacterSets.MIMENAME_ANY_CHARSET) || first.types[index1].equals(second.types[index2])) {
                    return true;
                }
                index2++;
            }
            index1++;
        }
        return false;
    }

    private boolean apnsSimilar(ApnSetting first, ApnSetting second) {
        return !first.canHandleType("dun") && !second.canHandleType("dun") && Objects.equals(first.apn, second.apn) && !apnTypeSameAny(first, second) && xorEquals(first.proxy, second.proxy) && xorEquals(first.port, second.port) && first.carrierEnabled == second.carrierEnabled && first.bearer == second.bearer && first.profileId == second.profileId && Objects.equals(first.mvnoType, second.mvnoType) && Objects.equals(first.mvnoMatchData, second.mvnoMatchData) && xorEquals(first.mmsc, second.mmsc) && xorEquals(first.mmsProxy, second.mmsProxy) && xorEquals(first.mmsPort, second.mmsPort);
    }

    private boolean xorEquals(String first, String second) {
        return Objects.equals(first, second) || TextUtils.isEmpty(first) || TextUtils.isEmpty(second);
    }

    private ApnSetting mergeApns(ApnSetting dest, ApnSetting src) {
        boolean z;
        ArrayList<String> resultTypes = new ArrayList();
        resultTypes.addAll(Arrays.asList(dest.types));
        for (String srcType : src.types) {
            if (!resultTypes.contains(srcType)) {
                resultTypes.add(srcType);
            }
        }
        String mmsc = TextUtils.isEmpty(dest.mmsc) ? src.mmsc : dest.mmsc;
        String mmsProxy = TextUtils.isEmpty(dest.mmsProxy) ? src.mmsProxy : dest.mmsProxy;
        String mmsPort = TextUtils.isEmpty(dest.mmsPort) ? src.mmsPort : dest.mmsPort;
        String proxy = TextUtils.isEmpty(dest.proxy) ? src.proxy : dest.proxy;
        String port = TextUtils.isEmpty(dest.port) ? src.port : dest.port;
        String protocol = src.protocol.equals("IPV4V6") ? src.protocol : dest.protocol;
        String roamingProtocol = src.roamingProtocol.equals("IPV4V6") ? src.roamingProtocol : dest.roamingProtocol;
        int i = dest.id;
        String str = dest.numeric;
        String str2 = dest.carrier;
        String str3 = dest.apn;
        String str4 = dest.user;
        String str5 = dest.password;
        int i2 = dest.authType;
        String[] strArr = (String[]) resultTypes.toArray(new String[0]);
        boolean z2 = dest.carrierEnabled;
        int i3 = dest.bearer;
        int i4 = dest.profileId;
        if (dest.modemCognitive || src.modemCognitive) {
            z = true;
        } else {
            z = false;
        }
        return new ApnSetting(i, str, str2, str3, proxy, port, mmsc, mmsProxy, mmsPort, str4, str5, i2, strArr, protocol, roamingProtocol, z2, i3, i4, z, dest.maxConns, dest.waitTime, dest.maxConnsTime, dest.mtu, dest.mvnoType, dest.mvnoMatchData);
    }

    private DcAsyncChannel createDataConnection() {
        log("createDataConnection E");
        int id = this.mUniqueIdGenerator.getAndIncrement();
        DataConnection conn = DataConnection.makeDataConnection(this.mPhone, id, this, this.mDcTesterFailBringUpAll, this.mDcc);
        this.mDataConnections.put(Integer.valueOf(id), conn);
        DcAsyncChannel dcac = new DcAsyncChannel(conn, "DCT");
        int status = dcac.fullyConnectSync(this.mPhone.getContext(), this, conn.getHandler());
        if (status == 0) {
            this.mDataConnectionAcHashMap.put(Integer.valueOf(dcac.getDataConnectionIdSync()), dcac);
        } else {
            loge("createDataConnection: Could not connect to dcac=" + dcac + " status=" + status);
        }
        log("createDataConnection() X id=" + id + " dc=" + conn);
        return dcac;
    }

    private void destroyDataConnections() {
        if (this.mDataConnections != null) {
            log("destroyDataConnections: clear mDataConnectionList");
            this.mDataConnections.clear();
            return;
        }
        log("destroyDataConnections: mDataConnecitonList is empty, ignore");
    }

    private ArrayList<ApnSetting> buildWaitingApns(String requestedApnType, int radioTech) {
        boolean usePreferred;
        log("buildWaitingApns: E requestedApnType=" + requestedApnType);
        ArrayList<ApnSetting> apnList = new ArrayList();
        if (requestedApnType.equals("dun")) {
            ApnSetting dun = fetchDunApn();
            if (dun != null) {
                apnList.add(dun);
                log("buildWaitingApns: X added APN_TYPE_DUN apnList=" + apnList);
                return apnList;
            }
        }
        IccRecords r = (IccRecords) this.mIccRecords.get();
        String operator = r != null ? r.getOperatorNumeric() : "";
        try {
            usePreferred = !this.mPhone.getContext().getResources().getBoolean(17956981);
        } catch (NotFoundException e) {
            log("buildWaitingApns: usePreferred NotFoundException set to true");
            usePreferred = true;
        }
        log("buildWaitingApns: usePreferred=" + usePreferred + " canSetPreferApn=" + this.mCanSetPreferApn + " mPreferredApn=" + this.mPreferredApn + " operator=" + operator + " radioTech=" + radioTech + " IccRecords r=" + r);
        if (usePreferred && this.mCanSetPreferApn && this.mPreferredApn != null && this.mPreferredApn.canHandleType(requestedApnType)) {
            log("buildWaitingApns: Preferred APN:" + operator + ":" + this.mPreferredApn.numeric + ":" + this.mPreferredApn);
            if (!this.mPreferredApn.numeric.equals(operator)) {
                log("buildWaitingApns: no preferred APN");
                setPreferredApn(-1);
                this.mPreferredApn = null;
            } else if (this.mPreferredApn.bearer == 0 || this.mPreferredApn.bearer == radioTech) {
                apnList.add(this.mPreferredApn);
                log("buildWaitingApns: X added preferred apnList=" + apnList);
                return apnList;
            } else {
                log("buildWaitingApns: no preferred APN");
                setPreferredApn(-1);
                this.mPreferredApn = null;
            }
        }
        if (this.mAllApnSettings != null) {
            log("buildWaitingApns: mAllApnSettings=" + this.mAllApnSettings);
            Iterator i$ = this.mAllApnSettings.iterator();
            while (i$.hasNext()) {
                ApnSetting apn = (ApnSetting) i$.next();
                log("buildWaitingApns: apn=" + apn);
                if (!apn.canHandleType(requestedApnType)) {
                    log("buildWaitingApns: couldn't handle requesedApnType=" + requestedApnType);
                } else if (apn.bearer == 0 || apn.bearer == radioTech) {
                    log("buildWaitingApns: adding apn=" + apn.toString());
                    apnList.add(apn);
                } else {
                    log("buildWaitingApns: bearer:" + apn.bearer + " != " + "radioTech:" + radioTech);
                }
            }
        } else {
            loge("mAllApnSettings is empty!");
        }
        log("buildWaitingApns: X apnList=" + apnList);
        return apnList;
    }

    private String apnListToString(ArrayList<ApnSetting> apns) {
        if (apns == null) {
            log("apnListToString: apns = null.");
            return "";
        }
        StringBuilder result = new StringBuilder();
        int size = apns.size();
        for (int i = 0; i < size; i++) {
            result.append('[').append(((ApnSetting) apns.get(i)).toString()).append(']');
        }
        return result.toString();
    }

    private void setPreferredApn(int pos) {
        if (this.mCanSetPreferApn) {
            Uri uri = Uri.withAppendedPath(PREFERAPN_NO_UPDATE_URI_USING_SUBID, Long.toString((long) this.mPhone.getSubId()));
            log("setPreferredApn: delete");
            ContentResolver resolver = this.mPhone.getContext().getContentResolver();
            resolver.delete(uri, null, null);
            if (pos >= 0) {
                log("setPreferredApn: insert");
                ContentValues values = new ContentValues();
                values.put(APN_ID, Integer.valueOf(pos));
                resolver.insert(uri, values);
                return;
            }
            return;
        }
        log("setPreferredApn: X !canSEtPreferApn");
    }

    private ApnSetting getPreferredApn() {
        if (this.mAllApnSettings.isEmpty()) {
            log("getPreferredApn: X not found mAllApnSettings.isEmpty");
            return null;
        }
        int count;
        Uri uri = Uri.withAppendedPath(PREFERAPN_NO_UPDATE_URI_USING_SUBID, Long.toString((long) this.mPhone.getSubId()));
        Cursor cursor = this.mPhone.getContext().getContentResolver().query(uri, new String[]{HbpcdLookup.ID, Part.NAME, Carriers.APN}, null, null, Carriers.DEFAULT_SORT_ORDER);
        if (cursor != null) {
            this.mCanSetPreferApn = true;
        } else {
            this.mCanSetPreferApn = false;
        }
        StringBuilder append = new StringBuilder().append("getPreferredApn: mRequestedApnType=").append(this.mRequestedApnType).append(" cursor=").append(cursor).append(" cursor.count=");
        if (cursor != null) {
            count = cursor.getCount();
        } else {
            count = 0;
        }
        log(append.append(count).toString());
        if (this.mCanSetPreferApn && cursor.getCount() > 0) {
            cursor.moveToFirst();
            int pos = cursor.getInt(cursor.getColumnIndexOrThrow(HbpcdLookup.ID));
            Iterator i$ = this.mAllApnSettings.iterator();
            while (i$.hasNext()) {
                ApnSetting p = (ApnSetting) i$.next();
                log("getPreferredApn: apnSetting=" + p);
                if (p.id == pos && p.canHandleType(this.mRequestedApnType)) {
                    log("getPreferredApn: X found apnSetting" + p);
                    cursor.close();
                    return p;
                }
            }
        }
        if (cursor != null) {
            cursor.close();
        }
        log("getPreferredApn: X not found");
        return null;
    }

    public void handleMessage(Message msg) {
        boolean tearDown = false;
        log("handleMessage msg=" + msg);
        if (!this.mPhone.mIsTheCurrentActivePhone || this.mIsDisposed) {
            loge("handleMessage: Ignore GSM msgs since GSM phone is inactive");
            return;
        }
        switch (msg.what) {
            case 270338:
                onRecordsLoaded();
            case 270339:
                if (msg.obj instanceof ApnContext) {
                    onTrySetupData((ApnContext) msg.obj);
                } else if (msg.obj instanceof String) {
                    onTrySetupData((String) msg.obj);
                } else {
                    loge("EVENT_TRY_SETUP request w/o apnContext or String");
                }
            case 270345:
                onDataConnectionDetached();
            case 270352:
                onDataConnectionAttached();
            case 270354:
                doRecovery();
            case 270355:
                onApnChanged();
            case 270358:
                log("EVENT_PS_RESTRICT_ENABLED " + this.mIsPsRestricted);
                stopNetStatPoll();
                stopDataStallAlarm();
                this.mIsPsRestricted = true;
            case 270359:
                log("EVENT_PS_RESTRICT_DISABLED " + this.mIsPsRestricted);
                this.mIsPsRestricted = false;
                if (isConnected()) {
                    startNetStatPoll();
                    startDataStallAlarm(false);
                    return;
                }
                if (this.mState == State.FAILED) {
                    cleanUpAllConnections(false, Phone.REASON_PS_RESTRICT_ENABLED);
                    this.mReregisterOnReconnectFailure = false;
                }
                ApnContext apnContext = (ApnContext) this.mApnContexts.get("default");
                if (apnContext != null) {
                    apnContext.setReason(Phone.REASON_PS_RESTRICT_ENABLED);
                    trySetupData(apnContext);
                    return;
                }
                loge("**** Default ApnContext not found ****");
                if (Build.IS_DEBUGGABLE) {
                    throw new RuntimeException("Default ApnContext not found");
                }
            case 270360:
                if (msg.arg1 != 0) {
                    tearDown = true;
                }
                log("EVENT_CLEAN_UP_CONNECTION tearDown=" + tearDown);
                if (msg.obj instanceof ApnContext) {
                    cleanUpConnection(tearDown, (ApnContext) msg.obj);
                    return;
                }
                loge("EVENT_CLEAN_UP_CONNECTION request w/o apn context, call super");
                super.handleMessage(msg);
            case 270363:
                boolean enabled;
                if (msg.arg1 == 1) {
                    enabled = true;
                } else {
                    enabled = false;
                }
                onSetInternalDataEnabled(enabled, (Message) msg.obj);
            case 270365:
                Message mCause = obtainMessage(270365, null);
                if (msg.obj != null && (msg.obj instanceof String)) {
                    mCause.obj = msg.obj;
                }
                super.handleMessage(mCause);
            case 270377:
                setupDataOnConnectableApns(Phone.REASON_NW_TYPE_CHANGED, RetryFailures.ONLY_ON_CHANGE);
            case 270378:
                if (this.mProvisioningSpinner == msg.obj) {
                    this.mProvisioningSpinner.dismiss();
                    this.mProvisioningSpinner = null;
                }
            default:
                super.handleMessage(msg);
        }
    }

    protected int getApnProfileID(String apnType) {
        if (TextUtils.equals(apnType, "ims")) {
            return 2;
        }
        if (TextUtils.equals(apnType, "fota")) {
            return 3;
        }
        if (TextUtils.equals(apnType, "cbs")) {
            return 4;
        }
        if (TextUtils.equals(apnType, "ia") || !TextUtils.equals(apnType, "dun")) {
            return 0;
        }
        return 1;
    }

    private int getCellLocationId() {
        CellLocation loc = this.mPhone.getCellLocation();
        if (loc == null) {
            return -1;
        }
        if (loc instanceof GsmCellLocation) {
            return ((GsmCellLocation) loc).getCid();
        }
        if (loc instanceof CdmaCellLocation) {
            return ((CdmaCellLocation) loc).getBaseStationId();
        }
        return -1;
    }

    private IccRecords getUiccRecords(int appFamily) {
        return this.mUiccController.getIccRecords(this.mPhone.getPhoneId(), appFamily);
    }

    protected void onUpdateIcc() {
        if (this.mUiccController != null) {
            IccRecords newIccRecords = getUiccRecords(1);
            IccRecords r = (IccRecords) this.mIccRecords.get();
            if (r != newIccRecords) {
                if (r != null) {
                    log("Removing stale icc objects.");
                    r.unregisterForRecordsLoaded(this);
                    this.mIccRecords.set(null);
                }
                if (newIccRecords != null) {
                    log("New records found");
                    this.mIccRecords.set(newIccRecords);
                    newIccRecords.registerForRecordsLoaded(this, 270338, null);
                    return;
                }
                onSimNotReady();
            }
        }
    }

    public void update() {
        log("update sub = " + this.mPhone.getSubId());
        log("update(): Active DDS, register for all events now!");
        registerForAllEvents();
        onUpdateIcc();
        this.mUserDataEnabled = getDataEnabled();
        if (this.mPhone instanceof CDMALTEPhone) {
            ((CDMALTEPhone) this.mPhone).updateCurrentCarrierInProvider();
            supplyMessenger();
        } else if (this.mPhone instanceof GSMPhone) {
            ((GSMPhone) this.mPhone).updateCurrentCarrierInProvider();
            supplyMessenger();
        } else {
            log("Phone object is not MultiSim. This should not hit!!!!");
        }
    }

    public void cleanUpAllConnections(String cause) {
        cleanUpAllConnections(cause, null);
    }

    public void updateRecords() {
        onUpdateIcc();
    }

    public void cleanUpAllConnections(String cause, Message disconnectAllCompleteMsg) {
        log("cleanUpAllConnections");
        if (disconnectAllCompleteMsg != null) {
            this.mDisconnectAllCompleteMsgList.add(disconnectAllCompleteMsg);
        }
        Message msg = obtainMessage(270365);
        msg.obj = cause;
        sendMessage(msg);
    }

    protected void notifyDataDisconnectComplete() {
        log("notifyDataDisconnectComplete");
        Iterator i$ = this.mDisconnectAllCompleteMsgList.iterator();
        while (i$.hasNext()) {
            ((Message) i$.next()).sendToTarget();
        }
        this.mDisconnectAllCompleteMsgList.clear();
    }

    protected void notifyAllDataDisconnected() {
        sEnableFailFastRefCounter = 0;
        this.mFailFast = false;
        this.mAllDataDisconnectedRegistrants.notifyRegistrants();
    }

    public void registerForAllDataDisconnected(Handler h, int what, Object obj) {
        this.mAllDataDisconnectedRegistrants.addUnique(h, what, obj);
        if (isDisconnected()) {
            log("notify All Data Disconnected");
            notifyAllDataDisconnected();
        }
    }

    public void unregisterForAllDataDisconnected(Handler h) {
        this.mAllDataDisconnectedRegistrants.remove(h);
    }

    protected void onSetInternalDataEnabled(boolean enable) {
        log("onSetInternalDataEnabled: enabled=" + enable);
        onSetInternalDataEnabled(enable, null);
    }

    protected void onSetInternalDataEnabled(boolean enabled, Message onCompleteMsg) {
        log("onSetInternalDataEnabled: enabled=" + enabled);
        boolean sendOnComplete = true;
        synchronized (this.mDataEnabledLock) {
            this.mInternalDataEnabled = enabled;
            if (enabled) {
                log("onSetInternalDataEnabled: changed to enabled, try to setup data call");
                onTrySetupData(Phone.REASON_DATA_ENABLED);
            } else {
                sendOnComplete = false;
                log("onSetInternalDataEnabled: changed to disabled, cleanUpAllConnections");
                cleanUpAllConnections(null, onCompleteMsg);
            }
        }
        if (sendOnComplete && onCompleteMsg != null) {
            onCompleteMsg.sendToTarget();
        }
    }

    public boolean setInternalDataEnabledFlag(boolean enable) {
        log("setInternalDataEnabledFlag(" + enable + ")");
        if (this.mInternalDataEnabled != enable) {
            this.mInternalDataEnabled = enable;
        }
        return true;
    }

    public boolean setInternalDataEnabled(boolean enable) {
        return setInternalDataEnabled(enable, null);
    }

    public boolean setInternalDataEnabled(boolean enable, Message onCompleteMsg) {
        log("setInternalDataEnabled(" + enable + ")");
        Message msg = obtainMessage(270363, onCompleteMsg);
        msg.arg1 = enable ? 1 : 0;
        sendMessage(msg);
        return true;
    }

    public void setDataAllowed(boolean enable, Message response) {
        log("setDataAllowed: enable=" + enable);
        mIsCleanupRequired = !enable;
        this.mPhone.mCi.setDataAllowed(enable, response);
        this.mInternalDataEnabled = enable;
    }

    protected void log(String s) {
        Rlog.d("DCT", "[" + this.mPhone.getPhoneId() + "]" + s);
    }

    protected void loge(String s) {
        Rlog.e("DCT", "[" + this.mPhone.getPhoneId() + "]" + s);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("DcTracker extends:");
        super.dump(fd, pw, args);
        pw.println(" mReregisterOnReconnectFailure=" + this.mReregisterOnReconnectFailure);
        pw.println(" canSetPreferApn=" + this.mCanSetPreferApn);
        pw.println(" mApnObserver=" + this.mApnObserver);
        pw.println(" getOverallState=" + getOverallState());
        pw.println(" mDataConnectionAsyncChannels=%s\n" + this.mDataConnectionAcHashMap);
        pw.println(" mAttached=" + this.mAttached.get());
    }

    public String[] getPcscfAddress(String apnType) {
        log("getPcscfAddress()");
        if (apnType == null) {
            log("apnType is null, return null");
            return null;
        }
        ApnContext apnContext;
        if (TextUtils.equals(apnType, "emergency")) {
            apnContext = (ApnContext) this.mApnContexts.get("emergency");
        } else if (TextUtils.equals(apnType, "ims")) {
            apnContext = (ApnContext) this.mApnContexts.get("ims");
        } else {
            log("apnType is invalid, return null");
            return null;
        }
        if (apnContext == null) {
            log("apnContext is null, return null");
            return null;
        }
        DcAsyncChannel dcac = apnContext.getDcAc();
        if (dcac == null) {
            return null;
        }
        String[] result = dcac.getPcscfAddr();
        for (int i = 0; i < result.length; i++) {
            log("Pcscf[" + i + "]: " + result[i]);
        }
        return result;
    }

    public void setImsRegistrationState(boolean registered) {
        log("setImsRegistrationState - mImsRegistrationState(before): " + this.mImsRegistrationState + ", registered(current) : " + registered);
        if (this.mPhone != null) {
            ServiceStateTracker sst = this.mPhone.getServiceStateTracker();
            if (sst != null) {
                sst.setImsRegistrationState(registered);
            }
        }
    }

    private void initEmergencyApnSetting() {
        Cursor cursor = this.mPhone.getContext().getContentResolver().query(Carriers.CONTENT_URI, null, "type=\"emergency\"", null, null);
        if (cursor != null) {
            if (cursor.getCount() > 0 && cursor.moveToFirst()) {
                this.mEmergencyApn = makeApnSetting(cursor);
            }
            cursor.close();
        }
    }

    private void addEmergencyApnSetting() {
        if (this.mEmergencyApn == null) {
            return;
        }
        if (this.mAllApnSettings == null) {
            this.mAllApnSettings = new ArrayList();
            return;
        }
        boolean hasEmergencyApn = false;
        Iterator i$ = this.mAllApnSettings.iterator();
        while (i$.hasNext()) {
            if (ArrayUtils.contains(((ApnSetting) i$.next()).types, "emergency")) {
                hasEmergencyApn = true;
                break;
            }
        }
        if (hasEmergencyApn) {
            log("addEmergencyApnSetting - E-APN setting is already present");
        } else {
            this.mAllApnSettings.add(this.mEmergencyApn);
        }
    }

    private void cleanUpConnectionsOnUpdatedApns(boolean tearDown) {
        log("cleanUpConnectionsOnUpdatedApns: tearDown=" + tearDown);
        if (this.mAllApnSettings.isEmpty()) {
            cleanUpAllConnections(tearDown, Phone.REASON_APN_CHANGED);
        } else {
            for (ApnContext apnContext : this.mApnContexts.values()) {
                boolean cleanUpApn = true;
                ArrayList<ApnSetting> currentWaitingApns = apnContext.getWaitingApns();
                if (!(currentWaitingApns == null || apnContext.isDisconnected())) {
                    ArrayList<ApnSetting> waitingApns = buildWaitingApns(apnContext.getApnType(), this.mPhone.getServiceState().getRilDataRadioTechnology());
                    if (waitingApns.size() == currentWaitingApns.size()) {
                        cleanUpApn = false;
                        for (int i = 0; i < waitingApns.size(); i++) {
                            if (!((ApnSetting) currentWaitingApns.get(i)).equals(waitingApns.get(i))) {
                                cleanUpApn = true;
                                apnContext.setWaitingApns(waitingApns);
                                break;
                            }
                        }
                    }
                }
                if (cleanUpApn) {
                    apnContext.setReason(Phone.REASON_APN_CHANGED);
                    cleanUpConnection(true, apnContext);
                }
            }
        }
        if (!isConnected()) {
            stopNetStatPoll();
            stopDataStallAlarm();
        }
        this.mRequestedApnType = "default";
        log("mDisconnectPendingCount = " + this.mDisconnectPendingCount);
        if (tearDown && this.mDisconnectPendingCount == 0) {
            notifyDataDisconnectComplete();
            notifyAllDataDisconnected();
        }
    }
}
