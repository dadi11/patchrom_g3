package android.renderscript;

import android.widget.Toast;

public class Short3 {
    public short f75x;
    public short f76y;
    public short f77z;

    public Short3(short i) {
        this.f77z = i;
        this.f76y = i;
        this.f75x = i;
    }

    public Short3(short x, short y, short z) {
        this.f75x = x;
        this.f76y = y;
        this.f77z = z;
    }

    public Short3(Short3 source) {
        this.f75x = source.f75x;
        this.f76y = source.f76y;
        this.f77z = source.f77z;
    }

    public void add(Short3 a) {
        this.f75x = (short) (this.f75x + a.f75x);
        this.f76y = (short) (this.f76y + a.f76y);
        this.f77z = (short) (this.f77z + a.f77z);
    }

    public static Short3 add(Short3 a, Short3 b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x + b.f75x);
        result.f76y = (short) (a.f76y + b.f76y);
        result.f77z = (short) (a.f77z + b.f77z);
        return result;
    }

    public void add(short value) {
        this.f75x = (short) (this.f75x + value);
        this.f76y = (short) (this.f76y + value);
        this.f77z = (short) (this.f77z + value);
    }

    public static Short3 add(Short3 a, short b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x + b);
        result.f76y = (short) (a.f76y + b);
        result.f77z = (short) (a.f77z + b);
        return result;
    }

    public void sub(Short3 a) {
        this.f75x = (short) (this.f75x - a.f75x);
        this.f76y = (short) (this.f76y - a.f76y);
        this.f77z = (short) (this.f77z - a.f77z);
    }

    public static Short3 sub(Short3 a, Short3 b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x - b.f75x);
        result.f76y = (short) (a.f76y - b.f76y);
        result.f77z = (short) (a.f77z - b.f77z);
        return result;
    }

    public void sub(short value) {
        this.f75x = (short) (this.f75x - value);
        this.f76y = (short) (this.f76y - value);
        this.f77z = (short) (this.f77z - value);
    }

    public static Short3 sub(Short3 a, short b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x - b);
        result.f76y = (short) (a.f76y - b);
        result.f77z = (short) (a.f77z - b);
        return result;
    }

    public void mul(Short3 a) {
        this.f75x = (short) (this.f75x * a.f75x);
        this.f76y = (short) (this.f76y * a.f76y);
        this.f77z = (short) (this.f77z * a.f77z);
    }

    public static Short3 mul(Short3 a, Short3 b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x * b.f75x);
        result.f76y = (short) (a.f76y * b.f76y);
        result.f77z = (short) (a.f77z * b.f77z);
        return result;
    }

    public void mul(short value) {
        this.f75x = (short) (this.f75x * value);
        this.f76y = (short) (this.f76y * value);
        this.f77z = (short) (this.f77z * value);
    }

    public static Short3 mul(Short3 a, short b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x * b);
        result.f76y = (short) (a.f76y * b);
        result.f77z = (short) (a.f77z * b);
        return result;
    }

    public void div(Short3 a) {
        this.f75x = (short) (this.f75x / a.f75x);
        this.f76y = (short) (this.f76y / a.f76y);
        this.f77z = (short) (this.f77z / a.f77z);
    }

    public static Short3 div(Short3 a, Short3 b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x / b.f75x);
        result.f76y = (short) (a.f76y / b.f76y);
        result.f77z = (short) (a.f77z / b.f77z);
        return result;
    }

    public void div(short value) {
        this.f75x = (short) (this.f75x / value);
        this.f76y = (short) (this.f76y / value);
        this.f77z = (short) (this.f77z / value);
    }

    public static Short3 div(Short3 a, short b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x / b);
        result.f76y = (short) (a.f76y / b);
        result.f77z = (short) (a.f77z / b);
        return result;
    }

    public void mod(Short3 a) {
        this.f75x = (short) (this.f75x % a.f75x);
        this.f76y = (short) (this.f76y % a.f76y);
        this.f77z = (short) (this.f77z % a.f77z);
    }

    public static Short3 mod(Short3 a, Short3 b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x % b.f75x);
        result.f76y = (short) (a.f76y % b.f76y);
        result.f77z = (short) (a.f77z % b.f77z);
        return result;
    }

    public void mod(short value) {
        this.f75x = (short) (this.f75x % value);
        this.f76y = (short) (this.f76y % value);
        this.f77z = (short) (this.f77z % value);
    }

    public static Short3 mod(Short3 a, short b) {
        Short3 result = new Short3();
        result.f75x = (short) (a.f75x % b);
        result.f76y = (short) (a.f76y % b);
        result.f77z = (short) (a.f77z % b);
        return result;
    }

    public short length() {
        return (short) 3;
    }

    public void negate() {
        this.f75x = (short) (-this.f75x);
        this.f76y = (short) (-this.f76y);
        this.f77z = (short) (-this.f77z);
    }

    public short dotProduct(Short3 a) {
        return (short) (((this.f75x * a.f75x) + (this.f76y * a.f76y)) + (this.f77z * a.f77z));
    }

    public static short dotProduct(Short3 a, Short3 b) {
        return (short) (((b.f75x * a.f75x) + (b.f76y * a.f76y)) + (b.f77z * a.f77z));
    }

    public void addMultiple(Short3 a, short factor) {
        this.f75x = (short) (this.f75x + (a.f75x * factor));
        this.f76y = (short) (this.f76y + (a.f76y * factor));
        this.f77z = (short) (this.f77z + (a.f77z * factor));
    }

    public void set(Short3 a) {
        this.f75x = a.f75x;
        this.f76y = a.f76y;
        this.f77z = a.f77z;
    }

    public void setValues(short a, short b, short c) {
        this.f75x = a;
        this.f76y = b;
        this.f77z = c;
    }

    public short elementSum() {
        return (short) ((this.f75x + this.f76y) + this.f77z);
    }

    public short get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f75x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f76y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f77z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f75x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f76y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f77z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f75x = (short) (this.f75x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f76y = (short) (this.f76y + value);
            case Action.MERGE_IGNORE /*2*/:
                this.f77z = (short) (this.f77z + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(short[] data, int offset) {
        data[offset] = this.f75x;
        data[offset + 1] = this.f76y;
        data[offset + 2] = this.f77z;
    }
}
