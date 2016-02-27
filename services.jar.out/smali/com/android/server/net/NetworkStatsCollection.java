package com.android.server.net;

import android.net.NetworkIdentity;
import android.net.NetworkStats;
import android.net.NetworkStats.Entry;
import android.net.NetworkStatsHistory;
import android.net.NetworkTemplate;
import android.util.ArrayMap;
import android.util.AtomicFile;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.FileRotator.Reader;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.job.controllers.JobStatus;
import com.google.android.collect.Lists;
import com.google.android.collect.Maps;
import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.ProtocolException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Objects;
import libcore.io.IoUtils;

public class NetworkStatsCollection implements Reader {
    private static final int FILE_MAGIC = 1095648596;
    private static final int VERSION_NETWORK_INIT = 1;
    private static final int VERSION_UID_INIT = 1;
    private static final int VERSION_UID_WITH_IDENT = 2;
    private static final int VERSION_UID_WITH_SET = 4;
    private static final int VERSION_UID_WITH_TAG = 3;
    private static final int VERSION_UNIFIED_INIT = 16;
    private final long mBucketDuration;
    private boolean mDirty;
    private long mEndMillis;
    private long mStartMillis;
    private ArrayMap<Key, NetworkStatsHistory> mStats;
    private long mTotalBytes;

    private static class Key implements Comparable<Key> {
        private final int hashCode;
        public final NetworkIdentitySet ident;
        public final int set;
        public final int tag;
        public final int uid;

        public Key(NetworkIdentitySet ident, int uid, int set, int tag) {
            this.ident = ident;
            this.uid = uid;
            this.set = set;
            this.tag = tag;
            Object[] objArr = new Object[NetworkStatsCollection.VERSION_UID_WITH_SET];
            objArr[0] = ident;
            objArr[NetworkStatsCollection.VERSION_UID_INIT] = Integer.valueOf(uid);
            objArr[NetworkStatsCollection.VERSION_UID_WITH_IDENT] = Integer.valueOf(set);
            objArr[NetworkStatsCollection.VERSION_UID_WITH_TAG] = Integer.valueOf(tag);
            this.hashCode = Objects.hash(objArr);
        }

        public int hashCode() {
            return this.hashCode;
        }

        public boolean equals(Object obj) {
            if (!(obj instanceof Key)) {
                return false;
            }
            Key key = (Key) obj;
            if (this.uid == key.uid && this.set == key.set && this.tag == key.tag && Objects.equals(this.ident, key.ident)) {
                return true;
            }
            return false;
        }

        public int compareTo(Key another) {
            int res = 0;
            if (!(this.ident == null || another.ident == null)) {
                res = this.ident.compareTo(another.ident);
            }
            if (res == 0) {
                res = Integer.compare(this.uid, another.uid);
            }
            if (res == 0) {
                res = Integer.compare(this.set, another.set);
            }
            if (res == 0) {
                return Integer.compare(this.tag, another.tag);
            }
            return res;
        }
    }

    public NetworkStatsCollection(long bucketDuration) {
        this.mStats = new ArrayMap();
        this.mBucketDuration = bucketDuration;
        reset();
    }

    public void reset() {
        this.mStats.clear();
        this.mStartMillis = JobStatus.NO_LATEST_RUNTIME;
        this.mEndMillis = Long.MIN_VALUE;
        this.mTotalBytes = 0;
        this.mDirty = false;
    }

    public long getStartMillis() {
        return this.mStartMillis;
    }

    public long getFirstAtomicBucketMillis() {
        if (this.mStartMillis == JobStatus.NO_LATEST_RUNTIME) {
            return JobStatus.NO_LATEST_RUNTIME;
        }
        return this.mStartMillis + this.mBucketDuration;
    }

    public long getEndMillis() {
        return this.mEndMillis;
    }

    public long getTotalBytes() {
        return this.mTotalBytes;
    }

    public boolean isDirty() {
        return this.mDirty;
    }

    public void clearDirty() {
        this.mDirty = false;
    }

    public boolean isEmpty() {
        return this.mStartMillis == JobStatus.NO_LATEST_RUNTIME && this.mEndMillis == Long.MIN_VALUE;
    }

    public NetworkStatsHistory getHistory(NetworkTemplate template, int uid, int set, int tag, int fields) {
        return getHistory(template, uid, set, tag, fields, Long.MIN_VALUE, JobStatus.NO_LATEST_RUNTIME);
    }

    public NetworkStatsHistory getHistory(NetworkTemplate template, int uid, int set, int tag, int fields, long start, long end) {
        NetworkStatsHistory combined = new NetworkStatsHistory(this.mBucketDuration, estimateBuckets(), fields);
        for (int i = 0; i < this.mStats.size(); i += VERSION_UID_INIT) {
            Key key = (Key) this.mStats.keyAt(i);
            boolean setMatches = set == -1 || key.set == set;
            if (key.uid == uid && setMatches && key.tag == tag && templateMatches(template, key.ident)) {
                combined.recordHistory((NetworkStatsHistory) this.mStats.valueAt(i), start, end);
            }
        }
        return combined;
    }

    public NetworkStats getSummary(NetworkTemplate template, long start, long end) {
        long now = System.currentTimeMillis();
        NetworkStats stats = new NetworkStats(end - start, 24);
        Entry entry = new Entry();
        NetworkStatsHistory.Entry historyEntry = null;
        if (start != end) {
            for (int i = 0; i < this.mStats.size(); i += VERSION_UID_INIT) {
                Key key = (Key) this.mStats.keyAt(i);
                if (templateMatches(template, key.ident)) {
                    historyEntry = ((NetworkStatsHistory) this.mStats.valueAt(i)).getValues(start, end, now, historyEntry);
                    entry.iface = NetworkStats.IFACE_ALL;
                    entry.uid = key.uid;
                    entry.set = key.set;
                    entry.tag = key.tag;
                    entry.rxBytes = historyEntry.rxBytes;
                    entry.rxPackets = historyEntry.rxPackets;
                    entry.txBytes = historyEntry.txBytes;
                    entry.txPackets = historyEntry.txPackets;
                    entry.operations = historyEntry.operations;
                    if (!entry.isEmpty()) {
                        stats.combineValues(entry);
                    }
                }
            }
        }
        return stats;
    }

    public void recordData(NetworkIdentitySet ident, int uid, int set, int tag, long start, long end, Entry entry) {
        NetworkStatsHistory history = findOrCreateHistory(ident, uid, set, tag);
        history.recordData(start, end, entry);
        noteRecordedHistory(history.getStart(), history.getEnd(), entry.txBytes + entry.rxBytes);
    }

    private void recordHistory(Key key, NetworkStatsHistory history) {
        if (history.size() != 0) {
            noteRecordedHistory(history.getStart(), history.getEnd(), history.getTotalBytes());
            NetworkStatsHistory target = (NetworkStatsHistory) this.mStats.get(key);
            if (target == null) {
                target = new NetworkStatsHistory(history.getBucketDuration());
                this.mStats.put(key, target);
            }
            target.recordEntireHistory(history);
        }
    }

    public void recordCollection(NetworkStatsCollection another) {
        for (int i = 0; i < another.mStats.size(); i += VERSION_UID_INIT) {
            recordHistory((Key) another.mStats.keyAt(i), (NetworkStatsHistory) another.mStats.valueAt(i));
        }
    }

    private NetworkStatsHistory findOrCreateHistory(NetworkIdentitySet ident, int uid, int set, int tag) {
        Key key = new Key(ident, uid, set, tag);
        NetworkStatsHistory existing = (NetworkStatsHistory) this.mStats.get(key);
        NetworkStatsHistory updated = null;
        if (existing == null) {
            updated = new NetworkStatsHistory(this.mBucketDuration, 10);
        } else if (existing.getBucketDuration() != this.mBucketDuration) {
            updated = new NetworkStatsHistory(existing, this.mBucketDuration);
        }
        if (updated == null) {
            return existing;
        }
        this.mStats.put(key, updated);
        return updated;
    }

    public void read(InputStream in) throws IOException {
        read(new DataInputStream(in));
    }

    public void read(DataInputStream in) throws IOException {
        int magic = in.readInt();
        if (magic != FILE_MAGIC) {
            throw new ProtocolException("unexpected magic: " + magic);
        }
        int version = in.readInt();
        switch (version) {
            case VERSION_UNIFIED_INIT /*16*/:
                int identSize = in.readInt();
                for (int i = 0; i < identSize; i += VERSION_UID_INIT) {
                    NetworkIdentitySet ident = new NetworkIdentitySet(in);
                    int size = in.readInt();
                    for (int j = 0; j < size; j += VERSION_UID_INIT) {
                        recordHistory(new Key(ident, in.readInt(), in.readInt(), in.readInt()), new NetworkStatsHistory(in));
                    }
                }
            default:
                throw new ProtocolException("unexpected version: " + version);
        }
    }

    public void write(DataOutputStream out) throws IOException {
        Key key;
        HashMap<NetworkIdentitySet, ArrayList<Key>> keysByIdent = Maps.newHashMap();
        for (Key key2 : this.mStats.keySet()) {
            ArrayList<Key> keys = (ArrayList) keysByIdent.get(key2.ident);
            if (keys == null) {
                keys = Lists.newArrayList();
                keysByIdent.put(key2.ident, keys);
            }
            keys.add(key2);
        }
        out.writeInt(FILE_MAGIC);
        out.writeInt(VERSION_UNIFIED_INIT);
        out.writeInt(keysByIdent.size());
        for (NetworkIdentitySet ident : keysByIdent.keySet()) {
            keys = (ArrayList) keysByIdent.get(ident);
            ident.writeToStream(out);
            out.writeInt(keys.size());
            Iterator i$ = keys.iterator();
            while (i$.hasNext()) {
                key2 = (Key) i$.next();
                NetworkStatsHistory history = (NetworkStatsHistory) this.mStats.get(key2);
                out.writeInt(key2.uid);
                out.writeInt(key2.set);
                out.writeInt(key2.tag);
                history.writeToStream(out);
            }
        }
        out.flush();
    }

    @Deprecated
    public void readLegacyNetwork(File file) throws IOException {
        Throwable th;
        DataInputStream in = null;
        try {
            DataInputStream in2 = new DataInputStream(new BufferedInputStream(new AtomicFile(file).openRead()));
            try {
                int magic = in2.readInt();
                if (magic != FILE_MAGIC) {
                    throw new ProtocolException("unexpected magic: " + magic);
                }
                int version = in2.readInt();
                switch (version) {
                    case VERSION_UID_INIT /*1*/:
                        int size = in2.readInt();
                        for (int i = 0; i < size; i += VERSION_UID_INIT) {
                            NetworkIdentitySet ident = new NetworkIdentitySet(in2);
                            recordHistory(new Key(ident, -1, -1, 0), new NetworkStatsHistory(in2));
                        }
                        IoUtils.closeQuietly(in2);
                        in = in2;
                    default:
                        throw new ProtocolException("unexpected version: " + version);
                }
            } catch (FileNotFoundException e) {
                in = in2;
                IoUtils.closeQuietly(in);
            } catch (Throwable th2) {
                th = th2;
                in = in2;
                IoUtils.closeQuietly(in);
                throw th;
            }
        } catch (FileNotFoundException e2) {
            IoUtils.closeQuietly(in);
        } catch (Throwable th3) {
            th = th3;
            IoUtils.closeQuietly(in);
            throw th;
        }
    }

    @Deprecated
    public void readLegacyUid(File file, boolean onlyTags) throws IOException {
        Throwable th;
        DataInputStream in = null;
        try {
            DataInputStream in2 = new DataInputStream(new BufferedInputStream(new AtomicFile(file).openRead()));
            try {
                int magic = in2.readInt();
                if (magic != FILE_MAGIC) {
                    throw new ProtocolException("unexpected magic: " + magic);
                }
                int version = in2.readInt();
                switch (version) {
                    case VERSION_UID_INIT /*1*/:
                    case VERSION_UID_WITH_IDENT /*2*/:
                        break;
                    case VERSION_UID_WITH_TAG /*3*/:
                    case VERSION_UID_WITH_SET /*4*/:
                        int identSize = in2.readInt();
                        for (int i = 0; i < identSize; i += VERSION_UID_INIT) {
                            NetworkIdentitySet ident = new NetworkIdentitySet(in2);
                            int size = in2.readInt();
                            for (int j = 0; j < size; j += VERSION_UID_INIT) {
                                int uid = in2.readInt();
                                int set = version >= VERSION_UID_WITH_SET ? in2.readInt() : 0;
                                int tag = in2.readInt();
                                Key key = new Key(ident, uid, set, tag);
                                NetworkStatsHistory history = new NetworkStatsHistory(in2);
                                if ((tag == 0) != onlyTags) {
                                    recordHistory(key, history);
                                }
                            }
                        }
                        break;
                    default:
                        throw new ProtocolException("unexpected version: " + version);
                }
                IoUtils.closeQuietly(in2);
                in = in2;
            } catch (FileNotFoundException e) {
                in = in2;
                IoUtils.closeQuietly(in);
            } catch (Throwable th2) {
                th = th2;
                in = in2;
                IoUtils.closeQuietly(in);
                throw th;
            }
        } catch (FileNotFoundException e2) {
            IoUtils.closeQuietly(in);
        } catch (Throwable th3) {
            th = th3;
            IoUtils.closeQuietly(in);
            throw th;
        }
    }

    public void removeUids(int[] uids) {
        ArrayList<Key> knownKeys = Lists.newArrayList();
        knownKeys.addAll(this.mStats.keySet());
        Iterator i$ = knownKeys.iterator();
        while (i$.hasNext()) {
            Key key = (Key) i$.next();
            if (ArrayUtils.contains(uids, key.uid)) {
                if (key.tag == 0) {
                    findOrCreateHistory(key.ident, -4, 0, 0).recordEntireHistory((NetworkStatsHistory) this.mStats.get(key));
                }
                this.mStats.remove(key);
                this.mDirty = true;
            }
        }
    }

    private void noteRecordedHistory(long startMillis, long endMillis, long totalBytes) {
        if (startMillis < this.mStartMillis) {
            this.mStartMillis = startMillis;
        }
        if (endMillis > this.mEndMillis) {
            this.mEndMillis = endMillis;
        }
        this.mTotalBytes += totalBytes;
        this.mDirty = true;
    }

    private int estimateBuckets() {
        return (int) (Math.min(this.mEndMillis - this.mStartMillis, 3024000000L) / this.mBucketDuration);
    }

    public void dump(IndentingPrintWriter pw) {
        ArrayList<Key> keys = Lists.newArrayList();
        keys.addAll(this.mStats.keySet());
        Collections.sort(keys);
        Iterator i$ = keys.iterator();
        while (i$.hasNext()) {
            Key key = (Key) i$.next();
            pw.print("ident=");
            pw.print(key.ident.toString());
            pw.print(" uid=");
            pw.print(key.uid);
            pw.print(" set=");
            pw.print(NetworkStats.setToString(key.set));
            pw.print(" tag=");
            pw.println(NetworkStats.tagToString(key.tag));
            NetworkStatsHistory history = (NetworkStatsHistory) this.mStats.get(key);
            pw.increaseIndent();
            history.dump(pw, true);
            pw.decreaseIndent();
        }
    }

    public void dumpCheckin(PrintWriter pw, long start, long end) {
        dumpCheckin(pw, start, end, NetworkTemplate.buildTemplateMobileWildcard(), "cell");
        dumpCheckin(pw, start, end, NetworkTemplate.buildTemplateWifiWildcard(), "wifi");
        dumpCheckin(pw, start, end, NetworkTemplate.buildTemplateEthernet(), "eth");
        dumpCheckin(pw, start, end, NetworkTemplate.buildTemplateBluetooth(), "bt");
    }

    private void dumpCheckin(PrintWriter pw, long start, long end, NetworkTemplate groupTemplate, String groupPrefix) {
        int i;
        ArrayMap<Key, NetworkStatsHistory> grouped = new ArrayMap();
        for (i = 0; i < this.mStats.size(); i += VERSION_UID_INIT) {
            Key key = (Key) this.mStats.keyAt(i);
            NetworkStatsHistory value = (NetworkStatsHistory) this.mStats.valueAt(i);
            if (templateMatches(groupTemplate, key.ident)) {
                Key groupKey = new Key(null, key.uid, key.set, key.tag);
                NetworkStatsHistory groupHistory = (NetworkStatsHistory) grouped.get(groupKey);
                if (groupHistory == null) {
                    groupHistory = new NetworkStatsHistory(value.getBucketDuration());
                    grouped.put(groupKey, groupHistory);
                }
                groupHistory.recordHistory(value, start, end);
            }
        }
        for (i = 0; i < grouped.size(); i += VERSION_UID_INIT) {
            key = (Key) grouped.keyAt(i);
            value = (NetworkStatsHistory) grouped.valueAt(i);
            if (value.size() != 0) {
                pw.print("c,");
                pw.print(groupPrefix);
                pw.print(',');
                pw.print(key.uid);
                pw.print(',');
                pw.print(NetworkStats.setToCheckinString(key.set));
                pw.print(',');
                pw.print(key.tag);
                pw.println();
                value.dumpCheckin(pw);
            }
        }
    }

    private static boolean templateMatches(NetworkTemplate template, NetworkIdentitySet identSet) {
        Iterator i$ = identSet.iterator();
        while (i$.hasNext()) {
            if (template.matches((NetworkIdentity) i$.next())) {
                return true;
            }
        }
        return false;
    }
}
