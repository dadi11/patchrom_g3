package com.android.internal.telephony.cat;

import android.os.Handler;
import android.os.Message;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccUtils;
import com.android.internal.util.State;
import com.android.internal.util.StateMachine;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduPersister;

class RilMessageDecoder extends StateMachine {
    private static final int CMD_PARAMS_READY = 2;
    private static final int CMD_START = 1;
    private static RilMessageDecoder[] mInstance;
    private static int mSimCount;
    private Handler mCaller;
    private CommandParamsFactory mCmdParamsFactory;
    private RilMessage mCurrentRilMessage;
    private StateCmdParamsReady mStateCmdParamsReady;
    private StateStart mStateStart;

    private class StateCmdParamsReady extends State {
        private StateCmdParamsReady() {
        }

        public boolean processMessage(Message msg) {
            if (msg.what == RilMessageDecoder.CMD_PARAMS_READY) {
                RilMessageDecoder.this.mCurrentRilMessage.mResCode = ResultCode.fromInt(msg.arg1);
                RilMessageDecoder.this.mCurrentRilMessage.mData = msg.obj;
                RilMessageDecoder.this.sendCmdForExecution(RilMessageDecoder.this.mCurrentRilMessage);
                RilMessageDecoder.this.transitionTo(RilMessageDecoder.this.mStateStart);
            } else {
                CatLog.m0d((Object) this, "StateCmdParamsReady expecting CMD_PARAMS_READY=2 got " + msg.what);
                RilMessageDecoder.this.deferMessage(msg);
            }
            return true;
        }
    }

    private class StateStart extends State {
        private StateStart() {
        }

        public boolean processMessage(Message msg) {
            if (msg.what != RilMessageDecoder.CMD_START) {
                CatLog.m0d((Object) this, "StateStart unexpected expecting START=1 got " + msg.what);
            } else if (RilMessageDecoder.this.decodeMessageParams((RilMessage) msg.obj)) {
                RilMessageDecoder.this.transitionTo(RilMessageDecoder.this.mStateCmdParamsReady);
            }
            return true;
        }
    }

    static {
        mSimCount = 0;
        mInstance = null;
    }

    public static synchronized RilMessageDecoder getInstance(Handler caller, IccFileHandler fh, int slotId) {
        RilMessageDecoder rilMessageDecoder = null;
        synchronized (RilMessageDecoder.class) {
            if (mInstance == null) {
                mSimCount = TelephonyManager.getDefault().getSimCount();
                mInstance = new RilMessageDecoder[mSimCount];
                for (int i = 0; i < mSimCount; i += CMD_START) {
                    mInstance[i] = null;
                }
            }
            if (slotId == -1 || slotId >= mSimCount) {
                CatLog.m1d("RilMessageDecoder", "invaild slot id: " + slotId);
            } else {
                if (mInstance[slotId] == null) {
                    mInstance[slotId] = new RilMessageDecoder(caller, fh);
                }
                rilMessageDecoder = mInstance[slotId];
            }
        }
        return rilMessageDecoder;
    }

    public void sendStartDecodingMessageParams(RilMessage rilMsg) {
        Message msg = obtainMessage(CMD_START);
        msg.obj = rilMsg;
        sendMessage(msg);
    }

    public void sendMsgParamsDecoded(ResultCode resCode, CommandParams cmdParams) {
        Message msg = obtainMessage(CMD_PARAMS_READY);
        msg.arg1 = resCode.value();
        msg.obj = cmdParams;
        sendMessage(msg);
    }

    private void sendCmdForExecution(RilMessage rilMsg) {
        this.mCaller.obtainMessage(10, new RilMessage(rilMsg)).sendToTarget();
    }

    private RilMessageDecoder(Handler caller, IccFileHandler fh) {
        super("RilMessageDecoder");
        this.mCmdParamsFactory = null;
        this.mCurrentRilMessage = null;
        this.mCaller = null;
        this.mStateStart = new StateStart();
        this.mStateCmdParamsReady = new StateCmdParamsReady();
        addState(this.mStateStart);
        addState(this.mStateCmdParamsReady);
        setInitialState(this.mStateStart);
        this.mCaller = caller;
        this.mCmdParamsFactory = CommandParamsFactory.getInstance(this, fh);
    }

    private RilMessageDecoder() {
        super("RilMessageDecoder");
        this.mCmdParamsFactory = null;
        this.mCurrentRilMessage = null;
        this.mCaller = null;
        this.mStateStart = new StateStart();
        this.mStateCmdParamsReady = new StateCmdParamsReady();
    }

    private boolean decodeMessageParams(RilMessage rilMsg) {
        this.mCurrentRilMessage = rilMsg;
        switch (rilMsg.mId) {
            case CMD_START /*1*/:
            case CharacterSets.ISO_8859_1 /*4*/:
                this.mCurrentRilMessage.mResCode = ResultCode.OK;
                sendCmdForExecution(this.mCurrentRilMessage);
                return false;
            case CMD_PARAMS_READY /*2*/:
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_2 /*5*/:
                try {
                    try {
                        this.mCmdParamsFactory.make(BerTlv.decode(IccUtils.hexStringToBytes((String) rilMsg.mData)));
                        return true;
                    } catch (ResultException e) {
                        CatLog.m0d((Object) this, "decodeMessageParams: caught ResultException e=" + e);
                        this.mCurrentRilMessage.mResCode = e.result();
                        sendCmdForExecution(this.mCurrentRilMessage);
                        return false;
                    }
                } catch (Exception e2) {
                    CatLog.m0d((Object) this, "decodeMessageParams dropping zombie messages");
                    return false;
                }
            default:
                return false;
        }
    }

    public void dispose() {
        this.mStateStart = null;
        this.mStateCmdParamsReady = null;
        this.mCmdParamsFactory.dispose();
        this.mCmdParamsFactory = null;
        this.mCurrentRilMessage = null;
        this.mCaller = null;
        mInstance = null;
    }
}
