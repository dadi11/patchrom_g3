package android.renderscript;

import android.widget.Toast;

public class Float4 {
    public float f46w;
    public float f47x;
    public float f48y;
    public float f49z;

    public Float4(Float4 data) {
        this.f47x = data.f47x;
        this.f48y = data.f48y;
        this.f49z = data.f49z;
        this.f46w = data.f46w;
    }

    public Float4(float x, float y, float z, float w) {
        this.f47x = x;
        this.f48y = y;
        this.f49z = z;
        this.f46w = w;
    }

    public static Float4 add(Float4 a, Float4 b) {
        Float4 res = new Float4();
        res.f47x = a.f47x + b.f47x;
        res.f48y = a.f48y + b.f48y;
        res.f49z = a.f49z + b.f49z;
        res.f46w = a.f46w + b.f46w;
        return res;
    }

    public void add(Float4 value) {
        this.f47x += value.f47x;
        this.f48y += value.f48y;
        this.f49z += value.f49z;
        this.f46w += value.f46w;
    }

    public void add(float value) {
        this.f47x += value;
        this.f48y += value;
        this.f49z += value;
        this.f46w += value;
    }

    public static Float4 add(Float4 a, float b) {
        Float4 res = new Float4();
        res.f47x = a.f47x + b;
        res.f48y = a.f48y + b;
        res.f49z = a.f49z + b;
        res.f46w = a.f46w + b;
        return res;
    }

    public void sub(Float4 value) {
        this.f47x -= value.f47x;
        this.f48y -= value.f48y;
        this.f49z -= value.f49z;
        this.f46w -= value.f46w;
    }

    public void sub(float value) {
        this.f47x -= value;
        this.f48y -= value;
        this.f49z -= value;
        this.f46w -= value;
    }

    public static Float4 sub(Float4 a, float b) {
        Float4 res = new Float4();
        res.f47x = a.f47x - b;
        res.f48y = a.f48y - b;
        res.f49z = a.f49z - b;
        res.f46w = a.f46w - b;
        return res;
    }

    public static Float4 sub(Float4 a, Float4 b) {
        Float4 res = new Float4();
        res.f47x = a.f47x - b.f47x;
        res.f48y = a.f48y - b.f48y;
        res.f49z = a.f49z - b.f49z;
        res.f46w = a.f46w - b.f46w;
        return res;
    }

    public void mul(Float4 value) {
        this.f47x *= value.f47x;
        this.f48y *= value.f48y;
        this.f49z *= value.f49z;
        this.f46w *= value.f46w;
    }

    public void mul(float value) {
        this.f47x *= value;
        this.f48y *= value;
        this.f49z *= value;
        this.f46w *= value;
    }

    public static Float4 mul(Float4 a, Float4 b) {
        Float4 res = new Float4();
        res.f47x = a.f47x * b.f47x;
        res.f48y = a.f48y * b.f48y;
        res.f49z = a.f49z * b.f49z;
        res.f46w = a.f46w * b.f46w;
        return res;
    }

    public static Float4 mul(Float4 a, float b) {
        Float4 res = new Float4();
        res.f47x = a.f47x * b;
        res.f48y = a.f48y * b;
        res.f49z = a.f49z * b;
        res.f46w = a.f46w * b;
        return res;
    }

    public void div(Float4 value) {
        this.f47x /= value.f47x;
        this.f48y /= value.f48y;
        this.f49z /= value.f49z;
        this.f46w /= value.f46w;
    }

    public void div(float value) {
        this.f47x /= value;
        this.f48y /= value;
        this.f49z /= value;
        this.f46w /= value;
    }

    public static Float4 div(Float4 a, float b) {
        Float4 res = new Float4();
        res.f47x = a.f47x / b;
        res.f48y = a.f48y / b;
        res.f49z = a.f49z / b;
        res.f46w = a.f46w / b;
        return res;
    }

    public static Float4 div(Float4 a, Float4 b) {
        Float4 res = new Float4();
        res.f47x = a.f47x / b.f47x;
        res.f48y = a.f48y / b.f48y;
        res.f49z = a.f49z / b.f49z;
        res.f46w = a.f46w / b.f46w;
        return res;
    }

    public float dotProduct(Float4 a) {
        return (((this.f47x * a.f47x) + (this.f48y * a.f48y)) + (this.f49z * a.f49z)) + (this.f46w * a.f46w);
    }

    public static float dotProduct(Float4 a, Float4 b) {
        return (((b.f47x * a.f47x) + (b.f48y * a.f48y)) + (b.f49z * a.f49z)) + (b.f46w * a.f46w);
    }

    public void addMultiple(Float4 a, float factor) {
        this.f47x += a.f47x * factor;
        this.f48y += a.f48y * factor;
        this.f49z += a.f49z * factor;
        this.f46w += a.f46w * factor;
    }

    public void set(Float4 a) {
        this.f47x = a.f47x;
        this.f48y = a.f48y;
        this.f49z = a.f49z;
        this.f46w = a.f46w;
    }

    public void negate() {
        this.f47x = -this.f47x;
        this.f48y = -this.f48y;
        this.f49z = -this.f49z;
        this.f46w = -this.f46w;
    }

    public int length() {
        return 4;
    }

    public float elementSum() {
        return ((this.f47x + this.f48y) + this.f49z) + this.f46w;
    }

    public float get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f47x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f48y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f49z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f46w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f47x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f48y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f49z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f46w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, float value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f47x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f48y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f49z += value;
            case SetDrawableParameters.TAG /*3*/:
                this.f46w += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setValues(float x, float y, float z, float w) {
        this.f47x = x;
        this.f48y = y;
        this.f49z = z;
        this.f46w = w;
    }

    public void copyTo(float[] data, int offset) {
        data[offset] = this.f47x;
        data[offset + 1] = this.f48y;
        data[offset + 2] = this.f49z;
        data[offset + 3] = this.f46w;
    }
}
