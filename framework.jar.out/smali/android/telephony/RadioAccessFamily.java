package android.telephony;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.view.KeyEvent;
import android.widget.SpellChecker;
import android.widget.Toast;

public class RadioAccessFamily implements Parcelable {
    public static final Creator<RadioAccessFamily> CREATOR;
    public static final int RAF_1xRTT = 64;
    public static final int RAF_EDGE = 4;
    public static final int RAF_EHRPD = 8192;
    public static final int RAF_EVDO_0 = 128;
    public static final int RAF_EVDO_A = 256;
    public static final int RAF_EVDO_B = 4096;
    public static final int RAF_GPRS = 2;
    public static final int RAF_GSM = 65536;
    public static final int RAF_HSDPA = 512;
    public static final int RAF_HSPA = 2048;
    public static final int RAF_HSPAP = 32768;
    public static final int RAF_HSUPA = 1024;
    public static final int RAF_IS95A = 16;
    public static final int RAF_IS95B = 32;
    public static final int RAF_LTE = 16384;
    public static final int RAF_TD_SCDMA = 131072;
    public static final int RAF_UMTS = 8;
    public static final int RAF_UNKNOWN = 1;
    private int mPhoneId;
    private int mRadioAccessFamily;

    /* renamed from: android.telephony.RadioAccessFamily.1 */
    static class C07841 implements Creator<RadioAccessFamily> {
        C07841() {
        }

        public RadioAccessFamily createFromParcel(Parcel in) {
            return new RadioAccessFamily(in.readInt(), in.readInt());
        }

        public RadioAccessFamily[] newArray(int size) {
            return new RadioAccessFamily[size];
        }
    }

    public RadioAccessFamily(int phoneId, int radioAccessFamily) {
        this.mPhoneId = phoneId;
        this.mRadioAccessFamily = radioAccessFamily;
    }

    public int getPhoneId() {
        return this.mPhoneId;
    }

    public int getRadioAccessFamily() {
        return this.mRadioAccessFamily;
    }

    public String toString() {
        return "{ mPhoneId = " + this.mPhoneId + ", mRadioAccessFamily = " + this.mRadioAccessFamily + "}";
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel outParcel, int flags) {
        outParcel.writeInt(this.mPhoneId);
        outParcel.writeInt(this.mRadioAccessFamily);
    }

    static {
        CREATOR = new C07841();
    }

    public static int getRafFromNetworkType(int type) {
        switch (type) {
            case Toast.LENGTH_SHORT /*0*/:
                return 101902;
            case RAF_UNKNOWN /*1*/:
                return 65542;
            case RAF_GPRS /*2*/:
                return 36360;
            case SetDrawableParameters.TAG /*3*/:
                return 101902;
            case RAF_EDGE /*4*/:
                return KeyEvent.KEYCODE_FORWARD_DEL;
            case ReflectionActionWithoutParams.TAG /*5*/:
                return KeyEvent.KEYCODE_FORWARD_DEL;
            case SetEmptyView.TAG /*6*/:
                return 4480;
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                return 106494;
            case RAF_UMTS /*8*/:
                return 20976;
            case SetOnClickFillInIntent.TAG /*9*/:
                return 118286;
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                return 122878;
            case TextViewDrawableAction.TAG /*11*/:
                return RAF_LTE;
            case BitmapReflectionAction.TAG /*12*/:
                return 52744;
            default:
                return RAF_UNKNOWN;
        }
    }
}
