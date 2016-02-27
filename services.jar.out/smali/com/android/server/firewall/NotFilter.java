package com.android.server.firewall;

import android.content.ComponentName;
import android.content.Intent;
import com.android.internal.util.XmlUtils;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

class NotFilter implements Filter {
    public static final FilterFactory FACTORY;
    private final Filter mChild;

    /* renamed from: com.android.server.firewall.NotFilter.1 */
    static class C02541 extends FilterFactory {
        C02541(String x0) {
            super(x0);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            Filter child = null;
            int outerDepth = parser.getDepth();
            while (XmlUtils.nextElementWithin(parser, outerDepth)) {
                Filter filter = IntentFirewall.parseFilter(parser);
                if (child == null) {
                    child = filter;
                } else {
                    throw new XmlPullParserException("<not> tag can only contain a single child filter.", parser, null);
                }
            }
            return new NotFilter(null);
        }
    }

    private NotFilter(Filter child) {
        this.mChild = child;
    }

    public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        return !this.mChild.matches(ifw, resolvedComponent, intent, callerUid, callerPid, resolvedType, receivingUid);
    }

    static {
        FACTORY = new C02541("not");
    }
}
