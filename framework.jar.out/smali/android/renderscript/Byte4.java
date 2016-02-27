package android.renderscript;

import android.widget.Toast;

public class Byte4 {
    public byte f28w;
    public byte f29x;
    public byte f30y;
    public byte f31z;

    public Byte4(byte initX, byte initY, byte initZ, byte initW) {
        this.f29x = initX;
        this.f30y = initY;
        this.f31z = initZ;
        this.f28w = initW;
    }

    public Byte4(Byte4 source) {
        this.f29x = source.f29x;
        this.f30y = source.f30y;
        this.f31z = source.f31z;
        this.f28w = source.f28w;
    }

    public void add(Byte4 a) {
        this.f29x = (byte) (this.f29x + a.f29x);
        this.f30y = (byte) (this.f30y + a.f30y);
        this.f31z = (byte) (this.f31z + a.f31z);
        this.f28w = (byte) (this.f28w + a.f28w);
    }

    public static Byte4 add(Byte4 a, Byte4 b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x + b.f29x);
        result.f30y = (byte) (a.f30y + b.f30y);
        result.f31z = (byte) (a.f31z + b.f31z);
        result.f28w = (byte) (a.f28w + b.f28w);
        return result;
    }

    public void add(byte value) {
        this.f29x = (byte) (this.f29x + value);
        this.f30y = (byte) (this.f30y + value);
        this.f31z = (byte) (this.f31z + value);
        this.f28w = (byte) (this.f28w + value);
    }

    public static Byte4 add(Byte4 a, byte b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x + b);
        result.f30y = (byte) (a.f30y + b);
        result.f31z = (byte) (a.f31z + b);
        result.f28w = (byte) (a.f28w + b);
        return result;
    }

    public void sub(Byte4 a) {
        this.f29x = (byte) (this.f29x - a.f29x);
        this.f30y = (byte) (this.f30y - a.f30y);
        this.f31z = (byte) (this.f31z - a.f31z);
        this.f28w = (byte) (this.f28w - a.f28w);
    }

    public static Byte4 sub(Byte4 a, Byte4 b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x - b.f29x);
        result.f30y = (byte) (a.f30y - b.f30y);
        result.f31z = (byte) (a.f31z - b.f31z);
        result.f28w = (byte) (a.f28w - b.f28w);
        return result;
    }

    public void sub(byte value) {
        this.f29x = (byte) (this.f29x - value);
        this.f30y = (byte) (this.f30y - value);
        this.f31z = (byte) (this.f31z - value);
        this.f28w = (byte) (this.f28w - value);
    }

    public static Byte4 sub(Byte4 a, byte b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x - b);
        result.f30y = (byte) (a.f30y - b);
        result.f31z = (byte) (a.f31z - b);
        result.f28w = (byte) (a.f28w - b);
        return result;
    }

    public void mul(Byte4 a) {
        this.f29x = (byte) (this.f29x * a.f29x);
        this.f30y = (byte) (this.f30y * a.f30y);
        this.f31z = (byte) (this.f31z * a.f31z);
        this.f28w = (byte) (this.f28w * a.f28w);
    }

    public static Byte4 mul(Byte4 a, Byte4 b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x * b.f29x);
        result.f30y = (byte) (a.f30y * b.f30y);
        result.f31z = (byte) (a.f31z * b.f31z);
        result.f28w = (byte) (a.f28w * b.f28w);
        return result;
    }

    public void mul(byte value) {
        this.f29x = (byte) (this.f29x * value);
        this.f30y = (byte) (this.f30y * value);
        this.f31z = (byte) (this.f31z * value);
        this.f28w = (byte) (this.f28w * value);
    }

    public static Byte4 mul(Byte4 a, byte b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x * b);
        result.f30y = (byte) (a.f30y * b);
        result.f31z = (byte) (a.f31z * b);
        result.f28w = (byte) (a.f28w * b);
        return result;
    }

    public void div(Byte4 a) {
        this.f29x = (byte) (this.f29x / a.f29x);
        this.f30y = (byte) (this.f30y / a.f30y);
        this.f31z = (byte) (this.f31z / a.f31z);
        this.f28w = (byte) (this.f28w / a.f28w);
    }

    public static Byte4 div(Byte4 a, Byte4 b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x / b.f29x);
        result.f30y = (byte) (a.f30y / b.f30y);
        result.f31z = (byte) (a.f31z / b.f31z);
        result.f28w = (byte) (a.f28w / b.f28w);
        return result;
    }

    public void div(byte value) {
        this.f29x = (byte) (this.f29x / value);
        this.f30y = (byte) (this.f30y / value);
        this.f31z = (byte) (this.f31z / value);
        this.f28w = (byte) (this.f28w / value);
    }

    public static Byte4 div(Byte4 a, byte b) {
        Byte4 result = new Byte4();
        result.f29x = (byte) (a.f29x / b);
        result.f30y = (byte) (a.f30y / b);
        result.f31z = (byte) (a.f31z / b);
        result.f28w = (byte) (a.f28w / b);
        return result;
    }

    public byte length() {
        return (byte) 4;
    }

    public void negate() {
        this.f29x = (byte) (-this.f29x);
        this.f30y = (byte) (-this.f30y);
        this.f31z = (byte) (-this.f31z);
        this.f28w = (byte) (-this.f28w);
    }

    public byte dotProduct(Byte4 a) {
        return (byte) ((((this.f29x * a.f29x) + (this.f30y * a.f30y)) + (this.f31z * a.f31z)) + (this.f28w * a.f28w));
    }

    public static byte dotProduct(Byte4 a, Byte4 b) {
        return (byte) ((((b.f29x * a.f29x) + (b.f30y * a.f30y)) + (b.f31z * a.f31z)) + (b.f28w * a.f28w));
    }

    public void addMultiple(Byte4 a, byte factor) {
        this.f29x = (byte) (this.f29x + (a.f29x * factor));
        this.f30y = (byte) (this.f30y + (a.f30y * factor));
        this.f31z = (byte) (this.f31z + (a.f31z * factor));
        this.f28w = (byte) (this.f28w + (a.f28w * factor));
    }

    public void set(Byte4 a) {
        this.f29x = a.f29x;
        this.f30y = a.f30y;
        this.f31z = a.f31z;
        this.f28w = a.f28w;
    }

    public void setValues(byte a, byte b, byte c, byte d) {
        this.f29x = a;
        this.f30y = b;
        this.f31z = c;
        this.f28w = d;
    }

    public byte elementSum() {
        return (byte) (((this.f29x + this.f30y) + this.f31z) + this.f28w);
    }

    public byte get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f29x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f30y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f31z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f28w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f29x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f30y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f31z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f28w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f29x = (byte) (this.f29x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f30y = (byte) (this.f30y + value);
            case Action.MERGE_IGNORE /*2*/:
                this.f31z = (byte) (this.f31z + value);
            case SetDrawableParameters.TAG /*3*/:
                this.f28w = (byte) (this.f28w + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(byte[] data, int offset) {
        data[offset] = this.f29x;
        data[offset + 1] = this.f30y;
        data[offset + 2] = this.f31z;
        data[offset + 3] = this.f28w;
    }
}
