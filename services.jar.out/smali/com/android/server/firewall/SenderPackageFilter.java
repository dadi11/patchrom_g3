package com.android.server.firewall;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.Intent;
import android.os.RemoteException;
import android.os.UserHandle;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class SenderPackageFilter implements Filter {
    private static final String ATTR_NAME = "name";
    public static final FilterFactory FACTORY;
    public final String mPackageName;

    /* renamed from: com.android.server.firewall.SenderPackageFilter.1 */
    static class C02621 extends FilterFactory {
        C02621(String x0) {
            super(x0);
        }

        public Filter newFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
            String packageName = parser.getAttributeValue(null, SenderPackageFilter.ATTR_NAME);
            if (packageName != null) {
                return new SenderPackageFilter(packageName);
            }
            throw new XmlPullParserException("A package name must be specified.", parser, null);
        }
    }

    public SenderPackageFilter(String packageName) {
        this.mPackageName = packageName;
    }

    public boolean matches(IntentFirewall ifw, ComponentName resolvedComponent, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        int packageUid = -1;
        try {
            packageUid = AppGlobals.getPackageManager().getPackageUid(this.mPackageName, 0);
        } catch (RemoteException e) {
        }
        if (packageUid == -1) {
            return false;
        }
        return UserHandle.isSameApp(packageUid, callerUid);
    }

    static {
        FACTORY = new C02621("sender-package");
    }
}
