package com.android.internal.telephony.test;

import java.io.InputStream;

/* compiled from: ModelInterpreter */
class LineReader {
    static final int BUFFER_SIZE = 4096;
    byte[] mBuffer;
    InputStream mInStream;

    LineReader(InputStream s) {
        this.mBuffer = new byte[BUFFER_SIZE];
        this.mInStream = s;
    }

    String getNextLine() {
        return getNextLine(false);
    }

    String getNextLineCtrlZ() {
        return getNextLine(true);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    java.lang.String getNextLine(boolean r10) {
        /*
        r9 = this;
        r4 = 0;
        r1 = 0;
        r2 = r1;
    L_0x0003:
        r5 = r9.mInStream;	 Catch:{ IOException -> 0x0034, IndexOutOfBoundsException -> 0x0037 }
        r3 = r5.read();	 Catch:{ IOException -> 0x0034, IndexOutOfBoundsException -> 0x0037 }
        if (r3 >= 0) goto L_0x000d;
    L_0x000b:
        r1 = r2;
    L_0x000c:
        return r4;
    L_0x000d:
        if (r10 == 0) goto L_0x0020;
    L_0x000f:
        r5 = 26;
        if (r3 != r5) goto L_0x0020;
    L_0x0013:
        r1 = r2;
    L_0x0014:
        r5 = new java.lang.String;	 Catch:{ UnsupportedEncodingException -> 0x0041 }
        r6 = r9.mBuffer;	 Catch:{ UnsupportedEncodingException -> 0x0041 }
        r7 = 0;
        r8 = "US-ASCII";
        r5.<init>(r6, r7, r1, r8);	 Catch:{ UnsupportedEncodingException -> 0x0041 }
        r4 = r5;
        goto L_0x000c;
    L_0x0020:
        r5 = 13;
        if (r3 == r5) goto L_0x0028;
    L_0x0024:
        r5 = 10;
        if (r3 != r5) goto L_0x002b;
    L_0x0028:
        if (r2 != 0) goto L_0x0013;
    L_0x002a:
        goto L_0x0003;
    L_0x002b:
        r5 = r9.mBuffer;	 Catch:{ IOException -> 0x0034, IndexOutOfBoundsException -> 0x0037 }
        r1 = r2 + 1;
        r6 = (byte) r3;
        r5[r2] = r6;	 Catch:{ IOException -> 0x004c, IndexOutOfBoundsException -> 0x004a }
        r2 = r1;
        goto L_0x0003;
    L_0x0034:
        r0 = move-exception;
        r1 = r2;
    L_0x0036:
        goto L_0x000c;
    L_0x0037:
        r0 = move-exception;
        r1 = r2;
    L_0x0039:
        r5 = java.lang.System.err;
        r6 = "ATChannel: buffer overflow";
        r5.println(r6);
        goto L_0x0014;
    L_0x0041:
        r0 = move-exception;
        r5 = java.lang.System.err;
        r6 = "ATChannel: implausable UnsupportedEncodingException";
        r5.println(r6);
        goto L_0x000c;
    L_0x004a:
        r0 = move-exception;
        goto L_0x0039;
    L_0x004c:
        r0 = move-exception;
        goto L_0x0036;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.LineReader.getNextLine(boolean):java.lang.String");
    }
}
