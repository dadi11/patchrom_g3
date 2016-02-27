package com.android.server.firewall;

import android.content.ComponentName;
import android.content.Intent;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

class SenderPermissionFilter implements Filter {
    private static final String ATTR_NAME = "name";
    public static final FilterFactory FACTORY;
    private final String mPermission;

    /* renamed from: com.android.server.firewall.SenderPermissionFilter.1 */
    static class C02631 extends FilterFactory {
        C02631(String x0) {
            super(x0);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            String permission = parser.getAttributeValue(null, SenderPermissionFilter.ATTR_NAME);
            if (permission != null) {
                return new SenderPermissionFilter(null);
            }
            throw new XmlPullParserException("Permission name must be specified.", parser, null);
        }
    }

    private SenderPermissionFilter(String permission) {
        this.mPermission = permission;
    }

    public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        return ifw.checkComponentPermission(this.mPermission, callerPid, callerUid, receivingUid, true);
    }

    static {
        FACTORY = new C02631("sender-permission");
    }
}
