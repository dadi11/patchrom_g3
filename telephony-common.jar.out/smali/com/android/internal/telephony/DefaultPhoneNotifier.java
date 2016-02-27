package com.android.internal.telephony;

import android.net.LinkProperties;
import android.net.NetworkCapabilities;
import android.os.Bundle;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.telephony.CellInfo;
import android.telephony.DataConnectionRealTimeInfo;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.telephony.VoLteServiceState;
import com.android.internal.telephony.Call.State;
import com.android.internal.telephony.ITelephonyRegistry.Stub;
import com.android.internal.telephony.Phone.DataActivityState;
import com.android.internal.telephony.PhoneConstants.DataState;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;
import java.util.List;

public class DefaultPhoneNotifier implements PhoneNotifier {
    private static final boolean DBG = false;
    private static final String LOG_TAG = "DefaultPhoneNotifier";
    protected ITelephonyRegistry mRegistry;

    /* renamed from: com.android.internal.telephony.DefaultPhoneNotifier.1 */
    static /* synthetic */ class C00091 {
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$Call$State;
        static final /* synthetic */ int[] f1x7097fcc7;
        static final /* synthetic */ int[] f2x67a69abf;
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$PhoneConstants$State;

        static {
            $SwitchMap$com$android$internal$telephony$Call$State = new int[State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.ACTIVE.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.HOLDING.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.DIALING.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.ALERTING.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.INCOMING.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.WAITING.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.DISCONNECTED.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$Call$State[State.DISCONNECTING.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
            f1x7097fcc7 = new int[DataActivityState.values().length];
            try {
                f1x7097fcc7[DataActivityState.DATAIN.ordinal()] = 1;
            } catch (NoSuchFieldError e9) {
            }
            try {
                f1x7097fcc7[DataActivityState.DATAOUT.ordinal()] = 2;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f1x7097fcc7[DataActivityState.DATAINANDOUT.ordinal()] = 3;
            } catch (NoSuchFieldError e11) {
            }
            try {
                f1x7097fcc7[DataActivityState.DORMANT.ordinal()] = 4;
            } catch (NoSuchFieldError e12) {
            }
            f2x67a69abf = new int[DataState.values().length];
            try {
                f2x67a69abf[DataState.CONNECTING.ordinal()] = 1;
            } catch (NoSuchFieldError e13) {
            }
            try {
                f2x67a69abf[DataState.CONNECTED.ordinal()] = 2;
            } catch (NoSuchFieldError e14) {
            }
            try {
                f2x67a69abf[DataState.SUSPENDED.ordinal()] = 3;
            } catch (NoSuchFieldError e15) {
            }
            $SwitchMap$com$android$internal$telephony$PhoneConstants$State = new int[PhoneConstants.State.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$PhoneConstants$State[PhoneConstants.State.RINGING.ordinal()] = 1;
            } catch (NoSuchFieldError e16) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$PhoneConstants$State[PhoneConstants.State.OFFHOOK.ordinal()] = 2;
            } catch (NoSuchFieldError e17) {
            }
        }
    }

    public interface IDataStateChangedCallback {
        void onDataStateChanged(int i, String str, String str2, String str3, String str4, boolean z);
    }

    protected DefaultPhoneNotifier() {
        this.mRegistry = Stub.asInterface(ServiceManager.getService("telephony.registry"));
    }

    public void notifyPhoneState(Phone sender) {
        Call ringingCall = sender.getRingingCall();
        int subId = sender.getSubId();
        String incomingNumber = "";
        if (!(ringingCall == null || ringingCall.getEarliestConnection() == null)) {
            incomingNumber = ringingCall.getEarliestConnection().getAddress();
        }
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyCallStateForSubscriber(subId, convertCallState(sender.getState()), incomingNumber);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyServiceState(Phone sender) {
        ServiceState ss = sender.getServiceState();
        int phoneId = sender.getPhoneId();
        int subId = sender.getSubId();
        Rlog.d(LOG_TAG, "nofityServiceState: mRegistry=" + this.mRegistry + " ss=" + ss + " sender=" + sender + " phondId=" + phoneId + " subId=" + subId);
        if (ss == null) {
            ss = new ServiceState();
            ss.setStateOutOfService();
        }
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyServiceStateForPhoneId(phoneId, subId, ss);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifySignalStrength(Phone sender) {
        int subId = sender.getSubId();
        Rlog.d(LOG_TAG, "notifySignalStrength: mRegistry=" + this.mRegistry + " ss=" + sender.getSignalStrength() + " sender=" + sender);
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifySignalStrengthForSubscriber(subId, sender.getSignalStrength());
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyMessageWaitingChanged(Phone sender) {
        int phoneId = sender.getPhoneId();
        int subId = sender.getSubId();
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyMessageWaitingChangedForPhoneId(phoneId, subId, sender.getMessageWaitingIndicator());
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyCallForwardingChanged(Phone sender) {
        int subId = sender.getSubId();
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyCallForwardingChangedForSubscriber(subId, sender.getCallForwardingIndicator());
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyDataActivity(Phone sender) {
        int subId = sender.getSubId();
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyDataActivityForSubscriber(subId, convertDataActivityState(sender.getDataActivityState()));
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyDataConnection(Phone sender, String reason, String apnType, DataState state) {
        doNotifyDataConnection(sender, reason, apnType, state);
    }

    private void doNotifyDataConnection(Phone sender, String reason, String apnType, DataState state) {
        int subId = sender.getSubId();
        long dds = (long) SubscriptionManager.getDefaultDataSubId();
        TelephonyManager telephony = TelephonyManager.getDefault();
        LinkProperties linkProperties = null;
        NetworkCapabilities networkCapabilities = null;
        boolean roaming = DBG;
        if (state == DataState.CONNECTED) {
            linkProperties = sender.getLinkProperties(apnType);
            networkCapabilities = sender.getNetworkCapabilities(apnType);
        }
        ServiceState ss = sender.getServiceState();
        if (ss != null) {
            roaming = ss.getDataRoaming();
        }
        try {
            if (this.mRegistry != null) {
                int dataNetworkType;
                ITelephonyRegistry iTelephonyRegistry = this.mRegistry;
                int convertDataState = convertDataState(state);
                boolean isDataConnectivityPossible = sender.isDataConnectivityPossible(apnType);
                String activeApnHost = sender.getActiveApnHost(apnType);
                if (telephony != null) {
                    dataNetworkType = telephony.getDataNetworkType(subId);
                } else {
                    dataNetworkType = 0;
                }
                iTelephonyRegistry.notifyDataConnectionForSubscriber(subId, convertDataState, isDataConnectivityPossible, reason, activeApnHost, apnType, linkProperties, networkCapabilities, dataNetworkType, roaming);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyDataConnectionFailed(Phone sender, String reason, String apnType) {
        int subId = sender.getSubId();
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyDataConnectionFailedForSubscriber(subId, reason, apnType);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyCellLocation(Phone sender) {
        int subId = sender.getSubId();
        Bundle data = new Bundle();
        sender.getCellLocation().fillInNotifierBundle(data);
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyCellLocationForSubscriber(subId, data);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyCellInfo(Phone sender, List<CellInfo> cellInfo) {
        int subId = sender.getSubId();
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyCellInfoForSubscriber(subId, cellInfo);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyDataConnectionRealTimeInfo(Phone sender, DataConnectionRealTimeInfo dcRtInfo) {
        try {
            this.mRegistry.notifyDataConnectionRealTimeInfo(dcRtInfo);
        } catch (RemoteException e) {
        }
    }

    public void notifyOtaspChanged(Phone sender, int otaspMode) {
        try {
            if (this.mRegistry != null) {
                this.mRegistry.notifyOtaspChanged(otaspMode);
            }
        } catch (RemoteException e) {
        }
    }

    public void notifyPreciseCallState(Phone sender) {
        Call ringingCall = sender.getRingingCall();
        Call foregroundCall = sender.getForegroundCall();
        Call backgroundCall = sender.getBackgroundCall();
        if (ringingCall != null && foregroundCall != null && backgroundCall != null) {
            try {
                this.mRegistry.notifyPreciseCallState(convertPreciseCallState(ringingCall.getState()), convertPreciseCallState(foregroundCall.getState()), convertPreciseCallState(backgroundCall.getState()));
            } catch (RemoteException e) {
            }
        }
    }

    public void notifyDisconnectCause(int cause, int preciseCause) {
        try {
            this.mRegistry.notifyDisconnectCause(cause, preciseCause);
        } catch (RemoteException e) {
        }
    }

    public void notifyPreciseDataConnectionFailed(Phone sender, String reason, String apnType, String apn, String failCause) {
        try {
            this.mRegistry.notifyPreciseDataConnectionFailed(reason, apnType, apn, failCause);
        } catch (RemoteException e) {
        }
    }

    public void notifyVoLteServiceStateChanged(Phone sender, VoLteServiceState lteState) {
        try {
            this.mRegistry.notifyVoLteServiceStateChanged(lteState);
        } catch (RemoteException e) {
        }
    }

    public void notifyOemHookRawEventForSubscriber(int subId, byte[] rawData) {
        try {
            this.mRegistry.notifyOemHookRawEventForSubscriber(subId, rawData);
        } catch (RemoteException e) {
        }
    }

    public static int convertCallState(PhoneConstants.State state) {
        switch (C00091.$SwitchMap$com$android$internal$telephony$PhoneConstants$State[state.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 1;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            default:
                return 0;
        }
    }

    public static PhoneConstants.State convertCallState(int state) {
        switch (state) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return PhoneConstants.State.RINGING;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return PhoneConstants.State.OFFHOOK;
            default:
                return PhoneConstants.State.IDLE;
        }
    }

    public static int convertDataState(DataState state) {
        switch (C00091.f2x67a69abf[state.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 1;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 3;
            default:
                return 0;
        }
    }

    public static DataState convertDataState(int state) {
        switch (state) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return DataState.CONNECTING;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return DataState.CONNECTED;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return DataState.SUSPENDED;
            default:
                return DataState.DISCONNECTED;
        }
    }

    public static int convertDataActivityState(DataActivityState state) {
        switch (C00091.f1x7097fcc7[state.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 1;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 3;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            default:
                return 0;
        }
    }

    public static DataActivityState convertDataActivityState(int state) {
        switch (state) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return DataActivityState.DATAIN;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return DataActivityState.DATAOUT;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return DataActivityState.DATAINANDOUT;
            case CharacterSets.ISO_8859_1 /*4*/:
                return DataActivityState.DORMANT;
            default:
                return DataActivityState.NONE;
        }
    }

    public static int convertPreciseCallState(State state) {
        switch (C00091.$SwitchMap$com$android$internal$telephony$Call$State[state.ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return 1;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return 2;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return 3;
            case CharacterSets.ISO_8859_1 /*4*/:
                return 4;
            case CharacterSets.ISO_8859_2 /*5*/:
                return 5;
            case CharacterSets.ISO_8859_3 /*6*/:
                return 6;
            case CharacterSets.ISO_8859_4 /*7*/:
                return 7;
            case CharacterSets.ISO_8859_5 /*8*/:
                return 8;
            default:
                return 0;
        }
    }

    public static State convertPreciseCallState(int state) {
        switch (state) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                return State.ACTIVE;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                return State.HOLDING;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                return State.DIALING;
            case CharacterSets.ISO_8859_1 /*4*/:
                return State.ALERTING;
            case CharacterSets.ISO_8859_2 /*5*/:
                return State.INCOMING;
            case CharacterSets.ISO_8859_3 /*6*/:
                return State.WAITING;
            case CharacterSets.ISO_8859_4 /*7*/:
                return State.DISCONNECTED;
            case CharacterSets.ISO_8859_5 /*8*/:
                return State.DISCONNECTING;
            default:
                return State.IDLE;
        }
    }

    private void log(String s) {
        Rlog.d(LOG_TAG, s);
    }
}
