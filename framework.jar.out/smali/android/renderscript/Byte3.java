package android.renderscript;

import android.widget.Toast;

public class Byte3 {
    public byte f25x;
    public byte f26y;
    public byte f27z;

    public Byte3(byte initX, byte initY, byte initZ) {
        this.f25x = initX;
        this.f26y = initY;
        this.f27z = initZ;
    }

    public Byte3(Byte3 source) {
        this.f25x = source.f25x;
        this.f26y = source.f26y;
        this.f27z = source.f27z;
    }

    public void add(Byte3 a) {
        this.f25x = (byte) (this.f25x + a.f25x);
        this.f26y = (byte) (this.f26y + a.f26y);
        this.f27z = (byte) (this.f27z + a.f27z);
    }

    public static Byte3 add(Byte3 a, Byte3 b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x + b.f25x);
        result.f26y = (byte) (a.f26y + b.f26y);
        result.f27z = (byte) (a.f27z + b.f27z);
        return result;
    }

    public void add(byte value) {
        this.f25x = (byte) (this.f25x + value);
        this.f26y = (byte) (this.f26y + value);
        this.f27z = (byte) (this.f27z + value);
    }

    public static Byte3 add(Byte3 a, byte b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x + b);
        result.f26y = (byte) (a.f26y + b);
        result.f27z = (byte) (a.f27z + b);
        return result;
    }

    public void sub(Byte3 a) {
        this.f25x = (byte) (this.f25x - a.f25x);
        this.f26y = (byte) (this.f26y - a.f26y);
        this.f27z = (byte) (this.f27z - a.f27z);
    }

    public static Byte3 sub(Byte3 a, Byte3 b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x - b.f25x);
        result.f26y = (byte) (a.f26y - b.f26y);
        result.f27z = (byte) (a.f27z - b.f27z);
        return result;
    }

    public void sub(byte value) {
        this.f25x = (byte) (this.f25x - value);
        this.f26y = (byte) (this.f26y - value);
        this.f27z = (byte) (this.f27z - value);
    }

    public static Byte3 sub(Byte3 a, byte b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x - b);
        result.f26y = (byte) (a.f26y - b);
        result.f27z = (byte) (a.f27z - b);
        return result;
    }

    public void mul(Byte3 a) {
        this.f25x = (byte) (this.f25x * a.f25x);
        this.f26y = (byte) (this.f26y * a.f26y);
        this.f27z = (byte) (this.f27z * a.f27z);
    }

    public static Byte3 mul(Byte3 a, Byte3 b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x * b.f25x);
        result.f26y = (byte) (a.f26y * b.f26y);
        result.f27z = (byte) (a.f27z * b.f27z);
        return result;
    }

    public void mul(byte value) {
        this.f25x = (byte) (this.f25x * value);
        this.f26y = (byte) (this.f26y * value);
        this.f27z = (byte) (this.f27z * value);
    }

    public static Byte3 mul(Byte3 a, byte b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x * b);
        result.f26y = (byte) (a.f26y * b);
        result.f27z = (byte) (a.f27z * b);
        return result;
    }

    public void div(Byte3 a) {
        this.f25x = (byte) (this.f25x / a.f25x);
        this.f26y = (byte) (this.f26y / a.f26y);
        this.f27z = (byte) (this.f27z / a.f27z);
    }

    public static Byte3 div(Byte3 a, Byte3 b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x / b.f25x);
        result.f26y = (byte) (a.f26y / b.f26y);
        result.f27z = (byte) (a.f27z / b.f27z);
        return result;
    }

    public void div(byte value) {
        this.f25x = (byte) (this.f25x / value);
        this.f26y = (byte) (this.f26y / value);
        this.f27z = (byte) (this.f27z / value);
    }

    public static Byte3 div(Byte3 a, byte b) {
        Byte3 result = new Byte3();
        result.f25x = (byte) (a.f25x / b);
        result.f26y = (byte) (a.f26y / b);
        result.f27z = (byte) (a.f27z / b);
        return result;
    }

    public byte length() {
        return (byte) 3;
    }

    public void negate() {
        this.f25x = (byte) (-this.f25x);
        this.f26y = (byte) (-this.f26y);
        this.f27z = (byte) (-this.f27z);
    }

    public byte dotProduct(Byte3 a) {
        return (byte) (((byte) (((byte) (this.f25x * a.f25x)) + ((byte) (this.f26y * a.f26y)))) + ((byte) (this.f27z * a.f27z)));
    }

    public static byte dotProduct(Byte3 a, Byte3 b) {
        return (byte) (((byte) (((byte) (b.f25x * a.f25x)) + ((byte) (b.f26y * a.f26y)))) + ((byte) (b.f27z * a.f27z)));
    }

    public void addMultiple(Byte3 a, byte factor) {
        this.f25x = (byte) (this.f25x + (a.f25x * factor));
        this.f26y = (byte) (this.f26y + (a.f26y * factor));
        this.f27z = (byte) (this.f27z + (a.f27z * factor));
    }

    public void set(Byte3 a) {
        this.f25x = a.f25x;
        this.f26y = a.f26y;
        this.f27z = a.f27z;
    }

    public void setValues(byte a, byte b, byte c) {
        this.f25x = a;
        this.f26y = b;
        this.f27z = c;
    }

    public byte elementSum() {
        return (byte) ((this.f25x + this.f26y) + this.f27z);
    }

    public byte get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f25x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f26y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f27z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f25x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f26y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f27z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f25x = (byte) (this.f25x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f26y = (byte) (this.f26y + value);
            case Action.MERGE_IGNORE /*2*/:
                this.f27z = (byte) (this.f27z + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(byte[] data, int offset) {
        data[offset] = this.f25x;
        data[offset + 1] = this.f26y;
        data[offset + 2] = this.f27z;
    }
}
