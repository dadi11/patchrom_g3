package android.renderscript;

import android.widget.Toast;

public class Int3 {
    public int f52x;
    public int f53y;
    public int f54z;

    public Int3(int i) {
        this.f54z = i;
        this.f53y = i;
        this.f52x = i;
    }

    public Int3(int x, int y, int z) {
        this.f52x = x;
        this.f53y = y;
        this.f54z = z;
    }

    public Int3(Int3 source) {
        this.f52x = source.f52x;
        this.f53y = source.f53y;
        this.f54z = source.f54z;
    }

    public void add(Int3 a) {
        this.f52x += a.f52x;
        this.f53y += a.f53y;
        this.f54z += a.f54z;
    }

    public static Int3 add(Int3 a, Int3 b) {
        Int3 result = new Int3();
        result.f52x = a.f52x + b.f52x;
        result.f53y = a.f53y + b.f53y;
        result.f54z = a.f54z + b.f54z;
        return result;
    }

    public void add(int value) {
        this.f52x += value;
        this.f53y += value;
        this.f54z += value;
    }

    public static Int3 add(Int3 a, int b) {
        Int3 result = new Int3();
        result.f52x = a.f52x + b;
        result.f53y = a.f53y + b;
        result.f54z = a.f54z + b;
        return result;
    }

    public void sub(Int3 a) {
        this.f52x -= a.f52x;
        this.f53y -= a.f53y;
        this.f54z -= a.f54z;
    }

    public static Int3 sub(Int3 a, Int3 b) {
        Int3 result = new Int3();
        result.f52x = a.f52x - b.f52x;
        result.f53y = a.f53y - b.f53y;
        result.f54z = a.f54z - b.f54z;
        return result;
    }

    public void sub(int value) {
        this.f52x -= value;
        this.f53y -= value;
        this.f54z -= value;
    }

    public static Int3 sub(Int3 a, int b) {
        Int3 result = new Int3();
        result.f52x = a.f52x - b;
        result.f53y = a.f53y - b;
        result.f54z = a.f54z - b;
        return result;
    }

    public void mul(Int3 a) {
        this.f52x *= a.f52x;
        this.f53y *= a.f53y;
        this.f54z *= a.f54z;
    }

    public static Int3 mul(Int3 a, Int3 b) {
        Int3 result = new Int3();
        result.f52x = a.f52x * b.f52x;
        result.f53y = a.f53y * b.f53y;
        result.f54z = a.f54z * b.f54z;
        return result;
    }

    public void mul(int value) {
        this.f52x *= value;
        this.f53y *= value;
        this.f54z *= value;
    }

    public static Int3 mul(Int3 a, int b) {
        Int3 result = new Int3();
        result.f52x = a.f52x * b;
        result.f53y = a.f53y * b;
        result.f54z = a.f54z * b;
        return result;
    }

    public void div(Int3 a) {
        this.f52x /= a.f52x;
        this.f53y /= a.f53y;
        this.f54z /= a.f54z;
    }

    public static Int3 div(Int3 a, Int3 b) {
        Int3 result = new Int3();
        result.f52x = a.f52x / b.f52x;
        result.f53y = a.f53y / b.f53y;
        result.f54z = a.f54z / b.f54z;
        return result;
    }

    public void div(int value) {
        this.f52x /= value;
        this.f53y /= value;
        this.f54z /= value;
    }

    public static Int3 div(Int3 a, int b) {
        Int3 result = new Int3();
        result.f52x = a.f52x / b;
        result.f53y = a.f53y / b;
        result.f54z = a.f54z / b;
        return result;
    }

    public void mod(Int3 a) {
        this.f52x %= a.f52x;
        this.f53y %= a.f53y;
        this.f54z %= a.f54z;
    }

    public static Int3 mod(Int3 a, Int3 b) {
        Int3 result = new Int3();
        result.f52x = a.f52x % b.f52x;
        result.f53y = a.f53y % b.f53y;
        result.f54z = a.f54z % b.f54z;
        return result;
    }

    public void mod(int value) {
        this.f52x %= value;
        this.f53y %= value;
        this.f54z %= value;
    }

    public static Int3 mod(Int3 a, int b) {
        Int3 result = new Int3();
        result.f52x = a.f52x % b;
        result.f53y = a.f53y % b;
        result.f54z = a.f54z % b;
        return result;
    }

    public int length() {
        return 3;
    }

    public void negate() {
        this.f52x = -this.f52x;
        this.f53y = -this.f53y;
        this.f54z = -this.f54z;
    }

    public int dotProduct(Int3 a) {
        return ((this.f52x * a.f52x) + (this.f53y * a.f53y)) + (this.f54z * a.f54z);
    }

    public static int dotProduct(Int3 a, Int3 b) {
        return ((b.f52x * a.f52x) + (b.f53y * a.f53y)) + (b.f54z * a.f54z);
    }

    public void addMultiple(Int3 a, int factor) {
        this.f52x += a.f52x * factor;
        this.f53y += a.f53y * factor;
        this.f54z += a.f54z * factor;
    }

    public void set(Int3 a) {
        this.f52x = a.f52x;
        this.f53y = a.f53y;
        this.f54z = a.f54z;
    }

    public void setValues(int a, int b, int c) {
        this.f52x = a;
        this.f53y = b;
        this.f54z = c;
    }

    public int elementSum() {
        return (this.f52x + this.f53y) + this.f54z;
    }

    public int get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f52x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f53y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f54z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f52x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f53y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f54z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f52x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f53y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f54z += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(int[] data, int offset) {
        data[offset] = this.f52x;
        data[offset + 1] = this.f53y;
        data[offset + 2] = this.f54z;
    }
}
