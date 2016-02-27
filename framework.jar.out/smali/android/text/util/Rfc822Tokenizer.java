package android.text.util;

import android.telephony.PhoneNumberUtils;
import android.widget.MultiAutoCompleteTextView.Tokenizer;
import java.util.ArrayList;
import java.util.Collection;

public class Rfc822Tokenizer implements Tokenizer {
    public static void tokenize(CharSequence text, Collection<Rfc822Token> out) {
        StringBuilder name = new StringBuilder();
        StringBuilder address = new StringBuilder();
        StringBuilder comment = new StringBuilder();
        int i = 0;
        int cursor = text.length();
        while (i < cursor) {
            char c = text.charAt(i);
            if (c == PhoneNumberUtils.PAUSE || c == PhoneNumberUtils.WAIT) {
                i++;
                while (i < cursor && text.charAt(i) == ' ') {
                    i++;
                }
                crunch(name);
                if (address.length() > 0) {
                    out.add(new Rfc822Token(name.toString(), address.toString(), comment.toString()));
                } else if (name.length() > 0) {
                    out.add(new Rfc822Token(null, name.toString(), comment.toString()));
                }
                name.setLength(0);
                address.setLength(0);
                comment.setLength(0);
            } else if (c == '\"') {
                i++;
                while (i < cursor) {
                    c = text.charAt(i);
                    if (c == '\"') {
                        i++;
                        break;
                    } else if (c == '\\') {
                        if (i + 1 < cursor) {
                            name.append(text.charAt(i + 1));
                        }
                        i += 2;
                    } else {
                        name.append(c);
                        i++;
                    }
                }
            } else if (c == '(') {
                int level = 1;
                i++;
                while (i < cursor && level > 0) {
                    c = text.charAt(i);
                    if (c == ')') {
                        if (level > 1) {
                            comment.append(c);
                        }
                        level--;
                        i++;
                    } else if (c == '(') {
                        comment.append(c);
                        level++;
                        i++;
                    } else if (c == '\\') {
                        if (i + 1 < cursor) {
                            comment.append(text.charAt(i + 1));
                        }
                        i += 2;
                    } else {
                        comment.append(c);
                        i++;
                    }
                }
            } else if (c == '<') {
                i++;
                while (i < cursor) {
                    c = text.charAt(i);
                    if (c == '>') {
                        i++;
                        break;
                    } else {
                        address.append(c);
                        i++;
                    }
                }
            } else if (c == ' ') {
                name.append('\u0000');
                i++;
            } else {
                name.append(c);
                i++;
            }
        }
        crunch(name);
        if (address.length() > 0) {
            out.add(new Rfc822Token(name.toString(), address.toString(), comment.toString()));
        } else if (name.length() > 0) {
            out.add(new Rfc822Token(null, name.toString(), comment.toString()));
        }
    }

    public static Rfc822Token[] tokenize(CharSequence text) {
        ArrayList<Rfc822Token> out = new ArrayList();
        tokenize(text, out);
        return (Rfc822Token[]) out.toArray(new Rfc822Token[out.size()]);
    }

    private static void crunch(StringBuilder sb) {
        int i = 0;
        int len = sb.length();
        while (i < len) {
            if (sb.charAt(i) != '\u0000') {
                i++;
            } else if (i == 0 || i == len - 1 || sb.charAt(i - 1) == ' ' || sb.charAt(i - 1) == '\u0000' || sb.charAt(i + 1) == ' ' || sb.charAt(i + 1) == '\u0000') {
                sb.deleteCharAt(i);
                len--;
            } else {
                i++;
            }
        }
        for (i = 0; i < len; i++) {
            if (sb.charAt(i) == '\u0000') {
                sb.setCharAt(i, ' ');
            }
        }
    }

    public int findTokenStart(CharSequence text, int cursor) {
        int best = 0;
        int i = 0;
        while (i < cursor) {
            i = findTokenEnd(text, i);
            if (i < cursor) {
                i++;
                while (i < cursor && text.charAt(i) == ' ') {
                    i++;
                }
                if (i < cursor) {
                    best = i;
                }
            }
        }
        return best;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public int findTokenEnd(java.lang.CharSequence r9, int r10) {
        /*
        r8 = this;
        r7 = 92;
        r6 = 40;
        r5 = 34;
        r2 = r9.length();
        r1 = r10;
    L_0x000b:
        if (r1 >= r2) goto L_0x0019;
    L_0x000d:
        r0 = r9.charAt(r1);
        r4 = 44;
        if (r0 == r4) goto L_0x0019;
    L_0x0015:
        r4 = 59;
        if (r0 != r4) goto L_0x001a;
    L_0x0019:
        return r1;
    L_0x001a:
        if (r0 != r5) goto L_0x0035;
    L_0x001c:
        r1 = r1 + 1;
    L_0x001e:
        if (r1 >= r2) goto L_0x000b;
    L_0x0020:
        r0 = r9.charAt(r1);
        if (r0 != r5) goto L_0x0029;
    L_0x0026:
        r1 = r1 + 1;
        goto L_0x000b;
    L_0x0029:
        if (r0 != r7) goto L_0x0032;
    L_0x002b:
        r4 = r1 + 1;
        if (r4 >= r2) goto L_0x0032;
    L_0x002f:
        r1 = r1 + 2;
        goto L_0x001e;
    L_0x0032:
        r1 = r1 + 1;
        goto L_0x001e;
    L_0x0035:
        if (r0 != r6) goto L_0x005e;
    L_0x0037:
        r3 = 1;
        r1 = r1 + 1;
    L_0x003a:
        if (r1 >= r2) goto L_0x000b;
    L_0x003c:
        if (r3 <= 0) goto L_0x000b;
    L_0x003e:
        r0 = r9.charAt(r1);
        r4 = 41;
        if (r0 != r4) goto L_0x004b;
    L_0x0046:
        r3 = r3 + -1;
        r1 = r1 + 1;
        goto L_0x003a;
    L_0x004b:
        if (r0 != r6) goto L_0x0052;
    L_0x004d:
        r3 = r3 + 1;
        r1 = r1 + 1;
        goto L_0x003a;
    L_0x0052:
        if (r0 != r7) goto L_0x005b;
    L_0x0054:
        r4 = r1 + 1;
        if (r4 >= r2) goto L_0x005b;
    L_0x0058:
        r1 = r1 + 2;
        goto L_0x003a;
    L_0x005b:
        r1 = r1 + 1;
        goto L_0x003a;
    L_0x005e:
        r4 = 60;
        if (r0 != r4) goto L_0x0074;
    L_0x0062:
        r1 = r1 + 1;
    L_0x0064:
        if (r1 >= r2) goto L_0x000b;
    L_0x0066:
        r0 = r9.charAt(r1);
        r4 = 62;
        if (r0 != r4) goto L_0x0071;
    L_0x006e:
        r1 = r1 + 1;
        goto L_0x000b;
    L_0x0071:
        r1 = r1 + 1;
        goto L_0x0064;
    L_0x0074:
        r1 = r1 + 1;
        goto L_0x000b;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.text.util.Rfc822Tokenizer.findTokenEnd(java.lang.CharSequence, int):int");
    }

    public CharSequence terminateToken(CharSequence text) {
        return text + ", ";
    }
}
