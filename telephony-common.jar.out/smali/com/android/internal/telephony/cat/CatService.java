package com.android.internal.telephony.cat;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.content.res.Resources.NotFoundException;
import android.os.AsyncResult;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Message;
import android.os.SystemProperties;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import com.android.internal.telephony.CommandsInterface;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.SubscriptionController;
import com.android.internal.telephony.cat.AppInterface.CommandType;
import com.android.internal.telephony.cat.Duration.TimeUnit;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.uicc.IccCardStatus.CardState;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.android.internal.telephony.uicc.IccRecords;
import com.android.internal.telephony.uicc.IccRefreshResponse;
import com.android.internal.telephony.uicc.IccUtils;
import com.android.internal.telephony.uicc.UiccCard;
import com.android.internal.telephony.uicc.UiccCardApplication;
import com.android.internal.telephony.uicc.UiccController;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.io.ByteArrayOutputStream;
import java.util.List;
import java.util.Locale;

public class CatService extends Handler implements AppInterface {
    private static final boolean DBG = false;
    private static final int DEV_ID_DISPLAY = 2;
    private static final int DEV_ID_KEYPAD = 1;
    private static final int DEV_ID_NETWORK = 131;
    private static final int DEV_ID_TERMINAL = 130;
    private static final int DEV_ID_UICC = 129;
    protected static final int MSG_ID_ALPHA_NOTIFY = 9;
    protected static final int MSG_ID_CALL_SETUP = 4;
    protected static final int MSG_ID_EVENT_NOTIFY = 3;
    protected static final int MSG_ID_ICC_CHANGED = 8;
    private static final int MSG_ID_ICC_RECORDS_LOADED = 20;
    private static final int MSG_ID_ICC_REFRESH = 30;
    protected static final int MSG_ID_PROACTIVE_COMMAND = 2;
    static final int MSG_ID_REFRESH = 5;
    static final int MSG_ID_RESPONSE = 6;
    static final int MSG_ID_RIL_MSG_DECODED = 10;
    protected static final int MSG_ID_SESSION_END = 1;
    static final int MSG_ID_SIM_READY = 7;
    static final String STK_DEFAULT = "Default Message";
    private static IccRecords mIccRecords;
    private static UiccCardApplication mUiccApplication;
    private static CatService[] sInstance;
    private static final Object sInstanceLock;
    private CardState mCardState;
    private CommandsInterface mCmdIf;
    private Context mContext;
    private CatCmdMessage mCurrntCmd;
    private HandlerThread mHandlerThread;
    private CatCmdMessage mMenuCmd;
    private RilMessageDecoder mMsgDecoder;
    private int mSlotId;
    private boolean mStkAppInstalled;
    private UiccController mUiccController;

    /* renamed from: com.android.internal.telephony.cat.CatService.1 */
    static /* synthetic */ class C00271 {
        static final /* synthetic */ int[] f4xca33cf42;
        static final /* synthetic */ int[] $SwitchMap$com$android$internal$telephony$cat$ResultCode;

        static {
            $SwitchMap$com$android$internal$telephony$cat$ResultCode = new int[ResultCode.values().length];
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.HELP_INFO_REQUIRED.ordinal()] = CatService.MSG_ID_SESSION_END;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.OK.ordinal()] = CatService.MSG_ID_PROACTIVE_COMMAND;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_WITH_PARTIAL_COMPREHENSION.ordinal()] = CatService.MSG_ID_EVENT_NOTIFY;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_WITH_MISSING_INFO.ordinal()] = CatService.MSG_ID_CALL_SETUP;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_WITH_ADDITIONAL_EFS_READ.ordinal()] = CatService.MSG_ID_REFRESH;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_ICON_NOT_DISPLAYED.ordinal()] = CatService.MSG_ID_RESPONSE;
            } catch (NoSuchFieldError e6) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_MODIFIED_BY_NAA.ordinal()] = CatService.MSG_ID_SIM_READY;
            } catch (NoSuchFieldError e7) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_LIMITED_SERVICE.ordinal()] = CatService.MSG_ID_ICC_CHANGED;
            } catch (NoSuchFieldError e8) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_WITH_MODIFICATION.ordinal()] = CatService.MSG_ID_ALPHA_NOTIFY;
            } catch (NoSuchFieldError e9) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_NAA_NOT_ACTIVE.ordinal()] = CatService.MSG_ID_RIL_MSG_DECODED;
            } catch (NoSuchFieldError e10) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.PRFRMD_TONE_NOT_PLAYED.ordinal()] = 11;
            } catch (NoSuchFieldError e11) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.TERMINAL_CRNTLY_UNABLE_TO_PROCESS.ordinal()] = 12;
            } catch (NoSuchFieldError e12) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.BACKWARD_MOVE_BY_USER.ordinal()] = 13;
            } catch (NoSuchFieldError e13) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.USER_NOT_ACCEPT.ordinal()] = 14;
            } catch (NoSuchFieldError e14) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.NO_RESPONSE_FROM_USER.ordinal()] = 15;
            } catch (NoSuchFieldError e15) {
            }
            try {
                $SwitchMap$com$android$internal$telephony$cat$ResultCode[ResultCode.UICC_SESSION_TERM_BY_USER.ordinal()] = 16;
            } catch (NoSuchFieldError e16) {
            }
            f4xca33cf42 = new int[CommandType.values().length];
            try {
                f4xca33cf42[CommandType.SET_UP_MENU.ordinal()] = CatService.MSG_ID_SESSION_END;
            } catch (NoSuchFieldError e17) {
            }
            try {
                f4xca33cf42[CommandType.DISPLAY_TEXT.ordinal()] = CatService.MSG_ID_PROACTIVE_COMMAND;
            } catch (NoSuchFieldError e18) {
            }
            try {
                f4xca33cf42[CommandType.REFRESH.ordinal()] = CatService.MSG_ID_EVENT_NOTIFY;
            } catch (NoSuchFieldError e19) {
            }
            try {
                f4xca33cf42[CommandType.SET_UP_IDLE_MODE_TEXT.ordinal()] = CatService.MSG_ID_CALL_SETUP;
            } catch (NoSuchFieldError e20) {
            }
            try {
                f4xca33cf42[CommandType.SET_UP_EVENT_LIST.ordinal()] = CatService.MSG_ID_REFRESH;
            } catch (NoSuchFieldError e21) {
            }
            try {
                f4xca33cf42[CommandType.PROVIDE_LOCAL_INFORMATION.ordinal()] = CatService.MSG_ID_RESPONSE;
            } catch (NoSuchFieldError e22) {
            }
            try {
                f4xca33cf42[CommandType.LAUNCH_BROWSER.ordinal()] = CatService.MSG_ID_SIM_READY;
            } catch (NoSuchFieldError e23) {
            }
            try {
                f4xca33cf42[CommandType.SELECT_ITEM.ordinal()] = CatService.MSG_ID_ICC_CHANGED;
            } catch (NoSuchFieldError e24) {
            }
            try {
                f4xca33cf42[CommandType.GET_INPUT.ordinal()] = CatService.MSG_ID_ALPHA_NOTIFY;
            } catch (NoSuchFieldError e25) {
            }
            try {
                f4xca33cf42[CommandType.GET_INKEY.ordinal()] = CatService.MSG_ID_RIL_MSG_DECODED;
            } catch (NoSuchFieldError e26) {
            }
            try {
                f4xca33cf42[CommandType.SEND_DTMF.ordinal()] = 11;
            } catch (NoSuchFieldError e27) {
            }
            try {
                f4xca33cf42[CommandType.SEND_SMS.ordinal()] = 12;
            } catch (NoSuchFieldError e28) {
            }
            try {
                f4xca33cf42[CommandType.SEND_SS.ordinal()] = 13;
            } catch (NoSuchFieldError e29) {
            }
            try {
                f4xca33cf42[CommandType.SEND_USSD.ordinal()] = 14;
            } catch (NoSuchFieldError e30) {
            }
            try {
                f4xca33cf42[CommandType.PLAY_TONE.ordinal()] = 15;
            } catch (NoSuchFieldError e31) {
            }
            try {
                f4xca33cf42[CommandType.SET_UP_CALL.ordinal()] = 16;
            } catch (NoSuchFieldError e32) {
            }
            try {
                f4xca33cf42[CommandType.OPEN_CHANNEL.ordinal()] = 17;
            } catch (NoSuchFieldError e33) {
            }
            try {
                f4xca33cf42[CommandType.CLOSE_CHANNEL.ordinal()] = 18;
            } catch (NoSuchFieldError e34) {
            }
            try {
                f4xca33cf42[CommandType.RECEIVE_DATA.ordinal()] = 19;
            } catch (NoSuchFieldError e35) {
            }
            try {
                f4xca33cf42[CommandType.SEND_DATA.ordinal()] = CatService.MSG_ID_ICC_RECORDS_LOADED;
            } catch (NoSuchFieldError e36) {
            }
        }
    }

    static {
        sInstanceLock = new Object();
        sInstance = null;
    }

    private CatService(CommandsInterface ci, UiccCardApplication ca, IccRecords ir, Context context, IccFileHandler fh, UiccCard ic, int slotId) {
        this.mCurrntCmd = null;
        this.mMenuCmd = null;
        this.mMsgDecoder = null;
        this.mStkAppInstalled = DBG;
        this.mCardState = CardState.CARDSTATE_ABSENT;
        if (ci == null || ca == null || ir == null || context == null || fh == null || ic == null) {
            throw new NullPointerException("Service: Input parameters must not be null");
        }
        this.mCmdIf = ci;
        this.mContext = context;
        this.mSlotId = slotId;
        this.mHandlerThread = new HandlerThread("Cat Telephony service" + slotId);
        this.mHandlerThread.start();
        this.mMsgDecoder = RilMessageDecoder.getInstance(this, fh, slotId);
        if (this.mMsgDecoder == null) {
            CatLog.m0d((Object) this, "Null RilMessageDecoder instance");
            return;
        }
        this.mMsgDecoder.start();
        this.mCmdIf.setOnCatSessionEnd(this, MSG_ID_SESSION_END, null);
        this.mCmdIf.setOnCatProactiveCmd(this, MSG_ID_PROACTIVE_COMMAND, null);
        this.mCmdIf.setOnCatEvent(this, MSG_ID_EVENT_NOTIFY, null);
        this.mCmdIf.setOnCatCallSetUp(this, MSG_ID_CALL_SETUP, null);
        this.mCmdIf.registerForIccRefresh(this, MSG_ID_ICC_REFRESH, null);
        this.mCmdIf.setOnCatCcAlphaNotify(this, MSG_ID_ALPHA_NOTIFY, null);
        mIccRecords = ir;
        mUiccApplication = ca;
        mIccRecords.registerForRecordsLoaded(this, MSG_ID_ICC_RECORDS_LOADED, null);
        CatLog.m0d((Object) this, "registerForRecordsLoaded slotid=" + this.mSlotId + " instance:" + this);
        this.mUiccController = UiccController.getInstance();
        this.mUiccController.registerForIccChanged(this, MSG_ID_ICC_CHANGED, null);
        this.mStkAppInstalled = isStkAppInstalled();
        CatLog.m0d((Object) this, "Running CAT service on Slotid: " + this.mSlotId + ". STK app installed:" + this.mStkAppInstalled);
    }

    public static CatService getInstance(CommandsInterface ci, Context context, UiccCard ic, int slotId) {
        CatService catService = null;
        UiccCardApplication ca = null;
        IccFileHandler fh = null;
        IccRecords ir = null;
        if (ic != null) {
            ca = ic.getApplicationIndex(0);
            if (ca != null) {
                fh = ca.getIccFileHandler();
                ir = ca.getIccRecords();
            }
        }
        synchronized (sInstanceLock) {
            if (sInstance == null) {
                int simCount = TelephonyManager.getDefault().getSimCount();
                sInstance = new CatService[simCount];
                for (int i = 0; i < simCount; i += MSG_ID_SESSION_END) {
                    sInstance[i] = null;
                }
            }
            if (sInstance[slotId] != null) {
                if (ir != null) {
                    if (mIccRecords != ir) {
                        if (mIccRecords != null) {
                            mIccRecords.unregisterForRecordsLoaded(sInstance[slotId]);
                        }
                        mIccRecords = ir;
                        mUiccApplication = ca;
                        mIccRecords.registerForRecordsLoaded(sInstance[slotId], MSG_ID_ICC_RECORDS_LOADED, null);
                        CatLog.m0d(sInstance[slotId], "registerForRecordsLoaded slotid=" + slotId + " instance:" + sInstance[slotId]);
                    }
                }
                catService = sInstance[slotId];
            } else if (ci == null || ca == null || ir == null || context == null || fh == null || ic == null) {
            } else {
                sInstance[slotId] = new CatService(ci, ca, ir, context, fh, ic, slotId);
                catService = sInstance[slotId];
            }
        }
        return catService;
    }

    public void dispose() {
        synchronized (sInstanceLock) {
            CatLog.m0d((Object) this, "Disposing CatService object");
            mIccRecords.unregisterForRecordsLoaded(this);
            broadcastCardStateAndIccRefreshResp(CardState.CARDSTATE_ABSENT, null);
            this.mCmdIf.unSetOnCatSessionEnd(this);
            this.mCmdIf.unSetOnCatProactiveCmd(this);
            this.mCmdIf.unSetOnCatEvent(this);
            this.mCmdIf.unSetOnCatCallSetUp(this);
            this.mCmdIf.unSetOnCatCcAlphaNotify(this);
            this.mCmdIf.unregisterForIccRefresh(this);
            if (this.mUiccController != null) {
                this.mUiccController.unregisterForIccChanged(this);
                this.mUiccController = null;
            }
            this.mMsgDecoder.dispose();
            this.mMsgDecoder = null;
            this.mHandlerThread.quit();
            this.mHandlerThread = null;
            removeCallbacksAndMessages(null);
            if (sInstance != null) {
                if (SubscriptionManager.isValidSlotId(this.mSlotId)) {
                    sInstance[this.mSlotId] = null;
                } else {
                    CatLog.m0d((Object) this, "error: invaild slot id: " + this.mSlotId);
                }
            }
        }
    }

    protected void finalize() {
        CatLog.m0d((Object) this, "Service finalized");
    }

    private void handleRilMsg(RilMessage rilMsg) {
        if (rilMsg != null) {
            CommandParams cmdParams;
            switch (rilMsg.mId) {
                case MSG_ID_SESSION_END /*1*/:
                    handleSessionEnd();
                case MSG_ID_PROACTIVE_COMMAND /*2*/:
                    try {
                        cmdParams = (CommandParams) rilMsg.mData;
                        if (cmdParams == null) {
                            return;
                        }
                        if (rilMsg.mResCode == ResultCode.OK) {
                            handleCommand(cmdParams, true);
                        } else {
                            sendTerminalResponse(cmdParams.mCmdDet, rilMsg.mResCode, DBG, 0, null);
                        }
                    } catch (ClassCastException e) {
                        CatLog.m0d((Object) this, "Fail to parse proactive command");
                        if (this.mCurrntCmd != null) {
                            sendTerminalResponse(this.mCurrntCmd.mCmdDet, ResultCode.CMD_DATA_NOT_UNDERSTOOD, DBG, 0, null);
                        }
                    }
                case MSG_ID_EVENT_NOTIFY /*3*/:
                    if (rilMsg.mResCode == ResultCode.OK) {
                        cmdParams = rilMsg.mData;
                        if (cmdParams != null) {
                            handleCommand(cmdParams, DBG);
                        }
                    }
                case MSG_ID_REFRESH /*5*/:
                    cmdParams = rilMsg.mData;
                    if (cmdParams != null) {
                        handleCommand(cmdParams, DBG);
                    }
                default:
            }
        }
    }

    private boolean isSupportedSetupEventCommand(CatCmdMessage cmdMsg) {
        boolean flag = true;
        int[] arr$ = cmdMsg.getSetEventList().eventList;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += MSG_ID_SESSION_END) {
            int eventVal = arr$[i$];
            CatLog.m0d((Object) this, "Event: " + eventVal);
            switch (eventVal) {
                case MSG_ID_REFRESH /*5*/:
                case MSG_ID_SIM_READY /*7*/:
                    break;
                default:
                    flag = DBG;
                    break;
            }
        }
        return flag;
    }

    private void handleCommand(CommandParams cmdParams, boolean isProactiveCmd) {
        CatLog.m0d((Object) this, cmdParams.getCommandType().name());
        if (isProactiveCmd && this.mUiccController != null) {
            this.mUiccController.addCardLog("ProactiveCommand mSlotId=" + this.mSlotId + " cmdParams=" + cmdParams);
        }
        CatCmdMessage cmdMsg = new CatCmdMessage(cmdParams);
        CharSequence message;
        switch (C00271.f4xca33cf42[cmdParams.getCommandType().ordinal()]) {
            case MSG_ID_SESSION_END /*1*/:
                if (removeMenu(cmdMsg.getMenu())) {
                    this.mMenuCmd = null;
                } else {
                    this.mMenuCmd = cmdMsg;
                }
                sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                break;
            case MSG_ID_PROACTIVE_COMMAND /*2*/:
            case MSG_ID_ICC_CHANGED /*8*/:
            case MSG_ID_ALPHA_NOTIFY /*9*/:
            case MSG_ID_RIL_MSG_DECODED /*10*/:
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                break;
            case MSG_ID_EVENT_NOTIFY /*3*/:
                cmdParams.mCmdDet.typeOfCommand = CommandType.SET_UP_IDLE_MODE_TEXT.value();
                break;
            case MSG_ID_CALL_SETUP /*4*/:
                sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                break;
            case MSG_ID_REFRESH /*5*/:
                if (!isSupportedSetupEventCommand(cmdMsg)) {
                    sendTerminalResponse(cmdParams.mCmdDet, ResultCode.BEYOND_TERMINAL_CAPABILITY, DBG, 0, null);
                    break;
                } else {
                    sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                    break;
                }
            case MSG_ID_RESPONSE /*6*/:
                switch (cmdParams.mCmdDet.commandQualifier) {
                    case MSG_ID_EVENT_NOTIFY /*3*/:
                        sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, new DTTZResponseData(null));
                        return;
                    case MSG_ID_CALL_SETUP /*4*/:
                        sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, new LanguageResponseData(Locale.getDefault().getLanguage()));
                        return;
                    default:
                        sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                        return;
                }
            case MSG_ID_SIM_READY /*7*/:
                if (((LaunchBrowserParams) cmdParams).mConfirmMsg.text != null && ((LaunchBrowserParams) cmdParams).mConfirmMsg.text.equals(STK_DEFAULT)) {
                    message = this.mContext.getText(17040856);
                    ((LaunchBrowserParams) cmdParams).mConfirmMsg.text = message.toString();
                    break;
                }
            case CharacterSets.ISO_8859_8 /*11*/:
            case CharacterSets.ISO_8859_9 /*12*/:
            case UserData.ASCII_CR_INDEX /*13*/:
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                if (((DisplayTextParams) cmdParams).mTextMsg.text != null && ((DisplayTextParams) cmdParams).mTextMsg.text.equals(STK_DEFAULT)) {
                    message = this.mContext.getText(17040855);
                    ((DisplayTextParams) cmdParams).mTextMsg.text = message.toString();
                    break;
                }
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
                if (((CallSetupParams) cmdParams).mConfirmMsg.text != null && ((CallSetupParams) cmdParams).mConfirmMsg.text.equals(STK_DEFAULT)) {
                    message = this.mContext.getText(17040857);
                    ((CallSetupParams) cmdParams).mConfirmMsg.text = message.toString();
                    break;
                }
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
            case PduHeaders.MMS_VERSION_1_2 /*18*/:
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
            case MSG_ID_ICC_RECORDS_LOADED /*20*/:
                BIPClientParams cmd = (BIPClientParams) cmdParams;
                boolean noAlphaUsrCnf;
                try {
                    noAlphaUsrCnf = this.mContext.getResources().getBoolean(17956987);
                } catch (NotFoundException e) {
                    noAlphaUsrCnf = DBG;
                }
                if (cmd.mTextMsg.text != null || (!cmd.mHasAlphaId && !noAlphaUsrCnf)) {
                    if (!this.mStkAppInstalled) {
                        CatLog.m0d((Object) this, "No STK application found.");
                        if (isProactiveCmd) {
                            sendTerminalResponse(cmdParams.mCmdDet, ResultCode.BEYOND_TERMINAL_CAPABILITY, DBG, 0, null);
                            return;
                        }
                    }
                    if (isProactiveCmd && (cmdParams.getCommandType() == CommandType.CLOSE_CHANNEL || cmdParams.getCommandType() == CommandType.RECEIVE_DATA || cmdParams.getCommandType() == CommandType.SEND_DATA)) {
                        sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                        break;
                    }
                }
                CatLog.m0d((Object) this, "cmd " + cmdParams.getCommandType() + " with null alpha id");
                if (isProactiveCmd) {
                    sendTerminalResponse(cmdParams.mCmdDet, ResultCode.OK, DBG, 0, null);
                    return;
                } else if (cmdParams.getCommandType() == CommandType.OPEN_CHANNEL) {
                    this.mCmdIf.handleCallSetupRequestFromSim(true, null);
                    return;
                } else {
                    return;
                }
                break;
            default:
                CatLog.m0d((Object) this, "Unsupported command");
                return;
        }
        this.mCurrntCmd = cmdMsg;
        broadcastCatCmdIntent(cmdMsg);
    }

    private void broadcastCatCmdIntent(CatCmdMessage cmdMsg) {
        Intent intent = new Intent(AppInterface.CAT_CMD_ACTION);
        intent.putExtra("STK CMD", cmdMsg);
        intent.putExtra("SLOT_ID", this.mSlotId);
        CatLog.m0d((Object) this, "Sending CmdMsg: " + cmdMsg + " on slotid:" + this.mSlotId);
        this.mContext.sendBroadcast(intent, AppInterface.STK_PERMISSION);
    }

    private void handleSessionEnd() {
        CatLog.m0d((Object) this, "SESSION END on " + this.mSlotId);
        this.mCurrntCmd = this.mMenuCmd;
        Intent intent = new Intent(AppInterface.CAT_SESSION_END_ACTION);
        intent.putExtra("SLOT_ID", this.mSlotId);
        this.mContext.sendBroadcast(intent, AppInterface.STK_PERMISSION);
    }

    private void sendTerminalResponse(CommandDetails cmdDet, ResultCode resultCode, boolean includeAdditionalInfo, int additionalInfo, ResponseData resp) {
        int length = MSG_ID_PROACTIVE_COMMAND;
        if (cmdDet != null) {
            ByteArrayOutputStream buf = new ByteArrayOutputStream();
            Input cmdInput = null;
            if (this.mCurrntCmd != null) {
                cmdInput = this.mCurrntCmd.geInput();
            }
            int tag = ComprehensionTlvTag.COMMAND_DETAILS.value();
            if (cmdDet.compRequired) {
                tag |= PduPart.P_Q;
            }
            buf.write(tag);
            buf.write(MSG_ID_EVENT_NOTIFY);
            buf.write(cmdDet.commandNumber);
            buf.write(cmdDet.typeOfCommand);
            buf.write(cmdDet.commandQualifier);
            buf.write(ComprehensionTlvTag.DEVICE_IDENTITIES.value());
            buf.write(MSG_ID_PROACTIVE_COMMAND);
            buf.write(DEV_ID_TERMINAL);
            buf.write(DEV_ID_UICC);
            tag = ComprehensionTlvTag.RESULT.value();
            if (cmdDet.compRequired) {
                tag |= PduPart.P_Q;
            }
            buf.write(tag);
            if (!includeAdditionalInfo) {
                length = MSG_ID_SESSION_END;
            }
            buf.write(length);
            buf.write(resultCode.value());
            if (includeAdditionalInfo) {
                buf.write(additionalInfo);
            }
            if (resp != null) {
                resp.format(buf);
            } else {
                encodeOptionalTags(cmdDet, resultCode, cmdInput, buf);
            }
            this.mCmdIf.sendTerminalResponse(IccUtils.bytesToHexString(buf.toByteArray()), null);
        }
    }

    private void encodeOptionalTags(CommandDetails cmdDet, ResultCode resultCode, Input cmdInput, ByteArrayOutputStream buf) {
        CommandType cmdType = CommandType.fromInt(cmdDet.typeOfCommand);
        if (cmdType != null) {
            switch (C00271.f4xca33cf42[cmdType.ordinal()]) {
                case MSG_ID_RESPONSE /*6*/:
                    if (cmdDet.commandQualifier == MSG_ID_CALL_SETUP && resultCode.value() == ResultCode.OK.value()) {
                        getPliResponse(buf);
                        return;
                    }
                    return;
                case MSG_ID_RIL_MSG_DECODED /*10*/:
                    if (resultCode.value() == ResultCode.NO_RESPONSE_FROM_USER.value() && cmdInput != null && cmdInput.duration != null) {
                        getInKeyResponse(buf, cmdInput);
                        return;
                    }
                    return;
                default:
                    CatLog.m0d((Object) this, "encodeOptionalTags() Unsupported Cmd details=" + cmdDet);
                    return;
            }
        }
        CatLog.m0d((Object) this, "encodeOptionalTags() bad Cmd details=" + cmdDet);
    }

    private void getInKeyResponse(ByteArrayOutputStream buf, Input cmdInput) {
        buf.write(ComprehensionTlvTag.DURATION.value());
        buf.write(MSG_ID_PROACTIVE_COMMAND);
        TimeUnit timeUnit = cmdInput.duration.timeUnit;
        buf.write(TimeUnit.SECOND.value());
        buf.write(cmdInput.duration.timeInterval);
    }

    private void getPliResponse(ByteArrayOutputStream buf) {
        String lang = SystemProperties.get("persist.sys.language");
        if (lang != null) {
            buf.write(ComprehensionTlvTag.LANGUAGE.value());
            ResponseData.writeLength(buf, lang.length());
            buf.write(lang.getBytes(), 0, lang.length());
        }
    }

    private void sendMenuSelection(int menuId, boolean helpRequired) {
        ByteArrayOutputStream buf = new ByteArrayOutputStream();
        buf.write(BerTlv.BER_MENU_SELECTION_TAG);
        buf.write(0);
        buf.write(ComprehensionTlvTag.DEVICE_IDENTITIES.value() | PduPart.P_Q);
        buf.write(MSG_ID_PROACTIVE_COMMAND);
        buf.write(MSG_ID_SESSION_END);
        buf.write(DEV_ID_UICC);
        buf.write(ComprehensionTlvTag.ITEM_ID.value() | PduPart.P_Q);
        buf.write(MSG_ID_SESSION_END);
        buf.write(menuId);
        if (helpRequired) {
            buf.write(ComprehensionTlvTag.HELP_REQUEST.value());
            buf.write(0);
        }
        byte[] rawData = buf.toByteArray();
        rawData[MSG_ID_SESSION_END] = (byte) (rawData.length - 2);
        this.mCmdIf.sendEnvelope(IccUtils.bytesToHexString(rawData), null);
    }

    private void eventDownload(int event, int sourceId, int destinationId, byte[] additionalInfo, boolean oneShot) {
        ByteArrayOutputStream buf = new ByteArrayOutputStream();
        buf.write(BerTlv.BER_EVENT_DOWNLOAD_TAG);
        buf.write(0);
        buf.write(ComprehensionTlvTag.EVENT_LIST.value() | PduPart.P_Q);
        buf.write(MSG_ID_SESSION_END);
        buf.write(event);
        buf.write(ComprehensionTlvTag.DEVICE_IDENTITIES.value() | PduPart.P_Q);
        buf.write(MSG_ID_PROACTIVE_COMMAND);
        buf.write(sourceId);
        buf.write(destinationId);
        switch (event) {
            case MSG_ID_REFRESH /*5*/:
                CatLog.m0d(sInstance, " Sending Idle Screen Available event download to ICC");
                break;
            case MSG_ID_SIM_READY /*7*/:
                CatLog.m0d(sInstance, " Sending Language Selection event download to ICC");
                buf.write(ComprehensionTlvTag.LANGUAGE.value() | PduPart.P_Q);
                buf.write(MSG_ID_PROACTIVE_COMMAND);
                break;
        }
        if (additionalInfo != null) {
            byte[] arr$ = additionalInfo;
            int len$ = arr$.length;
            for (int i$ = 0; i$ < len$; i$ += MSG_ID_SESSION_END) {
                buf.write(arr$[i$]);
            }
        }
        byte[] rawData = buf.toByteArray();
        rawData[MSG_ID_SESSION_END] = (byte) (rawData.length - 2);
        String hexString = IccUtils.bytesToHexString(rawData);
        CatLog.m0d((Object) this, "ENVELOPE COMMAND: " + hexString);
        this.mCmdIf.sendEnvelope(hexString, null);
    }

    public static AppInterface getInstance() {
        int slotId = 0;
        SubscriptionController sControl = SubscriptionController.getInstance();
        if (sControl != null) {
            slotId = sControl.getSlotId(sControl.getDefaultSubId());
        }
        return getInstance(null, null, null, slotId);
    }

    public static AppInterface getInstance(int slotId) {
        return getInstance(null, null, null, slotId);
    }

    public void handleMessage(Message msg) {
        CatLog.m0d((Object) this, "handleMessage[" + msg.what + "]");
        AsyncResult ar;
        switch (msg.what) {
            case MSG_ID_SESSION_END /*1*/:
            case MSG_ID_PROACTIVE_COMMAND /*2*/:
            case MSG_ID_EVENT_NOTIFY /*3*/:
            case MSG_ID_REFRESH /*5*/:
                CatLog.m0d((Object) this, "ril message arrived,slotid:" + this.mSlotId);
                String data = null;
                if (msg.obj != null) {
                    ar = msg.obj;
                    if (!(ar == null || ar.result == null)) {
                        try {
                            data = ar.result;
                        } catch (ClassCastException e) {
                            return;
                        }
                    }
                }
                this.mMsgDecoder.sendStartDecodingMessageParams(new RilMessage(msg.what, data));
            case MSG_ID_CALL_SETUP /*4*/:
                this.mMsgDecoder.sendStartDecodingMessageParams(new RilMessage(msg.what, null));
            case MSG_ID_RESPONSE /*6*/:
                handleCmdResponse((CatResponseMessage) msg.obj);
            case MSG_ID_ICC_CHANGED /*8*/:
                CatLog.m0d((Object) this, "MSG_ID_ICC_CHANGED");
                updateIccAvailability();
            case MSG_ID_ALPHA_NOTIFY /*9*/:
                CatLog.m0d((Object) this, "Received CAT CC Alpha message from card");
                if (msg.obj != null) {
                    ar = (AsyncResult) msg.obj;
                    if (ar == null || ar.result == null) {
                        CatLog.m0d((Object) this, "CAT Alpha message: ar.result is null");
                        return;
                    } else {
                        broadcastAlphaMessage((String) ar.result);
                        return;
                    }
                }
                CatLog.m0d((Object) this, "CAT Alpha message: msg.obj is null");
            case MSG_ID_RIL_MSG_DECODED /*10*/:
                handleRilMsg((RilMessage) msg.obj);
            case MSG_ID_ICC_RECORDS_LOADED /*20*/:
            case MSG_ID_ICC_REFRESH /*30*/:
                if (msg.obj != null) {
                    ar = (AsyncResult) msg.obj;
                    if (ar == null || ar.result == null) {
                        CatLog.m0d((Object) this, "Icc REFRESH with exception: " + ar.exception);
                        return;
                    } else {
                        broadcastCardStateAndIccRefreshResp(CardState.CARDSTATE_PRESENT, (IccRefreshResponse) ar.result);
                        return;
                    }
                }
                CatLog.m0d((Object) this, "IccRefresh Message is null");
            default:
                throw new AssertionError("Unrecognized CAT command: " + msg.what);
        }
    }

    private void broadcastCardStateAndIccRefreshResp(CardState cardState, IccRefreshResponse iccRefreshState) {
        Intent intent = new Intent(AppInterface.CAT_ICC_STATUS_CHANGE);
        boolean cardPresent = cardState == CardState.CARDSTATE_PRESENT ? true : DBG;
        if (iccRefreshState != null) {
            intent.putExtra(AppInterface.REFRESH_RESULT, iccRefreshState.refreshResult);
            CatLog.m0d((Object) this, "Sending IccResult with Result: " + iccRefreshState.refreshResult);
        }
        intent.putExtra(AppInterface.CARD_STATUS, cardPresent);
        CatLog.m0d((Object) this, "Sending Card Status: " + cardState + " " + "cardPresent: " + cardPresent);
        this.mContext.sendBroadcast(intent, AppInterface.STK_PERMISSION);
    }

    private void broadcastAlphaMessage(String alphaString) {
        CatLog.m0d((Object) this, "Broadcasting CAT Alpha message from card: " + alphaString);
        Intent intent = new Intent(AppInterface.CAT_ALPHA_NOTIFY_ACTION);
        intent.addFlags(268435456);
        intent.putExtra(AppInterface.ALPHA_STRING, alphaString);
        intent.putExtra("SLOT_ID", this.mSlotId);
        this.mContext.sendBroadcast(intent, AppInterface.STK_PERMISSION);
    }

    public synchronized void onCmdResponse(CatResponseMessage resMsg) {
        if (resMsg != null) {
            obtainMessage(MSG_ID_RESPONSE, resMsg).sendToTarget();
        }
    }

    private boolean validateResponse(CatResponseMessage resMsg) {
        if (resMsg.mCmdDet.typeOfCommand == CommandType.SET_UP_EVENT_LIST.value() || resMsg.mCmdDet.typeOfCommand == CommandType.SET_UP_MENU.value()) {
            CatLog.m0d((Object) this, "CmdType: " + resMsg.mCmdDet.typeOfCommand);
            return true;
        } else if (this.mCurrntCmd == null) {
            return DBG;
        } else {
            boolean validResponse = resMsg.mCmdDet.compareTo(this.mCurrntCmd.mCmdDet);
            CatLog.m0d((Object) this, "isResponse for last valid cmd: " + validResponse);
            return validResponse;
        }
    }

    private boolean removeMenu(Menu menu) {
        try {
            if (menu.items.size() == MSG_ID_SESSION_END && menu.items.get(0) == null) {
                return true;
            }
            return DBG;
        } catch (NullPointerException e) {
            CatLog.m0d((Object) this, "Unable to get Menu's items size");
            return true;
        }
    }

    private void handleCmdResponse(CatResponseMessage resMsg) {
        if (validateResponse(resMsg)) {
            ResponseData resp;
            boolean helpRequired = DBG;
            CommandDetails cmdDet = resMsg.getCmdDetails();
            CommandType type = CommandType.fromInt(cmdDet.typeOfCommand);
            switch (C00271.$SwitchMap$com$android$internal$telephony$cat$ResultCode[resMsg.mResCode.ordinal()]) {
                case MSG_ID_SESSION_END /*1*/:
                    helpRequired = true;
                    break;
                case MSG_ID_PROACTIVE_COMMAND /*2*/:
                case MSG_ID_EVENT_NOTIFY /*3*/:
                case MSG_ID_CALL_SETUP /*4*/:
                case MSG_ID_REFRESH /*5*/:
                case MSG_ID_RESPONSE /*6*/:
                case MSG_ID_SIM_READY /*7*/:
                case MSG_ID_ICC_CHANGED /*8*/:
                case MSG_ID_ALPHA_NOTIFY /*9*/:
                case MSG_ID_RIL_MSG_DECODED /*10*/:
                case CharacterSets.ISO_8859_8 /*11*/:
                case CharacterSets.ISO_8859_9 /*12*/:
                    break;
                case UserData.ASCII_CR_INDEX /*13*/:
                case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                    if (type != CommandType.SET_UP_CALL && type != CommandType.OPEN_CHANNEL) {
                        resp = null;
                        break;
                    }
                    this.mCmdIf.handleCallSetupRequestFromSim(DBG, null);
                    this.mCurrntCmd = null;
                    return;
                case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                case PduHeaders.MMS_VERSION_1_0 /*16*/:
                    resp = null;
                    break;
                default:
                    return;
            }
            switch (C00271.f4xca33cf42[type.ordinal()]) {
                case MSG_ID_SESSION_END /*1*/:
                    if (resMsg.mResCode == ResultCode.HELP_INFO_REQUIRED) {
                        helpRequired = true;
                    } else {
                        helpRequired = DBG;
                    }
                    sendMenuSelection(resMsg.mUsersMenuSelection, helpRequired);
                    return;
                case MSG_ID_PROACTIVE_COMMAND /*2*/:
                    if (resMsg.mResCode != ResultCode.TERMINAL_CRNTLY_UNABLE_TO_PROCESS) {
                        resMsg.mIncludeAdditionalInfo = DBG;
                        resMsg.mAdditionalInfo = 0;
                        resp = null;
                        break;
                    }
                    resMsg.setAdditionalInfo(MSG_ID_SESSION_END);
                    resp = null;
                    break;
                case MSG_ID_REFRESH /*5*/:
                    if (MSG_ID_REFRESH == resMsg.mEventValue) {
                        eventDownload(resMsg.mEventValue, MSG_ID_PROACTIVE_COMMAND, DEV_ID_UICC, resMsg.mAddedInfo, DBG);
                        return;
                    } else {
                        eventDownload(resMsg.mEventValue, DEV_ID_TERMINAL, DEV_ID_UICC, resMsg.mAddedInfo, DBG);
                        return;
                    }
                case MSG_ID_SIM_READY /*7*/:
                    resp = null;
                    break;
                case MSG_ID_ICC_CHANGED /*8*/:
                    resp = new SelectItemResponseData(resMsg.mUsersMenuSelection);
                    break;
                case MSG_ID_ALPHA_NOTIFY /*9*/:
                case MSG_ID_RIL_MSG_DECODED /*10*/:
                    Input input = this.mCurrntCmd.geInput();
                    if (!input.yesNo) {
                        if (!helpRequired) {
                            resp = new GetInkeyInputResponseData(resMsg.mUsersInput, input.ucs2, input.packed);
                            break;
                        } else {
                            resp = null;
                            break;
                        }
                    }
                    resp = new GetInkeyInputResponseData(resMsg.mUsersYesNoSelection);
                    break;
                case PduHeaders.MMS_VERSION_1_0 /*16*/:
                case PduHeaders.MMS_VERSION_1_1 /*17*/:
                    this.mCmdIf.handleCallSetupRequestFromSim(resMsg.mUsersConfirm, null);
                    this.mCurrntCmd = null;
                    return;
                default:
                    resp = null;
                    break;
            }
            sendTerminalResponse(cmdDet, resMsg.mResCode, resMsg.mIncludeAdditionalInfo, resMsg.mAdditionalInfo, resp);
            this.mCurrntCmd = null;
        }
    }

    private boolean isStkAppInstalled() {
        List<ResolveInfo> broadcastReceivers = this.mContext.getPackageManager().queryBroadcastReceivers(new Intent(AppInterface.CAT_CMD_ACTION), PduPart.P_Q);
        if ((broadcastReceivers == null ? 0 : broadcastReceivers.size()) > 0) {
            return true;
        }
        return DBG;
    }

    public void update(CommandsInterface ci, Context context, UiccCard ic) {
        UiccCardApplication ca = null;
        IccRecords ir = null;
        if (ic != null) {
            ca = ic.getApplicationIndex(0);
            if (ca != null) {
                ir = ca.getIccRecords();
            }
        }
        synchronized (sInstanceLock) {
            if (ir != null) {
                if (mIccRecords != ir) {
                    if (mIccRecords != null) {
                        mIccRecords.unregisterForRecordsLoaded(this);
                    }
                    CatLog.m0d((Object) this, "Reinitialize the Service with SIMRecords and UiccCardApplication");
                    mIccRecords = ir;
                    mUiccApplication = ca;
                    mIccRecords.registerForRecordsLoaded(this, MSG_ID_ICC_RECORDS_LOADED, null);
                    CatLog.m0d((Object) this, "registerForRecordsLoaded slotid=" + this.mSlotId + " instance:" + this);
                }
            }
        }
    }

    void updateIccAvailability() {
        if (this.mUiccController != null) {
            CardState newState = CardState.CARDSTATE_ABSENT;
            UiccCard newCard = this.mUiccController.getUiccCard(this.mSlotId);
            if (newCard != null) {
                newState = newCard.getCardState();
            }
            CardState oldState = this.mCardState;
            this.mCardState = newState;
            CatLog.m0d((Object) this, "New Card State = " + newState + " " + "Old Card State = " + oldState);
            if (oldState == CardState.CARDSTATE_PRESENT && newState != CardState.CARDSTATE_PRESENT) {
                broadcastCardStateAndIccRefreshResp(newState, null);
            } else if (oldState != CardState.CARDSTATE_PRESENT && newState == CardState.CARDSTATE_PRESENT) {
                this.mCmdIf.reportStkServiceIsRunning(null);
            }
        }
    }
}
