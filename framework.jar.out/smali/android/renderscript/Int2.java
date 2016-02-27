package android.renderscript;

import android.widget.Toast;

public class Int2 {
    public int f50x;
    public int f51y;

    public Int2(int i) {
        this.f51y = i;
        this.f50x = i;
    }

    public Int2(int x, int y) {
        this.f50x = x;
        this.f51y = y;
    }

    public Int2(Int2 source) {
        this.f50x = source.f50x;
        this.f51y = source.f51y;
    }

    public void add(Int2 a) {
        this.f50x += a.f50x;
        this.f51y += a.f51y;
    }

    public static Int2 add(Int2 a, Int2 b) {
        Int2 result = new Int2();
        result.f50x = a.f50x + b.f50x;
        result.f51y = a.f51y + b.f51y;
        return result;
    }

    public void add(int value) {
        this.f50x += value;
        this.f51y += value;
    }

    public static Int2 add(Int2 a, int b) {
        Int2 result = new Int2();
        result.f50x = a.f50x + b;
        result.f51y = a.f51y + b;
        return result;
    }

    public void sub(Int2 a) {
        this.f50x -= a.f50x;
        this.f51y -= a.f51y;
    }

    public static Int2 sub(Int2 a, Int2 b) {
        Int2 result = new Int2();
        result.f50x = a.f50x - b.f50x;
        result.f51y = a.f51y - b.f51y;
        return result;
    }

    public void sub(int value) {
        this.f50x -= value;
        this.f51y -= value;
    }

    public static Int2 sub(Int2 a, int b) {
        Int2 result = new Int2();
        result.f50x = a.f50x - b;
        result.f51y = a.f51y - b;
        return result;
    }

    public void mul(Int2 a) {
        this.f50x *= a.f50x;
        this.f51y *= a.f51y;
    }

    public static Int2 mul(Int2 a, Int2 b) {
        Int2 result = new Int2();
        result.f50x = a.f50x * b.f50x;
        result.f51y = a.f51y * b.f51y;
        return result;
    }

    public void mul(int value) {
        this.f50x *= value;
        this.f51y *= value;
    }

    public static Int2 mul(Int2 a, int b) {
        Int2 result = new Int2();
        result.f50x = a.f50x * b;
        result.f51y = a.f51y * b;
        return result;
    }

    public void div(Int2 a) {
        this.f50x /= a.f50x;
        this.f51y /= a.f51y;
    }

    public static Int2 div(Int2 a, Int2 b) {
        Int2 result = new Int2();
        result.f50x = a.f50x / b.f50x;
        result.f51y = a.f51y / b.f51y;
        return result;
    }

    public void div(int value) {
        this.f50x /= value;
        this.f51y /= value;
    }

    public static Int2 div(Int2 a, int b) {
        Int2 result = new Int2();
        result.f50x = a.f50x / b;
        result.f51y = a.f51y / b;
        return result;
    }

    public void mod(Int2 a) {
        this.f50x %= a.f50x;
        this.f51y %= a.f51y;
    }

    public static Int2 mod(Int2 a, Int2 b) {
        Int2 result = new Int2();
        result.f50x = a.f50x % b.f50x;
        result.f51y = a.f51y % b.f51y;
        return result;
    }

    public void mod(int value) {
        this.f50x %= value;
        this.f51y %= value;
    }

    public static Int2 mod(Int2 a, int b) {
        Int2 result = new Int2();
        result.f50x = a.f50x % b;
        result.f51y = a.f51y % b;
        return result;
    }

    public int length() {
        return 2;
    }

    public void negate() {
        this.f50x = -this.f50x;
        this.f51y = -this.f51y;
    }

    public int dotProduct(Int2 a) {
        return (this.f50x * a.f50x) + (this.f51y * a.f51y);
    }

    public static int dotProduct(Int2 a, Int2 b) {
        return (b.f50x * a.f50x) + (b.f51y * a.f51y);
    }

    public void addMultiple(Int2 a, int factor) {
        this.f50x += a.f50x * factor;
        this.f51y += a.f51y * factor;
    }

    public void set(Int2 a) {
        this.f50x = a.f50x;
        this.f51y = a.f51y;
    }

    public void setValues(int a, int b) {
        this.f50x = a;
        this.f51y = b;
    }

    public int elementSum() {
        return this.f50x + this.f51y;
    }

    public int get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f50x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f51y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f50x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f51y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, int value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f50x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f51y += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(int[] data, int offset) {
        data[offset] = this.f50x;
        data[offset + 1] = this.f51y;
    }
}
