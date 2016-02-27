package android.renderscript;

import android.widget.Toast;

public class Long4 {
    public long f64w;
    public long f65x;
    public long f66y;
    public long f67z;

    public Long4(long i) {
        this.f64w = i;
        this.f67z = i;
        this.f66y = i;
        this.f65x = i;
    }

    public Long4(long x, long y, long z, long w) {
        this.f65x = x;
        this.f66y = y;
        this.f67z = z;
        this.f64w = w;
    }

    public Long4(Long4 source) {
        this.f65x = source.f65x;
        this.f66y = source.f66y;
        this.f67z = source.f67z;
        this.f64w = source.f64w;
    }

    public void add(Long4 a) {
        this.f65x += a.f65x;
        this.f66y += a.f66y;
        this.f67z += a.f67z;
        this.f64w += a.f64w;
    }

    public static Long4 add(Long4 a, Long4 b) {
        Long4 result = new Long4();
        result.f65x = a.f65x + b.f65x;
        result.f66y = a.f66y + b.f66y;
        result.f67z = a.f67z + b.f67z;
        result.f64w = a.f64w + b.f64w;
        return result;
    }

    public void add(long value) {
        this.f65x += value;
        this.f66y += value;
        this.f67z += value;
        this.f64w += value;
    }

    public static Long4 add(Long4 a, long b) {
        Long4 result = new Long4();
        result.f65x = a.f65x + b;
        result.f66y = a.f66y + b;
        result.f67z = a.f67z + b;
        result.f64w = a.f64w + b;
        return result;
    }

    public void sub(Long4 a) {
        this.f65x -= a.f65x;
        this.f66y -= a.f66y;
        this.f67z -= a.f67z;
        this.f64w -= a.f64w;
    }

    public static Long4 sub(Long4 a, Long4 b) {
        Long4 result = new Long4();
        result.f65x = a.f65x - b.f65x;
        result.f66y = a.f66y - b.f66y;
        result.f67z = a.f67z - b.f67z;
        result.f64w = a.f64w - b.f64w;
        return result;
    }

    public void sub(long value) {
        this.f65x -= value;
        this.f66y -= value;
        this.f67z -= value;
        this.f64w -= value;
    }

    public static Long4 sub(Long4 a, long b) {
        Long4 result = new Long4();
        result.f65x = a.f65x - b;
        result.f66y = a.f66y - b;
        result.f67z = a.f67z - b;
        result.f64w = a.f64w - b;
        return result;
    }

    public void mul(Long4 a) {
        this.f65x *= a.f65x;
        this.f66y *= a.f66y;
        this.f67z *= a.f67z;
        this.f64w *= a.f64w;
    }

    public static Long4 mul(Long4 a, Long4 b) {
        Long4 result = new Long4();
        result.f65x = a.f65x * b.f65x;
        result.f66y = a.f66y * b.f66y;
        result.f67z = a.f67z * b.f67z;
        result.f64w = a.f64w * b.f64w;
        return result;
    }

    public void mul(long value) {
        this.f65x *= value;
        this.f66y *= value;
        this.f67z *= value;
        this.f64w *= value;
    }

    public static Long4 mul(Long4 a, long b) {
        Long4 result = new Long4();
        result.f65x = a.f65x * b;
        result.f66y = a.f66y * b;
        result.f67z = a.f67z * b;
        result.f64w = a.f64w * b;
        return result;
    }

    public void div(Long4 a) {
        this.f65x /= a.f65x;
        this.f66y /= a.f66y;
        this.f67z /= a.f67z;
        this.f64w /= a.f64w;
    }

    public static Long4 div(Long4 a, Long4 b) {
        Long4 result = new Long4();
        result.f65x = a.f65x / b.f65x;
        result.f66y = a.f66y / b.f66y;
        result.f67z = a.f67z / b.f67z;
        result.f64w = a.f64w / b.f64w;
        return result;
    }

    public void div(long value) {
        this.f65x /= value;
        this.f66y /= value;
        this.f67z /= value;
        this.f64w /= value;
    }

    public static Long4 div(Long4 a, long b) {
        Long4 result = new Long4();
        result.f65x = a.f65x / b;
        result.f66y = a.f66y / b;
        result.f67z = a.f67z / b;
        result.f64w = a.f64w / b;
        return result;
    }

    public void mod(Long4 a) {
        this.f65x %= a.f65x;
        this.f66y %= a.f66y;
        this.f67z %= a.f67z;
        this.f64w %= a.f64w;
    }

    public static Long4 mod(Long4 a, Long4 b) {
        Long4 result = new Long4();
        result.f65x = a.f65x % b.f65x;
        result.f66y = a.f66y % b.f66y;
        result.f67z = a.f67z % b.f67z;
        result.f64w = a.f64w % b.f64w;
        return result;
    }

    public void mod(long value) {
        this.f65x %= value;
        this.f66y %= value;
        this.f67z %= value;
        this.f64w %= value;
    }

    public static Long4 mod(Long4 a, long b) {
        Long4 result = new Long4();
        result.f65x = a.f65x % b;
        result.f66y = a.f66y % b;
        result.f67z = a.f67z % b;
        result.f64w = a.f64w % b;
        return result;
    }

    public long length() {
        return 4;
    }

    public void negate() {
        this.f65x = -this.f65x;
        this.f66y = -this.f66y;
        this.f67z = -this.f67z;
        this.f64w = -this.f64w;
    }

    public long dotProduct(Long4 a) {
        return (((this.f65x * a.f65x) + (this.f66y * a.f66y)) + (this.f67z * a.f67z)) + (this.f64w * a.f64w);
    }

    public static long dotProduct(Long4 a, Long4 b) {
        return (((b.f65x * a.f65x) + (b.f66y * a.f66y)) + (b.f67z * a.f67z)) + (b.f64w * a.f64w);
    }

    public void addMultiple(Long4 a, long factor) {
        this.f65x += a.f65x * factor;
        this.f66y += a.f66y * factor;
        this.f67z += a.f67z * factor;
        this.f64w += a.f64w * factor;
    }

    public void set(Long4 a) {
        this.f65x = a.f65x;
        this.f66y = a.f66y;
        this.f67z = a.f67z;
        this.f64w = a.f64w;
    }

    public void setValues(long a, long b, long c, long d) {
        this.f65x = a;
        this.f66y = b;
        this.f67z = c;
        this.f64w = d;
    }

    public long elementSum() {
        return ((this.f65x + this.f66y) + this.f67z) + this.f64w;
    }

    public long get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f65x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f66y;
            case Action.MERGE_IGNORE /*2*/:
                return this.f67z;
            case SetDrawableParameters.TAG /*3*/:
                return this.f64w;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f65x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f66y = value;
            case Action.MERGE_IGNORE /*2*/:
                this.f67z = value;
            case SetDrawableParameters.TAG /*3*/:
                this.f64w = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f65x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f66y += value;
            case Action.MERGE_IGNORE /*2*/:
                this.f67z += value;
            case SetDrawableParameters.TAG /*3*/:
                this.f64w += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(long[] data, int offset) {
        data[offset] = this.f65x;
        data[offset + 1] = this.f66y;
        data[offset + 2] = this.f67z;
        data[offset + 3] = this.f64w;
    }
}
