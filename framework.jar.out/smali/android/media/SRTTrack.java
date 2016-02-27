package android.media;

import android.media.SubtitleTrack.Cue;
import android.os.Handler;
import android.os.Parcel;
import android.util.Log;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Vector;

/* compiled from: SRTRenderer */
class SRTTrack extends WebVttTrack {
    private static final int KEY_LOCAL_SETTING = 102;
    private static final int KEY_START_TIME = 7;
    private static final int KEY_STRUCT_TEXT = 16;
    private static final int MEDIA_TIMED_TEXT = 99;
    private static final String TAG = "SRTTrack";
    private final Handler mEventHandler;

    SRTTrack(WebVttRenderingWidget renderingWidget, MediaFormat format) {
        super(renderingWidget, format);
        this.mEventHandler = null;
    }

    SRTTrack(Handler eventHandler, MediaFormat format) {
        super(null, format);
        this.mEventHandler = eventHandler;
    }

    protected void onData(SubtitleData data) {
        try {
            TextTrackCue cue = new TextTrackCue();
            cue.mStartTimeMs = data.getStartTimeUs() / 1000;
            cue.mEndTimeMs = (data.getStartTimeUs() + data.getDurationUs()) / 1000;
            String[] lines = new String(data.getData(), "UTF-8").split("\\r?\\n");
            cue.mLines = new TextTrackCueSpan[lines.length][];
            int len$ = lines.length;
            int i$ = 0;
            int i = 0;
            while (i$ < len$) {
                int i2 = i + 1;
                cue.mLines[i] = new TextTrackCueSpan[]{new TextTrackCueSpan(arr$[i$], -1)};
                i$++;
                i = i2;
            }
            addCue(cue);
        } catch (UnsupportedEncodingException e) {
            Log.w(TAG, "subtitle data is not UTF-8 encoded: " + e);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void onData(byte[] r23, boolean r24, long r25) {
        /*
        r22 = this;
        r14 = new java.io.InputStreamReader;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = new java.io.ByteArrayInputStream;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r18;
        r1 = r23;
        r0.<init>(r1);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r19 = "UTF-8";
        r0 = r18;
        r1 = r19;
        r14.<init>(r0, r1);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r4 = new java.io.BufferedReader;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r4.<init>(r14);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
    L_0x0019:
        r7 = r4.readLine();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        if (r7 == 0) goto L_0x0025;
    L_0x001f:
        r7 = r4.readLine();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        if (r7 != 0) goto L_0x0026;
    L_0x0025:
        return;
    L_0x0026:
        r5 = new android.media.TextTrackCue;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r5.<init>();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = "-->";
        r0 = r18;
        r17 = r7.split(r0);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = 0;
        r18 = r17[r18];	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = parseMs(r18);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r18;
        r5.mStartTimeMs = r0;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = 1;
        r18 = r17[r18];	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = parseMs(r18);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r18;
        r5.mEndTimeMs = r0;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r13 = new java.util.ArrayList;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r13.<init>();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
    L_0x0050:
        r15 = r4.readLine();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        if (r15 == 0) goto L_0x0083;
    L_0x0056:
        r18 = r15.trim();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r19 = "";
        r18 = r18.equals(r19);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        if (r18 != 0) goto L_0x0083;
    L_0x0062:
        r13.add(r15);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        goto L_0x0050;
    L_0x0066:
        r6 = move-exception;
        r18 = "SRTTrack";
        r19 = new java.lang.StringBuilder;
        r19.<init>();
        r20 = "subtitle data is not UTF-8 encoded: ";
        r19 = r19.append(r20);
        r0 = r19;
        r19 = r0.append(r6);
        r19 = r19.toString();
        android.util.Log.w(r18, r19);
        goto L_0x0025;
    L_0x0083:
        r8 = 0;
        r18 = r13.size();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r18;
        r0 = new android.media.TextTrackCueSpan[r0][];	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = r0;
        r0 = r18;
        r5.mLines = r0;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = 0;
        r0 = r18;
        r0 = new java.lang.String[r0];	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = r0;
        r0 = r18;
        r18 = r13.toArray(r0);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = (java.lang.String[]) r18;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r18;
        r5.mStrings = r0;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r10 = r13.iterator();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r9 = r8;
    L_0x00ab:
        r18 = r10.hasNext();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        if (r18 == 0) goto L_0x00de;
    L_0x00b1:
        r12 = r10.next();	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r12 = (java.lang.String) r12;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = 1;
        r0 = r18;
        r0 = new android.media.TextTrackCueSpan[r0];	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r16 = r0;
        r18 = 0;
        r19 = new android.media.TextTrackCueSpan;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r20 = -1;
        r0 = r19;
        r1 = r20;
        r0.<init>(r12, r1);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r16[r18] = r19;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r5.mStrings;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = r0;
        r18[r9] = r12;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r0 = r5.mLines;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r18 = r0;
        r8 = r9 + 1;
        r18[r9] = r16;	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        r9 = r8;
        goto L_0x00ab;
    L_0x00de:
        r0 = r22;
        r0.addCue(r5);	 Catch:{ UnsupportedEncodingException -> 0x0066, IOException -> 0x00e5 }
        goto L_0x0019;
    L_0x00e5:
        r11 = move-exception;
        r18 = "SRTTrack";
        r19 = r11.getMessage();
        r0 = r18;
        r1 = r19;
        android.util.Log.e(r0, r1, r11);
        goto L_0x0025;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.SRTTrack.onData(byte[], boolean, long):void");
    }

    public void updateView(Vector<Cue> activeCues) {
        if (getRenderingWidget() != null) {
            super.updateView(activeCues);
        } else if (this.mEventHandler != null) {
            Iterator it = activeCues.iterator();
            while (it.hasNext()) {
                Cue cue = (Cue) it.next();
                TextTrackCue ttc = (TextTrackCue) cue;
                Parcel parcel = Parcel.obtain();
                parcel.writeInt(KEY_LOCAL_SETTING);
                parcel.writeInt(KEY_START_TIME);
                parcel.writeInt((int) cue.mStartTimeMs);
                parcel.writeInt(KEY_STRUCT_TEXT);
                StringBuilder sb = new StringBuilder();
                for (String line : ttc.mStrings) {
                    sb.append(line).append('\n');
                }
                byte[] buf = sb.toString().getBytes();
                parcel.writeInt(buf.length);
                parcel.writeByteArray(buf);
                this.mEventHandler.sendMessage(this.mEventHandler.obtainMessage(MEDIA_TIMED_TEXT, 0, 0, parcel));
            }
            activeCues.clear();
        }
    }

    private static long parseMs(String in) {
        long hours = Long.parseLong(in.split(":")[0].trim());
        long minutes = Long.parseLong(in.split(":")[1].trim());
        long seconds = Long.parseLong(in.split(":")[2].split(",")[0].trim());
        return (((((60 * hours) * 60) * 1000) + ((60 * minutes) * 1000)) + (1000 * seconds)) + Long.parseLong(in.split(":")[2].split(",")[1].trim());
    }
}
