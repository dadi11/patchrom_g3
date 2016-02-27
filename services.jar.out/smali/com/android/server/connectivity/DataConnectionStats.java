package com.android.server.connectivity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.RemoteException;
import android.telephony.PhoneStateListener;
import android.telephony.ServiceState;
import android.telephony.SignalStrength;
import android.telephony.TelephonyManager;
import android.util.Log;
import com.android.internal.app.IBatteryStats;
import com.android.internal.telephony.IccCardConstants.State;
import com.android.server.am.BatteryStatsService;

public class DataConnectionStats extends BroadcastReceiver {
    private static final boolean DEBUG = false;
    private static final String TAG = "DataConnectionStats";
    private final IBatteryStats mBatteryStats;
    private final Context mContext;
    private int mDataState;
    private final PhoneStateListener mPhoneStateListener;
    private ServiceState mServiceState;
    private SignalStrength mSignalStrength;
    private State mSimState;

    /* renamed from: com.android.server.connectivity.DataConnectionStats.1 */
    class C01631 extends PhoneStateListener {
        C01631() {
        }

        public void onSignalStrengthsChanged(SignalStrength signalStrength) {
            DataConnectionStats.this.mSignalStrength = signalStrength;
        }

        public void onServiceStateChanged(ServiceState state) {
            DataConnectionStats.this.mServiceState = state;
            DataConnectionStats.this.notePhoneDataConnectionState();
        }

        public void onDataConnectionStateChanged(int state, int networkType) {
            DataConnectionStats.this.mDataState = state;
            DataConnectionStats.this.notePhoneDataConnectionState();
        }

        public void onDataActivity(int direction) {
            DataConnectionStats.this.notePhoneDataConnectionState();
        }
    }

    public DataConnectionStats(Context context) {
        this.mSimState = State.READY;
        this.mDataState = 0;
        this.mPhoneStateListener = new C01631();
        this.mContext = context;
        this.mBatteryStats = BatteryStatsService.getService();
    }

    public void startMonitoring() {
        ((TelephonyManager) this.mContext.getSystemService("phone")).listen(this.mPhoneStateListener, 449);
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.SIM_STATE_CHANGED");
        filter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
        filter.addAction("android.net.conn.INET_CONDITION_ACTION");
        this.mContext.registerReceiver(this, filter);
    }

    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals("android.intent.action.SIM_STATE_CHANGED")) {
            updateSimState(intent);
            notePhoneDataConnectionState();
        } else if (action.equals("android.net.conn.CONNECTIVITY_CHANGE") || action.equals("android.net.conn.INET_CONDITION_ACTION")) {
            notePhoneDataConnectionState();
        }
    }

    private void notePhoneDataConnectionState() {
        boolean visible = true;
        if (this.mServiceState != null) {
            boolean simReadyOrUnknown;
            if (this.mSimState == State.READY || this.mSimState == State.UNKNOWN) {
                simReadyOrUnknown = true;
            } else {
                simReadyOrUnknown = DEBUG;
            }
            if (!((simReadyOrUnknown || isCdma()) && hasService() && this.mDataState == 2)) {
                visible = DEBUG;
            }
            try {
                this.mBatteryStats.notePhoneDataConnectionState(this.mServiceState.getDataNetworkType(), visible);
            } catch (RemoteException e) {
                Log.w(TAG, "Error noting data connection state", e);
            }
        }
    }

    private final void updateSimState(Intent intent) {
        String stateExtra = intent.getStringExtra("ss");
        if ("ABSENT".equals(stateExtra)) {
            this.mSimState = State.ABSENT;
        } else if ("READY".equals(stateExtra)) {
            this.mSimState = State.READY;
        } else if ("LOCKED".equals(stateExtra)) {
            String lockedReason = intent.getStringExtra("reason");
            if ("PIN".equals(lockedReason)) {
                this.mSimState = State.PIN_REQUIRED;
            } else if ("PUK".equals(lockedReason)) {
                this.mSimState = State.PUK_REQUIRED;
            } else {
                this.mSimState = State.NETWORK_LOCKED;
            }
        } else {
            this.mSimState = State.UNKNOWN;
        }
    }

    private boolean isCdma() {
        return (this.mSignalStrength == null || this.mSignalStrength.isGsm()) ? DEBUG : true;
    }

    private boolean hasService() {
        return (this.mServiceState == null || this.mServiceState.getState() == 1 || this.mServiceState.getState() == 3) ? DEBUG : true;
    }
}
