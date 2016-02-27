package com.android.server.hdmi;

import java.util.Arrays;
import libcore.util.EmptyArray;

final class HdmiCecKeycode {
    public static final int CEC_KEYCODE_ANGLE = 80;
    public static final int CEC_KEYCODE_BACKWARD = 76;
    public static final int CEC_KEYCODE_CHANNEL_DOWN = 49;
    public static final int CEC_KEYCODE_CHANNEL_UP = 48;
    public static final int CEC_KEYCODE_CLEAR = 44;
    public static final int CEC_KEYCODE_CONTENTS_MENU = 11;
    public static final int CEC_KEYCODE_DATA = 118;
    public static final int CEC_KEYCODE_DISPLAY_INFORMATION = 53;
    public static final int CEC_KEYCODE_DOT = 42;
    public static final int CEC_KEYCODE_DOWN = 2;
    public static final int CEC_KEYCODE_EJECT = 74;
    public static final int CEC_KEYCODE_ELECTRONIC_PROGRAM_GUIDE = 83;
    public static final int CEC_KEYCODE_ENTER = 43;
    public static final int CEC_KEYCODE_EXIT = 13;
    public static final int CEC_KEYCODE_F1_BLUE = 113;
    public static final int CEC_KEYCODE_F2_RED = 114;
    public static final int CEC_KEYCODE_F3_GREEN = 115;
    public static final int CEC_KEYCODE_F4_YELLOW = 116;
    public static final int CEC_KEYCODE_F5 = 117;
    public static final int CEC_KEYCODE_FAST_FORWARD = 73;
    public static final int CEC_KEYCODE_FAVORITE_MENU = 12;
    public static final int CEC_KEYCODE_FORWARD = 75;
    public static final int CEC_KEYCODE_HELP = 54;
    public static final int CEC_KEYCODE_INITIAL_CONFIGURATION = 85;
    public static final int CEC_KEYCODE_INPUT_SELECT = 52;
    public static final int CEC_KEYCODE_LEFT = 3;
    public static final int CEC_KEYCODE_LEFT_DOWN = 8;
    public static final int CEC_KEYCODE_LEFT_UP = 7;
    public static final int CEC_KEYCODE_MEDIA_CONTEXT_SENSITIVE_MENU = 17;
    public static final int CEC_KEYCODE_MEDIA_TOP_MENU = 16;
    public static final int CEC_KEYCODE_MUTE = 67;
    public static final int CEC_KEYCODE_MUTE_FUNCTION = 101;
    public static final int CEC_KEYCODE_NEXT_FAVORITE = 47;
    public static final int CEC_KEYCODE_NUMBERS_1 = 33;
    public static final int CEC_KEYCODE_NUMBERS_2 = 34;
    public static final int CEC_KEYCODE_NUMBERS_3 = 35;
    public static final int CEC_KEYCODE_NUMBERS_4 = 36;
    public static final int CEC_KEYCODE_NUMBERS_5 = 37;
    public static final int CEC_KEYCODE_NUMBERS_6 = 38;
    public static final int CEC_KEYCODE_NUMBERS_7 = 39;
    public static final int CEC_KEYCODE_NUMBERS_8 = 40;
    public static final int CEC_KEYCODE_NUMBERS_9 = 41;
    public static final int CEC_KEYCODE_NUMBER_0_OR_NUMBER_10 = 32;
    public static final int CEC_KEYCODE_NUMBER_11 = 30;
    public static final int CEC_KEYCODE_NUMBER_12 = 31;
    public static final int CEC_KEYCODE_NUMBER_ENTRY_MODE = 29;
    public static final int CEC_KEYCODE_PAGE_DOWN = 56;
    public static final int CEC_KEYCODE_PAGE_UP = 55;
    public static final int CEC_KEYCODE_PAUSE = 70;
    public static final int CEC_KEYCODE_PAUSE_PLAY_FUNCTION = 97;
    public static final int CEC_KEYCODE_PAUSE_RECORD = 78;
    public static final int CEC_KEYCODE_PAUSE_RECORD_FUNCTION = 99;
    public static final int CEC_KEYCODE_PLAY = 68;
    public static final int CEC_KEYCODE_PLAY_FUNCTION = 96;
    public static final int CEC_KEYCODE_POWER = 64;
    public static final int CEC_KEYCODE_POWER_OFF_FUNCTION = 108;
    public static final int CEC_KEYCODE_POWER_ON_FUNCTION = 109;
    public static final int CEC_KEYCODE_POWER_TOGGLE_FUNCTION = 107;
    public static final int CEC_KEYCODE_PREVIOUS_CHANNEL = 50;
    public static final int CEC_KEYCODE_RECORD = 71;
    public static final int CEC_KEYCODE_RECORD_FUNCTION = 98;
    public static final int CEC_KEYCODE_RESERVED = 79;
    public static final int CEC_KEYCODE_RESTORE_VOLUME_FUNCTION = 102;
    public static final int CEC_KEYCODE_REWIND = 72;
    public static final int CEC_KEYCODE_RIGHT = 4;
    public static final int CEC_KEYCODE_RIGHT_DOWN = 6;
    public static final int CEC_KEYCODE_RIGHT_UP = 5;
    public static final int CEC_KEYCODE_ROOT_MENU = 9;
    public static final int CEC_KEYCODE_SELECT = 0;
    public static final int CEC_KEYCODE_SELECT_AUDIO_INPUT_FUNCTION = 106;
    public static final int CEC_KEYCODE_SELECT_AV_INPUT_FUNCTION = 105;
    public static final int CEC_KEYCODE_SELECT_BROADCAST_TYPE = 86;
    public static final int CEC_KEYCODE_SELECT_MEDIA_FUNCTION = 104;
    public static final int CEC_KEYCODE_SELECT_SOUND_PRESENTATION = 87;
    public static final int CEC_KEYCODE_SETUP_MENU = 10;
    public static final int CEC_KEYCODE_SOUND_SELECT = 51;
    public static final int CEC_KEYCODE_STOP = 69;
    public static final int CEC_KEYCODE_STOP_FUNCTION = 100;
    public static final int CEC_KEYCODE_STOP_RECORD = 77;
    public static final int CEC_KEYCODE_SUB_PICTURE = 81;
    public static final int CEC_KEYCODE_TIMER_PROGRAMMING = 84;
    public static final int CEC_KEYCODE_TUNE_FUNCTION = 103;
    public static final int CEC_KEYCODE_UP = 1;
    public static final int CEC_KEYCODE_VIDEO_ON_DEMAND = 82;
    public static final int CEC_KEYCODE_VOLUME_DOWN = 66;
    public static final int CEC_KEYCODE_VOLUME_UP = 65;
    private static final KeycodeEntry[] KEYCODE_ENTRIES;
    public static final int NO_PARAM = -1;
    public static final int UI_BROADCAST_ANALOGUE = 16;
    public static final int UI_BROADCAST_ANALOGUE_CABLE = 48;
    public static final int UI_BROADCAST_ANALOGUE_SATELLITE = 64;
    public static final int UI_BROADCAST_ANALOGUE_TERRESTRIAL = 32;
    public static final int UI_BROADCAST_DIGITAL = 80;
    public static final int UI_BROADCAST_DIGITAL_CABLE = 112;
    public static final int UI_BROADCAST_DIGITAL_COMMNICATIONS_SATELLITE = 144;
    public static final int UI_BROADCAST_DIGITAL_COMMNICATIONS_SATELLITE_2 = 145;
    public static final int UI_BROADCAST_DIGITAL_SATELLITE = 128;
    public static final int UI_BROADCAST_DIGITAL_TERRESTRIAL = 96;
    public static final int UI_BROADCAST_IP = 160;
    public static final int UI_BROADCAST_TOGGLE_ALL = 0;
    public static final int UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL = 1;
    public static final int UI_SOUND_PRESENTATION_BASS_NEUTRAL = 178;
    public static final int UI_SOUND_PRESENTATION_BASS_STEP_MINUS = 179;
    public static final int UI_SOUND_PRESENTATION_BASS_STEP_PLUS = 177;
    public static final int UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_EQUALIZER = 160;
    public static final int UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_REVERBERATION = 144;
    public static final int UI_SOUND_PRESENTATION_SELECT_AUDIO_DOWN_MIX = 128;
    public static final int UI_SOUND_PRESENTATION_SOUND_MIX_DUAL_MONO = 32;
    public static final int UI_SOUND_PRESENTATION_SOUND_MIX_KARAOKE = 48;
    public static final int UI_SOUND_PRESENTATION_TREBLE_NEUTRAL = 194;
    public static final int UI_SOUND_PRESENTATION_TREBLE_STEP_MINUS = 195;
    public static final int UI_SOUND_PRESENTATION_TREBLE_STEP_PLUS = 193;
    public static final int UNSUPPORTED_KEYCODE = -1;

    private static class KeycodeEntry {
        private final int mAndroidKeycode;
        private final byte[] mCecKeycodeAndParams;
        private final boolean mIsRepeatable;

        private KeycodeEntry(int androidKeycode, int cecKeycode, boolean isRepeatable, byte[] cecParams) {
            this.mAndroidKeycode = androidKeycode;
            this.mIsRepeatable = isRepeatable;
            this.mCecKeycodeAndParams = new byte[(cecParams.length + HdmiCecKeycode.UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL)];
            System.arraycopy(cecParams, HdmiCecKeycode.UI_BROADCAST_TOGGLE_ALL, this.mCecKeycodeAndParams, HdmiCecKeycode.UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL, cecParams.length);
            this.mCecKeycodeAndParams[HdmiCecKeycode.UI_BROADCAST_TOGGLE_ALL] = (byte) (cecKeycode & 255);
        }

        private KeycodeEntry(int androidKeycode, int cecKeycode, boolean isRepeatable) {
            this(androidKeycode, cecKeycode, isRepeatable, EmptyArray.BYTE);
        }

        private KeycodeEntry(int androidKeycode, int cecKeycode, byte[] cecParams) {
            this(androidKeycode, cecKeycode, true, cecParams);
        }

        private KeycodeEntry(int androidKeycode, int cecKeycode) {
            this(androidKeycode, cecKeycode, true, EmptyArray.BYTE);
        }

        private byte[] toCecKeycodeAndParamIfMatched(int androidKeycode) {
            if (this.mAndroidKeycode == androidKeycode) {
                return this.mCecKeycodeAndParams;
            }
            return null;
        }

        private int toAndroidKeycodeIfMatched(byte[] cecKeycodeAndParams) {
            if (Arrays.equals(this.mCecKeycodeAndParams, cecKeycodeAndParams)) {
                return this.mAndroidKeycode;
            }
            return HdmiCecKeycode.UNSUPPORTED_KEYCODE;
        }

        private Boolean isRepeatableIfMatched(int androidKeycode) {
            if (this.mAndroidKeycode == androidKeycode) {
                return Boolean.valueOf(this.mIsRepeatable);
            }
            return null;
        }
    }

    private HdmiCecKeycode() {
    }

    private static byte[] intToSingleByteArray(int value) {
        byte[] bArr = new byte[UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL];
        bArr[UI_BROADCAST_TOGGLE_ALL] = (byte) (value & 255);
        return bArr;
    }

    static {
        KEYCODE_ENTRIES = new KeycodeEntry[]{new KeycodeEntry((int) UI_BROADCAST_TOGGLE_ALL, null), new KeycodeEntry((int) UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL, null), new KeycodeEntry((int) CEC_KEYCODE_DOWN, null), new KeycodeEntry((int) CEC_KEYCODE_LEFT, null), new KeycodeEntry((int) CEC_KEYCODE_RIGHT, null), new KeycodeEntry((int) CEC_KEYCODE_RIGHT_UP, null), new KeycodeEntry((int) CEC_KEYCODE_RIGHT_DOWN, null), new KeycodeEntry((int) CEC_KEYCODE_LEFT_UP, null), new KeycodeEntry((int) CEC_KEYCODE_LEFT_DOWN, null), new KeycodeEntry((int) CEC_KEYCODE_ROOT_MENU, null), new KeycodeEntry((int) CEC_KEYCODE_SETUP_MENU, null), new KeycodeEntry((int) CEC_KEYCODE_CONTENTS_MENU, false, null), new KeycodeEntry((int) CEC_KEYCODE_FAVORITE_MENU, null), new KeycodeEntry((int) CEC_KEYCODE_EXIT, null), new KeycodeEntry((int) CEC_KEYCODE_EXIT, null), new KeycodeEntry((int) UI_BROADCAST_ANALOGUE, null), new KeycodeEntry((int) CEC_KEYCODE_MEDIA_CONTEXT_SENSITIVE_MENU, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBER_ENTRY_MODE, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBER_11, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBER_12, null), new KeycodeEntry((int) UI_SOUND_PRESENTATION_SOUND_MIX_DUAL_MONO, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_1, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_2, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_3, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_4, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_5, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_6, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_7, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_8, null), new KeycodeEntry((int) CEC_KEYCODE_NUMBERS_9, null), new KeycodeEntry((int) CEC_KEYCODE_DOT, null), new KeycodeEntry((int) CEC_KEYCODE_ENTER, null), new KeycodeEntry((int) CEC_KEYCODE_CLEAR, null), new KeycodeEntry((int) CEC_KEYCODE_NEXT_FAVORITE, null), new KeycodeEntry((int) UI_SOUND_PRESENTATION_SOUND_MIX_KARAOKE, null), new KeycodeEntry((int) CEC_KEYCODE_CHANNEL_DOWN, null), new KeycodeEntry((int) CEC_KEYCODE_PREVIOUS_CHANNEL, null), new KeycodeEntry((int) CEC_KEYCODE_SOUND_SELECT, null), new KeycodeEntry((int) CEC_KEYCODE_INPUT_SELECT, null), new KeycodeEntry((int) CEC_KEYCODE_DISPLAY_INFORMATION, null), new KeycodeEntry((int) CEC_KEYCODE_HELP, null), new KeycodeEntry((int) CEC_KEYCODE_PAGE_UP, null), new KeycodeEntry((int) CEC_KEYCODE_PAGE_DOWN, null), new KeycodeEntry((int) UI_BROADCAST_ANALOGUE_SATELLITE, false, null), new KeycodeEntry((int) CEC_KEYCODE_VOLUME_UP, null), new KeycodeEntry((int) CEC_KEYCODE_VOLUME_DOWN, null), new KeycodeEntry((int) CEC_KEYCODE_MUTE, false, null), new KeycodeEntry((int) CEC_KEYCODE_PLAY, null), new KeycodeEntry((int) CEC_KEYCODE_STOP, null), new KeycodeEntry((int) CEC_KEYCODE_PAUSE, null), new KeycodeEntry((int) CEC_KEYCODE_PAUSE, null), new KeycodeEntry((int) CEC_KEYCODE_RECORD, null), new KeycodeEntry((int) CEC_KEYCODE_REWIND, null), new KeycodeEntry((int) CEC_KEYCODE_FAST_FORWARD, null), new KeycodeEntry((int) CEC_KEYCODE_EJECT, null), new KeycodeEntry((int) CEC_KEYCODE_FORWARD, null), new KeycodeEntry((int) CEC_KEYCODE_BACKWARD, null), new KeycodeEntry((int) CEC_KEYCODE_STOP_RECORD, null), new KeycodeEntry((int) CEC_KEYCODE_PAUSE_RECORD, null), new KeycodeEntry((int) CEC_KEYCODE_RESERVED, null), new KeycodeEntry((int) UI_BROADCAST_DIGITAL, null), new KeycodeEntry((int) CEC_KEYCODE_SUB_PICTURE, null), new KeycodeEntry((int) CEC_KEYCODE_VIDEO_ON_DEMAND, null), new KeycodeEntry((int) CEC_KEYCODE_ELECTRONIC_PROGRAM_GUIDE, null), new KeycodeEntry((int) CEC_KEYCODE_TIMER_PROGRAMMING, null), new KeycodeEntry((int) CEC_KEYCODE_INITIAL_CONFIGURATION, null), new KeycodeEntry((int) CEC_KEYCODE_SELECT_BROADCAST_TYPE, null), new KeycodeEntry(CEC_KEYCODE_SELECT_BROADCAST_TYPE, true, intToSingleByteArray(UI_BROADCAST_ANALOGUE), null), new KeycodeEntry(CEC_KEYCODE_SELECT_BROADCAST_TYPE, true, intToSingleByteArray(UI_BROADCAST_DIGITAL_TERRESTRIAL), null), new KeycodeEntry(CEC_KEYCODE_SELECT_BROADCAST_TYPE, true, intToSingleByteArray(UI_SOUND_PRESENTATION_SELECT_AUDIO_DOWN_MIX), null), new KeycodeEntry(CEC_KEYCODE_SELECT_BROADCAST_TYPE, true, intToSingleByteArray(UI_SOUND_PRESENTATION_SELECT_AUDIO_AUTO_REVERBERATION), null), new KeycodeEntry(CEC_KEYCODE_SELECT_BROADCAST_TYPE, true, intToSingleByteArray(UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL), null), new KeycodeEntry((int) CEC_KEYCODE_SELECT_SOUND_PRESENTATION, null), new KeycodeEntry((int) UI_BROADCAST_DIGITAL_TERRESTRIAL, false, null), new KeycodeEntry((int) CEC_KEYCODE_PAUSE_PLAY_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_RECORD_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_PAUSE_RECORD_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_STOP_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_MUTE_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_RESTORE_VOLUME_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_TUNE_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_SELECT_MEDIA_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_SELECT_AV_INPUT_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_SELECT_AUDIO_INPUT_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_POWER_TOGGLE_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_POWER_OFF_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_POWER_ON_FUNCTION, false, null), new KeycodeEntry((int) CEC_KEYCODE_F1_BLUE, null), new KeycodeEntry((int) CEC_KEYCODE_F2_RED, null), new KeycodeEntry((int) CEC_KEYCODE_F3_GREEN, null), new KeycodeEntry((int) CEC_KEYCODE_F4_YELLOW, null), new KeycodeEntry((int) CEC_KEYCODE_F5, null), new KeycodeEntry((int) CEC_KEYCODE_DATA, null)};
    }

    static byte[] androidKeyToCecKey(int keycode) {
        for (int i = UI_BROADCAST_TOGGLE_ALL; i < KEYCODE_ENTRIES.length; i += UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL) {
            byte[] cecKeycodeAndParams = KEYCODE_ENTRIES[i].toCecKeycodeAndParamIfMatched(keycode);
            if (cecKeycodeAndParams != null) {
                return cecKeycodeAndParams;
            }
        }
        return null;
    }

    static int cecKeycodeAndParamsToAndroidKey(byte[] cecKeycodeAndParams) {
        for (int i = UI_BROADCAST_TOGGLE_ALL; i < KEYCODE_ENTRIES.length; i += UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL) {
            int androidKey = KEYCODE_ENTRIES[i].toAndroidKeycodeIfMatched(cecKeycodeAndParams);
            if (androidKey != UNSUPPORTED_KEYCODE) {
                return androidKey;
            }
        }
        return UNSUPPORTED_KEYCODE;
    }

    static boolean isRepeatableKey(int androidKeycode) {
        for (int i = UI_BROADCAST_TOGGLE_ALL; i < KEYCODE_ENTRIES.length; i += UI_BROADCAST_TOGGLE_ANALOGUE_DIGITAL) {
            Boolean isRepeatable = KEYCODE_ENTRIES[i].isRepeatableIfMatched(androidKeycode);
            if (isRepeatable != null) {
                return isRepeatable.booleanValue();
            }
        }
        return false;
    }

    static boolean isSupportedKeycode(int androidKeycode) {
        return androidKeyToCecKey(androidKeycode) != null;
    }
}
