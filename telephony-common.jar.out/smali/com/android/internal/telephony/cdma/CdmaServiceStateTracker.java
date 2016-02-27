package com.android.internal.telephony.cdma;

import android.app.AlarmManager;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.ContentObserver;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Registrant;
import android.os.RegistrantList;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.provider.Settings.SettingNotFoundException;
import android.provider.Telephony.CellBroadcasts;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.telephony.cdma.CdmaCellLocation;
import android.text.TextUtils;
import android.util.TimeUtils;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.CommandsInterface.RadioState;
import com.android.internal.telephony.HbpcdUtils;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.RadioNVItems;
import com.android.internal.telephony.ServiceStateTracker;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cdma.sms.CdmaSmsAddress;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.TimeZone;

public class CdmaServiceStateTracker extends ServiceStateTracker {
    protected static final String DEFAULT_MNC = "00";
    protected static final String INVALID_MCC = "000";
    static final String LOG_TAG = "CdmaSST";
    private static final int MS_PER_HOUR = 3600000;
    private static final int NITZ_UPDATE_DIFF_DEFAULT = 2000;
    private static final int NITZ_UPDATE_SPACING_DEFAULT = 600000;
    private static final String UNACTIVATED_MIN2_VALUE = "000000";
    private static final String UNACTIVATED_MIN_VALUE = "1111110111";
    private static final String WAKELOCK_TAG = "ServiceStateTracker";
    private ContentObserver mAutoTimeObserver;
    private ContentObserver mAutoTimeZoneObserver;
    protected RegistrantList mCdmaForSubscriptionInfoReadyRegistrants;
    private CdmaSubscriptionSourceManager mCdmaSSM;
    CdmaCellLocation mCellLoc;
    private ContentResolver mCr;
    private String mCurrentCarrier;
    int mCurrentOtaspMode;
    private int mDefaultRoamingIndicator;
    protected boolean mGotCountryCode;
    protected HbpcdUtils mHbpcdUtils;
    protected int[] mHomeNetworkId;
    protected int[] mHomeSystemId;
    private boolean mIsEriTextLoaded;
    private boolean mIsInPrl;
    protected boolean mIsMinInfoReady;
    protected boolean mIsSubscriptionFromRuim;
    protected String mMdn;
    protected String mMin;
    protected boolean mNeedFixZone;
    CdmaCellLocation mNewCellLoc;
    private int mNitzUpdateDiff;
    private int mNitzUpdateSpacing;
    CDMAPhone mPhone;
    protected String mPrlVersion;
    private String mRegistrationDeniedReason;
    protected int mRegistrationState;
    private int mRoamingIndicator;
    long mSavedAtTime;
    long mSavedTime;
    String mSavedTimeZone;
    private WakeLock mWakeLock;
    private boolean mZoneDst;
    private int mZoneOffset;
    private long mZoneTime;

    /* renamed from: com.android.internal.telephony.cdma.CdmaServiceStateTracker.1 */
    class C00461 extends ContentObserver {
        C00461(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            CdmaServiceStateTracker.this.log("Auto time state changed");
            CdmaServiceStateTracker.this.revertToNitzTime();
        }
    }

    /* renamed from: com.android.internal.telephony.cdma.CdmaServiceStateTracker.2 */
    class C00472 extends ContentObserver {
        C00472(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            CdmaServiceStateTracker.this.log("Auto time zone state changed");
            CdmaServiceStateTracker.this.revertToNitzTimeZone();
        }
    }

    /* renamed from: com.android.internal.telephony.cdma.CdmaServiceStateTracker.3 */
    static /* synthetic */ class C00483 {
        static final /* synthetic */ int[] f7x46dd5024;

        static {
            f7x46dd5024 = new int[RadioState.values().length];
            try {
                f7x46dd5024[RadioState.RADIO_UNAVAILABLE.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f7x46dd5024[RadioState.RADIO_OFF.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
        }
    }

    public CdmaServiceStateTracker(CDMAPhone phone) {
        this(phone, new CellInfoCdma());
    }

    protected CdmaServiceStateTracker(CDMAPhone phone, CellInfo cellInfo) {
        boolean z;
        super(phone, phone.mCi, cellInfo);
        this.mCurrentOtaspMode = 0;
        this.mNitzUpdateSpacing = SystemProperties.getInt("ro.nitz_update_spacing", NITZ_UPDATE_SPACING_DEFAULT);
        this.mNitzUpdateDiff = SystemProperties.getInt("ro.nitz_update_diff", NITZ_UPDATE_DIFF_DEFAULT);
        this.mRegistrationState = -1;
        this.mCdmaForSubscriptionInfoReadyRegistrants = new RegistrantList();
        this.mNeedFixZone = false;
        this.mGotCountryCode = false;
        this.mHomeSystemId = null;
        this.mHomeNetworkId = null;
        this.mIsMinInfoReady = false;
        this.mIsEriTextLoaded = false;
        this.mIsSubscriptionFromRuim = false;
        this.mHbpcdUtils = null;
        this.mCurrentCarrier = null;
        this.mAutoTimeObserver = new C00461(new Handler());
        this.mAutoTimeZoneObserver = new C00472(new Handler());
        this.mPhone = phone;
        this.mCr = phone.getContext().getContentResolver();
        this.mCellLoc = new CdmaCellLocation();
        this.mNewCellLoc = new CdmaCellLocation();
        this.mCdmaSSM = CdmaSubscriptionSourceManager.getInstance(phone.getContext(), this.mCi, this, 39, null);
        if (this.mCdmaSSM.getCdmaSubscriptionSource() == 0) {
            z = true;
        } else {
            z = false;
        }
        this.mIsSubscriptionFromRuim = z;
        this.mWakeLock = ((PowerManager) phone.getContext().getSystemService("power")).newWakeLock(1, WAKELOCK_TAG);
        this.mCi.registerForRadioStateChanged(this, 1, null);
        this.mCi.registerForVoiceNetworkStateChanged(this, 30, null);
        this.mCi.setOnNITZTime(this, 11, null);
        this.mCi.registerForCdmaPrlChanged(this, 40, null);
        phone.registerForEriFileLoaded(this, 36, null);
        this.mCi.registerForCdmaOtaProvision(this, 37, null);
        if (Global.getInt(this.mCr, "airplane_mode_on", 0) <= 0) {
            z = true;
        } else {
            z = false;
        }
        this.mDesiredPowerState = z;
        this.mCr.registerContentObserver(Global.getUriFor("auto_time"), true, this.mAutoTimeObserver);
        this.mCr.registerContentObserver(Global.getUriFor("auto_time_zone"), true, this.mAutoTimeZoneObserver);
        setSignalStrengthDefaultValues();
        this.mHbpcdUtils = new HbpcdUtils(phone.getContext());
        phone.notifyOtaspChanged(0);
    }

    public void dispose() {
        checkCorrectThread();
        log("ServiceStateTracker dispose");
        this.mCi.unregisterForRadioStateChanged(this);
        this.mCi.unregisterForVoiceNetworkStateChanged(this);
        this.mCi.unregisterForCdmaOtaProvision(this);
        this.mPhone.unregisterForEriFileLoaded(this);
        if (this.mUiccApplcation != null) {
            this.mUiccApplcation.unregisterForReady(this);
        }
        if (this.mIccRecords != null) {
            this.mIccRecords.unregisterForRecordsLoaded(this);
        }
        this.mCi.unSetOnNITZTime(this);
        this.mCr.unregisterContentObserver(this.mAutoTimeObserver);
        this.mCr.unregisterContentObserver(this.mAutoTimeZoneObserver);
        this.mCdmaSSM.dispose(this);
        this.mCi.unregisterForCdmaPrlChanged(this);
        super.dispose();
    }

    protected void finalize() {
        log("CdmaServiceStateTracker finalized");
    }

    public void registerForSubscriptionInfoReady(Handler h, int what, Object obj) {
        Registrant r = new Registrant(h, what, obj);
        this.mCdmaForSubscriptionInfoReadyRegistrants.add(r);
        if (isMinInfoReady()) {
            r.notifyRegistrant();
        }
    }

    public void unregisterForSubscriptionInfoReady(Handler h) {
        this.mCdmaForSubscriptionInfoReadyRegistrants.remove(h);
    }

    private void saveCdmaSubscriptionSource(int source) {
        log("Storing cdma subscription source: " + source);
        Global.putInt(this.mPhone.getContext().getContentResolver(), "subscription_mode", source);
        log("Read from settings: " + Global.getInt(this.mPhone.getContext().getContentResolver(), "subscription_mode", -1));
    }

    private void getSubscriptionInfoAndStartPollingThreads() {
        this.mCi.getCDMASubscription(obtainMessage(34));
        pollState();
    }

    public void handleMessage(Message msg) {
        int i;
        if (this.mPhone.mIsTheCurrentActivePhone) {
            AsyncResult ar;
            switch (msg.what) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    if (this.mCi.getRadioState() == RadioState.RADIO_ON) {
                        handleCdmaSubscriptionSource(this.mCdmaSSM.getCdmaSubscriptionSource());
                        queueNextSignalStrengthPoll();
                    }
                    setPowerStateToDesired();
                    pollState();
                    return;
                case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    if (this.mCi.getRadioState().isOn()) {
                        onSignalStrengthResult(msg.obj, false);
                        queueNextSignalStrengthPoll();
                        return;
                    }
                    return;
                case CharacterSets.ISO_8859_2 /*5*/:
                case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                case SmsHeader.ELT_ID_CHARACTER_SIZE_WVG_OBJECT /*25*/:
                    ar = (AsyncResult) msg.obj;
                    handlePollStateResult(msg.what, ar);
                    return;
                case CharacterSets.ISO_8859_7 /*10*/:
                    this.mCi.getSignalStrength(obtainMessage(3));
                    return;
                case CharacterSets.ISO_8859_8 /*11*/:
                    ar = (AsyncResult) msg.obj;
                    String str = ((Object[]) ar.result)[0];
                    setTimeFromNITZString(nitzString, ((Long) ((Object[]) ar.result)[1]).longValue());
                    return;
                case CharacterSets.ISO_8859_9 /*12*/:
                    ar = (AsyncResult) msg.obj;
                    this.mDontPollSignalStrength = true;
                    onSignalStrengthResult(ar, false);
                    return;
                case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                    log("EVENT_POLL_STATE_NETWORK_SELECTION_MODE");
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception != null || ar.result == null) {
                        log("Unable to getNetworkSelectionMode");
                        return;
                    }
                    if (((int[]) ar.result)[0] == 1) {
                        this.mPhone.setNetworkSelectionModeAutomatic(null);
                        return;
                    }
                    return;
                case PduHeaders.MMS_VERSION_1_2 /*18*/:
                    if (((AsyncResult) msg.obj).exception == null) {
                        this.mCi.getVoiceRegistrationState(obtainMessage(31, null));
                        return;
                    }
                    return;
                case SmsHeader.ELT_ID_EXTENDED_OBJECT_DATA_REQUEST_CMD /*26*/:
                    if (this.mPhone.getLteOnCdmaMode() == 1) {
                        log("Receive EVENT_RUIM_READY");
                        pollState();
                    } else {
                        log("Receive EVENT_RUIM_READY and Send Request getCDMASubscription.");
                        getSubscriptionInfoAndStartPollingThreads();
                    }
                    this.mCi.getNetworkSelectionMode(obtainMessage(14));
                    this.mPhone.prepareEri();
                    return;
                case 27:
                    i = msg.what;
                    log("EVENT_RUIM_RECORDS_LOADED: what=" + i);
                    updatePhoneObject();
                    updateSpnDisplay();
                    return;
                case CallFailCause.STATUS_ENQUIRY /*30*/:
                    pollState();
                    return;
                case CallFailCause.NORMAL_UNSPECIFIED /*31*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        String[] states = (String[]) ar.result;
                        int baseStationId = -1;
                        int baseStationLatitude = Integer.MAX_VALUE;
                        int baseStationLongitude = Integer.MAX_VALUE;
                        int systemId = -1;
                        int networkId = -1;
                        if (states.length > 9) {
                            try {
                                if (states[4] != null) {
                                    baseStationId = Integer.parseInt(states[4]);
                                }
                                if (states[5] != null) {
                                    baseStationLatitude = Integer.parseInt(states[5]);
                                }
                                if (states[6] != null) {
                                    baseStationLongitude = Integer.parseInt(states[6]);
                                }
                                if (baseStationLatitude == 0 && baseStationLongitude == 0) {
                                    baseStationLatitude = Integer.MAX_VALUE;
                                    baseStationLongitude = Integer.MAX_VALUE;
                                }
                                if (states[8] != null) {
                                    systemId = Integer.parseInt(states[8]);
                                }
                                if (states[9] != null) {
                                    networkId = Integer.parseInt(states[9]);
                                }
                            } catch (NumberFormatException ex) {
                                loge("error parsing cell location data: " + ex);
                            }
                        }
                        this.mCellLoc.setCellLocationData(baseStationId, baseStationLatitude, baseStationLongitude, systemId, networkId);
                        this.mPhone.notifyLocationChanged();
                    }
                    disableSingleLocationUpdate();
                    return;
                case CallFailCause.NO_CIRCUIT_AVAIL /*34*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        String[] cdmaSubscription = (String[]) ar.result;
                        if (cdmaSubscription == null || cdmaSubscription.length < 5) {
                            i = cdmaSubscription.length;
                            log("GET_CDMA_SUBSCRIPTION: error parsing cdmaSubscription params num=" + i);
                            return;
                        }
                        this.mMdn = cdmaSubscription[0];
                        parseSidNid(cdmaSubscription[1], cdmaSubscription[2]);
                        this.mMin = cdmaSubscription[3];
                        this.mPrlVersion = cdmaSubscription[4];
                        String str2 = this.mMdn;
                        log("GET_CDMA_SUBSCRIPTION: MDN=" + str2);
                        this.mIsMinInfoReady = true;
                        updateOtaspState();
                        if (this.mIsSubscriptionFromRuim || this.mIccRecords == null) {
                            log("GET_CDMA_SUBSCRIPTION either mIccRecords is null  or NV type device - not setting Imsi in mIccRecords");
                            return;
                        }
                        log("GET_CDMA_SUBSCRIPTION set imsi in mIccRecords");
                        this.mIccRecords.setImsi(getImsi());
                        return;
                    }
                    return;
                case SmsHeader.ELT_ID_ENHANCED_VOICE_MAIL_INFORMATION /*35*/:
                    updatePhoneObject();
                    this.mCi.getNetworkSelectionMode(obtainMessage(14));
                    getSubscriptionInfoAndStartPollingThreads();
                    return;
                case CdmaSmsAddress.SMS_SUBADDRESS_MAX /*36*/:
                    log("[CdmaServiceStateTracker] ERI file has been loaded, repolling.");
                    pollState();
                    return;
                case SmsHeader.ELT_ID_NATIONAL_LANGUAGE_LOCKING_SHIFT /*37*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        int otaStatus = ((int[]) ar.result)[0];
                        if (otaStatus == 8 || otaStatus == 10) {
                            log("EVENT_OTA_PROVISION_STATUS_CHANGE: Complete, Reload MDN");
                            this.mCi.getCDMASubscription(obtainMessage(34));
                            return;
                        }
                        return;
                    }
                    return;
                case RadioNVItems.RIL_NV_MIP_PROFILE_AAA_SPI /*39*/:
                    handleCdmaSubscriptionSource(this.mCdmaSSM.getCdmaSubscriptionSource());
                    return;
                case RadioNVItems.RIL_NV_MIP_PROFILE_MN_HA_SS /*40*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        this.mPrlVersion = Integer.toString(((int[]) ar.result)[0]);
                        return;
                    }
                    return;
                case 45:
                    log("EVENT_CHANGE_IMS_STATE");
                    setPowerStateToDesired();
                    return;
                default:
                    super.handleMessage(msg);
                    return;
            }
        }
        String str3 = "[";
        i = msg.what;
        str3 = "]";
        str3 = " while being destroyed. Ignoring.";
        loge("Received message " + msg + str2 + i + str2 + str2);
    }

    private void handleCdmaSubscriptionSource(int newSubscriptionSource) {
        log("Subscription Source : " + newSubscriptionSource);
        this.mIsSubscriptionFromRuim = newSubscriptionSource == 0;
        log("isFromRuim: " + this.mIsSubscriptionFromRuim);
        saveCdmaSubscriptionSource(newSubscriptionSource);
        if (!this.mIsSubscriptionFromRuim) {
            sendMessage(obtainMessage(35));
        }
    }

    protected void setPowerStateToDesired() {
        if (this.mDesiredPowerState && this.mCi.getRadioState() == RadioState.RADIO_OFF) {
            this.mCi.setRadioPower(true, null);
        } else if (!this.mDesiredPowerState && this.mCi.getRadioState().isOn()) {
            powerOffRadioSafely(this.mPhone.mDcTracker);
        } else if (this.mDeviceShuttingDown && this.mCi.getRadioState().isAvailable()) {
            this.mCi.requestShutdown(null);
        }
    }

    protected void updateSpnDisplay() {
        String plmn = this.mSS.getOperatorAlphaLong();
        boolean showPlmn = false;
        if (!TextUtils.equals(plmn, this.mCurPlmn)) {
            showPlmn = plmn != null;
            log(String.format("updateSpnDisplay: changed sending intent showPlmn='%b' plmn='%s'", new Object[]{Boolean.valueOf(showPlmn), plmn}));
            Intent intent = new Intent("android.provider.Telephony.SPN_STRINGS_UPDATED");
            intent.addFlags(536870912);
            intent.putExtra("showSpn", false);
            intent.putExtra("spn", "");
            intent.putExtra("showPlmn", showPlmn);
            intent.putExtra(CellBroadcasts.PLMN, plmn);
            SubscriptionManager.putPhoneIdAndSubIdExtra(intent, this.mPhone.getPhoneId());
            this.mPhone.getContext().sendStickyBroadcastAsUser(intent, UserHandle.ALL);
            if (!this.mSubscriptionController.setPlmnSpn(this.mPhone.getPhoneId(), showPlmn, plmn, false, "")) {
                this.mSpnUpdatePending = true;
            }
        }
        this.mCurShowSpn = false;
        this.mCurShowPlmn = showPlmn;
        this.mCurSpn = "";
        this.mCurPlmn = plmn;
    }

    protected Phone getPhone() {
        return this.mPhone;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void handlePollStateResultMessage(int r28, android.os.AsyncResult r29) {
        /*
        r27 = this;
        switch(r28) {
            case 5: goto L_0x000b;
            case 24: goto L_0x00e1;
            case 25: goto L_0x02a7;
            default: goto L_0x0003;
        };
    L_0x0003:
        r3 = "handlePollStateResultMessage: RIL response handle in wrong phone! Expected CDMA RIL request and get GSM RIL request.";
        r0 = r27;
        r0.loge(r3);
    L_0x000a:
        return;
    L_0x000b:
        r0 = r29;
        r3 = r0.result;
        r3 = (java.lang.String[]) r3;
        r22 = r3;
        r22 = (java.lang.String[]) r22;
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "handlePollStateResultMessage: EVENT_POLL_STATE_GPRS states.length=";
        r0 = r24;
        r3 = r3.append(r0);
        r0 = r22;
        r0 = r0.length;
        r24 = r0;
        r0 = r24;
        r3 = r3.append(r0);
        r24 = " states=";
        r0 = r24;
        r3 = r3.append(r0);
        r0 = r22;
        r3 = r3.append(r0);
        r3 = r3.toString();
        r0 = r27;
        r0.log(r3);
        r19 = 4;
        r12 = 0;
        r0 = r22;
        r3 = r0.length;
        if (r3 <= 0) goto L_0x0068;
    L_0x004c:
        r3 = 0;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x00c5 }
        r19 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x00c5 }
        r0 = r22;
        r3 = r0.length;	 Catch:{ NumberFormatException -> 0x00c5 }
        r24 = 4;
        r0 = r24;
        if (r3 < r0) goto L_0x0068;
    L_0x005c:
        r3 = 3;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x00c5 }
        if (r3 == 0) goto L_0x0068;
    L_0x0061:
        r3 = 3;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x00c5 }
        r12 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x00c5 }
    L_0x0068:
        r0 = r27;
        r1 = r19;
        r13 = r0.regCodeToServiceState(r1);
        r0 = r27;
        r3 = r0.mNewSS;
        r3.setDataRegState(r13);
        r0 = r27;
        r3 = r0.mNewSS;
        r3.setRilDataRadioTechnology(r12);
        r0 = r27;
        r3 = r0.mNewSS;
        r0 = r27;
        r1 = r19;
        r24 = r0.regCodeIsRoaming(r1);
        r0 = r24;
        r3.setDataRoaming(r0);
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "handlPollStateResultMessage: cdma setDataRegState=";
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.append(r13);
        r24 = " regState=";
        r0 = r24;
        r3 = r3.append(r0);
        r0 = r19;
        r3 = r3.append(r0);
        r24 = " dataRadioTechnology=";
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.append(r12);
        r3 = r3.toString();
        r0 = r27;
        r0.log(r3);
        goto L_0x000a;
    L_0x00c5:
        r15 = move-exception;
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "handlePollStateResultMessage: error parsing GprsRegistrationState: ";
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.append(r15);
        r3 = r3.toString();
        r0 = r27;
        r0.loge(r3);
        goto L_0x0068;
    L_0x00e1:
        r0 = r29;
        r3 = r0.result;
        r3 = (java.lang.String[]) r3;
        r22 = r3;
        r22 = (java.lang.String[]) r22;
        r20 = 4;
        r17 = -1;
        r4 = -1;
        r5 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r6 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r11 = 0;
        r7 = 0;
        r8 = 0;
        r21 = -1;
        r23 = 0;
        r14 = 0;
        r18 = 0;
        r0 = r22;
        r3 = r0.length;
        r24 = 14;
        r0 = r24;
        if (r3 < r0) goto L_0x0266;
    L_0x0109:
        r3 = 0;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0115;
    L_0x010e:
        r3 = 0;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r20 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0115:
        r3 = 3;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0121;
    L_0x011a:
        r3 = 3;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r17 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0121:
        r3 = 4;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x012d;
    L_0x0126:
        r3 = 4;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r4 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x012d:
        r3 = 5;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0139;
    L_0x0132:
        r3 = 5;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r5 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0139:
        r3 = 6;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0145;
    L_0x013e:
        r3 = 6;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r6 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0145:
        if (r5 != 0) goto L_0x014f;
    L_0x0147:
        if (r6 != 0) goto L_0x014f;
    L_0x0149:
        r5 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r6 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
    L_0x014f:
        r3 = 7;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x015b;
    L_0x0154:
        r3 = 7;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r11 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x015b:
        r3 = 8;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0169;
    L_0x0161:
        r3 = 8;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r7 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0169:
        r3 = 9;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0177;
    L_0x016f:
        r3 = 9;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r8 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0177:
        r3 = 10;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0185;
    L_0x017d:
        r3 = 10;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r21 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0185:
        r3 = 11;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x0193;
    L_0x018b:
        r3 = 11;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r23 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x0193:
        r3 = 12;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x01a1;
    L_0x0199:
        r3 = 12;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r14 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x01a1:
        r3 = 13;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        if (r3 == 0) goto L_0x01af;
    L_0x01a7:
        r3 = 13;
        r3 = r22[r3];	 Catch:{ NumberFormatException -> 0x0249 }
        r18 = java.lang.Integer.parseInt(r3);	 Catch:{ NumberFormatException -> 0x0249 }
    L_0x01af:
        r0 = r20;
        r1 = r27;
        r1.mRegistrationState = r0;
        r0 = r27;
        r1 = r20;
        r3 = r0.regCodeIsRoaming(r1);
        if (r3 == 0) goto L_0x028c;
    L_0x01bf:
        r3 = 10;
        r3 = r22[r3];
        r0 = r27;
        r3 = r0.isRoamIndForHomeSystem(r3);
        if (r3 != 0) goto L_0x028c;
    L_0x01cb:
        r10 = 1;
    L_0x01cc:
        r0 = r27;
        r3 = r0.mNewSS;
        r3.setVoiceRoaming(r10);
        r0 = r27;
        r3 = r0.mNewSS;
        r0 = r27;
        r1 = r20;
        r24 = r0.regCodeToServiceState(r1);
        r0 = r24;
        r3.setState(r0);
        r0 = r27;
        r3 = r0.mNewSS;
        r0 = r17;
        r3.setRilVoiceRadioTechnology(r0);
        r0 = r27;
        r3 = r0.mNewSS;
        r3.setCssIndicator(r11);
        r0 = r27;
        r3 = r0.mNewSS;
        r3.setSystemAndNetworkId(r7, r8);
        r0 = r21;
        r1 = r27;
        r1.mRoamingIndicator = r0;
        if (r23 != 0) goto L_0x028f;
    L_0x0203:
        r3 = 0;
    L_0x0204:
        r0 = r27;
        r0.mIsInPrl = r3;
        r0 = r27;
        r0.mDefaultRoamingIndicator = r14;
        r0 = r27;
        r3 = r0.mNewCellLoc;
        r3.setCellLocationData(r4, r5, r6, r7, r8);
        if (r18 != 0) goto L_0x0292;
    L_0x0215:
        r3 = "General";
        r0 = r27;
        r0.mRegistrationDeniedReason = r3;
    L_0x021b:
        r0 = r27;
        r3 = r0.mRegistrationState;
        r24 = 3;
        r0 = r24;
        if (r3 != r0) goto L_0x000a;
    L_0x0225:
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "Registration denied, ";
        r0 = r24;
        r3 = r3.append(r0);
        r0 = r27;
        r0 = r0.mRegistrationDeniedReason;
        r24 = r0;
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.toString();
        r0 = r27;
        r0.log(r3);
        goto L_0x000a;
    L_0x0249:
        r15 = move-exception;
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "EVENT_POLL_STATE_REGISTRATION_CDMA: error parsing: ";
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.append(r15);
        r3 = r3.toString();
        r0 = r27;
        r0.loge(r3);
        goto L_0x01af;
    L_0x0266:
        r3 = new java.lang.RuntimeException;
        r24 = new java.lang.StringBuilder;
        r24.<init>();
        r25 = "Warning! Wrong number of parameters returned from RIL_REQUEST_REGISTRATION_STATE: expected 14 or more strings and got ";
        r24 = r24.append(r25);
        r0 = r22;
        r0 = r0.length;
        r25 = r0;
        r24 = r24.append(r25);
        r25 = " strings";
        r24 = r24.append(r25);
        r24 = r24.toString();
        r0 = r24;
        r3.<init>(r0);
        throw r3;
    L_0x028c:
        r10 = 0;
        goto L_0x01cc;
    L_0x028f:
        r3 = 1;
        goto L_0x0204;
    L_0x0292:
        r3 = 1;
        r0 = r18;
        if (r0 != r3) goto L_0x029f;
    L_0x0297:
        r3 = "Authentication Failure";
        r0 = r27;
        r0.mRegistrationDeniedReason = r3;
        goto L_0x021b;
    L_0x029f:
        r3 = "";
        r0 = r27;
        r0.mRegistrationDeniedReason = r3;
        goto L_0x021b;
    L_0x02a7:
        r0 = r29;
        r3 = r0.result;
        r3 = (java.lang.String[]) r3;
        r16 = r3;
        r16 = (java.lang.String[]) r16;
        if (r16 == 0) goto L_0x0388;
    L_0x02b3:
        r0 = r16;
        r3 = r0.length;
        r24 = 3;
        r0 = r24;
        if (r3 < r0) goto L_0x0388;
    L_0x02bc:
        r3 = 2;
        r3 = r16[r3];
        if (r3 == 0) goto L_0x02dc;
    L_0x02c1:
        r3 = 2;
        r3 = r16[r3];
        r3 = r3.length();
        r24 = 5;
        r0 = r24;
        if (r3 < r0) goto L_0x02dc;
    L_0x02ce:
        r3 = "00000";
        r24 = 2;
        r24 = r16[r24];
        r0 = r24;
        r3 = r3.equals(r0);
        if (r3 == 0) goto L_0x0317;
    L_0x02dc:
        r3 = 2;
        r24 = com.android.internal.telephony.cdma.CDMAPhone.PROPERTY_CDMA_HOME_OPERATOR_NUMERIC;
        r25 = "00000";
        r24 = android.os.SystemProperties.get(r24, r25);
        r16[r3] = r24;
        r3 = new java.lang.StringBuilder;
        r3.<init>();
        r24 = "RIL_REQUEST_OPERATOR.response[2], the numeric,  is bad. Using SystemProperties '";
        r0 = r24;
        r3 = r3.append(r0);
        r24 = com.android.internal.telephony.cdma.CDMAPhone.PROPERTY_CDMA_HOME_OPERATOR_NUMERIC;
        r0 = r24;
        r3 = r3.append(r0);
        r24 = "'= ";
        r0 = r24;
        r3 = r3.append(r0);
        r24 = 2;
        r24 = r16[r24];
        r0 = r24;
        r3 = r3.append(r0);
        r3 = r3.toString();
        r0 = r27;
        r0.log(r3);
    L_0x0317:
        r0 = r27;
        r3 = r0.mIsSubscriptionFromRuim;
        if (r3 != 0) goto L_0x0338;
    L_0x031d:
        r0 = r27;
        r3 = r0.mNewSS;
        r24 = 0;
        r24 = r16[r24];
        r25 = 1;
        r25 = r16[r25];
        r26 = 2;
        r26 = r16[r26];
        r0 = r24;
        r1 = r25;
        r2 = r26;
        r3.setOperatorName(r0, r1, r2);
        goto L_0x000a;
    L_0x0338:
        r0 = r27;
        r3 = r0.mUiccController;
        r24 = r27.getPhoneId();
        r0 = r24;
        r3 = r3.getUiccCard(r0);
        if (r3 == 0) goto L_0x036b;
    L_0x0348:
        r0 = r27;
        r3 = r0.mUiccController;
        r24 = r27.getPhoneId();
        r0 = r24;
        r3 = r3.getUiccCard(r0);
        r9 = r3.getOperatorBrandOverride();
    L_0x035a:
        if (r9 == 0) goto L_0x036d;
    L_0x035c:
        r0 = r27;
        r3 = r0.mNewSS;
        r24 = 2;
        r24 = r16[r24];
        r0 = r24;
        r3.setOperatorName(r9, r9, r0);
        goto L_0x000a;
    L_0x036b:
        r9 = 0;
        goto L_0x035a;
    L_0x036d:
        r0 = r27;
        r3 = r0.mNewSS;
        r24 = 0;
        r24 = r16[r24];
        r25 = 1;
        r25 = r16[r25];
        r26 = 2;
        r26 = r16[r26];
        r0 = r24;
        r1 = r25;
        r2 = r26;
        r3.setOperatorName(r0, r1, r2);
        goto L_0x000a;
    L_0x0388:
        r3 = "EVENT_POLL_STATE_OPERATOR_CDMA: error parsing opNames";
        r0 = r27;
        r0.log(r3);
        goto L_0x000a;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.cdma.CdmaServiceStateTracker.handlePollStateResultMessage(int, android.os.AsyncResult):void");
    }

    protected void handlePollStateResult(int what, AsyncResult ar) {
        boolean isVoiceInService = false;
        if (ar.userObj == this.mPollingContext) {
            if (ar.exception != null) {
                Error err = null;
                if (ar.exception instanceof CommandException) {
                    err = ((CommandException) ar.exception).getCommandError();
                }
                if (err == Error.RADIO_NOT_AVAILABLE) {
                    cancelPollState();
                    return;
                } else if (!this.mCi.getRadioState().isOn()) {
                    cancelPollState();
                    return;
                } else if (err != Error.OP_NOT_ALLOWED_BEFORE_REG_NW) {
                    loge("handlePollStateResult: RIL returned an error where it must succeed" + ar.exception);
                }
            } else {
                try {
                    handlePollStateResultMessage(what, ar);
                } catch (RuntimeException ex) {
                    loge("handlePollStateResult: Exception while polling service state. Probably malformed RIL response." + ex);
                }
            }
            int[] iArr = this.mPollingContext;
            iArr[0] = iArr[0] - 1;
            if (this.mPollingContext[0] == 0) {
                boolean namMatch = false;
                if (!isSidsAllZeros() && isHomeSid(this.mNewSS.getSystemId())) {
                    namMatch = true;
                }
                if (this.mIsSubscriptionFromRuim) {
                    this.mNewSS.setVoiceRoaming(isRoamingBetweenOperators(this.mNewSS.getVoiceRoaming(), this.mNewSS));
                }
                if (this.mNewSS.getVoiceRegState() == 0) {
                    isVoiceInService = true;
                }
                int dataRegType = this.mNewSS.getRilDataRadioTechnology();
                if (isVoiceInService && ServiceState.isCdma(dataRegType)) {
                    this.mNewSS.setDataRoaming(this.mNewSS.getVoiceRoaming());
                }
                this.mNewSS.setCdmaDefaultRoamingIndicator(this.mDefaultRoamingIndicator);
                this.mNewSS.setCdmaRoamingIndicator(this.mRoamingIndicator);
                boolean isPrlLoaded = true;
                if (TextUtils.isEmpty(this.mPrlVersion)) {
                    isPrlLoaded = false;
                }
                if (!isPrlLoaded || this.mNewSS.getRilVoiceRadioTechnology() == 0) {
                    log("Turn off roaming indicator if !isPrlLoaded or voice RAT is unknown");
                    this.mNewSS.setCdmaRoamingIndicator(1);
                } else if (!isSidsAllZeros()) {
                    if (!namMatch && !this.mIsInPrl) {
                        this.mNewSS.setCdmaRoamingIndicator(this.mDefaultRoamingIndicator);
                    } else if (!namMatch || this.mIsInPrl) {
                        if (!namMatch && this.mIsInPrl) {
                            this.mNewSS.setCdmaRoamingIndicator(this.mRoamingIndicator);
                        } else if (this.mRoamingIndicator <= 2) {
                            this.mNewSS.setCdmaRoamingIndicator(1);
                        } else {
                            this.mNewSS.setCdmaRoamingIndicator(this.mRoamingIndicator);
                        }
                    } else if (this.mNewSS.getRilVoiceRadioTechnology() == 14) {
                        log("Turn off roaming indicator as voice is LTE");
                        this.mNewSS.setCdmaRoamingIndicator(1);
                    } else {
                        this.mNewSS.setCdmaRoamingIndicator(2);
                    }
                }
                int roamingIndicator = this.mNewSS.getCdmaRoamingIndicator();
                this.mNewSS.setCdmaEriIconIndex(this.mPhone.mEriManager.getCdmaEriIconIndex(roamingIndicator, this.mDefaultRoamingIndicator));
                this.mNewSS.setCdmaEriIconMode(this.mPhone.mEriManager.getCdmaEriIconMode(roamingIndicator, this.mDefaultRoamingIndicator));
                log("Set CDMA Roaming Indicator to: " + this.mNewSS.getCdmaRoamingIndicator() + ". voiceRoaming = " + this.mNewSS.getVoiceRoaming() + ". dataRoaming = " + this.mNewSS.getDataRoaming() + ", isPrlLoaded = " + isPrlLoaded + ". namMatch = " + namMatch + " , mIsInPrl = " + this.mIsInPrl + ", mRoamingIndicator = " + this.mRoamingIndicator + ", mDefaultRoamingIndicator= " + this.mDefaultRoamingIndicator);
                pollStateDone();
            }
        }
    }

    protected void setRoamingType(ServiceState currentServiceState) {
        boolean isVoiceInService;
        boolean isDataInService;
        if (currentServiceState.getVoiceRegState() == 0) {
            isVoiceInService = true;
        } else {
            isVoiceInService = false;
        }
        if (isVoiceInService) {
            if (currentServiceState.getVoiceRoaming()) {
                int[] intRoamingIndicators = this.mPhone.getContext().getResources().getIntArray(17236033);
                if (intRoamingIndicators != null && intRoamingIndicators.length > 0) {
                    currentServiceState.setVoiceRoamingType(2);
                    int curRoamingIndicator = currentServiceState.getCdmaRoamingIndicator();
                    for (int i : intRoamingIndicators) {
                        if (curRoamingIndicator == i) {
                            currentServiceState.setVoiceRoamingType(3);
                            break;
                        }
                    }
                } else if (inSameCountry(currentServiceState.getVoiceOperatorNumeric())) {
                    currentServiceState.setVoiceRoamingType(2);
                } else {
                    currentServiceState.setVoiceRoamingType(3);
                }
            } else {
                currentServiceState.setVoiceRoamingType(0);
            }
        }
        if (currentServiceState.getDataRegState() == 0) {
            isDataInService = true;
        } else {
            isDataInService = false;
        }
        int dataRegType = currentServiceState.getRilDataRadioTechnology();
        if (!isDataInService) {
            return;
        }
        if (!currentServiceState.getDataRoaming()) {
            currentServiceState.setDataRoamingType(0);
        } else if (ServiceState.isCdma(dataRegType)) {
            if (isVoiceInService) {
                currentServiceState.setDataRoamingType(currentServiceState.getVoiceRoamingType());
            } else {
                currentServiceState.setDataRoamingType(1);
            }
        } else if (inSameCountry(currentServiceState.getDataOperatorNumeric())) {
            currentServiceState.setDataRoamingType(2);
        } else {
            currentServiceState.setDataRoamingType(3);
        }
    }

    protected String getHomeOperatorNumeric() {
        String numeric = ((TelephonyManager) this.mPhone.getContext().getSystemService("phone")).getSimOperatorNumericForPhone(this.mPhoneBase.getPhoneId());
        if (TextUtils.isEmpty(numeric)) {
            return SystemProperties.get(CDMAPhone.PROPERTY_CDMA_HOME_OPERATOR_NUMERIC, "");
        }
        return numeric;
    }

    protected void setSignalStrengthDefaultValues() {
        this.mSignalStrength = new SignalStrength(false);
    }

    public void pollState() {
        this.mPollingContext = new int[1];
        this.mPollingContext[0] = 0;
        switch (C00483.f7x46dd5024[this.mCi.getRadioState().ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                this.mNewSS.setStateOutOfService();
                this.mNewCellLoc.setStateInvalid();
                setSignalStrengthDefaultValues();
                this.mGotCountryCode = false;
                pollStateDone();
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                this.mNewSS.setStateOff();
                this.mNewCellLoc.setStateInvalid();
                setSignalStrengthDefaultValues();
                this.mGotCountryCode = false;
                pollStateDone();
            default:
                int[] iArr = this.mPollingContext;
                iArr[0] = iArr[0] + 1;
                this.mCi.getOperator(obtainMessage(25, this.mPollingContext));
                iArr = this.mPollingContext;
                iArr[0] = iArr[0] + 1;
                this.mCi.getVoiceRegistrationState(obtainMessage(24, this.mPollingContext));
                iArr = this.mPollingContext;
                iArr[0] = iArr[0] + 1;
                this.mCi.getDataRegistrationState(obtainMessage(5, this.mPollingContext));
        }
    }

    protected void fixTimeZone(String isoCountryCode) {
        TimeZone zone;
        String zoneName = SystemProperties.get("persist.sys.timezone");
        log("fixTimeZone zoneName='" + zoneName + "' mZoneOffset=" + this.mZoneOffset + " mZoneDst=" + this.mZoneDst + " iso-cc='" + isoCountryCode + "' iso-cc-idx=" + Arrays.binarySearch(GMT_COUNTRY_CODES, isoCountryCode));
        if (this.mZoneOffset == 0 && !this.mZoneDst && zoneName != null && zoneName.length() > 0 && Arrays.binarySearch(GMT_COUNTRY_CODES, isoCountryCode) < 0) {
            zone = TimeZone.getDefault();
            if (this.mNeedFixZone) {
                long ctm = System.currentTimeMillis();
                long tzOffset = (long) zone.getOffset(ctm);
                log("fixTimeZone: tzOffset=" + tzOffset + " ltod=" + TimeUtils.logTimeOfDay(ctm));
                if (getAutoTime()) {
                    long adj = ctm - tzOffset;
                    log("fixTimeZone: adj ltod=" + TimeUtils.logTimeOfDay(adj));
                    setAndBroadcastNetworkSetTime(adj);
                } else {
                    this.mSavedTime -= tzOffset;
                    log("fixTimeZone: adj mSavedTime=" + this.mSavedTime);
                }
            }
            log("fixTimeZone: using default TimeZone");
        } else if (isoCountryCode.equals("")) {
            zone = getNitzTimeZone(this.mZoneOffset, this.mZoneDst, this.mZoneTime);
            log("fixTimeZone: using NITZ TimeZone");
        } else {
            zone = TimeUtils.getTimeZone(this.mZoneOffset, this.mZoneDst, this.mZoneTime, isoCountryCode);
            log("fixTimeZone: using getTimeZone(off, dst, time, iso)");
        }
        this.mNeedFixZone = false;
        if (zone != null) {
            log("fixTimeZone: zone != null zone.getID=" + zone.getID());
            if (getAutoTimeZone()) {
                setAndBroadcastNetworkSetTimeZone(zone.getID());
            } else {
                log("fixTimeZone: skip changing zone as getAutoTimeZone was false");
            }
            saveNitzTimeZone(zone.getID());
            return;
        }
        log("fixTimeZone: zone == null, do nothing for zone");
    }

    protected void pollStateDone() {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxOverflowException: Iterative traversal limit reached, method: com.android.internal.telephony.cdma.CdmaServiceStateTracker.pollStateDone():void
	at jadx.core.utils.ErrorsCounter.addError(ErrorsCounter.java:42)
	at jadx.core.utils.ErrorsCounter.methodError(ErrorsCounter.java:66)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:33)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r32 = this;
        r28 = new java.lang.StringBuilder;
        r28.<init>();
        r29 = "pollStateDone: cdma oldSS=[";
        r28 = r28.append(r29);
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r28 = r28.append(r29);
        r29 = "] newSS=[";
        r28 = r28.append(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r28 = r28.append(r29);
        r29 = "]";
        r28 = r28.append(r29);
        r28 = r28.toString();
        r0 = r32;
        r1 = r28;
        r0.log(r1);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getOperatorNumeric();
        r28 = r28.isMccMncMarkedAsNonRoaming(r29);
        if (r28 != 0) goto L_0x0062;
    L_0x004c:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getSystemId();
        r28 = r28.isSidMarkedAsNonRoaming(r29);
        if (r28 == 0) goto L_0x04cb;
    L_0x0062:
        r28 = "pollStateDone: override - marked as non-roaming.";
        r0 = r32;
        r1 = r28;
        r0.log(r1);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 0;
        r28.setVoiceRoaming(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 0;
        r28.setDataRoaming(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 1;
        r28.setCdmaEriIconIndex(r29);
    L_0x008c:
        r28 = android.os.Build.IS_DEBUGGABLE;
        if (r28 == 0) goto L_0x00b0;
    L_0x0090:
        r28 = "telephony.test.forceRoaming";
        r29 = 0;
        r28 = android.os.SystemProperties.getBoolean(r28, r29);
        if (r28 == 0) goto L_0x00b0;
    L_0x009a:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 1;
        r28.setVoiceRoaming(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 1;
        r28.setDataRoaming(r29);
    L_0x00b0:
        r32.useDataRegStateForDataOnlyDevices();
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        if (r28 == 0) goto L_0x052e;
    L_0x00bf:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        if (r28 != 0) goto L_0x052e;
    L_0x00cb:
        r15 = 1;
    L_0x00cc:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        if (r28 != 0) goto L_0x0531;
    L_0x00d8:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        if (r28 == 0) goto L_0x0531;
    L_0x00e4:
        r13 = 1;
    L_0x00e5:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        if (r28 == 0) goto L_0x0534;
    L_0x00f1:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        if (r28 != 0) goto L_0x0534;
    L_0x00fd:
        r7 = 1;
    L_0x00fe:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        if (r28 != 0) goto L_0x0537;
    L_0x010a:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        if (r28 == 0) goto L_0x0537;
    L_0x0116:
        r9 = 1;
    L_0x0117:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getDataRegState();
        r0 = r28;
        r1 = r29;
        if (r0 == r1) goto L_0x053a;
    L_0x0131:
        r8 = 1;
    L_0x0132:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getRilVoiceRadioTechnology();
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getRilVoiceRadioTechnology();
        r0 = r28;
        r1 = r29;
        if (r0 == r1) goto L_0x053d;
    L_0x014c:
        r17 = 1;
    L_0x014e:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getRilDataRadioTechnology();
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getRilDataRadioTechnology();
        r0 = r28;
        r1 = r29;
        if (r0 == r1) goto L_0x0541;
    L_0x0168:
        r16 = 1;
    L_0x016a:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r28 = r28.equals(r29);
        if (r28 != 0) goto L_0x0545;
    L_0x017c:
        r10 = 1;
    L_0x017d:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRoaming();
        if (r28 != 0) goto L_0x0548;
    L_0x0189:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getVoiceRoaming();
        if (r28 == 0) goto L_0x0548;
    L_0x0195:
        r19 = 1;
    L_0x0197:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRoaming();
        if (r28 == 0) goto L_0x054c;
    L_0x01a3:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getVoiceRoaming();
        if (r28 != 0) goto L_0x054c;
    L_0x01af:
        r18 = 1;
    L_0x01b1:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRoaming();
        if (r28 != 0) goto L_0x0550;
    L_0x01bd:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getDataRoaming();
        if (r28 == 0) goto L_0x0550;
    L_0x01c9:
        r12 = 1;
    L_0x01ca:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRoaming();
        if (r28 == 0) goto L_0x0553;
    L_0x01d6:
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28 = r28.getDataRoaming();
        if (r28 != 0) goto L_0x0553;
    L_0x01e2:
        r11 = 1;
    L_0x01e3:
        r0 = r32;
        r0 = r0.mNewCellLoc;
        r28 = r0;
        r0 = r32;
        r0 = r0.mCellLoc;
        r29 = r0;
        r28 = r28.equals(r29);
        if (r28 != 0) goto L_0x0556;
    L_0x01f5:
        r14 = 1;
    L_0x01f6:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getContext();
        r29 = "phone";
        r26 = r28.getSystemService(r29);
        r26 = (android.telephony.TelephonyManager) r26;
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getVoiceRegState();
        r0 = r28;
        r1 = r29;
        if (r0 != r1) goto L_0x023c;
    L_0x0222:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRegState();
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getDataRegState();
        r0 = r28;
        r1 = r29;
        if (r0 == r1) goto L_0x0292;
    L_0x023c:
        r28 = 50116; // 0xc3c4 float:7.0227E-41 double:2.47606E-319;
        r29 = 4;
        r0 = r29;
        r0 = new java.lang.Object[r0];
        r29 = r0;
        r30 = 0;
        r0 = r32;
        r0 = r0.mSS;
        r31 = r0;
        r31 = r31.getVoiceRegState();
        r31 = java.lang.Integer.valueOf(r31);
        r29[r30] = r31;
        r30 = 1;
        r0 = r32;
        r0 = r0.mSS;
        r31 = r0;
        r31 = r31.getDataRegState();
        r31 = java.lang.Integer.valueOf(r31);
        r29[r30] = r31;
        r30 = 2;
        r0 = r32;
        r0 = r0.mNewSS;
        r31 = r0;
        r31 = r31.getVoiceRegState();
        r31 = java.lang.Integer.valueOf(r31);
        r29[r30] = r31;
        r30 = 3;
        r0 = r32;
        r0 = r0.mNewSS;
        r31 = r0;
        r31 = r31.getDataRegState();
        r31 = java.lang.Integer.valueOf(r31);
        r29[r30] = r31;
        android.util.EventLog.writeEvent(r28, r29);
    L_0x0292:
        r0 = r32;
        r0 = r0.mSS;
        r27 = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r0 = r28;
        r1 = r32;
        r1.mSS = r0;
        r0 = r27;
        r1 = r32;
        r1.mNewSS = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r28.setStateOutOfService();
        r0 = r32;
        r0 = r0.mCellLoc;
        r25 = r0;
        r0 = r32;
        r0 = r0.mNewCellLoc;
        r28 = r0;
        r0 = r28;
        r1 = r32;
        r1.mCellLoc = r0;
        r0 = r25;
        r1 = r32;
        r1.mNewCellLoc = r0;
        if (r17 == 0) goto L_0x02d0;
    L_0x02cd:
        r32.updatePhoneObject();
    L_0x02d0:
        if (r16 == 0) goto L_0x02ef;
    L_0x02d2:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r29 = r29.getRilDataRadioTechnology();
        r0 = r26;
        r1 = r28;
        r2 = r29;
        r0.setDataNetworkTypeForPhone(r1, r2);
    L_0x02ef:
        if (r15 == 0) goto L_0x02fa;
    L_0x02f1:
        r0 = r32;
        r0 = r0.mNetworkAttachedRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x02fa:
        if (r10 == 0) goto L_0x046b;
    L_0x02fc:
        r0 = r32;
        r0 = r0.mCi;
        r28 = r0;
        r28 = r28.getRadioState();
        r28 = r28.isOn();
        if (r28 == 0) goto L_0x0335;
    L_0x030c:
        r0 = r32;
        r0 = r0.mIsSubscriptionFromRuim;
        r28 = r0;
        if (r28 != 0) goto L_0x0335;
    L_0x0314:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRegState();
        if (r28 != 0) goto L_0x0559;
    L_0x0320:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r5 = r28.getCdmaEriText();
    L_0x032a:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r0 = r28;
        r0.setOperatorAlphaLong(r5);
    L_0x0335:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r29 = r29.getOperatorAlphaLong();
        r0 = r26;
        r1 = r28;
        r2 = r29;
        r0.setNetworkOperatorNameForPhone(r1, r2);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r0 = r26;
        r1 = r28;
        r23 = r0.getNetworkOperatorForPhone(r1);
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r22 = r28.getOperatorNumeric();
        r0 = r32;
        r1 = r22;
        r28 = r0.isInvalidOperatorNumeric(r1);
        if (r28 == 0) goto L_0x038c;
    L_0x0378:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r24 = r28.getSystemId();
        r0 = r32;
        r1 = r22;
        r2 = r24;
        r22 = r0.fixUnknownMcc(r1, r2);
    L_0x038c:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r0 = r26;
        r1 = r28;
        r2 = r22;
        r0.setNetworkOperatorNumericForPhone(r1, r2);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getContext();
        r0 = r32;
        r1 = r22;
        r2 = r23;
        r3 = r28;
        r0.updateCarrierMccMncConfiguration(r1, r2, r3);
        r0 = r32;
        r1 = r22;
        r28 = r0.isInvalidOperatorNumeric(r1);
        if (r28 == 0) goto L_0x0570;
    L_0x03be:
        r28 = new java.lang.StringBuilder;
        r28.<init>();
        r29 = "operatorNumeric ";
        r28 = r28.append(r29);
        r0 = r28;
        r1 = r22;
        r28 = r0.append(r1);
        r29 = "is invalid";
        r28 = r28.append(r29);
        r28 = r28.toString();
        r0 = r32;
        r1 = r28;
        r0.log(r1);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r29 = "";
        r0 = r26;
        r1 = r28;
        r2 = r29;
        r0.setNetworkCountryIsoForPhone(r1, r2);
        r28 = 0;
        r0 = r28;
        r1 = r32;
        r1.mGotCountryCode = r0;
    L_0x03ff:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r29 = r28.getPhoneId();
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getVoiceRoaming();
        if (r28 != 0) goto L_0x0421;
    L_0x0415:
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r28 = r28.getDataRoaming();
        if (r28 == 0) goto L_0x061a;
    L_0x0421:
        r28 = 1;
    L_0x0423:
        r0 = r26;
        r1 = r29;
        r2 = r28;
        r0.setNetworkRoamingForPhone(r1, r2);
        r32.updateSpnDisplay();
        r0 = r32;
        r0 = r0.mSS;
        r28 = r0;
        r0 = r32;
        r1 = r28;
        r0.setRoamingType(r1);
        r28 = new java.lang.StringBuilder;
        r28.<init>();
        r29 = "Broadcasting ServiceState : ";
        r28 = r28.append(r29);
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r28 = r28.append(r29);
        r28 = r28.toString();
        r0 = r32;
        r1 = r28;
        r0.log(r1);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mSS;
        r29 = r0;
        r28.notifyServiceStateChanged(r29);
    L_0x046b:
        if (r7 == 0) goto L_0x0476;
    L_0x046d:
        r0 = r32;
        r0 = r0.mAttachedRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x0476:
        if (r9 == 0) goto L_0x0481;
    L_0x0478:
        r0 = r32;
        r0 = r0.mDetachedRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x0481:
        if (r8 != 0) goto L_0x0485;
    L_0x0483:
        if (r16 == 0) goto L_0x0493;
    L_0x0485:
        r32.notifyDataRegStateRilRadioTechnologyChanged();
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r29 = 0;
        r28.notifyDataConnection(r29);
    L_0x0493:
        if (r19 == 0) goto L_0x049e;
    L_0x0495:
        r0 = r32;
        r0 = r0.mVoiceRoamingOnRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x049e:
        if (r18 == 0) goto L_0x04a9;
    L_0x04a0:
        r0 = r32;
        r0 = r0.mVoiceRoamingOffRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x04a9:
        if (r12 == 0) goto L_0x04b4;
    L_0x04ab:
        r0 = r32;
        r0 = r0.mDataRoamingOnRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x04b4:
        if (r11 == 0) goto L_0x04bf;
    L_0x04b6:
        r0 = r32;
        r0 = r0.mDataRoamingOffRegistrants;
        r28 = r0;
        r28.notifyRegistrants();
    L_0x04bf:
        if (r14 == 0) goto L_0x04ca;
    L_0x04c1:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28.notifyLocationChanged();
    L_0x04ca:
        return;
    L_0x04cb:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getOperatorNumeric();
        r28 = r28.isMccMncMarkedAsRoaming(r29);
        if (r28 != 0) goto L_0x04f7;
    L_0x04e1:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mNewSS;
        r29 = r0;
        r29 = r29.getSystemId();
        r28 = r28.isSidMarkedAsRoaming(r29);
        if (r28 == 0) goto L_0x008c;
    L_0x04f7:
        r28 = "pollStateDone: override - marked as roaming.";
        r0 = r32;
        r1 = r28;
        r0.log(r1);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 1;
        r28.setVoiceRoaming(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 1;
        r28.setDataRoaming(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 0;
        r28.setCdmaEriIconIndex(r29);
        r0 = r32;
        r0 = r0.mNewSS;
        r28 = r0;
        r29 = 0;
        r28.setCdmaEriIconMode(r29);
        goto L_0x008c;
    L_0x052e:
        r15 = 0;
        goto L_0x00cc;
    L_0x0531:
        r13 = 0;
        goto L_0x00e5;
    L_0x0534:
        r7 = 0;
        goto L_0x00fe;
    L_0x0537:
        r9 = 0;
        goto L_0x0117;
    L_0x053a:
        r8 = 0;
        goto L_0x0132;
    L_0x053d:
        r17 = 0;
        goto L_0x014e;
    L_0x0541:
        r16 = 0;
        goto L_0x016a;
    L_0x0545:
        r10 = 0;
        goto L_0x017d;
    L_0x0548:
        r19 = 0;
        goto L_0x0197;
    L_0x054c:
        r18 = 0;
        goto L_0x01b1;
    L_0x0550:
        r12 = 0;
        goto L_0x01ca;
    L_0x0553:
        r11 = 0;
        goto L_0x01e3;
    L_0x0556:
        r14 = 0;
        goto L_0x01f6;
    L_0x0559:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getContext();
        r29 = 17039570; // 0x10400d2 float:2.424516E-38 double:8.418666E-317;
        r28 = r28.getText(r29);
        r5 = r28.toString();
        goto L_0x032a;
    L_0x0570:
        r20 = "";
        r28 = 0;
        r29 = 3;
        r0 = r22;
        r1 = r28;
        r2 = r29;
        r21 = r0.substring(r1, r2);
        r28 = 0;
        r29 = 3;
        r0 = r22;	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
        r1 = r28;	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
        r2 = r29;	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
        r28 = r0.substring(r1, r2);	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
        r28 = java.lang.Integer.parseInt(r28);	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
        r20 = com.android.internal.telephony.MccTable.countryCodeForMcc(r28);	 Catch:{ NumberFormatException -> 0x05dd, StringIndexOutOfBoundsException -> 0x05fb }
    L_0x0596:
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r28 = r28.getPhoneId();
        r0 = r26;
        r1 = r28;
        r2 = r20;
        r0.setNetworkCountryIsoForPhone(r1, r2);
        r28 = 1;
        r0 = r28;
        r1 = r32;
        r1.mGotCountryCode = r0;
        r0 = r32;
        r1 = r22;
        r0.setOperatorIdd(r1);
        r0 = r32;
        r0 = r0.mPhone;
        r28 = r0;
        r0 = r32;
        r0 = r0.mNeedFixZone;
        r29 = r0;
        r0 = r32;
        r1 = r28;
        r2 = r22;
        r3 = r23;
        r4 = r29;
        r28 = r0.shouldFixTimeZoneNow(r1, r2, r3, r4);
        if (r28 == 0) goto L_0x03ff;
    L_0x05d4:
        r0 = r32;
        r1 = r20;
        r0.fixTimeZone(r1);
        goto L_0x03ff;
    L_0x05dd:
        r6 = move-exception;
        r28 = new java.lang.StringBuilder;
        r28.<init>();
        r29 = "pollStateDone: countryCodeForMcc error";
        r28 = r28.append(r29);
        r0 = r28;
        r28 = r0.append(r6);
        r28 = r28.toString();
        r0 = r32;
        r1 = r28;
        r0.loge(r1);
        goto L_0x0596;
    L_0x05fb:
        r6 = move-exception;
        r28 = new java.lang.StringBuilder;
        r28.<init>();
        r29 = "pollStateDone: countryCodeForMcc error";
        r28 = r28.append(r29);
        r0 = r28;
        r28 = r0.append(r6);
        r28 = r28.toString();
        r0 = r32;
        r1 = r28;
        r0.loge(r1);
        goto L_0x0596;
    L_0x061a:
        r28 = 0;
        goto L_0x0423;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.cdma.CdmaServiceStateTracker.pollStateDone():void");
    }

    protected boolean isInvalidOperatorNumeric(String operatorNumeric) {
        return operatorNumeric == null || operatorNumeric.length() < 5 || operatorNumeric.startsWith(INVALID_MCC);
    }

    protected String fixUnknownMcc(String operatorNumeric, int sid) {
        if (sid <= 0) {
            return operatorNumeric;
        }
        boolean isNitzTimeZone = false;
        int timeZone = 0;
        if (this.mSavedTimeZone != null) {
            timeZone = TimeZone.getTimeZone(this.mSavedTimeZone).getRawOffset() / MS_PER_HOUR;
            isNitzTimeZone = true;
        } else {
            TimeZone tzone = getNitzTimeZone(this.mZoneOffset, this.mZoneDst, this.mZoneTime);
            if (tzone != null) {
                timeZone = tzone.getRawOffset() / MS_PER_HOUR;
            }
        }
        int mcc = this.mHbpcdUtils.getMcc(sid, timeZone, this.mZoneDst ? 1 : 0, isNitzTimeZone);
        if (mcc > 0) {
            operatorNumeric = Integer.toString(mcc) + DEFAULT_MNC;
        }
        return operatorNumeric;
    }

    protected void setOperatorIdd(String operatorNumeric) {
        String idd = this.mHbpcdUtils.getIddByMcc(Integer.parseInt(operatorNumeric.substring(0, 3)));
        if (idd == null || idd.isEmpty()) {
            this.mPhone.setSystemProperty("gsm.operator.idpstring", "+");
        } else {
            this.mPhone.setSystemProperty("gsm.operator.idpstring", idd);
        }
    }

    private TimeZone getNitzTimeZone(int offset, boolean dst, long when) {
        TimeZone guess = findTimeZone(offset, dst, when);
        if (guess == null) {
            guess = findTimeZone(offset, !dst, when);
        }
        log("getNitzTimeZone returning " + (guess == null ? guess : guess.getID()));
        return guess;
    }

    private TimeZone findTimeZone(int offset, boolean dst, long when) {
        int rawOffset = offset;
        if (dst) {
            rawOffset -= MS_PER_HOUR;
        }
        String[] zones = TimeZone.getAvailableIDs(rawOffset);
        Date d = new Date(when);
        for (String zone : zones) {
            TimeZone tz = TimeZone.getTimeZone(zone);
            if (tz.getOffset(when) == offset && tz.inDaylightTime(d) == dst) {
                return tz;
            }
        }
        return null;
    }

    private void queueNextSignalStrengthPoll() {
        if (!this.mDontPollSignalStrength) {
            Message msg = obtainMessage();
            msg.what = 10;
            sendMessageDelayed(msg, 20000);
        }
    }

    protected int radioTechnologyToDataServiceState(int code) {
        switch (code) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                return 1;
            case CharacterSets.ISO_8859_3 /*6*/:
            case CharacterSets.ISO_8859_4 /*7*/:
            case CharacterSets.ISO_8859_5 /*8*/:
            case CharacterSets.ISO_8859_9 /*12*/:
            case UserData.ASCII_CR_INDEX /*13*/:
                return 0;
            default:
                loge("radioTechnologyToDataServiceState: Wrong radioTechnology code.");
                return 1;
        }
    }

    protected int regCodeToServiceState(int code) {
        switch (code) {
            case CharacterSets.ANY_CHARSET /*0*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                return 1;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 0;
            case CharacterSets.ISO_8859_2 /*5*/:
                return 0;
            default:
                loge("regCodeToServiceState: unexpected service state " + code);
                return 1;
        }
    }

    public int getCurrentDataConnectionState() {
        return this.mSS.getDataRegState();
    }

    protected boolean regCodeIsRoaming(int code) {
        return 5 == code;
    }

    private boolean isRoamIndForHomeSystem(String roamInd) {
        String[] homeRoamIndicators = this.mPhone.getContext().getResources().getStringArray(17236025);
        if (homeRoamIndicators == null) {
            return false;
        }
        for (String homeRoamInd : homeRoamIndicators) {
            if (homeRoamInd.equals(roamInd)) {
                return true;
            }
        }
        return false;
    }

    private boolean isRoamingBetweenOperators(boolean cdmaRoaming, ServiceState s) {
        String spn = ((TelephonyManager) this.mPhone.getContext().getSystemService("phone")).getSimOperatorNameForPhone(this.mPhoneBase.getPhoneId());
        String onsl = s.getVoiceOperatorAlphaLong();
        String onss = s.getVoiceOperatorAlphaShort();
        boolean equalsOnsl;
        if (onsl == null || !spn.equals(onsl)) {
            equalsOnsl = false;
        } else {
            equalsOnsl = true;
        }
        boolean equalsOnss;
        if (onss == null || !spn.equals(onss)) {
            equalsOnss = false;
        } else {
            equalsOnss = true;
        }
        if (!cdmaRoaming || equalsOnsl || equalsOnss) {
            return false;
        }
        return true;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void setTimeFromNITZString(java.lang.String r39, long r40) {
        /*
        r38 = this;
        r26 = android.os.SystemClock.elapsedRealtime();
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "NITZ: ";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r39;
        r34 = r0.append(r1);
        r35 = ",";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r40;
        r34 = r0.append(r1);
        r35 = " start=";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r26;
        r34 = r0.append(r1);
        r35 = " delay=";
        r34 = r34.append(r35);
        r36 = r26 - r40;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);
        r34 = r34.toString();
        r0 = r38;
        r1 = r34;
        r0.log(r1);
        r34 = "GMT";
        r34 = java.util.TimeZone.getTimeZone(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r6 = java.util.Calendar.getInstance(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r6.clear();	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 16;
        r35 = 0;
        r0 = r34;
        r1 = r35;
        r6.set(r0, r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = "[/:,+-]";
        r0 = r39;
        r1 = r34;
        r21 = r0.split(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 0;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r34 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r0 = r0 + 2000;
        r32 = r0;
        r34 = 1;
        r0 = r34;
        r1 = r32;
        r6.set(r0, r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 1;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r34 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r20 = r34 + -1;
        r34 = 2;
        r0 = r34;
        r1 = r20;
        r6.set(r0, r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 2;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r7 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 5;
        r0 = r34;
        r6.set(r0, r7);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 3;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r14 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 10;
        r0 = r34;
        r6.set(r0, r14);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 4;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r17 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 12;
        r0 = r34;
        r1 = r17;
        r6.set(r0, r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 5;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r24 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 13;
        r0 = r34;
        r1 = r24;
        r6.set(r0, r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = 45;
        r0 = r39;
        r1 = r34;
        r34 = r0.indexOf(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = -1;
        r0 = r34;
        r1 = r35;
        if (r0 != r1) goto L_0x0266;
    L_0x00ec:
        r25 = 1;
    L_0x00ee:
        r34 = 6;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r30 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r21;
        r0 = r0.length;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r35 = 8;
        r0 = r34;
        r1 = r35;
        if (r0 < r1) goto L_0x026a;
    L_0x0103:
        r34 = 7;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r8 = java.lang.Integer.parseInt(r34);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x010b:
        if (r25 == 0) goto L_0x026d;
    L_0x010d:
        r34 = 1;
    L_0x010f:
        r34 = r34 * r30;
        r34 = r34 * 15;
        r34 = r34 * 60;
        r0 = r34;
        r0 = r0 * 1000;
        r30 = r0;
        r33 = 0;
        r0 = r21;
        r0 = r0.length;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r35 = 9;
        r0 = r34;
        r1 = r35;
        if (r0 < r1) goto L_0x013a;
    L_0x012a:
        r34 = 8;
        r34 = r21[r34];	 Catch:{ RuntimeException -> 0x0308 }
        r35 = 33;
        r36 = 47;
        r31 = r34.replace(r35, r36);	 Catch:{ RuntimeException -> 0x0308 }
        r33 = java.util.TimeZone.getTimeZone(r31);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x013a:
        r0 = r38;
        r0 = r0.mPhone;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r34 = r34.getContext();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "phone";
        r34 = r34.getSystemService(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = (android.telephony.TelephonyManager) r34;	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mPhone;	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r0;
        r35 = r35.getPhoneId();	 Catch:{ RuntimeException -> 0x0308 }
        r16 = r34.getNetworkCountryIsoForPhone(r35);	 Catch:{ RuntimeException -> 0x0308 }
        if (r33 != 0) goto L_0x0180;
    L_0x015c:
        r0 = r38;
        r0 = r0.mGotCountryCode;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        if (r34 == 0) goto L_0x0180;
    L_0x0164:
        if (r16 == 0) goto L_0x0275;
    L_0x0166:
        r34 = r16.length();	 Catch:{ RuntimeException -> 0x0308 }
        if (r34 <= 0) goto L_0x0275;
    L_0x016c:
        if (r8 == 0) goto L_0x0271;
    L_0x016e:
        r34 = 1;
    L_0x0170:
        r36 = r6.getTimeInMillis();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r30;
        r1 = r34;
        r2 = r36;
        r4 = r16;
        r33 = android.util.TimeUtils.getTimeZone(r0, r1, r2, r4);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x0180:
        if (r33 == 0) goto L_0x019e;
    L_0x0182:
        r0 = r38;
        r0 = r0.mZoneOffset;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r0 = r34;
        r1 = r30;
        if (r0 != r1) goto L_0x019e;
    L_0x018e:
        r0 = r38;
        r0 = r0.mZoneDst;	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r0;
        if (r8 == 0) goto L_0x028e;
    L_0x0196:
        r34 = 1;
    L_0x0198:
        r0 = r35;
        r1 = r34;
        if (r0 == r1) goto L_0x01c0;
    L_0x019e:
        r34 = 1;
        r0 = r34;
        r1 = r38;
        r1.mNeedFixZone = r0;	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r30;
        r1 = r38;
        r1.mZoneOffset = r0;	 Catch:{ RuntimeException -> 0x0308 }
        if (r8 == 0) goto L_0x0292;
    L_0x01ae:
        r34 = 1;
    L_0x01b0:
        r0 = r34;
        r1 = r38;
        r1.mZoneDst = r0;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r6.getTimeInMillis();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r2 = r38;
        r2.mZoneTime = r0;	 Catch:{ RuntimeException -> 0x0308 }
    L_0x01c0:
        r34 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r34.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "NITZ: tzOffset=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r1 = r30;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " dst=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r34 = r0.append(r8);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " zone=";
        r35 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        if (r33 == 0) goto L_0x0296;
    L_0x01e7:
        r34 = r33.getID();	 Catch:{ RuntimeException -> 0x0308 }
    L_0x01eb:
        r0 = r35;
        r1 = r34;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " iso=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r1 = r16;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " mGotCountryCode=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mGotCountryCode;	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r0;
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " mNeedFixZone=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mNeedFixZone;	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r0;
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r34.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        if (r33 == 0) goto L_0x024a;
    L_0x022e:
        r34 = r38.getAutoTimeZone();	 Catch:{ RuntimeException -> 0x0308 }
        if (r34 == 0) goto L_0x023f;
    L_0x0234:
        r34 = r33.getID();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.setAndBroadcastNetworkSetTimeZone(r1);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x023f:
        r34 = r33.getID();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.saveNitzTimeZone(r1);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x024a:
        r34 = "gsm.ignore-nitz";
        r15 = android.os.SystemProperties.get(r34);	 Catch:{ RuntimeException -> 0x0308 }
        if (r15 == 0) goto L_0x029a;
    L_0x0252:
        r34 = "yes";
        r0 = r34;
        r34 = r15.equals(r0);	 Catch:{ RuntimeException -> 0x0308 }
        if (r34 == 0) goto L_0x029a;
    L_0x025c:
        r34 = "NITZ: Not setting clock because gsm.ignore-nitz is set";
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
    L_0x0265:
        return;
    L_0x0266:
        r25 = 0;
        goto L_0x00ee;
    L_0x026a:
        r8 = 0;
        goto L_0x010b;
    L_0x026d:
        r34 = -1;
        goto L_0x010f;
    L_0x0271:
        r34 = 0;
        goto L_0x0170;
    L_0x0275:
        if (r8 == 0) goto L_0x028b;
    L_0x0277:
        r34 = 1;
    L_0x0279:
        r36 = r6.getTimeInMillis();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r30;
        r2 = r34;
        r3 = r36;
        r33 = r0.getNitzTimeZone(r1, r2, r3);	 Catch:{ RuntimeException -> 0x0308 }
        goto L_0x0180;
    L_0x028b:
        r34 = 0;
        goto L_0x0279;
    L_0x028e:
        r34 = 0;
        goto L_0x0198;
    L_0x0292:
        r34 = 0;
        goto L_0x01b0;
    L_0x0296:
        r34 = "NULL";
        goto L_0x01eb;
    L_0x029a:
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ all -> 0x0531 }
        r34 = r0;
        r34.acquire();	 Catch:{ all -> 0x0531 }
        r34 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0531 }
        r18 = r34 - r40;
        r34 = 0;
        r34 = (r18 > r34 ? 1 : (r18 == r34 ? 0 : -1));
        if (r34 >= 0) goto L_0x0335;
    L_0x02af:
        r34 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0531 }
        r34.<init>();	 Catch:{ all -> 0x0531 }
        r35 = "NITZ: not setting time, clock has rolled backwards since NITZ time was received, ";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r1 = r39;
        r34 = r0.append(r1);	 Catch:{ all -> 0x0531 }
        r34 = r34.toString();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ all -> 0x0531 }
        r10 = android.os.SystemClock.elapsedRealtime();	 Catch:{ RuntimeException -> 0x0308 }
        r34 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r34.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "NITZ: end=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r34 = r0.append(r10);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " dur=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = r10 - r26;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r34.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r34.release();	 Catch:{ RuntimeException -> 0x0308 }
        goto L_0x0265;
    L_0x0308:
        r9 = move-exception;
        r34 = new java.lang.StringBuilder;
        r34.<init>();
        r35 = "NITZ: Parsing NITZ time ";
        r34 = r34.append(r35);
        r0 = r34;
        r1 = r39;
        r34 = r0.append(r1);
        r35 = " ex=";
        r34 = r34.append(r35);
        r0 = r34;
        r34 = r0.append(r9);
        r34 = r34.toString();
        r0 = r38;
        r1 = r34;
        r0.loge(r1);
        goto L_0x0265;
    L_0x0335:
        r34 = 2147483647; // 0x7fffffff float:NaN double:1.060997895E-314;
        r34 = (r18 > r34 ? 1 : (r18 == r34 ? 0 : -1));
        if (r34 <= 0) goto L_0x03a0;
    L_0x033c:
        r34 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0531 }
        r34.<init>();	 Catch:{ all -> 0x0531 }
        r35 = "NITZ: not setting time, processing has taken ";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r36 = 86400000; // 0x5265c00 float:7.82218E-36 double:4.2687272E-316;
        r36 = r18 / r36;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);	 Catch:{ all -> 0x0531 }
        r35 = " days";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r34 = r34.toString();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ all -> 0x0531 }
        r10 = android.os.SystemClock.elapsedRealtime();	 Catch:{ RuntimeException -> 0x0308 }
        r34 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r34.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "NITZ: end=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r34 = r0.append(r10);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " dur=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = r10 - r26;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r34.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r34.release();	 Catch:{ RuntimeException -> 0x0308 }
        goto L_0x0265;
    L_0x03a0:
        r34 = 14;
        r0 = r18;
        r0 = (int) r0;
        r35 = r0;
        r0 = r34;
        r1 = r35;
        r6.add(r0, r1);	 Catch:{ all -> 0x0531 }
        r34 = r38.getAutoTime();	 Catch:{ all -> 0x0531 }
        if (r34 == 0) goto L_0x0461;
    L_0x03b4:
        r34 = r6.getTimeInMillis();	 Catch:{ all -> 0x0531 }
        r36 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x0531 }
        r12 = r34 - r36;
        r34 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r0 = r0.mSavedAtTime;	 Catch:{ all -> 0x0531 }
        r36 = r0;
        r28 = r34 - r36;
        r0 = r38;
        r0 = r0.mCr;	 Catch:{ all -> 0x0531 }
        r34 = r0;
        r35 = "nitz_update_spacing";
        r0 = r38;
        r0 = r0.mNitzUpdateSpacing;	 Catch:{ all -> 0x0531 }
        r36 = r0;
        r23 = android.provider.Settings.Global.getInt(r34, r35, r36);	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r0 = r0.mCr;	 Catch:{ all -> 0x0531 }
        r34 = r0;
        r35 = "nitz_update_diff";
        r0 = r38;
        r0 = r0.mNitzUpdateDiff;	 Catch:{ all -> 0x0531 }
        r36 = r0;
        r22 = android.provider.Settings.Global.getInt(r34, r35, r36);	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r0 = r0.mSavedAtTime;	 Catch:{ all -> 0x0531 }
        r34 = r0;
        r36 = 0;
        r34 = (r34 > r36 ? 1 : (r34 == r36 ? 0 : -1));
        if (r34 == 0) goto L_0x0410;
    L_0x03fa:
        r0 = r23;
        r0 = (long) r0;	 Catch:{ all -> 0x0531 }
        r34 = r0;
        r34 = (r28 > r34 ? 1 : (r28 == r34 ? 0 : -1));
        if (r34 > 0) goto L_0x0410;
    L_0x0403:
        r34 = java.lang.Math.abs(r12);	 Catch:{ all -> 0x0531 }
        r0 = r22;
        r0 = (long) r0;	 Catch:{ all -> 0x0531 }
        r36 = r0;
        r34 = (r34 > r36 ? 1 : (r34 == r36 ? 0 : -1));
        if (r34 <= 0) goto L_0x04c6;
    L_0x0410:
        r34 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0531 }
        r34.<init>();	 Catch:{ all -> 0x0531 }
        r35 = "NITZ: Auto updating time of day to ";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r35 = r6.getTime();	 Catch:{ all -> 0x0531 }
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r35 = " NITZ receive delay=";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r1 = r18;
        r34 = r0.append(r1);	 Catch:{ all -> 0x0531 }
        r35 = "ms gained=";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r34 = r0.append(r12);	 Catch:{ all -> 0x0531 }
        r35 = "ms from ";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r1 = r39;
        r34 = r0.append(r1);	 Catch:{ all -> 0x0531 }
        r34 = r34.toString();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ all -> 0x0531 }
        r34 = r6.getTimeInMillis();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r1 = r34;
        r0.setAndBroadcastNetworkSetTime(r1);	 Catch:{ all -> 0x0531 }
    L_0x0461:
        r34 = "NITZ: update nitz time property";
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ all -> 0x0531 }
        r34 = "gsm.nitz.time";
        r36 = r6.getTimeInMillis();	 Catch:{ all -> 0x0531 }
        r35 = java.lang.String.valueOf(r36);	 Catch:{ all -> 0x0531 }
        android.os.SystemProperties.set(r34, r35);	 Catch:{ all -> 0x0531 }
        r34 = r6.getTimeInMillis();	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r2 = r38;
        r2.mSavedTime = r0;	 Catch:{ all -> 0x0531 }
        r34 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r2 = r38;
        r2.mSavedAtTime = r0;	 Catch:{ all -> 0x0531 }
        r10 = android.os.SystemClock.elapsedRealtime();	 Catch:{ RuntimeException -> 0x0308 }
        r34 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r34.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "NITZ: end=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r34 = r0.append(r10);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " dur=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = r10 - r26;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r34.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r34.release();	 Catch:{ RuntimeException -> 0x0308 }
        goto L_0x0265;
    L_0x04c6:
        r34 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0531 }
        r34.<init>();	 Catch:{ all -> 0x0531 }
        r35 = "NITZ: ignore, a previous update was ";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r1 = r28;
        r34 = r0.append(r1);	 Catch:{ all -> 0x0531 }
        r35 = "ms ago and gained=";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r0 = r34;
        r34 = r0.append(r12);	 Catch:{ all -> 0x0531 }
        r35 = "ms";
        r34 = r34.append(r35);	 Catch:{ all -> 0x0531 }
        r34 = r34.toString();	 Catch:{ all -> 0x0531 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ all -> 0x0531 }
        r10 = android.os.SystemClock.elapsedRealtime();	 Catch:{ RuntimeException -> 0x0308 }
        r34 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r34.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = "NITZ: end=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r34;
        r34 = r0.append(r10);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = " dur=";
        r34 = r34.append(r35);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = r10 - r26;
        r0 = r34;
        r1 = r36;
        r34 = r0.append(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r34.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r34;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ RuntimeException -> 0x0308 }
        r34 = r0;
        r34.release();	 Catch:{ RuntimeException -> 0x0308 }
        goto L_0x0265;
    L_0x0531:
        r34 = move-exception;
        r10 = android.os.SystemClock.elapsedRealtime();	 Catch:{ RuntimeException -> 0x0308 }
        r35 = new java.lang.StringBuilder;	 Catch:{ RuntimeException -> 0x0308 }
        r35.<init>();	 Catch:{ RuntimeException -> 0x0308 }
        r36 = "NITZ: end=";
        r35 = r35.append(r36);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r35;
        r35 = r0.append(r10);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = " dur=";
        r35 = r35.append(r36);	 Catch:{ RuntimeException -> 0x0308 }
        r36 = r10 - r26;
        r35 = r35.append(r36);	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r35.toString();	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r1 = r35;
        r0.log(r1);	 Catch:{ RuntimeException -> 0x0308 }
        r0 = r38;
        r0 = r0.mWakeLock;	 Catch:{ RuntimeException -> 0x0308 }
        r35 = r0;
        r35.release();	 Catch:{ RuntimeException -> 0x0308 }
        throw r34;	 Catch:{ RuntimeException -> 0x0308 }
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.cdma.CdmaServiceStateTracker.setTimeFromNITZString(java.lang.String, long):void");
    }

    private boolean getAutoTime() {
        try {
            return Global.getInt(this.mCr, "auto_time") > 0;
        } catch (SettingNotFoundException e) {
            return true;
        }
    }

    private boolean getAutoTimeZone() {
        try {
            return Global.getInt(this.mCr, "auto_time_zone") > 0;
        } catch (SettingNotFoundException e) {
            return true;
        }
    }

    private void saveNitzTimeZone(String zoneId) {
        this.mSavedTimeZone = zoneId;
    }

    private void setAndBroadcastNetworkSetTimeZone(String zoneId) {
        log("setAndBroadcastNetworkSetTimeZone: setTimeZone=" + zoneId);
        ((AlarmManager) this.mPhone.getContext().getSystemService("alarm")).setTimeZone(zoneId);
        Intent intent = new Intent("android.intent.action.NETWORK_SET_TIMEZONE");
        intent.addFlags(536870912);
        intent.putExtra("time-zone", zoneId);
        this.mPhone.getContext().sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void setAndBroadcastNetworkSetTime(long time) {
        log("setAndBroadcastNetworkSetTime: time=" + time + "ms");
        SystemClock.setCurrentTimeMillis(time);
        Intent intent = new Intent("android.intent.action.NETWORK_SET_TIME");
        intent.addFlags(536870912);
        intent.putExtra("time", time);
        this.mPhone.getContext().sendStickyBroadcastAsUser(intent, UserHandle.ALL);
    }

    private void revertToNitzTime() {
        if (Global.getInt(this.mCr, "auto_time", 0) != 0) {
            log("revertToNitzTime: mSavedTime=" + this.mSavedTime + " mSavedAtTime=" + this.mSavedAtTime);
            if (this.mSavedTime != 0 && this.mSavedAtTime != 0) {
                setAndBroadcastNetworkSetTime(this.mSavedTime + (SystemClock.elapsedRealtime() - this.mSavedAtTime));
            }
        }
    }

    private void revertToNitzTimeZone() {
        if (Global.getInt(this.mPhone.getContext().getContentResolver(), "auto_time_zone", 0) != 0) {
            log("revertToNitzTimeZone: tz='" + this.mSavedTimeZone);
            if (this.mSavedTimeZone != null) {
                setAndBroadcastNetworkSetTimeZone(this.mSavedTimeZone);
            }
        }
    }

    protected boolean isSidsAllZeros() {
        if (this.mHomeSystemId != null) {
            for (int i : this.mHomeSystemId) {
                if (i != 0) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean isHomeSid(int sid) {
        if (this.mHomeSystemId != null) {
            for (int i : this.mHomeSystemId) {
                if (sid == i) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean isConcurrentVoiceAndDataAllowed() {
        return false;
    }

    public String getMdnNumber() {
        return this.mMdn;
    }

    public String getCdmaMin() {
        return this.mMin;
    }

    public String getPrlVersion() {
        return this.mPrlVersion;
    }

    String getImsi() {
        String operatorNumeric = ((TelephonyManager) this.mPhone.getContext().getSystemService("phone")).getSimOperatorNumericForPhone(this.mPhoneBase.getPhoneId());
        if (TextUtils.isEmpty(operatorNumeric) || getCdmaMin() == null) {
            return null;
        }
        return operatorNumeric + getCdmaMin();
    }

    public boolean isMinInfoReady() {
        return this.mIsMinInfoReady;
    }

    int getOtasp() {
        if (this.mIsSubscriptionFromRuim && this.mMin == null) {
            return 2;
        }
        int provisioningState;
        if (this.mMin == null || this.mMin.length() < 6) {
            log("getOtasp: bad mMin='" + this.mMin + "'");
            provisioningState = 1;
        } else if (this.mMin.equals(UNACTIVATED_MIN_VALUE) || this.mMin.substring(0, 6).equals(UNACTIVATED_MIN2_VALUE) || SystemProperties.getBoolean("test_cdma_setup", false)) {
            provisioningState = 2;
        } else {
            provisioningState = 3;
        }
        log("getOtasp: state=" + provisioningState);
        return provisioningState;
    }

    protected void hangupAndPowerOff() {
        this.mPhone.mCT.mRingingCall.hangupIfAlive();
        this.mPhone.mCT.mBackgroundCall.hangupIfAlive();
        this.mPhone.mCT.mForegroundCall.hangupIfAlive();
        this.mCi.setRadioPower(false, null);
    }

    protected void parseSidNid(String sidStr, String nidStr) {
        int i;
        if (sidStr != null) {
            String[] sid = sidStr.split(",");
            this.mHomeSystemId = new int[sid.length];
            for (i = 0; i < sid.length; i++) {
                try {
                    this.mHomeSystemId[i] = Integer.parseInt(sid[i]);
                } catch (NumberFormatException ex) {
                    loge("error parsing system id: " + ex);
                }
            }
        }
        log("CDMA_SUBSCRIPTION: SID=" + sidStr);
        if (nidStr != null) {
            String[] nid = nidStr.split(",");
            this.mHomeNetworkId = new int[nid.length];
            for (i = 0; i < nid.length; i++) {
                try {
                    this.mHomeNetworkId[i] = Integer.parseInt(nid[i]);
                } catch (NumberFormatException ex2) {
                    loge("CDMA_SUBSCRIPTION: error parsing network id: " + ex2);
                }
            }
        }
        log("CDMA_SUBSCRIPTION: NID=" + nidStr);
    }

    protected void updateOtaspState() {
        int otaspMode = getOtasp();
        int oldOtaspMode = this.mCurrentOtaspMode;
        this.mCurrentOtaspMode = otaspMode;
        if (this.mCdmaForSubscriptionInfoReadyRegistrants != null) {
            log("CDMA_SUBSCRIPTION: call notifyRegistrants()");
            this.mCdmaForSubscriptionInfoReadyRegistrants.notifyRegistrants();
        }
        if (oldOtaspMode != this.mCurrentOtaspMode) {
            log("CDMA_SUBSCRIPTION: call notifyOtaspChanged old otaspMode=" + oldOtaspMode + " new otaspMode=" + this.mCurrentOtaspMode);
            this.mPhone.notifyOtaspChanged(this.mCurrentOtaspMode);
        }
    }

    protected UiccCardApplication getUiccCardApplication() {
        return this.mUiccController.getUiccCardApplication(this.mPhone.getPhoneId(), 2);
    }

    protected void onUpdateIccAvailability() {
        if (this.mUiccController != null) {
            UiccCardApplication newUiccApplication = getUiccCardApplication();
            if (this.mUiccApplcation != newUiccApplication) {
                if (this.mUiccApplcation != null) {
                    log("Removing stale icc objects.");
                    this.mUiccApplcation.unregisterForReady(this);
                    if (this.mIccRecords != null) {
                        this.mIccRecords.unregisterForRecordsLoaded(this);
                    }
                    this.mIccRecords = null;
                    this.mUiccApplcation = null;
                }
                if (newUiccApplication != null) {
                    log("New card found");
                    this.mUiccApplcation = newUiccApplication;
                    this.mIccRecords = this.mUiccApplcation.getIccRecords();
                    if (this.mIsSubscriptionFromRuim) {
                        this.mUiccApplcation.registerForReady(this, 26, null);
                        if (this.mIccRecords != null) {
                            this.mIccRecords.registerForRecordsLoaded(this, 27, null);
                        }
                    }
                }
            }
        }
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, "[CdmaSST] " + s);
    }

    protected void loge(String s) {
        Rlog.e(LOG_TAG, "[CdmaSST] " + s);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("CdmaServiceStateTracker extends:");
        super.dump(fd, pw, args);
        pw.flush();
        pw.println(" mPhone=" + this.mPhone);
        pw.println(" mSS=" + this.mSS);
        pw.println(" mNewSS=" + this.mNewSS);
        pw.println(" mCellLoc=" + this.mCellLoc);
        pw.println(" mNewCellLoc=" + this.mNewCellLoc);
        pw.println(" mCurrentOtaspMode=" + this.mCurrentOtaspMode);
        pw.println(" mRoamingIndicator=" + this.mRoamingIndicator);
        pw.println(" mIsInPrl=" + this.mIsInPrl);
        pw.println(" mDefaultRoamingIndicator=" + this.mDefaultRoamingIndicator);
        pw.println(" mRegistrationState=" + this.mRegistrationState);
        pw.println(" mNeedFixZone=" + this.mNeedFixZone);
        pw.flush();
        pw.println(" mZoneOffset=" + this.mZoneOffset);
        pw.println(" mZoneDst=" + this.mZoneDst);
        pw.println(" mZoneTime=" + this.mZoneTime);
        pw.println(" mGotCountryCode=" + this.mGotCountryCode);
        pw.println(" mSavedTimeZone=" + this.mSavedTimeZone);
        pw.println(" mSavedTime=" + this.mSavedTime);
        pw.println(" mSavedAtTime=" + this.mSavedAtTime);
        pw.println(" mWakeLock=" + this.mWakeLock);
        pw.println(" mCurPlmn=" + this.mCurPlmn);
        pw.println(" mMdn=" + this.mMdn);
        pw.println(" mHomeSystemId=" + this.mHomeSystemId);
        pw.println(" mHomeNetworkId=" + this.mHomeNetworkId);
        pw.println(" mMin=" + this.mMin);
        pw.println(" mPrlVersion=" + this.mPrlVersion);
        pw.println(" mIsMinInfoReady=" + this.mIsMinInfoReady);
        pw.println(" mIsEriTextLoaded=" + this.mIsEriTextLoaded);
        pw.println(" mIsSubscriptionFromRuim=" + this.mIsSubscriptionFromRuim);
        pw.println(" mCdmaSSM=" + this.mCdmaSSM);
        pw.println(" mRegistrationDeniedReason=" + this.mRegistrationDeniedReason);
        pw.println(" mCurrentCarrier=" + this.mCurrentCarrier);
        pw.flush();
    }

    public void setImsRegistrationState(boolean registered) {
        log("ImsRegistrationState - registered : " + registered);
        if (this.mImsRegistrationOnOff && !registered && this.mAlarmSwitch) {
            this.mImsRegistrationOnOff = registered;
            ((AlarmManager) this.mPhone.getContext().getSystemService("alarm")).cancel(this.mRadioOffIntent);
            this.mAlarmSwitch = false;
            sendMessage(obtainMessage(45));
            return;
        }
        this.mImsRegistrationOnOff = registered;
    }
}
