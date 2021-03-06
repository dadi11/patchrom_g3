package android.net;

import android.text.format.DateFormat;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.StringTokenizer;

public class UrlQuerySanitizer {
    private static final ValueSanitizer sAllButNulAndAngleBracketsLegal;
    private static final ValueSanitizer sAllButNulLegal;
    private static final ValueSanitizer sAllButWhitespaceLegal;
    private static final ValueSanitizer sAllIllegal;
    private static final ValueSanitizer sAmpAndSpaceLegal;
    private static final ValueSanitizer sAmpLegal;
    private static final ValueSanitizer sSpaceLegal;
    private static final ValueSanitizer sURLLegal;
    private static final ValueSanitizer sUrlAndSpaceLegal;
    private boolean mAllowUnregisteredParamaters;
    private final HashMap<String, String> mEntries;
    private final ArrayList<ParameterValuePair> mEntriesList;
    private boolean mPreferFirstRepeatedParameter;
    private final HashMap<String, ValueSanitizer> mSanitizers;
    private ValueSanitizer mUnregisteredParameterValueSanitizer;

    public interface ValueSanitizer {
        String sanitize(String str);
    }

    public static class IllegalCharacterValueSanitizer implements ValueSanitizer {
        public static final int ALL_BUT_NUL_AND_ANGLE_BRACKETS_LEGAL = 1439;
        public static final int ALL_BUT_NUL_LEGAL = 1535;
        public static final int ALL_BUT_WHITESPACE_LEGAL = 1532;
        public static final int ALL_ILLEGAL = 0;
        public static final int ALL_OK = 2047;
        public static final int ALL_WHITESPACE_OK = 3;
        public static final int AMP_AND_SPACE_LEGAL = 129;
        public static final int AMP_LEGAL = 128;
        public static final int AMP_OK = 128;
        public static final int DQUOTE_OK = 8;
        public static final int GT_OK = 64;
        private static final String JAVASCRIPT_PREFIX = "javascript:";
        public static final int LT_OK = 32;
        private static final int MIN_SCRIPT_PREFIX_LENGTH;
        public static final int NON_7_BIT_ASCII_OK = 4;
        public static final int NUL_OK = 512;
        public static final int OTHER_WHITESPACE_OK = 2;
        public static final int PCT_OK = 256;
        public static final int SCRIPT_URL_OK = 1024;
        public static final int SPACE_LEGAL = 1;
        public static final int SPACE_OK = 1;
        public static final int SQUOTE_OK = 16;
        public static final int URL_AND_SPACE_LEGAL = 405;
        public static final int URL_LEGAL = 404;
        private static final String VBSCRIPT_PREFIX = "vbscript:";
        private int mFlags;

        static {
            MIN_SCRIPT_PREFIX_LENGTH = Math.min(JAVASCRIPT_PREFIX.length(), VBSCRIPT_PREFIX.length());
        }

        public IllegalCharacterValueSanitizer(int flags) {
            this.mFlags = flags;
        }

        public String sanitize(String value) {
            if (value == null) {
                return null;
            }
            int length = value.length();
            if ((this.mFlags & SCRIPT_URL_OK) != 0 && length >= MIN_SCRIPT_PREFIX_LENGTH) {
                String asLower = value.toLowerCase(Locale.ROOT);
                if (asLower.startsWith(JAVASCRIPT_PREFIX) || asLower.startsWith(VBSCRIPT_PREFIX)) {
                    return ProxyInfo.LOCAL_EXCL_LIST;
                }
            }
            if ((this.mFlags & ALL_WHITESPACE_OK) == 0) {
                value = trimWhitespace(value);
                length = value.length();
            }
            StringBuilder stringBuilder = new StringBuilder(length);
            for (int i = MIN_SCRIPT_PREFIX_LENGTH; i < length; i += SPACE_OK) {
                char c = value.charAt(i);
                if (!characterIsLegal(c)) {
                    if ((this.mFlags & SPACE_OK) != 0) {
                        c = ' ';
                    } else {
                        c = '_';
                    }
                }
                stringBuilder.append(c);
            }
            return stringBuilder.toString();
        }

        private String trimWhitespace(String value) {
            int start = MIN_SCRIPT_PREFIX_LENGTH;
            int last = value.length() - 1;
            int end = last;
            while (start <= end && isWhitespace(value.charAt(start))) {
                start += SPACE_OK;
            }
            while (end >= start && isWhitespace(value.charAt(end))) {
                end--;
            }
            return (start == 0 && end == last) ? value : value.substring(start, end + SPACE_OK);
        }

        private boolean isWhitespace(char c) {
            switch (c) {
                case SetOnClickFillInIntent.TAG /*9*/:
                case SetRemoteViewsAdapterIntent.TAG /*10*/:
                case TextViewDrawableAction.TAG /*11*/:
                case BitmapReflectionAction.TAG /*12*/:
                case TextViewSizeAction.TAG /*13*/:
                case LT_OK /*32*/:
                    return true;
                default:
                    return false;
            }
        }

        private boolean characterIsLegal(char c) {
            switch (c) {
                case MIN_SCRIPT_PREFIX_LENGTH:
                    if ((this.mFlags & NUL_OK) == 0) {
                        return false;
                    }
                    return true;
                case SetOnClickFillInIntent.TAG /*9*/:
                case SetRemoteViewsAdapterIntent.TAG /*10*/:
                case TextViewDrawableAction.TAG /*11*/:
                case BitmapReflectionAction.TAG /*12*/:
                case TextViewSizeAction.TAG /*13*/:
                    if ((this.mFlags & OTHER_WHITESPACE_OK) == 0) {
                        return false;
                    }
                    return true;
                case LT_OK /*32*/:
                    if ((this.mFlags & SPACE_OK) == 0) {
                        return false;
                    }
                    return true;
                case MotionEvent.AXIS_GENERIC_3 /*34*/:
                    if ((this.mFlags & DQUOTE_OK) == 0) {
                        return false;
                    }
                    return true;
                case MotionEvent.AXIS_GENERIC_6 /*37*/:
                    if ((this.mFlags & PCT_OK) == 0) {
                        return false;
                    }
                    return true;
                case MotionEvent.AXIS_GENERIC_7 /*38*/:
                    if ((this.mFlags & AMP_OK) == 0) {
                        return false;
                    }
                    return true;
                case MotionEvent.AXIS_GENERIC_8 /*39*/:
                    if ((this.mFlags & SQUOTE_OK) == 0) {
                        return false;
                    }
                    return true;
                case KeyEvent.KEYCODE_SHIFT_RIGHT /*60*/:
                    if ((this.mFlags & LT_OK) == 0) {
                        return false;
                    }
                    return true;
                case KeyEvent.KEYCODE_SPACE /*62*/:
                    if ((this.mFlags & GT_OK) == 0) {
                        return false;
                    }
                    return true;
                default:
                    if (c >= ' ' && c < '\u007f') {
                        return true;
                    }
                    if (c < '\u0080' || (this.mFlags & NON_7_BIT_ASCII_OK) == 0) {
                        return false;
                    }
                    return true;
            }
        }
    }

    public class ParameterValuePair {
        public String mParameter;
        public String mValue;

        public ParameterValuePair(String parameter, String value) {
            this.mParameter = parameter;
            this.mValue = value;
        }
    }

    public ValueSanitizer getUnregisteredParameterValueSanitizer() {
        return this.mUnregisteredParameterValueSanitizer;
    }

    public void setUnregisteredParameterValueSanitizer(ValueSanitizer sanitizer) {
        this.mUnregisteredParameterValueSanitizer = sanitizer;
    }

    static {
        sAllIllegal = new IllegalCharacterValueSanitizer(0);
        sAllButNulLegal = new IllegalCharacterValueSanitizer(IllegalCharacterValueSanitizer.ALL_BUT_NUL_LEGAL);
        sAllButWhitespaceLegal = new IllegalCharacterValueSanitizer(IllegalCharacterValueSanitizer.ALL_BUT_WHITESPACE_LEGAL);
        sURLLegal = new IllegalCharacterValueSanitizer(IllegalCharacterValueSanitizer.URL_LEGAL);
        sUrlAndSpaceLegal = new IllegalCharacterValueSanitizer(IllegalCharacterValueSanitizer.URL_AND_SPACE_LEGAL);
        sAmpLegal = new IllegalCharacterValueSanitizer(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        sAmpAndSpaceLegal = new IllegalCharacterValueSanitizer(KeyEvent.KEYCODE_MEDIA_EJECT);
        sSpaceLegal = new IllegalCharacterValueSanitizer(1);
        sAllButNulAndAngleBracketsLegal = new IllegalCharacterValueSanitizer(IllegalCharacterValueSanitizer.ALL_BUT_NUL_AND_ANGLE_BRACKETS_LEGAL);
    }

    public static final ValueSanitizer getAllIllegal() {
        return sAllIllegal;
    }

    public static final ValueSanitizer getAllButNulLegal() {
        return sAllButNulLegal;
    }

    public static final ValueSanitizer getAllButWhitespaceLegal() {
        return sAllButWhitespaceLegal;
    }

    public static final ValueSanitizer getUrlLegal() {
        return sURLLegal;
    }

    public static final ValueSanitizer getUrlAndSpaceLegal() {
        return sUrlAndSpaceLegal;
    }

    public static final ValueSanitizer getAmpLegal() {
        return sAmpLegal;
    }

    public static final ValueSanitizer getAmpAndSpaceLegal() {
        return sAmpAndSpaceLegal;
    }

    public static final ValueSanitizer getSpaceLegal() {
        return sSpaceLegal;
    }

    public static final ValueSanitizer getAllButNulAndAngleBracketsLegal() {
        return sAllButNulAndAngleBracketsLegal;
    }

    public UrlQuerySanitizer() {
        this.mSanitizers = new HashMap();
        this.mEntries = new HashMap();
        this.mEntriesList = new ArrayList();
        this.mUnregisteredParameterValueSanitizer = getAllIllegal();
    }

    public UrlQuerySanitizer(String url) {
        this.mSanitizers = new HashMap();
        this.mEntries = new HashMap();
        this.mEntriesList = new ArrayList();
        this.mUnregisteredParameterValueSanitizer = getAllIllegal();
        setAllowUnregisteredParamaters(true);
        parseUrl(url);
    }

    public void parseUrl(String url) {
        String query;
        int queryIndex = url.indexOf(63);
        if (queryIndex >= 0) {
            query = url.substring(queryIndex + 1);
        } else {
            query = ProxyInfo.LOCAL_EXCL_LIST;
        }
        parseQuery(query);
    }

    public void parseQuery(String query) {
        clear();
        StringTokenizer tokenizer = new StringTokenizer(query, "&");
        while (tokenizer.hasMoreElements()) {
            String attributeValuePair = tokenizer.nextToken();
            if (attributeValuePair.length() > 0) {
                int assignmentIndex = attributeValuePair.indexOf(61);
                if (assignmentIndex < 0) {
                    parseEntry(attributeValuePair, ProxyInfo.LOCAL_EXCL_LIST);
                } else {
                    parseEntry(attributeValuePair.substring(0, assignmentIndex), attributeValuePair.substring(assignmentIndex + 1));
                }
            }
        }
    }

    public Set<String> getParameterSet() {
        return this.mEntries.keySet();
    }

    public List<ParameterValuePair> getParameterList() {
        return this.mEntriesList;
    }

    public boolean hasParameter(String parameter) {
        return this.mEntries.containsKey(parameter);
    }

    public String getValue(String parameter) {
        return (String) this.mEntries.get(parameter);
    }

    public void registerParameter(String parameter, ValueSanitizer valueSanitizer) {
        if (valueSanitizer == null) {
            this.mSanitizers.remove(parameter);
        }
        this.mSanitizers.put(parameter, valueSanitizer);
    }

    public void registerParameters(String[] parameters, ValueSanitizer valueSanitizer) {
        for (Object put : parameters) {
            this.mSanitizers.put(put, valueSanitizer);
        }
    }

    public void setAllowUnregisteredParamaters(boolean allowUnregisteredParamaters) {
        this.mAllowUnregisteredParamaters = allowUnregisteredParamaters;
    }

    public boolean getAllowUnregisteredParamaters() {
        return this.mAllowUnregisteredParamaters;
    }

    public void setPreferFirstRepeatedParameter(boolean preferFirstRepeatedParameter) {
        this.mPreferFirstRepeatedParameter = preferFirstRepeatedParameter;
    }

    public boolean getPreferFirstRepeatedParameter() {
        return this.mPreferFirstRepeatedParameter;
    }

    protected void parseEntry(String parameter, String value) {
        String unescapedParameter = unescape(parameter);
        ValueSanitizer valueSanitizer = getEffectiveValueSanitizer(unescapedParameter);
        if (valueSanitizer != null) {
            addSanitizedEntry(unescapedParameter, valueSanitizer.sanitize(unescape(value)));
        }
    }

    protected void addSanitizedEntry(String parameter, String value) {
        this.mEntriesList.add(new ParameterValuePair(parameter, value));
        if (!this.mPreferFirstRepeatedParameter || !this.mEntries.containsKey(parameter)) {
            this.mEntries.put(parameter, value);
        }
    }

    public ValueSanitizer getValueSanitizer(String parameter) {
        return (ValueSanitizer) this.mSanitizers.get(parameter);
    }

    public ValueSanitizer getEffectiveValueSanitizer(String parameter) {
        ValueSanitizer sanitizer = getValueSanitizer(parameter);
        if (sanitizer == null && this.mAllowUnregisteredParamaters) {
            return getUnregisteredParameterValueSanitizer();
        }
        return sanitizer;
    }

    public String unescape(String string) {
        int firstEscape = string.indexOf(37);
        if (firstEscape < 0) {
            firstEscape = string.indexOf(43);
            if (firstEscape < 0) {
                return string;
            }
        }
        int length = string.length();
        StringBuilder stringBuilder = new StringBuilder(length);
        stringBuilder.append(string.substring(0, firstEscape));
        int i = firstEscape;
        while (i < length) {
            char c = string.charAt(i);
            if (c == '+') {
                c = ' ';
            } else if (c == '%' && i + 2 < length) {
                char c1 = string.charAt(i + 1);
                char c2 = string.charAt(i + 2);
                if (isHexDigit(c1) && isHexDigit(c2)) {
                    c = (char) ((decodeHexDigit(c1) * 16) + decodeHexDigit(c2));
                    i += 2;
                }
            }
            stringBuilder.append(c);
            i++;
        }
        return stringBuilder.toString();
    }

    protected boolean isHexDigit(char c) {
        return decodeHexDigit(c) >= 0;
    }

    protected int decodeHexDigit(char c) {
        if (c >= '0' && c <= '9') {
            return c - 48;
        }
        if (c >= DateFormat.CAPITAL_AM_PM && c <= 'F') {
            return (c - 65) + 10;
        }
        if (c < DateFormat.AM_PM || c > 'f') {
            return -1;
        }
        return (c - 97) + 10;
    }

    protected void clear() {
        this.mEntries.clear();
        this.mEntriesList.clear();
    }
}
