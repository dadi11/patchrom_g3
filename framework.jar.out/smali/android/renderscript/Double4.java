package android.renderscript;

import android.widget.Toast;

public class Double4 {
    public double f37w;
    public double f38x;
    public double f39y;
    public double f40z;

    public Double4(Double4 data) {
        this.f38x = data.f38x;
        this.f39y = data.f39y;
        this.f40z = data.f40z;
        this.f37w = data.f37w;
    }

    public Double4(double x, double y, double z, double w) {
        this.f38x = x;
        this.f39y = y;
        this.f40z = z;
        this.f37w = w;
    }

    public static Double4 add(Double4 a, Double4 b) {
        Double4 res = new Double4();
        res.f38x = a.f38x + b.f38x;
        res.f39y = a.f39y + b.f39y;
        res.f40z = a.f40z + b.f40z;
        res.f37w = a.f37w + b.f37w;
        return res;
    }

    public void add(Double4 value) {
        this.f38x += value.f38x;
        this.f39y += value.f39y;
        this.f40z += value.f40z;
        this.f37w += value.f37w;
    }

    public void add(double value) {
        this.f38x += value;
        this.f39y += value;
        this.f40z += value;
        this.f37w += value;
    }

    public static Double4 add(Double4 a, double b) {
        Double4 res = new Double4();
        res.f38x = a.f38x + b;
        res.f39y = a.f39y + b;
        res.f40z = a.f40z + b;
        res.f37w = a.f37w + b;
        return res;
    }

    public void sub(Double4 value) {
        this.f38x -= value.f38x;
        this.f39y -= value.f39y;
        this.f40z -= value.f40z;
        this.f37w -= value.f37w;
    }

    public void sub(double value) {
        this.f38x -= value;
        this.f39y -= value;
        this.f40z -= value;
        this.f37w -= value;
    }

    public static Double4 sub(Double4 a, double b) {
        Double4 res = new Double4();
        res.f38x = a.f38x - b;
        res.f39y = a.f39y - b;
        res.f40z = a.f40z - b;
        res.f37w = a.f37w - b;
        return res;
    }

    public static Double4 sub(Double4 a, Double4 b) {
        Double4 res = new Double4();
        res.f38x = a.f38x - b.f38x;
        res.f39y = a.f39y - b.f39y;
        res.f40z = a.f40z - b.f40z;
        res.f37w = a.f37w - b.f37w;
        return res;
    }

    public void mul(Double4 value) {
        this.f38x *= value.f38x;
        this.f39y *= value.f39y;
        this.f40z *= value.f40z;
        this.f37w *= value.f37w;
    }

    public void mul(double value) {
        this.f38x *= value;
        this.f39y *= value;
        this.f40z *= value;
        this.f37w *= value;
    }

    public static Double4 mul(Double4 a, Double4 b) {
        Double4 res = new Double4();
        res.f38x = a.f38x * b.f38x;
        res.f39y = a.f39y * b.f39y;
        res.f40z = a.f40z * b.f40z;
        res.f37w = a.f37w * b.f37w;
        return res;
    }

    public static Double4 mul(Double4 a, double b) {
        Double4 res = new Double4();
        res.f38x = a.f38x * b;
        res.f39y = a.f39y * b;
        res.f40z = a.f40z * b;
        res.f37w = a.f37w * b;
        return res;
    }

    public void div(Double4 value) {
        this.f38x /= value.f38x;
        this.f39y /= value.f39y;
        this.f40z /= value.f40z;
        this.f37w /= value.f37w;
    }

    public void div(double value) {
        this.f38x /= value;
        this.f39y /= value;
        this.f40z /= value;
        this.f37w /= value;
    }

    public static Double4 div(Double4 a, double b) {
        Double4 res = new Double4();
        res.f38x = a.f38x / b;
        res.f39y = a.f39y / b;
        res.f40z = a.f40z / b;
        res.f37w = a.f37w / b;
        return res;
    }

    public static Double4 div(Double4 a, Double4 b) {
        Double4 res = new Double4();
        res.f38x = a.f38x / b.f38x;
        res.f39y = a.f39y / b.f39y;
        res.f40z = a.f40z / b.f40z;
        res.f37w = a.f37w / b.f37w;
        return res;
    }

    public double dotProduct(Double4 a) {
        return (((this.f38x * a.f38x) + (this.f39y * a.f39y)) + (this.f40z * a.f40z)) + (this.f37w * a.f37w);
    }

    public static double dotProduct(Double4 a, Double4 b) {
        return (((b.f38x * a.f38x) + (b.f39y * a.f39y)) + (b.f40z * a.f40z)) + (b.f37w * a.f37w);
    }

    public void addMultiple(Double4 a, double factor) {
        this.f38x += a.f38x * factor;
        this.f39y += a.f39y * factor;
        this.f40z += a.f40z * factor;
        this.f37w += a.f37w * factor;
    }

    public void set(Double4 a) {
        this.f38x = a.f38x;
        this.f39y = a.f39y;
        this.f40z = a.f40z;
        this.f37w = a.f37w;
    }

    public void negate() {
        this.f38x = -this.f38x;
        this.f39y = -this.f39y;
        this.f40z = -this.f40z;
        this.f37w = -this.f37w;
    }

    public int length() {
        return 4;
    }

    public double elementSum() {
        return ((this.f38x + this.f39y) + this.f40z) + this.f37w;
    }

    public double get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f38x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f39y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f40z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f37w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f38x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f39y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f40z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f37w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f38x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f39y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f40z += value;
            case SetDrawableParameters.TAG /*3*/:
                this.f37w += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(double x, double y, double z, double w) {
        this.f38x = x;
        this.f39y = y;
        this.f40z = z;
        this.f37w = w;
    }

    public void copyTo(double[] data, int offset) {
        data[offset] = this.f38x;
        data[offset + 1] = this.f39y;
        data[offset + 2] = this.f40z;
        data[offset + 3] = this.f37w;
    }
}
