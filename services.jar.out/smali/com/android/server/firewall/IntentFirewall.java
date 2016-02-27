package com.android.server.firewall;

import android.app.AppGlobals;
import android.content.ComponentName;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.IPackageManager;
import android.os.Environment;
import android.os.FileObserver;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.ArrayMap;
import android.util.Slog;
import com.android.internal.util.ArrayUtils;
import com.android.server.EventLogTags;
import com.android.server.IntentResolver;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class IntentFirewall {
    private static final int LOG_PACKAGES_MAX_LENGTH = 150;
    private static final int LOG_PACKAGES_SUFFICIENT_LENGTH = 125;
    private static final File RULES_DIR;
    static final String TAG = "IntentFirewall";
    private static final String TAG_ACTIVITY = "activity";
    private static final String TAG_BROADCAST = "broadcast";
    private static final String TAG_RULES = "rules";
    private static final String TAG_SERVICE = "service";
    private static final int TYPE_ACTIVITY = 0;
    private static final int TYPE_BROADCAST = 1;
    private static final int TYPE_SERVICE = 2;
    private static final HashMap<String, FilterFactory> factoryMap;
    private FirewallIntentResolver mActivityResolver;
    private final AMSInterface mAms;
    private FirewallIntentResolver mBroadcastResolver;
    final FirewallHandler mHandler;
    private final RuleObserver mObserver;
    private FirewallIntentResolver mServiceResolver;

    public interface AMSInterface {
        int checkComponentPermission(String str, int i, int i2, int i3, boolean z);

        Object getAMSLock();
    }

    private final class FirewallHandler extends Handler {
        public FirewallHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            IntentFirewall.this.readRulesDir(IntentFirewall.getRulesDir());
        }
    }

    private static class FirewallIntentFilter extends IntentFilter {
        private final Rule rule;

        public FirewallIntentFilter(Rule rule) {
            this.rule = rule;
        }
    }

    private static class FirewallIntentResolver extends IntentResolver<FirewallIntentFilter, Rule> {
        private final ArrayMap<ComponentName, Rule[]> mRulesByComponent;

        private FirewallIntentResolver() {
            this.mRulesByComponent = new ArrayMap(IntentFirewall.TYPE_ACTIVITY);
        }

        protected boolean allowFilterResult(FirewallIntentFilter filter, List<Rule> dest) {
            return !dest.contains(filter.rule);
        }

        protected boolean isPackageForFilter(String packageName, FirewallIntentFilter filter) {
            return true;
        }

        protected FirewallIntentFilter[] newArray(int size) {
            return new FirewallIntentFilter[size];
        }

        protected Rule newResult(FirewallIntentFilter filter, int match, int userId) {
            return filter.rule;
        }

        protected void sortResults(List<Rule> list) {
        }

        public void queryByComponent(ComponentName componentName, List<Rule> candidateRules) {
            Rule[] rules = (Rule[]) this.mRulesByComponent.get(componentName);
            if (rules != null) {
                candidateRules.addAll(Arrays.asList(rules));
            }
        }

        public void addComponentFilter(ComponentName componentName, Rule rule) {
            this.mRulesByComponent.put(componentName, (Rule[]) ArrayUtils.appendElement(Rule.class, (Rule[]) this.mRulesByComponent.get(componentName), rule));
        }
    }

    private static class Rule extends AndFilter {
        private static final String ATTR_BLOCK = "block";
        private static final String ATTR_LOG = "log";
        private static final String ATTR_NAME = "name";
        private static final String TAG_COMPONENT_FILTER = "component-filter";
        private static final String TAG_INTENT_FILTER = "intent-filter";
        private boolean block;
        private boolean log;
        private final ArrayList<ComponentName> mComponentFilters;
        private final ArrayList<FirewallIntentFilter> mIntentFilters;

        private Rule() {
            this.mIntentFilters = new ArrayList(IntentFirewall.TYPE_BROADCAST);
            this.mComponentFilters = new ArrayList(IntentFirewall.TYPE_ACTIVITY);
        }

        public Rule readFromXml(XmlPullParser parser) throws IOException, XmlPullParserException {
            this.block = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_BLOCK));
            this.log = Boolean.parseBoolean(parser.getAttributeValue(null, ATTR_LOG));
            super.readFromXml(parser);
            return this;
        }

        protected void readChild(XmlPullParser parser) throws IOException, XmlPullParserException {
            String currentTag = parser.getName();
            if (currentTag.equals(TAG_INTENT_FILTER)) {
                FirewallIntentFilter intentFilter = new FirewallIntentFilter(this);
                intentFilter.readFromXml(parser);
                this.mIntentFilters.add(intentFilter);
            } else if (currentTag.equals(TAG_COMPONENT_FILTER)) {
                String componentStr = parser.getAttributeValue(null, ATTR_NAME);
                if (componentStr == null) {
                    throw new XmlPullParserException("Component name must be specified.", parser, null);
                }
                ComponentName componentName = ComponentName.unflattenFromString(componentStr);
                if (componentName == null) {
                    throw new XmlPullParserException("Invalid component name: " + componentStr);
                }
                this.mComponentFilters.add(componentName);
            } else {
                super.readChild(parser);
            }
        }

        public int getIntentFilterCount() {
            return this.mIntentFilters.size();
        }

        public FirewallIntentFilter getIntentFilter(int index) {
            return (FirewallIntentFilter) this.mIntentFilters.get(index);
        }

        public int getComponentFilterCount() {
            return this.mComponentFilters.size();
        }

        public ComponentName getComponentFilter(int index) {
            return (ComponentName) this.mComponentFilters.get(index);
        }

        public boolean getBlock() {
            return this.block;
        }

        public boolean getLog() {
            return this.log;
        }
    }

    private class RuleObserver extends FileObserver {
        private static final int MONITORED_EVENTS = 968;

        public RuleObserver(File monitoredDir) {
            super(monitoredDir.getAbsolutePath(), MONITORED_EVENTS);
        }

        public void onEvent(int event, String path) {
            if (path.endsWith(".xml")) {
                IntentFirewall.this.mHandler.removeMessages(IntentFirewall.TYPE_ACTIVITY);
                IntentFirewall.this.mHandler.sendEmptyMessageDelayed(IntentFirewall.TYPE_ACTIVITY, 250);
            }
        }
    }

    static {
        RULES_DIR = new File(Environment.getSystemSecureDirectory(), "ifw");
        FilterFactory[] factories = new FilterFactory[]{AndFilter.FACTORY, OrFilter.FACTORY, NotFilter.FACTORY, StringFilter.ACTION, StringFilter.COMPONENT, StringFilter.COMPONENT_NAME, StringFilter.COMPONENT_PACKAGE, StringFilter.DATA, StringFilter.HOST, StringFilter.MIME_TYPE, StringFilter.SCHEME, StringFilter.PATH, StringFilter.SSP, CategoryFilter.FACTORY, SenderFilter.FACTORY, SenderPackageFilter.FACTORY, SenderPermissionFilter.FACTORY, PortFilter.FACTORY};
        factoryMap = new HashMap((factories.length * 4) / 3);
        for (int i = TYPE_ACTIVITY; i < factories.length; i += TYPE_BROADCAST) {
            FilterFactory factory = factories[i];
            factoryMap.put(factory.getTagName(), factory);
        }
    }

    public IntentFirewall(AMSInterface ams, Handler handler) {
        this.mActivityResolver = new FirewallIntentResolver();
        this.mBroadcastResolver = new FirewallIntentResolver();
        this.mServiceResolver = new FirewallIntentResolver();
        this.mAms = ams;
        this.mHandler = new FirewallHandler(handler.getLooper());
        File rulesDir = getRulesDir();
        rulesDir.mkdirs();
        readRulesDir(rulesDir);
        this.mObserver = new RuleObserver(rulesDir);
        this.mObserver.startWatching();
    }

    public boolean checkStartActivity(Intent intent, int callerUid, int callerPid, String resolvedType, ApplicationInfo resolvedApp) {
        return checkIntent(this.mActivityResolver, intent.getComponent(), TYPE_ACTIVITY, intent, callerUid, callerPid, resolvedType, resolvedApp.uid);
    }

    public boolean checkService(ComponentName resolvedService, Intent intent, int callerUid, int callerPid, String resolvedType, ApplicationInfo resolvedApp) {
        return checkIntent(this.mServiceResolver, resolvedService, TYPE_SERVICE, intent, callerUid, callerPid, resolvedType, resolvedApp.uid);
    }

    public boolean checkBroadcast(Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        return checkIntent(this.mBroadcastResolver, intent.getComponent(), TYPE_BROADCAST, intent, callerUid, callerPid, resolvedType, receivingUid);
    }

    public boolean checkIntent(FirewallIntentResolver resolver, ComponentName resolvedComponent, int intentType, Intent intent, int callerUid, int callerPid, String resolvedType, int receivingUid) {
        boolean log = false;
        boolean block = false;
        List<Rule> candidateRules = resolver.queryIntent(intent, resolvedType, false, TYPE_ACTIVITY);
        if (candidateRules == null) {
            candidateRules = new ArrayList();
        }
        resolver.queryByComponent(resolvedComponent, candidateRules);
        for (int i = TYPE_ACTIVITY; i < candidateRules.size(); i += TYPE_BROADCAST) {
            Rule rule = (Rule) candidateRules.get(i);
            if (rule.matches(this, resolvedComponent, intent, callerUid, callerPid, resolvedType, receivingUid)) {
                block |= rule.getBlock();
                log |= rule.getLog();
                if (block && log) {
                    break;
                }
            }
        }
        if (log) {
            logIntent(intentType, intent, callerUid, resolvedType);
        }
        if (block) {
            return false;
        }
        return true;
    }

    private static void logIntent(int intentType, Intent intent, int callerUid, String resolvedType) {
        ComponentName cn = intent.getComponent();
        String shortComponent = null;
        if (cn != null) {
            shortComponent = cn.flattenToShortString();
        }
        String callerPackages = null;
        int callerPackageCount = TYPE_ACTIVITY;
        IPackageManager pm = AppGlobals.getPackageManager();
        if (pm != null) {
            try {
                String[] callerPackagesArray = pm.getPackagesForUid(callerUid);
                if (callerPackagesArray != null) {
                    callerPackageCount = callerPackagesArray.length;
                    callerPackages = joinPackages(callerPackagesArray);
                }
            } catch (RemoteException ex) {
                Slog.e(TAG, "Remote exception while retrieving packages", ex);
            }
        }
        EventLogTags.writeIfwIntentMatched(intentType, shortComponent, callerUid, callerPackageCount, callerPackages, intent.getAction(), resolvedType, intent.getDataString(), intent.getFlags());
    }

    private static String joinPackages(String[] packages) {
        boolean first = true;
        StringBuilder sb = new StringBuilder();
        for (int i = TYPE_ACTIVITY; i < packages.length; i += TYPE_BROADCAST) {
            String pkg = packages[i];
            if ((sb.length() + pkg.length()) + TYPE_BROADCAST < LOG_PACKAGES_MAX_LENGTH) {
                if (first) {
                    first = false;
                } else {
                    sb.append(',');
                }
                sb.append(pkg);
            } else if (sb.length() >= LOG_PACKAGES_SUFFICIENT_LENGTH) {
                return sb.toString();
            }
        }
        if (sb.length() != 0 || packages.length <= 0) {
            return null;
        }
        pkg = packages[TYPE_ACTIVITY];
        return pkg.substring((pkg.length() - 150) + TYPE_BROADCAST) + '-';
    }

    public static File getRulesDir() {
        return RULES_DIR;
    }

    private void readRulesDir(File rulesDir) {
        int i;
        FirewallIntentResolver[] resolvers = new FirewallIntentResolver[3];
        for (i = TYPE_ACTIVITY; i < resolvers.length; i += TYPE_BROADCAST) {
            resolvers[i] = new FirewallIntentResolver();
        }
        File[] files = rulesDir.listFiles();
        if (files != null) {
            for (i = TYPE_ACTIVITY; i < files.length; i += TYPE_BROADCAST) {
                File file = files[i];
                if (file.getName().endsWith(".xml")) {
                    readRules(file, resolvers);
                }
            }
        }
        Slog.i(TAG, "Read new rules (A:" + resolvers[TYPE_ACTIVITY].filterSet().size() + " B:" + resolvers[TYPE_BROADCAST].filterSet().size() + " S:" + resolvers[TYPE_SERVICE].filterSet().size() + ")");
        synchronized (this.mAms.getAMSLock()) {
            this.mActivityResolver = resolvers[TYPE_ACTIVITY];
            this.mBroadcastResolver = resolvers[TYPE_BROADCAST];
            this.mServiceResolver = resolvers[TYPE_SERVICE];
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void readRules(java.io.File r18, com.android.server.firewall.IntentFirewall.FirewallIntentResolver[] r19) {
        /*
        r17 = this;
        r11 = new java.util.ArrayList;
        r13 = 3;
        r11.<init>(r13);
        r3 = 0;
    L_0x0007:
        r13 = 3;
        if (r3 >= r13) goto L_0x0015;
    L_0x000a:
        r13 = new java.util.ArrayList;
        r13.<init>();
        r11.add(r13);
        r3 = r3 + 1;
        goto L_0x0007;
    L_0x0015:
        r2 = new java.io.FileInputStream;	 Catch:{ FileNotFoundException -> 0x0076 }
        r0 = r18;
        r2.<init>(r0);	 Catch:{ FileNotFoundException -> 0x0076 }
        r5 = android.util.Xml.newPullParser();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r13 = 0;
        r5.setInput(r2, r13);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r13 = "rules";
        com.android.internal.util.XmlUtils.beginDocument(r5, r13);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r4 = r5.getDepth();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
    L_0x002d:
        r13 = com.android.internal.util.XmlUtils.nextElementWithin(r5, r4);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        if (r13 == 0) goto L_0x00e3;
    L_0x0033:
        r9 = -1;
        r12 = r5.getName();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r13 = "activity";
        r13 = r12.equals(r13);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        if (r13 == 0) goto L_0x0078;
    L_0x0040:
        r9 = 0;
    L_0x0041:
        r13 = -1;
        if (r9 == r13) goto L_0x002d;
    L_0x0044:
        r7 = new com.android.server.firewall.IntentFirewall$Rule;	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r13 = 0;
        r7.<init>();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r10 = r11.get(r9);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r10 = (java.util.List) r10;	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r7.readFromXml(r5);	 Catch:{ XmlPullParserException -> 0x008c, IOException -> 0x00a8 }
        r10.add(r7);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        goto L_0x002d;
    L_0x0057:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;	 Catch:{ all -> 0x014c }
        r14.<init>();	 Catch:{ all -> 0x014c }
        r15 = "Error reading intent firewall rules from ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x014c }
        r0 = r18;
        r14 = r14.append(r0);	 Catch:{ all -> 0x014c }
        r14 = r14.toString();	 Catch:{ all -> 0x014c }
        android.util.Slog.e(r13, r14, r1);	 Catch:{ all -> 0x014c }
        r2.close();	 Catch:{ IOException -> 0x012f }
    L_0x0075:
        return;
    L_0x0076:
        r1 = move-exception;
        goto L_0x0075;
    L_0x0078:
        r13 = "broadcast";
        r13 = r12.equals(r13);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        if (r13 == 0) goto L_0x0082;
    L_0x0080:
        r9 = 1;
        goto L_0x0041;
    L_0x0082:
        r13 = "service";
        r13 = r12.equals(r13);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        if (r13 == 0) goto L_0x0041;
    L_0x008a:
        r9 = 2;
        goto L_0x0041;
    L_0x008c:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r14.<init>();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r15 = "Error reading an intent firewall rule from ";
        r14 = r14.append(r15);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r0 = r18;
        r14 = r14.append(r0);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        r14 = r14.toString();	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        android.util.Slog.e(r13, r14, r1);	 Catch:{ XmlPullParserException -> 0x0057, IOException -> 0x00a8 }
        goto L_0x002d;
    L_0x00a8:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;	 Catch:{ all -> 0x014c }
        r14.<init>();	 Catch:{ all -> 0x014c }
        r15 = "Error reading intent firewall rules from ";
        r14 = r14.append(r15);	 Catch:{ all -> 0x014c }
        r0 = r18;
        r14 = r14.append(r0);	 Catch:{ all -> 0x014c }
        r14 = r14.toString();	 Catch:{ all -> 0x014c }
        android.util.Slog.e(r13, r14, r1);	 Catch:{ all -> 0x014c }
        r2.close();	 Catch:{ IOException -> 0x00c7 }
        goto L_0x0075;
    L_0x00c7:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error while closing ";
        r14 = r14.append(r15);
        r0 = r18;
        r14 = r14.append(r0);
        r14 = r14.toString();
        android.util.Slog.e(r13, r14, r1);
        goto L_0x0075;
    L_0x00e3:
        r2.close();	 Catch:{ IOException -> 0x0113 }
    L_0x00e6:
        r9 = 0;
    L_0x00e7:
        r13 = r11.size();
        if (r9 >= r13) goto L_0x0075;
    L_0x00ed:
        r10 = r11.get(r9);
        r10 = (java.util.List) r10;
        r6 = r19[r9];
        r8 = 0;
    L_0x00f6:
        r13 = r10.size();
        if (r8 >= r13) goto L_0x0182;
    L_0x00fc:
        r7 = r10.get(r8);
        r7 = (com.android.server.firewall.IntentFirewall.Rule) r7;
        r3 = 0;
    L_0x0103:
        r13 = r7.getIntentFilterCount();
        if (r3 >= r13) goto L_0x016d;
    L_0x0109:
        r13 = r7.getIntentFilter(r3);
        r6.addFilter(r13);
        r3 = r3 + 1;
        goto L_0x0103;
    L_0x0113:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error while closing ";
        r14 = r14.append(r15);
        r0 = r18;
        r14 = r14.append(r0);
        r14 = r14.toString();
        android.util.Slog.e(r13, r14, r1);
        goto L_0x00e6;
    L_0x012f:
        r1 = move-exception;
        r13 = "IntentFirewall";
        r14 = new java.lang.StringBuilder;
        r14.<init>();
        r15 = "Error while closing ";
        r14 = r14.append(r15);
        r0 = r18;
        r14 = r14.append(r0);
        r14 = r14.toString();
        android.util.Slog.e(r13, r14, r1);
        goto L_0x0075;
    L_0x014c:
        r13 = move-exception;
        r2.close();	 Catch:{ IOException -> 0x0151 }
    L_0x0150:
        throw r13;
    L_0x0151:
        r1 = move-exception;
        r14 = "IntentFirewall";
        r15 = new java.lang.StringBuilder;
        r15.<init>();
        r16 = "Error while closing ";
        r15 = r15.append(r16);
        r0 = r18;
        r15 = r15.append(r0);
        r15 = r15.toString();
        android.util.Slog.e(r14, r15, r1);
        goto L_0x0150;
    L_0x016d:
        r3 = 0;
    L_0x016e:
        r13 = r7.getComponentFilterCount();
        if (r3 >= r13) goto L_0x017e;
    L_0x0174:
        r13 = r7.getComponentFilter(r3);
        r6.addComponentFilter(r13, r7);
        r3 = r3 + 1;
        goto L_0x016e;
    L_0x017e:
        r8 = r8 + 1;
        goto L_0x00f6;
    L_0x0182:
        r9 = r9 + 1;
        goto L_0x00e7;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.firewall.IntentFirewall.readRules(java.io.File, com.android.server.firewall.IntentFirewall$FirewallIntentResolver[]):void");
    }

    static Filter parseFilter(XmlPullParser parser) throws IOException, XmlPullParserException {
        String elementName = parser.getName();
        FilterFactory factory = (FilterFactory) factoryMap.get(elementName);
        if (factory != null) {
            return factory.newFilter(parser);
        }
        throw new XmlPullParserException("Unknown element in filter list: " + elementName);
    }

    boolean checkComponentPermission(String permission, int pid, int uid, int owningUid, boolean exported) {
        return this.mAms.checkComponentPermission(permission, pid, uid, owningUid, exported) == 0;
    }

    boolean signaturesMatch(int uid1, int uid2) {
        try {
            if (AppGlobals.getPackageManager().checkUidSignatures(uid1, uid2) == 0) {
                return true;
            }
            return false;
        } catch (RemoteException ex) {
            Slog.e(TAG, "Remote exception while checking signatures", ex);
            return false;
        }
    }
}
