package com.android.internal.telephony.cdma.sms;

import android.util.SparseIntArray;
import com.android.internal.telephony.SmsHeader;
import com.android.internal.util.HexDump;

public class UserData {
    public static final int ASCII_CR_INDEX = 13;
    public static final char[] ASCII_MAP;
    public static final int ASCII_MAP_BASE_INDEX = 32;
    public static final int ASCII_MAP_MAX_INDEX;
    public static final int ASCII_NL_INDEX = 10;
    public static final int ENCODING_7BIT_ASCII = 2;
    public static final int ENCODING_GSM_7BIT_ALPHABET = 9;
    public static final int ENCODING_GSM_DCS = 10;
    public static final int ENCODING_IA5 = 3;
    public static final int ENCODING_IS91_EXTENDED_PROTOCOL = 1;
    public static final int ENCODING_KOREAN = 6;
    public static final int ENCODING_LATIN = 8;
    public static final int ENCODING_LATIN_HEBREW = 7;
    public static final int ENCODING_OCTET = 0;
    public static final int ENCODING_SHIFT_JIS = 5;
    public static final int ENCODING_UNICODE_16 = 4;
    public static final int IS91_MSG_TYPE_CLI = 132;
    public static final int IS91_MSG_TYPE_SHORT_MESSAGE = 133;
    public static final int IS91_MSG_TYPE_SHORT_MESSAGE_FULL = 131;
    public static final int IS91_MSG_TYPE_VOICEMAIL_STATUS = 130;
    public static final int PRINTABLE_ASCII_MIN_INDEX = 32;
    static final byte UNENCODABLE_7_BIT_CHAR = (byte) 32;
    public static final SparseIntArray charToAscii;
    public int msgEncoding;
    public boolean msgEncodingSet;
    public int msgType;
    public int numFields;
    public int paddingBits;
    public byte[] payload;
    public String payloadStr;
    public SmsHeader userDataHeader;

    public UserData() {
        this.msgEncodingSet = false;
    }

    static {
        ASCII_MAP = new char[]{' ', '!', '\"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~'};
        charToAscii = new SparseIntArray();
        for (int i = ENCODING_OCTET; i < ASCII_MAP.length; i += ENCODING_IS91_EXTENDED_PROTOCOL) {
            charToAscii.put(ASCII_MAP[i], i + PRINTABLE_ASCII_MIN_INDEX);
        }
        charToAscii.put(ENCODING_GSM_DCS, ENCODING_GSM_DCS);
        charToAscii.put(ASCII_CR_INDEX, ASCII_CR_INDEX);
        ASCII_MAP_MAX_INDEX = (ASCII_MAP.length + PRINTABLE_ASCII_MIN_INDEX) - 1;
    }

    public static byte[] stringToAscii(String str) {
        int len = str.length();
        byte[] result = new byte[len];
        for (int i = ENCODING_OCTET; i < len; i += ENCODING_IS91_EXTENDED_PROTOCOL) {
            int charCode = charToAscii.get(str.charAt(i), -1);
            if (charCode == -1) {
                return null;
            }
            result[i] = (byte) charCode;
        }
        return result;
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("UserData ");
        builder.append("{ msgEncoding=" + (this.msgEncodingSet ? Integer.valueOf(this.msgEncoding) : "unset"));
        builder.append(", msgType=" + this.msgType);
        builder.append(", paddingBits=" + this.paddingBits);
        builder.append(", numFields=" + this.numFields);
        builder.append(", userDataHeader=" + this.userDataHeader);
        builder.append(", payload='" + HexDump.toHexString(this.payload) + "'");
        builder.append(", payloadStr='" + this.payloadStr + "'");
        builder.append(" }");
        return builder.toString();
    }
}
