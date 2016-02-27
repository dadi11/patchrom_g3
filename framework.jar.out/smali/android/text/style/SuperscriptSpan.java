package android.text.style;

import android.os.Parcel;
import android.text.ParcelableSpan;
import android.text.TextPaint;

public class SuperscriptSpan extends MetricAffectingSpan implements ParcelableSpan {
    public SuperscriptSpan(Parcel src) {
    }

    public int getSpanTypeId() {
        return 14;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
    }

    public void updateDrawState(TextPaint tp) {
        tp.baselineShift += (int) (tp.ascent() / 2.0f);
    }

    public void updateMeasureState(TextPaint tp) {
        tp.baselineShift += (int) (tp.ascent() / 2.0f);
    }
}
