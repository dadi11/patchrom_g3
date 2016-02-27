package android.renderscript;

import android.widget.Toast;

public class Short2 {
    public short f73x;
    public short f74y;

    public Short2(short i) {
        this.f74y = i;
        this.f73x = i;
    }

    public Short2(short x, short y) {
        this.f73x = x;
        this.f74y = y;
    }

    public Short2(Short2 source) {
        this.f73x = source.f73x;
        this.f74y = source.f74y;
    }

    public void add(Short2 a) {
        this.f73x = (short) (this.f73x + a.f73x);
        this.f74y = (short) (this.f74y + a.f74y);
    }

    public static Short2 add(Short2 a, Short2 b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x + b.f73x);
        result.f74y = (short) (a.f74y + b.f74y);
        return result;
    }

    public void add(short value) {
        this.f73x = (short) (this.f73x + value);
        this.f74y = (short) (this.f74y + value);
    }

    public static Short2 add(Short2 a, short b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x + b);
        result.f74y = (short) (a.f74y + b);
        return result;
    }

    public void sub(Short2 a) {
        this.f73x = (short) (this.f73x - a.f73x);
        this.f74y = (short) (this.f74y - a.f74y);
    }

    public static Short2 sub(Short2 a, Short2 b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x - b.f73x);
        result.f74y = (short) (a.f74y - b.f74y);
        return result;
    }

    public void sub(short value) {
        this.f73x = (short) (this.f73x - value);
        this.f74y = (short) (this.f74y - value);
    }

    public static Short2 sub(Short2 a, short b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x - b);
        result.f74y = (short) (a.f74y - b);
        return result;
    }

    public void mul(Short2 a) {
        this.f73x = (short) (this.f73x * a.f73x);
        this.f74y = (short) (this.f74y * a.f74y);
    }

    public static Short2 mul(Short2 a, Short2 b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x * b.f73x);
        result.f74y = (short) (a.f74y * b.f74y);
        return result;
    }

    public void mul(short value) {
        this.f73x = (short) (this.f73x * value);
        this.f74y = (short) (this.f74y * value);
    }

    public static Short2 mul(Short2 a, short b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x * b);
        result.f74y = (short) (a.f74y * b);
        return result;
    }

    public void div(Short2 a) {
        this.f73x = (short) (this.f73x / a.f73x);
        this.f74y = (short) (this.f74y / a.f74y);
    }

    public static Short2 div(Short2 a, Short2 b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x / b.f73x);
        result.f74y = (short) (a.f74y / b.f74y);
        return result;
    }

    public void div(short value) {
        this.f73x = (short) (this.f73x / value);
        this.f74y = (short) (this.f74y / value);
    }

    public static Short2 div(Short2 a, short b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x / b);
        result.f74y = (short) (a.f74y / b);
        return result;
    }

    public void mod(Short2 a) {
        this.f73x = (short) (this.f73x % a.f73x);
        this.f74y = (short) (this.f74y % a.f74y);
    }

    public static Short2 mod(Short2 a, Short2 b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x % b.f73x);
        result.f74y = (short) (a.f74y % b.f74y);
        return result;
    }

    public void mod(short value) {
        this.f73x = (short) (this.f73x % value);
        this.f74y = (short) (this.f74y % value);
    }

    public static Short2 mod(Short2 a, short b) {
        Short2 result = new Short2();
        result.f73x = (short) (a.f73x % b);
        result.f74y = (short) (a.f74y % b);
        return result;
    }

    public short length() {
        return (short) 2;
    }

    public void negate() {
        this.f73x = (short) (-this.f73x);
        this.f74y = (short) (-this.f74y);
    }

    public short dotProduct(Short2 a) {
        return (short) ((this.f73x * a.f73x) + (this.f74y * a.f74y));
    }

    public static short dotProduct(Short2 a, Short2 b) {
        return (short) ((b.f73x * a.f73x) + (b.f74y * a.f74y));
    }

    public void addMultiple(Short2 a, short factor) {
        this.f73x = (short) (this.f73x + (a.f73x * factor));
        this.f74y = (short) (this.f74y + (a.f74y * factor));
    }

    public void set(Short2 a) {
        this.f73x = a.f73x;
        this.f74y = a.f74y;
    }

    public void setValues(short a, short b) {
        this.f73x = a;
        this.f74y = b;
    }

    public short elementSum() {
        return (short) (this.f73x + this.f74y);
    }

    public short get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f73x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f74y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f73x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f74y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f73x = (short) (this.f73x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f74y = (short) (this.f74y + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(short[] data, int offset) {
        data[offset] = this.f73x;
        data[offset + 1] = this.f74y;
    }
}
