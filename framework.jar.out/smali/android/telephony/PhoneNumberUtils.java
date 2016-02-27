package android.telephony;

import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.location.CountryDetector;
import android.net.ProxyInfo;
import android.net.Uri;
import android.net.wifi.WifiEnterpriseConfig;
import android.os.SystemProperties;
import android.telecom.PhoneAccount;
import android.text.Editable;
import android.text.Spannable;
import android.text.Spannable.Factory;
import android.text.SpannableStringBuilder;
import android.text.TextUtils;
import android.text.format.DateFormat;
import android.text.style.TtsSpan.TelephoneBuilder;
import android.util.SparseIntArray;
import android.view.KeyEvent;
import android.view.WindowManager.LayoutParams;
import android.widget.SpellChecker;
import com.android.i18n.phonenumbers.NumberParseException;
import com.android.i18n.phonenumbers.PhoneNumberUtil;
import com.android.i18n.phonenumbers.PhoneNumberUtil.PhoneNumberFormat;
import com.android.i18n.phonenumbers.Phonenumber.PhoneNumber;
import com.android.i18n.phonenumbers.ShortNumberUtil;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PhoneNumberUtils {
    private static final int CCC_LENGTH;
    private static final String CLIR_OFF = "#31#";
    private static final String CLIR_ON = "*31#";
    private static final boolean[] COUNTRY_CALLING_CALL;
    private static final boolean DBG = false;
    public static final int FORMAT_JAPAN = 2;
    public static final int FORMAT_NANP = 1;
    public static final int FORMAT_UNKNOWN = 0;
    private static final Pattern GLOBAL_PHONE_NUMBER_PATTERN;
    private static final SparseIntArray KEYPAD_MAP;
    static final String LOG_TAG = "PhoneNumberUtils";
    static final int MIN_MATCH;
    private static final String[] NANP_COUNTRIES;
    private static final String NANP_IDP_STRING = "011";
    private static final int NANP_LENGTH = 10;
    private static final int NANP_STATE_DASH = 4;
    private static final int NANP_STATE_DIGIT = 1;
    private static final int NANP_STATE_ONE = 3;
    private static final int NANP_STATE_PLUS = 2;
    public static final char PAUSE = ',';
    private static final char PLUS_SIGN_CHAR = '+';
    private static final String PLUS_SIGN_STRING = "+";
    public static final int TOA_International = 145;
    public static final int TOA_Unknown = 129;
    public static final char WAIT = ';';
    public static final char WILD = 'N';

    private static class CountryCallingCodeAndNewIndex {
        public final int countryCallingCode;
        public final int newIndex;

        public CountryCallingCodeAndNewIndex(int countryCode, int newIndex) {
            this.countryCallingCode = countryCode;
            this.newIndex = newIndex;
        }
    }

    static {
        GLOBAL_PHONE_NUMBER_PATTERN = Pattern.compile("[\\+]?[0-9.-]+");
        NANP_COUNTRIES = new String[]{"US", "CA", "AS", "AI", "AG", "BS", "BB", "BM", "VG", "KY", "DM", "DO", "GD", "GU", "JM", "PR", "MS", "MP", "KN", "LC", "VC", "TT", "TC", "VI"};
        MIN_MATCH = SystemProperties.getInt("persist.env.c.phone.matchnum", 7);
        KEYPAD_MAP = new SparseIntArray();
        KEYPAD_MAP.put(97, 50);
        KEYPAD_MAP.put(98, 50);
        KEYPAD_MAP.put(99, 50);
        KEYPAD_MAP.put(65, 50);
        KEYPAD_MAP.put(66, 50);
        KEYPAD_MAP.put(67, 50);
        KEYPAD_MAP.put(100, 51);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_Z, 51);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_L1, 51);
        KEYPAD_MAP.put(68, 51);
        KEYPAD_MAP.put(69, 51);
        KEYPAD_MAP.put(70, 51);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_R1, 52);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_L2, 52);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_R2, 52);
        KEYPAD_MAP.put(71, 52);
        KEYPAD_MAP.put(72, 52);
        KEYPAD_MAP.put(73, 52);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_THUMBL, 53);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_THUMBR, 53);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_START, 53);
        KEYPAD_MAP.put(74, 53);
        KEYPAD_MAP.put(75, 53);
        KEYPAD_MAP.put(76, 53);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_SELECT, 54);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BUTTON_MODE, 54);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_ESCAPE, 54);
        KEYPAD_MAP.put(77, 54);
        KEYPAD_MAP.put(78, 54);
        KEYPAD_MAP.put(79, 54);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_FORWARD_DEL, 55);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_CTRL_LEFT, 55);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_CTRL_RIGHT, 55);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_CAPS_LOCK, 55);
        KEYPAD_MAP.put(80, 55);
        KEYPAD_MAP.put(81, 55);
        KEYPAD_MAP.put(82, 55);
        KEYPAD_MAP.put(83, 55);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_SCROLL_LOCK, 56);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_META_LEFT, 56);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_META_RIGHT, 56);
        KEYPAD_MAP.put(84, 56);
        KEYPAD_MAP.put(85, 56);
        KEYPAD_MAP.put(86, 56);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_FUNCTION, 57);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_SYSRQ, 57);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_BREAK, 57);
        KEYPAD_MAP.put(KeyEvent.KEYCODE_MOVE_HOME, 57);
        KEYPAD_MAP.put(87, 57);
        KEYPAD_MAP.put(88, 57);
        KEYPAD_MAP.put(89, 57);
        KEYPAD_MAP.put(90, 57);
        COUNTRY_CALLING_CALL = new boolean[]{true, true, DBG, DBG, DBG, DBG, DBG, true, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, true, DBG, DBG, DBG, DBG, DBG, DBG, true, true, DBG, true, true, true, true, true, DBG, true, DBG, DBG, true, true, DBG, DBG, true, true, true, true, true, true, true, DBG, true, true, true, true, true, true, true, true, DBG, true, true, true, true, true, true, true, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, DBG, true, true, true, true, DBG, true, DBG, DBG, true, true, true, true, true, true, true, DBG, DBG, true, DBG};
        CCC_LENGTH = COUNTRY_CALLING_CALL.length;
    }

    public static boolean isISODigit(char c) {
        return (c < '0' || c > '9') ? DBG : true;
    }

    public static final boolean is12Key(char c) {
        return ((c >= '0' && c <= '9') || c == '*' || c == '#') ? true : DBG;
    }

    public static final boolean isDialable(char c) {
        return ((c >= '0' && c <= '9') || c == '*' || c == '#' || c == PLUS_SIGN_CHAR || c == WILD) ? true : DBG;
    }

    public static final boolean isReallyDialable(char c) {
        return ((c >= '0' && c <= '9') || c == '*' || c == '#' || c == PLUS_SIGN_CHAR) ? true : DBG;
    }

    public static final boolean isNonSeparator(char c) {
        return ((c >= '0' && c <= '9') || c == '*' || c == '#' || c == PLUS_SIGN_CHAR || c == WILD || c == WAIT || c == PAUSE) ? true : DBG;
    }

    public static final boolean isStartsPostDial(char c) {
        return (c == PAUSE || c == WAIT) ? true : DBG;
    }

    private static boolean isPause(char c) {
        return (c == 'p' || c == 'P') ? true : DBG;
    }

    private static boolean isToneWait(char c) {
        return (c == 'w' || c == 'W') ? true : DBG;
    }

    private static boolean isSeparator(char ch) {
        return (isDialable(ch) || ((DateFormat.AM_PM <= ch && ch <= DateFormat.TIME_ZONE) || (DateFormat.CAPITAL_AM_PM <= ch && ch <= 'Z'))) ? DBG : true;
    }

    public static String getNumberFromIntent(Intent intent, Context context) {
        String number = null;
        Uri uri = intent.getData();
        if (uri == null) {
            return null;
        }
        String scheme = uri.getScheme();
        if (scheme.equals(PhoneAccount.SCHEME_TEL) || scheme.equals(PhoneAccount.SCHEME_SIP)) {
            return uri.getSchemeSpecificPart();
        }
        if (context == null) {
            return null;
        }
        String type = intent.resolveType(context);
        String phoneColumn = null;
        String authority = uri.getAuthority();
        if ("contacts".equals(authority)) {
            phoneColumn = SubscriptionManager.NUMBER;
        } else if ("com.android.contacts".equals(authority)) {
            phoneColumn = "data1";
        }
        ContentResolver contentResolver = context.getContentResolver();
        String[] strArr = new String[NANP_STATE_DIGIT];
        strArr[MIN_MATCH] = phoneColumn;
        Cursor c = contentResolver.query(uri, strArr, null, null, null);
        if (c != null) {
            try {
                if (c.moveToFirst()) {
                    number = c.getString(c.getColumnIndex(phoneColumn));
                }
                c.close();
            } catch (Throwable th) {
                c.close();
            }
        }
        return number;
    }

    public static String extractNetworkPortion(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        int len = phoneNumber.length();
        StringBuilder ret = new StringBuilder(len);
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            int digit = Character.digit(c, NANP_LENGTH);
            if (digit != -1) {
                ret.append(digit);
            } else if (c == PLUS_SIGN_CHAR) {
                String prefix = ret.toString();
                if (prefix.length() == 0 || prefix.equals(CLIR_ON) || prefix.equals(CLIR_OFF)) {
                    ret.append(c);
                }
            } else if (isDialable(c)) {
                ret.append(c);
            } else if (isStartsPostDial(c)) {
                break;
            }
        }
        return ret.toString();
    }

    public static String extractNetworkPortionAlt(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        int len = phoneNumber.length();
        StringBuilder ret = new StringBuilder(len);
        boolean haveSeenPlus = DBG;
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            if (c == PLUS_SIGN_CHAR) {
                if (haveSeenPlus) {
                    continue;
                } else {
                    haveSeenPlus = true;
                }
            }
            if (isDialable(c)) {
                ret.append(c);
            } else if (isStartsPostDial(c)) {
                break;
            }
        }
        return ret.toString();
    }

    public static String stripSeparators(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        int len = phoneNumber.length();
        StringBuilder ret = new StringBuilder(len);
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            int digit = Character.digit(c, NANP_LENGTH);
            if (digit != -1) {
                ret.append(digit);
            } else if (isNonSeparator(c)) {
                ret.append(c);
            }
        }
        return ret.toString();
    }

    public static String convertAndStrip(String phoneNumber) {
        return stripSeparators(convertKeypadLettersToDigits(phoneNumber));
    }

    public static String convertPreDial(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        int len = phoneNumber.length();
        StringBuilder ret = new StringBuilder(len);
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            if (isPause(c)) {
                c = PAUSE;
            } else if (isToneWait(c)) {
                c = WAIT;
            }
            ret.append(c);
        }
        return ret.toString();
    }

    private static int minPositive(int a, int b) {
        if (a >= 0 && b >= 0) {
            return a < b ? a : b;
        } else {
            if (a >= 0) {
                return a;
            }
            if (b >= 0) {
                return b;
            }
            return -1;
        }
    }

    private static void log(String msg) {
        Rlog.m13d(LOG_TAG, msg);
    }

    private static int indexOfLastNetworkChar(String a) {
        int origLength = a.length();
        int trimIndex = minPositive(a.indexOf(44), a.indexOf(59));
        if (trimIndex < 0) {
            return origLength - 1;
        }
        return trimIndex - 1;
    }

    public static String extractPostDialPortion(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        StringBuilder ret = new StringBuilder();
        int s = phoneNumber.length();
        for (int i = indexOfLastNetworkChar(phoneNumber) + NANP_STATE_DIGIT; i < s; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            if (isNonSeparator(c)) {
                ret.append(c);
            }
        }
        return ret.toString();
    }

    public static boolean compare(String a, String b) {
        return compare(a, b, (boolean) DBG);
    }

    public static boolean compare(Context context, String a, String b) {
        return compare(a, b, context.getResources().getBoolean(17956922));
    }

    public static boolean compare(String a, String b, boolean useStrictComparation) {
        return useStrictComparation ? compareStrictly(a, b) : compareLoosely(a, b);
    }

    public static boolean compareLoosely(String a, String b) {
        int numNonDialableCharsInA = MIN_MATCH;
        int numNonDialableCharsInB = MIN_MATCH;
        if (a == null || b == null) {
            if (a == b) {
                return true;
            }
            return DBG;
        } else if (a.length() == 0 || b.length() == 0) {
            return DBG;
        } else {
            int ia = indexOfLastNetworkChar(a);
            int ib = indexOfLastNetworkChar(b);
            int matched = MIN_MATCH;
            while (ia >= 0 && ib >= 0) {
                boolean skipCmp = DBG;
                char ca = a.charAt(ia);
                if (!isDialable(ca)) {
                    ia--;
                    skipCmp = true;
                    numNonDialableCharsInA += NANP_STATE_DIGIT;
                }
                char cb = b.charAt(ib);
                if (!isDialable(cb)) {
                    ib--;
                    skipCmp = true;
                    numNonDialableCharsInB += NANP_STATE_DIGIT;
                }
                if (!skipCmp) {
                    if (cb != ca && ca != WILD && cb != WILD) {
                        break;
                    }
                    ia--;
                    ib--;
                    matched += NANP_STATE_DIGIT;
                }
            }
            if (matched < MIN_MATCH) {
                int effectiveALen = a.length() - numNonDialableCharsInA;
                if (effectiveALen == b.length() - numNonDialableCharsInB && effectiveALen == matched) {
                    return true;
                }
                return DBG;
            } else if (matched >= MIN_MATCH && (ia < 0 || ib < 0)) {
                return true;
            } else {
                if (matchIntlPrefix(a, ia + NANP_STATE_DIGIT) && matchIntlPrefix(b, ib + NANP_STATE_DIGIT)) {
                    return true;
                }
                if (matchTrunkPrefix(a, ia + NANP_STATE_DIGIT) && matchIntlPrefixAndCC(b, ib + NANP_STATE_DIGIT)) {
                    return true;
                }
                if (matchTrunkPrefix(b, ib + NANP_STATE_DIGIT) && matchIntlPrefixAndCC(a, ia + NANP_STATE_DIGIT)) {
                    return true;
                }
                return DBG;
            }
        }
    }

    public static boolean compareStrictly(String a, String b) {
        return compareStrictly(a, b, true);
    }

    public static boolean compareStrictly(String a, String b, boolean acceptInvalidCCCPrefix) {
        if (a == null || b == null) {
            if (a == b) {
                return true;
            }
            return DBG;
        } else if (a.length() == 0 && b.length() == 0) {
            return DBG;
        } else {
            char chA;
            char chB;
            int forwardIndexA = MIN_MATCH;
            int forwardIndexB = MIN_MATCH;
            CountryCallingCodeAndNewIndex cccA = tryGetCountryCallingCodeAndNewIndex(a, acceptInvalidCCCPrefix);
            CountryCallingCodeAndNewIndex cccB = tryGetCountryCallingCodeAndNewIndex(b, acceptInvalidCCCPrefix);
            boolean bothHasCountryCallingCode = DBG;
            boolean okToIgnorePrefix = true;
            boolean trunkPrefixIsOmittedA = DBG;
            boolean trunkPrefixIsOmittedB = DBG;
            if (cccA != null && cccB != null) {
                if (cccA.countryCallingCode != cccB.countryCallingCode) {
                    return DBG;
                }
                okToIgnorePrefix = DBG;
                bothHasCountryCallingCode = true;
                forwardIndexA = cccA.newIndex;
                forwardIndexB = cccB.newIndex;
            } else if (cccA == null && cccB == null) {
                okToIgnorePrefix = DBG;
            } else {
                int tmp;
                if (cccA != null) {
                    forwardIndexA = cccA.newIndex;
                } else {
                    tmp = tryGetTrunkPrefixOmittedIndex(b, MIN_MATCH);
                    if (tmp >= 0) {
                        forwardIndexA = tmp;
                        trunkPrefixIsOmittedA = true;
                    }
                }
                if (cccB != null) {
                    forwardIndexB = cccB.newIndex;
                } else {
                    tmp = tryGetTrunkPrefixOmittedIndex(b, MIN_MATCH);
                    if (tmp >= 0) {
                        forwardIndexB = tmp;
                        trunkPrefixIsOmittedB = true;
                    }
                }
            }
            int backwardIndexA = a.length() - 1;
            int backwardIndexB = b.length() - 1;
            while (backwardIndexA >= forwardIndexA && backwardIndexB >= forwardIndexB) {
                boolean skip_compare = DBG;
                chA = a.charAt(backwardIndexA);
                chB = b.charAt(backwardIndexB);
                if (isSeparator(chA)) {
                    backwardIndexA--;
                    skip_compare = true;
                }
                if (isSeparator(chB)) {
                    backwardIndexB--;
                    skip_compare = true;
                }
                if (!skip_compare) {
                    if (chA != chB) {
                        return DBG;
                    }
                    backwardIndexA--;
                    backwardIndexB--;
                }
            }
            if (!okToIgnorePrefix) {
                boolean maybeNamp = !bothHasCountryCallingCode ? true : DBG;
                while (backwardIndexA >= forwardIndexA) {
                    chA = a.charAt(backwardIndexA);
                    if (isDialable(chA)) {
                        if (!maybeNamp || tryGetISODigit(chA) != NANP_STATE_DIGIT) {
                            return DBG;
                        }
                        maybeNamp = DBG;
                    }
                    backwardIndexA--;
                }
                while (backwardIndexB >= forwardIndexB) {
                    chB = b.charAt(backwardIndexB);
                    if (isDialable(chB)) {
                        if (!maybeNamp || tryGetISODigit(chB) != NANP_STATE_DIGIT) {
                            return DBG;
                        }
                        maybeNamp = DBG;
                    }
                    backwardIndexB--;
                }
            } else if ((!trunkPrefixIsOmittedA || forwardIndexA > backwardIndexA) && checkPrefixIsIgnorable(a, forwardIndexA, backwardIndexA)) {
                if ((trunkPrefixIsOmittedB && forwardIndexB <= backwardIndexB) || !checkPrefixIsIgnorable(b, forwardIndexA, backwardIndexB)) {
                    if (acceptInvalidCCCPrefix) {
                        return compare(a, b, DBG);
                    }
                    return DBG;
                }
            } else if (acceptInvalidCCCPrefix) {
                return compare(a, b, DBG);
            } else {
                return DBG;
            }
            return true;
        }
    }

    public static String toCallerIDMinMatch(String phoneNumber) {
        return internalGetStrippedReversed(extractNetworkPortionAlt(phoneNumber), MIN_MATCH);
    }

    public static String getStrippedReversed(String phoneNumber) {
        String np = extractNetworkPortionAlt(phoneNumber);
        if (np == null) {
            return null;
        }
        return internalGetStrippedReversed(np, np.length());
    }

    private static String internalGetStrippedReversed(String np, int numDigits) {
        if (np == null) {
            return null;
        }
        StringBuilder ret = new StringBuilder(numDigits);
        int length = np.length();
        int i = length - 1;
        int s = length;
        while (i >= 0 && s - i <= numDigits) {
            ret.append(np.charAt(i));
            i--;
        }
        return ret.toString();
    }

    public static String stringFromStringAndTOA(String s, int TOA) {
        if (s == null) {
            return null;
        }
        if (TOA != TOA_International || s.length() <= 0 || s.charAt(MIN_MATCH) == PLUS_SIGN_CHAR) {
            return s;
        }
        return PLUS_SIGN_STRING + s;
    }

    public static int toaFromString(String s) {
        if (s == null || s.length() <= 0 || s.charAt(MIN_MATCH) != PLUS_SIGN_CHAR) {
            return TOA_Unknown;
        }
        return TOA_International;
    }

    public static String calledPartyBCDToString(byte[] bytes, int offset, int length) {
        boolean prependPlus = DBG;
        StringBuilder ret = new StringBuilder((length * NANP_STATE_PLUS) + NANP_STATE_DIGIT);
        if (length < NANP_STATE_PLUS) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        if ((bytes[offset] & LayoutParams.SOFT_INPUT_MASK_ADJUST) == KeyEvent.KEYCODE_NUMPAD_0) {
            prependPlus = true;
        }
        internalCalledPartyBCDFragmentToString(ret, bytes, offset + NANP_STATE_DIGIT, length - 1);
        if (prependPlus && ret.length() == 0) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        if (prependPlus) {
            String retString = ret.toString();
            Matcher m = Pattern.compile("(^[#*])(.*)([#*])(.*)(#)$").matcher(retString);
            if (!m.matches()) {
                m = Pattern.compile("(^[#*])(.*)([#*])(.*)").matcher(retString);
                if (m.matches()) {
                    ret = new StringBuilder();
                    ret.append(m.group(NANP_STATE_DIGIT));
                    ret.append(m.group(NANP_STATE_PLUS));
                    ret.append(m.group(NANP_STATE_ONE));
                    ret.append(PLUS_SIGN_STRING);
                    ret.append(m.group(NANP_STATE_DASH));
                } else {
                    ret = new StringBuilder();
                    ret.append(PLUS_SIGN_CHAR);
                    ret.append(retString);
                }
            } else if (ProxyInfo.LOCAL_EXCL_LIST.equals(m.group(NANP_STATE_PLUS))) {
                ret = new StringBuilder();
                ret.append(m.group(NANP_STATE_DIGIT));
                ret.append(m.group(NANP_STATE_ONE));
                ret.append(m.group(NANP_STATE_DASH));
                ret.append(m.group(5));
                ret.append(PLUS_SIGN_STRING);
            } else {
                ret = new StringBuilder();
                ret.append(m.group(NANP_STATE_DIGIT));
                ret.append(m.group(NANP_STATE_PLUS));
                ret.append(m.group(NANP_STATE_ONE));
                ret.append(PLUS_SIGN_STRING);
                ret.append(m.group(NANP_STATE_DASH));
                ret.append(m.group(5));
            }
        }
        return ret.toString();
    }

    private static void internalCalledPartyBCDFragmentToString(StringBuilder sb, byte[] bytes, int offset, int length) {
        int i = offset;
        while (i < length + offset) {
            char c = bcdToChar((byte) (bytes[i] & 15));
            if (c != '\u0000') {
                sb.append(c);
                byte b = (byte) ((bytes[i] >> NANP_STATE_DASH) & 15);
                if (b != 15 || i + NANP_STATE_DIGIT != length + offset) {
                    c = bcdToChar(b);
                    if (c != '\u0000') {
                        sb.append(c);
                        i += NANP_STATE_DIGIT;
                    } else {
                        return;
                    }
                }
                return;
            }
            return;
        }
    }

    public static String calledPartyBCDFragmentToString(byte[] bytes, int offset, int length) {
        StringBuilder ret = new StringBuilder(length * NANP_STATE_PLUS);
        internalCalledPartyBCDFragmentToString(ret, bytes, offset, length);
        return ret.toString();
    }

    private static char bcdToChar(byte b) {
        if (b < NANP_LENGTH) {
            return (char) (b + 48);
        }
        switch (b) {
            case NANP_LENGTH /*10*/:
                return '*';
            case TextViewDrawableAction.TAG /*11*/:
                return '#';
            case BitmapReflectionAction.TAG /*12*/:
                return PAUSE;
            case TextViewSizeAction.TAG /*13*/:
                return WILD;
            default:
                return '\u0000';
        }
    }

    private static int charToBCD(char c) {
        if (c >= '0' && c <= '9') {
            return c - 48;
        }
        if (c == '*') {
            return NANP_LENGTH;
        }
        if (c == '#') {
            return 11;
        }
        if (c == PAUSE) {
            return 12;
        }
        if (c == WILD) {
            return 13;
        }
        if (c == WAIT) {
            return 14;
        }
        throw new RuntimeException("invalid char for BCD " + c);
    }

    public static boolean isWellFormedSmsAddress(String address) {
        String networkPortion = extractNetworkPortion(address);
        return (networkPortion.equals(PLUS_SIGN_STRING) || TextUtils.isEmpty(networkPortion) || !isDialable(networkPortion)) ? DBG : true;
    }

    public static boolean isGlobalPhoneNumber(String phoneNumber) {
        if (TextUtils.isEmpty(phoneNumber)) {
            return DBG;
        }
        return GLOBAL_PHONE_NUMBER_PATTERN.matcher(phoneNumber).matches();
    }

    private static boolean isDialable(String address) {
        int count = address.length();
        for (int i = MIN_MATCH; i < count; i += NANP_STATE_DIGIT) {
            if (!isDialable(address.charAt(i))) {
                return DBG;
            }
        }
        return true;
    }

    private static boolean isNonSeparator(String address) {
        int count = address.length();
        for (int i = MIN_MATCH; i < count; i += NANP_STATE_DIGIT) {
            if (!isNonSeparator(address.charAt(i))) {
                return DBG;
            }
        }
        return true;
    }

    public static byte[] networkPortionToCalledPartyBCD(String s) {
        return numberToCalledPartyBCDHelper(extractNetworkPortion(s), DBG);
    }

    public static byte[] networkPortionToCalledPartyBCDWithLength(String s) {
        return numberToCalledPartyBCDHelper(extractNetworkPortion(s), true);
    }

    public static byte[] numberToCalledPartyBCD(String number) {
        return numberToCalledPartyBCDHelper(number, DBG);
    }

    private static byte[] numberToCalledPartyBCDHelper(String number, boolean includeLength) {
        if (TextUtils.isEmpty(number)) {
            return null;
        }
        int numberLenReal = number.length();
        int numberLenEffective = numberLenReal;
        boolean hasPlus = number.indexOf(43) != -1 ? true : DBG;
        if (hasPlus) {
            numberLenEffective--;
        }
        if (numberLenEffective == 0) {
            return null;
        }
        int resultLen = (numberLenEffective + NANP_STATE_DIGIT) / NANP_STATE_PLUS;
        int extraBytes = NANP_STATE_DIGIT;
        if (includeLength) {
            extraBytes = NANP_STATE_DIGIT + NANP_STATE_DIGIT;
        }
        resultLen += extraBytes;
        byte[] result = new byte[resultLen];
        int digitCount = MIN_MATCH;
        for (int i = MIN_MATCH; i < numberLenReal; i += NANP_STATE_DIGIT) {
            char c = number.charAt(i);
            if (c != PLUS_SIGN_CHAR) {
                int i2 = (digitCount >> NANP_STATE_DIGIT) + extraBytes;
                result[i2] = (byte) (result[i2] | ((byte) ((charToBCD(c) & 15) << ((digitCount & NANP_STATE_DIGIT) == NANP_STATE_DIGIT ? NANP_STATE_DASH : MIN_MATCH))));
                digitCount += NANP_STATE_DIGIT;
            }
        }
        if ((digitCount & NANP_STATE_DIGIT) == NANP_STATE_DIGIT) {
            i2 = (digitCount >> NANP_STATE_DIGIT) + extraBytes;
            result[i2] = (byte) (result[i2] | LayoutParams.SOFT_INPUT_MASK_ADJUST);
        }
        int offset = MIN_MATCH;
        if (includeLength) {
            int offset2 = MIN_MATCH + NANP_STATE_DIGIT;
            result[MIN_MATCH] = (byte) (resultLen - 1);
            offset = offset2;
        }
        result[offset] = (byte) (hasPlus ? TOA_International : TOA_Unknown);
        return result;
    }

    public static String formatNumber(String source) {
        Editable text = new SpannableStringBuilder(source);
        formatNumber(text, getFormatTypeForLocale(Locale.getDefault()));
        return text.toString();
    }

    public static String formatNumber(String source, int defaultFormattingType) {
        Editable text = new SpannableStringBuilder(source);
        formatNumber(text, defaultFormattingType);
        return text.toString();
    }

    public static int getFormatTypeForLocale(Locale locale) {
        return getFormatTypeFromCountryCode(locale.getCountry());
    }

    public static void formatNumber(Editable text, int defaultFormattingType) {
        int formatType = defaultFormattingType;
        if (text.length() > NANP_STATE_PLUS && text.charAt(MIN_MATCH) == PLUS_SIGN_CHAR) {
            formatType = text.charAt(NANP_STATE_DIGIT) == '1' ? NANP_STATE_DIGIT : (text.length() >= NANP_STATE_ONE && text.charAt(NANP_STATE_DIGIT) == '8' && text.charAt(NANP_STATE_PLUS) == '1') ? NANP_STATE_PLUS : MIN_MATCH;
        }
        switch (formatType) {
            case MIN_MATCH:
                removeDashes(text);
            case NANP_STATE_DIGIT /*1*/:
                formatNanpNumber(text);
            case NANP_STATE_PLUS /*2*/:
                formatJapaneseNumber(text);
            default:
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static void formatNanpNumber(android.text.Editable r15) {
        /*
        r14 = 2;
        r13 = 3;
        r12 = 0;
        r4 = r15.length();
        r11 = "+1-nnn-nnn-nnnn";
        r11 = r11.length();
        if (r4 <= r11) goto L_0x0010;
    L_0x000f:
        return;
    L_0x0010:
        r11 = 5;
        if (r4 <= r11) goto L_0x000f;
    L_0x0013:
        r9 = r15.subSequence(r12, r4);
        removeDashes(r15);
        r4 = r15.length();
        r1 = new int[r13];
        r5 = 0;
        r10 = 1;
        r7 = 0;
        r2 = 0;
        r6 = r5;
    L_0x0025:
        if (r2 >= r4) goto L_0x0061;
    L_0x0027:
        r0 = r15.charAt(r2);
        switch(r0) {
            case 43: goto L_0x005c;
            case 44: goto L_0x002e;
            case 45: goto L_0x0059;
            case 46: goto L_0x002e;
            case 47: goto L_0x002e;
            case 48: goto L_0x003c;
            case 49: goto L_0x0032;
            case 50: goto L_0x003c;
            case 51: goto L_0x003c;
            case 52: goto L_0x003c;
            case 53: goto L_0x003c;
            case 54: goto L_0x003c;
            case 55: goto L_0x003c;
            case 56: goto L_0x003c;
            case 57: goto L_0x003c;
            default: goto L_0x002e;
        };
    L_0x002e:
        r15.replace(r12, r4, r9);
        goto L_0x000f;
    L_0x0032:
        if (r7 == 0) goto L_0x0036;
    L_0x0034:
        if (r10 != r14) goto L_0x003c;
    L_0x0036:
        r10 = 3;
        r5 = r6;
    L_0x0038:
        r2 = r2 + 1;
        r6 = r5;
        goto L_0x0025;
    L_0x003c:
        if (r10 != r14) goto L_0x0042;
    L_0x003e:
        r15.replace(r12, r4, r9);
        goto L_0x000f;
    L_0x0042:
        if (r10 != r13) goto L_0x004c;
    L_0x0044:
        r5 = r6 + 1;
        r1[r6] = r2;
    L_0x0048:
        r10 = 1;
        r7 = r7 + 1;
        goto L_0x0038;
    L_0x004c:
        r11 = 4;
        if (r10 == r11) goto L_0x0091;
    L_0x004f:
        if (r7 == r13) goto L_0x0054;
    L_0x0051:
        r11 = 6;
        if (r7 != r11) goto L_0x0091;
    L_0x0054:
        r5 = r6 + 1;
        r1[r6] = r2;
        goto L_0x0048;
    L_0x0059:
        r10 = 4;
        r5 = r6;
        goto L_0x0038;
    L_0x005c:
        if (r2 != 0) goto L_0x002e;
    L_0x005e:
        r10 = 2;
        r5 = r6;
        goto L_0x0038;
    L_0x0061:
        r11 = 7;
        if (r7 != r11) goto L_0x008f;
    L_0x0064:
        r5 = r6 + -1;
    L_0x0066:
        r2 = 0;
    L_0x0067:
        if (r2 >= r5) goto L_0x0077;
    L_0x0069:
        r8 = r1[r2];
        r11 = r8 + r2;
        r12 = r8 + r2;
        r13 = "-";
        r15.replace(r11, r12, r13);
        r2 = r2 + 1;
        goto L_0x0067;
    L_0x0077:
        r3 = r15.length();
    L_0x007b:
        if (r3 <= 0) goto L_0x000f;
    L_0x007d:
        r11 = r3 + -1;
        r11 = r15.charAt(r11);
        r12 = 45;
        if (r11 != r12) goto L_0x000f;
    L_0x0087:
        r11 = r3 + -1;
        r15.delete(r11, r3);
        r3 = r3 + -1;
        goto L_0x007b;
    L_0x008f:
        r5 = r6;
        goto L_0x0066;
    L_0x0091:
        r5 = r6;
        goto L_0x0048;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.telephony.PhoneNumberUtils.formatNanpNumber(android.text.Editable):void");
    }

    public static void formatJapaneseNumber(Editable text) {
        JapanesePhoneNumberFormatter.format(text);
    }

    private static void removeDashes(Editable text) {
        int p = MIN_MATCH;
        while (p < text.length()) {
            if (text.charAt(p) == '-') {
                text.delete(p, p + NANP_STATE_DIGIT);
            } else {
                p += NANP_STATE_DIGIT;
            }
        }
    }

    public static String formatNumberToE164(String phoneNumber, String defaultCountryIso) {
        PhoneNumberUtil util = PhoneNumberUtil.getInstance();
        String result = null;
        try {
            PhoneNumber pn = util.parse(phoneNumber, defaultCountryIso);
            if (util.isValidNumber(pn)) {
                result = util.format(pn, PhoneNumberFormat.E164);
            }
        } catch (NumberParseException e) {
        }
        return result;
    }

    public static String formatNumber(String phoneNumber, String defaultCountryIso) {
        if (phoneNumber.startsWith("#") || phoneNumber.startsWith("*")) {
            return phoneNumber;
        }
        PhoneNumberUtil util = PhoneNumberUtil.getInstance();
        String result = null;
        try {
            return util.formatInOriginalFormat(util.parseAndKeepRawInput(phoneNumber, defaultCountryIso), defaultCountryIso);
        } catch (NumberParseException e) {
            return result;
        }
    }

    public static String formatNumber(String phoneNumber, String phoneNumberE164, String defaultCountryIso) {
        int len = phoneNumber.length();
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            if (!isDialable(phoneNumber.charAt(i))) {
                return phoneNumber;
            }
        }
        PhoneNumberUtil util = PhoneNumberUtil.getInstance();
        if (phoneNumberE164 != null && phoneNumberE164.length() >= NANP_STATE_PLUS && phoneNumberE164.charAt(MIN_MATCH) == PLUS_SIGN_CHAR) {
            try {
                String regionCode = util.getRegionCodeForNumber(util.parse(phoneNumberE164, "ZZ"));
                if (!TextUtils.isEmpty(regionCode) && normalizeNumber(phoneNumber).indexOf(phoneNumberE164.substring(NANP_STATE_DIGIT)) <= 0) {
                    defaultCountryIso = regionCode;
                }
            } catch (NumberParseException e) {
            }
        }
        String result = formatNumber(phoneNumber, defaultCountryIso);
        if (result == null) {
            result = phoneNumber;
        }
        return result;
    }

    public static String normalizeNumber(String phoneNumber) {
        if (TextUtils.isEmpty(phoneNumber)) {
            return ProxyInfo.LOCAL_EXCL_LIST;
        }
        StringBuilder sb = new StringBuilder();
        int len = phoneNumber.length();
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = phoneNumber.charAt(i);
            int digit = Character.digit(c, NANP_LENGTH);
            if (digit != -1) {
                sb.append(digit);
            } else if (sb.length() == 0 && c == PLUS_SIGN_CHAR) {
                sb.append(c);
            } else if ((c >= DateFormat.AM_PM && c <= DateFormat.TIME_ZONE) || (c >= DateFormat.CAPITAL_AM_PM && c <= 'Z')) {
                return normalizeNumber(convertKeypadLettersToDigits(phoneNumber));
            }
        }
        return sb.toString();
    }

    public static String replaceUnicodeDigits(String number) {
        StringBuilder normalizedDigits = new StringBuilder(number.length());
        char[] arr$ = number.toCharArray();
        int len$ = arr$.length;
        for (int i$ = MIN_MATCH; i$ < len$; i$ += NANP_STATE_DIGIT) {
            char c = arr$[i$];
            int digit = Character.digit(c, NANP_LENGTH);
            if (digit != -1) {
                normalizedDigits.append(digit);
            } else {
                normalizedDigits.append(c);
            }
        }
        return normalizedDigits.toString();
    }

    public static boolean isEmergencyNumber(String number) {
        return isEmergencyNumber(getDefaultVoiceSubId(), number);
    }

    public static boolean isEmergencyNumber(int subId, String number) {
        return isEmergencyNumberInternal(subId, number, true);
    }

    public static boolean isPotentialEmergencyNumber(String number) {
        return isPotentialEmergencyNumber(getDefaultVoiceSubId(), number);
    }

    public static boolean isPotentialEmergencyNumber(int subId, String number) {
        return isEmergencyNumberInternal(subId, number, (boolean) DBG);
    }

    private static boolean isEmergencyNumberInternal(String number, boolean useExactMatch) {
        return isEmergencyNumberInternal(getDefaultVoiceSubId(), number, useExactMatch);
    }

    private static boolean isEmergencyNumberInternal(int subId, String number, boolean useExactMatch) {
        return isEmergencyNumberInternal(subId, number, null, useExactMatch);
    }

    public static boolean isEmergencyNumber(String number, String defaultCountryIso) {
        return isEmergencyNumber(getDefaultVoiceSubId(), number, defaultCountryIso);
    }

    public static boolean isEmergencyNumber(int subId, String number, String defaultCountryIso) {
        return isEmergencyNumberInternal(subId, number, defaultCountryIso, true);
    }

    public static boolean isPotentialEmergencyNumber(String number, String defaultCountryIso) {
        return isPotentialEmergencyNumber(getDefaultVoiceSubId(), number, defaultCountryIso);
    }

    public static boolean isPotentialEmergencyNumber(int subId, String number, String defaultCountryIso) {
        return isEmergencyNumberInternal(subId, number, defaultCountryIso, DBG);
    }

    private static boolean isEmergencyNumberInternal(String number, String defaultCountryIso, boolean useExactMatch) {
        return isEmergencyNumberInternal(getDefaultVoiceSubId(), number, defaultCountryIso, useExactMatch);
    }

    private static boolean isEmergencyNumberInternal(int subId, String number, String defaultCountryIso, boolean useExactMatch) {
        if (number == null) {
            return DBG;
        }
        if (isUriNumber(number)) {
            return DBG;
        }
        String str;
        String ecclist;
        number = extractNetworkPortionAlt(number);
        String str2 = LOG_TAG;
        StringBuilder append = new StringBuilder().append("subId:").append(subId).append(", defaultCountryIso:");
        if (defaultCountryIso == null) {
            str = WifiEnterpriseConfig.EMPTY_VALUE;
        } else {
            str = defaultCountryIso;
        }
        Rlog.m13d(str2, append.append(str).toString());
        String emergencyNumbers = ProxyInfo.LOCAL_EXCL_LIST;
        int slotId = SubscriptionManager.getSlotId(subId);
        if (slotId <= 0) {
            ecclist = "ril.ecclist";
        } else {
            ecclist = "ril.ecclist" + slotId;
        }
        emergencyNumbers = SystemProperties.get(ecclist, ProxyInfo.LOCAL_EXCL_LIST);
        Rlog.m13d(LOG_TAG, "slotId:" + slotId + ", emergencyNumbers: " + emergencyNumbers);
        if (TextUtils.isEmpty(emergencyNumbers)) {
            emergencyNumbers = SystemProperties.get("ro.ril.ecclist");
        }
        String[] arr$;
        int len$;
        int i$;
        String emergencyNum;
        if (TextUtils.isEmpty(emergencyNumbers)) {
            Rlog.m13d(LOG_TAG, "System property doesn't provide any emergency numbers. Use embedded logic for determining ones.");
            arr$ = (slotId < 0 ? "112,911,000,08,110,118,119,999" : "112,911").split(",");
            len$ = arr$.length;
            for (i$ = MIN_MATCH; i$ < len$; i$ += NANP_STATE_DIGIT) {
                emergencyNum = arr$[i$];
                if (useExactMatch) {
                    if (number.equals(emergencyNum)) {
                        return true;
                    }
                } else if (number.startsWith(emergencyNum)) {
                    return true;
                }
            }
            if (defaultCountryIso == null) {
                return DBG;
            }
            ShortNumberUtil util = new ShortNumberUtil();
            if (useExactMatch) {
                return util.isEmergencyNumber(number, defaultCountryIso);
            }
            return util.connectsToEmergencyNumber(number, defaultCountryIso);
        }
        arr$ = emergencyNumbers.split(",");
        len$ = arr$.length;
        for (i$ = MIN_MATCH; i$ < len$; i$ += NANP_STATE_DIGIT) {
            emergencyNum = arr$[i$];
            if (useExactMatch || "BR".equalsIgnoreCase(defaultCountryIso)) {
                if (number.equals(emergencyNum)) {
                    return true;
                }
            } else if (number.startsWith(emergencyNum)) {
                return true;
            }
        }
        return DBG;
    }

    public static boolean isLocalEmergencyNumber(Context context, String number) {
        return isLocalEmergencyNumber(context, getDefaultVoiceSubId(), number);
    }

    public static boolean isLocalEmergencyNumber(Context context, int subId, String number) {
        return isLocalEmergencyNumberInternal(subId, number, context, true);
    }

    public static boolean isPotentialLocalEmergencyNumber(Context context, String number) {
        return isPotentialLocalEmergencyNumber(context, getDefaultVoiceSubId(), number);
    }

    public static boolean isPotentialLocalEmergencyNumber(Context context, int subId, String number) {
        return isLocalEmergencyNumberInternal(subId, number, context, DBG);
    }

    private static boolean isLocalEmergencyNumberInternal(String number, Context context, boolean useExactMatch) {
        return isLocalEmergencyNumberInternal(getDefaultVoiceSubId(), number, context, useExactMatch);
    }

    private static boolean isLocalEmergencyNumberInternal(int subId, String number, Context context, boolean useExactMatch) {
        String countryIso;
        CountryDetector detector = (CountryDetector) context.getSystemService(Context.COUNTRY_DETECTOR);
        if (detector == null || detector.detectCountry() == null) {
            countryIso = context.getResources().getConfiguration().locale.getCountry();
            Rlog.m21w(LOG_TAG, "No CountryDetector; falling back to countryIso based on locale: " + countryIso);
        } else {
            countryIso = detector.detectCountry().getCountryIso();
        }
        return isEmergencyNumberInternal(subId, number, countryIso, useExactMatch);
    }

    public static boolean isVoiceMailNumber(String number) {
        return isVoiceMailNumber(SubscriptionManager.getDefaultSubId(), number);
    }

    public static boolean isVoiceMailNumber(int subId, String number) {
        try {
            String vmNumber = TelephonyManager.getDefault().getVoiceMailNumber(subId);
            number = extractNetworkPortionAlt(number);
            if (TextUtils.isEmpty(number) || !compare(number, vmNumber)) {
                return DBG;
            }
            return true;
        } catch (SecurityException e) {
            return DBG;
        }
    }

    public static String convertKeypadLettersToDigits(String input) {
        if (input == null) {
            return input;
        }
        int len = input.length();
        if (len == 0) {
            return input;
        }
        char[] out = input.toCharArray();
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = out[i];
            out[i] = (char) KEYPAD_MAP.get(c, c);
        }
        return new String(out);
    }

    public static String cdmaCheckAndProcessPlusCode(String dialStr) {
        if (TextUtils.isEmpty(dialStr) || !isReallyDialable(dialStr.charAt(MIN_MATCH)) || !isNonSeparator(dialStr)) {
            return dialStr;
        }
        String currIso = TelephonyManager.getDefault().getNetworkCountryIso();
        String defaultIso = TelephonyManager.getDefault().getSimCountryIso();
        if (TextUtils.isEmpty(currIso) || TextUtils.isEmpty(defaultIso)) {
            return dialStr;
        }
        return cdmaCheckAndProcessPlusCodeByNumberFormat(dialStr, getFormatTypeFromCountryCode(currIso), getFormatTypeFromCountryCode(defaultIso));
    }

    public static String cdmaCheckAndProcessPlusCodeForSms(String dialStr) {
        if (TextUtils.isEmpty(dialStr) || !isReallyDialable(dialStr.charAt(MIN_MATCH)) || !isNonSeparator(dialStr)) {
            return dialStr;
        }
        String defaultIso = TelephonyManager.getDefault().getSimCountryIso();
        if (TextUtils.isEmpty(defaultIso)) {
            return dialStr;
        }
        int format = getFormatTypeFromCountryCode(defaultIso);
        return cdmaCheckAndProcessPlusCodeByNumberFormat(dialStr, format, format);
    }

    public static String cdmaCheckAndProcessPlusCodeByNumberFormat(String dialStr, int currFormat, int defaultFormat) {
        String retStr = dialStr;
        boolean useNanp = (currFormat == defaultFormat && currFormat == NANP_STATE_DIGIT) ? true : DBG;
        if (!(dialStr == null || dialStr.lastIndexOf(PLUS_SIGN_STRING) == -1)) {
            String tempDialStr = dialStr;
            retStr = null;
            do {
                String networkDialStr;
                if (useNanp) {
                    networkDialStr = extractNetworkPortion(tempDialStr);
                } else {
                    networkDialStr = extractNetworkPortionAlt(tempDialStr);
                }
                networkDialStr = processPlusCode(networkDialStr, useNanp);
                if (!TextUtils.isEmpty(networkDialStr)) {
                    if (retStr == null) {
                        retStr = networkDialStr;
                    } else {
                        retStr = retStr.concat(networkDialStr);
                    }
                    String postDialStr = extractPostDialPortion(tempDialStr);
                    if (!TextUtils.isEmpty(postDialStr)) {
                        int dialableIndex = findDialableIndexFromPostDialStr(postDialStr);
                        if (dialableIndex >= NANP_STATE_DIGIT) {
                            retStr = appendPwCharBackToOrigDialStr(dialableIndex, retStr, postDialStr);
                            tempDialStr = postDialStr.substring(dialableIndex);
                        } else {
                            if (dialableIndex < 0) {
                                postDialStr = ProxyInfo.LOCAL_EXCL_LIST;
                            }
                            Rlog.m15e("wrong postDialStr=", postDialStr);
                        }
                    }
                    if (TextUtils.isEmpty(postDialStr)) {
                        break;
                    }
                } else {
                    Rlog.m15e("checkAndProcessPlusCode: null newDialStr", networkDialStr);
                    return dialStr;
                }
            } while (!TextUtils.isEmpty(tempDialStr));
        }
        return retStr;
    }

    public static CharSequence ttsSpanAsPhoneNumber(CharSequence phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }
        CharSequence spannable = Factory.getInstance().newSpannable(phoneNumber);
        ttsSpanAsPhoneNumber(spannable, MIN_MATCH, spannable.length());
        return spannable;
    }

    public static void ttsSpanAsPhoneNumber(Spannable s, int start, int end) {
        s.setSpan(new TelephoneBuilder().setNumberParts(splitAtNonNumerics(s.subSequence(start, end))).build(), start, end, 33);
    }

    private static String splitAtNonNumerics(CharSequence number) {
        StringBuilder sb = new StringBuilder(number.length());
        for (int i = MIN_MATCH; i < number.length(); i += NANP_STATE_DIGIT) {
            sb.append(isISODigit(number.charAt(i)) ? Character.valueOf(number.charAt(i)) : " ");
        }
        return sb.toString().replaceAll(" +", " ").trim();
    }

    private static String getCurrentIdp(boolean useNanp) {
        return SystemProperties.get("gsm.operator.idpstring", useNanp ? NANP_IDP_STRING : PLUS_SIGN_STRING);
    }

    private static boolean isTwoToNine(char c) {
        if (c < '2' || c > '9') {
            return DBG;
        }
        return true;
    }

    private static int getFormatTypeFromCountryCode(String country) {
        int length = NANP_COUNTRIES.length;
        for (int i = MIN_MATCH; i < length; i += NANP_STATE_DIGIT) {
            if (NANP_COUNTRIES[i].compareToIgnoreCase(country) == 0) {
                return NANP_STATE_DIGIT;
            }
        }
        if ("jp".compareToIgnoreCase(country) == 0) {
            return NANP_STATE_PLUS;
        }
        return MIN_MATCH;
    }

    public static boolean isNanp(String dialStr) {
        if (dialStr == null) {
            Rlog.m15e("isNanp: null dialStr passed in", dialStr);
            return DBG;
        } else if (dialStr.length() != NANP_LENGTH || !isTwoToNine(dialStr.charAt(MIN_MATCH)) || !isTwoToNine(dialStr.charAt(NANP_STATE_ONE))) {
            return DBG;
        } else {
            for (int i = NANP_STATE_DIGIT; i < NANP_LENGTH; i += NANP_STATE_DIGIT) {
                if (!isISODigit(dialStr.charAt(i))) {
                    return DBG;
                }
            }
            return true;
        }
    }

    private static boolean isOneNanp(String dialStr) {
        if (dialStr != null) {
            String newDialStr = dialStr.substring(NANP_STATE_DIGIT);
            if (dialStr.charAt(MIN_MATCH) == '1' && isNanp(newDialStr)) {
                return true;
            }
            return DBG;
        }
        Rlog.m15e("isOneNanp: null dialStr passed in", dialStr);
        return DBG;
    }

    public static boolean isUriNumber(String number) {
        return (number == null || !(number.contains("@") || number.contains("%40"))) ? DBG : true;
    }

    public static String getUsernameFromUriNumber(String number) {
        int delimiterIndex = number.indexOf(64);
        if (delimiterIndex < 0) {
            delimiterIndex = number.indexOf("%40");
        }
        if (delimiterIndex < 0) {
            Rlog.m21w(LOG_TAG, "getUsernameFromUriNumber: no delimiter found in SIP addr '" + number + "'");
            delimiterIndex = number.length();
        }
        return number.substring(MIN_MATCH, delimiterIndex);
    }

    private static String processPlusCode(String networkDialStr, boolean useNanp) {
        String retStr = networkDialStr;
        if (networkDialStr == null || networkDialStr.charAt(MIN_MATCH) != PLUS_SIGN_CHAR || networkDialStr.length() <= NANP_STATE_DIGIT) {
            return retStr;
        }
        String newStr = networkDialStr.substring(NANP_STATE_DIGIT);
        if (useNanp && isOneNanp(newStr)) {
            return newStr;
        }
        return networkDialStr.replaceFirst("[+]", getCurrentIdp(useNanp));
    }

    private static int findDialableIndexFromPostDialStr(String postDialStr) {
        for (int index = MIN_MATCH; index < postDialStr.length(); index += NANP_STATE_DIGIT) {
            if (isReallyDialable(postDialStr.charAt(index))) {
                return index;
            }
        }
        return -1;
    }

    private static String appendPwCharBackToOrigDialStr(int dialableIndex, String origStr, String dialStr) {
        if (dialableIndex == NANP_STATE_DIGIT) {
            return dialStr.charAt(MIN_MATCH);
        }
        return origStr.concat(dialStr.substring(MIN_MATCH, dialableIndex));
    }

    private static boolean matchIntlPrefix(String a, int len) {
        int state = MIN_MATCH;
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = a.charAt(i);
            switch (state) {
                case MIN_MATCH:
                    if (c != PLUS_SIGN_CHAR) {
                        if (c != '0') {
                            if (!isNonSeparator(c)) {
                                break;
                            }
                            return DBG;
                        }
                        state = NANP_STATE_PLUS;
                        break;
                    }
                    state = NANP_STATE_DIGIT;
                    break;
                case NANP_STATE_PLUS /*2*/:
                    if (c != '0') {
                        if (c != '1') {
                            if (!isNonSeparator(c)) {
                                break;
                            }
                            return DBG;
                        }
                        state = NANP_STATE_DASH;
                        break;
                    }
                    state = NANP_STATE_ONE;
                    break;
                case NANP_STATE_DASH /*4*/:
                    if (c != '1') {
                        if (!isNonSeparator(c)) {
                            break;
                        }
                        return DBG;
                    }
                    state = 5;
                    break;
                default:
                    if (!isNonSeparator(c)) {
                        break;
                    }
                    return DBG;
            }
        }
        if (state == NANP_STATE_DIGIT || state == NANP_STATE_ONE || state == 5) {
            return true;
        }
        return DBG;
    }

    private static boolean matchIntlPrefixAndCC(String a, int len) {
        int state = MIN_MATCH;
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = a.charAt(i);
            switch (state) {
                case MIN_MATCH:
                    if (c != PLUS_SIGN_CHAR) {
                        if (c != '0') {
                            if (!isNonSeparator(c)) {
                                break;
                            }
                            return DBG;
                        }
                        state = NANP_STATE_PLUS;
                        break;
                    }
                    state = NANP_STATE_DIGIT;
                    break;
                case NANP_STATE_DIGIT /*1*/:
                case NANP_STATE_ONE /*3*/:
                case ReflectionActionWithoutParams.TAG /*5*/:
                    if (!isISODigit(c)) {
                        if (!isNonSeparator(c)) {
                            break;
                        }
                        return DBG;
                    }
                    state = 6;
                    break;
                case NANP_STATE_PLUS /*2*/:
                    if (c != '0') {
                        if (c != '1') {
                            if (!isNonSeparator(c)) {
                                break;
                            }
                            return DBG;
                        }
                        state = NANP_STATE_DASH;
                        break;
                    }
                    state = NANP_STATE_ONE;
                    break;
                case NANP_STATE_DASH /*4*/:
                    if (c != '1') {
                        if (!isNonSeparator(c)) {
                            break;
                        }
                        return DBG;
                    }
                    state = 5;
                    break;
                case SetEmptyView.TAG /*6*/:
                case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                    if (!isISODigit(c)) {
                        if (!isNonSeparator(c)) {
                            break;
                        }
                        return DBG;
                    }
                    state += NANP_STATE_DIGIT;
                    break;
                default:
                    if (!isNonSeparator(c)) {
                        break;
                    }
                    return DBG;
            }
        }
        if (state == 6 || state == 7 || state == 8) {
            return true;
        }
        return DBG;
    }

    private static boolean matchTrunkPrefix(String a, int len) {
        boolean found = DBG;
        for (int i = MIN_MATCH; i < len; i += NANP_STATE_DIGIT) {
            char c = a.charAt(i);
            if (c == '0' && !found) {
                found = true;
            } else if (isNonSeparator(c)) {
                return DBG;
            }
        }
        return found;
    }

    private static boolean isCountryCallingCode(int countryCallingCodeCandidate) {
        return (countryCallingCodeCandidate <= 0 || countryCallingCodeCandidate >= CCC_LENGTH || !COUNTRY_CALLING_CALL[countryCallingCodeCandidate]) ? DBG : true;
    }

    private static int tryGetISODigit(char ch) {
        if ('0' > ch || ch > '9') {
            return -1;
        }
        return ch - 48;
    }

    private static CountryCallingCodeAndNewIndex tryGetCountryCallingCodeAndNewIndex(String str, boolean acceptThailandCase) {
        int state = MIN_MATCH;
        int ccc = MIN_MATCH;
        int length = str.length();
        for (int i = MIN_MATCH; i < length; i += NANP_STATE_DIGIT) {
            char ch = str.charAt(i);
            switch (state) {
                case MIN_MATCH:
                    if (ch != PLUS_SIGN_CHAR) {
                        if (ch != '0') {
                            if (ch != '1') {
                                if (!isDialable(ch)) {
                                    break;
                                }
                                return null;
                            } else if (acceptThailandCase) {
                                state = 8;
                                break;
                            } else {
                                return null;
                            }
                        }
                        state = NANP_STATE_PLUS;
                        break;
                    }
                    state = NANP_STATE_DIGIT;
                    break;
                case NANP_STATE_DIGIT /*1*/:
                case NANP_STATE_ONE /*3*/:
                case ReflectionActionWithoutParams.TAG /*5*/:
                case SetEmptyView.TAG /*6*/:
                case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                    int ret = tryGetISODigit(ch);
                    if (ret <= 0) {
                        if (!isDialable(ch)) {
                            break;
                        }
                        return null;
                    }
                    ccc = (ccc * NANP_LENGTH) + ret;
                    if (ccc < 100 && !isCountryCallingCode(ccc)) {
                        if (state != NANP_STATE_DIGIT && state != NANP_STATE_ONE && state != 5) {
                            state += NANP_STATE_DIGIT;
                            break;
                        }
                        state = 6;
                        break;
                    }
                    return new CountryCallingCodeAndNewIndex(ccc, i + NANP_STATE_DIGIT);
                    break;
                case NANP_STATE_PLUS /*2*/:
                    if (ch != '0') {
                        if (ch != '1') {
                            if (!isDialable(ch)) {
                                break;
                            }
                            return null;
                        }
                        state = NANP_STATE_DASH;
                        break;
                    }
                    state = NANP_STATE_ONE;
                    break;
                case NANP_STATE_DASH /*4*/:
                    if (ch != '1') {
                        if (!isDialable(ch)) {
                            break;
                        }
                        return null;
                    }
                    state = 5;
                    break;
                case SetPendingIntentTemplate.TAG /*8*/:
                    if (ch != '6') {
                        if (!isDialable(ch)) {
                            break;
                        }
                        return null;
                    }
                    state = 9;
                    break;
                case SetOnClickFillInIntent.TAG /*9*/:
                    if (ch == '6') {
                        return new CountryCallingCodeAndNewIndex(66, i + NANP_STATE_DIGIT);
                    }
                    return null;
                default:
                    return null;
            }
        }
        return null;
    }

    private static int tryGetTrunkPrefixOmittedIndex(String str, int currentIndex) {
        int length = str.length();
        for (int i = currentIndex; i < length; i += NANP_STATE_DIGIT) {
            char ch = str.charAt(i);
            if (tryGetISODigit(ch) >= 0) {
                return i + NANP_STATE_DIGIT;
            }
            if (isDialable(ch)) {
                return -1;
            }
        }
        return -1;
    }

    private static boolean checkPrefixIsIgnorable(String str, int forwardIndex, int backwardIndex) {
        boolean trunk_prefix_was_read = DBG;
        while (backwardIndex >= forwardIndex) {
            if (tryGetISODigit(str.charAt(backwardIndex)) >= 0) {
                if (trunk_prefix_was_read) {
                    return DBG;
                }
                trunk_prefix_was_read = true;
            } else if (isDialable(str.charAt(backwardIndex))) {
                return DBG;
            }
            backwardIndex--;
        }
        return true;
    }

    private static int getDefaultVoiceSubId() {
        return SubscriptionManager.getDefaultVoiceSubId();
    }
}
