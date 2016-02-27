package android.net;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.SystemClock;
import android.util.Log;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;

public class DhcpStateMachine extends StateMachine {
    private static final String ACTION_DHCP_RENEW = "android.net.wifi.DHCP_RENEW";
    private static final int BASE = 196608;
    public static final int CMD_ON_QUIT = 196614;
    public static final int CMD_POST_DHCP_ACTION = 196613;
    public static final int CMD_PRE_DHCP_ACTION = 196612;
    public static final int CMD_PRE_DHCP_ACTION_COMPLETE = 196615;
    public static final int CMD_RENEW_DHCP = 196611;
    public static final int CMD_START_DHCP = 196609;
    public static final int CMD_STOP_DHCP = 196610;
    private static final boolean DBG = false;
    public static final int DHCP_FAILURE = 2;
    private static final int DHCP_RENEW = 0;
    public static final int DHCP_SUCCESS = 1;
    private static final int MIN_RENEWAL_TIME_SECS = 300;
    private static final String TAG = "DhcpStateMachine";
    private static final String WAKELOCK_TAG = "DHCP";
    private AlarmManager mAlarmManager;
    private BroadcastReceiver mBroadcastReceiver;
    private Context mContext;
    private StateMachine mController;
    private State mDefaultState;
    private WakeLock mDhcpRenewWakeLock;
    private PendingIntent mDhcpRenewalIntent;
    private DhcpResults mDhcpResults;
    private final String mInterfaceName;
    private boolean mRegisteredForPreDhcpNotification;
    private State mRunningState;
    private State mStoppedState;
    private State mWaitBeforeRenewalState;
    private State mWaitBeforeStartState;

    /* renamed from: android.net.DhcpStateMachine.1 */
    class C04761 extends BroadcastReceiver {
        C04761() {
        }

        public void onReceive(Context context, Intent intent) {
            DhcpStateMachine.this.mDhcpRenewWakeLock.acquire(40000);
            DhcpStateMachine.this.sendMessage(DhcpStateMachine.CMD_RENEW_DHCP);
        }
    }

    class DefaultState extends State {
        DefaultState() {
        }

        public void exit() {
            DhcpStateMachine.this.mContext.unregisterReceiver(DhcpStateMachine.this.mBroadcastReceiver);
        }

        public boolean processMessage(Message message) {
            switch (message.what) {
                case DhcpStateMachine.CMD_RENEW_DHCP /*196611*/:
                    Log.e(DhcpStateMachine.TAG, "Error! Failed to handle a DHCP renewal on " + DhcpStateMachine.this.mInterfaceName);
                    DhcpStateMachine.this.mDhcpRenewWakeLock.release();
                    break;
                default:
                    Log.e(DhcpStateMachine.TAG, "Error! unhandled message  " + message);
                    break;
            }
            return true;
        }
    }

    private enum DhcpAction {
        START,
        RENEW
    }

    class RunningState extends State {
        RunningState() {
        }

        public void enter() {
        }

        public boolean processMessage(Message message) {
            switch (message.what) {
                case DhcpStateMachine.CMD_START_DHCP /*196609*/:
                    return true;
                case DhcpStateMachine.CMD_STOP_DHCP /*196610*/:
                    DhcpStateMachine.this.mAlarmManager.cancel(DhcpStateMachine.this.mDhcpRenewalIntent);
                    if (!NetworkUtils.stopDhcp(DhcpStateMachine.this.mInterfaceName)) {
                        Log.e(DhcpStateMachine.TAG, "Failed to stop Dhcp on " + DhcpStateMachine.this.mInterfaceName);
                    }
                    DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    return true;
                case DhcpStateMachine.CMD_RENEW_DHCP /*196611*/:
                    if (DhcpStateMachine.this.mRegisteredForPreDhcpNotification) {
                        DhcpStateMachine.this.mController.sendMessage(DhcpStateMachine.CMD_PRE_DHCP_ACTION);
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mWaitBeforeRenewalState);
                        return true;
                    }
                    if (!DhcpStateMachine.this.runDhcp(DhcpAction.RENEW)) {
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    }
                    DhcpStateMachine.this.mDhcpRenewWakeLock.release();
                    return true;
                default:
                    return DhcpStateMachine.DBG;
            }
        }
    }

    class StoppedState extends State {
        StoppedState() {
        }

        public void enter() {
        }

        public boolean processMessage(Message message) {
            switch (message.what) {
                case DhcpStateMachine.CMD_START_DHCP /*196609*/:
                    if (DhcpStateMachine.this.mRegisteredForPreDhcpNotification) {
                        DhcpStateMachine.this.mController.sendMessage(DhcpStateMachine.CMD_PRE_DHCP_ACTION);
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mWaitBeforeStartState);
                        return true;
                    } else if (!DhcpStateMachine.this.runDhcp(DhcpAction.START)) {
                        return true;
                    } else {
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mRunningState);
                        return true;
                    }
                case DhcpStateMachine.CMD_STOP_DHCP /*196610*/:
                    return true;
                default:
                    return DhcpStateMachine.DBG;
            }
        }
    }

    class WaitBeforeRenewalState extends State {
        WaitBeforeRenewalState() {
        }

        public void enter() {
        }

        public boolean processMessage(Message message) {
            switch (message.what) {
                case DhcpStateMachine.CMD_START_DHCP /*196609*/:
                    return true;
                case DhcpStateMachine.CMD_STOP_DHCP /*196610*/:
                    DhcpStateMachine.this.mAlarmManager.cancel(DhcpStateMachine.this.mDhcpRenewalIntent);
                    if (!NetworkUtils.stopDhcp(DhcpStateMachine.this.mInterfaceName)) {
                        Log.e(DhcpStateMachine.TAG, "Failed to stop Dhcp on " + DhcpStateMachine.this.mInterfaceName);
                    }
                    DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    return true;
                case DhcpStateMachine.CMD_PRE_DHCP_ACTION_COMPLETE /*196615*/:
                    if (DhcpStateMachine.this.runDhcp(DhcpAction.RENEW)) {
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mRunningState);
                        return true;
                    }
                    DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    return true;
                default:
                    return DhcpStateMachine.DBG;
            }
        }

        public void exit() {
            DhcpStateMachine.this.mDhcpRenewWakeLock.release();
        }
    }

    class WaitBeforeStartState extends State {
        WaitBeforeStartState() {
        }

        public void enter() {
        }

        public boolean processMessage(Message message) {
            switch (message.what) {
                case DhcpStateMachine.CMD_START_DHCP /*196609*/:
                    return true;
                case DhcpStateMachine.CMD_STOP_DHCP /*196610*/:
                    DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    return true;
                case DhcpStateMachine.CMD_PRE_DHCP_ACTION_COMPLETE /*196615*/:
                    if (DhcpStateMachine.this.runDhcp(DhcpAction.START)) {
                        DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mRunningState);
                        return true;
                    }
                    DhcpStateMachine.this.transitionTo(DhcpStateMachine.this.mStoppedState);
                    return true;
                default:
                    return DhcpStateMachine.DBG;
            }
        }
    }

    private DhcpStateMachine(Context context, StateMachine controller, String intf) {
        super(TAG);
        this.mRegisteredForPreDhcpNotification = DBG;
        this.mDefaultState = new DefaultState();
        this.mStoppedState = new StoppedState();
        this.mWaitBeforeStartState = new WaitBeforeStartState();
        this.mRunningState = new RunningState();
        this.mWaitBeforeRenewalState = new WaitBeforeRenewalState();
        this.mContext = context;
        this.mController = controller;
        this.mInterfaceName = intf;
        this.mAlarmManager = (AlarmManager) this.mContext.getSystemService(Context.ALARM_SERVICE);
        this.mDhcpRenewalIntent = PendingIntent.getBroadcast(this.mContext, DHCP_RENEW, new Intent(ACTION_DHCP_RENEW, null), DHCP_RENEW);
        this.mDhcpRenewWakeLock = ((PowerManager) this.mContext.getSystemService(Context.POWER_SERVICE)).newWakeLock(DHCP_SUCCESS, WAKELOCK_TAG);
        this.mDhcpRenewWakeLock.setReferenceCounted(DBG);
        this.mBroadcastReceiver = new C04761();
        this.mContext.registerReceiver(this.mBroadcastReceiver, new IntentFilter(ACTION_DHCP_RENEW));
        addState(this.mDefaultState);
        addState(this.mStoppedState, this.mDefaultState);
        addState(this.mWaitBeforeStartState, this.mDefaultState);
        addState(this.mRunningState, this.mDefaultState);
        addState(this.mWaitBeforeRenewalState, this.mDefaultState);
        setInitialState(this.mStoppedState);
    }

    public static DhcpStateMachine makeDhcpStateMachine(Context context, StateMachine controller, String intf) {
        DhcpStateMachine dsm = new DhcpStateMachine(context, controller, intf);
        dsm.start();
        return dsm;
    }

    public void registerForPreDhcpNotification() {
        this.mRegisteredForPreDhcpNotification = true;
    }

    public void doQuit() {
        quit();
    }

    protected void onQuitting() {
        this.mController.sendMessage(CMD_ON_QUIT);
    }

    private boolean runDhcp(DhcpAction dhcpAction) {
        boolean success = DBG;
        DhcpResults dhcpResults = new DhcpResults();
        if (dhcpAction == DhcpAction.START) {
            NetworkUtils.stopDhcp(this.mInterfaceName);
            success = NetworkUtils.runDhcp(this.mInterfaceName, dhcpResults);
        } else if (dhcpAction == DhcpAction.RENEW) {
            success = NetworkUtils.runDhcpRenew(this.mInterfaceName, dhcpResults);
            if (success) {
                dhcpResults.updateFromDhcpRequest(this.mDhcpResults);
            }
        }
        if (success) {
            long leaseDuration = (long) dhcpResults.leaseDuration;
            if (leaseDuration >= 0) {
                if (leaseDuration < 300) {
                    leaseDuration = 300;
                }
                this.mAlarmManager.setExact(DHCP_FAILURE, SystemClock.elapsedRealtime() + (480 * leaseDuration), this.mDhcpRenewalIntent);
            }
            this.mDhcpResults = dhcpResults;
            this.mController.obtainMessage(CMD_POST_DHCP_ACTION, DHCP_SUCCESS, DHCP_RENEW, dhcpResults).sendToTarget();
        } else {
            Log.e(TAG, "DHCP failed on " + this.mInterfaceName + ": " + NetworkUtils.getDhcpError());
            NetworkUtils.stopDhcp(this.mInterfaceName);
            this.mController.obtainMessage(CMD_POST_DHCP_ACTION, DHCP_FAILURE, DHCP_RENEW).sendToTarget();
        }
        return success;
    }
}
