package com.android.internal.telephony.uicc;

import android.telephony.Rlog;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.telephony.uicc.IccCardStatus.PinState;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;

public class IccCardApplicationStatus {
    public String aid;
    public String app_label;
    public AppState app_state;
    public AppType app_type;
    public PersoSubState perso_substate;
    public PinState pin1;
    public int pin1_replaced;
    public PinState pin2;

    public enum AppState {
        APPSTATE_UNKNOWN,
        APPSTATE_DETECTED,
        APPSTATE_PIN,
        APPSTATE_PUK,
        APPSTATE_SUBSCRIPTION_PERSO,
        APPSTATE_READY;

        boolean isPinRequired() {
            return this == APPSTATE_PIN;
        }

        boolean isPukRequired() {
            return this == APPSTATE_PUK;
        }

        boolean isSubscriptionPersoEnabled() {
            return this == APPSTATE_SUBSCRIPTION_PERSO;
        }

        boolean isAppReady() {
            return this == APPSTATE_READY;
        }

        boolean isAppNotReady() {
            return this == APPSTATE_UNKNOWN || this == APPSTATE_DETECTED;
        }
    }

    public enum AppType {
        APPTYPE_UNKNOWN,
        APPTYPE_SIM,
        APPTYPE_USIM,
        APPTYPE_RUIM,
        APPTYPE_CSIM,
        APPTYPE_ISIM
    }

    public enum PersoSubState {
        PERSOSUBSTATE_UNKNOWN,
        PERSOSUBSTATE_IN_PROGRESS,
        PERSOSUBSTATE_READY,
        PERSOSUBSTATE_SIM_NETWORK,
        PERSOSUBSTATE_SIM_NETWORK_SUBSET,
        PERSOSUBSTATE_SIM_CORPORATE,
        PERSOSUBSTATE_SIM_SERVICE_PROVIDER,
        PERSOSUBSTATE_SIM_SIM,
        PERSOSUBSTATE_SIM_NETWORK_PUK,
        PERSOSUBSTATE_SIM_NETWORK_SUBSET_PUK,
        PERSOSUBSTATE_SIM_CORPORATE_PUK,
        PERSOSUBSTATE_SIM_SERVICE_PROVIDER_PUK,
        PERSOSUBSTATE_SIM_SIM_PUK,
        PERSOSUBSTATE_RUIM_NETWORK1,
        PERSOSUBSTATE_RUIM_NETWORK2,
        PERSOSUBSTATE_RUIM_HRPD,
        PERSOSUBSTATE_RUIM_CORPORATE,
        PERSOSUBSTATE_RUIM_SERVICE_PROVIDER,
        PERSOSUBSTATE_RUIM_RUIM,
        PERSOSUBSTATE_RUIM_NETWORK1_PUK,
        PERSOSUBSTATE_RUIM_NETWORK2_PUK,
        PERSOSUBSTATE_RUIM_HRPD_PUK,
        PERSOSUBSTATE_RUIM_CORPORATE_PUK,
        PERSOSUBSTATE_RUIM_SERVICE_PROVIDER_PUK,
        PERSOSUBSTATE_RUIM_RUIM_PUK;

        boolean isPersoSubStateUnknown() {
            return this == PERSOSUBSTATE_UNKNOWN;
        }
    }

    public AppType AppTypeFromRILInt(int type) {
        switch (type) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return AppType.APPTYPE_UNKNOWN;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return AppType.APPTYPE_SIM;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return AppType.APPTYPE_USIM;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return AppType.APPTYPE_RUIM;
            case CharacterSets.ISO_8859_1 /*4*/:
                return AppType.APPTYPE_CSIM;
            case CharacterSets.ISO_8859_2 /*5*/:
                return AppType.APPTYPE_ISIM;
            default:
                AppType newType = AppType.APPTYPE_UNKNOWN;
                loge("AppTypeFromRILInt: bad RIL_AppType: " + type + " use APPTYPE_UNKNOWN");
                return newType;
        }
    }

    public AppState AppStateFromRILInt(int state) {
        switch (state) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return AppState.APPSTATE_UNKNOWN;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return AppState.APPSTATE_DETECTED;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return AppState.APPSTATE_PIN;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return AppState.APPSTATE_PUK;
            case CharacterSets.ISO_8859_1 /*4*/:
                return AppState.APPSTATE_SUBSCRIPTION_PERSO;
            case CharacterSets.ISO_8859_2 /*5*/:
                return AppState.APPSTATE_READY;
            default:
                AppState newState = AppState.APPSTATE_UNKNOWN;
                loge("AppStateFromRILInt: bad state: " + state + " use APPSTATE_UNKNOWN");
                return newState;
        }
    }

    public PersoSubState PersoSubstateFromRILInt(int substate) {
        switch (substate) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return PersoSubState.PERSOSUBSTATE_UNKNOWN;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return PersoSubState.PERSOSUBSTATE_IN_PROGRESS;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return PersoSubState.PERSOSUBSTATE_READY;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return PersoSubState.PERSOSUBSTATE_SIM_NETWORK;
            case CharacterSets.ISO_8859_1 /*4*/:
                return PersoSubState.PERSOSUBSTATE_SIM_NETWORK_SUBSET;
            case CharacterSets.ISO_8859_2 /*5*/:
                return PersoSubState.PERSOSUBSTATE_SIM_CORPORATE;
            case CharacterSets.ISO_8859_3 /*6*/:
                return PersoSubState.PERSOSUBSTATE_SIM_SERVICE_PROVIDER;
            case CharacterSets.ISO_8859_4 /*7*/:
                return PersoSubState.PERSOSUBSTATE_SIM_SIM;
            case CharacterSets.ISO_8859_5 /*8*/:
                return PersoSubState.PERSOSUBSTATE_SIM_NETWORK_PUK;
            case CharacterSets.ISO_8859_6 /*9*/:
                return PersoSubState.PERSOSUBSTATE_SIM_NETWORK_SUBSET_PUK;
            case CharacterSets.ISO_8859_7 /*10*/:
                return PersoSubState.PERSOSUBSTATE_SIM_CORPORATE_PUK;
            case CharacterSets.ISO_8859_8 /*11*/:
                return PersoSubState.PERSOSUBSTATE_SIM_SERVICE_PROVIDER_PUK;
            case CharacterSets.ISO_8859_9 /*12*/:
                return PersoSubState.PERSOSUBSTATE_SIM_SIM_PUK;
            case UserData.ASCII_CR_INDEX /*13*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_NETWORK1;
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_NETWORK2;
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_HRPD;
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_CORPORATE;
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_SERVICE_PROVIDER;
            case PduHeaders.MMS_VERSION_1_2 /*18*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_RUIM;
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_NETWORK1_PUK;
            case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_NETWORK2_PUK;
            case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_HRPD_PUK;
            case CallFailCause.NUMBER_CHANGED /*22*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_CORPORATE_PUK;
            case SmsHeader.ELT_ID_OBJECT_DISTR_INDICATOR /*23*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_SERVICE_PROVIDER_PUK;
            case SmsHeader.ELT_ID_STANDARD_WVG_OBJECT /*24*/:
                return PersoSubState.PERSOSUBSTATE_RUIM_RUIM_PUK;
            default:
                PersoSubState newSubState = PersoSubState.PERSOSUBSTATE_UNKNOWN;
                loge("PersoSubstateFromRILInt: bad substate: " + substate + " use PERSOSUBSTATE_UNKNOWN");
                return newSubState;
        }
    }

    public PinState PinStateFromRILInt(int state) {
        switch (state) {
            case CharacterSets.ANY_CHARSET /*0*/:
                return PinState.PINSTATE_UNKNOWN;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return PinState.PINSTATE_ENABLED_NOT_VERIFIED;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return PinState.PINSTATE_ENABLED_VERIFIED;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return PinState.PINSTATE_DISABLED;
            case CharacterSets.ISO_8859_1 /*4*/:
                return PinState.PINSTATE_ENABLED_BLOCKED;
            case CharacterSets.ISO_8859_2 /*5*/:
                return PinState.PINSTATE_ENABLED_PERM_BLOCKED;
            default:
                PinState newPinState = PinState.PINSTATE_UNKNOWN;
                loge("PinStateFromRILInt: bad pin state: " + state + " use PINSTATE_UNKNOWN");
                return newPinState;
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("{").append(this.app_type).append(",").append(this.app_state);
        if (this.app_state == AppState.APPSTATE_SUBSCRIPTION_PERSO) {
            sb.append(",").append(this.perso_substate);
        }
        if (this.app_type == AppType.APPTYPE_CSIM || this.app_type == AppType.APPTYPE_USIM || this.app_type == AppType.APPTYPE_ISIM) {
            sb.append(",pin1=").append(this.pin1);
            sb.append(",pin2=").append(this.pin2);
        }
        sb.append("}");
        return sb.toString();
    }

    private void loge(String s) {
        Rlog.e("IccCardApplicationStatus", s);
    }
}
