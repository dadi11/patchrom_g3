package android.renderscript;

import android.widget.Toast;

public class Float3 {
    public float f43x;
    public float f44y;
    public float f45z;

    public Float3(Float3 data) {
        this.f43x = data.f43x;
        this.f44y = data.f44y;
        this.f45z = data.f45z;
    }

    public Float3(float x, float y, float z) {
        this.f43x = x;
        this.f44y = y;
        this.f45z = z;
    }

    public static Float3 add(Float3 a, Float3 b) {
        Float3 res = new Float3();
        res.f43x = a.f43x + b.f43x;
        res.f44y = a.f44y + b.f44y;
        res.f45z = a.f45z + b.f45z;
        return res;
    }

    public void add(Float3 value) {
        this.f43x += value.f43x;
        this.f44y += value.f44y;
        this.f45z += value.f45z;
    }

    public void add(float value) {
        this.f43x += value;
        this.f44y += value;
        this.f45z += value;
    }

    public static Float3 add(Float3 a, float b) {
        Float3 res = new Float3();
        res.f43x = a.f43x + b;
        res.f44y = a.f44y + b;
        res.f45z = a.f45z + b;
        return res;
    }

    public void sub(Float3 value) {
        this.f43x -= value.f43x;
        this.f44y -= value.f44y;
        this.f45z -= value.f45z;
    }

    public static Float3 sub(Float3 a, Float3 b) {
        Float3 res = new Float3();
        res.f43x = a.f43x - b.f43x;
        res.f44y = a.f44y - b.f44y;
        res.f45z = a.f45z - b.f45z;
        return res;
    }

    public void sub(float value) {
        this.f43x -= value;
        this.f44y -= value;
        this.f45z -= value;
    }

    public static Float3 sub(Float3 a, float b) {
        Float3 res = new Float3();
        res.f43x = a.f43x - b;
        res.f44y = a.f44y - b;
        res.f45z = a.f45z - b;
        return res;
    }

    public void mul(Float3 value) {
        this.f43x *= value.f43x;
        this.f44y *= value.f44y;
        this.f45z *= value.f45z;
    }

    public static Float3 mul(Float3 a, Float3 b) {
        Float3 res = new Float3();
        res.f43x = a.f43x * b.f43x;
        res.f44y = a.f44y * b.f44y;
        res.f45z = a.f45z * b.f45z;
        return res;
    }

    public void mul(float value) {
        this.f43x *= value;
        this.f44y *= value;
        this.f45z *= value;
    }

    public static Float3 mul(Float3 a, float b) {
        Float3 res = new Float3();
        res.f43x = a.f43x * b;
        res.f44y = a.f44y * b;
        res.f45z = a.f45z * b;
        return res;
    }

    public void div(Float3 value) {
        this.f43x /= value.f43x;
        this.f44y /= value.f44y;
        this.f45z /= value.f45z;
    }

    public static Float3 div(Float3 a, Float3 b) {
        Float3 res = new Float3();
        res.f43x = a.f43x / b.f43x;
        res.f44y = a.f44y / b.f44y;
        res.f45z = a.f45z / b.f45z;
        return res;
    }

    public void div(float value) {
        this.f43x /= value;
        this.f44y /= value;
        this.f45z /= value;
    }

    public static Float3 div(Float3 a, float b) {
        Float3 res = new Float3();
        res.f43x = a.f43x / b;
        res.f44y = a.f44y / b;
        res.f45z = a.f45z / b;
        return res;
    }

    public Float dotProduct(Float3 a) {
        return new Float(((this.f43x * a.f43x) + (this.f44y * a.f44y)) + (this.f45z * a.f45z));
    }

    public static Float dotProduct(Float3 a, Float3 b) {
        return new Float(((b.f43x * a.f43x) + (b.f44y * a.f44y)) + (b.f45z * a.f45z));
    }

    public void addMultiple(Float3 a, float factor) {
        this.f43x += a.f43x * factor;
        this.f44y += a.f44y * factor;
        this.f45z += a.f45z * factor;
    }

    public void set(Float3 a) {
        this.f43x = a.f43x;
        this.f44y = a.f44y;
        this.f45z = a.f45z;
    }

    public void negate() {
        this.f43x = -this.f43x;
        this.f44y = -this.f44y;
        this.f45z = -this.f45z;
    }

    public int length() {
        return 3;
    }

    public Float elementSum() {
        return new Float((this.f43x + this.f44y) + this.f45z);
    }

    public float get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f43x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f44y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f45z;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f43x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f44y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f45z = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f43x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f44y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f45z += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(float x, float y, float z) {
        this.f43x = x;
        this.f44y = y;
        this.f45z = z;
    }

    public void copyTo(float[] data, int offset) {
        data[offset] = this.f43x;
        data[offset + 1] = this.f44y;
        data[offset + 2] = this.f45z;
    }
}
