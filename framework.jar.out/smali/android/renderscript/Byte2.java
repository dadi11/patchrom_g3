package android.renderscript;

import android.widget.Toast;

public class Byte2 {
    public byte f23x;
    public byte f24y;

    public Byte2(byte initX, byte initY) {
        this.f23x = initX;
        this.f24y = initY;
    }

    public Byte2(Byte2 source) {
        this.f23x = source.f23x;
        this.f24y = source.f24y;
    }

    public void add(Byte2 a) {
        this.f23x = (byte) (this.f23x + a.f23x);
        this.f24y = (byte) (this.f24y + a.f24y);
    }

    public static Byte2 add(Byte2 a, Byte2 b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x + b.f23x);
        result.f24y = (byte) (a.f24y + b.f24y);
        return result;
    }

    public void add(byte value) {
        this.f23x = (byte) (this.f23x + value);
        this.f24y = (byte) (this.f24y + value);
    }

    public static Byte2 add(Byte2 a, byte b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x + b);
        result.f24y = (byte) (a.f24y + b);
        return result;
    }

    public void sub(Byte2 a) {
        this.f23x = (byte) (this.f23x - a.f23x);
        this.f24y = (byte) (this.f24y - a.f24y);
    }

    public static Byte2 sub(Byte2 a, Byte2 b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x - b.f23x);
        result.f24y = (byte) (a.f24y - b.f24y);
        return result;
    }

    public void sub(byte value) {
        this.f23x = (byte) (this.f23x - value);
        this.f24y = (byte) (this.f24y - value);
    }

    public static Byte2 sub(Byte2 a, byte b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x - b);
        result.f24y = (byte) (a.f24y - b);
        return result;
    }

    public void mul(Byte2 a) {
        this.f23x = (byte) (this.f23x * a.f23x);
        this.f24y = (byte) (this.f24y * a.f24y);
    }

    public static Byte2 mul(Byte2 a, Byte2 b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x * b.f23x);
        result.f24y = (byte) (a.f24y * b.f24y);
        return result;
    }

    public void mul(byte value) {
        this.f23x = (byte) (this.f23x * value);
        this.f24y = (byte) (this.f24y * value);
    }

    public static Byte2 mul(Byte2 a, byte b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x * b);
        result.f24y = (byte) (a.f24y * b);
        return result;
    }

    public void div(Byte2 a) {
        this.f23x = (byte) (this.f23x / a.f23x);
        this.f24y = (byte) (this.f24y / a.f24y);
    }

    public static Byte2 div(Byte2 a, Byte2 b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x / b.f23x);
        result.f24y = (byte) (a.f24y / b.f24y);
        return result;
    }

    public void div(byte value) {
        this.f23x = (byte) (this.f23x / value);
        this.f24y = (byte) (this.f24y / value);
    }

    public static Byte2 div(Byte2 a, byte b) {
        Byte2 result = new Byte2();
        result.f23x = (byte) (a.f23x / b);
        result.f24y = (byte) (a.f24y / b);
        return result;
    }

    public byte length() {
        return (byte) 2;
    }

    public void negate() {
        this.f23x = (byte) (-this.f23x);
        this.f24y = (byte) (-this.f24y);
    }

    public byte dotProduct(Byte2 a) {
        return (byte) ((this.f23x * a.f23x) + (this.f24y * a.f24y));
    }

    public static byte dotProduct(Byte2 a, Byte2 b) {
        return (byte) ((b.f23x * a.f23x) + (b.f24y * a.f24y));
    }

    public void addMultiple(Byte2 a, byte factor) {
        this.f23x = (byte) (this.f23x + (a.f23x * factor));
        this.f24y = (byte) (this.f24y + (a.f24y * factor));
    }

    public void set(Byte2 a) {
        this.f23x = a.f23x;
        this.f24y = a.f24y;
    }

    public void setValues(byte a, byte b) {
        this.f23x = a;
        this.f24y = b;
    }

    public byte elementSum() {
        return (byte) (this.f23x + this.f24y);
    }

    public byte get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f23x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f24y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f23x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f24y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, byte value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f23x = (byte) (this.f23x + value);
            case Toast.LENGTH_LONG /*1*/:
                this.f24y = (byte) (this.f24y + value);
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(byte[] data, int offset) {
        data[offset] = this.f23x;
        data[offset + 1] = this.f24y;
    }
}
