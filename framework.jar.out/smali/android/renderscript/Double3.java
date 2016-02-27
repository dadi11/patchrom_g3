package android.renderscript;

import android.widget.Toast;

public class Double3 {
    public double f34x;
    public double f35y;
    public double f36z;

    public Double3(Double3 data) {
        this.f34x = data.f34x;
        this.f35y = data.f35y;
        this.f36z = data.f36z;
    }

    public Double3(double x, double y, double z) {
        this.f34x = x;
        this.f35y = y;
        this.f36z = z;
    }

    public static Double3 add(Double3 a, Double3 b) {
        Double3 res = new Double3();
        res.f34x = a.f34x + b.f34x;
        res.f35y = a.f35y + b.f35y;
        res.f36z = a.f36z + b.f36z;
        return res;
    }

    public void add(Double3 value) {
        this.f34x += value.f34x;
        this.f35y += value.f35y;
        this.f36z += value.f36z;
    }

    public void add(double value) {
        this.f34x += value;
        this.f35y += value;
        this.f36z += value;
    }

    public static Double3 add(Double3 a, double b) {
        Double3 res = new Double3();
        res.f34x = a.f34x + b;
        res.f35y = a.f35y + b;
        res.f36z = a.f36z + b;
        return res;
    }

    public void sub(Double3 value) {
        this.f34x -= value.f34x;
        this.f35y -= value.f35y;
        this.f36z -= value.f36z;
    }

    public static Double3 sub(Double3 a, Double3 b) {
        Double3 res = new Double3();
        res.f34x = a.f34x - b.f34x;
        res.f35y = a.f35y - b.f35y;
        res.f36z = a.f36z - b.f36z;
        return res;
    }

    public void sub(double value) {
        this.f34x -= value;
        this.f35y -= value;
        this.f36z -= value;
    }

    public static Double3 sub(Double3 a, double b) {
        Double3 res = new Double3();
        res.f34x = a.f34x - b;
        res.f35y = a.f35y - b;
        res.f36z = a.f36z - b;
        return res;
    }

    public void mul(Double3 value) {
        this.f34x *= value.f34x;
        this.f35y *= value.f35y;
        this.f36z *= value.f36z;
    }

    public static Double3 mul(Double3 a, Double3 b) {
        Double3 res = new Double3();
        res.f34x = a.f34x * b.f34x;
        res.f35y = a.f35y * b.f35y;
        res.f36z = a.f36z * b.f36z;
        return res;
    }

    public void mul(double value) {
        this.f34x *= value;
        this.f35y *= value;
        this.f36z *= value;
    }

    public static Double3 mul(Double3 a, double b) {
        Double3 res = new Double3();
        res.f34x = a.f34x * b;
        res.f35y = a.f35y * b;
        res.f36z = a.f36z * b;
        return res;
    }

    public void div(Double3 value) {
        this.f34x /= value.f34x;
        this.f35y /= value.f35y;
        this.f36z /= value.f36z;
    }

    public static Double3 div(Double3 a, Double3 b) {
        Double3 res = new Double3();
        res.f34x = a.f34x / b.f34x;
        res.f35y = a.f35y / b.f35y;
        res.f36z = a.f36z / b.f36z;
        return res;
    }

    public void div(double value) {
        this.f34x /= value;
        this.f35y /= value;
        this.f36z /= value;
    }

    public static Double3 div(Double3 a, double b) {
        Double3 res = new Double3();
        res.f34x = a.f34x / b;
        res.f35y = a.f35y / b;
        res.f36z = a.f36z / b;
        return res;
    }

    public double dotProduct(Double3 a) {
        return ((this.f34x * a.f34x) + (this.f35y * a.f35y)) + (this.f36z * a.f36z);
    }

    public static double dotProduct(Double3 a, Double3 b) {
        return ((b.f34x * a.f34x) + (b.f35y * a.f35y)) + (b.f36z * a.f36z);
    }

    public void addMultiple(Double3 a, double factor) {
        this.f34x += a.f34x * factor;
        this.f35y += a.f35y * factor;
        this.f36z += a.f36z * factor;
    }

    public void set(Double3 a) {
        this.f34x = a.f34x;
        this.f35y = a.f35y;
        this.f36z = a.f36z;
    }

    public void negate() {
        this.f34x = -this.f34x;
        this.f35y = -this.f35y;
        this.f36z = -this.f36z;
    }

    public int length() {
        return 3;
    }

    public double elementSum() {
        return (this.f34x + this.f35y) + this.f36z;
    }

    public double get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f34x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f35y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f36z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f34x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f35y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f36z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, double value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f34x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f35y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f36z += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(double x, double y, double z) {
        this.f34x = x;
        this.f35y = y;
        this.f36z = z;
    }

    public void copyTo(double[] data, int offset) {
        data[offset] = this.f34x;
        data[offset + 1] = this.f35y;
        data[offset + 2] = this.f36z;
    }
}
