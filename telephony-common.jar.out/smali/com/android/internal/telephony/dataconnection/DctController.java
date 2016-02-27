package com.android.internal.telephony.dataconnection;

import android.content.Context;
import android.database.ContentObserver;
import android.net.ConnectivityManager;
import android.net.NetworkCapabilities;
import android.net.NetworkFactory;
import android.net.NetworkRequest;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.provider.Settings.Global;
import android.telephony.Rlog;
import android.telephony.SubscriptionManager;
import android.telephony.SubscriptionManager.OnSubscriptionsChangedListener;
import android.util.SparseArray;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneProxy;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.dataconnection.DcSwitchAsyncChannel.RequestInfo;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map.Entry;

public class DctController extends Handler {
    private static final boolean DBG = true;
    private static final int EVENT_DATA_ATTACHED = 500;
    private static final int EVENT_DATA_DETACHED = 600;
    private static final int EVENT_EXECUTE_ALL_REQUESTS = 102;
    private static final int EVENT_EXECUTE_REQUEST = 101;
    private static final int EVENT_PROCESS_REQUESTS = 100;
    private static final int EVENT_RELEASE_ALL_REQUESTS = 104;
    private static final int EVENT_RELEASE_REQUEST = 103;
    private static final String LOG_TAG = "DctController";
    private static DctController sDctController;
    private Context mContext;
    private DcSwitchAsyncChannel[] mDcSwitchAsyncChannel;
    private Handler[] mDcSwitchStateHandler;
    private DcSwitchStateMachine[] mDcSwitchStateMachine;
    private NetworkFactory[] mNetworkFactory;
    private Messenger[] mNetworkFactoryMessenger;
    private NetworkCapabilities[] mNetworkFilter;
    private ContentObserver mObserver;
    private OnSubscriptionsChangedListener mOnSubscriptionsChangedListener;
    private int mPhoneNum;
    private PhoneProxy[] mPhones;
    private HashMap<Integer, RequestInfo> mRequestInfos;
    private Handler mRspHandler;
    private SubscriptionController mSubController;
    private SubscriptionManager mSubMgr;

    /* renamed from: com.android.internal.telephony.dataconnection.DctController.1 */
    class C00631 extends OnSubscriptionsChangedListener {
        C00631() {
        }

        public void onSubscriptionsChanged() {
            DctController.this.onSubInfoReady();
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DctController.2 */
    class C00642 extends ContentObserver {
        C00642(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            DctController.logd("Settings change");
            DctController.this.onSettingsChange();
        }
    }

    /* renamed from: com.android.internal.telephony.dataconnection.DctController.3 */
    class C00653 extends Handler {
        C00653() {
        }

        public void handleMessage(Message msg) {
            if (msg.what >= DctController.EVENT_DATA_DETACHED) {
                DctController.logd("EVENT_PHONE" + ((msg.what - 600) + 1) + "_DATA_DETACH.");
                DctController.this.mDcSwitchAsyncChannel[msg.what - 600].notifyDataDetached();
            } else if (msg.what >= DctController.EVENT_DATA_ATTACHED) {
                DctController.logd("EVENT_PHONE" + ((msg.what - 500) + 1) + "_DATA_ATTACH.");
                DctController.this.mDcSwitchAsyncChannel[msg.what - 500].notifyDataAttached();
            }
        }
    }

    private class TelephonyNetworkFactory extends NetworkFactory {
        private final SparseArray<NetworkRequest> mPendingReq;
        private Phone mPhone;

        public TelephonyNetworkFactory(Looper l, Context c, String TAG, Phone phone, NetworkCapabilities nc) {
            super(l, c, TAG, nc);
            this.mPendingReq = new SparseArray();
            this.mPhone = phone;
            log("NetworkCapabilities: " + nc);
        }

        protected void needNetworkFor(NetworkRequest networkRequest, int score) {
            log("Cellular needs Network for " + networkRequest);
            if (!SubscriptionManager.isUsableSubIdValue(this.mPhone.getSubId())) {
                log("Sub Info has not been ready, pending request.");
                this.mPendingReq.put(networkRequest.requestId, networkRequest);
            } else if (DctController.this.getRequestPhoneId(networkRequest) == this.mPhone.getPhoneId()) {
                DcTrackerBase dcTracker = ((PhoneBase) this.mPhone).mDcTracker;
                String apn = DctController.this.apnForNetworkRequest(networkRequest);
                if (dcTracker.isApnSupported(apn)) {
                    DctController.this.requestNetwork(networkRequest, dcTracker.getApnPriority(apn));
                } else {
                    log("Unsupported APN");
                }
            } else {
                log("Request not send, put to pending");
                this.mPendingReq.put(networkRequest.requestId, networkRequest);
            }
        }

        protected void releaseNetworkFor(NetworkRequest networkRequest) {
            log("Cellular releasing Network for " + networkRequest);
            if (!SubscriptionManager.isUsableSubIdValue(this.mPhone.getSubId())) {
                log("Sub Info has not been ready, remove request.");
                this.mPendingReq.remove(networkRequest.requestId);
            } else if (DctController.this.getRequestPhoneId(networkRequest) != this.mPhone.getPhoneId()) {
                log("Request not release");
            } else if (((PhoneBase) this.mPhone).mDcTracker.isApnSupported(DctController.this.apnForNetworkRequest(networkRequest))) {
                DctController.this.releaseNetwork(networkRequest);
            } else {
                log("Unsupported APN");
            }
        }

        protected void log(String s) {
            Rlog.d(DctController.LOG_TAG, "[TNF " + this.mPhone.getSubId() + "]" + s);
        }

        public void evalPendingRequest() {
            log("evalPendingRequest, pending request size is " + this.mPendingReq.size());
            for (int i = 0; i < this.mPendingReq.size(); i++) {
                NetworkRequest request = (NetworkRequest) this.mPendingReq.get(this.mPendingReq.keyAt(i));
                log("evalPendingRequest: request = " + request);
                this.mPendingReq.remove(request.requestId);
                needNetworkFor(request, 0);
            }
        }
    }

    public void updatePhoneObject(PhoneProxy phone) {
        if (phone == null) {
            loge("updatePhoneObject phone = null");
            return;
        }
        PhoneBase phoneBase = (PhoneBase) phone.getActivePhone();
        if (phoneBase == null) {
            loge("updatePhoneObject phoneBase = null");
            return;
        }
        for (int i = 0; i < this.mPhoneNum; i++) {
            if (this.mPhones[i] == phone) {
                updatePhoneBaseForIndex(i, phoneBase);
                return;
            }
        }
    }

    private void updatePhoneBaseForIndex(int index, PhoneBase phoneBase) {
        logd("updatePhoneBaseForIndex for phone index=" + index);
        phoneBase.getServiceStateTracker().registerForDataConnectionAttached(this.mRspHandler, index + EVENT_DATA_ATTACHED, null);
        phoneBase.getServiceStateTracker().registerForDataConnectionDetached(this.mRspHandler, index + EVENT_DATA_DETACHED, null);
        ConnectivityManager cm = (ConnectivityManager) this.mPhones[index].getContext().getSystemService("connectivity");
        if (this.mNetworkFactoryMessenger != null) {
            logd("unregister TelephonyNetworkFactory for phone index=" + index);
            cm.unregisterNetworkFactory(this.mNetworkFactoryMessenger[index]);
            this.mNetworkFactoryMessenger[index] = null;
            this.mNetworkFactory[index] = null;
            this.mNetworkFilter[index] = null;
        }
        this.mNetworkFilter[index] = new NetworkCapabilities();
        this.mNetworkFilter[index].addTransportType(0);
        this.mNetworkFilter[index].addCapability(0);
        this.mNetworkFilter[index].addCapability(1);
        this.mNetworkFilter[index].addCapability(2);
        this.mNetworkFilter[index].addCapability(3);
        this.mNetworkFilter[index].addCapability(4);
        this.mNetworkFilter[index].addCapability(5);
        this.mNetworkFilter[index].addCapability(7);
        this.mNetworkFilter[index].addCapability(8);
        this.mNetworkFilter[index].addCapability(9);
        this.mNetworkFilter[index].addCapability(10);
        this.mNetworkFilter[index].addCapability(13);
        this.mNetworkFilter[index].addCapability(12);
        this.mNetworkFactory[index] = new TelephonyNetworkFactory(getLooper(), this.mPhones[index].getContext(), "TelephonyNetworkFactory", phoneBase, this.mNetworkFilter[index]);
        this.mNetworkFactory[index].setScoreFilter(50);
        this.mNetworkFactoryMessenger[index] = new Messenger(this.mNetworkFactory[index]);
        cm.registerNetworkFactory(this.mNetworkFactoryMessenger[index], "Telephony");
    }

    public static DctController getInstance() {
        if (sDctController != null) {
            return sDctController;
        }
        throw new RuntimeException("DctController.getInstance can't be called before makeDCTController()");
    }

    public static DctController makeDctController(PhoneProxy[] phones) {
        if (sDctController == null) {
            logd("makeDctController: new DctController phones.length=" + phones.length);
            sDctController = new DctController(phones);
        }
        logd("makeDctController: X sDctController=" + sDctController);
        return sDctController;
    }

    private DctController(PhoneProxy[] phones) {
        this.mRequestInfos = new HashMap();
        this.mSubController = SubscriptionController.getInstance();
        this.mOnSubscriptionsChangedListener = new C00631();
        this.mObserver = new C00642(new Handler());
        this.mRspHandler = new C00653();
        logd("DctController(): phones.length=" + phones.length);
        if (phones != null && phones.length != 0) {
            this.mPhoneNum = phones.length;
            this.mPhones = phones;
            this.mDcSwitchStateMachine = new DcSwitchStateMachine[this.mPhoneNum];
            this.mDcSwitchAsyncChannel = new DcSwitchAsyncChannel[this.mPhoneNum];
            this.mDcSwitchStateHandler = new Handler[this.mPhoneNum];
            this.mNetworkFactoryMessenger = new Messenger[this.mPhoneNum];
            this.mNetworkFactory = new NetworkFactory[this.mPhoneNum];
            this.mNetworkFilter = new NetworkCapabilities[this.mPhoneNum];
            for (int i = 0; i < this.mPhoneNum; i++) {
                int phoneId = i;
                this.mDcSwitchStateMachine[i] = new DcSwitchStateMachine(this.mPhones[i], "DcSwitchStateMachine-" + phoneId, phoneId);
                this.mDcSwitchStateMachine[i].start();
                this.mDcSwitchAsyncChannel[i] = new DcSwitchAsyncChannel(this.mDcSwitchStateMachine[i], phoneId);
                this.mDcSwitchStateHandler[i] = new Handler();
                if (this.mDcSwitchAsyncChannel[i].fullyConnectSync(this.mPhones[i].getContext(), this.mDcSwitchStateHandler[i], this.mDcSwitchStateMachine[i].getHandler()) == 0) {
                    logd("DctController(phones): Connect success: " + i);
                } else {
                    loge("DctController(phones): Could not connect to " + i);
                }
                updatePhoneBaseForIndex(i, (PhoneBase) this.mPhones[i].getActivePhone());
            }
            this.mContext = this.mPhones[0].getContext();
            this.mSubMgr = SubscriptionManager.from(this.mContext);
            this.mSubMgr.addOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
            this.mContext.getContentResolver().registerContentObserver(Global.getUriFor("multi_sim_data_call"), false, this.mObserver);
        } else if (phones == null) {
            loge("DctController(phones): UNEXPECTED phones=null, ignore");
        } else {
            loge("DctController(phones): UNEXPECTED phones.length=0, ignore");
        }
    }

    public void dispose() {
        logd("DctController.dispose");
        for (int i = 0; i < this.mPhoneNum; i++) {
            ((ConnectivityManager) this.mPhones[i].getContext().getSystemService("connectivity")).unregisterNetworkFactory(this.mNetworkFactoryMessenger[i]);
            this.mNetworkFactoryMessenger[i] = null;
        }
        this.mSubMgr.removeOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
        this.mContext.getContentResolver().unregisterContentObserver(this.mObserver);
    }

    public void handleMessage(Message msg) {
        logd("handleMessage msg=" + msg);
        switch (msg.what) {
            case EVENT_PROCESS_REQUESTS /*100*/:
                onProcessRequest();
            case EVENT_EXECUTE_REQUEST /*101*/:
                onExecuteRequest((RequestInfo) msg.obj);
            case EVENT_EXECUTE_ALL_REQUESTS /*102*/:
                onExecuteAllRequests(msg.arg1);
            case EVENT_RELEASE_REQUEST /*103*/:
                onReleaseRequest((RequestInfo) msg.obj);
            case EVENT_RELEASE_ALL_REQUESTS /*104*/:
                onReleaseAllRequests(msg.arg1);
            default:
                loge("Un-handled message [" + msg.what + "]");
        }
    }

    private int requestNetwork(NetworkRequest request, int priority) {
        logd("requestNetwork request=" + request + ", priority=" + priority);
        this.mRequestInfos.put(Integer.valueOf(request.requestId), new RequestInfo(request, priority));
        processRequests();
        return 1;
    }

    private int releaseNetwork(NetworkRequest request) {
        RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(Integer.valueOf(request.requestId));
        logd("releaseNetwork request=" + request + ", requestInfo=" + requestInfo);
        this.mRequestInfos.remove(Integer.valueOf(request.requestId));
        releaseRequest(requestInfo);
        processRequests();
        return 1;
    }

    void processRequests() {
        logd("processRequests");
        sendMessage(obtainMessage(EVENT_PROCESS_REQUESTS));
    }

    void executeRequest(RequestInfo request) {
        logd("executeRequest, request= " + request);
        sendMessage(obtainMessage(EVENT_EXECUTE_REQUEST, request));
    }

    void executeAllRequests(int phoneId) {
        logd("executeAllRequests, phone:" + phoneId);
        sendMessage(obtainMessage(EVENT_EXECUTE_ALL_REQUESTS, phoneId, 0));
    }

    void releaseRequest(RequestInfo request) {
        logd("releaseRequest, request= " + request);
        sendMessage(obtainMessage(EVENT_RELEASE_REQUEST, request));
    }

    void releaseAllRequests(int phoneId) {
        logd("releaseAllRequests, phone:" + phoneId);
        sendMessage(obtainMessage(EVENT_RELEASE_ALL_REQUESTS, phoneId, 0));
    }

    private void onProcessRequest() {
        int phoneId = getTopPriorityRequestPhoneId();
        int activePhoneId = -1;
        for (int i = 0; i < this.mDcSwitchStateMachine.length; i++) {
            if (!this.mDcSwitchAsyncChannel[i].isIdleSync()) {
                activePhoneId = i;
                break;
            }
        }
        logd("onProcessRequest phoneId=" + phoneId + ", activePhoneId=" + activePhoneId);
        if (activePhoneId == -1 || activePhoneId == phoneId) {
            for (Object obj : this.mRequestInfos.keySet()) {
                RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(obj);
                if (getRequestPhoneId(requestInfo.request) == phoneId && !requestInfo.executed) {
                    this.mDcSwitchAsyncChannel[phoneId].connectSync(requestInfo);
                }
            }
            return;
        }
        this.mDcSwitchAsyncChannel[activePhoneId].disconnectAllSync();
    }

    private void onExecuteRequest(RequestInfo requestInfo) {
        logd("onExecuteRequest request=" + requestInfo);
        if (!requestInfo.executed) {
            requestInfo.executed = DBG;
            ((PhoneBase) this.mPhones[getRequestPhoneId(requestInfo.request)].getActivePhone()).mDcTracker.incApnRefCount(apnForNetworkRequest(requestInfo.request));
        }
    }

    private void onExecuteAllRequests(int phoneId) {
        logd("onExecuteAllRequests phoneId=" + phoneId);
        for (Object obj : this.mRequestInfos.keySet()) {
            RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(obj);
            if (getRequestPhoneId(requestInfo.request) == phoneId) {
                onExecuteRequest(requestInfo);
            }
        }
    }

    private void onReleaseRequest(RequestInfo requestInfo) {
        logd("onReleaseRequest request=" + requestInfo);
        if (requestInfo != null && requestInfo.executed) {
            ((PhoneBase) this.mPhones[getRequestPhoneId(requestInfo.request)].getActivePhone()).mDcTracker.decApnRefCount(apnForNetworkRequest(requestInfo.request));
            requestInfo.executed = false;
        }
    }

    private void onReleaseAllRequests(int phoneId) {
        logd("onReleaseAllRequests phoneId=" + phoneId);
        for (Object obj : this.mRequestInfos.keySet()) {
            RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(obj);
            if (getRequestPhoneId(requestInfo.request) == phoneId) {
                onReleaseRequest(requestInfo);
            }
        }
    }

    private void onSettingsChange() {
        int i;
        long dataSubId = (long) this.mSubController.getDefaultDataSubId();
        int activePhoneId = -1;
        for (i = 0; i < this.mDcSwitchStateMachine.length; i++) {
            if (!this.mDcSwitchAsyncChannel[i].isIdleSync()) {
                activePhoneId = i;
                break;
            }
        }
        int[] subIds = SubscriptionManager.getSubId(activePhoneId);
        if (subIds == null || subIds.length == 0) {
            loge("onSettingsChange, subIds null or length 0 for activePhoneId " + activePhoneId);
            return;
        }
        logd("onSettingsChange, data sub: " + dataSubId + ", active data sub: " + subIds[0]);
        if (((long) subIds[0]) != dataSubId) {
            for (Object obj : this.mRequestInfos.keySet()) {
                RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(obj);
                String specifier = requestInfo.request.networkCapabilities.getNetworkSpecifier();
                if ((specifier == null || specifier.equals("")) && requestInfo.executed) {
                    String apn = apnForNetworkRequest(requestInfo.request);
                    logd("[setDataSubId] activePhoneId:" + activePhoneId + ", subId =" + dataSubId);
                    ((PhoneBase) this.mPhones[activePhoneId].getActivePhone()).mDcTracker.decApnRefCount(apn);
                    requestInfo.executed = false;
                }
            }
        }
        for (i = 0; i < this.mPhoneNum; i++) {
            ((TelephonyNetworkFactory) this.mNetworkFactory[i]).evalPendingRequest();
        }
        processRequests();
    }

    private int getTopPriorityRequestPhoneId() {
        RequestInfo retRequestInfo = null;
        int phoneId = 0;
        int priority = -1;
        for (int i = 0; i < this.mPhoneNum; i++) {
            for (Object obj : this.mRequestInfos.keySet()) {
                RequestInfo requestInfo = (RequestInfo) this.mRequestInfos.get(obj);
                logd("selectExecPhone requestInfo = " + requestInfo);
                if (getRequestPhoneId(requestInfo.request) == i && priority < requestInfo.priority) {
                    priority = requestInfo.priority;
                    retRequestInfo = requestInfo;
                }
            }
        }
        if (retRequestInfo != null) {
            phoneId = getRequestPhoneId(retRequestInfo.request);
        }
        logd("getTopPriorityRequestPhoneId = " + phoneId + ", priority = " + priority);
        return phoneId;
    }

    private void onSubInfoReady() {
        logd("onSubInfoReady mPhoneNum=" + this.mPhoneNum);
        for (int i = 0; i < this.mPhoneNum; i++) {
            int subId = this.mPhones[i].getSubId();
            logd("onSubInfoReady handle pending requests subId=" + subId);
            this.mNetworkFilter[i].setNetworkSpecifier(String.valueOf(subId));
            ((TelephonyNetworkFactory) this.mNetworkFactory[i]).evalPendingRequest();
        }
        processRequests();
    }

    private String apnForNetworkRequest(NetworkRequest nr) {
        NetworkCapabilities nc = nr.networkCapabilities;
        if (nc.getTransportTypes().length > 0 && !nc.hasTransport(0)) {
            return null;
        }
        int type = -1;
        String name = null;
        boolean error = false;
        if (nc.hasCapability(12)) {
            if (null != null) {
                error = DBG;
            }
            name = "default";
            type = 0;
        }
        if (nc.hasCapability(0)) {
            if (name != null) {
                error = DBG;
            }
            name = "mms";
            type = 2;
        }
        if (nc.hasCapability(1)) {
            if (name != null) {
                error = DBG;
            }
            name = "supl";
            type = 3;
        }
        if (nc.hasCapability(2)) {
            if (name != null) {
                error = DBG;
            }
            name = "dun";
            type = 4;
        }
        if (nc.hasCapability(3)) {
            if (name != null) {
                error = DBG;
            }
            name = "fota";
            type = 10;
        }
        if (nc.hasCapability(4)) {
            if (name != null) {
                error = DBG;
            }
            name = "ims";
            type = 11;
        }
        if (nc.hasCapability(5)) {
            if (name != null) {
                error = DBG;
            }
            name = "cbs";
            type = 12;
        }
        if (nc.hasCapability(7)) {
            if (name != null) {
                error = DBG;
            }
            name = "ia";
            type = 14;
        }
        if (nc.hasCapability(8)) {
            if (name != null) {
                error = DBG;
            }
            name = null;
            loge("RCS APN type not yet supported");
        }
        if (nc.hasCapability(9)) {
            if (name != null) {
                error = DBG;
            }
            name = null;
            loge("XCAP APN type not yet supported");
        }
        if (nc.hasCapability(10)) {
            if (name != null) {
                error = DBG;
            }
            name = null;
            loge("EIMS APN type not yet supported");
        }
        if (error) {
            loge("Multiple apn types specified in request - result is unspecified!");
        }
        if (type != -1 && name != null) {
            return name;
        }
        loge("Unsupported NetworkRequest in Telephony: nr=" + nr);
        return null;
    }

    private int getRequestPhoneId(NetworkRequest networkRequest) {
        int subId;
        String specifier = networkRequest.networkCapabilities.getNetworkSpecifier();
        if (specifier == null || specifier.equals("")) {
            subId = this.mSubController.getDefaultDataSubId();
        } else {
            subId = Integer.parseInt(specifier);
        }
        int phoneId = this.mSubController.getPhoneId(subId);
        if (!SubscriptionManager.isValidPhoneId(phoneId)) {
            phoneId = 0;
            if (!SubscriptionManager.isValidPhoneId(0)) {
                throw new RuntimeException("Should not happen, no valid phoneId");
            }
        }
        return phoneId;
    }

    private static void logd(String s) {
        Rlog.d(LOG_TAG, s);
    }

    private static void loge(String s) {
        Rlog.e(LOG_TAG, s);
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        pw.println("DctController:");
        try {
            for (DcSwitchStateMachine dssm : this.mDcSwitchStateMachine) {
                dssm.dump(fd, pw, args);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        try {
            for (Entry<Integer, RequestInfo> entry : this.mRequestInfos.entrySet()) {
                pw.println("mRequestInfos[" + entry.getKey() + "]=" + entry.getValue());
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        pw.flush();
        pw.println("TelephonyNetworkFactories:");
        for (NetworkFactory tnf : this.mNetworkFactory) {
            pw.println("  " + tnf);
        }
        pw.flush();
        pw.println("++++++++++++++++++++++++++++++++");
        pw.flush();
    }
}
