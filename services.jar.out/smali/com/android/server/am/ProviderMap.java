package com.android.server.am;

import android.content.ComponentName;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.SparseArray;
import com.android.internal.os.TransferPipe;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

public final class ProviderMap {
    private static final boolean DBG = false;
    private static final String TAG = "ProviderMap";
    private final ActivityManagerService mAm;
    private final SparseArray<HashMap<ComponentName, ContentProviderRecord>> mProvidersByClassPerUser;
    private final SparseArray<HashMap<String, ContentProviderRecord>> mProvidersByNamePerUser;
    private final HashMap<ComponentName, ContentProviderRecord> mSingletonByClass;
    private final HashMap<String, ContentProviderRecord> mSingletonByName;

    ProviderMap(ActivityManagerService am) {
        this.mSingletonByName = new HashMap();
        this.mSingletonByClass = new HashMap();
        this.mProvidersByNamePerUser = new SparseArray();
        this.mProvidersByClassPerUser = new SparseArray();
        this.mAm = am;
    }

    ContentProviderRecord getProviderByName(String name) {
        return getProviderByName(name, -1);
    }

    ContentProviderRecord getProviderByName(String name, int userId) {
        ContentProviderRecord record = (ContentProviderRecord) this.mSingletonByName.get(name);
        return record != null ? record : (ContentProviderRecord) getProvidersByName(userId).get(name);
    }

    ContentProviderRecord getProviderByClass(ComponentName name) {
        return getProviderByClass(name, -1);
    }

    ContentProviderRecord getProviderByClass(ComponentName name, int userId) {
        ContentProviderRecord record = (ContentProviderRecord) this.mSingletonByClass.get(name);
        return record != null ? record : (ContentProviderRecord) getProvidersByClass(userId).get(name);
    }

    void putProviderByName(String name, ContentProviderRecord record) {
        if (record.singleton) {
            this.mSingletonByName.put(name, record);
        } else {
            getProvidersByName(UserHandle.getUserId(record.appInfo.uid)).put(name, record);
        }
    }

    void putProviderByClass(ComponentName name, ContentProviderRecord record) {
        if (record.singleton) {
            this.mSingletonByClass.put(name, record);
        } else {
            getProvidersByClass(UserHandle.getUserId(record.appInfo.uid)).put(name, record);
        }
    }

    void removeProviderByName(String name, int userId) {
        if (this.mSingletonByName.containsKey(name)) {
            this.mSingletonByName.remove(name);
        } else if (userId < 0) {
            throw new IllegalArgumentException("Bad user " + userId);
        } else {
            HashMap<String, ContentProviderRecord> map = getProvidersByName(userId);
            map.remove(name);
            if (map.size() == 0) {
                this.mProvidersByNamePerUser.remove(userId);
            }
        }
    }

    void removeProviderByClass(ComponentName name, int userId) {
        if (this.mSingletonByClass.containsKey(name)) {
            this.mSingletonByClass.remove(name);
        } else if (userId < 0) {
            throw new IllegalArgumentException("Bad user " + userId);
        } else {
            HashMap<ComponentName, ContentProviderRecord> map = getProvidersByClass(userId);
            map.remove(name);
            if (map.size() == 0) {
                this.mProvidersByClassPerUser.remove(userId);
            }
        }
    }

    private HashMap<String, ContentProviderRecord> getProvidersByName(int userId) {
        if (userId < 0) {
            throw new IllegalArgumentException("Bad user " + userId);
        }
        HashMap<String, ContentProviderRecord> map = (HashMap) this.mProvidersByNamePerUser.get(userId);
        if (map != null) {
            return map;
        }
        HashMap<String, ContentProviderRecord> newMap = new HashMap();
        this.mProvidersByNamePerUser.put(userId, newMap);
        return newMap;
    }

    HashMap<ComponentName, ContentProviderRecord> getProvidersByClass(int userId) {
        if (userId < 0) {
            throw new IllegalArgumentException("Bad user " + userId);
        }
        HashMap<ComponentName, ContentProviderRecord> map = (HashMap) this.mProvidersByClassPerUser.get(userId);
        if (map != null) {
            return map;
        }
        HashMap<ComponentName, ContentProviderRecord> newMap = new HashMap();
        this.mProvidersByClassPerUser.put(userId, newMap);
        return newMap;
    }

    private boolean collectForceStopProvidersLocked(String name, int appId, boolean doit, boolean evenPersistent, int userId, HashMap<ComponentName, ContentProviderRecord> providers, ArrayList<ContentProviderRecord> result) {
        boolean didSomething = DBG;
        for (ContentProviderRecord provider : providers.values()) {
            if ((name == null || provider.info.packageName.equals(name)) && (provider.proc == null || evenPersistent || !provider.proc.persistent)) {
                if (!doit) {
                    return true;
                }
                didSomething = true;
                result.add(provider);
            }
        }
        return didSomething;
    }

    boolean collectForceStopProviders(String name, int appId, boolean doit, boolean evenPersistent, int userId, ArrayList<ContentProviderRecord> result) {
        boolean didSomething = DBG;
        if (userId == -1 || userId == 0) {
            didSomething = collectForceStopProvidersLocked(name, appId, doit, evenPersistent, userId, this.mSingletonByClass, result);
        }
        if (!doit && didSomething) {
            return true;
        }
        if (userId == -1) {
            for (int i = 0; i < this.mProvidersByClassPerUser.size(); i++) {
                if (collectForceStopProvidersLocked(name, appId, doit, evenPersistent, userId, (HashMap) this.mProvidersByClassPerUser.valueAt(i), result)) {
                    if (!doit) {
                        return true;
                    }
                    didSomething = true;
                }
            }
        } else {
            HashMap<ComponentName, ContentProviderRecord> items = getProvidersByClass(userId);
            if (items != null) {
                didSomething |= collectForceStopProvidersLocked(name, appId, doit, evenPersistent, userId, items, result);
            }
        }
        return didSomething;
    }

    private boolean dumpProvidersByClassLocked(PrintWriter pw, boolean dumpAll, String dumpPackage, String header, boolean needSep, HashMap<ComponentName, ContentProviderRecord> map) {
        boolean written = DBG;
        for (Entry<ComponentName, ContentProviderRecord> e : map.entrySet()) {
            ContentProviderRecord r = (ContentProviderRecord) e.getValue();
            if (dumpPackage == null || dumpPackage.equals(r.appInfo.packageName)) {
                if (needSep) {
                    pw.println("");
                    needSep = DBG;
                }
                if (header != null) {
                    pw.println(header);
                    header = null;
                }
                written = true;
                pw.print("  * ");
                pw.println(r);
                r.dump(pw, "    ", dumpAll);
            }
        }
        return written;
    }

    private boolean dumpProvidersByNameLocked(PrintWriter pw, String dumpPackage, String header, boolean needSep, HashMap<String, ContentProviderRecord> map) {
        boolean written = DBG;
        for (Entry<String, ContentProviderRecord> e : map.entrySet()) {
            ContentProviderRecord r = (ContentProviderRecord) e.getValue();
            if (dumpPackage == null || dumpPackage.equals(r.appInfo.packageName)) {
                if (needSep) {
                    pw.println("");
                    needSep = DBG;
                }
                if (header != null) {
                    pw.println(header);
                    header = null;
                }
                written = true;
                pw.print("  ");
                pw.print((String) e.getKey());
                pw.print(": ");
                pw.println(r.toShortString());
            }
        }
        return written;
    }

    boolean dumpProvidersLocked(PrintWriter pw, boolean dumpAll, String dumpPackage) {
        int i;
        boolean needSep = DBG;
        if (this.mSingletonByClass.size() > 0) {
            needSep = DBG | dumpProvidersByClassLocked(pw, dumpAll, dumpPackage, "  Published single-user content providers (by class):", DBG, this.mSingletonByClass);
        }
        for (i = 0; i < this.mProvidersByClassPerUser.size(); i++) {
            HashMap<ComponentName, ContentProviderRecord> map = (HashMap) this.mProvidersByClassPerUser.valueAt(i);
            needSep |= dumpProvidersByClassLocked(pw, dumpAll, dumpPackage, "  Published user " + this.mProvidersByClassPerUser.keyAt(i) + " content providers (by class):", needSep, map);
        }
        if (dumpAll) {
            needSep |= dumpProvidersByNameLocked(pw, dumpPackage, "  Single-user authority to provider mappings:", needSep, this.mSingletonByName);
            for (i = 0; i < this.mProvidersByNamePerUser.size(); i++) {
                needSep |= dumpProvidersByNameLocked(pw, dumpPackage, "  User " + this.mProvidersByNamePerUser.keyAt(i) + " authority to provider mappings:", needSep, (HashMap) this.mProvidersByNamePerUser.valueAt(i));
            }
        }
        return needSep;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected boolean dumpProvider(java.io.FileDescriptor r16, java.io.PrintWriter r17, java.lang.String r18, java.lang.String[] r19, int r20, boolean r21) {
        /*
        r15 = this;
        r8 = new java.util.ArrayList;
        r8.<init>();
        r13 = new java.util.ArrayList;
        r13.<init>();
        r2 = r15.mAm;
        monitor-enter(r2);
        r1 = r15.mSingletonByClass;	 Catch:{ all -> 0x008e }
        r1 = r1.values();	 Catch:{ all -> 0x008e }
        r8.addAll(r1);	 Catch:{ all -> 0x008e }
        r10 = 0;
    L_0x0017:
        r1 = r15.mProvidersByClassPerUser;	 Catch:{ all -> 0x008e }
        r1 = r1.size();	 Catch:{ all -> 0x008e }
        if (r10 >= r1) goto L_0x0031;
    L_0x001f:
        r1 = r15.mProvidersByClassPerUser;	 Catch:{ all -> 0x008e }
        r1 = r1.valueAt(r10);	 Catch:{ all -> 0x008e }
        r1 = (java.util.HashMap) r1;	 Catch:{ all -> 0x008e }
        r1 = r1.values();	 Catch:{ all -> 0x008e }
        r8.addAll(r1);	 Catch:{ all -> 0x008e }
        r10 = r10 + 1;
        goto L_0x0017;
    L_0x0031:
        r1 = "all";
        r0 = r18;
        r1 = r1.equals(r0);	 Catch:{ all -> 0x008e }
        if (r1 == 0) goto L_0x0047;
    L_0x003b:
        r13.addAll(r8);	 Catch:{ all -> 0x008e }
    L_0x003e:
        monitor-exit(r2);	 Catch:{ all -> 0x008e }
        r1 = r13.size();
        if (r1 > 0) goto L_0x009b;
    L_0x0045:
        r1 = 0;
    L_0x0046:
        return r1;
    L_0x0047:
        if (r18 == 0) goto L_0x0078;
    L_0x0049:
        r9 = android.content.ComponentName.unflattenFromString(r18);	 Catch:{ all -> 0x008e }
    L_0x004d:
        r12 = 0;
        if (r9 != 0) goto L_0x005b;
    L_0x0050:
        r1 = 16;
        r0 = r18;
        r12 = java.lang.Integer.parseInt(r0, r1);	 Catch:{ RuntimeException -> 0x00c2 }
        r18 = 0;
        r9 = 0;
    L_0x005b:
        r10 = 0;
    L_0x005c:
        r1 = r8.size();	 Catch:{ all -> 0x008e }
        if (r10 >= r1) goto L_0x003e;
    L_0x0062:
        r14 = r8.get(r10);	 Catch:{ all -> 0x008e }
        r14 = (com.android.server.am.ContentProviderRecord) r14;	 Catch:{ all -> 0x008e }
        if (r9 == 0) goto L_0x007a;
    L_0x006a:
        r1 = r14.name;	 Catch:{ all -> 0x008e }
        r1 = r1.equals(r9);	 Catch:{ all -> 0x008e }
        if (r1 == 0) goto L_0x0075;
    L_0x0072:
        r13.add(r14);	 Catch:{ all -> 0x008e }
    L_0x0075:
        r10 = r10 + 1;
        goto L_0x005c;
    L_0x0078:
        r9 = 0;
        goto L_0x004d;
    L_0x007a:
        if (r18 == 0) goto L_0x0091;
    L_0x007c:
        r1 = r14.name;	 Catch:{ all -> 0x008e }
        r1 = r1.flattenToString();	 Catch:{ all -> 0x008e }
        r0 = r18;
        r1 = r1.contains(r0);	 Catch:{ all -> 0x008e }
        if (r1 == 0) goto L_0x0075;
    L_0x008a:
        r13.add(r14);	 Catch:{ all -> 0x008e }
        goto L_0x0075;
    L_0x008e:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x008e }
        throw r1;
    L_0x0091:
        r1 = java.lang.System.identityHashCode(r14);	 Catch:{ all -> 0x008e }
        if (r1 != r12) goto L_0x0075;
    L_0x0097:
        r13.add(r14);	 Catch:{ all -> 0x008e }
        goto L_0x0075;
    L_0x009b:
        r11 = 0;
        r10 = 0;
    L_0x009d:
        r1 = r13.size();
        if (r10 >= r1) goto L_0x00c0;
    L_0x00a3:
        if (r11 == 0) goto L_0x00a8;
    L_0x00a5:
        r17.println();
    L_0x00a8:
        r11 = 1;
        r2 = "";
        r5 = r13.get(r10);
        r5 = (com.android.server.am.ContentProviderRecord) r5;
        r1 = r15;
        r3 = r16;
        r4 = r17;
        r6 = r19;
        r7 = r21;
        r1.dumpProvider(r2, r3, r4, r5, r6, r7);
        r10 = r10 + 1;
        goto L_0x009d;
    L_0x00c0:
        r1 = 1;
        goto L_0x0046;
    L_0x00c2:
        r1 = move-exception;
        goto L_0x005b;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ProviderMap.dumpProvider(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String, java.lang.String[], int, boolean):boolean");
    }

    private void dumpProvider(String prefix, FileDescriptor fd, PrintWriter pw, ContentProviderRecord r, String[] args, boolean dumpAll) {
        String innerPrefix = prefix + "  ";
        synchronized (this.mAm) {
            pw.print(prefix);
            pw.print("PROVIDER ");
            pw.print(r);
            pw.print(" pid=");
            if (r.proc != null) {
                pw.println(r.proc.pid);
            } else {
                pw.println("(not running)");
            }
            if (dumpAll) {
                r.dump(pw, innerPrefix, true);
            }
        }
        if (r.proc != null && r.proc.thread != null) {
            pw.println("    Client:");
            pw.flush();
            TransferPipe tp;
            try {
                tp = new TransferPipe();
                r.proc.thread.dumpProvider(tp.getWriteFd().getFileDescriptor(), r.provider.asBinder(), args);
                tp.setBufferPrefix("      ");
                tp.go(fd, 2000);
                tp.kill();
            } catch (IOException ex) {
                pw.println("      Failure while dumping the provider: " + ex);
            } catch (RemoteException e) {
                pw.println("      Got a RemoteException while dumping the service");
            } catch (Throwable th) {
                tp.kill();
            }
        }
    }
}
