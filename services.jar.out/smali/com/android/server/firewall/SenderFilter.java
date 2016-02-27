package com.android.server.firewall;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.Intent;
import android.os.Process;
import android.os.RemoteException;
import android.util.Slog;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

class SenderFilter {
    private static final String ATTR_TYPE = "type";
    public static final FilterFactory FACTORY;
    private static final Filter SIGNATURE;
    private static final Filter SYSTEM;
    private static final Filter SYSTEM_OR_SIGNATURE;
    private static final Filter USER_ID;
    private static final String VAL_SIGNATURE = "signature";
    private static final String VAL_SYSTEM = "system";
    private static final String VAL_SYSTEM_OR_SIGNATURE = "system|signature";
    private static final String VAL_USER_ID = "userId";

    /* renamed from: com.android.server.firewall.SenderFilter.1 */
    static class C02571 extends FilterFactory {
        C02571(String x0) {
            super(x0);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            String typeString = parser.getAttributeValue(null, SenderFilter.ATTR_TYPE);
            if (typeString == null) {
                throw new XmlPullParserException("type attribute must be specified for <sender>", parser, null);
            } else if (typeString.equals(SenderFilter.VAL_SYSTEM)) {
                return SenderFilter.SYSTEM;
            } else {
                if (typeString.equals(SenderFilter.VAL_SIGNATURE)) {
                    return SenderFilter.SIGNATURE;
                }
                if (typeString.equals(SenderFilter.VAL_SYSTEM_OR_SIGNATURE)) {
                    return SenderFilter.SYSTEM_OR_SIGNATURE;
                }
                if (typeString.equals(SenderFilter.VAL_USER_ID)) {
                    return SenderFilter.USER_ID;
                }
                throw new XmlPullParserException("Invalid type attribute for <sender>: " + typeString, parser, null);
            }
        }
    }

    /* renamed from: com.android.server.firewall.SenderFilter.2 */
    static class C02582 implements Filter {
        C02582() {
        }

        public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
            return ifw.signaturesMatch(callerUid, receivingUid);
        }
    }

    /* renamed from: com.android.server.firewall.SenderFilter.3 */
    static class C02593 implements Filter {
        C02593() {
        }

        public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
            return SenderFilter.isPrivilegedApp(callerUid, callerPid);
        }
    }

    /* renamed from: com.android.server.firewall.SenderFilter.4 */
    static class C02604 implements Filter {
        C02604() {
        }

        public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
            return SenderFilter.isPrivilegedApp(callerUid, callerPid) || ifw.signaturesMatch(callerUid, receivingUid);
        }
    }

    /* renamed from: com.android.server.firewall.SenderFilter.5 */
    static class C02615 implements Filter {
        C02615() {
        }

        public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
            return ifw.checkComponentPermission(null, callerPid, callerUid, receivingUid, false);
        }
    }

    SenderFilter() {
    }

    static boolean isPrivilegedApp(int callerUid, int callerPid) {
        if (callerUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || callerUid == 0 || callerPid == Process.myPid() || callerPid == 0) {
            return true;
        }
        try {
            if ((AppGlobals.getPackageManager().getFlagsForUid(callerUid) & 1073741824) == 0) {
                return false;
            }
            return true;
        } catch (RemoteException ex) {
            Slog.e("IntentFirewall", "Remote exception while retrieving uid flags", ex);
            return false;
        }
    }

    static {
        FACTORY = new C02571("sender");
        SIGNATURE = new C02582();
        SYSTEM = new C02593();
        SYSTEM_OR_SIGNATURE = new C02604();
        USER_ID = new C02615();
    }
}
