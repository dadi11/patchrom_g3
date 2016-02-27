package android.renderscript;

import android.widget.Toast;

public class Long2 {
    public long f59x;
    public long f60y;

    public Long2(long i) {
        this.f60y = i;
        this.f59x = i;
    }

    public Long2(long x, long y) {
        this.f59x = x;
        this.f60y = y;
    }

    public Long2(Long2 source) {
        this.f59x = source.f59x;
        this.f60y = source.f60y;
    }

    public void add(Long2 a) {
        this.f59x += a.f59x;
        this.f60y += a.f60y;
    }

    public static Long2 add(Long2 a, Long2 b) {
        Long2 result = new Long2();
        result.f59x = a.f59x + b.f59x;
        result.f60y = a.f60y + b.f60y;
        return result;
    }

    public void add(long value) {
        this.f59x += value;
        this.f60y += value;
    }

    public static Long2 add(Long2 a, long b) {
        Long2 result = new Long2();
        result.f59x = a.f59x + b;
        result.f60y = a.f60y + b;
        return result;
    }

    public void sub(Long2 a) {
        this.f59x -= a.f59x;
        this.f60y -= a.f60y;
    }

    public static Long2 sub(Long2 a, Long2 b) {
        Long2 result = new Long2();
        result.f59x = a.f59x - b.f59x;
        result.f60y = a.f60y - b.f60y;
        return result;
    }

    public void sub(long value) {
        this.f59x -= value;
        this.f60y -= value;
    }

    public static Long2 sub(Long2 a, long b) {
        Long2 result = new Long2();
        result.f59x = a.f59x - b;
        result.f60y = a.f60y - b;
        return result;
    }

    public void mul(Long2 a) {
        this.f59x *= a.f59x;
        this.f60y *= a.f60y;
    }

    public static Long2 mul(Long2 a, Long2 b) {
        Long2 result = new Long2();
        result.f59x = a.f59x * b.f59x;
        result.f60y = a.f60y * b.f60y;
        return result;
    }

    public void mul(long value) {
        this.f59x *= value;
        this.f60y *= value;
    }

    public static Long2 mul(Long2 a, long b) {
        Long2 result = new Long2();
        result.f59x = a.f59x * b;
        result.f60y = a.f60y * b;
        return result;
    }

    public void div(Long2 a) {
        this.f59x /= a.f59x;
        this.f60y /= a.f60y;
    }

    public static Long2 div(Long2 a, Long2 b) {
        Long2 result = new Long2();
        result.f59x = a.f59x / b.f59x;
        result.f60y = a.f60y / b.f60y;
        return result;
    }

    public void div(long value) {
        this.f59x /= value;
        this.f60y /= value;
    }

    public static Long2 div(Long2 a, long b) {
        Long2 result = new Long2();
        result.f59x = a.f59x / b;
        result.f60y = a.f60y / b;
        return result;
    }

    public void mod(Long2 a) {
        this.f59x %= a.f59x;
        this.f60y %= a.f60y;
    }

    public static Long2 mod(Long2 a, Long2 b) {
        Long2 result = new Long2();
        result.f59x = a.f59x % b.f59x;
        result.f60y = a.f60y % b.f60y;
        return result;
    }

    public void mod(long value) {
        this.f59x %= value;
        this.f60y %= value;
    }

    public static Long2 mod(Long2 a, long b) {
        Long2 result = new Long2();
        result.f59x = a.f59x % b;
        result.f60y = a.f60y % b;
        return result;
    }

    public long length() {
        return 2;
    }

    public void negate() {
        this.f59x = -this.f59x;
        this.f60y = -this.f60y;
    }

    public long dotProduct(Long2 a) {
        return (this.f59x * a.f59x) + (this.f60y * a.f60y);
    }

    public static long dotProduct(Long2 a, Long2 b) {
        return (b.f59x * a.f59x) + (b.f60y * a.f60y);
    }

    public void addMultiple(Long2 a, long factor) {
        this.f59x += a.f59x * factor;
        this.f60y += a.f60y * factor;
    }

    public void set(Long2 a) {
        this.f59x = a.f59x;
        this.f60y = a.f60y;
    }

    public void setValues(long a, long b) {
        this.f59x = a;
        this.f60y = b;
    }

    public long elementSum() {
        return this.f59x + this.f60y;
    }

    public long get(int i) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                return this.f59x;
            case Toast.LENGTH_LONG /*1*/:
                return this.f60y;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void setAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f59x = value;
            case Toast.LENGTH_LONG /*1*/:
                this.f60y = value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void addAt(int i, long value) {
        switch (i) {
            case Toast.LENGTH_SHORT /*0*/:
                this.f59x += value;
            case Toast.LENGTH_LONG /*1*/:
                this.f60y += value;
            default:
                throw new IndexOutOfBoundsException("Index: i");
        }
    }

    public void copyTo(long[] data, int offset) {
        data[offset] = this.f59x;
        data[offset + 1] = this.f60y;
    }
}
