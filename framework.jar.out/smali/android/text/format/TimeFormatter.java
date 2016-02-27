package android.text.format;

import android.content.res.Resources;
import android.speech.tts.Voice;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.WindowManager.LayoutParams;
import java.nio.CharBuffer;
import java.util.Formatter;
import java.util.Locale;
import libcore.icu.LocaleData;
import libcore.util.ZoneInfo;
import libcore.util.ZoneInfo.WallTime;

class TimeFormatter {
    private static final int DAYSPERLYEAR = 366;
    private static final int DAYSPERNYEAR = 365;
    private static final int DAYSPERWEEK = 7;
    private static final int FORCE_LOWER_CASE = -1;
    private static final int HOURSPERDAY = 24;
    private static final int MINSPERHOUR = 60;
    private static final int MONSPERYEAR = 12;
    private static final int SECSPERMIN = 60;
    private static String sDateOnlyFormat;
    private static String sDateTimeFormat;
    private static Locale sLocale;
    private static LocaleData sLocaleData;
    private static String sTimeOnlyFormat;
    private final String dateOnlyFormat;
    private final String dateTimeFormat;
    private final LocaleData localeData;
    private Formatter numberFormatter;
    private StringBuilder outputBuilder;
    private final String timeOnlyFormat;

    public TimeFormatter() {
        synchronized (TimeFormatter.class) {
            Locale locale = Locale.getDefault();
            if (sLocale == null || !locale.equals(sLocale)) {
                sLocale = locale;
                sLocaleData = LocaleData.get(locale);
                Resources r = Resources.getSystem();
                sTimeOnlyFormat = r.getString(17039451);
                sDateOnlyFormat = r.getString(17039450);
                sDateTimeFormat = r.getString(17039452);
            }
            this.dateTimeFormat = sDateTimeFormat;
            this.timeOnlyFormat = sTimeOnlyFormat;
            this.dateOnlyFormat = sDateOnlyFormat;
            this.localeData = sLocaleData;
        }
    }

    public String format(String pattern, WallTime wallTime, ZoneInfo zoneInfo) {
        try {
            StringBuilder stringBuilder = new StringBuilder();
            this.outputBuilder = stringBuilder;
            this.numberFormatter = new Formatter(stringBuilder, Locale.US);
            formatInternal(pattern, wallTime, zoneInfo);
            String result = stringBuilder.toString();
            if (this.localeData.zeroDigit != '0') {
                result = localizeDigits(result);
            }
            this.outputBuilder = null;
            this.numberFormatter = null;
            return result;
        } catch (Throwable th) {
            this.outputBuilder = null;
            this.numberFormatter = null;
        }
    }

    private String localizeDigits(String s) {
        int length = s.length();
        int offsetToLocalizedDigits = this.localeData.zeroDigit - 48;
        StringBuilder result = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            char ch = s.charAt(i);
            if (ch >= '0' && ch <= '9') {
                ch = (char) (ch + offsetToLocalizedDigits);
            }
            result.append(ch);
        }
        return result.toString();
    }

    private void formatInternal(String pattern, WallTime wallTime, ZoneInfo zoneInfo) {
        CharBuffer formatBuffer = CharBuffer.wrap(pattern);
        while (formatBuffer.remaining() > 0) {
            boolean outputCurrentChar = true;
            if (formatBuffer.get(formatBuffer.position()) == '%') {
                outputCurrentChar = handleToken(formatBuffer, wallTime, zoneInfo);
            }
            if (outputCurrentChar) {
                this.outputBuilder.append(formatBuffer.get(formatBuffer.position()));
            }
            formatBuffer.position(formatBuffer.position() + 1);
        }
    }

    private boolean handleToken(CharBuffer formatBuffer, WallTime wallTime, ZoneInfo zoneInfo) {
        int modifier = 0;
        while (formatBuffer.remaining() > 1) {
            formatBuffer.position(formatBuffer.position() + 1);
            char currentChar = formatBuffer.get(formatBuffer.position());
            String str;
            switch (currentChar) {
                case MotionEvent.AXIS_GENERIC_4 /*35*/:
                case MotionEvent.AXIS_GENERIC_14 /*45*/:
                case LayoutParams.SOFT_INPUT_ADJUST_NOTHING /*48*/:
                case KeyEvent.KEYCODE_PICTSYMBOLS /*94*/:
                case KeyEvent.KEYCODE_SWITCH_CHARSET /*95*/:
                    modifier = currentChar;
                    break;
                case MotionEvent.AXIS_GENERIC_12 /*43*/:
                    formatInternal("%a %b %e %H:%M:%S %Z %Y", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_ENVELOPE /*65*/:
                    str = (wallTime.getWeekDay() < 0 || wallTime.getWeekDay() >= DAYSPERWEEK) ? "?" : this.localeData.longWeekdayNames[wallTime.getWeekDay() + 1];
                    modifyAndAppend(str, modifier);
                    return false;
                case KeyEvent.KEYCODE_ENTER /*66*/:
                    if (modifier == 45) {
                        if (wallTime.getMonth() < 0 || wallTime.getMonth() >= MONSPERYEAR) {
                            str = "?";
                        } else {
                            str = this.localeData.longStandAloneMonthNames[wallTime.getMonth()];
                        }
                        modifyAndAppend(str, modifier);
                    } else {
                        str = (wallTime.getMonth() < 0 || wallTime.getMonth() >= MONSPERYEAR) ? "?" : this.localeData.longMonthNames[wallTime.getMonth()];
                        modifyAndAppend(str, modifier);
                    }
                    return false;
                case KeyEvent.KEYCODE_DEL /*67*/:
                    outputYear(wallTime.getYear(), true, false, modifier);
                    return false;
                case KeyEvent.KEYCODE_GRAVE /*68*/:
                    formatInternal("%m/%d/%y", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_MINUS /*69*/:
                case KeyEvent.KEYCODE_HEADSETHOOK /*79*/:
                    break;
                case KeyEvent.KEYCODE_EQUALS /*70*/:
                    formatInternal("%Y-%m-%d", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_LEFT_BRACKET /*71*/:
                case KeyEvent.KEYCODE_MEDIA_STOP /*86*/:
                case KeyEvent.KEYCODE_BUTTON_R1 /*103*/:
                    int year = wallTime.getYear();
                    int yday = wallTime.getYearDay();
                    int wday = wallTime.getWeekDay();
                    while (true) {
                        int w;
                        int len = isLeap(year) ? DAYSPERLYEAR : DAYSPERNYEAR;
                        int bot = (((yday + 11) - wday) % DAYSPERWEEK) - 3;
                        int top = bot - (len % DAYSPERWEEK);
                        if (top < -3) {
                            top += DAYSPERWEEK;
                        }
                        if (yday >= top + len) {
                            year++;
                            w = 1;
                        } else if (yday >= bot) {
                            w = ((yday - bot) / DAYSPERWEEK) + 1;
                        } else {
                            year += FORCE_LOWER_CASE;
                            yday += isLeap(year) ? DAYSPERLYEAR : DAYSPERNYEAR;
                        }
                        if (currentChar == 'V') {
                            this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(w)});
                        } else if (currentChar == 'g') {
                            outputYear(year, false, true, modifier);
                        } else {
                            outputYear(year, true, true, modifier);
                        }
                        return false;
                    }
                case KeyEvent.KEYCODE_RIGHT_BRACKET /*72*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getHour())});
                    return false;
                case KeyEvent.KEYCODE_BACKSLASH /*73*/:
                    int hour = wallTime.getHour() % MONSPERYEAR != 0 ? wallTime.getHour() % MONSPERYEAR : MONSPERYEAR;
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(hour)});
                    return false;
                case KeyEvent.KEYCODE_AT /*77*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getMinute())});
                    return false;
                case KeyEvent.KEYCODE_FOCUS /*80*/:
                    modifyAndAppend(wallTime.getHour() >= MONSPERYEAR ? this.localeData.amPm[1] : this.localeData.amPm[0], FORCE_LOWER_CASE);
                    return false;
                case KeyEvent.KEYCODE_MENU /*82*/:
                    formatInternal(DateUtils.HOUR_MINUTE_24, wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_NOTIFICATION /*83*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getSecond())});
                    return false;
                case KeyEvent.MAX_KEYCODE /*84*/:
                    formatInternal("%H:%M:%S", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE /*85*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(((wallTime.getYearDay() + DAYSPERWEEK) - wallTime.getWeekDay()) / DAYSPERWEEK)});
                    return false;
                case KeyEvent.KEYCODE_MEDIA_NEXT /*87*/:
                    int n = ((wallTime.getYearDay() + DAYSPERWEEK) - (wallTime.getWeekDay() != 0 ? wallTime.getWeekDay() + FORCE_LOWER_CASE : 6)) / DAYSPERWEEK;
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(n)});
                    return false;
                case KeyEvent.KEYCODE_MEDIA_PREVIOUS /*88*/:
                    formatInternal(this.timeOnlyFormat, wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_MEDIA_REWIND /*89*/:
                    outputYear(wallTime.getYear(), true, true, modifier);
                    return false;
                case KeyEvent.KEYCODE_MEDIA_FAST_FORWARD /*90*/:
                    if (wallTime.getIsDst() < 0) {
                        return false;
                    }
                    modifyAndAppend(zoneInfo.getDisplayName(wallTime.getIsDst() != 0, 0), modifier);
                    return false;
                case KeyEvent.KEYCODE_BUTTON_B /*97*/:
                    str = (wallTime.getWeekDay() < 0 || wallTime.getWeekDay() >= DAYSPERWEEK) ? "?" : this.localeData.shortWeekdayNames[wallTime.getWeekDay() + 1];
                    modifyAndAppend(str, modifier);
                    return false;
                case KeyEvent.KEYCODE_BUTTON_C /*98*/:
                case KeyEvent.KEYCODE_BUTTON_L2 /*104*/:
                    str = (wallTime.getMonth() < 0 || wallTime.getMonth() >= MONSPERYEAR) ? "?" : this.localeData.shortMonthNames[wallTime.getMonth()];
                    modifyAndAppend(str, modifier);
                    return false;
                case LayoutParams.LAST_APPLICATION_WINDOW /*99*/:
                    formatInternal(this.dateTimeFormat, wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_BUTTON_Y /*100*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getMonthDay())});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_Z /*101*/:
                    this.numberFormatter.format(getFormat(modifier, "%2d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getMonthDay())});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_THUMBL /*106*/:
                    int yearDay = wallTime.getYearDay() + 1;
                    this.numberFormatter.format(getFormat(modifier, "%03d", "%3d", "%d", "%03d"), new Object[]{Integer.valueOf(yearDay)});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_THUMBR /*107*/:
                    this.numberFormatter.format(getFormat(modifier, "%2d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getHour())});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_START /*108*/:
                    int n2 = wallTime.getHour() % MONSPERYEAR != 0 ? wallTime.getHour() % MONSPERYEAR : MONSPERYEAR;
                    this.numberFormatter.format(getFormat(modifier, "%2d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(n2)});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_SELECT /*109*/:
                    this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(wallTime.getMonth() + 1)});
                    return false;
                case KeyEvent.KEYCODE_BUTTON_MODE /*110*/:
                    this.outputBuilder.append('\n');
                    return false;
                case KeyEvent.KEYCODE_FORWARD_DEL /*112*/:
                    modifyAndAppend(wallTime.getHour() >= MONSPERYEAR ? this.localeData.amPm[1] : this.localeData.amPm[0], modifier);
                    return false;
                case KeyEvent.KEYCODE_CTRL_RIGHT /*114*/:
                    formatInternal("%I:%M:%S %p", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_CAPS_LOCK /*115*/:
                    this.outputBuilder.append(Integer.toString(wallTime.mktime(zoneInfo)));
                    return false;
                case KeyEvent.KEYCODE_SCROLL_LOCK /*116*/:
                    this.outputBuilder.append('\t');
                    return false;
                case KeyEvent.KEYCODE_META_LEFT /*117*/:
                    int day = wallTime.getWeekDay() == 0 ? DAYSPERWEEK : wallTime.getWeekDay();
                    this.numberFormatter.format("%d", new Object[]{Integer.valueOf(day)});
                    return false;
                case KeyEvent.KEYCODE_META_RIGHT /*118*/:
                    formatInternal("%e-%b-%Y", wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_FUNCTION /*119*/:
                    this.numberFormatter.format("%d", new Object[]{Integer.valueOf(wallTime.getWeekDay())});
                    return false;
                case KeyEvent.KEYCODE_SYSRQ /*120*/:
                    formatInternal(this.dateOnlyFormat, wallTime, zoneInfo);
                    return false;
                case KeyEvent.KEYCODE_BREAK /*121*/:
                    outputYear(wallTime.getYear(), false, true, modifier);
                    return false;
                case KeyEvent.KEYCODE_MOVE_HOME /*122*/:
                    if (wallTime.getIsDst() < 0) {
                        return false;
                    }
                    char sign;
                    int diff = wallTime.getGmtOffset();
                    if (diff < 0) {
                        sign = '-';
                        diff = -diff;
                    } else {
                        sign = '+';
                    }
                    this.outputBuilder.append(sign);
                    diff /= SECSPERMIN;
                    diff = ((diff / SECSPERMIN) * 100) + (diff % SECSPERMIN);
                    this.numberFormatter.format(getFormat(modifier, "%04d", "%4d", "%d", "%04d"), new Object[]{Integer.valueOf(diff)});
                    return false;
                default:
                    return true;
            }
        }
        return true;
    }

    private void modifyAndAppend(CharSequence str, int modifier) {
        int i;
        switch (modifier) {
            case FORCE_LOWER_CASE /*-1*/:
                for (i = 0; i < str.length(); i++) {
                    this.outputBuilder.append(brokenToLower(str.charAt(i)));
                }
            case MotionEvent.AXIS_GENERIC_4 /*35*/:
                for (i = 0; i < str.length(); i++) {
                    char c = str.charAt(i);
                    if (brokenIsUpper(c)) {
                        c = brokenToLower(c);
                    } else if (brokenIsLower(c)) {
                        c = brokenToUpper(c);
                    }
                    this.outputBuilder.append(c);
                }
            case KeyEvent.KEYCODE_PICTSYMBOLS /*94*/:
                for (i = 0; i < str.length(); i++) {
                    this.outputBuilder.append(brokenToUpper(str.charAt(i)));
                }
            default:
                this.outputBuilder.append(str);
        }
    }

    private void outputYear(int value, boolean outputTop, boolean outputBottom, int modifier) {
        int trail = value % 100;
        int lead = (value / 100) + (trail / 100);
        trail %= 100;
        if (trail < 0 && lead > 0) {
            trail += 100;
            lead += FORCE_LOWER_CASE;
        } else if (lead < 0 && trail > 0) {
            trail -= 100;
            lead++;
        }
        if (outputTop) {
            if (lead != 0 || trail >= 0) {
                this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(lead)});
            } else {
                this.outputBuilder.append("-0");
            }
        }
        if (outputBottom) {
            int n;
            if (trail < 0) {
                n = -trail;
            } else {
                n = trail;
            }
            this.numberFormatter.format(getFormat(modifier, "%02d", "%2d", "%d", "%02d"), new Object[]{Integer.valueOf(n)});
        }
    }

    private static String getFormat(int modifier, String normal, String underscore, String dash, String zero) {
        switch (modifier) {
            case MotionEvent.AXIS_GENERIC_14 /*45*/:
                return dash;
            case LayoutParams.SOFT_INPUT_ADJUST_NOTHING /*48*/:
                return zero;
            case KeyEvent.KEYCODE_SWITCH_CHARSET /*95*/:
                return underscore;
            default:
                return normal;
        }
    }

    private static boolean isLeap(int year) {
        return year % 4 == 0 && (year % 100 != 0 || year % Voice.QUALITY_HIGH == 0);
    }

    private static boolean brokenIsUpper(char toCheck) {
        return toCheck >= DateFormat.CAPITAL_AM_PM && toCheck <= 'Z';
    }

    private static boolean brokenIsLower(char toCheck) {
        return toCheck >= DateFormat.AM_PM && toCheck <= DateFormat.TIME_ZONE;
    }

    private static char brokenToLower(char input) {
        if (input < DateFormat.CAPITAL_AM_PM || input > 'Z') {
            return input;
        }
        return (char) ((input - 65) + 97);
    }

    private static char brokenToUpper(char input) {
        if (input < DateFormat.AM_PM || input > DateFormat.TIME_ZONE) {
            return input;
        }
        return (char) ((input - 97) + 65);
    }
}
