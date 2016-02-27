package com.android.internal.telephony.uicc;

import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncResult;
import android.os.Message;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.SmsMessage;
import android.text.TextUtils;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.MccTable;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.gsm.SimTlv;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppState;
import com.android.internal.telephony.uicc.IccCardApplicationStatus.AppType;
import com.android.internal.telephony.uicc.IccRecords.IccRecordLoaded;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;

public class SIMRecords extends IccRecords {
    static final int CFF_LINE1_MASK = 15;
    static final int CFF_LINE1_RESET = 240;
    static final int CFF_UNCONDITIONAL_ACTIVE = 10;
    static final int CFF_UNCONDITIONAL_DEACTIVE = 5;
    private static final int CFIS_ADN_CAPABILITY_ID_OFFSET = 14;
    private static final int CFIS_ADN_EXTENSION_ID_OFFSET = 15;
    private static final int CFIS_BCD_NUMBER_LENGTH_OFFSET = 2;
    private static final int CFIS_TON_NPI_OFFSET = 3;
    private static final int CPHS_SST_MBN_ENABLED = 48;
    private static final int CPHS_SST_MBN_MASK = 48;
    private static final boolean CRASH_RIL = false;
    private static final int EVENT_APP_LOCKED = 35;
    protected static final int EVENT_GET_AD_DONE = 9;
    private static final int EVENT_GET_ALL_SMS_DONE = 18;
    private static final int EVENT_GET_CFF_DONE = 24;
    private static final int EVENT_GET_CFIS_DONE = 32;
    private static final int EVENT_GET_CPHS_MAILBOX_DONE = 11;
    private static final int EVENT_GET_CSP_CPHS_DONE = 33;
    private static final int EVENT_GET_GID1_DONE = 34;
    private static final int EVENT_GET_ICCID_DONE = 4;
    private static final int EVENT_GET_IMSI_DONE = 3;
    private static final int EVENT_GET_INFO_CPHS_DONE = 26;
    private static final int EVENT_GET_MBDN_DONE = 6;
    private static final int EVENT_GET_MBI_DONE = 5;
    protected static final int EVENT_GET_MSISDN_DONE = 10;
    private static final int EVENT_GET_MWIS_DONE = 7;
    private static final int EVENT_GET_PNN_DONE = 15;
    private static final int EVENT_GET_SMS_DONE = 22;
    private static final int EVENT_GET_SPDI_DONE = 13;
    private static final int EVENT_GET_SPN_DONE = 12;
    protected static final int EVENT_GET_SST_DONE = 17;
    private static final int EVENT_GET_VOICE_MAIL_INDICATOR_CPHS_DONE = 8;
    private static final int EVENT_MARK_SMS_READ_DONE = 19;
    private static final int EVENT_SET_CPHS_MAILBOX_DONE = 25;
    private static final int EVENT_SET_MBDN_DONE = 20;
    private static final int EVENT_SIM_REFRESH = 31;
    private static final int EVENT_SMS_ON_SIM = 21;
    private static final int EVENT_UPDATE_DONE = 14;
    protected static final String LOG_TAG = "SIMRecords";
    private static final String[] MCCMNC_CODES_HAVING_3DIGITS_MNC;
    static final int TAG_FULL_NETWORK_NAME = 67;
    static final int TAG_SHORT_NETWORK_NAME = 69;
    static final int TAG_SPDI = 163;
    static final int TAG_SPDI_PLMN_LIST = 128;
    private boolean mCallForwardingEnabled;
    private byte[] mCphsInfo;
    boolean mCspPlmnEnabled;
    byte[] mEfCPHS_MWI;
    byte[] mEfCff;
    byte[] mEfCfis;
    byte[] mEfLi;
    byte[] mEfMWIS;
    byte[] mEfPl;
    String mPnnHomeName;
    ArrayList<String> mSpdiNetworks;
    int mSpnDisplayCondition;
    SpnOverride mSpnOverride;
    private GetSpnFsmState mSpnState;
    UsimServiceTable mUsimServiceTable;
    VoiceMailConstants mVmConfig;

    /* renamed from: com.android.internal.telephony.uicc.SIMRecords.1 */
    static /* synthetic */ class C00871 {
        static final /* synthetic */ int[] f11xdc363d50;

        static {
            f11xdc363d50 = new int[GetSpnFsmState.values().length];
            try {
                f11xdc363d50[GetSpnFsmState.INIT.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f11xdc363d50[GetSpnFsmState.READ_SPN_3GPP.ordinal()] = SIMRecords.CFIS_BCD_NUMBER_LENGTH_OFFSET;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f11xdc363d50[GetSpnFsmState.READ_SPN_CPHS.ordinal()] = SIMRecords.EVENT_GET_IMSI_DONE;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f11xdc363d50[GetSpnFsmState.READ_SPN_SHORT_CPHS.ordinal()] = SIMRecords.EVENT_GET_ICCID_DONE;
            } catch (NoSuchFieldError e4) {
            }
        }
    }

    private class EfPlLoaded implements IccRecordLoaded {
        private EfPlLoaded() {
        }

        public String getEfName() {
            return "EF_PL";
        }

        public void onRecordLoaded(AsyncResult ar) {
            SIMRecords.this.mEfPl = (byte[]) ar.result;
            SIMRecords.this.log("EF_PL=" + IccUtils.bytesToHexString(SIMRecords.this.mEfPl));
        }
    }

    private class EfUsimLiLoaded implements IccRecordLoaded {
        private EfUsimLiLoaded() {
        }

        public String getEfName() {
            return "EF_LI";
        }

        public void onRecordLoaded(AsyncResult ar) {
            SIMRecords.this.mEfLi = (byte[]) ar.result;
            SIMRecords.this.log("EF_LI=" + IccUtils.bytesToHexString(SIMRecords.this.mEfLi));
        }
    }

    private enum GetSpnFsmState {
        IDLE,
        INIT,
        READ_SPN_3GPP,
        READ_SPN_CPHS,
        READ_SPN_SHORT_CPHS
    }

    public String toString() {
        return "SimRecords: " + super.toString() + " mVmConfig" + this.mVmConfig + " mSpnOverride=" + "mSpnOverride" + " callForwardingEnabled=" + this.mCallForwardingEnabled + " spnState=" + this.mSpnState + " mCphsInfo=" + this.mCphsInfo + " mCspPlmnEnabled=" + this.mCspPlmnEnabled + " efMWIS=" + this.mEfMWIS + " efCPHS_MWI=" + this.mEfCPHS_MWI + " mEfCff=" + this.mEfCff + " mEfCfis=" + this.mEfCfis + " getOperatorNumeric=" + getOperatorNumeric();
    }

    static {
        String[] strArr = new String[PduPart.P_TYPE];
        strArr[0] = "302370";
        strArr[1] = "302720";
        strArr[CFIS_BCD_NUMBER_LENGTH_OFFSET] = "310260";
        strArr[EVENT_GET_IMSI_DONE] = "405025";
        strArr[EVENT_GET_ICCID_DONE] = "405026";
        strArr[EVENT_GET_MBI_DONE] = "405027";
        strArr[EVENT_GET_MBDN_DONE] = "405028";
        strArr[EVENT_GET_MWIS_DONE] = "405029";
        strArr[EVENT_GET_VOICE_MAIL_INDICATOR_CPHS_DONE] = "405030";
        strArr[EVENT_GET_AD_DONE] = "405031";
        strArr[EVENT_GET_MSISDN_DONE] = "405032";
        strArr[EVENT_GET_CPHS_MAILBOX_DONE] = "405033";
        strArr[EVENT_GET_SPN_DONE] = "405034";
        strArr[EVENT_GET_SPDI_DONE] = "405035";
        strArr[EVENT_UPDATE_DONE] = "405036";
        strArr[EVENT_GET_PNN_DONE] = "405037";
        strArr[16] = "405038";
        strArr[EVENT_GET_SST_DONE] = "405039";
        strArr[EVENT_GET_ALL_SMS_DONE] = "405040";
        strArr[EVENT_MARK_SMS_READ_DONE] = "405041";
        strArr[EVENT_SET_MBDN_DONE] = "405042";
        strArr[EVENT_SMS_ON_SIM] = "405043";
        strArr[EVENT_GET_SMS_DONE] = "405044";
        strArr[23] = "405045";
        strArr[EVENT_GET_CFF_DONE] = "405046";
        strArr[EVENT_SET_CPHS_MAILBOX_DONE] = "405047";
        strArr[EVENT_GET_INFO_CPHS_DONE] = "405750";
        strArr[27] = "405751";
        strArr[28] = "405752";
        strArr[29] = "405753";
        strArr[30] = "405754";
        strArr[EVENT_SIM_REFRESH] = "405755";
        strArr[EVENT_GET_CFIS_DONE] = "405756";
        strArr[EVENT_GET_CSP_CPHS_DONE] = "405799";
        strArr[EVENT_GET_GID1_DONE] = "405800";
        strArr[EVENT_APP_LOCKED] = "405801";
        strArr[36] = "405802";
        strArr[37] = "405803";
        strArr[38] = "405804";
        strArr[39] = "405805";
        strArr[40] = "405806";
        strArr[41] = "405807";
        strArr[42] = "405808";
        strArr[43] = "405809";
        strArr[44] = "405810";
        strArr[45] = "405811";
        strArr[46] = "405812";
        strArr[47] = "405813";
        strArr[CPHS_SST_MBN_MASK] = "405814";
        strArr[49] = "405815";
        strArr[50] = "405816";
        strArr[51] = "405817";
        strArr[52] = "405818";
        strArr[53] = "405819";
        strArr[54] = "405820";
        strArr[55] = "405821";
        strArr[56] = "405822";
        strArr[57] = "405823";
        strArr[58] = "405824";
        strArr[59] = "405825";
        strArr[60] = "405826";
        strArr[61] = "405827";
        strArr[62] = "405828";
        strArr[63] = "405829";
        strArr[64] = "405830";
        strArr[65] = "405831";
        strArr[66] = "405832";
        strArr[TAG_FULL_NETWORK_NAME] = "405833";
        strArr[68] = "405834";
        strArr[TAG_SHORT_NETWORK_NAME] = "405835";
        strArr[70] = "405836";
        strArr[71] = "405837";
        strArr[72] = "405838";
        strArr[73] = "405839";
        strArr[74] = "405840";
        strArr[75] = "405841";
        strArr[76] = "405842";
        strArr[77] = "405843";
        strArr[78] = "405844";
        strArr[79] = "405845";
        strArr[80] = "405846";
        strArr[81] = "405847";
        strArr[82] = "405848";
        strArr[83] = "405849";
        strArr[84] = "405850";
        strArr[85] = "405851";
        strArr[86] = "405852";
        strArr[87] = "405853";
        strArr[88] = "405875";
        strArr[89] = "405876";
        strArr[90] = "405877";
        strArr[91] = "405878";
        strArr[92] = "405879";
        strArr[93] = "405880";
        strArr[94] = "405881";
        strArr[95] = "405882";
        strArr[96] = "405883";
        strArr[97] = "405884";
        strArr[98] = "405885";
        strArr[99] = "405886";
        strArr[100] = "405908";
        strArr[101] = "405909";
        strArr[102] = "405910";
        strArr[103] = "405911";
        strArr[104] = "405912";
        strArr[105] = "405913";
        strArr[CharacterSets.UTF_8] = "405914";
        strArr[107] = "405915";
        strArr[108] = "405916";
        strArr[109] = "405917";
        strArr[110] = "405918";
        strArr[111] = "405919";
        strArr[112] = "405920";
        strArr[113] = "405921";
        strArr[114] = "405922";
        strArr[115] = "405923";
        strArr[116] = "405924";
        strArr[117] = "405925";
        strArr[118] = "405926";
        strArr[119] = "405927";
        strArr[120] = "405928";
        strArr[121] = "405929";
        strArr[122] = "405930";
        strArr[123] = "405931";
        strArr[124] = "405932";
        strArr[125] = "502142";
        strArr[126] = "502143";
        strArr[127] = "502145";
        strArr[TAG_SPDI_PLMN_LIST] = "502146";
        strArr[PduPart.P_DISPOSITION_ATTACHMENT] = "502147";
        strArr[PduPart.P_LEVEL] = "502148";
        MCCMNC_CODES_HAVING_3DIGITS_MNC = strArr;
    }

    public SIMRecords(UiccCardApplication app, Context c, CommandsInterface ci) {
        super(app, c, ci);
        this.mCphsInfo = null;
        this.mCspPlmnEnabled = true;
        this.mEfMWIS = null;
        this.mEfCPHS_MWI = null;
        this.mEfCff = null;
        this.mEfCfis = null;
        this.mEfLi = null;
        this.mEfPl = null;
        this.mSpdiNetworks = null;
        this.mPnnHomeName = null;
        this.mAdnCache = new AdnRecordCache(this.mFh);
        this.mVmConfig = new VoiceMailConstants();
        this.mSpnOverride = new SpnOverride();
        this.mRecordsRequested = CRASH_RIL;
        this.mRecordsToLoad = 0;
        this.mCi.setOnSmsOnSim(this, EVENT_SMS_ON_SIM, null);
        this.mCi.registerForIccRefresh(this, EVENT_SIM_REFRESH, null);
        resetRecords();
        this.mParentApp.registerForReady(this, 1, null);
        this.mParentApp.registerForLocked(this, EVENT_APP_LOCKED, null);
        log("SIMRecords X ctor this=" + this);
    }

    public void dispose() {
        log("Disposing SIMRecords this=" + this);
        this.mCi.unregisterForIccRefresh(this);
        this.mCi.unSetOnSmsOnSim(this);
        this.mParentApp.unregisterForReady(this);
        this.mParentApp.unregisterForLocked(this);
        resetRecords();
        super.dispose();
    }

    protected void finalize() {
        log("finalized");
    }

    protected void resetRecords() {
        this.mImsi = null;
        this.mMsisdn = null;
        this.mVoiceMailNum = null;
        this.mMncLength = -1;
        log("setting0 mMncLength" + this.mMncLength);
        this.mIccId = null;
        this.mSpnDisplayCondition = -1;
        this.mEfMWIS = null;
        this.mEfCPHS_MWI = null;
        this.mSpdiNetworks = null;
        this.mPnnHomeName = null;
        this.mGid1 = null;
        this.mAdnCache.reset();
        log("SIMRecords: onRadioOffOrNotAvailable set 'gsm.sim.operator.numeric' to operator=null");
        log("update icc_operator_numeric=" + null);
        this.mTelephonyManager.setSimOperatorNumericForPhone(this.mParentApp.getPhoneId(), "");
        this.mTelephonyManager.setSimOperatorNameForPhone(this.mParentApp.getPhoneId(), "");
        this.mTelephonyManager.setSimCountryIsoForPhone(this.mParentApp.getPhoneId(), "");
        this.mParentApp.getUICCConfig().setImsi(this.mImsi);
        this.mParentApp.getUICCConfig().setMncLength(this.mMncLength);
        this.mRecordsRequested = CRASH_RIL;
    }

    public String getIMSI() {
        return this.mImsi;
    }

    public String getMsisdnNumber() {
        return this.mMsisdn;
    }

    public String getGid1() {
        return this.mGid1;
    }

    public UsimServiceTable getUsimServiceTable() {
        return this.mUsimServiceTable;
    }

    public void setMsisdnNumber(String alphaTag, String number, Message onComplete) {
        this.mNewMsisdn = number;
        this.mNewMsisdnTag = alphaTag;
        log("Set MSISDN: " + this.mNewMsisdnTag + " " + "xxxxxxx");
        new AdnRecordLoader(this.mFh).updateEF(new AdnRecord(this.mNewMsisdnTag, this.mNewMsisdn), IccConstants.EF_MSISDN, IccConstants.EF_EXT1, 1, null, obtainMessage(30, onComplete));
    }

    public String getMsisdnAlphaTag() {
        return this.mMsisdnTag;
    }

    public String getVoiceMailNumber() {
        return this.mVoiceMailNum;
    }

    public void setVoiceMailNumber(String alphaTag, String voiceNumber, Message onComplete) {
        if (this.mIsVoiceMailFixed) {
            AsyncResult.forMessage(onComplete).exception = new IccVmFixedException("Voicemail number is fixed by operator");
            onComplete.sendToTarget();
            return;
        }
        this.mNewVoiceMailNum = voiceNumber;
        this.mNewVoiceMailTag = alphaTag;
        AdnRecord adn = new AdnRecord(this.mNewVoiceMailTag, this.mNewVoiceMailNum);
        if (this.mMailboxIndex != 0 && this.mMailboxIndex != PduHeaders.STORE_STATUS_ERROR_END) {
            new AdnRecordLoader(this.mFh).updateEF(adn, IccConstants.EF_MBDN, IccConstants.EF_EXT6, this.mMailboxIndex, null, obtainMessage(EVENT_SET_MBDN_DONE, onComplete));
        } else if (isCphsMailboxEnabled()) {
            new AdnRecordLoader(this.mFh).updateEF(adn, IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, null, obtainMessage(EVENT_SET_CPHS_MAILBOX_DONE, onComplete));
        } else {
            AsyncResult.forMessage(onComplete).exception = new IccVmNotSupportedException("Update SIM voice mailbox error");
            onComplete.sendToTarget();
        }
    }

    public String getVoiceMailAlphaTag() {
        return this.mVoiceMailTag;
    }

    public void setVoiceMessageWaiting(int line, int countWaiting) {
        int i = 0;
        if (line == 1) {
            try {
                if (this.mEfMWIS != null) {
                    byte[] bArr = this.mEfMWIS;
                    int i2 = this.mEfMWIS[0] & 254;
                    if (countWaiting != 0) {
                        i = 1;
                    }
                    bArr[0] = (byte) (i | i2);
                    if (countWaiting < 0) {
                        this.mEfMWIS[1] = (byte) 0;
                    } else {
                        this.mEfMWIS[1] = (byte) countWaiting;
                    }
                    this.mFh.updateEFLinearFixed(IccConstants.EF_MWIS, 1, this.mEfMWIS, null, obtainMessage(EVENT_UPDATE_DONE, IccConstants.EF_MWIS, 0));
                }
                if (this.mEfCPHS_MWI != null) {
                    this.mEfCPHS_MWI[0] = (byte) ((countWaiting == 0 ? EVENT_GET_MBI_DONE : EVENT_GET_MSISDN_DONE) | (this.mEfCPHS_MWI[0] & CFF_LINE1_RESET));
                    this.mFh.updateEFTransparent(IccConstants.EF_VOICE_MAIL_INDICATOR_CPHS, this.mEfCPHS_MWI, obtainMessage(EVENT_UPDATE_DONE, Integer.valueOf(IccConstants.EF_VOICE_MAIL_INDICATOR_CPHS)));
                }
            } catch (ArrayIndexOutOfBoundsException ex) {
                logw("Error saving voice mail state to SIM. Probably malformed SIM record", ex);
            }
        }
    }

    private boolean validEfCfis(byte[] data) {
        return (data == null || data[0] < (byte) 1 || data[0] > EVENT_GET_ICCID_DONE) ? CRASH_RIL : true;
    }

    public int getVoiceMessageCount() {
        int countVoiceMessages = 0;
        if (this.mEfMWIS != null) {
            countVoiceMessages = this.mEfMWIS[1] & PduHeaders.STORE_STATUS_ERROR_END;
            if (((this.mEfMWIS[0] & 1) != 0 ? true : CRASH_RIL) && countVoiceMessages == 0) {
                countVoiceMessages = -1;
            }
            log(" VoiceMessageCount from SIM MWIS = " + countVoiceMessages);
        } else if (this.mEfCPHS_MWI != null) {
            int indicator = this.mEfCPHS_MWI[0] & EVENT_GET_PNN_DONE;
            if (indicator == EVENT_GET_MSISDN_DONE) {
                countVoiceMessages = -1;
            } else if (indicator == EVENT_GET_MBI_DONE) {
                countVoiceMessages = 0;
            }
            log(" VoiceMessageCount from SIM CPHS = " + countVoiceMessages);
        }
        return countVoiceMessages;
    }

    public boolean getVoiceCallForwardingFlag() {
        return this.mCallForwardingEnabled;
    }

    public void setVoiceCallForwardingFlag(int line, boolean enable, String dialNumber) {
        if (line == 1) {
            this.mCallForwardingEnabled = enable;
            this.mRecordsEventsRegistrants.notifyResult(Integer.valueOf(1));
            try {
                if (validEfCfis(this.mEfCfis)) {
                    byte[] bArr;
                    if (enable) {
                        bArr = this.mEfCfis;
                        bArr[1] = (byte) (bArr[1] | 1);
                    } else {
                        bArr = this.mEfCfis;
                        bArr[1] = (byte) (bArr[1] & 254);
                    }
                    log("setVoiceCallForwardingFlag: enable=" + enable + " mEfCfis=" + IccUtils.bytesToHexString(this.mEfCfis));
                    if (enable && !TextUtils.isEmpty(dialNumber)) {
                        log("EF_CFIS: updating cf number, " + dialNumber);
                        byte[] bcdNumber = PhoneNumberUtils.numberToCalledPartyBCD(dialNumber);
                        System.arraycopy(bcdNumber, 0, this.mEfCfis, EVENT_GET_IMSI_DONE, bcdNumber.length);
                        this.mEfCfis[CFIS_BCD_NUMBER_LENGTH_OFFSET] = (byte) bcdNumber.length;
                        this.mEfCfis[EVENT_UPDATE_DONE] = (byte) -1;
                        this.mEfCfis[EVENT_GET_PNN_DONE] = (byte) -1;
                    }
                    this.mFh.updateEFLinearFixed(IccConstants.EF_CFIS, 1, this.mEfCfis, null, obtainMessage(EVENT_UPDATE_DONE, Integer.valueOf(IccConstants.EF_CFIS)));
                } else {
                    log("setVoiceCallForwardingFlag: ignoring enable=" + enable + " invalid mEfCfis=" + IccUtils.bytesToHexString(this.mEfCfis));
                }
                if (this.mEfCff != null) {
                    if (enable) {
                        this.mEfCff[0] = (byte) ((this.mEfCff[0] & CFF_LINE1_RESET) | EVENT_GET_MSISDN_DONE);
                    } else {
                        this.mEfCff[0] = (byte) ((this.mEfCff[0] & CFF_LINE1_RESET) | EVENT_GET_MBI_DONE);
                    }
                    this.mFh.updateEFTransparent(IccConstants.EF_CFF_CPHS, this.mEfCff, obtainMessage(EVENT_UPDATE_DONE, Integer.valueOf(IccConstants.EF_CFF_CPHS)));
                }
            } catch (ArrayIndexOutOfBoundsException ex) {
                logw("Error saving call forwarding flag to SIM. Probably malformed SIM record", ex);
            }
        }
    }

    public void onRefresh(boolean fileChanged, int[] fileList) {
        if (fileChanged) {
            fetchSimRecords();
        }
    }

    public String getOperatorNumeric() {
        if (this.mImsi == null) {
            log("getOperatorNumeric: IMSI == null");
            return null;
        } else if (this.mMncLength != -1 && this.mMncLength != 0) {
            return this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE);
        } else {
            log("getSIMOperatorNumeric: bad mncLength");
            return null;
        }
    }

    public void handleMessage(Message msg) {
        boolean isRecordLoadResponse = CRASH_RIL;
        if (this.mDestroyed.get()) {
            loge("Received message " + msg + "[" + msg.what + "] " + " while being destroyed. Ignoring.");
            return;
        }
        String mccmncCode;
        String[] arr$;
        int len$;
        int i$;
        try {
            AsyncResult ar;
            byte[] data;
            AdnRecord adn;
            switch (msg.what) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    onReady();
                    break;
                case EVENT_GET_IMSI_DONE /*3*/:
                    isRecordLoadResponse = true;
                    ar = msg.obj;
                    if (ar.exception == null) {
                        this.mImsi = (String) ar.result;
                        if (this.mImsi != null && (this.mImsi.length() < EVENT_GET_MBDN_DONE || this.mImsi.length() > EVENT_GET_PNN_DONE)) {
                            loge("invalid IMSI " + this.mImsi);
                            this.mImsi = null;
                        }
                        log("IMSI: mMncLength=" + this.mMncLength);
                        log("IMSI: " + this.mImsi.substring(0, EVENT_GET_MBDN_DONE) + "xxxxxxx");
                        if ((this.mMncLength == 0 || this.mMncLength == CFIS_BCD_NUMBER_LENGTH_OFFSET) && this.mImsi != null && this.mImsi.length() >= EVENT_GET_MBDN_DONE) {
                            mccmncCode = this.mImsi.substring(0, EVENT_GET_MBDN_DONE);
                            arr$ = MCCMNC_CODES_HAVING_3DIGITS_MNC;
                            len$ = arr$.length;
                            i$ = 0;
                            while (i$ < len$) {
                                if (arr$[i$].equals(mccmncCode)) {
                                    this.mMncLength = EVENT_GET_IMSI_DONE;
                                    log("IMSI: setting1 mMncLength=" + this.mMncLength);
                                } else {
                                    i$++;
                                }
                            }
                        }
                        if (this.mMncLength == 0) {
                            try {
                                this.mMncLength = MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE)));
                                log("setting2 mMncLength=" + this.mMncLength);
                            } catch (NumberFormatException e) {
                                this.mMncLength = 0;
                                loge("Corrupt IMSI! setting3 mMncLength=" + this.mMncLength);
                            }
                        }
                        this.mParentApp.getUICCConfig().setImsi(this.mImsi);
                        if (this.mMncLength == 0 || this.mMncLength == -1) {
                            this.mParentApp.getUICCConfig().setMncLength(EVENT_GET_IMSI_DONE);
                        } else {
                            this.mParentApp.getUICCConfig().setMncLength(this.mMncLength);
                        }
                        if (!(this.mMncLength == 0 || this.mMncLength == -1)) {
                            log("update mccmnc=" + this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE));
                            MccTable.updateMccMncConfiguration(this.mContext, this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE), CRASH_RIL);
                        }
                        this.mImsiReadyRegistrants.notifyRegistrants();
                        break;
                    }
                    loge("Exception querying IMSI, Exception:" + ar.exception);
                    break;
                    break;
                case EVENT_GET_ICCID_DONE /*4*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        this.mIccId = IccUtils.bcdToString(data, 0, data.length);
                        log("iccid: " + this.mIccId);
                        break;
                    }
                    break;
                case EVENT_GET_MBI_DONE /*5*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    boolean isValidMbdn = CRASH_RIL;
                    if (ar.exception == null) {
                        log("EF_MBI: " + IccUtils.bytesToHexString(data));
                        this.mMailboxIndex = data[0] & PduHeaders.STORE_STATUS_ERROR_END;
                        if (!(this.mMailboxIndex == 0 || this.mMailboxIndex == PduHeaders.STORE_STATUS_ERROR_END)) {
                            log("Got valid mailbox number for MBDN");
                            isValidMbdn = true;
                        }
                    }
                    this.mRecordsToLoad++;
                    if (!isValidMbdn) {
                        new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, obtainMessage(EVENT_GET_CPHS_MAILBOX_DONE));
                        break;
                    } else {
                        new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MBDN, IccConstants.EF_EXT6, this.mMailboxIndex, obtainMessage(EVENT_GET_MBDN_DONE));
                        break;
                    }
                case EVENT_GET_MBDN_DONE /*6*/:
                case EVENT_GET_CPHS_MAILBOX_DONE /*11*/:
                    this.mVoiceMailNum = null;
                    this.mVoiceMailTag = null;
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        adn = ar.result;
                        log("VM: " + adn + (msg.what == EVENT_GET_CPHS_MAILBOX_DONE ? " EF[MAILBOX]" : " EF[MBDN]"));
                        if (!adn.isEmpty() || msg.what != EVENT_GET_MBDN_DONE) {
                            this.mVoiceMailNum = adn.getNumber();
                            this.mVoiceMailTag = adn.getAlphaTag();
                            break;
                        }
                        this.mRecordsToLoad++;
                        new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, obtainMessage(EVENT_GET_CPHS_MAILBOX_DONE));
                        break;
                    }
                    log("Invalid or missing EF" + (msg.what == EVENT_GET_CPHS_MAILBOX_DONE ? "[MAILBOX]" : "[MBDN]"));
                    if (msg.what == EVENT_GET_MBDN_DONE) {
                        this.mRecordsToLoad++;
                        new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, obtainMessage(EVENT_GET_CPHS_MAILBOX_DONE));
                        break;
                    }
                    break;
                case EVENT_GET_MWIS_DONE /*7*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    log("EF_MWIS : " + IccUtils.bytesToHexString(data));
                    if (ar.exception == null) {
                        if ((data[0] & PduHeaders.STORE_STATUS_ERROR_END) != PduHeaders.STORE_STATUS_ERROR_END) {
                            this.mEfMWIS = data;
                            break;
                        } else {
                            log("SIMRecords: Uninitialized record MWIS");
                            break;
                        }
                    }
                    log("EVENT_GET_MWIS_DONE exception = " + ar.exception);
                    break;
                case EVENT_GET_VOICE_MAIL_INDICATOR_CPHS_DONE /*8*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    log("EF_CPHS_MWI: " + IccUtils.bytesToHexString(data));
                    if (ar.exception == null) {
                        this.mEfCPHS_MWI = data;
                        break;
                    } else {
                        log("EVENT_GET_VOICE_MAIL_INDICATOR_CPHS_DONE exception = " + ar.exception);
                        break;
                    }
                case EVENT_GET_AD_DONE /*9*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        log("EF_AD: " + IccUtils.bytesToHexString(data));
                        if (data.length >= EVENT_GET_IMSI_DONE) {
                            if (data.length != EVENT_GET_IMSI_DONE) {
                                this.mMncLength = data[EVENT_GET_IMSI_DONE] & EVENT_GET_PNN_DONE;
                                log("setting4 mMncLength=" + this.mMncLength);
                                if (this.mMncLength == EVENT_GET_PNN_DONE) {
                                    this.mMncLength = 0;
                                    log("setting5 mMncLength=" + this.mMncLength);
                                } else {
                                    this.mParentApp.getUICCConfig().setMncLength(this.mMncLength);
                                }
                                if ((this.mMncLength == -1 || this.mMncLength == 0 || this.mMncLength == CFIS_BCD_NUMBER_LENGTH_OFFSET) && this.mImsi != null && this.mImsi.length() >= EVENT_GET_MBDN_DONE) {
                                    mccmncCode = this.mImsi.substring(0, EVENT_GET_MBDN_DONE);
                                    log("mccmncCode=" + mccmncCode);
                                    arr$ = MCCMNC_CODES_HAVING_3DIGITS_MNC;
                                    len$ = arr$.length;
                                    i$ = 0;
                                    while (i$ < len$) {
                                        if (arr$[i$].equals(mccmncCode)) {
                                            this.mMncLength = EVENT_GET_IMSI_DONE;
                                            log("setting6 mMncLength=" + this.mMncLength);
                                        } else {
                                            i$++;
                                        }
                                    }
                                }
                                if (this.mMncLength == 0 || this.mMncLength == -1) {
                                    if (this.mImsi != null) {
                                        try {
                                            this.mMncLength = MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE)));
                                            log("setting7 mMncLength=" + this.mMncLength);
                                        } catch (NumberFormatException e2) {
                                            this.mMncLength = 0;
                                            loge("Corrupt IMSI! setting8 mMncLength=" + this.mMncLength);
                                        }
                                    } else {
                                        this.mMncLength = 0;
                                        log("MNC length not present in EF_AD setting9 mMncLength=" + this.mMncLength);
                                    }
                                }
                                if (!(this.mImsi == null || this.mMncLength == 0)) {
                                    log("update mccmnc=" + this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE));
                                    MccTable.updateMccMncConfiguration(this.mContext, this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE), CRASH_RIL);
                                    break;
                                }
                            }
                            log("MNC length not present in EF_AD");
                            if ((this.mMncLength == -1 || this.mMncLength == 0 || this.mMncLength == CFIS_BCD_NUMBER_LENGTH_OFFSET) && this.mImsi != null && this.mImsi.length() >= EVENT_GET_MBDN_DONE) {
                                mccmncCode = this.mImsi.substring(0, EVENT_GET_MBDN_DONE);
                                log("mccmncCode=" + mccmncCode);
                                arr$ = MCCMNC_CODES_HAVING_3DIGITS_MNC;
                                len$ = arr$.length;
                                i$ = 0;
                                while (i$ < len$) {
                                    if (arr$[i$].equals(mccmncCode)) {
                                        this.mMncLength = EVENT_GET_IMSI_DONE;
                                        log("setting6 mMncLength=" + this.mMncLength);
                                    } else {
                                        i$++;
                                    }
                                }
                            }
                            if (this.mMncLength == 0 || this.mMncLength == -1) {
                                if (this.mImsi != null) {
                                    try {
                                        this.mMncLength = MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE)));
                                        log("setting7 mMncLength=" + this.mMncLength);
                                    } catch (NumberFormatException e3) {
                                        this.mMncLength = 0;
                                        loge("Corrupt IMSI! setting8 mMncLength=" + this.mMncLength);
                                    }
                                } else {
                                    this.mMncLength = 0;
                                    log("MNC length not present in EF_AD setting9 mMncLength=" + this.mMncLength);
                                }
                            }
                            if (!(this.mImsi == null || this.mMncLength == 0)) {
                                log("update mccmnc=" + this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE));
                                MccTable.updateMccMncConfiguration(this.mContext, this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE), CRASH_RIL);
                                break;
                            }
                        }
                        log("Corrupt AD data on SIM");
                        if ((this.mMncLength == -1 || this.mMncLength == 0 || this.mMncLength == CFIS_BCD_NUMBER_LENGTH_OFFSET) && this.mImsi != null && this.mImsi.length() >= EVENT_GET_MBDN_DONE) {
                            mccmncCode = this.mImsi.substring(0, EVENT_GET_MBDN_DONE);
                            log("mccmncCode=" + mccmncCode);
                            arr$ = MCCMNC_CODES_HAVING_3DIGITS_MNC;
                            len$ = arr$.length;
                            i$ = 0;
                            while (i$ < len$) {
                                if (arr$[i$].equals(mccmncCode)) {
                                    this.mMncLength = EVENT_GET_IMSI_DONE;
                                    log("setting6 mMncLength=" + this.mMncLength);
                                } else {
                                    i$++;
                                }
                            }
                        }
                        if (this.mMncLength == 0 || this.mMncLength == -1) {
                            if (this.mImsi != null) {
                                try {
                                    this.mMncLength = MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE)));
                                    log("setting7 mMncLength=" + this.mMncLength);
                                } catch (NumberFormatException e4) {
                                    this.mMncLength = 0;
                                    loge("Corrupt IMSI! setting8 mMncLength=" + this.mMncLength);
                                }
                            } else {
                                this.mMncLength = 0;
                                log("MNC length not present in EF_AD setting9 mMncLength=" + this.mMncLength);
                            }
                        }
                        if (!(this.mImsi == null || this.mMncLength == 0)) {
                            log("update mccmnc=" + this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE));
                            MccTable.updateMccMncConfiguration(this.mContext, this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE), CRASH_RIL);
                            break;
                        }
                    }
                    if ((this.mMncLength == -1 || this.mMncLength == 0 || this.mMncLength == CFIS_BCD_NUMBER_LENGTH_OFFSET) && this.mImsi != null && this.mImsi.length() >= EVENT_GET_MBDN_DONE) {
                        mccmncCode = this.mImsi.substring(0, EVENT_GET_MBDN_DONE);
                        log("mccmncCode=" + mccmncCode);
                        arr$ = MCCMNC_CODES_HAVING_3DIGITS_MNC;
                        len$ = arr$.length;
                        i$ = 0;
                        while (i$ < len$) {
                            if (arr$[i$].equals(mccmncCode)) {
                                this.mMncLength = EVENT_GET_IMSI_DONE;
                                log("setting6 mMncLength=" + this.mMncLength);
                            } else {
                                i$++;
                            }
                        }
                    }
                    if (this.mMncLength == 0 || this.mMncLength == -1) {
                        if (this.mImsi != null) {
                            try {
                                this.mMncLength = MccTable.smallestDigitsMccForMnc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE)));
                                log("setting7 mMncLength=" + this.mMncLength);
                            } catch (NumberFormatException e5) {
                                this.mMncLength = 0;
                                loge("Corrupt IMSI! setting8 mMncLength=" + this.mMncLength);
                            }
                        } else {
                            this.mMncLength = 0;
                            log("MNC length not present in EF_AD setting9 mMncLength=" + this.mMncLength);
                        }
                    }
                    if (!(this.mImsi == null || this.mMncLength == 0)) {
                        log("update mccmnc=" + this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE));
                        MccTable.updateMccMncConfiguration(this.mContext, this.mImsi.substring(0, this.mMncLength + EVENT_GET_IMSI_DONE), CRASH_RIL);
                        break;
                    }
                case EVENT_GET_MSISDN_DONE /*10*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        adn = (AdnRecord) ar.result;
                        this.mMsisdn = adn.getNumber();
                        this.mMsisdnTag = adn.getAlphaTag();
                        log("MSISDN: xxxxxxx");
                        break;
                    }
                    log("Invalid or missing EF[MSISDN]");
                    break;
                case EVENT_GET_SPN_DONE /*12*/:
                    isRecordLoadResponse = true;
                    getSpnFsm(CRASH_RIL, (AsyncResult) msg.obj);
                    break;
                case EVENT_GET_SPDI_DONE /*13*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        parseEfSpdi(data);
                        break;
                    }
                    break;
                case EVENT_UPDATE_DONE /*14*/:
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception != null) {
                        logw("update failed. ", ar.exception);
                        break;
                    }
                    break;
                case EVENT_GET_PNN_DONE /*15*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        SimTlv simTlv = new SimTlv(data, 0, data.length);
                        while (simTlv.isValidObject()) {
                            if (simTlv.getTag() == TAG_FULL_NETWORK_NAME) {
                                this.mPnnHomeName = IccUtils.networkNameToString(simTlv.getData(), 0, simTlv.getData().length);
                                break;
                            }
                            simTlv.nextObject();
                        }
                        break;
                    }
                    break;
                case EVENT_GET_SST_DONE /*17*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        this.mUsimServiceTable = new UsimServiceTable(data);
                        log("SST: " + this.mUsimServiceTable);
                        break;
                    }
                    break;
                case EVENT_GET_ALL_SMS_DONE /*18*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        handleSmses((ArrayList) ar.result);
                        break;
                    }
                    break;
                case EVENT_MARK_SMS_READ_DONE /*19*/:
                    Rlog.i("ENF", "marked read: sms " + msg.arg1);
                    break;
                case EVENT_SET_MBDN_DONE /*20*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    log("EVENT_SET_MBDN_DONE ex:" + ar.exception);
                    if (ar.exception == null) {
                        this.mVoiceMailNum = this.mNewVoiceMailNum;
                        this.mVoiceMailTag = this.mNewVoiceMailTag;
                    }
                    if (!isCphsMailboxEnabled()) {
                        if (ar.userObj != null) {
                            Resources resource = Resources.getSystem();
                            if (ar.exception == null || !resource.getBoolean(17957005)) {
                                AsyncResult.forMessage((Message) ar.userObj).exception = ar.exception;
                            } else {
                                AsyncResult.forMessage((Message) ar.userObj).exception = new IccVmNotSupportedException("Update SIM voice mailbox error");
                            }
                            ((Message) ar.userObj).sendToTarget();
                            break;
                        }
                    }
                    adn = new AdnRecord(this.mVoiceMailTag, this.mVoiceMailNum);
                    Message onCphsCompleted = ar.userObj;
                    if (ar.exception == null && ar.userObj != null) {
                        AsyncResult.forMessage((Message) ar.userObj).exception = null;
                        ((Message) ar.userObj).sendToTarget();
                        log("Callback with MBDN successful.");
                        onCphsCompleted = null;
                    }
                    new AdnRecordLoader(this.mFh).updateEF(adn, IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, null, obtainMessage(EVENT_SET_CPHS_MAILBOX_DONE, onCphsCompleted));
                    break;
                    break;
                case EVENT_SMS_ON_SIM /*21*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    int[] index = (int[]) ar.result;
                    if (ar.exception != null || index.length != 1) {
                        loge("Error on SMS_ON_SIM with exp " + ar.exception + " length " + index.length);
                        break;
                    }
                    log("READ EF_SMS RECORD index=" + index[0]);
                    this.mFh.loadEFLinearFixed(IccConstants.EF_SMS, index[0], obtainMessage(EVENT_GET_SMS_DONE));
                    break;
                    break;
                case EVENT_GET_SMS_DONE /*22*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception != null) {
                        loge("Error on GET_SMS with exp " + ar.exception);
                        break;
                    } else {
                        handleSms((byte[]) ar.result);
                        break;
                    }
                case EVENT_GET_CFF_DONE /*24*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        log("EF_CFF_CPHS: " + IccUtils.bytesToHexString(data));
                        this.mEfCff = data;
                        if (!validEfCfis(this.mEfCfis)) {
                            this.mCallForwardingEnabled = (data[0] & EVENT_GET_PNN_DONE) == EVENT_GET_MSISDN_DONE ? true : CRASH_RIL;
                            this.mRecordsEventsRegistrants.notifyResult(Integer.valueOf(1));
                            break;
                        }
                        log("EVENT_GET_CFF_DONE: EF_CFIS is valid, ignoring EF_CFF_CPHS");
                        break;
                    }
                    break;
                case EVENT_SET_CPHS_MAILBOX_DONE /*25*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        this.mVoiceMailNum = this.mNewVoiceMailNum;
                        this.mVoiceMailTag = this.mNewVoiceMailTag;
                    } else {
                        log("Set CPHS MailBox with exception: " + ar.exception);
                    }
                    if (ar.userObj != null) {
                        log("Callback with CPHS MB successful.");
                        AsyncResult.forMessage((Message) ar.userObj).exception = ar.exception;
                        ((Message) ar.userObj).sendToTarget();
                        break;
                    }
                    break;
                case EVENT_GET_INFO_CPHS_DONE /*26*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        this.mCphsInfo = (byte[]) ar.result;
                        log("iCPHS: " + IccUtils.bytesToHexString(this.mCphsInfo));
                        break;
                    }
                    break;
                case CallFailCause.STATUS_ENQUIRY /*30*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        this.mMsisdn = this.mNewMsisdn;
                        this.mMsisdnTag = this.mNewMsisdnTag;
                        log("Success to update EF[MSISDN]");
                    }
                    if (ar.userObj != null) {
                        AsyncResult.forMessage((Message) ar.userObj).exception = ar.exception;
                        ((Message) ar.userObj).sendToTarget();
                        break;
                    }
                    break;
                case EVENT_SIM_REFRESH /*31*/:
                    isRecordLoadResponse = CRASH_RIL;
                    ar = (AsyncResult) msg.obj;
                    log("Sim REFRESH with exception: " + ar.exception);
                    if (ar.exception == null) {
                        handleSimRefresh((IccRefreshResponse) ar.result);
                        break;
                    }
                    break;
                case EVENT_GET_CFIS_DONE /*32*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        log("EF_CFIS: " + IccUtils.bytesToHexString(data));
                        if (!validEfCfis(data)) {
                            log("EF_CFIS: invalid data=" + IccUtils.bytesToHexString(data));
                            break;
                        }
                        this.mEfCfis = data;
                        this.mCallForwardingEnabled = (data[1] & 1) != 0 ? true : CRASH_RIL;
                        log("EF_CFIS: callForwardingEnabled=" + this.mCallForwardingEnabled);
                        this.mRecordsEventsRegistrants.notifyResult(Integer.valueOf(1));
                        break;
                    }
                    break;
                case EVENT_GET_CSP_CPHS_DONE /*33*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    if (ar.exception == null) {
                        data = (byte[]) ar.result;
                        log("EF_CSP: " + IccUtils.bytesToHexString(data));
                        handleEfCspData(data);
                        break;
                    }
                    loge("Exception in fetching EF_CSP data " + ar.exception);
                    break;
                case EVENT_GET_GID1_DONE /*34*/:
                    isRecordLoadResponse = true;
                    ar = (AsyncResult) msg.obj;
                    data = (byte[]) ar.result;
                    if (ar.exception == null) {
                        this.mGid1 = IccUtils.bytesToHexString(data);
                        log("GID1: " + this.mGid1);
                        break;
                    }
                    loge("Exception in get GID1 " + ar.exception);
                    this.mGid1 = null;
                    break;
                case EVENT_APP_LOCKED /*35*/:
                    onLocked();
                    break;
                default:
                    super.handleMessage(msg);
                    break;
            }
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        } catch (RuntimeException exc) {
            logw("Exception parsing SIM record", exc);
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        } catch (Throwable th) {
            if (isRecordLoadResponse) {
                onRecordLoaded();
            }
        }
    }

    private void handleFileUpdate(int efid) {
        switch (efid) {
            case IccConstants.EF_CSP_CPHS /*28437*/:
                this.mRecordsToLoad++;
                log("[CSP] SIM Refresh for EF_CSP_CPHS");
                this.mFh.loadEFTransparent(IccConstants.EF_CSP_CPHS, obtainMessage(EVENT_GET_CSP_CPHS_DONE));
            case IccConstants.EF_MAILBOX_CPHS /*28439*/:
                this.mRecordsToLoad++;
                new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MAILBOX_CPHS, IccConstants.EF_EXT1, 1, obtainMessage(EVENT_GET_CPHS_MAILBOX_DONE));
            case IccConstants.EF_FDN /*28475*/:
                log("SIM Refresh called for EF_FDN");
                this.mParentApp.queryFdn();
            case IccConstants.EF_MBDN /*28615*/:
                this.mRecordsToLoad++;
                new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MBDN, IccConstants.EF_EXT6, this.mMailboxIndex, obtainMessage(EVENT_GET_MBDN_DONE));
            default:
                this.mAdnCache.reset();
                fetchSimRecords();
        }
    }

    private void handleSimRefresh(IccRefreshResponse refreshResponse) {
        if (refreshResponse == null) {
            log("handleSimRefresh received without input");
        } else if (refreshResponse.aid == null || refreshResponse.aid.equals(this.mParentApp.getAid())) {
            switch (refreshResponse.refreshResult) {
                case CharacterSets.ANY_CHARSET /*0*/:
                    log("handleSimRefresh with SIM_FILE_UPDATED");
                    handleFileUpdate(refreshResponse.efId);
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    log("handleSimRefresh with SIM_REFRESH_INIT");
                    onIccRefreshInit();
                case CFIS_BCD_NUMBER_LENGTH_OFFSET /*2*/:
                    log("handleSimRefresh with SIM_REFRESH_RESET");
                default:
                    log("handleSimRefresh with unknown operation");
            }
        }
    }

    private int dispatchGsmMessage(SmsMessage message) {
        this.mNewSmsRegistrants.notifyResult(message);
        return 0;
    }

    private void handleSms(byte[] ba) {
        if (ba[0] != null) {
            Rlog.d("ENF", "status : " + ba[0]);
        }
        if (ba[0] == EVENT_GET_IMSI_DONE) {
            int n = ba.length;
            byte[] pdu = new byte[(n - 1)];
            System.arraycopy(ba, 1, pdu, 0, n - 1);
            dispatchGsmMessage(SmsMessage.createFromPdu(pdu, SmsMessage.FORMAT_3GPP));
        }
    }

    private void handleSmses(ArrayList<byte[]> messages) {
        int count = messages.size();
        for (int i = 0; i < count; i++) {
            byte[] ba = (byte[]) messages.get(i);
            if (ba[0] != null) {
                Rlog.i("ENF", "status " + i + ": " + ba[0]);
            }
            if (ba[0] == EVENT_GET_IMSI_DONE) {
                int n = ba.length;
                byte[] pdu = new byte[(n - 1)];
                System.arraycopy(ba, 1, pdu, 0, n - 1);
                dispatchGsmMessage(SmsMessage.createFromPdu(pdu, SmsMessage.FORMAT_3GPP));
                ba[0] = (byte) 1;
            }
        }
    }

    private String findBestLanguage(byte[] languages) {
        String[] locales = this.mContext.getAssets().getLocales();
        if (languages == null || locales == null) {
            return null;
        }
        int i = 0;
        while (i + 1 < languages.length) {
            try {
                String lang = new String(languages, i, CFIS_BCD_NUMBER_LENGTH_OFFSET, "ISO-8859-1");
                log("languages from sim = " + lang);
                int j = 0;
                while (j < locales.length) {
                    if (locales[j] != null && locales[j].length() >= CFIS_BCD_NUMBER_LENGTH_OFFSET && locales[j].substring(0, CFIS_BCD_NUMBER_LENGTH_OFFSET).equalsIgnoreCase(lang)) {
                        return lang;
                    }
                    j++;
                }
                if (null != null) {
                    break;
                }
                i += CFIS_BCD_NUMBER_LENGTH_OFFSET;
            } catch (UnsupportedEncodingException e) {
                log("Failed to parse USIM language records" + e);
            }
        }
        return null;
    }

    private void setLocaleFromUsim() {
        String prefLang = findBestLanguage(this.mEfLi);
        if (prefLang == null) {
            prefLang = findBestLanguage(this.mEfPl);
        }
        if (prefLang != null) {
            String imsi = getIMSI();
            String country = null;
            if (imsi != null) {
                country = MccTable.countryCodeForMcc(Integer.parseInt(imsi.substring(0, EVENT_GET_IMSI_DONE)));
            }
            log("Setting locale to " + prefLang + "_" + country);
            MccTable.setSystemLocale(this.mContext, prefLang, country);
            return;
        }
        log("No suitable USIM selected locale");
    }

    protected void onRecordLoaded() {
        this.mRecordsToLoad--;
        log("onRecordLoaded " + this.mRecordsToLoad + " requested: " + this.mRecordsRequested);
        if (this.mRecordsToLoad == 0 && this.mRecordsRequested) {
            onAllRecordsLoaded();
        } else if (this.mRecordsToLoad < 0) {
            loge("recordsToLoad <0, programmer error suspected");
            this.mRecordsToLoad = 0;
        }
    }

    protected void onAllRecordsLoaded() {
        log("record load complete");
        setLocaleFromUsim();
        if (this.mParentApp.getState() == AppState.APPSTATE_PIN || this.mParentApp.getState() == AppState.APPSTATE_PUK) {
            this.mRecordsRequested = CRASH_RIL;
            return;
        }
        String operator = getOperatorNumeric();
        if (TextUtils.isEmpty(operator)) {
            log("onAllRecordsLoaded empty 'gsm.sim.operator.numeric' skipping");
        } else {
            log("onAllRecordsLoaded set 'gsm.sim.operator.numeric' to operator='" + operator + "'");
            log("update icc_operator_numeric=" + operator);
            this.mTelephonyManager.setSimOperatorNumericForPhone(this.mParentApp.getPhoneId(), operator);
            SubscriptionController subController = SubscriptionController.getInstance();
            subController.setMccMnc(operator, subController.getDefaultSmsSubId());
        }
        if (TextUtils.isEmpty(this.mImsi)) {
            log("onAllRecordsLoaded empty imsi skipping setting mcc");
        } else {
            log("onAllRecordsLoaded set mcc imsi=" + this.mImsi);
            this.mTelephonyManager.setSimCountryIsoForPhone(this.mParentApp.getPhoneId(), MccTable.countryCodeForMcc(Integer.parseInt(this.mImsi.substring(0, EVENT_GET_IMSI_DONE))));
        }
        setVoiceMailByCountry(operator);
        setSpnFromConfig(operator);
        this.mRecordsLoadedRegistrants.notifyRegistrants(new AsyncResult(null, null, null));
    }

    private void setSpnFromConfig(String carrier) {
        if (this.mSpnOverride.containsCarrier(carrier)) {
            setServiceProviderName(this.mSpnOverride.getSpn(carrier));
            this.mTelephonyManager.setSimOperatorNameForPhone(this.mParentApp.getPhoneId(), getServiceProviderName());
        }
    }

    private void setVoiceMailByCountry(String spn) {
        if (this.mVmConfig.containsCarrier(spn)) {
            this.mIsVoiceMailFixed = true;
            this.mVoiceMailNum = this.mVmConfig.getVoiceMailNumber(spn);
            this.mVoiceMailTag = this.mVmConfig.getVoiceMailTag(spn);
        }
    }

    public void onReady() {
        fetchSimRecords();
    }

    private void onLocked() {
        log("only fetch EF_LI and EF_PL in lock state");
        loadEfLiAndEfPl();
    }

    private void loadEfLiAndEfPl() {
        if (!Resources.getSystem().getBoolean(17957012)) {
            log("Not using EF LI/EF PL");
        } else if (this.mParentApp.getType() == AppType.APPTYPE_USIM) {
            this.mRecordsRequested = true;
            this.mFh.loadEFTransparent(IccConstants.EF_LI, obtainMessage(100, new EfUsimLiLoaded()));
            this.mRecordsToLoad++;
            this.mFh.loadEFTransparent(IccConstants.EF_PL, obtainMessage(100, new EfPlLoaded()));
            this.mRecordsToLoad++;
        }
    }

    protected void fetchSimRecords() {
        this.mRecordsRequested = true;
        log("fetchSimRecords " + this.mRecordsToLoad);
        this.mCi.getIMSIForApp(this.mParentApp.getAid(), obtainMessage(EVENT_GET_IMSI_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_ICCID, obtainMessage(EVENT_GET_ICCID_DONE));
        this.mRecordsToLoad++;
        new AdnRecordLoader(this.mFh).loadFromEF(IccConstants.EF_MSISDN, IccConstants.EF_EXT1, 1, obtainMessage(EVENT_GET_MSISDN_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixed(IccConstants.EF_MBI, 1, obtainMessage(EVENT_GET_MBI_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_AD, obtainMessage(EVENT_GET_AD_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixed(IccConstants.EF_MWIS, 1, obtainMessage(EVENT_GET_MWIS_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_VOICE_MAIL_INDICATOR_CPHS, obtainMessage(EVENT_GET_VOICE_MAIL_INDICATOR_CPHS_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixed(IccConstants.EF_CFIS, 1, obtainMessage(EVENT_GET_CFIS_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_CFF_CPHS, obtainMessage(EVENT_GET_CFF_DONE));
        this.mRecordsToLoad++;
        getSpnFsm(true, null);
        this.mFh.loadEFTransparent(IccConstants.EF_SPDI, obtainMessage(EVENT_GET_SPDI_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFLinearFixed(IccConstants.EF_PNN, 1, obtainMessage(EVENT_GET_PNN_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_SST, obtainMessage(EVENT_GET_SST_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_INFO_CPHS, obtainMessage(EVENT_GET_INFO_CPHS_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_CSP_CPHS, obtainMessage(EVENT_GET_CSP_CPHS_DONE));
        this.mRecordsToLoad++;
        this.mFh.loadEFTransparent(IccConstants.EF_GID1, obtainMessage(EVENT_GET_GID1_DONE));
        this.mRecordsToLoad++;
        loadEfLiAndEfPl();
        log("fetchSimRecords " + this.mRecordsToLoad + " requested: " + this.mRecordsRequested);
    }

    public int getDisplayRule(String plmn) {
        if (this.mParentApp != null && this.mParentApp.getUiccCard() != null && this.mParentApp.getUiccCard().getOperatorBrandOverride() != null) {
            return CFIS_BCD_NUMBER_LENGTH_OFFSET;
        }
        if (TextUtils.isEmpty(getServiceProviderName()) || this.mSpnDisplayCondition == -1) {
            return CFIS_BCD_NUMBER_LENGTH_OFFSET;
        }
        if (isOnMatchingPlmn(plmn)) {
            if ((this.mSpnDisplayCondition & 1) == 1) {
                return 1 | CFIS_BCD_NUMBER_LENGTH_OFFSET;
            }
            return 1;
        } else if ((this.mSpnDisplayCondition & CFIS_BCD_NUMBER_LENGTH_OFFSET) == 0) {
            return CFIS_BCD_NUMBER_LENGTH_OFFSET | 1;
        } else {
            return CFIS_BCD_NUMBER_LENGTH_OFFSET;
        }
    }

    private boolean isOnMatchingPlmn(String plmn) {
        if (plmn == null) {
            return CRASH_RIL;
        }
        if (plmn.equals(getOperatorNumeric())) {
            return true;
        }
        if (this.mSpdiNetworks == null) {
            return CRASH_RIL;
        }
        Iterator i$ = this.mSpdiNetworks.iterator();
        while (i$.hasNext()) {
            if (plmn.equals((String) i$.next())) {
                return true;
            }
        }
        return CRASH_RIL;
    }

    private void getSpnFsm(boolean start, AsyncResult ar) {
        if (start) {
            if (this.mSpnState == GetSpnFsmState.READ_SPN_3GPP || this.mSpnState == GetSpnFsmState.READ_SPN_CPHS || this.mSpnState == GetSpnFsmState.READ_SPN_SHORT_CPHS || this.mSpnState == GetSpnFsmState.INIT) {
                this.mSpnState = GetSpnFsmState.INIT;
                return;
            }
            this.mSpnState = GetSpnFsmState.INIT;
        }
        byte[] data;
        switch (C00871.f11xdc363d50[this.mSpnState.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                setServiceProviderName(null);
                this.mFh.loadEFTransparent(IccConstants.EF_SPN, obtainMessage(EVENT_GET_SPN_DONE));
                this.mRecordsToLoad++;
                this.mSpnState = GetSpnFsmState.READ_SPN_3GPP;
            case CFIS_BCD_NUMBER_LENGTH_OFFSET /*2*/:
                if (ar == null || ar.exception != null) {
                    this.mFh.loadEFTransparent(IccConstants.EF_SPN_CPHS, obtainMessage(EVENT_GET_SPN_DONE));
                    this.mRecordsToLoad++;
                    this.mSpnState = GetSpnFsmState.READ_SPN_CPHS;
                    this.mSpnDisplayCondition = -1;
                    return;
                }
                data = (byte[]) ar.result;
                this.mSpnDisplayCondition = data[0] & PduHeaders.STORE_STATUS_ERROR_END;
                setServiceProviderName(IccUtils.adnStringFieldToString(data, 1, data.length - 1));
                log("Load EF_SPN: " + getServiceProviderName() + " spnDisplayCondition: " + this.mSpnDisplayCondition);
                this.mTelephonyManager.setSimOperatorNameForPhone(this.mParentApp.getPhoneId(), getServiceProviderName());
                this.mSpnState = GetSpnFsmState.IDLE;
            case EVENT_GET_IMSI_DONE /*3*/:
                if (ar == null || ar.exception != null) {
                    this.mFh.loadEFTransparent(IccConstants.EF_SPN_SHORT_CPHS, obtainMessage(EVENT_GET_SPN_DONE));
                    this.mRecordsToLoad++;
                    this.mSpnState = GetSpnFsmState.READ_SPN_SHORT_CPHS;
                    return;
                }
                data = (byte[]) ar.result;
                setServiceProviderName(IccUtils.adnStringFieldToString(data, 0, data.length));
                log("Load EF_SPN_CPHS: " + getServiceProviderName());
                this.mTelephonyManager.setSimOperatorNameForPhone(this.mParentApp.getPhoneId(), getServiceProviderName());
                this.mSpnState = GetSpnFsmState.IDLE;
            case EVENT_GET_ICCID_DONE /*4*/:
                if (ar == null || ar.exception != null) {
                    log("No SPN loaded in either CHPS or 3GPP");
                } else {
                    data = (byte[]) ar.result;
                    setServiceProviderName(IccUtils.adnStringFieldToString(data, 0, data.length));
                    log("Load EF_SPN_SHORT_CPHS: " + getServiceProviderName());
                    this.mTelephonyManager.setSimOperatorNameForPhone(this.mParentApp.getPhoneId(), getServiceProviderName());
                }
                this.mSpnState = GetSpnFsmState.IDLE;
            default:
                this.mSpnState = GetSpnFsmState.IDLE;
        }
    }

    private void parseEfSpdi(byte[] data) {
        SimTlv tlv = new SimTlv(data, 0, data.length);
        byte[] plmnEntries = null;
        while (tlv.isValidObject()) {
            if (tlv.getTag() == TAG_SPDI) {
                tlv = new SimTlv(tlv.getData(), 0, tlv.getData().length);
            }
            if (tlv.getTag() == TAG_SPDI_PLMN_LIST) {
                plmnEntries = tlv.getData();
                break;
            }
            tlv.nextObject();
        }
        if (plmnEntries != null) {
            this.mSpdiNetworks = new ArrayList(plmnEntries.length / EVENT_GET_IMSI_DONE);
            for (int i = 0; i + CFIS_BCD_NUMBER_LENGTH_OFFSET < plmnEntries.length; i += EVENT_GET_IMSI_DONE) {
                String plmnCode = IccUtils.bcdToString(plmnEntries, i, EVENT_GET_IMSI_DONE);
                if (plmnCode.length() >= EVENT_GET_MBI_DONE) {
                    log("EF_SPDI network: " + plmnCode);
                    this.mSpdiNetworks.add(plmnCode);
                }
            }
        }
    }

    private boolean isCphsMailboxEnabled() {
        boolean z = true;
        if (this.mCphsInfo == null) {
            return CRASH_RIL;
        }
        if ((this.mCphsInfo[1] & CPHS_SST_MBN_MASK) != CPHS_SST_MBN_MASK) {
            z = false;
        }
        return z;
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, "[SIMRecords] " + s);
    }

    protected void loge(String s) {
        Rlog.e(LOG_TAG, "[SIMRecords] " + s);
    }

    protected void logw(String s, Throwable tr) {
        Rlog.w(LOG_TAG, "[SIMRecords] " + s, tr);
    }

    protected void logv(String s) {
        Rlog.v(LOG_TAG, "[SIMRecords] " + s);
    }

    public boolean isCspPlmnEnabled() {
        return this.mCspPlmnEnabled;
    }

    private void handleEfCspData(byte[] data) {
        int usedCspGroups = data.length / CFIS_BCD_NUMBER_LENGTH_OFFSET;
        this.mCspPlmnEnabled = true;
        for (int i = 0; i < usedCspGroups; i++) {
            if (data[i * CFIS_BCD_NUMBER_LENGTH_OFFSET] == (byte) -64) {
                log("[CSP] found ValueAddedServicesGroup, value " + data[(i * CFIS_BCD_NUMBER_LENGTH_OFFSET) + 1]);
                if ((data[(i * CFIS_BCD_NUMBER_LENGTH_OFFSET) + 1] & TAG_SPDI_PLMN_LIST) == TAG_SPDI_PLMN_LIST) {
                    this.mCspPlmnEnabled = true;
                    return;
                }
                this.mCspPlmnEnabled = CRASH_RIL;
                log("[CSP] Set Automatic Network Selection");
                this.mNetworkSelectionModeAutomaticRegistrants.notifyRegistrants();
                return;
            }
        }
        log("[CSP] Value Added Service Group (0xC0), not found!");
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("SIMRecords: " + this);
        pw.println(" extends:");
        super.dump(fd, pw, args);
        pw.println(" mVmConfig=" + this.mVmConfig);
        pw.println(" mSpnOverride=" + this.mSpnOverride);
        pw.println(" mCallForwardingEnabled=" + this.mCallForwardingEnabled);
        pw.println(" mSpnState=" + this.mSpnState);
        pw.println(" mCphsInfo=" + this.mCphsInfo);
        pw.println(" mCspPlmnEnabled=" + this.mCspPlmnEnabled);
        pw.println(" mEfMWIS[]=" + Arrays.toString(this.mEfMWIS));
        pw.println(" mEfCPHS_MWI[]=" + Arrays.toString(this.mEfCPHS_MWI));
        pw.println(" mEfCff[]=" + Arrays.toString(this.mEfCff));
        pw.println(" mEfCfis[]=" + Arrays.toString(this.mEfCfis));
        pw.println(" mSpnDisplayCondition=" + this.mSpnDisplayCondition);
        pw.println(" mSpdiNetworks[]=" + this.mSpdiNetworks);
        pw.println(" mPnnHomeName=" + this.mPnnHomeName);
        pw.println(" mUsimServiceTable=" + this.mUsimServiceTable);
        pw.println(" mGid1=" + this.mGid1);
        pw.flush();
    }
}
