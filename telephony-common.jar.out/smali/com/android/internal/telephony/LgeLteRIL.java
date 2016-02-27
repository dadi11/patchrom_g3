package com.android.internal.telephony;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Message;
import android.os.Parcel;
import android.os.SystemProperties;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.uicc.IccCardApplicationStatus;
import com.android.internal.telephony.uicc.IccCardStatus;

public class LgeLteRIL extends RIL implements CommandsInterface {
    static final String LOG_TAG = "LgeLteRIL";
    private boolean isGSM;
    private Message mPendingGetSimStatus;

    public LgeLteRIL(Context context, int preferredNetworkType, int cdmaSubscription, Integer instanceId) {
        this(context, preferredNetworkType, cdmaSubscription);
        this.mQANElements = 5;
    }

    public LgeLteRIL(Context context, int networkMode, int cdmaSubscription) {
        super(context, networkMode, cdmaSubscription);
        this.isGSM = false;
    }

    protected Object responseIccCardStatus(Parcel p) {
        IccCardApplicationStatus appStatus = null;
        IccCardStatus cardStatus = new IccCardStatus();
        cardStatus.setCardState(p.readInt());
        cardStatus.setUniversalPinState(p.readInt());
        cardStatus.mGsmUmtsSubscriptionAppIndex = p.readInt();
        cardStatus.mCdmaSubscriptionAppIndex = p.readInt();
        cardStatus.mImsSubscriptionAppIndex = p.readInt();
        int numApplications = p.readInt();
        if (numApplications > 8) {
            numApplications = 8;
        }
        cardStatus.mApplications = new IccCardApplicationStatus[numApplications];
        for (int i = 0; i < numApplications; i++) {
            appStatus = new IccCardApplicationStatus();
            appStatus.app_type = appStatus.AppTypeFromRILInt(p.readInt());
            appStatus.app_state = appStatus.AppStateFromRILInt(p.readInt());
            appStatus.perso_substate = appStatus.PersoSubstateFromRILInt(p.readInt());
            appStatus.aid = p.readString();
            appStatus.app_label = p.readString();
            appStatus.pin1_replaced = p.readInt();
            appStatus.pin1 = appStatus.PinStateFromRILInt(p.readInt());
            appStatus.pin2 = appStatus.PinStateFromRILInt(p.readInt());
            int remaining_count_pin1 = p.readInt();
            int remaining_count_puk1 = p.readInt();
            int remaining_count_pin2 = p.readInt();
            int remaining_count_puk2 = p.readInt();
            cardStatus.mApplications[i] = appStatus;
        }
        if (numApplications == 1 && !this.isGSM && appStatus != null && appStatus.app_type == appStatus.AppTypeFromRILInt(2)) {
            cardStatus.mApplications = new IccCardApplicationStatus[(numApplications + 2)];
            cardStatus.mGsmUmtsSubscriptionAppIndex = 0;
            cardStatus.mApplications[cardStatus.mGsmUmtsSubscriptionAppIndex] = appStatus;
            cardStatus.mCdmaSubscriptionAppIndex = 1;
            cardStatus.mImsSubscriptionAppIndex = 2;
            IccCardApplicationStatus appStatus2 = new IccCardApplicationStatus();
            appStatus2.app_type = appStatus2.AppTypeFromRILInt(4);
            appStatus2.app_state = appStatus.app_state;
            appStatus2.perso_substate = appStatus.perso_substate;
            appStatus2.aid = appStatus.aid;
            appStatus2.app_label = appStatus.app_label;
            appStatus2.pin1_replaced = appStatus.pin1_replaced;
            appStatus2.pin1 = appStatus.pin1;
            appStatus2.pin2 = appStatus.pin2;
            cardStatus.mApplications[cardStatus.mCdmaSubscriptionAppIndex] = appStatus2;
            IccCardApplicationStatus appStatus3 = new IccCardApplicationStatus();
            appStatus3.app_type = appStatus3.AppTypeFromRILInt(5);
            appStatus3.app_state = appStatus.app_state;
            appStatus3.perso_substate = appStatus.perso_substate;
            appStatus3.aid = appStatus.aid;
            appStatus3.app_label = appStatus.app_label;
            appStatus3.pin1_replaced = appStatus.pin1_replaced;
            appStatus3.pin1 = appStatus.pin1;
            appStatus3.pin2 = appStatus.pin2;
            cardStatus.mApplications[cardStatus.mImsSubscriptionAppIndex] = appStatus3;
        }
        return cardStatus;
    }

    public void setPhoneType(int phoneType) {
        super.setPhoneType(phoneType);
        this.isGSM = phoneType != 2;
    }

    protected void processUnsolicited(Parcel p) {
        if (this.mRilVersion >= 10) {
            super.processUnsolicited(p);
            return;
        }
        int dataPosition = p.dataPosition();
        int response = p.readInt();
        switch (response) {
            case 1034:
                Object ret = responseInts(p);
                switch (response) {
                    case 1034:
                        unsljLogRet(response, ret);
                        if (SystemProperties.get("ril.socket.reset").equals("1")) {
                            setRadioPower(false, null);
                        }
                        SystemProperties.set("ril.socket.reset", "1");
                        setPreferredNetworkType(this.mPreferredNetworkType, null);
                        setCdmaSubscriptionSource(this.mCdmaSubscription, null);
                        setCellInfoListRate(Integer.MAX_VALUE, null);
                        notifyRegistrantsRilConnectionChanged(((int[]) ret)[0]);
                    default:
                }
            default:
                p.setDataPosition(dataPosition);
                super.processUnsolicited(p);
        }
    }

    public void getHardwareConfig(Message result) {
        if (this.mRilVersion >= 10) {
            super.getHardwareConfig(result);
        } else if (result != null) {
            riljLog("Ignoring call to 'getHardwareConfig' for ril version < 10");
            AsyncResult.forMessage(result, null, new CommandException(Error.REQUEST_NOT_SUPPORTED));
            result.sendToTarget();
        }
    }
}
