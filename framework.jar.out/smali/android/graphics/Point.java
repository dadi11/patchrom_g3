package android.graphics;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class Point implements Parcelable {
    public static final Creator<Point> CREATOR;
    public int f13x;
    public int f14y;

    /* renamed from: android.graphics.Point.1 */
    static class C01761 implements Creator<Point> {
        C01761() {
        }

        public Point createFromParcel(Parcel in) {
            Point r = new Point();
            r.readFromParcel(in);
            return r;
        }

        public Point[] newArray(int size) {
            return new Point[size];
        }
    }

    public Point(int x, int y) {
        this.f13x = x;
        this.f14y = y;
    }

    public Point(Point src) {
        this.f13x = src.f13x;
        this.f14y = src.f14y;
    }

    public void set(int x, int y) {
        this.f13x = x;
        this.f14y = y;
    }

    public final void negate() {
        this.f13x = -this.f13x;
        this.f14y = -this.f14y;
    }

    public final void offset(int dx, int dy) {
        this.f13x += dx;
        this.f14y += dy;
    }

    public final boolean equals(int x, int y) {
        return this.f13x == x && this.f14y == y;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Point point = (Point) o;
        if (this.f13x != point.f13x) {
            return false;
        }
        if (this.f14y != point.f14y) {
            return false;
        }
        return true;
    }

    public int hashCode() {
        return (this.f13x * 31) + this.f14y;
    }

    public String toString() {
        return "Point(" + this.f13x + ", " + this.f14y + ")";
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeInt(this.f13x);
        out.writeInt(this.f14y);
    }

    static {
        CREATOR = new C01761();
    }

    public void readFromParcel(Parcel in) {
        this.f13x = in.readInt();
        this.f14y = in.readInt();
    }
}
