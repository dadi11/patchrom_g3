package android.os;

import android.util.Log;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class MemoryFile {
    private static final int PROT_READ = 1;
    private static final int PROT_WRITE = 2;
    private static String TAG;
    private long mAddress;
    private boolean mAllowPurging;
    private FileDescriptor mFD;
    private int mLength;

    private class MemoryInputStream extends InputStream {
        private int mMark;
        private int mOffset;
        private byte[] mSingleByte;

        private MemoryInputStream() {
            this.mMark = 0;
            this.mOffset = 0;
        }

        public int available() throws IOException {
            if (this.mOffset >= MemoryFile.this.mLength) {
                return 0;
            }
            return MemoryFile.this.mLength - this.mOffset;
        }

        public boolean markSupported() {
            return true;
        }

        public void mark(int readlimit) {
            this.mMark = this.mOffset;
        }

        public void reset() throws IOException {
            this.mOffset = this.mMark;
        }

        public int read() throws IOException {
            if (this.mSingleByte == null) {
                this.mSingleByte = new byte[MemoryFile.PROT_READ];
            }
            if (read(this.mSingleByte, 0, MemoryFile.PROT_READ) != MemoryFile.PROT_READ) {
                return -1;
            }
            return this.mSingleByte[0];
        }

        public int read(byte[] buffer, int offset, int count) throws IOException {
            if (offset < 0 || count < 0 || offset + count > buffer.length) {
                throw new IndexOutOfBoundsException();
            }
            count = Math.min(count, available());
            if (count < MemoryFile.PROT_READ) {
                return -1;
            }
            int result = MemoryFile.this.readBytes(buffer, this.mOffset, offset, count);
            if (result <= 0) {
                return result;
            }
            this.mOffset += result;
            return result;
        }

        public long skip(long n) throws IOException {
            if (((long) this.mOffset) + n > ((long) MemoryFile.this.mLength)) {
                n = (long) (MemoryFile.this.mLength - this.mOffset);
            }
            this.mOffset = (int) (((long) this.mOffset) + n);
            return n;
        }
    }

    private class MemoryOutputStream extends OutputStream {
        private int mOffset;
        private byte[] mSingleByte;

        private MemoryOutputStream() {
            this.mOffset = 0;
        }

        public void write(byte[] buffer, int offset, int count) throws IOException {
            MemoryFile.this.writeBytes(buffer, offset, this.mOffset, count);
            this.mOffset += count;
        }

        public void write(int oneByte) throws IOException {
            if (this.mSingleByte == null) {
                this.mSingleByte = new byte[MemoryFile.PROT_READ];
            }
            this.mSingleByte[0] = (byte) oneByte;
            write(this.mSingleByte, 0, MemoryFile.PROT_READ);
        }
    }

    private static native void native_close(FileDescriptor fileDescriptor);

    private static native int native_get_size(FileDescriptor fileDescriptor) throws IOException;

    private static native long native_mmap(FileDescriptor fileDescriptor, int i, int i2) throws IOException;

    private static native void native_munmap(long j, int i) throws IOException;

    private static native FileDescriptor native_open(String str, int i) throws IOException;

    private static native void native_pin(FileDescriptor fileDescriptor, boolean z) throws IOException;

    private static native int native_read(FileDescriptor fileDescriptor, long j, byte[] bArr, int i, int i2, int i3, boolean z) throws IOException;

    private static native void native_write(FileDescriptor fileDescriptor, long j, byte[] bArr, int i, int i2, int i3, boolean z) throws IOException;

    static {
        TAG = "MemoryFile";
    }

    public MemoryFile(String name, int length) throws IOException {
        this.mAllowPurging = false;
        this.mLength = length;
        if (length >= 0) {
            this.mFD = native_open(name, length);
            if (length > 0) {
                this.mAddress = native_mmap(this.mFD, length, 3);
                return;
            } else {
                this.mAddress = 0;
                return;
            }
        }
        throw new IOException("Invalid length: " + length);
    }

    public void close() {
        deactivate();
        if (!isClosed()) {
            native_close(this.mFD);
        }
    }

    void deactivate() {
        if (!isDeactivated()) {
            try {
                native_munmap(this.mAddress, this.mLength);
                this.mAddress = 0;
            } catch (IOException ex) {
                Log.e(TAG, ex.toString());
            }
        }
    }

    private boolean isDeactivated() {
        return this.mAddress == 0;
    }

    private boolean isClosed() {
        return !this.mFD.valid();
    }

    protected void finalize() {
        if (!isClosed()) {
            Log.e(TAG, "MemoryFile.finalize() called while ashmem still open");
            close();
        }
    }

    public int length() {
        return this.mLength;
    }

    public boolean isPurgingAllowed() {
        return this.mAllowPurging;
    }

    public synchronized boolean allowPurging(boolean allowPurging) throws IOException {
        boolean oldValue;
        oldValue = this.mAllowPurging;
        if (oldValue != allowPurging) {
            native_pin(this.mFD, !allowPurging);
            this.mAllowPurging = allowPurging;
        }
        return oldValue;
    }

    public InputStream getInputStream() {
        return new MemoryInputStream();
    }

    public OutputStream getOutputStream() {
        return new MemoryOutputStream();
    }

    public int readBytes(byte[] buffer, int srcOffset, int destOffset, int count) throws IOException {
        if (isDeactivated()) {
            throw new IOException("Can't read from deactivated memory file.");
        } else if (destOffset < 0 || destOffset > buffer.length || count < 0 || count > buffer.length - destOffset || srcOffset < 0 || srcOffset > this.mLength || count > this.mLength - srcOffset) {
            throw new IndexOutOfBoundsException();
        } else {
            return native_read(this.mFD, this.mAddress, buffer, srcOffset, destOffset, count, this.mAllowPurging);
        }
    }

    public void writeBytes(byte[] buffer, int srcOffset, int destOffset, int count) throws IOException {
        if (isDeactivated()) {
            throw new IOException("Can't write to deactivated memory file.");
        } else if (srcOffset < 0 || srcOffset > buffer.length || count < 0 || count > buffer.length - srcOffset || destOffset < 0 || destOffset > this.mLength || count > this.mLength - destOffset) {
            throw new IndexOutOfBoundsException();
        } else {
            native_write(this.mFD, this.mAddress, buffer, srcOffset, destOffset, count, this.mAllowPurging);
        }
    }

    public FileDescriptor getFileDescriptor() throws IOException {
        return this.mFD;
    }

    public static int getSize(FileDescriptor fd) throws IOException {
        return native_get_size(fd);
    }
}
