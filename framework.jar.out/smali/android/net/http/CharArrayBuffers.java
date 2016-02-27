package android.net.http;

import android.text.format.DateFormat;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.CharArrayBuffer;

class CharArrayBuffers {
    static final char uppercaseAddon = ' ';

    CharArrayBuffers() {
    }

    static boolean containsIgnoreCaseTrimmed(CharArrayBuffer buffer, int beginIndex, String str) {
        boolean ok;
        int len = buffer.length();
        char[] chars = buffer.buffer();
        while (beginIndex < len && HTTP.isWhitespace(chars[beginIndex])) {
            beginIndex++;
        }
        int size = str.length();
        if (len >= beginIndex + size) {
            ok = true;
        } else {
            ok = false;
        }
        int j = 0;
        while (ok && j < size) {
            char a = chars[beginIndex + j];
            char b = str.charAt(j);
            if (a != b) {
                if (toLower(a) == toLower(b)) {
                    ok = true;
                } else {
                    ok = false;
                }
            }
            j++;
        }
        return ok;
    }

    static int setLowercaseIndexOf(CharArrayBuffer buffer, int ch) {
        int endIndex = buffer.length();
        char[] chars = buffer.buffer();
        for (int i = 0; i < endIndex; i++) {
            char current = chars[i];
            if (current == ch) {
                return i;
            }
            if (current >= DateFormat.CAPITAL_AM_PM && current <= 'Z') {
                chars[i] = (char) (current + 32);
            }
        }
        return -1;
    }

    private static char toLower(char c) {
        if (c < DateFormat.CAPITAL_AM_PM || c > 'Z') {
            return c;
        }
        return (char) (c + 32);
    }
}
