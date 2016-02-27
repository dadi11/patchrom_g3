package com.android.internal.telephony.cdma;

import android.os.AsyncResult;
import android.os.Message;
import android.os.SystemClock;
import android.telephony.CellIdentityLte;
import android.telephony.CellInfo;
import android.telephony.CellInfoLte;
import android.telephony.CellSignalStrengthLte;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import com.android.internal.telephony.CommandsInterface.RadioState;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.ProxyController;
import com.android.internal.telephony.dataconnection.DcTrackerBase;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.RuimRecords;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class CdmaLteServiceStateTracker extends CdmaServiceStateTracker {
    private static final int EVENT_ALL_DATA_DISCONNECTED = 1001;
    private CDMALTEPhone mCdmaLtePhone;
    private final CellInfoLte mCellInfoLte;
    private CellIdentityLte mLasteCellIdentityLte;
    private CellIdentityLte mNewCellIdentityLte;
    protected int mNewRilRadioTechnology;

    /* renamed from: com.android.internal.telephony.cdma.CdmaLteServiceStateTracker.1 */
    static /* synthetic */ class C00441 {
        static final /* synthetic */ int[] f6x46dd5024;

        static {
            f6x46dd5024 = new int[RadioState.values().length];
            try {
                f6x46dd5024[RadioState.RADIO_UNAVAILABLE.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f6x46dd5024[RadioState.RADIO_OFF.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
        }
    }

    public CdmaLteServiceStateTracker(CDMALTEPhone phone) {
        super(phone, new CellInfoLte());
        this.mNewRilRadioTechnology = 0;
        this.mNewCellIdentityLte = new CellIdentityLte();
        this.mLasteCellIdentityLte = new CellIdentityLte();
        this.mCdmaLtePhone = phone;
        this.mCdmaLtePhone.registerForSimRecordsLoaded(this, 16, null);
        this.mCellInfoLte = (CellInfoLte) this.mCellInfo;
        ((CellInfoLte) this.mCellInfo).setCellSignalStrength(new CellSignalStrengthLte());
        ((CellInfoLte) this.mCellInfo).setCellIdentity(new CellIdentityLte());
        log("CdmaLteServiceStateTracker Constructors");
    }

    public void dispose() {
        this.mPhone.unregisterForSimRecordsLoaded(this);
        super.dispose();
    }

    public void handleMessage(Message msg) {
        if (this.mPhone.mIsTheCurrentActivePhone) {
            log("handleMessage: " + msg.what);
            switch (msg.what) {
                case CharacterSets.ISO_8859_2 /*5*/:
                    log("handleMessage EVENT_POLL_STATE_GPRS");
                    handlePollStateResult(msg.what, msg.obj);
                    return;
                case PduHeaders.MMS_VERSION_1_0 /*16*/:
                    updatePhoneObject();
                    return;
                case 27:
                    updatePhoneObject();
                    RuimRecords ruim = this.mIccRecords;
                    if (ruim != null) {
                        if (ruim.isProvisioned()) {
                            this.mMdn = ruim.getMdn();
                            this.mMin = ruim.getMin();
                            parseSidNid(ruim.getSid(), ruim.getNid());
                            this.mPrlVersion = ruim.getPrlVersion();
                            this.mIsMinInfoReady = true;
                        }
                        updateOtaspState();
                    }
                    this.mPhone.prepareEri();
                    pollState();
                    return;
                case EVENT_ALL_DATA_DISCONNECTED /*1001*/:
                    ProxyController.getInstance().unregisterForAllDataDisconnected(SubscriptionManager.getDefaultDataSubId(), this);
                    synchronized (this) {
                        if (!this.mPendingRadioPowerOffAfterDataOff) {
                            log("EVENT_ALL_DATA_DISCONNECTED is stale");
                            break;
                        }
                        log("EVENT_ALL_DATA_DISCONNECTED, turn radio off now.");
                        hangupAndPowerOff();
                        this.mPendingRadioPowerOffAfterDataOff = false;
                        break;
                    }
                    return;
                default:
                    super.handleMessage(msg);
                    return;
            }
        }
        loge("Received message " + msg + "[" + msg.what + "]" + " while being destroyed. Ignoring.");
    }

    protected void handlePollStateResultMessage(int what, AsyncResult ar) {
        if (what == 5) {
            String[] states = (String[]) ar.result;
            log("handlePollStateResultMessage: EVENT_POLL_STATE_GPRS states.length=" + states.length + " states=" + states);
            int type = 0;
            int regState = -1;
            if (states.length > 0) {
                try {
                    regState = Integer.parseInt(states[0]);
                    if (states.length >= 4 && states[3] != null) {
                        type = Integer.parseInt(states[3]);
                    }
                } catch (NumberFormatException ex) {
                    loge("handlePollStateResultMessage: error parsing GprsRegistrationState: " + ex);
                }
                if (states.length >= 10) {
                    int mcc;
                    int mnc;
                    int tac;
                    int pci;
                    int eci;
                    String str = null;
                    try {
                        str = this.mNewSS.getOperatorNumeric();
                        mcc = Integer.parseInt(str.substring(0, 3));
                    } catch (Exception e) {
                        try {
                            str = this.mSS.getOperatorNumeric();
                            mcc = Integer.parseInt(str.substring(0, 3));
                        } catch (Exception ex2) {
                            loge("handlePollStateResultMessage: bad mcc operatorNumeric=" + str + " ex=" + ex2);
                            str = "";
                            mcc = Integer.MAX_VALUE;
                        }
                    }
                    try {
                        mnc = Integer.parseInt(str.substring(3));
                    } catch (Exception e2) {
                        loge("handlePollStateResultMessage: bad mnc operatorNumeric=" + str + " e=" + e2);
                        mnc = Integer.MAX_VALUE;
                    }
                    try {
                        tac = Integer.decode(states[6]).intValue();
                    } catch (Exception e22) {
                        loge("handlePollStateResultMessage: bad tac states[6]=" + states[6] + " e=" + e22);
                        tac = Integer.MAX_VALUE;
                    }
                    try {
                        pci = Integer.decode(states[7]).intValue();
                    } catch (Exception e222) {
                        loge("handlePollStateResultMessage: bad pci states[7]=" + states[7] + " e=" + e222);
                        pci = Integer.MAX_VALUE;
                    }
                    try {
                        eci = Integer.decode(states[8]).intValue();
                    } catch (Exception e2222) {
                        loge("handlePollStateResultMessage: bad eci states[8]=" + states[8] + " e=" + e2222);
                        eci = Integer.MAX_VALUE;
                    }
                    try {
                        int csgid = Integer.decode(states[9]).intValue();
                    } catch (Exception e3) {
                    }
                    this.mNewCellIdentityLte = new CellIdentityLte(mcc, mnc, eci, pci, tac);
                    log("handlePollStateResultMessage: mNewLteCellIdentity=" + this.mNewCellIdentityLte);
                }
            }
            this.mNewSS.setRilDataRadioTechnology(type);
            int dataRegState = regCodeToServiceState(regState);
            this.mNewSS.setDataRegState(dataRegState);
            this.mNewSS.setDataRoaming(regCodeIsRoaming(regState));
            log("handlPollStateResultMessage: CdmaLteSST setDataRegState=" + dataRegState + " regState=" + regState + " dataRadioTechnology=" + type);
            return;
        }
        super.handlePollStateResultMessage(what, ar);
    }

    public void pollState() {
        this.mPollingContext = new int[1];
        this.mPollingContext[0] = 0;
        switch (C00441.f6x46dd5024[this.mCi.getRadioState().ordinal()]) {
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

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void pollStateDone() {
        /*
        r48 = this;
        r0 = r48;
        r0 = r0.mCi;
        r42 = r0;
        r43 = "usevoicetechfordata";
        r31 = r42.needsOldRilFeature(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 == 0) goto L_0x0084;
    L_0x0018:
        if (r31 == 0) goto L_0x0084;
    L_0x001a:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilVoiceRadioTechnology();
        r0 = r42;
        r1 = r48;
        r1.mNewRilRadioTechnology = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewRilRadioTechnology;
        r43 = r0;
        r0 = r48;
        r1 = r43;
        r43 = r0.radioTechnologyToDataServiceState(r1);
        r42.setDataRegState(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewRilRadioTechnology;
        r43 = r0;
        r42.setRilDataRadioTechnology(r43);
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "pollStateDone CDMA STATE_IN_SERVICE mNewRilRadioTechnology = ";
        r42 = r42.append(r43);
        r0 = r48;
        r0 = r0.mNewRilRadioTechnology;
        r43 = r0;
        r42 = r42.append(r43);
        r43 = " mNewSS.getDataRegState() = ";
        r42 = r42.append(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getDataRegState();
        r42 = r42.append(r43);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.log(r1);
    L_0x0084:
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "pollStateDone: lte 1 ss=[";
        r42 = r42.append(r43);
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r42 = r42.append(r43);
        r43 = "] newSS=[";
        r42 = r42.append(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r42 = r42.append(r43);
        r43 = "]";
        r42 = r42.append(r43);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getOperatorNumeric();
        r42 = r42.isMccMncMarkedAsNonRoaming(r43);
        if (r42 != 0) goto L_0x00e6;
    L_0x00d0:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getSystemId();
        r42 = r42.isSidMarkedAsNonRoaming(r43);
        if (r42 == 0) goto L_0x0899;
    L_0x00e6:
        r42 = "pollStateDone: override - marked as non-roaming.";
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 0;
        r42.setVoiceRoaming(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 0;
        r42.setDataRoaming(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 1;
        r42.setCdmaEriIconIndex(r43);
    L_0x0110:
        r42 = android.os.Build.IS_DEBUGGABLE;
        if (r42 == 0) goto L_0x0134;
    L_0x0114:
        r42 = "telephony.test.forceRoaming";
        r43 = 0;
        r42 = android.os.SystemProperties.getBoolean(r42, r43);
        if (r42 == 0) goto L_0x0134;
    L_0x011e:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 1;
        r42.setVoiceRoaming(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 1;
        r42.setDataRoaming(r43);
    L_0x0134:
        r48.useDataRegStateForDataOnlyDevices();
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 == 0) goto L_0x08fc;
    L_0x0143:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 != 0) goto L_0x08fc;
    L_0x014f:
        r24 = 1;
    L_0x0151:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 != 0) goto L_0x0900;
    L_0x015d:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 == 0) goto L_0x0900;
    L_0x0169:
        r20 = 1;
    L_0x016b:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 == 0) goto L_0x0904;
    L_0x0177:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 != 0) goto L_0x0904;
    L_0x0183:
        r13 = 1;
    L_0x0184:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 != 0) goto L_0x0907;
    L_0x0190:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 == 0) goto L_0x0907;
    L_0x019c:
        r15 = 1;
    L_0x019d:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getDataRegState();
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x090a;
    L_0x01b7:
        r14 = 1;
    L_0x01b8:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilVoiceRadioTechnology();
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getRilVoiceRadioTechnology();
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x090d;
    L_0x01d2:
        r25 = 1;
    L_0x01d4:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getRilDataRadioTechnology();
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x0911;
    L_0x01ee:
        r17 = 1;
    L_0x01f0:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r42 = r42.equals(r43);
        if (r42 != 0) goto L_0x0915;
    L_0x0202:
        r16 = 1;
    L_0x0204:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRoaming();
        if (r42 != 0) goto L_0x0919;
    L_0x0210:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getVoiceRoaming();
        if (r42 == 0) goto L_0x0919;
    L_0x021c:
        r27 = 1;
    L_0x021e:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRoaming();
        if (r42 == 0) goto L_0x091d;
    L_0x022a:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getVoiceRoaming();
        if (r42 != 0) goto L_0x091d;
    L_0x0236:
        r26 = 1;
    L_0x0238:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRoaming();
        if (r42 != 0) goto L_0x0921;
    L_0x0244:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRoaming();
        if (r42 == 0) goto L_0x0921;
    L_0x0250:
        r19 = 1;
    L_0x0252:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRoaming();
        if (r42 == 0) goto L_0x0925;
    L_0x025e:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRoaming();
        if (r42 != 0) goto L_0x0925;
    L_0x026a:
        r18 = 1;
    L_0x026c:
        r0 = r48;
        r0 = r0.mNewCellLoc;
        r42 = r0;
        r0 = r48;
        r0 = r0.mCellLoc;
        r43 = r0;
        r42 = r42.equals(r43);
        if (r42 != 0) goto L_0x0929;
    L_0x027e:
        r21 = 1;
    L_0x0280:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 != 0) goto L_0x092d;
    L_0x028c:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 14;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x02b0;
    L_0x029e:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 13;
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x02d4;
    L_0x02b0:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 13;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x092d;
    L_0x02c2:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 14;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x092d;
    L_0x02d4:
        r11 = 1;
    L_0x02d5:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 14;
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x02f9;
    L_0x02e7:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 13;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x0930;
    L_0x02f9:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 14;
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x0930;
    L_0x030b:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 13;
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x0930;
    L_0x031d:
        r23 = 1;
    L_0x031f:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 4;
        r0 = r42;
        r1 = r43;
        if (r0 < r1) goto L_0x0934;
    L_0x0331:
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42 = r42.getRilDataRadioTechnology();
        r43 = 8;
        r0 = r42;
        r1 = r43;
        if (r0 > r1) goto L_0x0934;
    L_0x0343:
        r22 = 1;
    L_0x0345:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getContext();
        r43 = "phone";
        r40 = r42.getSystemService(r43);
        r40 = (android.telephony.TelephonyManager) r40;
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "pollStateDone: hasRegistered=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r24;
        r42 = r0.append(r1);
        r43 = " hasDeegistered=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r20;
        r42 = r0.append(r1);
        r43 = " hasCdmaDataConnectionAttached=";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r13);
        r43 = " hasCdmaDataConnectionDetached=";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r15);
        r43 = " hasCdmaDataConnectionChanged=";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r14);
        r43 = " hasVoiceRadioTechnologyChanged= ";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r25;
        r42 = r0.append(r1);
        r43 = " hasDataRadioTechnologyChanged=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r17;
        r42 = r0.append(r1);
        r43 = " hasChanged=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r16;
        r42 = r0.append(r1);
        r43 = " hasVoiceRoamingOn=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r27;
        r42 = r0.append(r1);
        r43 = " hasVoiceRoamingOff=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r26;
        r42 = r0.append(r1);
        r43 = " hasDataRoamingOn=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r19;
        r42 = r0.append(r1);
        r43 = " hasDataRoamingOff=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r18;
        r42 = r0.append(r1);
        r43 = " hasLocationChanged=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r21;
        r42 = r0.append(r1);
        r43 = " has4gHandoff = ";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r11);
        r43 = " hasMultiApnSupport=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r23;
        r42 = r0.append(r1);
        r43 = " hasLostMultiApnSupport=";
        r42 = r42.append(r43);
        r0 = r42;
        r1 = r22;
        r42 = r0.append(r1);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getVoiceRegState();
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x0473;
    L_0x0459:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getDataRegState();
        r0 = r42;
        r1 = r43;
        if (r0 == r1) goto L_0x04c9;
    L_0x0473:
        r42 = 50116; // 0xc3c4 float:7.0227E-41 double:2.47606E-319;
        r43 = 4;
        r0 = r43;
        r0 = new java.lang.Object[r0];
        r43 = r0;
        r44 = 0;
        r0 = r48;
        r0 = r0.mSS;
        r45 = r0;
        r45 = r45.getVoiceRegState();
        r45 = java.lang.Integer.valueOf(r45);
        r43[r44] = r45;
        r44 = 1;
        r0 = r48;
        r0 = r0.mSS;
        r45 = r0;
        r45 = r45.getDataRegState();
        r45 = java.lang.Integer.valueOf(r45);
        r43[r44] = r45;
        r44 = 2;
        r0 = r48;
        r0 = r0.mNewSS;
        r45 = r0;
        r45 = r45.getVoiceRegState();
        r45 = java.lang.Integer.valueOf(r45);
        r43[r44] = r45;
        r44 = 3;
        r0 = r48;
        r0 = r0.mNewSS;
        r45 = r0;
        r45 = r45.getDataRegState();
        r45 = java.lang.Integer.valueOf(r45);
        r43[r44] = r45;
        android.util.EventLog.writeEvent(r42, r43);
    L_0x04c9:
        r0 = r48;
        r0 = r0.mSS;
        r41 = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r0 = r42;
        r1 = r48;
        r1.mSS = r0;
        r0 = r41;
        r1 = r48;
        r1.mNewSS = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42.setStateOutOfService();
        r0 = r48;
        r0 = r0.mCellLoc;
        r37 = r0;
        r0 = r48;
        r0 = r0.mNewCellLoc;
        r42 = r0;
        r0 = r42;
        r1 = r48;
        r1.mCellLoc = r0;
        r0 = r37;
        r1 = r48;
        r1.mNewCellLoc = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r42.setStateOutOfService();
        if (r25 == 0) goto L_0x0510;
    L_0x050d:
        r48.updatePhoneObject();
    L_0x0510:
        if (r17 == 0) goto L_0x052f;
    L_0x0512:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r43 = r43.getRilDataRadioTechnology();
        r0 = r40;
        r1 = r42;
        r2 = r43;
        r0.setDataNetworkTypeForPhone(r1, r2);
    L_0x052f:
        if (r24 == 0) goto L_0x053a;
    L_0x0531:
        r0 = r48;
        r0 = r0.mNetworkAttachedRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x053a:
        if (r16 == 0) goto L_0x0763;
    L_0x053c:
        r0 = r48;
        r0 = r0.mUiccController;
        r42 = r0;
        r43 = r48.getPhoneId();
        r42 = r42.getUiccCard(r43);
        if (r42 != 0) goto L_0x0938;
    L_0x054c:
        r12 = 0;
    L_0x054d:
        if (r12 != 0) goto L_0x05bf;
    L_0x054f:
        r0 = r48;
        r0 = r0.mCi;
        r42 = r0;
        r42 = r42.getRadioState();
        r42 = r42.isOn();
        if (r42 == 0) goto L_0x05bf;
    L_0x055f:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.isEriFileLoaded();
        if (r42 == 0) goto L_0x05bf;
    L_0x056b:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getRilVoiceRadioTechnology();
        r43 = 14;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x0594;
    L_0x057d:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getContext();
        r42 = r42.getResources();
        r43 = 17957013; // 0x1120095 float:2.6816382E-38 double:8.871943E-317;
        r42 = r42.getBoolean(r43);
        if (r42 == 0) goto L_0x05bf;
    L_0x0594:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r9 = r42.getOperatorAlphaLong();
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 != 0) goto L_0x0952;
    L_0x05aa:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r9 = r42.getCdmaEriText();
    L_0x05b4:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r0 = r42;
        r0.setOperatorAlphaLong(r9);
    L_0x05bf:
        r0 = r48;
        r0 = r0.mUiccApplcation;
        r42 = r0;
        if (r42 == 0) goto L_0x0648;
    L_0x05c7:
        r0 = r48;
        r0 = r0.mUiccApplcation;
        r42 = r0;
        r42 = r42.getState();
        r43 = com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState.APPSTATE_READY;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x0648;
    L_0x05d9:
        r0 = r48;
        r0 = r0.mIccRecords;
        r42 = r0;
        if (r42 == 0) goto L_0x0648;
    L_0x05e1:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        if (r42 != 0) goto L_0x0648;
    L_0x05ed:
        r0 = r48;
        r0 = r0.mIccRecords;
        r42 = r0;
        r42 = (com.android.internal.telephony.uicc.RuimRecords) r42;
        r35 = r42.getCsimSpnDisplayCondition();
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r28 = r42.getCdmaEriIconIndex();
        if (r35 == 0) goto L_0x0648;
    L_0x0605:
        r42 = 1;
        r0 = r28;
        r1 = r42;
        if (r0 != r1) goto L_0x0648;
    L_0x060d:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getSystemId();
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r43 = r43.getNetworkId();
        r0 = r48;
        r1 = r42;
        r2 = r43;
        r42 = r0.isInHomeSidNid(r1, r2);
        if (r42 == 0) goto L_0x0648;
    L_0x062d:
        r0 = r48;
        r0 = r0.mIccRecords;
        r42 = r0;
        if (r42 == 0) goto L_0x0648;
    L_0x0635:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r0 = r48;
        r0 = r0.mIccRecords;
        r43 = r0;
        r43 = r43.getServiceProviderName();
        r42.setOperatorAlphaLong(r43);
    L_0x0648:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r43 = r43.getOperatorAlphaLong();
        r0 = r40;
        r1 = r42;
        r2 = r43;
        r0.setNetworkOperatorNameForPhone(r1, r2);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r0 = r40;
        r1 = r42;
        r33 = r0.getNetworkOperatorForPhone(r1);
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r32 = r42.getOperatorNumeric();
        r0 = r48;
        r1 = r32;
        r42 = r0.isInvalidOperatorNumeric(r1);
        if (r42 == 0) goto L_0x069f;
    L_0x068b:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r36 = r42.getSystemId();
        r0 = r48;
        r1 = r32;
        r2 = r36;
        r32 = r0.fixUnknownMcc(r1, r2);
    L_0x069f:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r0 = r40;
        r1 = r42;
        r2 = r32;
        r0.setNetworkOperatorNumericForPhone(r1, r2);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getContext();
        r0 = r48;
        r1 = r32;
        r2 = r33;
        r3 = r42;
        r0.updateCarrierMccMncConfiguration(r1, r2, r3);
        r0 = r48;
        r1 = r32;
        r42 = r0.isInvalidOperatorNumeric(r1);
        if (r42 == 0) goto L_0x09a9;
    L_0x06d1:
        r42 = "operatorNumeric is null";
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r43 = "";
        r0 = r40;
        r1 = r42;
        r2 = r43;
        r0.setNetworkCountryIsoForPhone(r1, r2);
        r42 = 0;
        r0 = r42;
        r1 = r48;
        r1.mGotCountryCode = r0;
    L_0x06f7:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r43 = r42.getPhoneId();
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRoaming();
        if (r42 != 0) goto L_0x0719;
    L_0x070d:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRoaming();
        if (r42 == 0) goto L_0x0a53;
    L_0x0719:
        r42 = 1;
    L_0x071b:
        r0 = r40;
        r1 = r43;
        r2 = r42;
        r0.setNetworkRoamingForPhone(r1, r2);
        r48.updateSpnDisplay();
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r0 = r48;
        r1 = r42;
        r0.setRoamingType(r1);
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "Broadcasting ServiceState : ";
        r42 = r42.append(r43);
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r42 = r42.append(r43);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mSS;
        r43 = r0;
        r42.notifyServiceStateChanged(r43);
    L_0x0763:
        if (r13 != 0) goto L_0x0767;
    L_0x0765:
        if (r11 == 0) goto L_0x0770;
    L_0x0767:
        r0 = r48;
        r0 = r0.mAttachedRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x0770:
        if (r15 == 0) goto L_0x077b;
    L_0x0772:
        r0 = r48;
        r0 = r0.mDetachedRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x077b:
        if (r14 != 0) goto L_0x077f;
    L_0x077d:
        if (r17 == 0) goto L_0x078d;
    L_0x077f:
        r48.notifyDataRegStateRilRadioTechnologyChanged();
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r43 = 0;
        r42.notifyDataConnection(r43);
    L_0x078d:
        if (r27 == 0) goto L_0x0798;
    L_0x078f:
        r0 = r48;
        r0 = r0.mVoiceRoamingOnRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x0798:
        if (r26 == 0) goto L_0x07a3;
    L_0x079a:
        r0 = r48;
        r0 = r0.mVoiceRoamingOffRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x07a3:
        if (r19 == 0) goto L_0x07ae;
    L_0x07a5:
        r0 = r48;
        r0 = r0.mDataRoamingOnRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x07ae:
        if (r18 == 0) goto L_0x07b9;
    L_0x07b0:
        r0 = r48;
        r0 = r0.mDataRoamingOffRegistrants;
        r42 = r0;
        r42.notifyRegistrants();
    L_0x07b9:
        if (r21 == 0) goto L_0x07c4;
    L_0x07bb:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42.notifyLocationChanged();
    L_0x07c4:
        r6 = new java.util.ArrayList;
        r6.<init>();
        r0 = r48;
        r0 = r0.mCellInfo;
        r43 = r0;
        monitor-enter(r43);
        r0 = r48;
        r8 = r0.mCellInfo;	 Catch:{ all -> 0x0a5e }
        r8 = (android.telephony.CellInfoLte) r8;	 Catch:{ all -> 0x0a5e }
        r0 = r48;
        r0 = r0.mNewCellIdentityLte;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r0 = r48;
        r0 = r0.mLasteCellIdentityLte;	 Catch:{ all -> 0x0a5e }
        r44 = r0;
        r0 = r42;
        r1 = r44;
        r42 = r0.equals(r1);	 Catch:{ all -> 0x0a5e }
        if (r42 != 0) goto L_0x0a57;
    L_0x07ec:
        r7 = 1;
    L_0x07ed:
        if (r24 != 0) goto L_0x07f3;
    L_0x07ef:
        if (r20 != 0) goto L_0x07f3;
    L_0x07f1:
        if (r7 == 0) goto L_0x088c;
    L_0x07f3:
        r44 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0a5e }
        r46 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r38 = r44 * r46;
        r0 = r48;
        r0 = r0.mSS;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r42 = r42.getVoiceRegState();	 Catch:{ all -> 0x0a5e }
        if (r42 != 0) goto L_0x0a5a;
    L_0x0807:
        r34 = 1;
    L_0x0809:
        r0 = r48;
        r0 = r0.mNewCellIdentityLte;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r0 = r42;
        r1 = r48;
        r1.mLasteCellIdentityLte = r0;	 Catch:{ all -> 0x0a5e }
        r0 = r34;
        r8.setRegistered(r0);	 Catch:{ all -> 0x0a5e }
        r0 = r48;
        r0 = r0.mLasteCellIdentityLte;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r0 = r42;
        r8.setCellIdentity(r0);	 Catch:{ all -> 0x0a5e }
        r42 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0a5e }
        r42.<init>();	 Catch:{ all -> 0x0a5e }
        r44 = "pollStateDone: hasRegistered=";
        r0 = r42;
        r1 = r44;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r0 = r42;
        r1 = r24;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r44 = " hasDeregistered=";
        r0 = r42;
        r1 = r44;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r0 = r42;
        r1 = r20;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r44 = " cidChanged=";
        r0 = r42;
        r1 = r44;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r0 = r42;
        r42 = r0.append(r7);	 Catch:{ all -> 0x0a5e }
        r44 = " mCellInfo=";
        r0 = r42;
        r1 = r44;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r0 = r48;
        r0 = r0.mCellInfo;	 Catch:{ all -> 0x0a5e }
        r44 = r0;
        r0 = r42;
        r1 = r44;
        r42 = r0.append(r1);	 Catch:{ all -> 0x0a5e }
        r42 = r42.toString();	 Catch:{ all -> 0x0a5e }
        r0 = r48;
        r1 = r42;
        r0.log(r1);	 Catch:{ all -> 0x0a5e }
        r0 = r48;
        r0 = r0.mCellInfo;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r0 = r42;
        r6.add(r0);	 Catch:{ all -> 0x0a5e }
    L_0x088c:
        r0 = r48;
        r0 = r0.mPhoneBase;	 Catch:{ all -> 0x0a5e }
        r42 = r0;
        r0 = r42;
        r0.notifyCellInfo(r6);	 Catch:{ all -> 0x0a5e }
        monitor-exit(r43);	 Catch:{ all -> 0x0a5e }
        return;
    L_0x0899:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getOperatorNumeric();
        r42 = r42.isMccMncMarkedAsRoaming(r43);
        if (r42 != 0) goto L_0x08c5;
    L_0x08af:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNewSS;
        r43 = r0;
        r43 = r43.getSystemId();
        r42 = r42.isSidMarkedAsRoaming(r43);
        if (r42 == 0) goto L_0x0110;
    L_0x08c5:
        r42 = "pollStateDone: override - marked as roaming.";
        r0 = r48;
        r1 = r42;
        r0.log(r1);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 1;
        r42.setVoiceRoaming(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 1;
        r42.setDataRoaming(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 0;
        r42.setCdmaEriIconIndex(r43);
        r0 = r48;
        r0 = r0.mNewSS;
        r42 = r0;
        r43 = 0;
        r42.setCdmaEriIconMode(r43);
        goto L_0x0110;
    L_0x08fc:
        r24 = 0;
        goto L_0x0151;
    L_0x0900:
        r20 = 0;
        goto L_0x016b;
    L_0x0904:
        r13 = 0;
        goto L_0x0184;
    L_0x0907:
        r15 = 0;
        goto L_0x019d;
    L_0x090a:
        r14 = 0;
        goto L_0x01b8;
    L_0x090d:
        r25 = 0;
        goto L_0x01d4;
    L_0x0911:
        r17 = 0;
        goto L_0x01f0;
    L_0x0915:
        r16 = 0;
        goto L_0x0204;
    L_0x0919:
        r27 = 0;
        goto L_0x021e;
    L_0x091d:
        r26 = 0;
        goto L_0x0238;
    L_0x0921:
        r19 = 0;
        goto L_0x0252;
    L_0x0925:
        r18 = 0;
        goto L_0x026c;
    L_0x0929:
        r21 = 0;
        goto L_0x0280;
    L_0x092d:
        r11 = 0;
        goto L_0x02d5;
    L_0x0930:
        r23 = 0;
        goto L_0x031f;
    L_0x0934:
        r22 = 0;
        goto L_0x0345;
    L_0x0938:
        r0 = r48;
        r0 = r0.mUiccController;
        r42 = r0;
        r43 = r48.getPhoneId();
        r42 = r42.getUiccCard(r43);
        r42 = r42.getOperatorBrandOverride();
        if (r42 == 0) goto L_0x094f;
    L_0x094c:
        r12 = 1;
        goto L_0x054d;
    L_0x094f:
        r12 = 0;
        goto L_0x054d;
    L_0x0952:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getVoiceRegState();
        r43 = 3;
        r0 = r42;
        r1 = r43;
        if (r0 != r1) goto L_0x0986;
    L_0x0964:
        r0 = r48;
        r0 = r0.mIccRecords;
        r42 = r0;
        if (r42 == 0) goto L_0x0984;
    L_0x096c:
        r0 = r48;
        r0 = r0.mIccRecords;
        r42 = r0;
        r9 = r42.getServiceProviderName();
    L_0x0976:
        r42 = android.text.TextUtils.isEmpty(r9);
        if (r42 == 0) goto L_0x05b4;
    L_0x097c:
        r42 = "ro.cdma.home.operator.alpha";
        r9 = android.os.SystemProperties.get(r42);
        goto L_0x05b4;
    L_0x0984:
        r9 = 0;
        goto L_0x0976;
    L_0x0986:
        r0 = r48;
        r0 = r0.mSS;
        r42 = r0;
        r42 = r42.getDataRegState();
        if (r42 == 0) goto L_0x05b4;
    L_0x0992:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getContext();
        r43 = 17039570; // 0x10400d2 float:2.424516E-38 double:8.418666E-317;
        r42 = r42.getText(r43);
        r9 = r42.toString();
        goto L_0x05b4;
    L_0x09a9:
        r29 = "";
        r42 = 0;
        r43 = 3;
        r0 = r32;
        r1 = r42;
        r2 = r43;
        r30 = r0.substring(r1, r2);
        r42 = 0;
        r43 = 3;
        r0 = r32;
        r1 = r42;
        r2 = r43;
        r42 = r0.substring(r1, r2);	 Catch:{ NumberFormatException -> 0x0a16, StringIndexOutOfBoundsException -> 0x0a34 }
        r42 = java.lang.Integer.parseInt(r42);	 Catch:{ NumberFormatException -> 0x0a16, StringIndexOutOfBoundsException -> 0x0a34 }
        r29 = com.android.internal.telephony.MccTable.countryCodeForMcc(r42);	 Catch:{ NumberFormatException -> 0x0a16, StringIndexOutOfBoundsException -> 0x0a34 }
    L_0x09cf:
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r42 = r42.getPhoneId();
        r0 = r40;
        r1 = r42;
        r2 = r29;
        r0.setNetworkCountryIsoForPhone(r1, r2);
        r42 = 1;
        r0 = r42;
        r1 = r48;
        r1.mGotCountryCode = r0;
        r0 = r48;
        r1 = r32;
        r0.setOperatorIdd(r1);
        r0 = r48;
        r0 = r0.mPhone;
        r42 = r0;
        r0 = r48;
        r0 = r0.mNeedFixZone;
        r43 = r0;
        r0 = r48;
        r1 = r42;
        r2 = r32;
        r3 = r33;
        r4 = r43;
        r42 = r0.shouldFixTimeZoneNow(r1, r2, r3, r4);
        if (r42 == 0) goto L_0x06f7;
    L_0x0a0d:
        r0 = r48;
        r1 = r29;
        r0.fixTimeZone(r1);
        goto L_0x06f7;
    L_0x0a16:
        r10 = move-exception;
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "countryCodeForMcc error";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r10);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.loge(r1);
        goto L_0x09cf;
    L_0x0a34:
        r10 = move-exception;
        r42 = new java.lang.StringBuilder;
        r42.<init>();
        r43 = "countryCodeForMcc error";
        r42 = r42.append(r43);
        r0 = r42;
        r42 = r0.append(r10);
        r42 = r42.toString();
        r0 = r48;
        r1 = r42;
        r0.loge(r1);
        goto L_0x09cf;
    L_0x0a53:
        r42 = 0;
        goto L_0x071b;
    L_0x0a57:
        r7 = 0;
        goto L_0x07ed;
    L_0x0a5a:
        r34 = 0;
        goto L_0x0809;
    L_0x0a5e:
        r42 = move-exception;
        monitor-exit(r43);	 Catch:{ all -> 0x0a5e }
        throw r42;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.cdma.CdmaLteServiceStateTracker.pollStateDone():void");
    }

    protected boolean onSignalStrengthResult(AsyncResult ar, boolean isGsm) {
        if (this.mSS.getRilDataRadioTechnology() == 14) {
            isGsm = true;
        }
        boolean ssChanged = super.onSignalStrengthResult(ar, isGsm);
        synchronized (this.mCellInfo) {
            if (this.mSS.getRilDataRadioTechnology() == 14) {
                this.mCellInfoLte.setTimeStamp(SystemClock.elapsedRealtime() * 1000);
                this.mCellInfoLte.setTimeStampType(4);
                this.mCellInfoLte.getCellSignalStrength().initialize(this.mSignalStrength, Integer.MAX_VALUE);
            }
            if (this.mCellInfoLte.getCellIdentity() != null) {
                ArrayList<CellInfo> arrayCi = new ArrayList();
                arrayCi.add(this.mCellInfoLte);
                this.mPhoneBase.notifyCellInfo(arrayCi);
            }
        }
        return ssChanged;
    }

    public boolean isConcurrentVoiceAndDataAllowed() {
        return this.mSS.getCssIndicator() == 1;
    }

    private boolean isInHomeSidNid(int sid, int nid) {
        if (isSidsAllZeros() || this.mHomeSystemId.length != this.mHomeNetworkId.length || sid == 0) {
            return true;
        }
        int i = 0;
        while (i < this.mHomeSystemId.length) {
            if (this.mHomeSystemId[i] == sid && (this.mHomeNetworkId[i] == 0 || this.mHomeNetworkId[i] == 65535 || nid == 0 || nid == CallFailCause.ERROR_UNSPECIFIED || this.mHomeNetworkId[i] == nid)) {
                return true;
            }
            i++;
        }
        return false;
    }

    public List<CellInfo> getAllCellInfo() {
        if (this.mCi.getRilVersion() >= 8) {
            return super.getAllCellInfo();
        }
        List<CellInfo> arrayList = new ArrayList();
        synchronized (this.mCellInfo) {
            arrayList.add(this.mCellInfoLte);
        }
        log("getAllCellInfo: arrayList=" + arrayList);
        return arrayList;
    }

    protected UiccCardApplication getUiccCardApplication() {
        return this.mUiccController.getUiccCardApplication(((CDMALTEPhone) this.mPhone).getPhoneId(), 2);
    }

    protected void updateCdmaSubscription() {
        this.mCi.getCDMASubscription(obtainMessage(34));
    }

    public void powerOffRadioSafely(DcTrackerBase dcTracker) {
        synchronized (this) {
            if (!this.mPendingRadioPowerOffAfterDataOff) {
                int dds = SubscriptionManager.getDefaultDataSubId();
                if (!dcTracker.isDisconnected() || (dds != this.mPhone.getSubId() && (dds == this.mPhone.getSubId() || !ProxyController.getInstance().isDataDisconnected(dds)))) {
                    dcTracker.cleanUpAllConnections(Phone.REASON_RADIO_TURNED_OFF);
                    if (!(dds == this.mPhone.getSubId() || ProxyController.getInstance().isDataDisconnected(dds))) {
                        log("Data is active on DDS.  Wait for all data disconnect");
                        ProxyController.getInstance().registerForAllDataDisconnected(dds, this, EVENT_ALL_DATA_DISCONNECTED, null);
                        this.mPendingRadioPowerOffAfterDataOff = true;
                    }
                    Message msg = Message.obtain(this);
                    msg.what = 38;
                    int i = this.mPendingRadioPowerOffAfterDataOffTag + 1;
                    this.mPendingRadioPowerOffAfterDataOffTag = i;
                    msg.arg1 = i;
                    if (sendMessageDelayed(msg, 30000)) {
                        log("Wait upto 30s for data to disconnect, then turn off radio.");
                        this.mPendingRadioPowerOffAfterDataOff = true;
                    } else {
                        log("Cannot send delayed Msg, turn off radio right away.");
                        hangupAndPowerOff();
                        this.mPendingRadioPowerOffAfterDataOff = false;
                    }
                } else {
                    dcTracker.cleanUpAllConnections(Phone.REASON_RADIO_TURNED_OFF);
                    log("Data disconnected, turn off radio right away.");
                    hangupAndPowerOff();
                }
            }
        }
    }

    protected void log(String s) {
        Rlog.d("CdmaSST", "[CdmaLteSST] " + s);
    }

    protected void loge(String s) {
        Rlog.e("CdmaSST", "[CdmaLteSST] " + s);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("CdmaLteServiceStateTracker extends:");
        super.dump(fd, pw, args);
        pw.println(" mCdmaLtePhone=" + this.mCdmaLtePhone);
    }
}
