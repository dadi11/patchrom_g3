package android.text.util;

import android.net.LinkQualityInfo;
import android.net.ProxyInfo;
import android.telephony.PhoneNumberUtils;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.method.LinkMovementMethod;
import android.text.method.MovementMethod;
import android.text.style.URLSpan;
import android.util.Patterns;
import android.webkit.WebView;
import android.widget.TextView;
import com.android.i18n.phonenumbers.PhoneNumberMatch;
import com.android.i18n.phonenumbers.PhoneNumberUtil;
import com.android.i18n.phonenumbers.PhoneNumberUtil.Leniency;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Linkify {
    public static final int ALL = 15;
    public static final int EMAIL_ADDRESSES = 2;
    public static final int MAP_ADDRESSES = 8;
    public static final int PHONE_NUMBERS = 4;
    private static final int PHONE_NUMBER_MINIMUM_DIGITS = 5;
    public static final int WEB_URLS = 1;
    public static final MatchFilter sPhoneNumberMatchFilter;
    public static final TransformFilter sPhoneNumberTransformFilter;
    public static final MatchFilter sUrlMatchFilter;

    public interface MatchFilter {
        boolean acceptMatch(CharSequence charSequence, int i, int i2);
    }

    /* renamed from: android.text.util.Linkify.1 */
    static class C08041 implements MatchFilter {
        C08041() {
        }

        public final boolean acceptMatch(CharSequence s, int start, int end) {
            if (start != 0 && s.charAt(start - 1) == '@') {
                return false;
            }
            return true;
        }
    }

    /* renamed from: android.text.util.Linkify.2 */
    static class C08052 implements MatchFilter {
        C08052() {
        }

        public final boolean acceptMatch(CharSequence s, int start, int end) {
            int digitCount = 0;
            for (int i = start; i < end; i += Linkify.WEB_URLS) {
                if (Character.isDigit(s.charAt(i))) {
                    digitCount += Linkify.WEB_URLS;
                    if (digitCount >= Linkify.PHONE_NUMBER_MINIMUM_DIGITS) {
                        return true;
                    }
                }
            }
            return false;
        }
    }

    public interface TransformFilter {
        String transformUrl(Matcher matcher, String str);
    }

    /* renamed from: android.text.util.Linkify.3 */
    static class C08063 implements TransformFilter {
        C08063() {
        }

        public final String transformUrl(Matcher match, String url) {
            return Patterns.digitsAndPlusOnly(match);
        }
    }

    /* renamed from: android.text.util.Linkify.4 */
    static class C08074 implements Comparator<LinkSpec> {
        C08074() {
        }

        public final int compare(LinkSpec a, LinkSpec b) {
            if (a.start < b.start) {
                return -1;
            }
            if (a.start > b.start) {
                return Linkify.WEB_URLS;
            }
            if (a.end < b.end) {
                return Linkify.WEB_URLS;
            }
            if (a.end <= b.end) {
                return 0;
            }
            return -1;
        }
    }

    static {
        sUrlMatchFilter = new C08041();
        sPhoneNumberMatchFilter = new C08052();
        sPhoneNumberTransformFilter = new C08063();
    }

    public static final boolean addLinks(Spannable text, int mask) {
        if (mask == 0) {
            return false;
        }
        URLSpan[] old = (URLSpan[]) text.getSpans(0, text.length(), URLSpan.class);
        for (int i = old.length - 1; i >= 0; i--) {
            text.removeSpan(old[i]);
        }
        ArrayList<LinkSpec> links = new ArrayList();
        if ((mask & WEB_URLS) != 0) {
            Spannable spannable = text;
            gatherLinks(links, spannable, Patterns.WEB_URL, new String[]{"http://", "https://", "rtsp://"}, sUrlMatchFilter, null);
        }
        if ((mask & EMAIL_ADDRESSES) != 0) {
            Pattern pattern = Patterns.EMAIL_ADDRESS;
            String[] strArr = new String[WEB_URLS];
            strArr[0] = WebView.SCHEME_MAILTO;
            gatherLinks(links, text, pattern, strArr, null, null);
        }
        if ((mask & PHONE_NUMBERS) != 0) {
            gatherTelLinks(links, text);
        }
        if ((mask & MAP_ADDRESSES) != 0) {
            gatherMapLinks(links, text);
        }
        pruneOverlaps(links);
        if (links.size() == 0) {
            return false;
        }
        Iterator i$ = links.iterator();
        while (i$.hasNext()) {
            LinkSpec link = (LinkSpec) i$.next();
            applyLink(link.url, link.start, link.end, text);
        }
        return true;
    }

    public static final boolean addLinks(TextView text, int mask) {
        if (mask == 0) {
            return false;
        }
        CharSequence t = text.getText();
        if (!(t instanceof Spannable)) {
            CharSequence s = SpannableString.valueOf(t);
            if (!addLinks((Spannable) s, mask)) {
                return false;
            }
            addLinkMovementMethod(text);
            text.setText(s);
            return true;
        } else if (!addLinks((Spannable) t, mask)) {
            return false;
        } else {
            addLinkMovementMethod(text);
            return true;
        }
    }

    private static final void addLinkMovementMethod(TextView t) {
        MovementMethod m = t.getMovementMethod();
        if ((m == null || !(m instanceof LinkMovementMethod)) && t.getLinksClickable()) {
            t.setMovementMethod(LinkMovementMethod.getInstance());
        }
    }

    public static final void addLinks(TextView text, Pattern pattern, String scheme) {
        addLinks(text, pattern, scheme, null, null);
    }

    public static final void addLinks(TextView text, Pattern p, String scheme, MatchFilter matchFilter, TransformFilter transformFilter) {
        CharSequence s = SpannableString.valueOf(text.getText());
        if (addLinks((Spannable) s, p, scheme, matchFilter, transformFilter)) {
            text.setText(s);
            addLinkMovementMethod(text);
        }
    }

    public static final boolean addLinks(Spannable text, Pattern pattern, String scheme) {
        return addLinks(text, pattern, scheme, null, null);
    }

    public static final boolean addLinks(Spannable s, Pattern p, String scheme, MatchFilter matchFilter, TransformFilter transformFilter) {
        String prefix;
        boolean hasMatches = false;
        if (scheme == null) {
            prefix = ProxyInfo.LOCAL_EXCL_LIST;
        } else {
            prefix = scheme.toLowerCase(Locale.ROOT);
        }
        Matcher m = p.matcher(s);
        while (m.find()) {
            int start = m.start();
            int end = m.end();
            boolean allowed = true;
            if (matchFilter != null) {
                allowed = matchFilter.acceptMatch(s, start, end);
            }
            if (allowed) {
                String group = m.group(0);
                String[] strArr = new String[WEB_URLS];
                strArr[0] = prefix;
                applyLink(makeUrl(group, strArr, m, transformFilter), start, end, s);
                hasMatches = true;
            }
        }
        return hasMatches;
    }

    private static final void applyLink(String url, int start, int end, Spannable text) {
        text.setSpan(new URLSpan(url), start, end, 33);
    }

    private static final String makeUrl(String url, String[] prefixes, Matcher m, TransformFilter filter) {
        if (filter != null) {
            url = filter.transformUrl(m, url);
        }
        boolean hasPrefix = false;
        for (int i = 0; i < prefixes.length; i += WEB_URLS) {
            if (url.regionMatches(true, 0, prefixes[i], 0, prefixes[i].length())) {
                hasPrefix = true;
                if (!url.regionMatches(false, 0, prefixes[i], 0, prefixes[i].length())) {
                    url = prefixes[i] + url.substring(prefixes[i].length());
                }
                if (hasPrefix) {
                    return prefixes[0] + url;
                }
                return url;
            }
        }
        if (hasPrefix) {
            return url;
        }
        return prefixes[0] + url;
    }

    private static final void gatherLinks(ArrayList<LinkSpec> links, Spannable s, Pattern pattern, String[] schemes, MatchFilter matchFilter, TransformFilter transformFilter) {
        Matcher m = pattern.matcher(s);
        while (m.find()) {
            int start = m.start();
            int end = m.end();
            if (matchFilter == null || matchFilter.acceptMatch(s, start, end)) {
                LinkSpec spec = new LinkSpec();
                spec.url = makeUrl(m.group(0), schemes, m, transformFilter);
                spec.start = start;
                spec.end = end;
                links.add(spec);
            }
        }
    }

    private static final void gatherTelLinks(ArrayList<LinkSpec> links, Spannable s) {
        for (PhoneNumberMatch match : PhoneNumberUtil.getInstance().findNumbers(s.toString(), Locale.getDefault().getCountry(), Leniency.POSSIBLE, LinkQualityInfo.UNKNOWN_LONG)) {
            LinkSpec spec = new LinkSpec();
            spec.url = WebView.SCHEME_TEL + PhoneNumberUtils.normalizeNumber(match.rawString());
            spec.start = match.start();
            spec.end = match.end();
            links.add(spec);
        }
    }

    private static final void gatherMapLinks(ArrayList<LinkSpec> links, Spannable s) {
        String string = s.toString();
        int base = 0;
        while (true) {
            String address = WebView.findAddress(string);
            if (address != null) {
                int start = string.indexOf(address);
                if (start >= 0) {
                    LinkSpec spec = new LinkSpec();
                    int end = start + address.length();
                    spec.start = base + start;
                    spec.end = base + end;
                    string = string.substring(end);
                    base += end;
                    try {
                    } catch (UnsupportedEncodingException e) {
                    }
                    try {
                        spec.url = WebView.SCHEME_GEO + URLEncoder.encode(address, "UTF-8");
                        links.add(spec);
                    } catch (UnsupportedOperationException e2) {
                        return;
                    }
                }
                return;
            }
            return;
        }
    }

    private static final void pruneOverlaps(ArrayList<LinkSpec> links) {
        Collections.sort(links, new C08074());
        int len = links.size();
        int i = 0;
        while (i < len - 1) {
            LinkSpec a = (LinkSpec) links.get(i);
            LinkSpec b = (LinkSpec) links.get(i + WEB_URLS);
            int remove = -1;
            if (a.start <= b.start && a.end > b.start) {
                if (b.end <= a.end) {
                    remove = i + WEB_URLS;
                } else if (a.end - a.start > b.end - b.start) {
                    remove = i + WEB_URLS;
                } else if (a.end - a.start < b.end - b.start) {
                    remove = i;
                }
                if (remove != -1) {
                    links.remove(remove);
                    len--;
                }
            }
            i += WEB_URLS;
        }
    }
}
