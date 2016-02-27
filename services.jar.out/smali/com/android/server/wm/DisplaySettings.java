package com.android.server.wm;

import android.os.Environment;
import android.util.AtomicFile;
import android.util.Slog;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.XmlUtils;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class DisplaySettings {
    private static final String TAG = "WindowManager";
    private final HashMap<String, Entry> mEntries;
    private final AtomicFile mFile;

    public static class Entry {
        public final String name;
        public int overscanBottom;
        public int overscanLeft;
        public int overscanRight;
        public int overscanTop;

        public Entry(String _name) {
            this.name = _name;
        }
    }

    public void readSettingsLocked() {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find block by offset: 0x0049 in list []
	at jadx.core.utils.BlockUtils.getBlockByOffset(BlockUtils.java:42)
	at jadx.core.dex.instructions.IfNode.initBlocks(IfNode.java:58)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.initBlocksInIfNodes(BlockFinish.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockFinish.visit(BlockFinish.java:33)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r12 = this;
        r11 = 3;
        r8 = 2;
        r10 = 1;
        r7 = r12.mFile;	 Catch:{ FileNotFoundException -> 0x004d }
        r3 = r7.openRead();	 Catch:{ FileNotFoundException -> 0x004d }
        r4 = 0;
        r2 = android.util.Xml.newPullParser();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r7 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r7 = r7.name();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r2.setInput(r3, r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0017:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r6 == r8) goto L_0x001f;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x001d:
        if (r6 != r10) goto L_0x0017;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x001f:
        if (r6 == r8) goto L_0x0073;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0021:
        r7 = new java.lang.IllegalStateException;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = "no start tag found";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r7.<init>(r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        throw r7;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0029:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x0049;
    L_0x0044:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0049:
        r3.close();	 Catch:{ IOException -> 0x019c }
    L_0x004c:
        return;
    L_0x004d:
        r0 = move-exception;
        r7 = "WindowManager";
        r8 = new java.lang.StringBuilder;
        r8.<init>();
        r9 = "No existing display settings ";
        r8 = r8.append(r9);
        r9 = r12.mFile;
        r9 = r9.getBaseFile();
        r8 = r8.append(r9);
        r9 = "; starting empty";
        r8 = r8.append(r9);
        r8 = r8.toString();
        android.util.Slog.i(r7, r8);
        goto L_0x004c;
    L_0x0073:
        r1 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0077:
        r6 = r2.next();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r6 == r10) goto L_0x0108;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x007d:
        if (r6 != r11) goto L_0x0085;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x007f:
        r7 = r2.getDepth();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r7 <= r1) goto L_0x0108;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0085:
        if (r6 == r11) goto L_0x0077;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0087:
        r7 = 4;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r6 == r7) goto L_0x0077;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x008a:
        r5 = r2.getName();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r7 = "display";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r7 = r5.equals(r7);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r7 == 0) goto L_0x00c0;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
    L_0x0096:
        r12.readDisplay(r2);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        goto L_0x0077;
    L_0x009a:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x00ba;
    L_0x00b5:
        r7 = r12.mEntries;
        r7.clear();
    L_0x00ba:
        r3.close();	 Catch:{ IOException -> 0x00be }
        goto L_0x004c;
    L_0x00be:
        r7 = move-exception;
        goto L_0x004c;
    L_0x00c0:
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Unknown element under <display-settings>: ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = r2.getName();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        com.android.internal.util.XmlUtils.skipCurrentTag(r2);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        goto L_0x0077;
    L_0x00e0:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x0100;
    L_0x00fb:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0100:
        r3.close();	 Catch:{ IOException -> 0x0105 }
        goto L_0x004c;
    L_0x0105:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0108:
        r4 = 1;
        if (r4 != 0) goto L_0x0110;
    L_0x010b:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0110:
        r3.close();	 Catch:{ IOException -> 0x0115 }
        goto L_0x004c;
    L_0x0115:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0118:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x0138;
    L_0x0133:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0138:
        r3.close();	 Catch:{ IOException -> 0x013d }
        goto L_0x004c;
    L_0x013d:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0140:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x0160;
    L_0x015b:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0160:
        r3.close();	 Catch:{ IOException -> 0x0165 }
        goto L_0x004c;
    L_0x0165:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0168:
        r0 = move-exception;
        r7 = "WindowManager";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = new java.lang.StringBuilder;	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8.<init>();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r9 = "Failed parsing ";	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r9);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.append(r0);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        r8 = r8.toString();	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        android.util.Slog.w(r7, r8);	 Catch:{ IllegalStateException -> 0x0029, NullPointerException -> 0x009a, NumberFormatException -> 0x00e0, XmlPullParserException -> 0x0118, IOException -> 0x0140, IndexOutOfBoundsException -> 0x0168, all -> 0x0190 }
        if (r4 != 0) goto L_0x0188;
    L_0x0183:
        r7 = r12.mEntries;
        r7.clear();
    L_0x0188:
        r3.close();	 Catch:{ IOException -> 0x018d }
        goto L_0x004c;
    L_0x018d:
        r7 = move-exception;
        goto L_0x004c;
    L_0x0190:
        r7 = move-exception;
        if (r4 != 0) goto L_0x0198;
    L_0x0193:
        r8 = r12.mEntries;
        r8.clear();
    L_0x0198:
        r3.close();	 Catch:{ IOException -> 0x019f }
    L_0x019b:
        throw r7;
    L_0x019c:
        r7 = move-exception;
        goto L_0x004c;
    L_0x019f:
        r8 = move-exception;
        goto L_0x019b;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.DisplaySettings.readSettingsLocked():void");
    }

    public DisplaySettings() {
        this.mEntries = new HashMap();
        this.mFile = new AtomicFile(new File(new File(Environment.getDataDirectory(), "system"), "display_settings.xml"));
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void getOverscanLocked(java.lang.String r4, java.lang.String r5, android.graphics.Rect r6) {
        /*
        r3 = this;
        r2 = 0;
        if (r5 == 0) goto L_0x000d;
    L_0x0003:
        r1 = r3.mEntries;
        r0 = r1.get(r5);
        r0 = (com.android.server.wm.DisplaySettings.Entry) r0;
        if (r0 != 0) goto L_0x0015;
    L_0x000d:
        r1 = r3.mEntries;
        r0 = r1.get(r4);
        r0 = (com.android.server.wm.DisplaySettings.Entry) r0;
    L_0x0015:
        if (r0 == 0) goto L_0x0028;
    L_0x0017:
        r1 = r0.overscanLeft;
        r6.left = r1;
        r1 = r0.overscanTop;
        r6.top = r1;
        r1 = r0.overscanRight;
        r6.right = r1;
        r1 = r0.overscanBottom;
        r6.bottom = r1;
    L_0x0027:
        return;
    L_0x0028:
        r6.set(r2, r2, r2, r2);
        goto L_0x0027;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.DisplaySettings.getOverscanLocked(java.lang.String, java.lang.String, android.graphics.Rect):void");
    }

    public void setOverscanLocked(String name, int left, int top, int right, int bottom) {
        if (left == 0 && top == 0 && right == 0 && bottom == 0) {
            this.mEntries.remove(name);
            return;
        }
        Entry entry = (Entry) this.mEntries.get(name);
        if (entry == null) {
            entry = new Entry(name);
            this.mEntries.put(name, entry);
        }
        entry.overscanLeft = left;
        entry.overscanTop = top;
        entry.overscanRight = right;
        entry.overscanBottom = bottom;
    }

    private int getIntAttribute(XmlPullParser parser, String name) {
        int i = 0;
        try {
            String str = parser.getAttributeValue(null, name);
            if (str != null) {
                i = Integer.parseInt(str);
            }
        } catch (NumberFormatException e) {
        }
        return i;
    }

    private void readDisplay(XmlPullParser parser) throws NumberFormatException, XmlPullParserException, IOException {
        String name = parser.getAttributeValue(null, "name");
        if (name != null) {
            Entry entry = new Entry(name);
            entry.overscanLeft = getIntAttribute(parser, "overscanLeft");
            entry.overscanTop = getIntAttribute(parser, "overscanTop");
            entry.overscanRight = getIntAttribute(parser, "overscanRight");
            entry.overscanBottom = getIntAttribute(parser, "overscanBottom");
            this.mEntries.put(name, entry);
        }
        XmlUtils.skipCurrentTag(parser);
    }

    public void writeSettingsLocked() {
        try {
            FileOutputStream stream = this.mFile.startWrite();
            try {
                XmlSerializer out = new FastXmlSerializer();
                out.setOutput(stream, StandardCharsets.UTF_8.name());
                out.startDocument(null, Boolean.valueOf(true));
                out.startTag(null, "display-settings");
                for (Entry entry : this.mEntries.values()) {
                    out.startTag(null, "display");
                    out.attribute(null, "name", entry.name);
                    if (entry.overscanLeft != 0) {
                        out.attribute(null, "overscanLeft", Integer.toString(entry.overscanLeft));
                    }
                    if (entry.overscanTop != 0) {
                        out.attribute(null, "overscanTop", Integer.toString(entry.overscanTop));
                    }
                    if (entry.overscanRight != 0) {
                        out.attribute(null, "overscanRight", Integer.toString(entry.overscanRight));
                    }
                    if (entry.overscanBottom != 0) {
                        out.attribute(null, "overscanBottom", Integer.toString(entry.overscanBottom));
                    }
                    out.endTag(null, "display");
                }
                out.endTag(null, "display-settings");
                out.endDocument();
                this.mFile.finishWrite(stream);
            } catch (IOException e) {
                Slog.w(TAG, "Failed to write display settings, restoring backup.", e);
                this.mFile.failWrite(stream);
            }
        } catch (IOException e2) {
            Slog.w(TAG, "Failed to write display settings: " + e2);
        }
    }
}
