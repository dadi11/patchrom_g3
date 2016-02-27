package com.android.internal.telephony.cat;

import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;

public class ResultException extends CatException {
    private int mAdditionalInfo;
    private String mExplanation;
    private ResultCode mResult;

    /* renamed from: com.android.internal.telephony.cat.ResultException.1 */
    static /* synthetic */ class C00341 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$cat$ResultCode;

        static {
            $SwitchMap$com$android$internal$telephony$cat$ResultCode = new int[ResultCode.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.TERMINAL_CRNTLY_UNABLE_TO_PROCESS.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.NETWORK_CRNTLY_UNABLE_TO_PROCESS.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.LAUNCH_BROWSER_ERROR.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.MULTI_CARDS_CMD_ERROR.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.USIM_CALL_CONTROL_PERMANENT.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.BIP_ERROR.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.FRAMES_ERROR.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.MMS_ERROR.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
        }
    }

    public ResultException(ResultCode result) {
        switch (C00341.$SwitchMap$com$android$internal$telephony$cat$ResultCode[result.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
            case CharacterSets.ISO_8859_3 /*6*/:
            case CharacterSets.ISO_8859_4 /*7*/:
            case CharacterSets.ISO_8859_5 /*8*/:
                throw new AssertionError("For result code, " + result + ", additional information must be given!");
            default:
                this.mResult = result;
                this.mAdditionalInfo = -1;
                this.mExplanation = "";
        }
    }

    public ResultException(ResultCode result, String explanation) {
        this(result);
        this.mExplanation = explanation;
    }

    public ResultException(ResultCode result, int additionalInfo) {
        this(result);
        if (additionalInfo < 0) {
            throw new AssertionError("Additional info must be greater than zero!");
        }
        this.mAdditionalInfo = additionalInfo;
    }

    public ResultException(ResultCode result, int additionalInfo, String explanation) {
        this(result, additionalInfo);
        this.mExplanation = explanation;
    }

    public ResultCode result() {
        return this.mResult;
    }

    public boolean hasAdditionalInfo() {
        return this.mAdditionalInfo >= 0;
    }

    public int additionalInfo() {
        return this.mAdditionalInfo;
    }

    public String explanation() {
        return this.mExplanation;
    }

    public String toString() {
        return "result=" + this.mResult + " additionalInfo=" + this.mAdditionalInfo + " explantion=" + this.mExplanation;
    }
}
