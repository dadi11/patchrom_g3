package com.android.internal.telephony.dataconnection;

import android.app.PendingIntent;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.LinkProperties;
import android.net.NetworkAgent;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.NetworkInfo.DetailedState;
import android.net.NetworkMisc;
import android.net.ProxyInfo;
import android.os.AsyncResult;
import android.os.Build;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.telephony.Rlog;
import android.telephony.ServiceState;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Pair;
import android.util.Patterns;
import android.util.TimeUtils;
import com.android.internal.telephony.CommandException;
import com.android.internal.telephony.CommandException.Error;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.RetryManager;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.dataconnection.DataCallResponse.SetupResult;
import com.android.internal.telephony.gsm.CallFailCause;
import com.android.internal.util.AsyncChannel;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPart;
import com.google.android.mms.pdu.PduPersister;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.net.Inet4Address;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;

public final class DataConnection extends StateMachine {
    static final int BASE = 262144;
    private static final int CMD_TO_STRING_COUNT = 14;
    private static final boolean DBG = true;
    private static final String DEFAULT_DATA_RETRY_CONFIG = "default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000";
    static final int EVENT_CONNECT = 262144;
    static final int EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED = 262155;
    static final int EVENT_DATA_CONNECTION_ROAM_OFF = 262157;
    static final int EVENT_DATA_CONNECTION_ROAM_ON = 262156;
    static final int EVENT_DATA_STATE_CHANGED = 262151;
    static final int EVENT_DEACTIVATE_DONE = 262147;
    static final int EVENT_DISCONNECT = 262148;
    static final int EVENT_DISCONNECT_ALL = 262150;
    static final int EVENT_GET_LAST_FAIL_DONE = 262146;
    static final int EVENT_LOST_CONNECTION = 262153;
    static final int EVENT_RETRY_CONNECTION = 262154;
    static final int EVENT_RIL_CONNECTED = 262149;
    static final int EVENT_SETUP_DATA_CONNECTION_DONE = 262145;
    static final int EVENT_TEAR_DOWN_NOW = 262152;
    private static final String NETWORK_TYPE = "MOBILE";
    private static final String NULL_IP = "0.0.0.0";
    private static final String SECONDARY_DATA_RETRY_CONFIG = "max_retries=3, 5000, 5000, 5000";
    private static final String TCP_BUFFER_SIZES_1XRTT = "16384,32768,131072,4096,16384,102400";
    private static final String TCP_BUFFER_SIZES_EDGE = "4093,26280,70800,4096,16384,70800";
    private static final String TCP_BUFFER_SIZES_EHRPD = "131072,262144,1048576,4096,16384,524288";
    private static final String TCP_BUFFER_SIZES_EVDO = "4094,87380,262144,4096,16384,262144";
    private static final String TCP_BUFFER_SIZES_GPRS = "4092,8760,48000,4096,8760,48000";
    private static final String TCP_BUFFER_SIZES_HSDPA = "61167,367002,1101005,8738,52429,262114";
    private static final String TCP_BUFFER_SIZES_HSPA = "40778,244668,734003,16777,100663,301990";
    private static final String TCP_BUFFER_SIZES_HSPAP = "122334,734003,2202010,32040,192239,576717";
    private static final String TCP_BUFFER_SIZES_LTE = "524288,1048576,2097152,262144,524288,1048576";
    private static final String TCP_BUFFER_SIZES_UMTS = "58254,349525,1048576,58254,349525,1048576";
    private static final boolean VDBG = true;
    private static AtomicInteger mInstanceNumber;
    private static String[] sCmdToString;
    private AsyncChannel mAc;
    private DcActivatingState mActivatingState;
    private DcActiveState mActiveState;
    List<ApnContext> mApnContexts;
    private ApnSetting mApnSetting;
    int mCid;
    private ConnectionParams mConnectionParams;
    private long mCreateTime;
    private int mDataRegState;
    private DcController mDcController;
    private DcFailCause mDcFailCause;
    private DcRetryAlarmController mDcRetryAlarmController;
    private DcTesterFailBringUpAll mDcTesterFailBringUpAll;
    private DcTrackerBase mDct;
    private DcDefaultState mDefaultState;
    private DisconnectParams mDisconnectParams;
    private DcDisconnectionErrorCreatingConnection mDisconnectingErrorCreatingConnection;
    private DcDisconnectingState mDisconnectingState;
    private int mId;
    private DcInactiveState mInactiveState;
    private DcFailCause mLastFailCause;
    private long mLastFailTime;
    private LinkProperties mLinkProperties;
    private NetworkAgent mNetworkAgent;
    private NetworkInfo mNetworkInfo;
    protected String[] mPcscfAddr;
    private PhoneBase mPhone;
    PendingIntent mReconnectIntent;
    RetryManager mRetryManager;
    private DcRetryingState mRetryingState;
    private int mRilRat;
    int mTag;
    private Object mUserData;

    /* renamed from: com.android.internal.telephony.dataconnection.DataConnection.1 */
    class C00501 extends PrintWriter {
        C00501(Writer x0) {
            super(x0);
        }

        public void println(String s) {
            DataConnection.this.logd(s);
        }

        public void flush() {
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DataConnection.2 */
    static /* synthetic */ class C00512 {
        static final /* synthetic */ int[] f8xd987aa80;

        static {
            f8xd987aa80 = new int[SetupResult.values().length];
            try {
                f8xd987aa80[SetupResult.SUCCESS.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f8xd987aa80[SetupResult.ERR_BadCommand.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f8xd987aa80[SetupResult.ERR_UnacceptableParameter.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f8xd987aa80[SetupResult.ERR_GetLastErrorFromRil.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f8xd987aa80[SetupResult.ERR_RilError.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f8xd987aa80[SetupResult.ERR_Stale.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
        }
    }

    static class ConnectionParams {
        ApnContext mApnContext;
        int mInitialMaxRetry;
        Message mOnCompletedMsg;
        int mProfileId;
        boolean mRetryWhenSSChange;
        int mRilRat;
        int mTag;

        ConnectionParams(ApnContext apnContext, int initialMaxRetry, int profileId, int rilRadioTechnology, boolean retryWhenSSChange, Message onCompletedMsg) {
            this.mApnContext = apnContext;
            this.mInitialMaxRetry = initialMaxRetry;
            this.mProfileId = profileId;
            this.mRilRat = rilRadioTechnology;
            this.mRetryWhenSSChange = retryWhenSSChange;
            this.mOnCompletedMsg = onCompletedMsg;
        }

        public String toString() {
            return "{mTag=" + this.mTag + " mApnContext=" + this.mApnContext + " mInitialMaxRetry=" + this.mInitialMaxRetry + " mProfileId=" + this.mProfileId + " mRat=" + this.mRilRat + " mOnCompletedMsg=" + DataConnection.msgToString(this.mOnCompletedMsg) + "}";
        }
    }

    private class DcActivatingState extends State {
        private DcActivatingState() {
        }

        public boolean processMessage(Message msg) {
            DataConnection.this.log("DcActivatingState: msg=" + DataConnection.msgToString(msg));
            AsyncResult ar;
            ConnectionParams cp;
            switch (msg.what) {
                case DataConnection.EVENT_CONNECT /*262144*/:
                case DataConnection.EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED /*262155*/:
                    DataConnection.this.deferMessage(msg);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_SETUP_DATA_CONNECTION_DONE /*262145*/:
                    ar = msg.obj;
                    cp = ar.userObj;
                    SetupResult result = DataConnection.this.onSetupConnectionCompleted(ar);
                    if (!(result == SetupResult.ERR_Stale || DataConnection.this.mConnectionParams == cp)) {
                        DataConnection.this.loge("DcActivatingState: WEIRD mConnectionsParams:" + DataConnection.this.mConnectionParams + " != cp:" + cp);
                    }
                    DataConnection.this.log("DcActivatingState onSetupConnectionCompleted result=" + result + " dc=" + DataConnection.this);
                    switch (C00512.f8xd987aa80[result.ordinal()]) {
                        case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                            DataConnection.this.mDcFailCause = DcFailCause.NONE;
                            DataConnection.this.transitionTo(DataConnection.this.mActiveState);
                            break;
                        case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                            DataConnection.this.mInactiveState.setEnterNotificationParams(cp, result.mFailCause);
                            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                            break;
                        case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                            DataConnection.this.tearDownData(cp);
                            DataConnection.this.transitionTo(DataConnection.this.mDisconnectingErrorCreatingConnection);
                            break;
                        case CharacterSets.ISO_8859_1 /*4*/:
                            DataConnection.this.mPhone.mCi.getLastDataCallFailCause(DataConnection.this.obtainMessage(DataConnection.EVENT_GET_LAST_FAIL_DONE, cp));
                            break;
                        case CharacterSets.ISO_8859_2 /*5*/:
                            int delay = DataConnection.this.mDcRetryAlarmController.getSuggestedRetryTime(DataConnection.this, ar);
                            DataConnection.this.log("DcActivatingState: ERR_RilError  delay=" + delay + " isRetryNeeded=" + DataConnection.this.mRetryManager.isRetryNeeded() + " result=" + result + " result.isRestartRadioFail=" + result.mFailCause.isRestartRadioFail() + " result.isPermanentFail=" + DataConnection.this.mDct.isPermanentFail(result.mFailCause));
                            if (!result.mFailCause.isRestartRadioFail()) {
                                if (!DataConnection.this.mDct.isPermanentFail(result.mFailCause)) {
                                    if (delay < 0) {
                                        DataConnection.this.log("DcActivatingState: ERR_RilError no retry");
                                        DataConnection.this.mInactiveState.setEnterNotificationParams(cp, result.mFailCause);
                                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                                        break;
                                    }
                                    DataConnection.this.log("DcActivatingState: ERR_RilError retry");
                                    DataConnection.this.mDcRetryAlarmController.startRetryAlarm(DataConnection.EVENT_RETRY_CONNECTION, DataConnection.this.mTag, delay);
                                    DataConnection.this.transitionTo(DataConnection.this.mRetryingState);
                                    break;
                                }
                                DataConnection.this.log("DcActivatingState: ERR_RilError perm error");
                                DataConnection.this.mInactiveState.setEnterNotificationParams(cp, result.mFailCause);
                                DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                                break;
                            }
                            DataConnection.this.log("DcActivatingState: ERR_RilError restart radio");
                            DataConnection.this.mDct.sendRestartRadio();
                            DataConnection.this.mInactiveState.setEnterNotificationParams(cp, result.mFailCause);
                            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                            break;
                        case CharacterSets.ISO_8859_3 /*6*/:
                            DataConnection.this.loge("DcActivatingState: stale EVENT_SETUP_DATA_CONNECTION_DONE tag:" + cp.mTag + " != mTag:" + DataConnection.this.mTag);
                            break;
                        default:
                            throw new RuntimeException("Unknown SetupResult, should not happen");
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_GET_LAST_FAIL_DONE /*262146*/:
                    ar = (AsyncResult) msg.obj;
                    cp = (ConnectionParams) ar.userObj;
                    if (cp.mTag == DataConnection.this.mTag) {
                        if (DataConnection.this.mConnectionParams != cp) {
                            DataConnection.this.loge("DcActivatingState: WEIRD mConnectionsParams:" + DataConnection.this.mConnectionParams + " != cp:" + cp);
                        }
                        DcFailCause cause = DcFailCause.UNKNOWN;
                        if (ar.exception == null) {
                            cause = DcFailCause.fromInt(((int[]) ar.result)[0]);
                            if (cause == DcFailCause.NONE) {
                                DataConnection.this.log("DcActivatingState msg.what=EVENT_GET_LAST_FAIL_DONE BAD: error was NONE, change to UNKNOWN");
                                cause = DcFailCause.UNKNOWN;
                            }
                        }
                        DataConnection.this.mDcFailCause = cause;
                        int retryDelay = DataConnection.this.mRetryManager.getRetryTimer();
                        DataConnection.this.log("DcActivatingState msg.what=EVENT_GET_LAST_FAIL_DONE cause=" + cause + " retryDelay=" + retryDelay + " isRetryNeeded=" + DataConnection.this.mRetryManager.isRetryNeeded() + " dc=" + DataConnection.this);
                        if (cause.isRestartRadioFail()) {
                            DataConnection.this.log("DcActivatingState: EVENT_GET_LAST_FAIL_DONE restart radio");
                            DataConnection.this.mDct.sendRestartRadio();
                            DataConnection.this.mInactiveState.setEnterNotificationParams(cp, cause);
                            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                        } else if (DataConnection.this.mDct.isPermanentFail(cause)) {
                            DataConnection.this.log("DcActivatingState: EVENT_GET_LAST_FAIL_DONE perm er");
                            DataConnection.this.mInactiveState.setEnterNotificationParams(cp, cause);
                            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                        } else if (retryDelay < 0 || !DataConnection.this.mRetryManager.isRetryNeeded()) {
                            DataConnection.this.log("DcActivatingState: EVENT_GET_LAST_FAIL_DONE no retry");
                            DataConnection.this.mInactiveState.setEnterNotificationParams(cp, cause);
                            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                        } else {
                            DataConnection.this.log("DcActivatingState: EVENT_GET_LAST_FAIL_DONE retry");
                            DataConnection.this.mDcRetryAlarmController.startRetryAlarm(DataConnection.EVENT_RETRY_CONNECTION, DataConnection.this.mTag, retryDelay);
                            DataConnection.this.transitionTo(DataConnection.this.mRetryingState);
                        }
                    } else {
                        DataConnection.this.loge("DcActivatingState: stale EVENT_GET_LAST_FAIL_DONE tag:" + cp.mTag + " != mTag:" + DataConnection.this.mTag);
                    }
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcActivatingState not handled msg.what=" + DataConnection.this.getWhatToString(msg.what) + " RefCount=" + DataConnection.this.mApnContexts.size());
                    return false;
            }
        }
    }

    private class DcActiveState extends State {
        private DcActiveState() {
        }

        public void enter() {
            DataConnection.this.log("DcActiveState: enter dc=" + DataConnection.this);
            if (DataConnection.this.mRetryManager.getRetryCount() != 0) {
                DataConnection.this.log("DcActiveState: connected after retrying call notifyAllOfConnected");
                DataConnection.this.mRetryManager.setRetryCount(0);
            }
            DataConnection.this.notifyAllOfConnected(Phone.REASON_CONNECTED);
            DataConnection.this.mRetryManager.restoreCurMaxRetryCount();
            DataConnection.this.mDcController.addActiveDcByCid(DataConnection.this);
            DataConnection.this.mNetworkInfo.setDetailedState(DetailedState.CONNECTED, DataConnection.this.mNetworkInfo.getReason(), null);
            DataConnection.this.mNetworkInfo.setExtraInfo(DataConnection.this.mApnSetting.apn);
            DataConnection.this.updateTcpBufferSizes(DataConnection.this.mRilRat);
            NetworkMisc misc = new NetworkMisc();
            misc.subscriberId = DataConnection.this.mPhone.getSubscriberId();
            DataConnection.this.mNetworkAgent = new DcNetworkAgent(DataConnection.this.getHandler().getLooper(), DataConnection.this.mPhone.getContext(), "DcNetworkAgent", DataConnection.this.mNetworkInfo, DataConnection.this.makeNetworkCapabilities(), DataConnection.this.mLinkProperties, 50, misc);
        }

        public void exit() {
            DataConnection.this.log("DcActiveState: exit dc=" + this);
            DataConnection.this.mNetworkInfo.setDetailedState(DetailedState.DISCONNECTED, DataConnection.this.mNetworkInfo.getReason(), DataConnection.this.mNetworkInfo.getExtraInfo());
            DataConnection.this.mNetworkAgent.sendNetworkInfo(DataConnection.this.mNetworkInfo);
            DataConnection.this.mNetworkAgent = null;
        }

        public boolean processMessage(Message msg) {
            DisconnectParams dp;
            switch (msg.what) {
                case DataConnection.EVENT_CONNECT /*262144*/:
                    ConnectionParams cp = msg.obj;
                    DataConnection.this.log("DcActiveState: EVENT_CONNECT cp=" + cp + " dc=" + DataConnection.this);
                    if (DataConnection.this.mApnContexts.contains(cp.mApnContext)) {
                        DataConnection.this.log("DcActiveState ERROR already added apnContext=" + cp.mApnContext);
                    } else {
                        DataConnection.this.mApnContexts.add(cp.mApnContext);
                        DataConnection.this.log("DcActiveState msg.what=EVENT_CONNECT RefCount=" + DataConnection.this.mApnContexts.size());
                    }
                    DataConnection.this.notifyConnectCompleted(cp, DcFailCause.NONE, false);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT /*262148*/:
                    dp = msg.obj;
                    DataConnection.this.log("DcActiveState: EVENT_DISCONNECT dp=" + dp + " dc=" + DataConnection.this);
                    if (DataConnection.this.mApnContexts.contains(dp.mApnContext)) {
                        DataConnection.this.log("DcActiveState msg.what=EVENT_DISCONNECT RefCount=" + DataConnection.this.mApnContexts.size());
                        if (DataConnection.this.mApnContexts.size() == 1) {
                            DataConnection.this.mApnContexts.clear();
                            DataConnection.this.mDisconnectParams = dp;
                            DataConnection.this.mConnectionParams = null;
                            dp.mTag = DataConnection.this.mTag;
                            DataConnection.this.tearDownData(dp);
                            DataConnection.this.transitionTo(DataConnection.this.mDisconnectingState);
                        } else {
                            DataConnection.this.mApnContexts.remove(dp.mApnContext);
                            DataConnection.this.notifyDisconnectCompleted(dp, false);
                        }
                    } else {
                        DataConnection.this.log("DcActiveState ERROR no such apnContext=" + dp.mApnContext + " in this dc=" + DataConnection.this);
                        DataConnection.this.notifyDisconnectCompleted(dp, false);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT_ALL /*262150*/:
                    DataConnection.this.log("DcActiveState EVENT_DISCONNECT clearing apn contexts, dc=" + DataConnection.this);
                    dp = (DisconnectParams) msg.obj;
                    DataConnection.this.mDisconnectParams = dp;
                    DataConnection.this.mConnectionParams = null;
                    dp.mTag = DataConnection.this.mTag;
                    DataConnection.this.tearDownData(dp);
                    DataConnection.this.transitionTo(DataConnection.this.mDisconnectingState);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_LOST_CONNECTION /*262153*/:
                    DataConnection.this.log("DcActiveState EVENT_LOST_CONNECTION dc=" + DataConnection.this);
                    if (DataConnection.this.mRetryManager.isRetryNeeded()) {
                        int delayMillis = DataConnection.this.mRetryManager.getRetryTimer();
                        DataConnection.this.log("DcActiveState EVENT_LOST_CONNECTION startRetryAlarm mTag=" + DataConnection.this.mTag + " delay=" + delayMillis + "ms");
                        DataConnection.this.mDcRetryAlarmController.startRetryAlarm(DataConnection.EVENT_RETRY_CONNECTION, DataConnection.this.mTag, delayMillis);
                        DataConnection.this.transitionTo(DataConnection.this.mRetryingState);
                    } else {
                        DataConnection.this.mInactiveState.setEnterNotificationParams(DcFailCause.LOST_CONNECTION);
                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DATA_CONNECTION_ROAM_ON /*262156*/:
                    DataConnection.this.mNetworkInfo.setRoaming(DataConnection.VDBG);
                    DataConnection.this.mNetworkAgent.sendNetworkInfo(DataConnection.this.mNetworkInfo);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DATA_CONNECTION_ROAM_OFF /*262157*/:
                    DataConnection.this.mNetworkInfo.setRoaming(false);
                    DataConnection.this.mNetworkAgent.sendNetworkInfo(DataConnection.this.mNetworkInfo);
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcActiveState not handled msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    return false;
            }
        }
    }

    private class DcDefaultState extends State {
        private DcDefaultState() {
        }

        public void enter() {
            DataConnection.this.log("DcDefaultState: enter");
            DataConnection.this.mPhone.getServiceStateTracker().registerForDataRegStateOrRatChanged(DataConnection.this.getHandler(), DataConnection.EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED, null);
            DataConnection.this.mPhone.getServiceStateTracker().registerForDataRoamingOn(DataConnection.this.getHandler(), DataConnection.EVENT_DATA_CONNECTION_ROAM_ON, null);
            DataConnection.this.mPhone.getServiceStateTracker().registerForDataRoamingOff(DataConnection.this.getHandler(), DataConnection.EVENT_DATA_CONNECTION_ROAM_OFF, null);
            DataConnection.this.mDcController.addDc(DataConnection.this);
        }

        public void exit() {
            DataConnection.this.log("DcDefaultState: exit");
            DataConnection.this.mPhone.getServiceStateTracker().unregisterForDataRegStateOrRatChanged(DataConnection.this.getHandler());
            DataConnection.this.mPhone.getServiceStateTracker().unregisterForDataRoamingOn(DataConnection.this.getHandler());
            DataConnection.this.mPhone.getServiceStateTracker().unregisterForDataRoamingOff(DataConnection.this.getHandler());
            DataConnection.this.mDcController.removeDc(DataConnection.this);
            if (DataConnection.this.mAc != null) {
                DataConnection.this.mAc.disconnected();
                DataConnection.this.mAc = null;
            }
            DataConnection.this.mDcRetryAlarmController.dispose();
            DataConnection.this.mDcRetryAlarmController = null;
            DataConnection.this.mApnContexts = null;
            DataConnection.this.mReconnectIntent = null;
            DataConnection.this.mDct = null;
            DataConnection.this.mApnSetting = null;
            DataConnection.this.mPhone = null;
            DataConnection.this.mLinkProperties = null;
            DataConnection.this.mLastFailCause = null;
            DataConnection.this.mUserData = null;
            DataConnection.this.mDcController = null;
            DataConnection.this.mDcTesterFailBringUpAll = null;
        }

        public boolean processMessage(Message msg) {
            DataConnection.this.log("DcDefault msg=" + DataConnection.this.getWhatToString(msg.what) + " RefCount=" + DataConnection.this.mApnContexts.size());
            switch (msg.what) {
                case 69633:
                    if (DataConnection.this.mAc == null) {
                        DataConnection.this.mAc = new AsyncChannel();
                        DataConnection.this.mAc.connected(null, DataConnection.this.getHandler(), msg.replyTo);
                        DataConnection.this.log("DcDefaultState: FULL_CONNECTION reply connected");
                        DataConnection.this.mAc.replyToMessage(msg, 69634, 0, DataConnection.this.mId, "hi");
                        break;
                    }
                    DataConnection.this.log("Disconnecting to previous connection mAc=" + DataConnection.this.mAc);
                    DataConnection.this.mAc.replyToMessage(msg, 69634, 3);
                    break;
                case 69636:
                    DataConnection.this.log("DcDefault: CMD_CHANNEL_DISCONNECTED before quiting call dump");
                    DataConnection.this.dumpToLog();
                    DataConnection.this.quit();
                    break;
                case DataConnection.EVENT_CONNECT /*262144*/:
                    DataConnection.this.log("DcDefaultState: msg.what=EVENT_CONNECT, fail not expected");
                    DataConnection.this.notifyConnectCompleted(msg.obj, DcFailCause.UNKNOWN, false);
                    break;
                case DataConnection.EVENT_DISCONNECT /*262148*/:
                    DataConnection.this.log("DcDefaultState deferring msg.what=EVENT_DISCONNECT RefCount=" + DataConnection.this.mApnContexts.size());
                    DataConnection.this.deferMessage(msg);
                    break;
                case DataConnection.EVENT_DISCONNECT_ALL /*262150*/:
                    DataConnection.this.log("DcDefaultState deferring msg.what=EVENT_DISCONNECT_ALL RefCount=" + DataConnection.this.mApnContexts.size());
                    DataConnection.this.deferMessage(msg);
                    break;
                case DataConnection.EVENT_TEAR_DOWN_NOW /*262152*/:
                    DataConnection.this.log("DcDefaultState EVENT_TEAR_DOWN_NOW");
                    DataConnection.this.mPhone.mCi.deactivateDataCall(DataConnection.this.mCid, 0, null);
                    break;
                case DataConnection.EVENT_LOST_CONNECTION /*262153*/:
                    DataConnection.this.logAndAddLogRec("DcDefaultState ignore EVENT_LOST_CONNECTION tag=" + msg.arg1 + ":mTag=" + DataConnection.this.mTag);
                    break;
                case DataConnection.EVENT_RETRY_CONNECTION /*262154*/:
                    DataConnection.this.logAndAddLogRec("DcDefaultState ignore EVENT_RETRY_CONNECTION tag=" + msg.arg1 + ":mTag=" + DataConnection.this.mTag);
                    break;
                case DataConnection.EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED /*262155*/:
                    Pair<Integer, Integer> drsRatPair = msg.obj.result;
                    DataConnection.this.mDataRegState = ((Integer) drsRatPair.first).intValue();
                    if (DataConnection.this.mRilRat != ((Integer) drsRatPair.second).intValue()) {
                        DataConnection.this.updateTcpBufferSizes(((Integer) drsRatPair.second).intValue());
                    }
                    DataConnection.this.mRilRat = ((Integer) drsRatPair.second).intValue();
                    DataConnection.this.log("DcDefaultState: EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED drs=" + DataConnection.this.mDataRegState + " mRilRat=" + DataConnection.this.mRilRat);
                    int networkType = DataConnection.this.mPhone.getServiceState().getDataNetworkType();
                    DataConnection.this.mNetworkInfo.setSubtype(networkType, TelephonyManager.getNetworkTypeName(networkType));
                    if (DataConnection.this.mNetworkAgent != null) {
                        DataConnection.this.mNetworkAgent.sendNetworkCapabilities(DataConnection.this.makeNetworkCapabilities());
                        DataConnection.this.mNetworkAgent.sendNetworkInfo(DataConnection.this.mNetworkInfo);
                        DataConnection.this.mNetworkAgent.sendLinkProperties(DataConnection.this.mLinkProperties);
                        break;
                    }
                    break;
                case DataConnection.EVENT_DATA_CONNECTION_ROAM_ON /*262156*/:
                    DataConnection.this.mNetworkInfo.setRoaming(DataConnection.VDBG);
                    break;
                case DataConnection.EVENT_DATA_CONNECTION_ROAM_OFF /*262157*/:
                    DataConnection.this.mNetworkInfo.setRoaming(false);
                    break;
                case DcAsyncChannel.REQ_IS_INACTIVE /*266240*/:
                    boolean val = DataConnection.this.getIsInactive();
                    DataConnection.this.log("REQ_IS_INACTIVE  isInactive=" + val);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_IS_INACTIVE, val ? 1 : 0);
                    break;
                case DcAsyncChannel.REQ_GET_CID /*266242*/:
                    int cid = DataConnection.this.getCid();
                    DataConnection.this.log("REQ_GET_CID  cid=" + cid);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_GET_CID, cid);
                    break;
                case DcAsyncChannel.REQ_GET_APNSETTING /*266244*/:
                    ApnSetting apnSetting = DataConnection.this.getApnSetting();
                    DataConnection.this.log("REQ_GET_APNSETTING  mApnSetting=" + apnSetting);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_GET_APNSETTING, apnSetting);
                    break;
                case DcAsyncChannel.REQ_GET_LINK_PROPERTIES /*266246*/:
                    LinkProperties lp = DataConnection.this.getCopyLinkProperties();
                    DataConnection.this.log("REQ_GET_LINK_PROPERTIES linkProperties" + lp);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_GET_LINK_PROPERTIES, lp);
                    break;
                case DcAsyncChannel.REQ_SET_LINK_PROPERTIES_HTTP_PROXY /*266248*/:
                    ProxyInfo proxy = msg.obj;
                    DataConnection.this.log("REQ_SET_LINK_PROPERTIES_HTTP_PROXY proxy=" + proxy);
                    DataConnection.this.setLinkPropertiesHttpProxy(proxy);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_SET_LINK_PROPERTIES_HTTP_PROXY);
                    break;
                case DcAsyncChannel.REQ_GET_NETWORK_CAPABILITIES /*266250*/:
                    NetworkCapabilities nc = DataConnection.this.getCopyNetworkCapabilities();
                    DataConnection.this.log("REQ_GET_NETWORK_CAPABILITIES networkCapabilities" + nc);
                    DataConnection.this.mAc.replyToMessage(msg, DcAsyncChannel.RSP_GET_NETWORK_CAPABILITIES, nc);
                    break;
                case DcAsyncChannel.REQ_RESET /*266252*/:
                    DataConnection.this.log("DcDefaultState: msg.what=REQ_RESET");
                    DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    break;
                default:
                    DataConnection.this.log("DcDefaultState: shouldn't happen but ignore msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    break;
            }
            return DataConnection.VDBG;
        }
    }

    private class DcDisconnectingState extends State {
        private DcDisconnectingState() {
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case DataConnection.EVENT_CONNECT /*262144*/:
                    DataConnection.this.log("DcDisconnectingState msg.what=EVENT_CONNECT. Defer. RefCount = " + DataConnection.this.mApnContexts.size());
                    DataConnection.this.deferMessage(msg);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DEACTIVATE_DONE /*262147*/:
                    DataConnection.this.log("DcDisconnectingState msg.what=EVENT_DEACTIVATE_DONE RefCount=" + DataConnection.this.mApnContexts.size());
                    AsyncResult ar = msg.obj;
                    DisconnectParams dp = ar.userObj;
                    if (dp.mTag == DataConnection.this.mTag) {
                        DataConnection.this.mInactiveState.setEnterNotificationParams((DisconnectParams) ar.userObj);
                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    } else {
                        DataConnection.this.log("DcDisconnectState stale EVENT_DEACTIVATE_DONE dp.tag=" + dp.mTag + " mTag=" + DataConnection.this.mTag);
                    }
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcDisconnectingState not handled msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    return false;
            }
        }
    }

    private class DcDisconnectionErrorCreatingConnection extends State {
        private DcDisconnectionErrorCreatingConnection() {
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case DataConnection.EVENT_DEACTIVATE_DONE /*262147*/:
                    ConnectionParams cp = msg.obj.userObj;
                    if (cp.mTag == DataConnection.this.mTag) {
                        DataConnection.this.log("DcDisconnectionErrorCreatingConnection msg.what=EVENT_DEACTIVATE_DONE");
                        DataConnection.this.mInactiveState.setEnterNotificationParams(cp, DcFailCause.UNACCEPTABLE_NETWORK_PARAMETER);
                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    } else {
                        DataConnection.this.log("DcDisconnectionErrorCreatingConnection stale EVENT_DEACTIVATE_DONE dp.tag=" + cp.mTag + ", mTag=" + DataConnection.this.mTag);
                    }
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcDisconnectionErrorCreatingConnection not handled msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    return false;
            }
        }
    }

    private class DcInactiveState extends State {
        private DcInactiveState() {
        }

        public void setEnterNotificationParams(ConnectionParams cp, DcFailCause cause) {
            DataConnection.this.log("DcInactiveState: setEnterNoticationParams cp,cause");
            DataConnection.this.mConnectionParams = cp;
            DataConnection.this.mDisconnectParams = null;
            DataConnection.this.mDcFailCause = cause;
        }

        public void setEnterNotificationParams(DisconnectParams dp) {
            DataConnection.this.log("DcInactiveState: setEnterNoticationParams dp");
            DataConnection.this.mConnectionParams = null;
            DataConnection.this.mDisconnectParams = dp;
            DataConnection.this.mDcFailCause = DcFailCause.NONE;
        }

        public void setEnterNotificationParams(DcFailCause cause) {
            DataConnection.this.mConnectionParams = null;
            DataConnection.this.mDisconnectParams = null;
            DataConnection.this.mDcFailCause = cause;
        }

        public void enter() {
            DataConnection dataConnection = DataConnection.this;
            dataConnection.mTag++;
            DataConnection.this.log("DcInactiveState: enter() mTag=" + DataConnection.this.mTag);
            if (DataConnection.this.mConnectionParams != null) {
                DataConnection.this.log("DcInactiveState: enter notifyConnectCompleted +ALL failCause=" + DataConnection.this.mDcFailCause);
                DataConnection.this.notifyConnectCompleted(DataConnection.this.mConnectionParams, DataConnection.this.mDcFailCause, DataConnection.VDBG);
            }
            if (DataConnection.this.mDisconnectParams != null) {
                DataConnection.this.log("DcInactiveState: enter notifyDisconnectCompleted +ALL failCause=" + DataConnection.this.mDcFailCause);
                DataConnection.this.notifyDisconnectCompleted(DataConnection.this.mDisconnectParams, DataConnection.VDBG);
            }
            if (DataConnection.this.mDisconnectParams == null && DataConnection.this.mConnectionParams == null && DataConnection.this.mDcFailCause != null) {
                DataConnection.this.log("DcInactiveState: enter notifyAllDisconnectCompleted failCause=" + DataConnection.this.mDcFailCause);
                DataConnection.this.notifyAllDisconnectCompleted(DataConnection.this.mDcFailCause);
            }
            DataConnection.this.mDcController.removeActiveDcByCid(DataConnection.this);
            DataConnection.this.clearSettings();
        }

        public void exit() {
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case DataConnection.EVENT_CONNECT /*262144*/:
                    DataConnection.this.log("DcInactiveState: mag.what=EVENT_CONNECT");
                    ConnectionParams cp = msg.obj;
                    if (DataConnection.this.initConnection(cp)) {
                        DataConnection.this.onConnect(DataConnection.this.mConnectionParams);
                        DataConnection.this.transitionTo(DataConnection.this.mActivatingState);
                    } else {
                        DataConnection.this.log("DcInactiveState: msg.what=EVENT_CONNECT initConnection failed");
                        DataConnection.this.notifyConnectCompleted(cp, DcFailCause.UNACCEPTABLE_NETWORK_PARAMETER, false);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT /*262148*/:
                    DataConnection.this.log("DcInactiveState: msg.what=EVENT_DISCONNECT");
                    DataConnection.this.notifyDisconnectCompleted((DisconnectParams) msg.obj, false);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT_ALL /*262150*/:
                    DataConnection.this.log("DcInactiveState: msg.what=EVENT_DISCONNECT_ALL");
                    DataConnection.this.notifyDisconnectCompleted((DisconnectParams) msg.obj, false);
                    return DataConnection.VDBG;
                case DcAsyncChannel.REQ_RESET /*266252*/:
                    DataConnection.this.log("DcInactiveState: msg.what=RSP_RESET, ignore we're already reset");
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcInactiveState nothandled msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    return false;
            }
        }
    }

    private class DcNetworkAgent extends NetworkAgent {
        public DcNetworkAgent(Looper l, Context c, String TAG, NetworkInfo ni, NetworkCapabilities nc, LinkProperties lp, int score, NetworkMisc misc) {
            super(l, c, TAG, ni, nc, lp, score, misc);
        }

        protected void unwanted() {
            if (DataConnection.this.mNetworkAgent != this) {
                log("DcNetworkAgent: unwanted found mNetworkAgent=" + DataConnection.this.mNetworkAgent + ", which isn't me.  Aborting unwanted");
            } else if (DataConnection.this.mApnContexts != null) {
                for (ApnContext apnContext : DataConnection.this.mApnContexts) {
                    log("DcNetworkAgent: [unwanted]: disconnect apnContext=" + apnContext);
                    DataConnection.this.sendMessage(DataConnection.this.obtainMessage(DataConnection.EVENT_DISCONNECT, new DisconnectParams(apnContext, apnContext.getReason(), DataConnection.this.mDct.obtainMessage(270351, apnContext))));
                }
            }
        }
    }

    private class DcRetryingState extends State {
        private DcRetryingState() {
        }

        public void enter() {
            if (DataConnection.this.mConnectionParams.mRilRat == DataConnection.this.mRilRat && DataConnection.this.mDataRegState == 0) {
                DataConnection.this.log("DcRetryingState: enter() mTag=" + DataConnection.this.mTag + ", call notifyAllOfDisconnectDcRetrying lostConnection");
                DataConnection.this.notifyAllOfDisconnectDcRetrying(Phone.REASON_LOST_DATA_CONNECTION);
                DataConnection.this.mDcController.removeActiveDcByCid(DataConnection.this);
                DataConnection.this.mCid = -1;
                return;
            }
            DataConnection.this.logAndAddLogRec("DcRetryingState: enter() not retrying rat changed, mConnectionParams.mRilRat=" + DataConnection.this.mConnectionParams.mRilRat + " != mRilRat:" + DataConnection.this.mRilRat + " transitionTo(mInactiveState)");
            DataConnection.this.mInactiveState.setEnterNotificationParams(DcFailCause.LOST_CONNECTION);
            DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case DataConnection.EVENT_CONNECT /*262144*/:
                    ConnectionParams cp = msg.obj;
                    DataConnection.this.log("DcRetryingState: msg.what=EVENT_CONNECT RefCount=" + DataConnection.this.mApnContexts.size() + " cp=" + cp + " mConnectionParams=" + DataConnection.this.mConnectionParams);
                    if (DataConnection.this.initConnection(cp)) {
                        DataConnection.this.onConnect(DataConnection.this.mConnectionParams);
                        DataConnection.this.transitionTo(DataConnection.this.mActivatingState);
                    } else {
                        DataConnection.this.log("DcRetryingState: msg.what=EVENT_CONNECT initConnection failed");
                        DataConnection.this.notifyConnectCompleted(cp, DcFailCause.UNACCEPTABLE_NETWORK_PARAMETER, false);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT /*262148*/:
                    DisconnectParams dp = msg.obj;
                    if (DataConnection.this.mApnContexts.remove(dp.mApnContext) && DataConnection.this.mApnContexts.size() == 0) {
                        DataConnection.this.log("DcRetryingState msg.what=EVENT_DISCONNECT  RefCount=" + DataConnection.this.mApnContexts.size() + " dp=" + dp);
                        DataConnection.this.mInactiveState.setEnterNotificationParams(dp);
                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    } else {
                        DataConnection.this.log("DcRetryingState: msg.what=EVENT_DISCONNECT");
                        DataConnection.this.notifyDisconnectCompleted(dp, false);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DISCONNECT_ALL /*262150*/:
                    DataConnection.this.log("DcRetryingState msg.what=EVENT_DISCONNECT/DISCONNECT_ALL RefCount=" + DataConnection.this.mApnContexts.size());
                    DataConnection.this.mInactiveState.setEnterNotificationParams(DcFailCause.LOST_CONNECTION);
                    DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    return DataConnection.VDBG;
                case DataConnection.EVENT_RETRY_CONNECTION /*262154*/:
                    if (msg.arg1 == DataConnection.this.mTag) {
                        DataConnection.this.mRetryManager.increaseRetryCount();
                        DataConnection.this.log("DcRetryingState EVENT_RETRY_CONNECTION RetryCount=" + DataConnection.this.mRetryManager.getRetryCount() + " mConnectionParams=" + DataConnection.this.mConnectionParams);
                        DataConnection.this.onConnect(DataConnection.this.mConnectionParams);
                        DataConnection.this.transitionTo(DataConnection.this.mActivatingState);
                    } else {
                        DataConnection.this.log("DcRetryingState stale EVENT_RETRY_CONNECTION tag:" + msg.arg1 + " != mTag:" + DataConnection.this.mTag);
                    }
                    return DataConnection.VDBG;
                case DataConnection.EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED /*262155*/:
                    Pair<Integer, Integer> drsRatPair = msg.obj.result;
                    int drs = ((Integer) drsRatPair.first).intValue();
                    int rat = ((Integer) drsRatPair.second).intValue();
                    if (rat == DataConnection.this.mRilRat && drs == DataConnection.this.mDataRegState) {
                        DataConnection.this.log("DcRetryingState: EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED strange no change in drs=" + drs + " rat=" + rat + " ignoring");
                    } else if (DataConnection.this.mConnectionParams.mRetryWhenSSChange) {
                        return false;
                    } else {
                        DataConnection.this.mInactiveState.setEnterNotificationParams(DcFailCause.LOST_CONNECTION);
                        DataConnection.this.deferMessage(msg);
                        DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                        DataConnection.this.logAndAddLogRec("DcRetryingState: EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED giving up changed from " + DataConnection.this.mRilRat + " to rat=" + rat + " or drs changed from " + DataConnection.this.mDataRegState + " to drs=" + drs);
                        DataConnection.this.mDataRegState = drs;
                        DataConnection.this.mRilRat = rat;
                        int networkType = DataConnection.this.mPhone.getServiceState().getDataNetworkType();
                        DataConnection.this.mNetworkInfo.setSubtype(networkType, TelephonyManager.getNetworkTypeName(networkType));
                    }
                    return DataConnection.VDBG;
                case DcAsyncChannel.REQ_RESET /*266252*/:
                    DataConnection.this.log("DcRetryingState: msg.what=RSP_RESET, ignore we're already reset");
                    DataConnection.this.mInactiveState.setEnterNotificationParams(DataConnection.this.mConnectionParams, DcFailCause.RESET_BY_FRAMEWORK);
                    DataConnection.this.transitionTo(DataConnection.this.mInactiveState);
                    return DataConnection.VDBG;
                default:
                    DataConnection.this.log("DcRetryingState nothandled msg.what=" + DataConnection.this.getWhatToString(msg.what));
                    return false;
            }
        }
    }

    static class DisconnectParams {
        ApnContext mApnContext;
        Message mOnCompletedMsg;
        String mReason;
        int mTag;

        DisconnectParams(ApnContext apnContext, String reason, Message onCompletedMsg) {
            this.mApnContext = apnContext;
            this.mReason = reason;
            this.mOnCompletedMsg = onCompletedMsg;
        }

        public String toString() {
            return "{mTag=" + this.mTag + " mApnContext=" + this.mApnContext + " mReason=" + this.mReason + " mOnCompletedMsg=" + DataConnection.msgToString(this.mOnCompletedMsg) + "}";
        }
    }

    static class UpdateLinkPropertyResult {
        public LinkProperties newLp;
        public LinkProperties oldLp;
        public SetupResult setupResult;

        public UpdateLinkPropertyResult(LinkProperties curLp) {
            this.setupResult = SetupResult.SUCCESS;
            this.oldLp = curLp;
            this.newLp = curLp;
        }
    }

    static {
        mInstanceNumber = new AtomicInteger(0);
        sCmdToString = new String[CMD_TO_STRING_COUNT];
        sCmdToString[0] = "EVENT_CONNECT";
        sCmdToString[1] = "EVENT_SETUP_DATA_CONNECTION_DONE";
        sCmdToString[2] = "EVENT_GET_LAST_FAIL_DONE";
        sCmdToString[3] = "EVENT_DEACTIVATE_DONE";
        sCmdToString[4] = "EVENT_DISCONNECT";
        sCmdToString[5] = "EVENT_RIL_CONNECTED";
        sCmdToString[6] = "EVENT_DISCONNECT_ALL";
        sCmdToString[7] = "EVENT_DATA_STATE_CHANGED";
        sCmdToString[8] = "EVENT_TEAR_DOWN_NOW";
        sCmdToString[9] = "EVENT_LOST_CONNECTION";
        sCmdToString[10] = "EVENT_RETRY_CONNECTION";
        sCmdToString[11] = "EVENT_DATA_CONNECTION_DRS_OR_RAT_CHANGED";
        sCmdToString[12] = "EVENT_DATA_CONNECTION_ROAM_ON";
        sCmdToString[13] = "EVENT_DATA_CONNECTION_ROAM_OFF";
    }

    static String cmdToString(int cmd) {
        String value;
        cmd -= EVENT_CONNECT;
        if (cmd < 0 || cmd >= sCmdToString.length) {
            value = DcAsyncChannel.cmdToString(cmd + EVENT_CONNECT);
        } else {
            value = sCmdToString[cmd];
        }
        if (value == null) {
            return "0x" + Integer.toHexString(cmd + EVENT_CONNECT);
        }
        return value;
    }

    static DataConnection makeDataConnection(PhoneBase phone, int id, DcTrackerBase dct, DcTesterFailBringUpAll failBringUpAll, DcController dcc) {
        DataConnection dc = new DataConnection(phone, "DC-" + mInstanceNumber.incrementAndGet(), id, dct, failBringUpAll, dcc);
        dc.start();
        dc.log("Made " + dc.getName());
        return dc;
    }

    void dispose() {
        log("dispose: call quiteNow()");
        quitNow();
    }

    NetworkCapabilities getCopyNetworkCapabilities() {
        return makeNetworkCapabilities();
    }

    LinkProperties getCopyLinkProperties() {
        return new LinkProperties(this.mLinkProperties);
    }

    boolean getIsInactive() {
        return getCurrentState() == this.mInactiveState ? VDBG : false;
    }

    int getCid() {
        return this.mCid;
    }

    ApnSetting getApnSetting() {
        return this.mApnSetting;
    }

    void setLinkPropertiesHttpProxy(ProxyInfo proxy) {
        this.mLinkProperties.setHttpProxy(proxy);
    }

    public boolean isIpv4Connected() {
        for (InetAddress addr : this.mLinkProperties.getAddresses()) {
            if (addr instanceof Inet4Address) {
                Inet4Address i4addr = (Inet4Address) addr;
                if (!(i4addr.isAnyLocalAddress() || i4addr.isLinkLocalAddress() || i4addr.isLoopbackAddress() || i4addr.isMulticastAddress())) {
                    return VDBG;
                }
            }
        }
        return false;
    }

    public boolean isIpv6Connected() {
        for (InetAddress addr : this.mLinkProperties.getAddresses()) {
            if (addr instanceof Inet6Address) {
                Inet6Address i6addr = (Inet6Address) addr;
                if (!(i6addr.isAnyLocalAddress() || i6addr.isLinkLocalAddress() || i6addr.isLoopbackAddress() || i6addr.isMulticastAddress())) {
                    return VDBG;
                }
            }
        }
        return false;
    }

    UpdateLinkPropertyResult updateLinkProperty(DataCallResponse newState) {
        UpdateLinkPropertyResult result = new UpdateLinkPropertyResult(this.mLinkProperties);
        if (newState != null) {
            result.newLp = new LinkProperties();
            result.setupResult = setLinkProperties(newState, result.newLp);
            if (result.setupResult != SetupResult.SUCCESS) {
                log("updateLinkProperty failed : " + result.setupResult);
            } else {
                result.newLp.setHttpProxy(this.mLinkProperties.getHttpProxy());
                checkSetMtu(this.mApnSetting, result.newLp);
                this.mLinkProperties = result.newLp;
                updateTcpBufferSizes(this.mRilRat);
                if (!result.oldLp.equals(result.newLp)) {
                    log("updateLinkProperty old LP=" + result.oldLp);
                    log("updateLinkProperty new LP=" + result.newLp);
                }
                if (!(result.newLp.equals(result.oldLp) || this.mNetworkAgent == null)) {
                    this.mNetworkAgent.sendLinkProperties(this.mLinkProperties);
                }
            }
        }
        return result;
    }

    private void checkSetMtu(ApnSetting apn, LinkProperties lp) {
        if (lp != null && apn != null && lp != null) {
            if (lp.getMtu() != 0) {
                log("MTU set by call response to: " + lp.getMtu());
            } else if (apn == null || apn.mtu == 0) {
                int mtu = this.mPhone.getContext().getResources().getInteger(17694842);
                if (mtu != 0) {
                    lp.setMtu(mtu);
                    log("MTU set by config resource to: " + mtu);
                }
            } else {
                lp.setMtu(apn.mtu);
                log("MTU set by APN to: " + apn.mtu);
            }
        }
    }

    private DataConnection(PhoneBase phone, String name, int id, DcTrackerBase dct, DcTesterFailBringUpAll failBringUpAll, DcController dcc) {
        super(name, dcc.getHandler());
        this.mDct = null;
        this.mLinkProperties = new LinkProperties();
        this.mRilRat = Integer.MAX_VALUE;
        this.mDataRegState = Integer.MAX_VALUE;
        this.mApnContexts = null;
        this.mReconnectIntent = null;
        this.mRetryManager = new RetryManager();
        this.mDefaultState = new DcDefaultState();
        this.mInactiveState = new DcInactiveState();
        this.mRetryingState = new DcRetryingState();
        this.mActivatingState = new DcActivatingState();
        this.mActiveState = new DcActiveState();
        this.mDisconnectingState = new DcDisconnectingState();
        this.mDisconnectingErrorCreatingConnection = new DcDisconnectionErrorCreatingConnection();
        setLogRecSize(300);
        setLogOnlyTransitions(VDBG);
        log("DataConnection constructor E");
        this.mPhone = phone;
        this.mDct = dct;
        this.mDcTesterFailBringUpAll = failBringUpAll;
        this.mDcController = dcc;
        this.mId = id;
        this.mCid = -1;
        this.mDcRetryAlarmController = new DcRetryAlarmController(this.mPhone, this);
        ServiceState ss = this.mPhone.getServiceState();
        this.mRilRat = ss.getRilDataRadioTechnology();
        this.mDataRegState = this.mPhone.getServiceState().getDataRegState();
        int networkType = ss.getDataNetworkType();
        this.mNetworkInfo = new NetworkInfo(0, networkType, NETWORK_TYPE, TelephonyManager.getNetworkTypeName(networkType));
        this.mNetworkInfo.setRoaming(ss.getDataRoaming());
        this.mNetworkInfo.setIsAvailable(VDBG);
        addState(this.mDefaultState);
        addState(this.mInactiveState, this.mDefaultState);
        addState(this.mActivatingState, this.mDefaultState);
        addState(this.mRetryingState, this.mDefaultState);
        addState(this.mActiveState, this.mDefaultState);
        addState(this.mDisconnectingState, this.mDefaultState);
        addState(this.mDisconnectingErrorCreatingConnection, this.mDefaultState);
        setInitialState(this.mInactiveState);
        this.mApnContexts = new ArrayList();
        log("DataConnection constructor X");
    }

    private String getRetryConfig(boolean forDefault) {
        int nt = this.mPhone.getServiceState().getNetworkType();
        if (Build.IS_DEBUGGABLE) {
            String config = SystemProperties.get("test.data_retry_config");
            if (!TextUtils.isEmpty(config)) {
                return config;
            }
        }
        if (nt == 4 || nt == 7 || nt == 5 || nt == 6 || nt == 12 || nt == CMD_TO_STRING_COUNT) {
            return SystemProperties.get("ro.cdma.data_retry_config");
        }
        if (forDefault) {
            return SystemProperties.get("ro.gsm.data_retry_config");
        }
        return SystemProperties.get("ro.gsm.2nd_data_retry_config");
    }

    private void configureRetry(boolean forDefault) {
        if (!this.mRetryManager.configure(getRetryConfig(forDefault))) {
            if (forDefault) {
                if (!this.mRetryManager.configure(DEFAULT_DATA_RETRY_CONFIG)) {
                    loge("configureRetry: Could not configure using DEFAULT_DATA_RETRY_CONFIG=default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000");
                    this.mRetryManager.configure(5, 2000, CharacterSets.UCS2);
                }
            } else if (!this.mRetryManager.configure(SECONDARY_DATA_RETRY_CONFIG)) {
                loge("configureRetry: Could note configure using SECONDARY_DATA_RETRY_CONFIG=max_retries=3, 5000, 5000, 5000");
                this.mRetryManager.configure(5, 2000, CharacterSets.UCS2);
            }
        }
        log("configureRetry: forDefault=" + forDefault + " mRetryManager=" + this.mRetryManager);
    }

    private void onConnect(ConnectionParams cp) {
        log("onConnect: carrier='" + this.mApnSetting.carrier + "' APN='" + this.mApnSetting.apn + "' proxy='" + this.mApnSetting.proxy + "' port='" + this.mApnSetting.port + "'");
        if (this.mDcTesterFailBringUpAll.getDcFailBringUp().mCounter > 0) {
            DataCallResponse response = new DataCallResponse();
            response.version = this.mPhone.mCi.getRilVersion();
            response.status = this.mDcTesterFailBringUpAll.getDcFailBringUp().mFailCause.getErrorCode();
            response.cid = 0;
            response.active = 0;
            response.type = "";
            response.ifname = "";
            response.addresses = new String[0];
            response.dnses = new String[0];
            response.gateways = new String[0];
            response.suggestedRetryTime = this.mDcTesterFailBringUpAll.getDcFailBringUp().mSuggestedRetryTime;
            response.pcscf = new String[0];
            response.mtu = 0;
            Message msg = obtainMessage(EVENT_SETUP_DATA_CONNECTION_DONE, cp);
            AsyncResult.forMessage(msg, response, null);
            sendMessage(msg);
            log("onConnect: FailBringUpAll=" + this.mDcTesterFailBringUpAll.getDcFailBringUp() + " send error response=" + response);
            DcFailBringUp dcFailBringUp = this.mDcTesterFailBringUpAll.getDcFailBringUp();
            dcFailBringUp.mCounter--;
            return;
        }
        String protocol;
        this.mCreateTime = -1;
        this.mLastFailTime = -1;
        this.mLastFailCause = DcFailCause.NONE;
        msg = obtainMessage(EVENT_SETUP_DATA_CONNECTION_DONE, cp);
        msg.obj = cp;
        int authType = this.mApnSetting.authType;
        if (authType == -1) {
            authType = TextUtils.isEmpty(this.mApnSetting.user) ? 0 : 3;
        }
        if (this.mPhone.getServiceState().getDataRoaming()) {
            protocol = this.mApnSetting.roamingProtocol;
        } else {
            protocol = this.mApnSetting.protocol;
        }
        this.mPhone.mCi.setupDataCall(getDataTechnology(cp.mRilRat), Integer.toString(cp.mProfileId), this.mApnSetting.apn, this.mApnSetting.user, this.mApnSetting.password, Integer.toString(authType), protocol, msg);
    }

    private String getDataTechnology(int radioTechnology) {
        int dataTechnology = radioTechnology + 2;
        if (this.mPhone.mCi.getRilVersion() < 5) {
            if (ServiceState.isGsm(radioTechnology)) {
                dataTechnology = 1;
            } else if (ServiceState.isCdma(radioTechnology)) {
                dataTechnology = 0;
            }
        }
        return Integer.toString(dataTechnology);
    }

    private void tearDownData(Object o) {
        int discReason = 0;
        if (o != null && (o instanceof DisconnectParams)) {
            DisconnectParams dp = (DisconnectParams) o;
            if (TextUtils.equals(dp.mReason, Phone.REASON_RADIO_TURNED_OFF)) {
                discReason = 1;
            } else if (TextUtils.equals(dp.mReason, Phone.REASON_PDP_RESET)) {
                discReason = 2;
            }
        }
        if (this.mPhone.mCi.getRadioState().isOn()) {
            log("tearDownData radio is on, call deactivateDataCall");
            this.mPhone.mCi.deactivateDataCall(this.mCid, discReason, obtainMessage(EVENT_DEACTIVATE_DONE, this.mTag, 0, o));
            return;
        }
        log("tearDownData radio is off sendMessage EVENT_DEACTIVATE_DONE immediately");
        sendMessage(obtainMessage(EVENT_DEACTIVATE_DONE, this.mTag, 0, new AsyncResult(o, null, null)));
    }

    private void notifyAllWithEvent(ApnContext alreadySent, int event, String reason) {
        this.mNetworkInfo.setDetailedState(this.mNetworkInfo.getDetailedState(), reason, this.mNetworkInfo.getExtraInfo());
        for (ApnContext apnContext : this.mApnContexts) {
            if (apnContext != alreadySent) {
                if (reason != null) {
                    apnContext.setReason(reason);
                }
                Message msg = this.mDct.obtainMessage(event, apnContext);
                AsyncResult.forMessage(msg);
                msg.sendToTarget();
            }
        }
    }

    private void notifyAllOfConnected(String reason) {
        notifyAllWithEvent(null, 270336, reason);
    }

    private void notifyAllOfDisconnectDcRetrying(String reason) {
        notifyAllWithEvent(null, 270370, reason);
    }

    private void notifyAllDisconnectCompleted(DcFailCause cause) {
        notifyAllWithEvent(null, 270351, cause.toString());
    }

    private void notifyConnectCompleted(ConnectionParams cp, DcFailCause cause, boolean sendAll) {
        ApnContext alreadySent = null;
        if (!(cp == null || cp.mOnCompletedMsg == null)) {
            Message connectionCompletedMsg = cp.mOnCompletedMsg;
            cp.mOnCompletedMsg = null;
            if (connectionCompletedMsg.obj instanceof ApnContext) {
                alreadySent = connectionCompletedMsg.obj;
            }
            long timeStamp = System.currentTimeMillis();
            connectionCompletedMsg.arg1 = this.mCid;
            if (cause == DcFailCause.NONE) {
                this.mCreateTime = timeStamp;
                AsyncResult.forMessage(connectionCompletedMsg);
            } else {
                this.mLastFailCause = cause;
                this.mLastFailTime = timeStamp;
                if (cause == null) {
                    cause = DcFailCause.UNKNOWN;
                }
                AsyncResult.forMessage(connectionCompletedMsg, cause, new Throwable(cause.toString()));
            }
            log("notifyConnectCompleted at " + timeStamp + " cause=" + cause + " connectionCompletedMsg=" + msgToString(connectionCompletedMsg));
            connectionCompletedMsg.sendToTarget();
        }
        if (sendAll) {
            notifyAllWithEvent(alreadySent, 270371, cause.toString());
        }
    }

    private void notifyDisconnectCompleted(DisconnectParams dp, boolean sendAll) {
        log("NotifyDisconnectCompleted");
        ApnContext alreadySent = null;
        String reason = null;
        if (!(dp == null || dp.mOnCompletedMsg == null)) {
            Message msg = dp.mOnCompletedMsg;
            dp.mOnCompletedMsg = null;
            if (msg.obj instanceof ApnContext) {
                alreadySent = msg.obj;
            }
            reason = dp.mReason;
            String str = "msg=%s msg.obj=%s";
            Object[] objArr = new Object[2];
            objArr[0] = msg.toString();
            objArr[1] = msg.obj instanceof String ? (String) msg.obj : "<no-reason>";
            log(String.format(str, objArr));
            AsyncResult.forMessage(msg);
            msg.sendToTarget();
        }
        if (sendAll) {
            if (reason == null) {
                reason = DcFailCause.UNKNOWN.toString();
            }
            notifyAllWithEvent(alreadySent, 270351, reason);
        }
        log("NotifyDisconnectCompleted DisconnectParams=" + dp);
    }

    public int getDataConnectionId() {
        return this.mId;
    }

    private void clearSettings() {
        log("clearSettings");
        this.mCreateTime = -1;
        this.mLastFailTime = -1;
        this.mLastFailCause = DcFailCause.NONE;
        this.mCid = -1;
        this.mPcscfAddr = new String[5];
        this.mLinkProperties = new LinkProperties();
        this.mApnContexts.clear();
        this.mApnSetting = null;
        this.mDcFailCause = null;
    }

    private SetupResult onSetupConnectionCompleted(AsyncResult ar) {
        DataCallResponse response = ar.result;
        ConnectionParams cp = ar.userObj;
        if (cp.mTag != this.mTag) {
            log("onSetupConnectionCompleted stale cp.tag=" + cp.mTag + ", mtag=" + this.mTag);
            return SetupResult.ERR_Stale;
        } else if (ar.exception != null) {
            log("onSetupConnectionCompleted failed, ar.exception=" + ar.exception + " response=" + response);
            if ((ar.exception instanceof CommandException) && ((CommandException) ar.exception).getCommandError() == Error.RADIO_NOT_AVAILABLE) {
                result = SetupResult.ERR_BadCommand;
                result.mFailCause = DcFailCause.RADIO_NOT_AVAILABLE;
                return result;
            } else if (response == null || response.version < 4) {
                return SetupResult.ERR_GetLastErrorFromRil;
            } else {
                result = SetupResult.ERR_RilError;
                result.mFailCause = DcFailCause.fromInt(response.status);
                return result;
            }
        } else if (response.status != 0) {
            result = SetupResult.ERR_RilError;
            result.mFailCause = DcFailCause.fromInt(response.status);
            return result;
        } else {
            log("onSetupConnectionCompleted received DataCallResponse: " + response);
            this.mCid = response.cid;
            this.mPcscfAddr = response.pcscf;
            return updateLinkProperty(response).setupResult;
        }
    }

    private boolean isDnsOk(String[] domainNameServers) {
        if (!NULL_IP.equals(domainNameServers[0]) || !NULL_IP.equals(domainNameServers[1]) || this.mPhone.isDnsCheckDisabled() || (this.mApnSetting.types[0].equals("mms") && isIpAddress(this.mApnSetting.mmsProxy))) {
            return VDBG;
        }
        log(String.format("isDnsOk: return false apn.types[0]=%s APN_TYPE_MMS=%s isIpAddress(%s)=%s", new Object[]{this.mApnSetting.types[0], "mms", this.mApnSetting.mmsProxy, Boolean.valueOf(isIpAddress(this.mApnSetting.mmsProxy))}));
        return false;
    }

    private void updateTcpBufferSizes(int rilRat) {
        String sizes = null;
        String ratName = ServiceState.rilRadioTechnologyToString(rilRat).toLowerCase(Locale.ROOT);
        if (rilRat == 7 || rilRat == 8 || rilRat == 12) {
            ratName = "evdo";
        }
        String[] configOverride = this.mPhone.getContext().getResources().getStringArray(17236014);
        for (String split : configOverride) {
            String[] split2 = split.split(":");
            if (ratName.equals(split2[0]) && split2.length == 2) {
                sizes = split2[1];
                break;
            }
        }
        if (sizes == null) {
            switch (rilRat) {
                case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                    sizes = TCP_BUFFER_SIZES_GPRS;
                    break;
                case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                    sizes = TCP_BUFFER_SIZES_EDGE;
                    break;
                case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                    sizes = TCP_BUFFER_SIZES_UMTS;
                    break;
                case CharacterSets.ISO_8859_3 /*6*/:
                    sizes = TCP_BUFFER_SIZES_1XRTT;
                    break;
                case CharacterSets.ISO_8859_4 /*7*/:
                case CharacterSets.ISO_8859_5 /*8*/:
                case CharacterSets.ISO_8859_9 /*12*/:
                    sizes = TCP_BUFFER_SIZES_EVDO;
                    break;
                case CharacterSets.ISO_8859_6 /*9*/:
                    sizes = TCP_BUFFER_SIZES_HSDPA;
                    break;
                case CharacterSets.ISO_8859_7 /*10*/:
                case CharacterSets.ISO_8859_8 /*11*/:
                    sizes = TCP_BUFFER_SIZES_HSPA;
                    break;
                case UserData.ASCII_CR_INDEX /*13*/:
                    sizes = TCP_BUFFER_SIZES_EHRPD;
                    break;
                case CMD_TO_STRING_COUNT /*14*/:
                    sizes = TCP_BUFFER_SIZES_LTE;
                    break;
                case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                    sizes = TCP_BUFFER_SIZES_HSPAP;
                    break;
            }
        }
        this.mLinkProperties.setTcpBufferSizes(sizes);
    }

    private NetworkCapabilities makeNetworkCapabilities() {
        NetworkCapabilities result = new NetworkCapabilities();
        result.addTransportType(0);
        if (this.mApnSetting != null) {
            for (String type : this.mApnSetting.types) {
                int i = -1;
                switch (type.hashCode()) {
                    case CallFailCause.SWITCHING_CONGESTION /*42*/:
                        if (type.equals(CharacterSets.MIMENAME_ANY_CHARSET)) {
                            i = 0;
                            break;
                        }
                        break;
                    case 3352:
                        if (type.equals("ia")) {
                            i = 8;
                            break;
                        }
                        break;
                    case 98292:
                        if (type.equals("cbs")) {
                            i = 7;
                            break;
                        }
                        break;
                    case 99837:
                        if (type.equals("dun")) {
                            i = 4;
                            break;
                        }
                        break;
                    case 104399:
                        if (type.equals("ims")) {
                            i = 6;
                            break;
                        }
                        break;
                    case 108243:
                        if (type.equals("mms")) {
                            i = 2;
                            break;
                        }
                        break;
                    case 3149046:
                        if (type.equals("fota")) {
                            i = 5;
                            break;
                        }
                        break;
                    case 3541982:
                        if (type.equals("supl")) {
                            i = 3;
                            break;
                        }
                        break;
                    case 1544803905:
                        if (type.equals("default")) {
                            i = 1;
                            break;
                        }
                        break;
                }
                switch (i) {
                    case CharacterSets.ANY_CHARSET /*0*/:
                        result.addCapability(12);
                        result.addCapability(0);
                        result.addCapability(1);
                        result.addCapability(3);
                        result.addCapability(4);
                        result.addCapability(5);
                        result.addCapability(7);
                        break;
                    case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                        result.addCapability(12);
                        break;
                    case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                        result.addCapability(0);
                        break;
                    case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                        result.addCapability(1);
                        break;
                    case CharacterSets.ISO_8859_1 /*4*/:
                        ApnSetting securedDunApn = this.mDct.fetchDunApn();
                        if (securedDunApn != null && !securedDunApn.equals(this.mApnSetting)) {
                            break;
                        }
                        result.addCapability(2);
                        break;
                        break;
                    case CharacterSets.ISO_8859_2 /*5*/:
                        result.addCapability(3);
                        break;
                    case CharacterSets.ISO_8859_3 /*6*/:
                        result.addCapability(4);
                        break;
                    case CharacterSets.ISO_8859_4 /*7*/:
                        result.addCapability(5);
                        break;
                    case CharacterSets.ISO_8859_5 /*8*/:
                        result.addCapability(7);
                        break;
                    default:
                        break;
                }
            }
            ConnectivityManager.maybeMarkCapabilitiesRestricted(result);
        }
        int up = CMD_TO_STRING_COUNT;
        int down = CMD_TO_STRING_COUNT;
        switch (this.mRilRat) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
                up = 80;
                down = 80;
                break;
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                up = 59;
                down = 236;
                break;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
                up = 384;
                down = 384;
                break;
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                up = CMD_TO_STRING_COUNT;
                down = CMD_TO_STRING_COUNT;
                break;
            case CharacterSets.ISO_8859_3 /*6*/:
                up = 100;
                down = 100;
                break;
            case CharacterSets.ISO_8859_4 /*7*/:
                up = PduPart.P_START;
                down = 2457;
                break;
            case CharacterSets.ISO_8859_5 /*8*/:
                up = 1843;
                down = 3174;
                break;
            case CharacterSets.ISO_8859_6 /*9*/:
                up = 2048;
                down = 14336;
                break;
            case CharacterSets.ISO_8859_7 /*10*/:
                up = 5898;
                down = 14336;
                break;
            case CharacterSets.ISO_8859_8 /*11*/:
                up = 5898;
                down = 14336;
                break;
            case CharacterSets.ISO_8859_9 /*12*/:
                up = 1843;
                down = 5017;
                break;
            case UserData.ASCII_CR_INDEX /*13*/:
                up = PduPart.P_START;
                down = 2516;
                break;
            case CMD_TO_STRING_COUNT /*14*/:
                up = 51200;
                down = 102400;
                break;
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                up = 11264;
                down = 43008;
                break;
        }
        result.setLinkUpstreamBandwidthKbps(up);
        result.setLinkDownstreamBandwidthKbps(down);
        result.setNetworkSpecifier(Integer.toString(this.mPhone.getSubId()));
        return result;
    }

    private boolean isIpAddress(String address) {
        if (address == null) {
            return false;
        }
        return Patterns.IP_ADDRESS.matcher(address).matches();
    }

    private SetupResult setLinkProperties(DataCallResponse response, LinkProperties lp) {
        String propertyPrefix = "net." + response.ifname + ".";
        return response.setLinkProperties(lp, isDnsOk(new String[]{SystemProperties.get(propertyPrefix + "dns1"), SystemProperties.get(propertyPrefix + "dns2")}));
    }

    private boolean initConnection(ConnectionParams cp) {
        ApnContext apnContext = cp.mApnContext;
        if (this.mApnSetting == null) {
            this.mApnSetting = apnContext.getApnSetting();
        }
        if (this.mApnSetting == null || !this.mApnSetting.canHandleType(apnContext.getApnType())) {
            log("initConnection: incompatible apnSetting in ConnectionParams cp=" + cp + " dc=" + this);
            return false;
        }
        this.mTag++;
        this.mConnectionParams = cp;
        this.mConnectionParams.mTag = this.mTag;
        if (!this.mApnContexts.contains(apnContext)) {
            this.mApnContexts.add(apnContext);
        }
        configureRetry(this.mApnSetting.canHandleType("default"));
        this.mRetryManager.setRetryCount(0);
        this.mRetryManager.setCurMaxRetryCount(this.mConnectionParams.mInitialMaxRetry);
        this.mRetryManager.setRetryForever(false);
        log("initConnection:  RefCount=" + this.mApnContexts.size() + " mApnList=" + this.mApnContexts + " mConnectionParams=" + this.mConnectionParams);
        return VDBG;
    }

    void tearDownNow() {
        log("tearDownNow()");
        sendMessage(obtainMessage(EVENT_TEAR_DOWN_NOW));
    }

    protected String getWhatToString(int what) {
        return cmdToString(what);
    }

    private static String msgToString(Message msg) {
        if (msg == null) {
            return "null";
        }
        StringBuilder b = new StringBuilder();
        b.append("{what=");
        b.append(cmdToString(msg.what));
        b.append(" when=");
        TimeUtils.formatDuration(msg.getWhen() - SystemClock.uptimeMillis(), b);
        if (msg.arg1 != 0) {
            b.append(" arg1=");
            b.append(msg.arg1);
        }
        if (msg.arg2 != 0) {
            b.append(" arg2=");
            b.append(msg.arg2);
        }
        if (msg.obj != null) {
            b.append(" obj=");
            b.append(msg.obj);
        }
        b.append(" target=");
        b.append(msg.getTarget());
        b.append(" replyTo=");
        b.append(msg.replyTo);
        b.append("}");
        return b.toString();
    }

    static void slog(String s) {
        Rlog.d("DC", s);
    }

    protected void log(String s) {
        Rlog.d(getName(), s);
    }

    protected void logd(String s) {
        Rlog.d(getName(), s);
    }

    protected void logv(String s) {
        Rlog.v(getName(), s);
    }

    protected void logi(String s) {
        Rlog.i(getName(), s);
    }

    protected void logw(String s) {
        Rlog.w(getName(), s);
    }

    protected void loge(String s) {
        Rlog.e(getName(), s);
    }

    protected void loge(String s, Throwable e) {
        Rlog.e(getName(), s, e);
    }

    public String toStringSimple() {
        return getName() + ": State=" + getCurrentState().getName() + " mApnSetting=" + this.mApnSetting + " RefCount=" + this.mApnContexts.size() + " mCid=" + this.mCid + " mCreateTime=" + this.mCreateTime + " mLastastFailTime=" + this.mLastFailTime + " mLastFailCause=" + this.mLastFailCause + " mTag=" + this.mTag + " mRetryManager=" + this.mRetryManager + " mLinkProperties=" + this.mLinkProperties + " linkCapabilities=" + makeNetworkCapabilities();
    }

    public String toString() {
        return "{" + toStringSimple() + " mApnContexts=" + this.mApnContexts + "}";
    }

    private void dumpToLog() {
        dump(null, new C00501(new StringWriter(0)), null);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.print("DataConnection ");
        super.dump(fd, pw, args);
        pw.println(" mApnContexts.size=" + this.mApnContexts.size());
        pw.println(" mApnContexts=" + this.mApnContexts);
        pw.flush();
        pw.println(" mDataConnectionTracker=" + this.mDct);
        pw.println(" mApnSetting=" + this.mApnSetting);
        pw.println(" mTag=" + this.mTag);
        pw.println(" mCid=" + this.mCid);
        pw.println(" mRetryManager=" + this.mRetryManager);
        pw.println(" mConnectionParams=" + this.mConnectionParams);
        pw.println(" mDisconnectParams=" + this.mDisconnectParams);
        pw.println(" mDcFailCause=" + this.mDcFailCause);
        pw.flush();
        pw.println(" mPhone=" + this.mPhone);
        pw.flush();
        pw.println(" mLinkProperties=" + this.mLinkProperties);
        pw.flush();
        pw.println(" mDataRegState=" + this.mDataRegState);
        pw.println(" mRilRat=" + this.mRilRat);
        pw.println(" mNetworkCapabilities=" + makeNetworkCapabilities());
        pw.println(" mCreateTime=" + TimeUtils.logTimeOfDay(this.mCreateTime));
        pw.println(" mLastFailTime=" + TimeUtils.logTimeOfDay(this.mLastFailTime));
        pw.println(" mLastFailCause=" + this.mLastFailCause);
        pw.flush();
        pw.println(" mUserData=" + this.mUserData);
        pw.println(" mInstanceNumber=" + mInstanceNumber);
        pw.println(" mAc=" + this.mAc);
        pw.println(" mDcRetryAlarmController=" + this.mDcRetryAlarmController);
        pw.flush();
    }
}
