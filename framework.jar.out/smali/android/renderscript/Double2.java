package android.renderscript;

import android.widget.Toast;

public class Double2 {
    public double f32x;
    public double f33y;

    public Double2(Double2 data) {
        this.f32x = data.f32x;
        this.f33y = data.f33y;
    }

    public Double2(double x, double y) {
        this.f32x = x;
        this.f33y = y;
    }

    public static Double2 add(Double2 a, Double2 b) {
        Double2 res = new Double2();
        res.f32x = a.f32x + b.f32x;
        res.f33y = a.f33y + b.f33y;
        return res;
    }

    public void add(Double2 value) {
        this.f32x += value.f32x;
        this.f33y += value.f33y;
    }

    public void add(double value) {
        this.f32x += value;
        this.f33y += value;
    }

    public static Double2 add(Double2 a, double b) {
        Double2 res = new Double2();
        res.f32x = a.f32x + b;
        res.f33y = a.f33y + b;
        return res;
    }

    public void sub(Double2 value) {
        this.f32x -= value.f32x;
        this.f33y -= value.f33y;
    }

    public static Double2 sub(Double2 a, Double2 b) {
        Double2 res = new Double2();
        res.f32x = a.f32x - b.f32x;
        res.f33y = a.f33y - b.f33y;
        return res;
    }

    public void sub(double value) {
        this.f32x -= value;
        this.f33y -= value;
    }

    public static Double2 sub(Double2 a, double b) {
        Double2 res = new Double2();
        res.f32x = a.f32x - b;
        res.f33y = a.f33y - b;
        return res;
    }

    public void mul(Double2 value) {
        this.f32x *= value.f32x;
        this.f33y *= value.f33y;
    }

    public static Double2 mul(Double2 a, Double2 b) {
        Double2 res = new Double2();
        res.f32x = a.f32x * b.f32x;
        res.f33y = a.f33y * b.f33y;
        return res;
    }

    public void mul(double value) {
        this.f32x *= value;
        this.f33y *= value;
    }

    public static Double2 mul(Double2 a, double b) {
        Double2 res = new Double2();
        res.f32x = a.f32x * b;
        res.f33y = a.f33y * b;
        return res;
    }

    public void div(Double2 value) {
        this.f32x /= value.f32x;
        this.f33y /= value.f33y;
    }

    public static Double2 div(Double2 a, Double2 b) {
        Double2 res = new Double2();
        res.f32x = a.f32x / b.f32x;
        res.f33y = a.f33y / b.f33y;
        return res;
    }

    public void div(double value) {
        this.f32x /= value;
        this.f33y /= value;
    }

    public static Double2 div(Double2 a, double b) {
        Double2 res = new Double2();
        res.f32x = a.f32x / b;
        res.f33y = a.f33y / b;
        return res;
    }

    public double dotProduct(Double2 a) {
        return (this.f32x * a.f32x) + (this.f33y * a.f33y);
    }

    public static Double dotProduct(Double2 a, Double2 b) {
        return Double.valueOf((b.f32x * a.f32x) + (b.f33y * a.f33y));
    }

    public void addMultiple(Double2 a, double factor) {
        this.f32x += a.f32x * factor;
        this.f33y += a.f33y * factor;
    }

    public void set(Double2 a) {
        this.f32x = a.f32x;
        this.f33y = a.f33y;
    }

    public void negate() {
        this.f32x = -this.f32x;
        this.f33y = -this.f33y;
    }

    public int length() {
        return 2;
    }

    public double elementSum() {
        return this.f32x + this.f33y;
    }

    public double get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f32x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f33y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f32x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f33y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f32x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f33y += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(double x, double y) {
        this.f32x = x;
        this.f33y = y;
    }

    public void copyTo(double[] data, int offset) {
        data[offset] = this.f32x;
        data[offset + 1] = this.f33y;
    }
}
