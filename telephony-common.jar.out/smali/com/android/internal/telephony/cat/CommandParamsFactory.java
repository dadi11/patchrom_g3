package com.android.internal.telephony.cat;

import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Message;
import com.android.internal.telephony.GsmAlphabet;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cat.AppInterface.CommandType;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.android.internal.telephony.uicc.IccFileHandler;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPart;
import java.util.Iterator;
import java.util.List;

class CommandParamsFactory extends Handler {
    static final int DTTZ_SETTING = 3;
    static final int LANGUAGE_SETTING = 4;
    static final int LOAD_MULTI_ICONS = 2;
    static final int LOAD_NO_ICON = 0;
    static final int LOAD_SINGLE_ICON = 1;
    static final int MSG_ID_LOAD_ICON_DONE = 1;
    static final int REFRESH_NAA_INIT = 3;
    static final int REFRESH_NAA_INIT_AND_FILE_CHANGE = 2;
    static final int REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE = 0;
    static final int REFRESH_UICC_RESET = 4;
    private static CommandParamsFactory sInstance;
    private RilMessageDecoder mCaller;
    private CommandParams mCmdParams;
    private int mIconLoadState;
    private IconLoader mIconLoader;

    /* renamed from: com.android.internal.telephony.cat.CommandParamsFactory.1 */
    static /* synthetic */ class C00291 {
        static final /* synthetic */ int[] f5xca33cf42;

        static {
            f5xca33cf42 = new int[CommandType.values().length];
            try {
                f5xca33cf42[CommandType.SET_UP_MENU.ordinal()] = CommandParamsFactory.MSG_ID_LOAD_ICON_DONE;
            } catch (NoSuchFieldError e) {
            }
            try {
                f5xca33cf42[CommandType.SELECT_ITEM.ordinal()] = CommandParamsFactory.REFRESH_NAA_INIT_AND_FILE_CHANGE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f5xca33cf42[CommandType.DISPLAY_TEXT.ordinal()] = CommandParamsFactory.REFRESH_NAA_INIT;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f5xca33cf42[CommandType.SET_UP_IDLE_MODE_TEXT.ordinal()] = CommandParamsFactory.REFRESH_UICC_RESET;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f5xca33cf42[CommandType.GET_INKEY.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f5xca33cf42[CommandType.GET_INPUT.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                f5xca33cf42[CommandType.SEND_DTMF.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
            try {
                f5xca33cf42[CommandType.SEND_SMS.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
            try {
                f5xca33cf42[CommandType.SEND_SS.ordinal()] = 9;
            } catch (NoSuchFieldError e9) {
            }
            try {
                f5xca33cf42[CommandType.SEND_USSD.ordinal()] = 10;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f5xca33cf42[CommandType.GET_CHANNEL_STATUS.ordinal()] = 11;
            } catch (NoSuchFieldError e11) {
            }
            try {
                f5xca33cf42[CommandType.SET_UP_CALL.ordinal()] = 12;
            } catch (NoSuchFieldError e12) {
            }
            try {
                f5xca33cf42[CommandType.REFRESH.ordinal()] = 13;
            } catch (NoSuchFieldError e13) {
            }
            try {
                f5xca33cf42[CommandType.LAUNCH_BROWSER.ordinal()] = 14;
            } catch (NoSuchFieldError e14) {
            }
            try {
                f5xca33cf42[CommandType.PLAY_TONE.ordinal()] = 15;
            } catch (NoSuchFieldError e15) {
            }
            try {
                f5xca33cf42[CommandType.SET_UP_EVENT_LIST.ordinal()] = 16;
            } catch (NoSuchFieldError e16) {
            }
            try {
                f5xca33cf42[CommandType.PROVIDE_LOCAL_INFORMATION.ordinal()] = 17;
            } catch (NoSuchFieldError e17) {
            }
            try {
                f5xca33cf42[CommandType.OPEN_CHANNEL.ordinal()] = 18;
            } catch (NoSuchFieldError e18) {
            }
            try {
                f5xca33cf42[CommandType.CLOSE_CHANNEL.ordinal()] = 19;
            } catch (NoSuchFieldError e19) {
            }
            try {
                f5xca33cf42[CommandType.RECEIVE_DATA.ordinal()] = 20;
            } catch (NoSuchFieldError e20) {
            }
            try {
                f5xca33cf42[CommandType.SEND_DATA.ordinal()] = 21;
            } catch (NoSuchFieldError e21) {
            }
        }
    }

    static {
        sInstance = null;
    }

    static synchronized CommandParamsFactory getInstance(RilMessageDecoder caller, IccFileHandler fh) {
        CommandParamsFactory commandParamsFactory;
        synchronized (CommandParamsFactory.class) {
            if (sInstance != null) {
                commandParamsFactory = sInstance;
            } else if (fh != null) {
                commandParamsFactory = new CommandParamsFactory(caller, fh);
            } else {
                commandParamsFactory = null;
            }
        }
        return commandParamsFactory;
    }

    private CommandParamsFactory(RilMessageDecoder caller, IccFileHandler fh) {
        this.mCmdParams = null;
        this.mIconLoadState = REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE;
        this.mCaller = null;
        this.mCaller = caller;
        this.mIconLoader = IconLoader.getInstance(this, fh);
    }

    private CommandDetails processCommandDetails(List<ComprehensionTlv> ctlvs) {
        CommandDetails cmdDet = null;
        if (ctlvs != null) {
            ComprehensionTlv ctlvCmdDet = searchForTag(ComprehensionTlvTag.COMMAND_DETAILS, ctlvs);
            if (ctlvCmdDet != null) {
                try {
                    cmdDet = ValueParser.retrieveCommandDetails(ctlvCmdDet);
                } catch (ResultException e) {
                    CatLog.m0d((Object) this, "processCommandDetails: Failed to procees command details e=" + e);
                }
            }
        }
        return cmdDet;
    }

    void make(BerTlv berTlv) {
        if (berTlv != null) {
            this.mCmdParams = null;
            this.mIconLoadState = REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE;
            if (berTlv.getTag() != BerTlv.BER_PROACTIVE_COMMAND_TAG) {
                sendCmdParams(ResultCode.CMD_TYPE_NOT_UNDERSTOOD);
                return;
            }
            List<ComprehensionTlv> ctlvs = berTlv.getComprehensionTlvs();
            CommandDetails cmdDet = processCommandDetails(ctlvs);
            if (cmdDet == null) {
                sendCmdParams(ResultCode.CMD_TYPE_NOT_UNDERSTOOD);
                return;
            }
            CommandType cmdType = CommandType.fromInt(cmdDet.typeOfCommand);
            if (cmdType == null) {
                this.mCmdParams = new CommandParams(cmdDet);
                sendCmdParams(ResultCode.BEYOND_TERMINAL_CAPABILITY);
            } else if (berTlv.isLengthValid()) {
                try {
                    boolean cmdPending;
                    switch (C00291.f5xca33cf42[cmdType.ordinal()]) {
                        case MSG_ID_LOAD_ICON_DONE /*1*/:
                            cmdPending = processSelectItem(cmdDet, ctlvs);
                            break;
                        case REFRESH_NAA_INIT_AND_FILE_CHANGE /*2*/:
                            cmdPending = processSelectItem(cmdDet, ctlvs);
                            break;
                        case REFRESH_NAA_INIT /*3*/:
                            cmdPending = processDisplayText(cmdDet, ctlvs);
                            break;
                        case REFRESH_UICC_RESET /*4*/:
                            cmdPending = processSetUpIdleModeText(cmdDet, ctlvs);
                            break;
                        case CharacterSets.ISO_8859_2 /*5*/:
                            cmdPending = processGetInkey(cmdDet, ctlvs);
                            break;
                        case CharacterSets.ISO_8859_3 /*6*/:
                            cmdPending = processGetInput(cmdDet, ctlvs);
                            break;
                        case CharacterSets.ISO_8859_4 /*7*/:
                        case CharacterSets.ISO_8859_5 /*8*/:
                        case CharacterSets.ISO_8859_6 /*9*/:
                        case CharacterSets.ISO_8859_7 /*10*/:
                            cmdPending = processEventNotify(cmdDet, ctlvs);
                            break;
                        case CharacterSets.ISO_8859_8 /*11*/:
                        case CharacterSets.ISO_8859_9 /*12*/:
                            cmdPending = processSetupCall(cmdDet, ctlvs);
                            break;
                        case UserData.ASCII_CR_INDEX /*13*/:
                            processRefresh(cmdDet, ctlvs);
                            cmdPending = false;
                            break;
                        case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                            cmdPending = processLaunchBrowser(cmdDet, ctlvs);
                            break;
                        case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                            cmdPending = processPlayTone(cmdDet, ctlvs);
                            break;
                        case PduHeaders.MMS_VERSION_1_0 /*16*/:
                            cmdPending = processSetUpEventList(cmdDet, ctlvs);
                            break;
                        case PduHeaders.MMS_VERSION_1_1 /*17*/:
                            cmdPending = processProvideLocalInfo(cmdDet, ctlvs);
                            break;
                        case PduHeaders.MMS_VERSION_1_2 /*18*/:
                        case PduHeaders.MMS_VERSION_1_3 /*19*/:
                        case SmsHeader.ELT_ID_EXTENDED_OBJECT /*20*/:
                        case SmsHeader.ELT_ID_REUSED_EXTENDED_OBJECT /*21*/:
                            cmdPending = processBIPClient(cmdDet, ctlvs);
                            break;
                        default:
                            this.mCmdParams = new CommandParams(cmdDet);
                            sendCmdParams(ResultCode.BEYOND_TERMINAL_CAPABILITY);
                            return;
                    }
                    if (!cmdPending) {
                        sendCmdParams(ResultCode.OK);
                    }
                } catch (ResultException e) {
                    CatLog.m0d((Object) this, "make: caught ResultException e=" + e);
                    this.mCmdParams = new CommandParams(cmdDet);
                    sendCmdParams(e.result());
                }
            } else {
                this.mCmdParams = new CommandParams(cmdDet);
                sendCmdParams(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
            }
        }
    }

    public void handleMessage(Message msg) {
        switch (msg.what) {
            case MSG_ID_LOAD_ICON_DONE /*1*/:
                sendCmdParams(setIcons(msg.obj));
            default:
        }
    }

    private ResultCode setIcons(Object data) {
        if (data == null) {
            return ResultCode.OK;
        }
        switch (this.mIconLoadState) {
            case MSG_ID_LOAD_ICON_DONE /*1*/:
                this.mCmdParams.setIcon((Bitmap) data);
                break;
            case REFRESH_NAA_INIT_AND_FILE_CHANGE /*2*/:
                Bitmap[] arr$ = (Bitmap[]) data;
                int len$ = arr$.length;
                for (int i$ = REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE; i$ < len$; i$ += MSG_ID_LOAD_ICON_DONE) {
                    this.mCmdParams.setIcon(arr$[i$]);
                }
                break;
        }
        return ResultCode.OK;
    }

    private void sendCmdParams(ResultCode resCode) {
        this.mCaller.sendMsgParamsDecoded(resCode, this.mCmdParams);
    }

    private ComprehensionTlv searchForTag(ComprehensionTlvTag tag, List<ComprehensionTlv> ctlvs) {
        return searchForNextTag(tag, ctlvs.iterator());
    }

    private ComprehensionTlv searchForNextTag(ComprehensionTlvTag tag, Iterator<ComprehensionTlv> iter) {
        int tagValue = tag.value();
        while (iter.hasNext()) {
            ComprehensionTlv ctlv = (ComprehensionTlv) iter.next();
            if (ctlv.getTag() == tagValue) {
                return ctlv;
            }
        }
        return null;
    }

    private boolean processDisplayText(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process DisplayText");
        TextMessage textMsg = new TextMessage();
        IconId iconId = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.TEXT_STRING, ctlvs);
        if (ctlv != null) {
            textMsg.text = ValueParser.retrieveTextString(ctlv);
        }
        if (textMsg.text == null) {
            throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
        }
        boolean z;
        if (searchForTag(ComprehensionTlvTag.IMMEDIATE_RESPONSE, ctlvs) != null) {
            textMsg.responseNeeded = false;
        }
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            iconId = ValueParser.retrieveIconId(ctlv);
            textMsg.iconSelfExplanatory = iconId.selfExplanatory;
        }
        ctlv = searchForTag(ComprehensionTlvTag.DURATION, ctlvs);
        if (ctlv != null) {
            textMsg.duration = ValueParser.retrieveDuration(ctlv);
        }
        textMsg.isHighPriority = (cmdDet.commandQualifier & MSG_ID_LOAD_ICON_DONE) != 0;
        if ((cmdDet.commandQualifier & PduPart.P_Q) != 0) {
            z = true;
        } else {
            z = false;
        }
        textMsg.userClear = z;
        this.mCmdParams = new DisplayTextParams(cmdDet, textMsg);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processSetUpIdleModeText(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process SetUpIdleModeText");
        TextMessage textMsg = new TextMessage();
        IconId iconId = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.TEXT_STRING, ctlvs);
        if (ctlv != null) {
            textMsg.text = ValueParser.retrieveTextString(ctlv);
        }
        if (textMsg.text != null) {
            ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
            if (ctlv != null) {
                iconId = ValueParser.retrieveIconId(ctlv);
                textMsg.iconSelfExplanatory = iconId.selfExplanatory;
            }
        }
        this.mCmdParams = new DisplayTextParams(cmdDet, textMsg);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processGetInkey(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process GetInkey");
        Input input = new Input();
        IconId iconId = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.TEXT_STRING, ctlvs);
        if (ctlv != null) {
            boolean z;
            input.text = ValueParser.retrieveTextString(ctlv);
            ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
            if (ctlv != null) {
                iconId = ValueParser.retrieveIconId(ctlv);
            }
            ctlv = searchForTag(ComprehensionTlvTag.DURATION, ctlvs);
            if (ctlv != null) {
                input.duration = ValueParser.retrieveDuration(ctlv);
            }
            input.minLen = MSG_ID_LOAD_ICON_DONE;
            input.maxLen = MSG_ID_LOAD_ICON_DONE;
            input.digitOnly = (cmdDet.commandQualifier & MSG_ID_LOAD_ICON_DONE) == 0;
            if ((cmdDet.commandQualifier & REFRESH_NAA_INIT_AND_FILE_CHANGE) != 0) {
                z = true;
            } else {
                z = false;
            }
            input.ucs2 = z;
            if ((cmdDet.commandQualifier & REFRESH_UICC_RESET) != 0) {
                z = true;
            } else {
                z = false;
            }
            input.yesNo = z;
            if ((cmdDet.commandQualifier & PduPart.P_Q) != 0) {
                z = true;
            } else {
                z = false;
            }
            input.helpAvailable = z;
            input.echo = true;
            this.mCmdParams = new GetInputParams(cmdDet, input);
            if (iconId == null) {
                return false;
            }
            this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
            this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
            return true;
        }
        throw new ResultException(ResultCode.REQUIRED_VALUES_MISSING);
    }

    private boolean processGetInput(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process GetInput");
        Input input = new Input();
        IconId iconId = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.TEXT_STRING, ctlvs);
        if (ctlv != null) {
            input.text = ValueParser.retrieveTextString(ctlv);
            ctlv = searchForTag(ComprehensionTlvTag.RESPONSE_LENGTH, ctlvs);
            if (ctlv != null) {
                try {
                    boolean z;
                    byte[] rawValue = ctlv.getRawValue();
                    int valueIndex = ctlv.getValueIndex();
                    input.minLen = rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END;
                    input.maxLen = rawValue[valueIndex + MSG_ID_LOAD_ICON_DONE] & PduHeaders.STORE_STATUS_ERROR_END;
                    ctlv = searchForTag(ComprehensionTlvTag.DEFAULT_TEXT, ctlvs);
                    if (ctlv != null) {
                        input.defaultText = ValueParser.retrieveTextString(ctlv);
                    }
                    ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
                    if (ctlv != null) {
                        iconId = ValueParser.retrieveIconId(ctlv);
                    }
                    if ((cmdDet.commandQualifier & MSG_ID_LOAD_ICON_DONE) == 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    input.digitOnly = z;
                    if ((cmdDet.commandQualifier & REFRESH_NAA_INIT_AND_FILE_CHANGE) != 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    input.ucs2 = z;
                    if ((cmdDet.commandQualifier & REFRESH_UICC_RESET) == 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    input.echo = z;
                    if ((cmdDet.commandQualifier & 8) != 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    input.packed = z;
                    if ((cmdDet.commandQualifier & PduPart.P_Q) != 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    input.helpAvailable = z;
                    this.mCmdParams = new GetInputParams(cmdDet, input);
                    if (iconId == null) {
                        return false;
                    }
                    this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
                    this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
                    return true;
                } catch (IndexOutOfBoundsException e) {
                    throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
                }
            }
            throw new ResultException(ResultCode.REQUIRED_VALUES_MISSING);
        }
        throw new ResultException(ResultCode.REQUIRED_VALUES_MISSING);
    }

    private boolean processRefresh(CommandDetails cmdDet, List<ComprehensionTlv> list) {
        CatLog.m0d((Object) this, "process Refresh");
        switch (cmdDet.commandQualifier) {
            case REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE /*0*/:
            case REFRESH_NAA_INIT_AND_FILE_CHANGE /*2*/:
            case REFRESH_NAA_INIT /*3*/:
            case REFRESH_UICC_RESET /*4*/:
                this.mCmdParams = new DisplayTextParams(cmdDet, null);
                break;
        }
        return false;
    }

    private boolean processSelectItem(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process SelectItem");
        Menu menu = new Menu();
        IconId titleIconId = null;
        ItemsIconId itemsIconId = null;
        Iterator<ComprehensionTlv> iter = ctlvs.iterator();
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.ALPHA_ID, ctlvs);
        if (ctlv != null) {
            menu.title = ValueParser.retrieveAlphaId(ctlv);
        }
        while (true) {
            ctlv = searchForNextTag(ComprehensionTlvTag.ITEM, iter);
            if (ctlv == null) {
                break;
            }
            menu.items.add(ValueParser.retrieveItem(ctlv));
        }
        if (menu.items.size() == 0) {
            throw new ResultException(ResultCode.REQUIRED_VALUES_MISSING);
        }
        boolean presentTypeSpecified;
        boolean z;
        ctlv = searchForTag(ComprehensionTlvTag.ITEM_ID, ctlvs);
        if (ctlv != null) {
            menu.defaultItem = ValueParser.retrieveItemId(ctlv) - 1;
        }
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
            titleIconId = ValueParser.retrieveIconId(ctlv);
            menu.titleIconSelfExplanatory = titleIconId.selfExplanatory;
        }
        ctlv = searchForTag(ComprehensionTlvTag.ITEM_ICON_ID_LIST, ctlvs);
        if (ctlv != null) {
            this.mIconLoadState = REFRESH_NAA_INIT_AND_FILE_CHANGE;
            itemsIconId = ValueParser.retrieveItemsIconId(ctlv);
            menu.itemsIconSelfExplanatory = itemsIconId.selfExplanatory;
        }
        if ((cmdDet.commandQualifier & MSG_ID_LOAD_ICON_DONE) != 0) {
            presentTypeSpecified = true;
        } else {
            presentTypeSpecified = false;
        }
        if (presentTypeSpecified) {
            if ((cmdDet.commandQualifier & REFRESH_NAA_INIT_AND_FILE_CHANGE) == 0) {
                menu.presentationType = PresentationType.DATA_VALUES;
            } else {
                menu.presentationType = PresentationType.NAVIGATION_OPTIONS;
            }
        }
        if ((cmdDet.commandQualifier & REFRESH_UICC_RESET) != 0) {
            z = true;
        } else {
            z = false;
        }
        menu.softKeyPreferred = z;
        if ((cmdDet.commandQualifier & PduPart.P_Q) != 0) {
            z = true;
        } else {
            z = false;
        }
        menu.helpAvailable = z;
        if (titleIconId != null) {
            z = true;
        } else {
            z = false;
        }
        this.mCmdParams = new SelectItemParams(cmdDet, menu, z);
        switch (this.mIconLoadState) {
            case REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE /*0*/:
                return false;
            case MSG_ID_LOAD_ICON_DONE /*1*/:
                this.mIconLoader.loadIcon(titleIconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
                break;
            case REFRESH_NAA_INIT_AND_FILE_CHANGE /*2*/:
                int[] recordNumbers = itemsIconId.recordNumbers;
                if (titleIconId != null) {
                    recordNumbers = new int[(itemsIconId.recordNumbers.length + MSG_ID_LOAD_ICON_DONE)];
                    recordNumbers[REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE] = titleIconId.recordNumber;
                    System.arraycopy(itemsIconId.recordNumbers, REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE, recordNumbers, MSG_ID_LOAD_ICON_DONE, itemsIconId.recordNumbers.length);
                }
                this.mIconLoader.loadIcons(recordNumbers, obtainMessage(MSG_ID_LOAD_ICON_DONE));
                break;
        }
        return true;
    }

    private boolean processEventNotify(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process EventNotify");
        TextMessage textMsg = new TextMessage();
        IconId iconId = null;
        textMsg.text = ValueParser.retrieveAlphaId(searchForTag(ComprehensionTlvTag.ALPHA_ID, ctlvs));
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            iconId = ValueParser.retrieveIconId(ctlv);
            textMsg.iconSelfExplanatory = iconId.selfExplanatory;
        }
        textMsg.responseNeeded = false;
        this.mCmdParams = new DisplayTextParams(cmdDet, textMsg);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processSetUpEventList(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) {
        CatLog.m0d((Object) this, "process SetUpEventList");
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.EVENT_LIST, ctlvs);
        if (ctlv != null) {
            try {
                byte[] rawValue = ctlv.getRawValue();
                int valueIndex = ctlv.getValueIndex();
                int valueLen = ctlv.getLength();
                int[] eventList = new int[valueLen];
                int i = REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE;
                while (valueLen > 0) {
                    int eventValue = rawValue[valueIndex] & PduHeaders.STORE_STATUS_ERROR_END;
                    valueIndex += MSG_ID_LOAD_ICON_DONE;
                    valueLen--;
                    switch (eventValue) {
                        case REFRESH_UICC_RESET /*4*/:
                        case CharacterSets.ISO_8859_2 /*5*/:
                        case CharacterSets.ISO_8859_4 /*7*/:
                        case CharacterSets.ISO_8859_5 /*8*/:
                        case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
                            eventList[i] = eventValue;
                            i += MSG_ID_LOAD_ICON_DONE;
                            break;
                        default:
                            break;
                    }
                }
                this.mCmdParams = new SetEventListParams(cmdDet, eventList);
            } catch (IndexOutOfBoundsException e) {
                CatLog.m2e((Object) this, " IndexOutofBoundException in processSetUpEventList");
            }
        }
        return false;
    }

    private boolean processLaunchBrowser(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        LaunchBrowserMode mode;
        CatLog.m0d((Object) this, "process LaunchBrowser");
        TextMessage confirmMsg = new TextMessage();
        IconId iconId = null;
        String url = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.URL, ctlvs);
        if (ctlv != null) {
            try {
                byte[] rawValue = ctlv.getRawValue();
                int valueIndex = ctlv.getValueIndex();
                int valueLen = ctlv.getLength();
                if (valueLen > 0) {
                    url = GsmAlphabet.gsm8BitUnpackedToString(rawValue, valueIndex, valueLen);
                } else {
                    url = null;
                }
            } catch (IndexOutOfBoundsException e) {
                throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
            }
        }
        confirmMsg.text = ValueParser.retrieveAlphaId(searchForTag(ComprehensionTlvTag.ALPHA_ID, ctlvs));
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            iconId = ValueParser.retrieveIconId(ctlv);
            confirmMsg.iconSelfExplanatory = iconId.selfExplanatory;
        }
        switch (cmdDet.commandQualifier) {
            case REFRESH_NAA_INIT_AND_FILE_CHANGE /*2*/:
                mode = LaunchBrowserMode.USE_EXISTING_BROWSER;
                break;
            case REFRESH_NAA_INIT /*3*/:
                mode = LaunchBrowserMode.LAUNCH_NEW_BROWSER;
                break;
            default:
                mode = LaunchBrowserMode.LAUNCH_IF_NOT_ALREADY_LAUNCHED;
                break;
        }
        this.mCmdParams = new LaunchBrowserParams(cmdDet, confirmMsg, url, mode);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processPlayTone(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CatLog.m0d((Object) this, "process PlayTone");
        Tone tone = null;
        TextMessage textMsg = new TextMessage();
        Duration duration = null;
        IconId iconId = null;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.TONE, ctlvs);
        if (ctlv != null && ctlv.getLength() > 0) {
            try {
                tone = Tone.fromInt(ctlv.getRawValue()[ctlv.getValueIndex()]);
            } catch (IndexOutOfBoundsException e) {
                throw new ResultException(ResultCode.CMD_DATA_NOT_UNDERSTOOD);
            }
        }
        ctlv = searchForTag(ComprehensionTlvTag.ALPHA_ID, ctlvs);
        if (ctlv != null) {
            textMsg.text = ValueParser.retrieveAlphaId(ctlv);
        }
        ctlv = searchForTag(ComprehensionTlvTag.DURATION, ctlvs);
        if (ctlv != null) {
            duration = ValueParser.retrieveDuration(ctlv);
        }
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            iconId = ValueParser.retrieveIconId(ctlv);
            textMsg.iconSelfExplanatory = iconId.selfExplanatory;
        }
        boolean vibrate = (cmdDet.commandQualifier & MSG_ID_LOAD_ICON_DONE) != 0;
        textMsg.responseNeeded = false;
        this.mCmdParams = new PlayToneParams(cmdDet, textMsg, tone, duration, vibrate);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processSetupCall(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        int i = -1;
        CatLog.m0d((Object) this, "process SetupCall");
        Iterator<ComprehensionTlv> iter = ctlvs.iterator();
        TextMessage confirmMsg = new TextMessage();
        TextMessage callMsg = new TextMessage();
        IconId confirmIconId = null;
        IconId callIconId = null;
        confirmMsg.text = ValueParser.retrieveAlphaId(searchForNextTag(ComprehensionTlvTag.ALPHA_ID, iter));
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            confirmIconId = ValueParser.retrieveIconId(ctlv);
            confirmMsg.iconSelfExplanatory = confirmIconId.selfExplanatory;
        }
        ctlv = searchForNextTag(ComprehensionTlvTag.ALPHA_ID, iter);
        if (ctlv != null) {
            callMsg.text = ValueParser.retrieveAlphaId(ctlv);
        }
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            callIconId = ValueParser.retrieveIconId(ctlv);
            callMsg.iconSelfExplanatory = callIconId.selfExplanatory;
        }
        this.mCmdParams = new CallSetupParams(cmdDet, confirmMsg, callMsg);
        if (confirmIconId == null && callIconId == null) {
            return false;
        }
        int i2;
        this.mIconLoadState = REFRESH_NAA_INIT_AND_FILE_CHANGE;
        int[] recordNumbers = new int[REFRESH_NAA_INIT_AND_FILE_CHANGE];
        if (confirmIconId != null) {
            i2 = confirmIconId.recordNumber;
        } else {
            i2 = -1;
        }
        recordNumbers[REFRESH_NAA_INIT_AND_FULL_FILE_CHANGE] = i2;
        if (callIconId != null) {
            i = callIconId.recordNumber;
        }
        recordNumbers[MSG_ID_LOAD_ICON_DONE] = i;
        this.mIconLoader.loadIcons(recordNumbers, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    private boolean processProvideLocalInfo(CommandDetails cmdDet, List<ComprehensionTlv> list) throws ResultException {
        CatLog.m0d((Object) this, "process ProvideLocalInfo");
        switch (cmdDet.commandQualifier) {
            case REFRESH_NAA_INIT /*3*/:
                CatLog.m0d((Object) this, "PLI [DTTZ_SETTING]");
                this.mCmdParams = new CommandParams(cmdDet);
                break;
            case REFRESH_UICC_RESET /*4*/:
                CatLog.m0d((Object) this, "PLI [LANGUAGE_SETTING]");
                this.mCmdParams = new CommandParams(cmdDet);
                break;
            default:
                CatLog.m0d((Object) this, "PLI[" + cmdDet.commandQualifier + "] Command Not Supported");
                this.mCmdParams = new CommandParams(cmdDet);
                throw new ResultException(ResultCode.BEYOND_TERMINAL_CAPABILITY);
        }
        return false;
    }

    private boolean processBIPClient(CommandDetails cmdDet, List<ComprehensionTlv> ctlvs) throws ResultException {
        CommandType commandType = CommandType.fromInt(cmdDet.typeOfCommand);
        if (commandType != null) {
            CatLog.m0d((Object) this, "process " + commandType.name());
        }
        TextMessage textMsg = new TextMessage();
        IconId iconId = null;
        boolean has_alpha_id = false;
        ComprehensionTlv ctlv = searchForTag(ComprehensionTlvTag.ALPHA_ID, ctlvs);
        if (ctlv != null) {
            textMsg.text = ValueParser.retrieveAlphaId(ctlv);
            CatLog.m0d((Object) this, "alpha TLV text=" + textMsg.text);
            has_alpha_id = true;
        }
        ctlv = searchForTag(ComprehensionTlvTag.ICON_ID, ctlvs);
        if (ctlv != null) {
            iconId = ValueParser.retrieveIconId(ctlv);
            textMsg.iconSelfExplanatory = iconId.selfExplanatory;
        }
        textMsg.responseNeeded = false;
        this.mCmdParams = new BIPClientParams(cmdDet, textMsg, has_alpha_id);
        if (iconId == null) {
            return false;
        }
        this.mIconLoadState = MSG_ID_LOAD_ICON_DONE;
        this.mIconLoader.loadIcon(iconId.recordNumber, obtainMessage(MSG_ID_LOAD_ICON_DONE));
        return true;
    }

    public void dispose() {
        this.mIconLoader.dispose();
        this.mIconLoader = null;
        this.mCmdParams = null;
        this.mCaller = null;
        sInstance = null;
    }
}
