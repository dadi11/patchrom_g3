package com.android.internal.telephony.uicc;

import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;

public class IccCardStatus {
    public static final int CARD_MAX_APPS = 8;
    public IccCardApplicationStatus[] mApplications;
    public CardState mCardState;
    public int mCdmaSubscriptionAppIndex;
    public int mGsmUmtsSubscriptionAppIndex;
    public int mImsSubscriptionAppIndex;
    public PinState mUniversalPinState;

    public enum CardState {
        CARDSTATE_ABSENT,
        CARDSTATE_PRESENT,
        CARDSTATE_ERROR;

        boolean isCardPresent() {
            return this == CARDSTATE_PRESENT;
        }
    }

    public enum PinState {
        PINSTATE_UNKNOWN,
        PINSTATE_ENABLED_NOT_VERIFIED,
        PINSTATE_ENABLED_VERIFIED,
        PINSTATE_DISABLED,
        PINSTATE_ENABLED_BLOCKED,
        PINSTATE_ENABLED_PERM_BLOCKED;

        boolean isPermBlocked() {
            return this == PINSTATE_ENABLED_PERM_BLOCKED;
        }

        boolean isPinRequired() {
            return this == PINSTATE_ENABLED_NOT_VERIFIED;
        }

        boolean isPukRequired() {
            return this == PINSTATE_ENABLED_BLOCKED;
        }
    }

    public void setCardState(int state) {
        switch (state) {
            case CharacterSets.ANY_CHARSET /*0*/:
                this.mCardState = CardState.CARDSTATE_ABSENT;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                this.mCardState = CardState.CARDSTATE_PRESENT;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                this.mCardState = CardState.CARDSTATE_ERROR;
            default:
                throw new RuntimeException("Unrecognized RIL_CardState: " + state);
        }
    }

    public void setUniversalPinState(int state) {
        switch (state) {
            case CharacterSets.ANY_CHARSET /*0*/:
                this.mUniversalPinState = PinState.PINSTATE_UNKNOWN;
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                this.mUniversalPinState = PinState.PINSTATE_ENABLED_NOT_VERIFIED;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                this.mUniversalPinState = PinState.PINSTATE_ENABLED_VERIFIED;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                this.mUniversalPinState = PinState.PINSTATE_DISABLED;
            case CharacterSets.ISO_8859_1 /*4*/:
                this.mUniversalPinState = PinState.PINSTATE_ENABLED_BLOCKED;
            case CharacterSets.ISO_8859_2 /*5*/:
                this.mUniversalPinState = PinState.PINSTATE_ENABLED_PERM_BLOCKED;
            default:
                throw new RuntimeException("Unrecognized RIL_PinState: " + state);
        }
    }

    public String toString() {
        IccCardApplicationStatus app;
        StringBuilder sb = new StringBuilder();
        sb.append("IccCardState {").append(this.mCardState).append(",").append(this.mUniversalPinState).append(",num_apps=").append(this.mApplications.length).append(",gsm_id=").append(this.mGsmUmtsSubscriptionAppIndex);
        if (this.mGsmUmtsSubscriptionAppIndex >= 0 && this.mGsmUmtsSubscriptionAppIndex < CARD_MAX_APPS) {
            app = this.mApplications[this.mGsmUmtsSubscriptionAppIndex];
            if (app == null) {
                app = "null";
            }
            sb.append(app);
        }
        sb.append(",cdma_id=").append(this.mCdmaSubscriptionAppIndex);
        if (this.mCdmaSubscriptionAppIndex >= 0 && this.mCdmaSubscriptionAppIndex < CARD_MAX_APPS) {
            app = this.mApplications[this.mCdmaSubscriptionAppIndex];
            if (app == null) {
                app = "null";
            }
            sb.append(app);
        }
        sb.append(",ims_id=").append(this.mImsSubscriptionAppIndex);
        if (this.mImsSubscriptionAppIndex >= 0 && this.mImsSubscriptionAppIndex < CARD_MAX_APPS) {
            app = this.mApplications[this.mImsSubscriptionAppIndex];
            if (app == null) {
                app = "null";
            }
            sb.append(app);
        }
        sb.append("}");
        return sb.toString();
    }
}
