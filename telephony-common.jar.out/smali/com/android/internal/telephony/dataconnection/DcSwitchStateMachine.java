package com.android.internal.telephony.dataconnection;

import android.os.Message;
import android.telephony.Rlog;
import com.android.internal.telephony.Phone;
import com.android.internal.telephony.PhoneBase;
import com.android.internal.telephony.PhoneProxy;
import com.android.internal.telephony.dataconnection.DcSwitchAsyncChannel.RequestInfo;
import com.android.internal.util.AsyncChannel;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;

public class DcSwitchStateMachine extends StateMachine {
    private static final int BASE = 274432;
    private static final boolean DBG = true;
    private static final int EVENT_CONNECTED = 274432;
    private static final String LOG_TAG = "DcSwitchSM";
    private static final boolean VDBG = false;
    private AsyncChannel mAc;
    private AttachedState mAttachedState;
    private AttachingState mAttachingState;
    private DefaultState mDefaultState;
    private DetachingState mDetachingState;
    private int mId;
    private IdleState mIdleState;
    private Phone mPhone;

    private class AttachedState extends State {
        private AttachedState() {
        }

        public void enter() {
            DcSwitchStateMachine.this.log("AttachedState: enter");
            DctController.getInstance().executeAllRequests(DcSwitchStateMachine.this.mId);
        }

        public boolean processMessage(Message msg) {
            RequestInfo apnRequest;
            switch (msg.what) {
                case 278528:
                    apnRequest = msg.obj;
                    DcSwitchStateMachine.this.log("AttachedState: REQ_CONNECT, apnRequest=" + apnRequest);
                    DctController.getInstance().executeRequest(apnRequest);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278529, 1);
                    return DcSwitchStateMachine.DBG;
                case 278530:
                    apnRequest = (RequestInfo) msg.obj;
                    DcSwitchStateMachine.this.log("AttachedState: REQ_DISCONNECT apnRequest=" + apnRequest);
                    DctController.getInstance().releaseRequest(apnRequest);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278529, 1);
                    return DcSwitchStateMachine.DBG;
                case 278532:
                    DcSwitchStateMachine.this.log("AttachedState: REQ_DISCONNECT_ALL");
                    DctController.getInstance().releaseAllRequests(DcSwitchStateMachine.this.mId);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278533, 1);
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mDetachingState);
                    return DcSwitchStateMachine.DBG;
                case 278539:
                    DcSwitchStateMachine.this.log("AttachedState: EVENT_DATA_DETACHED");
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mAttachingState);
                    return DcSwitchStateMachine.DBG;
                default:
                    return false;
            }
        }
    }

    private class AttachingState extends State {
        private AttachingState() {
        }

        public void enter() {
            DcSwitchStateMachine.this.log("AttachingState: enter");
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case 278528:
                    DcSwitchStateMachine.this.log("AttachingState: REQ_CONNECT");
                    ((PhoneBase) ((PhoneProxy) DcSwitchStateMachine.this.mPhone).getActivePhone()).mCi.setDataAllowed(DcSwitchStateMachine.DBG, null);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278529, 1);
                    return DcSwitchStateMachine.DBG;
                case 278532:
                    DcSwitchStateMachine.this.log("AttachingState: REQ_DISCONNECT_ALL");
                    DctController.getInstance().releaseAllRequests(DcSwitchStateMachine.this.mId);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278533, 1);
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mDetachingState);
                    return DcSwitchStateMachine.DBG;
                case 278538:
                    DcSwitchStateMachine.this.log("AttachingState: EVENT_DATA_ATTACHED");
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mAttachedState);
                    return DcSwitchStateMachine.DBG;
                default:
                    return false;
            }
        }
    }

    private class DefaultState extends State {
        private DefaultState() {
        }

        public boolean processMessage(Message msg) {
            int i = 0;
            boolean val;
            AsyncChannel access$700;
            switch (msg.what) {
                case 69633:
                    if (DcSwitchStateMachine.this.mAc == null) {
                        DcSwitchStateMachine.this.mAc = new AsyncChannel();
                        DcSwitchStateMachine.this.mAc.connected(null, DcSwitchStateMachine.this.getHandler(), msg.replyTo);
                        DcSwitchStateMachine.this.mAc.replyToMessage(msg, 69634, 0, DcSwitchStateMachine.this.mId, "hi");
                        break;
                    }
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 69634, 3);
                    break;
                case 69635:
                    DcSwitchStateMachine.this.mAc.disconnect();
                    break;
                case 69636:
                    DcSwitchStateMachine.this.mAc = null;
                    break;
                case 278534:
                    if (DcSwitchStateMachine.this.getCurrentState() == DcSwitchStateMachine.this.mIdleState) {
                        val = DcSwitchStateMachine.DBG;
                    } else {
                        val = false;
                    }
                    access$700 = DcSwitchStateMachine.this.mAc;
                    if (val) {
                        i = 1;
                    }
                    access$700.replyToMessage(msg, 278535, i);
                    break;
                case 278536:
                    if (DcSwitchStateMachine.this.getCurrentState() == DcSwitchStateMachine.this.mIdleState || DcSwitchStateMachine.this.getCurrentState() == DcSwitchStateMachine.this.mDetachingState) {
                        val = DcSwitchStateMachine.DBG;
                    } else {
                        val = false;
                    }
                    access$700 = DcSwitchStateMachine.this.mAc;
                    if (val) {
                        i = 1;
                    }
                    access$700.replyToMessage(msg, 278537, i);
                    break;
                default:
                    DcSwitchStateMachine.this.log("DefaultState: shouldn't happen but ignore msg.what=0x" + Integer.toHexString(msg.what));
                    break;
            }
            return DcSwitchStateMachine.DBG;
        }
    }

    private class DetachingState extends State {
        private DetachingState() {
        }

        public void enter() {
            DcSwitchStateMachine.this.log("DetachingState: enter");
            ((PhoneBase) ((PhoneProxy) DcSwitchStateMachine.this.mPhone).getActivePhone()).mCi.setDataAllowed(false, DcSwitchStateMachine.this.obtainMessage(278539));
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case 278532:
                    DcSwitchStateMachine.this.log("DetachingState: REQ_DISCONNECT_ALL, already detaching");
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278533, 1);
                    return DcSwitchStateMachine.DBG;
                case 278539:
                    DcSwitchStateMachine.this.log("DetachingState: EVENT_DATA_DETACHED");
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mIdleState);
                    return DcSwitchStateMachine.DBG;
                default:
                    return false;
            }
        }
    }

    private class IdleState extends State {
        private IdleState() {
        }

        public void enter() {
            DcSwitchStateMachine.this.log("IdleState: enter");
            try {
                DctController.getInstance().processRequests();
            } catch (RuntimeException e) {
                DcSwitchStateMachine.this.loge("DctController is not ready");
            }
        }

        public boolean processMessage(Message msg) {
            switch (msg.what) {
                case DcSwitchStateMachine.EVENT_CONNECTED /*274432*/:
                    DcSwitchStateMachine.this.log("IdleState: Receive invalid event EVENT_CONNECTED!");
                    return DcSwitchStateMachine.DBG;
                case 278528:
                    DcSwitchStateMachine.this.log("IdleState: REQ_CONNECT");
                    ((PhoneBase) ((PhoneProxy) DcSwitchStateMachine.this.mPhone).getActivePhone()).mCi.setDataAllowed(DcSwitchStateMachine.DBG, null);
                    DcSwitchStateMachine.this.mAc.replyToMessage(msg, 278529, 1);
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mAttachingState);
                    return DcSwitchStateMachine.DBG;
                case 278538:
                    DcSwitchStateMachine.this.log("AttachingState: EVENT_DATA_ATTACHED");
                    DcSwitchStateMachine.this.transitionTo(DcSwitchStateMachine.this.mAttachedState);
                    return DcSwitchStateMachine.DBG;
                default:
                    return false;
            }
        }
    }

    protected DcSwitchStateMachine(Phone phone, String name, int id) {
        super(name);
        this.mIdleState = new IdleState();
        this.mAttachingState = new AttachingState();
        this.mAttachedState = new AttachedState();
        this.mDetachingState = new DetachingState();
        this.mDefaultState = new DefaultState();
        log("DcSwitchState constructor E");
        this.mPhone = phone;
        this.mId = id;
        addState(this.mDefaultState);
        addState(this.mIdleState, this.mDefaultState);
        addState(this.mAttachingState, this.mDefaultState);
        addState(this.mAttachedState, this.mDefaultState);
        addState(this.mDetachingState, this.mDefaultState);
        setInitialState(this.mIdleState);
        log("DcSwitchState constructor X");
    }

    protected void log(String s) {
        Rlog.d(LOG_TAG, "[" + getName() + "] " + s);
    }
}
