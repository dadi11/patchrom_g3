package android.renderscript;

import android.widget.Toast;

public class Short4 {
    public short f78w;
    public short f79x;
    public short f80y;
    public short f81z;

    public Short4(short i) {
        this.f78w = i;
        this.f81z = i;
        this.f80y = i;
        this.f79x = i;
    }

    public Short4(short x, short y, short z, short w) {
        this.f79x = x;
        this.f80y = y;
        this.f81z = z;
        this.f78w = w;
    }

    public Short4(Short4 source) {
        this.f79x = source.f79x;
        this.f80y = source.f80y;
        this.f81z = source.f81z;
        this.f78w = source.f78w;
    }

    public void add(Short4 a) {
        this.f79x = (short) (this.f79x + a.f79x);
        this.f80y = (short) (this.f80y + a.f80y);
        this.f81z = (short) (this.f81z + a.f81z);
        this.f78w = (short) (this.f78w + a.f78w);
    }

    public static Short4 add(Short4 a, Short4 b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x + b.f79x);
        result.f80y = (short) (a.f80y + b.f80y);
        result.f81z = (short) (a.f81z + b.f81z);
        result.f78w = (short) (a.f78w + b.f78w);
        return result;
    }

    public void add(short value) {
        this.f79x = (short) (this.f79x + value);
        this.f80y = (short) (this.f80y + value);
        this.f81z = (short) (this.f81z + value);
        this.f78w = (short) (this.f78w + value);
    }

    public static Short4 add(Short4 a, short b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x + b);
        result.f80y = (short) (a.f80y + b);
        result.f81z = (short) (a.f81z + b);
        result.f78w = (short) (a.f78w + b);
        return result;
    }

    public void sub(Short4 a) {
        this.f79x = (short) (this.f79x - a.f79x);
        this.f80y = (short) (this.f80y - a.f80y);
        this.f81z = (short) (this.f81z - a.f81z);
        this.f78w = (short) (this.f78w - a.f78w);
    }

    public static Short4 sub(Short4 a, Short4 b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x - b.f79x);
        result.f80y = (short) (a.f80y - b.f80y);
        result.f81z = (short) (a.f81z - b.f81z);
        result.f78w = (short) (a.f78w - b.f78w);
        return result;
    }

    public void sub(short value) {
        this.f79x = (short) (this.f79x - value);
        this.f80y = (short) (this.f80y - value);
        this.f81z = (short) (this.f81z - value);
        this.f78w = (short) (this.f78w - value);
    }

    public static Short4 sub(Short4 a, short b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x - b);
        result.f80y = (short) (a.f80y - b);
        result.f81z = (short) (a.f81z - b);
        result.f78w = (short) (a.f78w - b);
        return result;
    }

    public void mul(Short4 a) {
        this.f79x = (short) (this.f79x * a.f79x);
        this.f80y = (short) (this.f80y * a.f80y);
        this.f81z = (short) (this.f81z * a.f81z);
        this.f78w = (short) (this.f78w * a.f78w);
    }

    public static Short4 mul(Short4 a, Short4 b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x * b.f79x);
        result.f80y = (short) (a.f80y * b.f80y);
        result.f81z = (short) (a.f81z * b.f81z);
        result.f78w = (short) (a.f78w * b.f78w);
        return result;
    }

    public void mul(short value) {
        this.f79x = (short) (this.f79x * value);
        this.f80y = (short) (this.f80y * value);
        this.f81z = (short) (this.f81z * value);
        this.f78w = (short) (this.f78w * value);
    }

    public static Short4 mul(Short4 a, short b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x * b);
        result.f80y = (short) (a.f80y * b);
        result.f81z = (short) (a.f81z * b);
        result.f78w = (short) (a.f78w * b);
        return result;
    }

    public void div(Short4 a) {
        this.f79x = (short) (this.f79x / a.f79x);
        this.f80y = (short) (this.f80y / a.f80y);
        this.f81z = (short) (this.f81z / a.f81z);
        this.f78w = (short) (this.f78w / a.f78w);
    }

    public static Short4 div(Short4 a, Short4 b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x / b.f79x);
        result.f80y = (short) (a.f80y / b.f80y);
        result.f81z = (short) (a.f81z / b.f81z);
        result.f78w = (short) (a.f78w / b.f78w);
        return result;
    }

    public void div(short value) {
        this.f79x = (short) (this.f79x / value);
        this.f80y = (short) (this.f80y / value);
        this.f81z = (short) (this.f81z / value);
        this.f78w = (short) (this.f78w / value);
    }

    public static Short4 div(Short4 a, short b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x / b);
        result.f80y = (short) (a.f80y / b);
        result.f81z = (short) (a.f81z / b);
        result.f78w = (short) (a.f78w / b);
        return result;
    }

    public void mod(Short4 a) {
        this.f79x = (short) (this.f79x % a.f79x);
        this.f80y = (short) (this.f80y % a.f80y);
        this.f81z = (short) (this.f81z % a.f81z);
        this.f78w = (short) (this.f78w % a.f78w);
    }

    public static Short4 mod(Short4 a, Short4 b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x % b.f79x);
        result.f80y = (short) (a.f80y % b.f80y);
        result.f81z = (short) (a.f81z % b.f81z);
        result.f78w = (short) (a.f78w % b.f78w);
        return result;
    }

    public void mod(short value) {
        this.f79x = (short) (this.f79x % value);
        this.f80y = (short) (this.f80y % value);
        this.f81z = (short) (this.f81z % value);
        this.f78w = (short) (this.f78w % value);
    }

    public static Short4 mod(Short4 a, short b) {
        Short4 result = new Short4();
        result.f79x = (short) (a.f79x % b);
        result.f80y = (short) (a.f80y % b);
        result.f81z = (short) (a.f81z % b);
        result.f78w = (short) (a.f78w % b);
        return result;
    }

    public short length() {
        return (short) 4;
    }

    public void negate() {
        this.f79x = (short) (-this.f79x);
        this.f80y = (short) (-this.f80y);
        this.f81z = (short) (-this.f81z);
        this.f78w = (short) (-this.f78w);
    }

    public short dotProduct(Short4 a) {
        return (short) ((((this.f79x * a.f79x) + (this.f80y * a.f80y)) + (this.f81z * a.f81z)) + (this.f78w * a.f78w));
    }

    public static short dotProduct(Short4 a, Short4 b) {
        return (short) ((((b.f79x * a.f79x) + (b.f80y * a.f80y)) + (b.f81z * a.f81z)) + (b.f78w * a.f78w));
    }

    public void addMultiple(Short4 a, short factor) {
        this.f79x = (short) (this.f79x + (a.f79x * factor));
        this.f80y = (short) (this.f80y + (a.f80y * factor));
        this.f81z = (short) (this.f81z + (a.f81z * factor));
        this.f78w = (short) (this.f78w + (a.f78w * factor));
    }

    public void set(Short4 a) {
        this.f79x = a.f79x;
        this.f80y = a.f80y;
        this.f81z = a.f81z;
        this.f78w = a.f78w;
    }

    public void setValues(short a, short b, short c, short d) {
        this.f79x = a;
        this.f80y = b;
        this.f81z = c;
        this.f78w = d;
    }

    public short elementSum() {
        return (short) (((this.f79x + this.f80y) + this.f81z) + this.f78w);
    }

    public short get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f79x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f80y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f81z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f78w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f79x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f80y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f81z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f78w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, short value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f79x = (short) (this.f79x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f80y = (short) (this.f80y + value);
            case Action.MERGE_IGNORE /*2*/:
                this.f81z = (short) (this.f81z + value);
            case SetDrawableParameters.TAG /*3*/:
                this.f78w = (short) (this.f78w + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(short[] data, int offset) {
        data[offset] = this.f79x;
        data[offset + 1] = this.f80y;
        data[offset + 2] = this.f81z;
        data[offset + 3] = this.f78w;
    }
}
