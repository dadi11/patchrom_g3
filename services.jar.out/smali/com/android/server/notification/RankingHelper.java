package com.android.server.notification;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseIntArray;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class RankingHelper implements RankingConfig {
    private static final String ATT_NAME = "name";
    private static final String ATT_PRIORITY = "priority";
    private static final String ATT_UID = "uid";
    private static final String ATT_VERSION = "version";
    private static final String ATT_VISIBILITY = "visibility";
    private static final boolean DEBUG = false;
    private static final String TAG = "RankingHelper";
    private static final String TAG_PACKAGE = "package";
    private static final String TAG_RANKING = "ranking";
    private static final int XML_VERSION = 1;
    private final Context mContext;
    private final GlobalSortKeyComparator mFinalComparator;
    private final ArrayMap<String, SparseIntArray> mPackagePriorities;
    private final ArrayMap<String, SparseIntArray> mPackageVisibilities;
    private final NotificationComparator mPreliminaryComparator;
    private final ArrayMap<String, NotificationRecord> mProxyByGroupTmp;
    private final Handler mRankingHandler;
    private final NotificationSignalExtractor[] mSignalExtractors;

    public RankingHelper(Context context, Handler rankingHandler, String[] extractorNames) {
        this.mPreliminaryComparator = new NotificationComparator();
        this.mFinalComparator = new GlobalSortKeyComparator();
        this.mContext = context;
        this.mRankingHandler = rankingHandler;
        this.mPackagePriorities = new ArrayMap();
        this.mPackageVisibilities = new ArrayMap();
        int N = extractorNames.length;
        this.mSignalExtractors = new NotificationSignalExtractor[N];
        for (int i = 0; i < N; i += XML_VERSION) {
            try {
                NotificationSignalExtractor extractor = (NotificationSignalExtractor) this.mContext.getClassLoader().loadClass(extractorNames[i]).newInstance();
                extractor.initialize(this.mContext);
                extractor.setConfig(this);
                this.mSignalExtractors[i] = extractor;
            } catch (ClassNotFoundException e) {
                Slog.w(TAG, "Couldn't find extractor " + extractorNames[i] + ".", e);
            } catch (InstantiationException e2) {
                Slog.w(TAG, "Couldn't instantiate extractor " + extractorNames[i] + ".", e2);
            } catch (IllegalAccessException e3) {
                Slog.w(TAG, "Problem accessing extractor " + extractorNames[i] + ".", e3);
            }
        }
        this.mProxyByGroupTmp = new ArrayMap();
    }

    public <T extends NotificationSignalExtractor> T findExtractor(Class<T> extractorClass) {
        int N = this.mSignalExtractors.length;
        for (int i = 0; i < N; i += XML_VERSION) {
            NotificationSignalExtractor extractor = this.mSignalExtractors[i];
            if (extractorClass.equals(extractor.getClass())) {
                return extractor;
            }
        }
        return null;
    }

    public void extractSignals(NotificationRecord r) {
        int N = this.mSignalExtractors.length;
        for (int i = 0; i < N; i += XML_VERSION) {
            try {
                RankingReconsideration recon = this.mSignalExtractors[i].process(r);
                if (recon != null) {
                    this.mRankingHandler.sendMessageDelayed(Message.obtain(this.mRankingHandler, 4, recon), recon.getDelay(TimeUnit.MILLISECONDS));
                }
            } catch (Throwable t) {
                Slog.w(TAG, "NotificationSignalExtractor failed.", t);
            }
        }
    }

    public void readXml(XmlPullParser parser) throws XmlPullParserException, IOException {
        if (parser.getEventType() == 2) {
            if (TAG_RANKING.equals(parser.getName())) {
                this.mPackagePriorities.clear();
                int version = safeInt(parser, ATT_VERSION, XML_VERSION);
                while (true) {
                    int type = parser.next();
                    if (type == XML_VERSION) {
                        break;
                    }
                    String tag = parser.getName();
                    if (type != 3 || !TAG_RANKING.equals(tag)) {
                        if (type == 2 && TAG_PACKAGE.equals(tag)) {
                            int uid = safeInt(parser, ATT_UID, -1);
                            int priority = safeInt(parser, ATT_PRIORITY, 0);
                            int vis = safeInt(parser, ATT_VISIBILITY, -1000);
                            String name = parser.getAttributeValue(null, ATT_NAME);
                            if (!TextUtils.isEmpty(name)) {
                                if (priority != 0) {
                                    SparseIntArray priorityByUid = (SparseIntArray) this.mPackagePriorities.get(name);
                                    if (priorityByUid == null) {
                                        priorityByUid = new SparseIntArray();
                                        this.mPackagePriorities.put(name, priorityByUid);
                                    }
                                    priorityByUid.put(uid, priority);
                                }
                                if (vis != -1000) {
                                    SparseIntArray visibilityByUid = (SparseIntArray) this.mPackageVisibilities.get(name);
                                    if (visibilityByUid == null) {
                                        visibilityByUid = new SparseIntArray();
                                        this.mPackageVisibilities.put(name, visibilityByUid);
                                    }
                                    visibilityByUid.put(uid, vis);
                                }
                            }
                        }
                    } else {
                        return;
                    }
                }
                throw new IllegalStateException("Failed to reach END_DOCUMENT");
            }
        }
    }

    public void writeXml(XmlSerializer out) throws IOException {
        out.startTag(null, TAG_RANKING);
        out.attribute(null, ATT_VERSION, Integer.toString(XML_VERSION));
        Set<String> packageNames = new ArraySet(this.mPackagePriorities.size() + this.mPackageVisibilities.size());
        packageNames.addAll(this.mPackagePriorities.keySet());
        packageNames.addAll(this.mPackageVisibilities.keySet());
        Set<Integer> packageUids = new ArraySet();
        for (String packageName : packageNames) {
            int M;
            int j;
            packageUids.clear();
            SparseIntArray priorityByUid = (SparseIntArray) this.mPackagePriorities.get(packageName);
            SparseIntArray visibilityByUid = (SparseIntArray) this.mPackageVisibilities.get(packageName);
            if (priorityByUid != null) {
                M = priorityByUid.size();
                for (j = 0; j < M; j += XML_VERSION) {
                    packageUids.add(Integer.valueOf(priorityByUid.keyAt(j)));
                }
            }
            if (visibilityByUid != null) {
                M = visibilityByUid.size();
                for (j = 0; j < M; j += XML_VERSION) {
                    packageUids.add(Integer.valueOf(visibilityByUid.keyAt(j)));
                }
            }
            for (Integer uid : packageUids) {
                out.startTag(null, TAG_PACKAGE);
                out.attribute(null, ATT_NAME, packageName);
                if (priorityByUid != null) {
                    int priority = priorityByUid.get(uid.intValue());
                    if (priority != 0) {
                        out.attribute(null, ATT_PRIORITY, Integer.toString(priority));
                    }
                }
                if (visibilityByUid != null) {
                    int visibility = visibilityByUid.get(uid.intValue());
                    if (visibility != -1000) {
                        out.attribute(null, ATT_VISIBILITY, Integer.toString(visibility));
                    }
                }
                out.attribute(null, ATT_UID, Integer.toString(uid.intValue()));
                out.endTag(null, TAG_PACKAGE);
            }
        }
        out.endTag(null, TAG_RANKING);
    }

    private void updateConfig() {
        int N = this.mSignalExtractors.length;
        for (int i = 0; i < N; i += XML_VERSION) {
            this.mSignalExtractors[i].setConfig(this);
        }
        this.mRankingHandler.sendEmptyMessage(5);
    }

    public void sort(ArrayList<NotificationRecord> notificationList) {
        int i;
        int N = notificationList.size();
        for (i = N - 1; i >= 0; i--) {
            ((NotificationRecord) notificationList.get(i)).setGlobalSortKey(null);
        }
        Collections.sort(notificationList, this.mPreliminaryComparator);
        synchronized (this.mProxyByGroupTmp) {
            for (i = N - 1; i >= 0; i--) {
                NotificationRecord record = (NotificationRecord) notificationList.get(i);
                record.setAuthoritativeRank(i);
                String groupKey = record.getGroupKey();
                if (record.getNotification().isGroupSummary() || !this.mProxyByGroupTmp.containsKey(groupKey)) {
                    this.mProxyByGroupTmp.put(groupKey, record);
                }
            }
            for (i = 0; i < N; i += XML_VERSION) {
                String groupSortKeyPortion;
                char c;
                record = (NotificationRecord) notificationList.get(i);
                NotificationRecord groupProxy = (NotificationRecord) this.mProxyByGroupTmp.get(record.getGroupKey());
                String groupSortKey = record.getNotification().getSortKey();
                if (groupSortKey == null) {
                    groupSortKeyPortion = "nsk";
                } else if (groupSortKey.equals("")) {
                    groupSortKeyPortion = "esk";
                } else {
                    groupSortKeyPortion = "gsk=" + groupSortKey;
                }
                boolean isGroupSummary = record.getNotification().isGroupSummary();
                String str = "intrsv=%c:grnk=0x%04x:gsmry=%c:%s:rnk=0x%04x";
                Object[] objArr = new Object[5];
                if (record.isRecentlyIntrusive()) {
                    c = '0';
                } else {
                    c = '1';
                }
                objArr[0] = Character.valueOf(c);
                objArr[XML_VERSION] = Integer.valueOf(groupProxy.getAuthoritativeRank());
                if (isGroupSummary) {
                    c = '0';
                } else {
                    c = '1';
                }
                objArr[2] = Character.valueOf(c);
                objArr[3] = groupSortKeyPortion;
                objArr[4] = Integer.valueOf(record.getAuthoritativeRank());
                record.setGlobalSortKey(String.format(str, objArr));
            }
            this.mProxyByGroupTmp.clear();
        }
        Collections.sort(notificationList, this.mFinalComparator);
    }

    public int indexOf(ArrayList<NotificationRecord> notificationList, NotificationRecord target) {
        return Collections.binarySearch(notificationList, target, this.mFinalComparator);
    }

    private static int safeInt(XmlPullParser parser, String att, int defValue) {
        return tryParseInt(parser.getAttributeValue(null, att), defValue);
    }

    private static int tryParseInt(String value, int defValue) {
        if (!TextUtils.isEmpty(value)) {
            try {
                defValue = Integer.valueOf(value).intValue();
            } catch (NumberFormatException e) {
            }
        }
        return defValue;
    }

    public int getPackagePriority(String packageName, int uid) {
        SparseIntArray priorityByUid = (SparseIntArray) this.mPackagePriorities.get(packageName);
        if (priorityByUid != null) {
            return priorityByUid.get(uid, 0);
        }
        return 0;
    }

    public void setPackagePriority(String packageName, int uid, int priority) {
        if (priority != getPackagePriority(packageName, uid)) {
            SparseIntArray priorityByUid = (SparseIntArray) this.mPackagePriorities.get(packageName);
            if (priorityByUid == null) {
                priorityByUid = new SparseIntArray();
                this.mPackagePriorities.put(packageName, priorityByUid);
            }
            priorityByUid.put(uid, priority);
            updateConfig();
        }
    }

    public int getPackageVisibilityOverride(String packageName, int uid) {
        SparseIntArray visibilityByUid = (SparseIntArray) this.mPackageVisibilities.get(packageName);
        if (visibilityByUid != null) {
            return visibilityByUid.get(uid, -1000);
        }
        return -1000;
    }

    public void setPackageVisibilityOverride(String packageName, int uid, int visibility) {
        if (visibility != getPackageVisibilityOverride(packageName, uid)) {
            SparseIntArray visibilityByUid = (SparseIntArray) this.mPackageVisibilities.get(packageName);
            if (visibilityByUid == null) {
                visibilityByUid = new SparseIntArray();
                this.mPackageVisibilities.put(packageName, visibilityByUid);
            }
            visibilityByUid.put(uid, visibility);
            updateConfig();
        }
    }

    public void dump(PrintWriter pw, String prefix, DumpFilter filter) {
        int N;
        int i;
        if (filter == null) {
            N = this.mSignalExtractors.length;
            pw.print(prefix);
            pw.print("mSignalExtractors.length = ");
            pw.println(N);
            for (i = 0; i < N; i += XML_VERSION) {
                pw.print(prefix);
                pw.print("  ");
                pw.println(this.mSignalExtractors[i]);
            }
        }
        N = this.mPackagePriorities.size();
        if (filter == null) {
            pw.print(prefix);
            pw.println("package priorities:");
        }
        for (i = 0; i < N; i += XML_VERSION) {
            String name = (String) this.mPackagePriorities.keyAt(i);
            if (filter == null || filter.matches(name)) {
                SparseIntArray priorityByUid = (SparseIntArray) this.mPackagePriorities.get(name);
                int M = priorityByUid.size();
                for (int j = 0; j < M; j += XML_VERSION) {
                    int uid = priorityByUid.keyAt(j);
                    int priority = priorityByUid.get(uid);
                    pw.print(prefix);
                    pw.print("  ");
                    pw.print(name);
                    pw.print(" (");
                    pw.print(uid);
                    pw.print(") has priority: ");
                    pw.println(priority);
                }
            }
        }
    }
}
