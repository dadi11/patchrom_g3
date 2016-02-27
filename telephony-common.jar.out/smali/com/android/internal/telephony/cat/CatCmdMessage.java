package com.android.internal.telephony.cat;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.telephony.cat.AppInterface.CommandType;
import com.android.internal.telephony.cdma.SignalToneUtil;
import com.android.internal.telephony.cdma.sms.UserData;
import com.google.android.mms.pdu.CharacterSets;
import com.google.android.mms.pdu.PduHeaders;
import com.google.android.mms.pdu.PduPersister;

public class CatCmdMessage implements Parcelable {
    public static final Creator<CatCmdMessage> CREATOR;
    private BrowserSettings mBrowserSettings;
    private CallSettings mCallSettings;
    CommandDetails mCmdDet;
    private Input mInput;
    private Menu mMenu;
    private SetupEventListSettings mSetupEventListSettings;
    private TextMessage mTextMsg;
    private ToneSettings mToneSettings;

    /* renamed from: com.android.internal.telephony.cat.CatCmdMessage.1 */
    static class C00251 implements Creator<CatCmdMessage> {
        C00251() {
        }

        public CatCmdMessage createFromParcel(Parcel in) {
            return new CatCmdMessage(in);
        }

        public CatCmdMessage[] newArray(int size) {
            return new CatCmdMessage[size];
        }
    }

    /* renamed from: com.android.internal.telephony.cat.CatCmdMessage.2 */
    static /* synthetic */ class C00262 {
        static final /* synthetic */ int[] f3xca33cf42;

        static {
            f3xca33cf42 = new int[CommandType.values().length];
            try {
                f3xca33cf42[CommandType.SET_UP_MENU.ordinal()] = 1;
            } catch (NoSuchFieldError e) {
            }
            try {
                f3xca33cf42[CommandType.SELECT_ITEM.ordinal()] = 2;
            } catch (NoSuchFieldError e2) {
            }
            try {
                f3xca33cf42[CommandType.DISPLAY_TEXT.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                f3xca33cf42[CommandType.SET_UP_IDLE_MODE_TEXT.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                f3xca33cf42[CommandType.SEND_DTMF.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                f3xca33cf42[CommandType.SEND_SMS.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
            try {
                f3xca33cf42[CommandType.SEND_SS.ordinal()] = 7;
            } catch (NoSuchFieldError e7) {
            }
            try {
                f3xca33cf42[CommandType.SEND_USSD.ordinal()] = 8;
            } catch (NoSuchFieldError e8) {
            }
            try {
                f3xca33cf42[CommandType.GET_INPUT.ordinal()] = 9;
            } catch (NoSuchFieldError e9) {
            }
            try {
                f3xca33cf42[CommandType.GET_INKEY.ordinal()] = 10;
            } catch (NoSuchFieldError e10) {
            }
            try {
                f3xca33cf42[CommandType.LAUNCH_BROWSER.ordinal()] = 11;
            } catch (NoSuchFieldError e11) {
            }
            try {
                f3xca33cf42[CommandType.PLAY_TONE.ordinal()] = 12;
            } catch (NoSuchFieldError e12) {
            }
            try {
                f3xca33cf42[CommandType.GET_CHANNEL_STATUS.ordinal()] = 13;
            } catch (NoSuchFieldError e13) {
            }
            try {
                f3xca33cf42[CommandType.SET_UP_CALL.ordinal()] = 14;
            } catch (NoSuchFieldError e14) {
            }
            try {
                f3xca33cf42[CommandType.OPEN_CHANNEL.ordinal()] = 15;
            } catch (NoSuchFieldError e15) {
            }
            try {
                f3xca33cf42[CommandType.CLOSE_CHANNEL.ordinal()] = 16;
            } catch (NoSuchFieldError e16) {
            }
            try {
                f3xca33cf42[CommandType.RECEIVE_DATA.ordinal()] = 17;
            } catch (NoSuchFieldError e17) {
            }
            try {
                f3xca33cf42[CommandType.SEND_DATA.ordinal()] = 18;
            } catch (NoSuchFieldError e18) {
            }
            try {
                f3xca33cf42[CommandType.SET_UP_EVENT_LIST.ordinal()] = 19;
            } catch (NoSuchFieldError e19) {
            }
            try {
                f3xca33cf42[CommandType.PROVIDE_LOCAL_INFORMATION.ordinal()] = 20;
            } catch (NoSuchFieldError e20) {
            }
            try {
                f3xca33cf42[CommandType.REFRESH.ordinal()] = 21;
            } catch (NoSuchFieldError e21) {
            }
        }
    }

    public class BrowserSettings {
        public LaunchBrowserMode mode;
        public String url;
    }

    public final class BrowserTerminationCauses {
        public static final int ERROR_TERMINATION = 1;
        public static final int USER_TERMINATION = 0;
    }

    public class CallSettings {
        public TextMessage callMsg;
        public TextMessage confirmMsg;
    }

    public final class SetupEventListConstants {
        public static final int BROWSER_TERMINATION_EVENT = 8;
        public static final int BROWSING_STATUS_EVENT = 15;
        public static final int IDLE_SCREEN_AVAILABLE_EVENT = 5;
        public static final int LANGUAGE_SELECTION_EVENT = 7;
        public static final int USER_ACTIVITY_EVENT = 4;
    }

    public class SetupEventListSettings {
        public int[] eventList;
    }

    CatCmdMessage(CommandParams cmdParams) {
        this.mBrowserSettings = null;
        this.mToneSettings = null;
        this.mCallSettings = null;
        this.mSetupEventListSettings = null;
        this.mCmdDet = cmdParams.mCmdDet;
        switch (C00262.f3xca33cf42[getCmdType().ordinal()]) {
            case PduPersister.PROC_STATUS_TRANSIENT_FAILURE /*1*/:
            case PduPersister.PROC_STATUS_PERMANENTLY_FAILURE /*2*/:
                this.mMenu = ((SelectItemParams) cmdParams).mMenu;
            case PduPersister.PROC_STATUS_COMPLETED /*3*/:
            case CharacterSets.ISO_8859_1 /*4*/:
            case CharacterSets.ISO_8859_2 /*5*/:
            case CharacterSets.ISO_8859_3 /*6*/:
            case CharacterSets.ISO_8859_4 /*7*/:
            case CharacterSets.ISO_8859_5 /*8*/:
                this.mTextMsg = ((DisplayTextParams) cmdParams).mTextMsg;
            case CharacterSets.ISO_8859_6 /*9*/:
            case CharacterSets.ISO_8859_7 /*10*/:
                this.mInput = ((GetInputParams) cmdParams).mInput;
            case CharacterSets.ISO_8859_8 /*11*/:
                this.mTextMsg = ((LaunchBrowserParams) cmdParams).mConfirmMsg;
                this.mBrowserSettings = new BrowserSettings();
                this.mBrowserSettings.url = ((LaunchBrowserParams) cmdParams).mUrl;
                this.mBrowserSettings.mode = ((LaunchBrowserParams) cmdParams).mMode;
            case CharacterSets.ISO_8859_9 /*12*/:
                PlayToneParams params = (PlayToneParams) cmdParams;
                this.mToneSettings = params.mSettings;
                this.mTextMsg = params.mTextMsg;
            case UserData.ASCII_CR_INDEX /*13*/:
                this.mTextMsg = ((CallSetupParams) cmdParams).mConfirmMsg;
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                this.mCallSettings = new CallSettings();
                this.mCallSettings.confirmMsg = ((CallSetupParams) cmdParams).mConfirmMsg;
                this.mCallSettings.callMsg = ((CallSetupParams) cmdParams).mCallMsg;
            case SignalToneUtil.IS95_CONST_IR_SIG_ISDN_OFF /*15*/:
            case PduHeaders.MMS_VERSION_1_0 /*16*/:
            case PduHeaders.MMS_VERSION_1_1 /*17*/:
            case PduHeaders.MMS_VERSION_1_2 /*18*/:
                this.mTextMsg = ((BIPClientParams) cmdParams).mTextMsg;
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                this.mSetupEventListSettings = new SetupEventListSettings();
                this.mSetupEventListSettings.eventList = ((SetEventListParams) cmdParams).mEventInfo;
            default:
        }
    }

    public CatCmdMessage(Parcel in) {
        this.mBrowserSettings = null;
        this.mToneSettings = null;
        this.mCallSettings = null;
        this.mSetupEventListSettings = null;
        this.mCmdDet = (CommandDetails) in.readParcelable(null);
        this.mTextMsg = (TextMessage) in.readParcelable(null);
        this.mMenu = (Menu) in.readParcelable(null);
        this.mInput = (Input) in.readParcelable(null);
        switch (C00262.f3xca33cf42[getCmdType().ordinal()]) {
            case CharacterSets.ISO_8859_8 /*11*/:
                this.mBrowserSettings = new BrowserSettings();
                this.mBrowserSettings.url = in.readString();
                this.mBrowserSettings.mode = LaunchBrowserMode.values()[in.readInt()];
            case CharacterSets.ISO_8859_9 /*12*/:
                this.mToneSettings = (ToneSettings) in.readParcelable(null);
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                this.mCallSettings = new CallSettings();
                this.mCallSettings.confirmMsg = (TextMessage) in.readParcelable(null);
                this.mCallSettings.callMsg = (TextMessage) in.readParcelable(null);
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                this.mSetupEventListSettings = new SetupEventListSettings();
                int length = in.readInt();
                this.mSetupEventListSettings.eventList = new int[length];
                for (int i = 0; i < length; i++) {
                    this.mSetupEventListSettings.eventList[i] = in.readInt();
                }
            default:
        }
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeParcelable(this.mCmdDet, 0);
        dest.writeParcelable(this.mTextMsg, 0);
        dest.writeParcelable(this.mMenu, 0);
        dest.writeParcelable(this.mInput, 0);
        switch (C00262.f3xca33cf42[getCmdType().ordinal()]) {
            case CharacterSets.ISO_8859_8 /*11*/:
                dest.writeString(this.mBrowserSettings.url);
                dest.writeInt(this.mBrowserSettings.mode.ordinal());
            case CharacterSets.ISO_8859_9 /*12*/:
                dest.writeParcelable(this.mToneSettings, 0);
            case SmsHeader.ELT_ID_LARGE_ANIMATION /*14*/:
                dest.writeParcelable(this.mCallSettings.confirmMsg, 0);
                dest.writeParcelable(this.mCallSettings.callMsg, 0);
            case PduHeaders.MMS_VERSION_1_3 /*19*/:
                dest.writeIntArray(this.mSetupEventListSettings.eventList);
            default:
        }
    }

    static {
        CREATOR = new C00251();
    }

    public int describeContents() {
        return 0;
    }

    public CommandType getCmdType() {
        return CommandType.fromInt(this.mCmdDet.typeOfCommand);
    }

    public Menu getMenu() {
        return this.mMenu;
    }

    public Input geInput() {
        return this.mInput;
    }

    public TextMessage geTextMessage() {
        return this.mTextMsg;
    }

    public BrowserSettings getBrowserSettings() {
        return this.mBrowserSettings;
    }

    public ToneSettings getToneSettings() {
        return this.mToneSettings;
    }

    public CallSettings getCallSettings() {
        return this.mCallSettings;
    }

    public SetupEventListSettings getSetEventList() {
        return this.mSetupEventListSettings;
    }
}
