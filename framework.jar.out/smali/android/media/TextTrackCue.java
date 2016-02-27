package android.media;

import android.hardware.Camera.Parameters;
import android.media.SubtitleTrack.Cue;
import android.net.ProxyInfo;
import java.util.Arrays;

/* compiled from: WebVttRenderer */
class TextTrackCue extends Cue {
    static final int ALIGNMENT_END = 202;
    static final int ALIGNMENT_LEFT = 203;
    static final int ALIGNMENT_MIDDLE = 200;
    static final int ALIGNMENT_RIGHT = 204;
    static final int ALIGNMENT_START = 201;
    private static final String TAG = "TTCue";
    static final int WRITING_DIRECTION_HORIZONTAL = 100;
    static final int WRITING_DIRECTION_VERTICAL_LR = 102;
    static final int WRITING_DIRECTION_VERTICAL_RL = 101;
    int mAlignment;
    boolean mAutoLinePosition;
    String mId;
    Integer mLinePosition;
    TextTrackCueSpan[][] mLines;
    boolean mPauseOnExit;
    TextTrackRegion mRegion;
    String mRegionId;
    int mSize;
    boolean mSnapToLines;
    String[] mStrings;
    int mTextPosition;
    int mWritingDirection;

    TextTrackCue() {
        this.mId = ProxyInfo.LOCAL_EXCL_LIST;
        this.mPauseOnExit = false;
        this.mWritingDirection = WRITING_DIRECTION_HORIZONTAL;
        this.mRegionId = ProxyInfo.LOCAL_EXCL_LIST;
        this.mSnapToLines = true;
        this.mLinePosition = null;
        this.mTextPosition = 50;
        this.mSize = WRITING_DIRECTION_HORIZONTAL;
        this.mAlignment = ALIGNMENT_MIDDLE;
        this.mLines = (TextTrackCueSpan[][]) null;
        this.mRegion = null;
    }

    public boolean equals(Object o) {
        if (!(o instanceof TextTrackCue)) {
            return false;
        }
        if (this == o) {
            return true;
        }
        try {
            boolean res;
            TextTrackCue cue = (TextTrackCue) o;
            if (this.mId.equals(cue.mId) && this.mPauseOnExit == cue.mPauseOnExit && this.mWritingDirection == cue.mWritingDirection && this.mRegionId.equals(cue.mRegionId) && this.mSnapToLines == cue.mSnapToLines && this.mAutoLinePosition == cue.mAutoLinePosition && ((this.mAutoLinePosition || ((this.mLinePosition != null && this.mLinePosition.equals(cue.mLinePosition)) || (this.mLinePosition == null && cue.mLinePosition == null))) && this.mTextPosition == cue.mTextPosition && this.mSize == cue.mSize && this.mAlignment == cue.mAlignment && this.mLines.length == cue.mLines.length)) {
                res = true;
            } else {
                res = false;
            }
            if (!res) {
                return res;
            }
            for (int line = 0; line < this.mLines.length; line++) {
                if (!Arrays.equals(this.mLines[line], cue.mLines[line])) {
                    return false;
                }
            }
            return res;
        } catch (IncompatibleClassChangeError e) {
            return false;
        }
    }

    public StringBuilder appendStringsToBuilder(StringBuilder builder) {
        if (this.mStrings == null) {
            builder.append("null");
        } else {
            builder.append("[");
            boolean first = true;
            for (String s : this.mStrings) {
                if (!first) {
                    builder.append(", ");
                }
                if (s == null) {
                    builder.append("null");
                } else {
                    builder.append("\"");
                    builder.append(s);
                    builder.append("\"");
                }
                first = false;
            }
            builder.append("]");
        }
        return builder;
    }

    public StringBuilder appendLinesToBuilder(StringBuilder builder) {
        if (this.mLines == null) {
            builder.append("null");
        } else {
            builder.append("[");
            boolean first = true;
            for (TextTrackCueSpan[] spans : this.mLines) {
                if (!first) {
                    builder.append(", ");
                }
                if (spans == null) {
                    builder.append("null");
                } else {
                    builder.append("\"");
                    boolean innerFirst = true;
                    long lastTimestamp = -1;
                    for (TextTrackCueSpan span : spans) {
                        if (!innerFirst) {
                            builder.append(" ");
                        }
                        if (span.mTimestampMs != lastTimestamp) {
                            builder.append("<").append(WebVttParser.timeToString(span.mTimestampMs)).append(">");
                            lastTimestamp = span.mTimestampMs;
                        }
                        builder.append(span.mText);
                        innerFirst = false;
                    }
                    builder.append("\"");
                }
                first = false;
            }
            builder.append("]");
        }
        return builder;
    }

    public String toString() {
        Object obj;
        StringBuilder res = new StringBuilder();
        StringBuilder append = res.append(WebVttParser.timeToString(this.mStartTimeMs)).append(" --> ").append(WebVttParser.timeToString(this.mEndTimeMs)).append(" {id:\"").append(this.mId).append("\", pauseOnExit:").append(this.mPauseOnExit).append(", direction:");
        String str = this.mWritingDirection == WRITING_DIRECTION_HORIZONTAL ? "horizontal" : this.mWritingDirection == WRITING_DIRECTION_VERTICAL_LR ? "vertical_lr" : this.mWritingDirection == WRITING_DIRECTION_VERTICAL_RL ? "vertical_rl" : "INVALID";
        append = append.append(str).append(", regionId:\"").append(this.mRegionId).append("\", snapToLines:").append(this.mSnapToLines).append(", linePosition:");
        if (this.mAutoLinePosition) {
            obj = Parameters.WHITE_BALANCE_AUTO;
        } else {
            obj = this.mLinePosition;
        }
        append = append.append(obj).append(", textPosition:").append(this.mTextPosition).append(", size:").append(this.mSize).append(", alignment:");
        str = this.mAlignment == ALIGNMENT_END ? TtmlUtils.ATTR_END : this.mAlignment == ALIGNMENT_LEFT ? "left" : this.mAlignment == ALIGNMENT_MIDDLE ? "middle" : this.mAlignment == ALIGNMENT_RIGHT ? "right" : this.mAlignment == ALIGNMENT_START ? "start" : "INVALID";
        append.append(str).append(", text:");
        appendStringsToBuilder(res).append("}");
        return res.toString();
    }

    public int hashCode() {
        return toString().hashCode();
    }

    public void onTime(long timeMs) {
        for (TextTrackCueSpan[] arr$ : this.mLines) {
            for (TextTrackCueSpan span : r0[r3]) {
                span.mEnabled = timeMs >= span.mTimestampMs;
            }
        }
    }
}
