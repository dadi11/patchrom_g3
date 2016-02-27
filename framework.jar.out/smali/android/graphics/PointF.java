package android.graphics;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.FloatMath;

public class PointF implements Parcelable {
    public static final Creator<PointF> CREATOR;
    public float f15x;
    public float f16y;

    /* renamed from: android.graphics.PointF.1 */
    static class C01771 implements Creator<PointF> {
        C01771() {
        }

        public PointF createFromParcel(Parcel in) {
            PointF r = new PointF();
            r.readFromParcel(in);
            return r;
        }

        public PointF[] newArray(int size) {
            return new PointF[size];
        }
    }

    public PointF(float x, float y) {
        this.f15x = x;
        this.f16y = y;
    }

    public PointF(Point p) {
        this.f15x = (float) p.f13x;
        this.f16y = (float) p.f14y;
    }

    public final void set(float x, float y) {
        this.f15x = x;
        this.f16y = y;
    }

    public final void set(PointF p) {
        this.f15x = p.f15x;
        this.f16y = p.f16y;
    }

    public final void negate() {
        this.f15x = -this.f15x;
        this.f16y = -this.f16y;
    }

    public final void offset(float dx, float dy) {
        this.f15x += dx;
        this.f16y += dy;
    }

    public final boolean equals(float x, float y) {
        return this.f15x == x && this.f16y == y;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        PointF pointF = (PointF) o;
        if (Float.compare(pointF.f15x, this.f15x) != 0) {
            return false;
        }
        if (Float.compare(pointF.f16y, this.f16y) != 0) {
            return false;
        }
        return true;
    }

    public int hashCode() {
        int result;
        int i = 0;
        if (this.f15x != 0.0f) {
            result = Float.floatToIntBits(this.f15x);
        } else {
            result = 0;
        }
        int i2 = result * 31;
        if (this.f16y != 0.0f) {
            i = Float.floatToIntBits(this.f16y);
        }
        return i2 + i;
    }

    public String toString() {
        return "PointF(" + this.f15x + ", " + this.f16y + ")";
    }

    public final float length() {
        return length(this.f15x, this.f16y);
    }

    public static float length(float x, float y) {
        return FloatMath.sqrt((x * x) + (y * y));
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeFloat(this.f15x);
        out.writeFloat(this.f16y);
    }

    static {
        CREATOR = new C01771();
    }

    public void readFromParcel(Parcel in) {
        this.f15x = in.readFloat();
        this.f16y = in.readFloat();
    }
}
