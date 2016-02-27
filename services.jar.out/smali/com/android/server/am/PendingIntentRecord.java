package com.android.server.am;

import android.content.IIntentReceiver;
import android.content.IIntentSender.Stub;
import android.content.Intent;
import android.os.Bundle;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;

final class PendingIntentRecord extends Stub {
    boolean canceled;
    final Key key;
    String lastTag;
    String lastTagPrefix;
    final ActivityManagerService owner;
    final WeakReference<PendingIntentRecord> ref;
    boolean sent;
    String stringName;
    final int uid;

    static final class Key {
        private static final int ODD_PRIME_NUMBER = 37;
        final ActivityRecord activity;
        Intent[] allIntents;
        String[] allResolvedTypes;
        final int flags;
        final int hashCode;
        final Bundle options;
        final String packageName;
        final int requestCode;
        final Intent requestIntent;
        final String requestResolvedType;
        final int type;
        final int userId;
        final String who;

        Key(int _t, String _p, ActivityRecord _a, String _w, int _r, Intent[] _i, String[] _it, int _f, Bundle _o, int _userId) {
            Intent intent;
            String str = null;
            this.type = _t;
            this.packageName = _p;
            this.activity = _a;
            this.who = _w;
            this.requestCode = _r;
            if (_i != null) {
                intent = _i[_i.length - 1];
            } else {
                intent = null;
            }
            this.requestIntent = intent;
            if (_it != null) {
                str = _it[_it.length - 1];
            }
            this.requestResolvedType = str;
            this.allIntents = _i;
            this.allResolvedTypes = _it;
            this.flags = _f;
            this.options = _o;
            this.userId = _userId;
            int hash = ((((_f + 851) * ODD_PRIME_NUMBER) + _r) * ODD_PRIME_NUMBER) + _userId;
            if (_w != null) {
                hash = (hash * ODD_PRIME_NUMBER) + _w.hashCode();
            }
            if (_a != null) {
                hash = (hash * ODD_PRIME_NUMBER) + _a.hashCode();
            }
            if (this.requestIntent != null) {
                hash = (hash * ODD_PRIME_NUMBER) + this.requestIntent.filterHashCode();
            }
            if (this.requestResolvedType != null) {
                hash = (hash * ODD_PRIME_NUMBER) + this.requestResolvedType.hashCode();
            }
            this.hashCode = (((hash * ODD_PRIME_NUMBER) + _p.hashCode()) * ODD_PRIME_NUMBER) + _t;
        }

        public boolean equals(Object otherObj) {
            if (otherObj == null) {
                return false;
            }
            try {
                Key other = (Key) otherObj;
                if (this.type != other.type || this.userId != other.userId || !this.packageName.equals(other.packageName) || this.activity != other.activity) {
                    return false;
                }
                if (this.who != other.who) {
                    if (this.who != null) {
                        if (!this.who.equals(other.who)) {
                            return false;
                        }
                    } else if (other.who != null) {
                        return false;
                    }
                }
                if (this.requestCode != other.requestCode) {
                    return false;
                }
                if (this.requestIntent != other.requestIntent) {
                    if (this.requestIntent != null) {
                        if (!this.requestIntent.filterEquals(other.requestIntent)) {
                            return false;
                        }
                    } else if (other.requestIntent != null) {
                        return false;
                    }
                }
                if (this.requestResolvedType != other.requestResolvedType) {
                    if (this.requestResolvedType != null) {
                        if (!this.requestResolvedType.equals(other.requestResolvedType)) {
                            return false;
                        }
                    } else if (other.requestResolvedType != null) {
                        return false;
                    }
                }
                if (this.flags == other.flags) {
                    return true;
                }
                return false;
            } catch (ClassCastException e) {
                return false;
            }
        }

        public int hashCode() {
            return this.hashCode;
        }

        public String toString() {
            return "Key{" + typeName() + " pkg=" + this.packageName + " intent=" + (this.requestIntent != null ? this.requestIntent.toShortString(false, true, false, false) : "<null>") + " flags=0x" + Integer.toHexString(this.flags) + " u=" + this.userId + "}";
        }

        String typeName() {
            switch (this.type) {
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    return "broadcastIntent";
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    return "startActivity";
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    return "activityResult";
                case C0569H.DO_TRAVERSAL /*4*/:
                    return "startService";
                default:
                    return Integer.toString(this.type);
            }
        }
    }

    PendingIntentRecord(ActivityManagerService _owner, Key _k, int _u) {
        this.sent = false;
        this.canceled = false;
        this.owner = _owner;
        this.key = _k;
        this.uid = _u;
        this.ref = new WeakReference(this);
    }

    public int send(int code, Intent intent, String resolvedType, IIntentReceiver finishedReceiver, String requiredPermission) {
        return sendInner(code, intent, resolvedType, finishedReceiver, requiredPermission, null, null, 0, 0, 0, null, null);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    int sendInner(int r32, android.content.Intent r33, java.lang.String r34, android.content.IIntentReceiver r35, java.lang.String r36, android.os.IBinder r37, java.lang.String r38, int r39, int r40, int r41, android.os.Bundle r42, android.app.IActivityContainer r43) {
        /*
        r31 = this;
        r0 = r31;
        r0 = r0.owner;
        r30 = r0;
        monitor-enter(r30);
        r0 = r31;
        r2 = r0.canceled;	 Catch:{ all -> 0x00b9 }
        if (r2 != 0) goto L_0x0216;
    L_0x000d:
        r2 = 1;
        r0 = r31;
        r0.sent = r2;	 Catch:{ all -> 0x00b9 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.flags;	 Catch:{ all -> 0x00b9 }
        r3 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;
        r2 = r2 & r3;
        if (r2 == 0) goto L_0x002c;
    L_0x001d:
        r0 = r31;
        r2 = r0.owner;	 Catch:{ all -> 0x00b9 }
        r3 = 1;
        r0 = r31;
        r2.cancelIntentSenderLocked(r0, r3);	 Catch:{ all -> 0x00b9 }
        r2 = 1;
        r0 = r31;
        r0.canceled = r2;	 Catch:{ all -> 0x00b9 }
    L_0x002c:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.requestIntent;	 Catch:{ all -> 0x00b9 }
        if (r2 == 0) goto L_0x00b3;
    L_0x0034:
        r13 = new android.content.Intent;	 Catch:{ all -> 0x00b9 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.requestIntent;	 Catch:{ all -> 0x00b9 }
        r13.<init>(r2);	 Catch:{ all -> 0x00b9 }
    L_0x003f:
        if (r33 == 0) goto L_0x00bc;
    L_0x0041:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.flags;	 Catch:{ all -> 0x00b9 }
        r0 = r33;
        r23 = r13.fillIn(r0, r2);	 Catch:{ all -> 0x00b9 }
        r2 = r23 & 2;
        if (r2 != 0) goto L_0x0059;
    L_0x0051:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.requestResolvedType;	 Catch:{ all -> 0x00b9 }
        r34 = r0;
    L_0x0059:
        r0 = r40;
        r0 = r0 & -196;
        r40 = r0;
        r41 = r41 & r40;
        r2 = r13.getFlags();	 Catch:{ all -> 0x00b9 }
        r3 = r40 ^ -1;
        r2 = r2 & r3;
        r2 = r2 | r41;
        r13.setFlags(r2);	 Catch:{ all -> 0x00b9 }
        r26 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x00b9 }
        if (r35 == 0) goto L_0x00c5;
    L_0x0073:
        r28 = 1;
    L_0x0075:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r9 = r2.userId;	 Catch:{ all -> 0x00b9 }
        r2 = -2;
        if (r9 != r2) goto L_0x0086;
    L_0x007e:
        r0 = r31;
        r2 = r0.owner;	 Catch:{ all -> 0x00b9 }
        r9 = r2.getCurrentUserIdLocked();	 Catch:{ all -> 0x00b9 }
    L_0x0086:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.type;	 Catch:{ all -> 0x00b9 }
        switch(r2) {
            case 1: goto L_0x01c0;
            case 2: goto L_0x00c8;
            case 3: goto L_0x0194;
            case 4: goto L_0x01fb;
            default: goto L_0x008f;
        };
    L_0x008f:
        if (r28 == 0) goto L_0x00ad;
    L_0x0091:
        r15 = new android.content.Intent;	 Catch:{ RemoteException -> 0x021a }
        r15.<init>(r13);	 Catch:{ RemoteException -> 0x021a }
        r16 = 0;
        r17 = 0;
        r18 = 0;
        r19 = 0;
        r20 = 0;
        r0 = r31;
        r2 = r0.key;	 Catch:{ RemoteException -> 0x021a }
        r0 = r2.userId;	 Catch:{ RemoteException -> 0x021a }
        r21 = r0;
        r14 = r35;
        r14.performReceive(r15, r16, r17, r18, r19, r20, r21);	 Catch:{ RemoteException -> 0x021a }
    L_0x00ad:
        android.os.Binder.restoreCallingIdentity(r26);	 Catch:{ all -> 0x00b9 }
        r2 = 0;
        monitor-exit(r30);	 Catch:{ all -> 0x00b9 }
    L_0x00b2:
        return r2;
    L_0x00b3:
        r13 = new android.content.Intent;	 Catch:{ all -> 0x00b9 }
        r13.<init>();	 Catch:{ all -> 0x00b9 }
        goto L_0x003f;
    L_0x00b9:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x00b9 }
        throw r2;
    L_0x00bc:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.requestResolvedType;	 Catch:{ all -> 0x00b9 }
        r34 = r0;
        goto L_0x0059;
    L_0x00c5:
        r28 = 0;
        goto L_0x0075;
    L_0x00c8:
        if (r42 != 0) goto L_0x014f;
    L_0x00ca:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.options;	 Catch:{ all -> 0x00b9 }
        r42 = r0;
    L_0x00d2:
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        if (r2 == 0) goto L_0x016f;
    L_0x00da:
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.length;	 Catch:{ RuntimeException -> 0x0143 }
        r3 = 1;
        if (r2 <= r3) goto L_0x016f;
    L_0x00e4:
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.length;	 Catch:{ RuntimeException -> 0x0143 }
        r5 = new android.content.Intent[r2];	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.length;	 Catch:{ RuntimeException -> 0x0143 }
        r6 = new java.lang.String[r2];	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        r3 = 0;
        r4 = 0;
        r0 = r31;
        r7 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r7 = r7.allIntents;	 Catch:{ RuntimeException -> 0x0143 }
        r7 = r7.length;	 Catch:{ RuntimeException -> 0x0143 }
        java.lang.System.arraycopy(r2, r3, r5, r4, r7);	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allResolvedTypes;	 Catch:{ RuntimeException -> 0x0143 }
        if (r2 == 0) goto L_0x0122;
    L_0x0110:
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2.allResolvedTypes;	 Catch:{ RuntimeException -> 0x0143 }
        r3 = 0;
        r4 = 0;
        r0 = r31;
        r7 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r7 = r7.allResolvedTypes;	 Catch:{ RuntimeException -> 0x0143 }
        r7 = r7.length;	 Catch:{ RuntimeException -> 0x0143 }
        java.lang.System.arraycopy(r2, r3, r6, r4, r7);	 Catch:{ RuntimeException -> 0x0143 }
    L_0x0122:
        r2 = r5.length;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2 + -1;
        r5[r2] = r13;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r6.length;	 Catch:{ RuntimeException -> 0x0143 }
        r2 = r2 + -1;
        r6[r2] = r34;	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r2 = r0.owner;	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r3 = r0.uid;	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r4 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r4 = r4.packageName;	 Catch:{ RuntimeException -> 0x0143 }
        r7 = r37;
        r8 = r42;
        r2.startActivitiesInPackage(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ RuntimeException -> 0x0143 }
        goto L_0x008f;
    L_0x0143:
        r24 = move-exception;
        r2 = "ActivityManager";
        r3 = "Unable to send startActivity intent";
        r0 = r24;
        android.util.Slog.w(r2, r3, r0);	 Catch:{ all -> 0x00b9 }
        goto L_0x008f;
    L_0x014f:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.options;	 Catch:{ all -> 0x00b9 }
        if (r2 == 0) goto L_0x00d2;
    L_0x0157:
        r25 = new android.os.Bundle;	 Catch:{ all -> 0x00b9 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.options;	 Catch:{ all -> 0x00b9 }
        r0 = r25;
        r0.<init>(r2);	 Catch:{ all -> 0x00b9 }
        r0 = r25;
        r1 = r42;
        r0.putAll(r1);	 Catch:{ all -> 0x00b9 }
        r42 = r25;
        goto L_0x00d2;
    L_0x016f:
        r0 = r31;
        r10 = r0.owner;	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r11 = r0.uid;	 Catch:{ RuntimeException -> 0x0143 }
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x0143 }
        r12 = r2.packageName;	 Catch:{ RuntimeException -> 0x0143 }
        r18 = 0;
        r22 = 0;
        r14 = r34;
        r15 = r37;
        r16 = r38;
        r17 = r39;
        r19 = r42;
        r20 = r9;
        r21 = r43;
        r10.startActivityInPackage(r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22);	 Catch:{ RuntimeException -> 0x0143 }
        goto L_0x008f;
    L_0x0194:
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r2 = r2.activity;	 Catch:{ all -> 0x00b9 }
        r2 = r2.task;	 Catch:{ all -> 0x00b9 }
        r14 = r2.stack;	 Catch:{ all -> 0x00b9 }
        r15 = -1;
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.activity;	 Catch:{ all -> 0x00b9 }
        r16 = r0;
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.who;	 Catch:{ all -> 0x00b9 }
        r17 = r0;
        r0 = r31;
        r2 = r0.key;	 Catch:{ all -> 0x00b9 }
        r0 = r2.requestCode;	 Catch:{ all -> 0x00b9 }
        r18 = r0;
        r19 = r32;
        r20 = r13;
        r14.sendActivityResultLocked(r15, r16, r17, r18, r19, r20);	 Catch:{ all -> 0x00b9 }
        goto L_0x008f;
    L_0x01c0:
        r0 = r31;
        r10 = r0.owner;	 Catch:{ RuntimeException -> 0x01ef }
        r0 = r31;
        r2 = r0.key;	 Catch:{ RuntimeException -> 0x01ef }
        r11 = r2.packageName;	 Catch:{ RuntimeException -> 0x01ef }
        r0 = r31;
        r12 = r0.uid;	 Catch:{ RuntimeException -> 0x01ef }
        r17 = 0;
        r18 = 0;
        if (r35 == 0) goto L_0x01ec;
    L_0x01d4:
        r20 = 1;
    L_0x01d6:
        r21 = 0;
        r14 = r34;
        r15 = r35;
        r16 = r32;
        r19 = r36;
        r22 = r9;
        r29 = r10.broadcastIntentInPackage(r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22);	 Catch:{ RuntimeException -> 0x01ef }
        if (r29 != 0) goto L_0x008f;
    L_0x01e8:
        r28 = 0;
        goto L_0x008f;
    L_0x01ec:
        r20 = 0;
        goto L_0x01d6;
    L_0x01ef:
        r24 = move-exception;
        r2 = "ActivityManager";
        r3 = "Unable to send startActivity intent";
        r0 = r24;
        android.util.Slog.w(r2, r3, r0);	 Catch:{ all -> 0x00b9 }
        goto L_0x008f;
    L_0x01fb:
        r0 = r31;
        r2 = r0.owner;	 Catch:{ RuntimeException -> 0x020a }
        r0 = r31;
        r3 = r0.uid;	 Catch:{ RuntimeException -> 0x020a }
        r0 = r34;
        r2.startServiceInPackage(r3, r13, r0, r9);	 Catch:{ RuntimeException -> 0x020a }
        goto L_0x008f;
    L_0x020a:
        r24 = move-exception;
        r2 = "ActivityManager";
        r3 = "Unable to send startService intent";
        r0 = r24;
        android.util.Slog.w(r2, r3, r0);	 Catch:{ all -> 0x00b9 }
        goto L_0x008f;
    L_0x0216:
        monitor-exit(r30);	 Catch:{ all -> 0x00b9 }
        r2 = -6;
        goto L_0x00b2;
    L_0x021a:
        r2 = move-exception;
        goto L_0x00ad;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.PendingIntentRecord.sendInner(int, android.content.Intent, java.lang.String, android.content.IIntentReceiver, java.lang.String, android.os.IBinder, java.lang.String, int, int, int, android.os.Bundle, android.app.IActivityContainer):int");
    }

    protected void finalize() throws Throwable {
        try {
            if (!this.canceled) {
                this.owner.mHandler.sendMessage(this.owner.mHandler.obtainMessage(23, this));
            }
            super.finalize();
        } catch (Throwable th) {
            super.finalize();
        }
    }

    public void completeFinalize() {
        synchronized (this.owner) {
            if (((WeakReference) this.owner.mIntentSenderRecords.get(this.key)) == this.ref) {
                this.owner.mIntentSenderRecords.remove(this.key);
            }
        }
    }

    void dump(PrintWriter pw, String prefix) {
        pw.print(prefix);
        pw.print("uid=");
        pw.print(this.uid);
        pw.print(" packageName=");
        pw.print(this.key.packageName);
        pw.print(" type=");
        pw.print(this.key.typeName());
        pw.print(" flags=0x");
        pw.println(Integer.toHexString(this.key.flags));
        if (!(this.key.activity == null && this.key.who == null)) {
            pw.print(prefix);
            pw.print("activity=");
            pw.print(this.key.activity);
            pw.print(" who=");
            pw.println(this.key.who);
        }
        if (!(this.key.requestCode == 0 && this.key.requestResolvedType == null)) {
            pw.print(prefix);
            pw.print("requestCode=");
            pw.print(this.key.requestCode);
            pw.print(" requestResolvedType=");
            pw.println(this.key.requestResolvedType);
        }
        if (this.key.requestIntent != null) {
            pw.print(prefix);
            pw.print("requestIntent=");
            pw.println(this.key.requestIntent.toShortString(false, true, true, true));
        }
        if (this.sent || this.canceled) {
            pw.print(prefix);
            pw.print("sent=");
            pw.print(this.sent);
            pw.print(" canceled=");
            pw.println(this.canceled);
        }
    }

    public String toString() {
        if (this.stringName != null) {
            return this.stringName;
        }
        StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
        sb.append("PendingIntentRecord{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(' ');
        sb.append(this.key.packageName);
        sb.append(' ');
        sb.append(this.key.typeName());
        sb.append('}');
        String stringBuilder = sb.toString();
        this.stringName = stringBuilder;
        return stringBuilder;
    }
}
