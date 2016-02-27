package android.renderscript;

import android.widget.Toast;

public class Int4 {
    public int f55w;
    public int f56x;
    public int f57y;
    public int f58z;

    public Int4(int i) {
        this.f55w = i;
        this.f58z = i;
        this.f57y = i;
        this.f56x = i;
    }

    public Int4(int x, int y, int z, int w) {
        this.f56x = x;
        this.f57y = y;
        this.f58z = z;
        this.f55w = w;
    }

    public Int4(Int4 source) {
        this.f56x = source.f56x;
        this.f57y = source.f57y;
        this.f58z = source.f58z;
        this.f55w = source.f55w;
    }

    public void add(Int4 a) {
        this.f56x += a.f56x;
        this.f57y += a.f57y;
        this.f58z += a.f58z;
        this.f55w += a.f55w;
    }

    public static Int4 add(Int4 a, Int4 b) {
        Int4 result = new Int4();
        result.f56x = a.f56x + b.f56x;
        result.f57y = a.f57y + b.f57y;
        result.f58z = a.f58z + b.f58z;
        result.f55w = a.f55w + b.f55w;
        return result;
    }

    public void add(int value) {
        this.f56x += value;
        this.f57y += value;
        this.f58z += value;
        this.f55w += value;
    }

    public static Int4 add(Int4 a, int b) {
        Int4 result = new Int4();
        result.f56x = a.f56x + b;
        result.f57y = a.f57y + b;
        result.f58z = a.f58z + b;
        result.f55w = a.f55w + b;
        return result;
    }

    public void sub(Int4 a) {
        this.f56x -= a.f56x;
        this.f57y -= a.f57y;
        this.f58z -= a.f58z;
        this.f55w -= a.f55w;
    }

    public static Int4 sub(Int4 a, Int4 b) {
        Int4 result = new Int4();
        result.f56x = a.f56x - b.f56x;
        result.f57y = a.f57y - b.f57y;
        result.f58z = a.f58z - b.f58z;
        result.f55w = a.f55w - b.f55w;
        return result;
    }

    public void sub(int value) {
        this.f56x -= value;
        this.f57y -= value;
        this.f58z -= value;
        this.f55w -= value;
    }

    public static Int4 sub(Int4 a, int b) {
        Int4 result = new Int4();
        result.f56x = a.f56x - b;
        result.f57y = a.f57y - b;
        result.f58z = a.f58z - b;
        result.f55w = a.f55w - b;
        return result;
    }

    public void mul(Int4 a) {
        this.f56x *= a.f56x;
        this.f57y *= a.f57y;
        this.f58z *= a.f58z;
        this.f55w *= a.f55w;
    }

    public static Int4 mul(Int4 a, Int4 b) {
        Int4 result = new Int4();
        result.f56x = a.f56x * b.f56x;
        result.f57y = a.f57y * b.f57y;
        result.f58z = a.f58z * b.f58z;
        result.f55w = a.f55w * b.f55w;
        return result;
    }

    public void mul(int value) {
        this.f56x *= value;
        this.f57y *= value;
        this.f58z *= value;
        this.f55w *= value;
    }

    public static Int4 mul(Int4 a, int b) {
        Int4 result = new Int4();
        result.f56x = a.f56x * b;
        result.f57y = a.f57y * b;
        result.f58z = a.f58z * b;
        result.f55w = a.f55w * b;
        return result;
    }

    public void div(Int4 a) {
        this.f56x /= a.f56x;
        this.f57y /= a.f57y;
        this.f58z /= a.f58z;
        this.f55w /= a.f55w;
    }

    public static Int4 div(Int4 a, Int4 b) {
        Int4 result = new Int4();
        result.f56x = a.f56x / b.f56x;
        result.f57y = a.f57y / b.f57y;
        result.f58z = a.f58z / b.f58z;
        result.f55w = a.f55w / b.f55w;
        return result;
    }

    public void div(int value) {
        this.f56x /= value;
        this.f57y /= value;
        this.f58z /= value;
        this.f55w /= value;
    }

    public static Int4 div(Int4 a, int b) {
        Int4 result = new Int4();
        result.f56x = a.f56x / b;
        result.f57y = a.f57y / b;
        result.f58z = a.f58z / b;
        result.f55w = a.f55w / b;
        return result;
    }

    public void mod(Int4 a) {
        this.f56x %= a.f56x;
        this.f57y %= a.f57y;
        this.f58z %= a.f58z;
        this.f55w %= a.f55w;
    }

    public static Int4 mod(Int4 a, Int4 b) {
        Int4 result = new Int4();
        result.f56x = a.f56x % b.f56x;
        result.f57y = a.f57y % b.f57y;
        result.f58z = a.f58z % b.f58z;
        result.f55w = a.f55w % b.f55w;
        return result;
    }

    public void mod(int value) {
        this.f56x %= value;
        this.f57y %= value;
        this.f58z %= value;
        this.f55w %= value;
    }

    public static Int4 mod(Int4 a, int b) {
        Int4 result = new Int4();
        result.f56x = a.f56x % b;
        result.f57y = a.f57y % b;
        result.f58z = a.f58z % b;
        result.f55w = a.f55w % b;
        return result;
    }

    public int length() {
        return 4;
    }

    public void negate() {
        this.f56x = -this.f56x;
        this.f57y = -this.f57y;
        this.f58z = -this.f58z;
        this.f55w = -this.f55w;
    }

    public int dotProduct(Int4 a) {
        return (((this.f56x * a.f56x) + (this.f57y * a.f57y)) + (this.f58z * a.f58z)) + (this.f55w * a.f55w);
    }

    public static int dotProduct(Int4 a, Int4 b) {
        return (((b.f56x * a.f56x) + (b.f57y * a.f57y)) + (b.f58z * a.f58z)) + (b.f55w * a.f55w);
    }

    public void addMultiple(Int4 a, int factor) {
        this.f56x += a.f56x * factor;
        this.f57y += a.f57y * factor;
        this.f58z += a.f58z * factor;
        this.f55w += a.f55w * factor;
    }

    public void set(Int4 a) {
        this.f56x = a.f56x;
        this.f57y = a.f57y;
        this.f58z = a.f58z;
        this.f55w = a.f55w;
    }

    public void setValues(int a, int b, int c, int d) {
        this.f56x = a;
        this.f57y = b;
        this.f58z = c;
        this.f55w = d;
    }

    public int elementSum() {
        return ((this.f56x + this.f57y) + this.f58z) + this.f55w;
    }

    public int get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f56x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f57y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f58z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f55w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f56x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f57y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f58z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f55w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f56x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f57y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f58z += value;
            case SetDrawableParameters.TAG /*3*/:
                this.f55w += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(int[] data, int offset) {
        data[offset] = this.f56x;
        data[offset + 1] = this.f57y;
        data[offset + 2] = this.f58z;
        data[offset + 3] = this.f55w;
    }
}
