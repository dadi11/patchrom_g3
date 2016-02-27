package android.media;

import android.os.Parcel;
import android.text.ParcelableSpan;
import android.text.TextPaint;
import android.text.style.CharacterStyle;
import android.text.style.UpdateAppearance;

/* compiled from: ClosedCaptionRenderer */
class MutableBackgroundColorSpan extends CharacterStyle implements UpdateAppearance, ParcelableSpan {
    private int mColor;

    public MutableBackgroundColorSpan(int color) {
        this.mColor = color;
    }

    public MutableBackgroundColorSpan(Parcel src) {
        this.mColor = src.readInt();
    }

    public void setBackgroundColor(int color) {
        this.mColor = color;
    }

    public int getBackgroundColor() {
        return this.mColor;
    }

    public int getSpanTypeId() {
        return 12;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mColor);
    }

    public void updateDrawState(TextPaint ds) {
        ds.bgColor = this.mColor;
    }
}
