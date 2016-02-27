package com.android.internal.telephony.cat;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class ToneSettings implements Parcelable {
    public static final Creator<ToneSettings> CREATOR;
    public Duration duration;
    public Tone tone;
    public boolean vibrate;

    /* renamed from: com.android.internal.telephony.cat.ToneSettings.1 */
    static class C00381 implements Creator<ToneSettings> {
        C00381() {
        }

        public ToneSettings createFromParcel(Parcel in) {
            return new ToneSettings(null);
        }

        public ToneSettings[] newArray(int size) {
            return new ToneSettings[size];
        }
    }

    public ToneSettings(Duration duration, Tone tone, boolean vibrate) {
        this.duration = duration;
        this.tone = tone;
        this.vibrate = vibrate;
    }

    private ToneSettings(Parcel in) {
        this.duration = (Duration) in.readParcelable(null);
        this.tone = (Tone) in.readParcelable(null);
        this.vibrate = in.readInt() == 1;
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i = 0;
        dest.writeParcelable(this.duration, 0);
        dest.writeParcelable(this.tone, 0);
        if (this.vibrate) {
            i = 1;
        }
        dest.writeInt(i);
    }

    static {
        CREATOR = new C00381();
    }
}
