package android.os;

import android.system.ErrnoException;
import android.system.Os;
import android.system.OsConstants;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteOrder;
import java.util.Arrays;
import libcore.io.IoBridge;
import libcore.io.IoUtils;
import libcore.io.Memory;
import libcore.io.Streams;

public class FileBridge extends Thread {
    private static final int CMD_CLOSE = 3;
    private static final int CMD_FSYNC = 2;
    private static final int CMD_WRITE = 1;
    private static final int MSG_LENGTH = 8;
    private static final String TAG = "FileBridge";
    private final FileDescriptor mClient;
    private volatile boolean mClosed;
    private final FileDescriptor mServer;
    private FileDescriptor mTarget;

    public static class FileBridgeOutputStream extends OutputStream {
        private final FileDescriptor mClient;
        private final ParcelFileDescriptor mClientPfd;
        private final byte[] mTemp;

        public FileBridgeOutputStream(ParcelFileDescriptor clientPfd) {
            this.mTemp = new byte[FileBridge.MSG_LENGTH];
            this.mClientPfd = clientPfd;
            this.mClient = clientPfd.getFileDescriptor();
        }

        public FileBridgeOutputStream(FileDescriptor client) {
            this.mTemp = new byte[FileBridge.MSG_LENGTH];
            this.mClientPfd = null;
            this.mClient = client;
        }

        public void close() throws IOException {
            try {
                writeCommandAndBlock(FileBridge.CMD_CLOSE, "close()");
            } finally {
                IoBridge.closeAndSignalBlockedThreads(this.mClient);
                IoUtils.closeQuietly(this.mClientPfd);
            }
        }

        public void fsync() throws IOException {
            writeCommandAndBlock(FileBridge.CMD_FSYNC, "fsync()");
        }

        private void writeCommandAndBlock(int cmd, String cmdString) throws IOException {
            Memory.pokeInt(this.mTemp, 0, cmd, ByteOrder.BIG_ENDIAN);
            IoBridge.write(this.mClient, this.mTemp, 0, FileBridge.MSG_LENGTH);
            if (IoBridge.read(this.mClient, this.mTemp, 0, FileBridge.MSG_LENGTH) != FileBridge.MSG_LENGTH || Memory.peekInt(this.mTemp, 0, ByteOrder.BIG_ENDIAN) != cmd) {
                throw new IOException("Failed to execute " + cmdString + " across bridge");
            }
        }

        public void write(byte[] buffer, int byteOffset, int byteCount) throws IOException {
            Arrays.checkOffsetAndCount(buffer.length, byteOffset, byteCount);
            Memory.pokeInt(this.mTemp, 0, FileBridge.CMD_WRITE, ByteOrder.BIG_ENDIAN);
            Memory.pokeInt(this.mTemp, 4, byteCount, ByteOrder.BIG_ENDIAN);
            IoBridge.write(this.mClient, this.mTemp, 0, FileBridge.MSG_LENGTH);
            IoBridge.write(this.mClient, buffer, byteOffset, byteCount);
        }

        public void write(int oneByte) throws IOException {
            Streams.writeSingleByte(this, oneByte);
        }
    }

    public FileBridge() {
        this.mServer = new FileDescriptor();
        this.mClient = new FileDescriptor();
        try {
            Os.socketpair(OsConstants.AF_UNIX, OsConstants.SOCK_STREAM, 0, this.mServer, this.mClient);
        } catch (ErrnoException e) {
            throw new RuntimeException("Failed to create bridge");
        }
    }

    public boolean isClosed() {
        return this.mClosed;
    }

    public void forceClose() {
        IoUtils.closeQuietly(this.mTarget);
        IoUtils.closeQuietly(this.mServer);
        IoUtils.closeQuietly(this.mClient);
        this.mClosed = true;
    }

    public void setTargetFile(FileDescriptor target) {
        this.mTarget = target;
    }

    public FileDescriptor getClientSocket() {
        return this.mClient;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void run() {
        /*
        r10 = this;
        r9 = 1;
        r8 = 8;
        r5 = 8192; // 0x2000 float:1.14794E-41 double:4.0474E-320;
        r4 = new byte[r5];
    L_0x0007:
        r5 = r10.mServer;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = 0;
        r7 = 8;
        r5 = libcore.io.IoBridge.read(r5, r4, r6, r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        if (r5 != r8) goto L_0x0093;
    L_0x0012:
        r5 = 0;
        r6 = java.nio.ByteOrder.BIG_ENDIAN;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r0 = libcore.io.Memory.peekInt(r4, r5, r6);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        if (r0 != r9) goto L_0x0067;
    L_0x001b:
        r5 = 4;
        r6 = java.nio.ByteOrder.BIG_ENDIAN;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r2 = libcore.io.Memory.peekInt(r4, r5, r6);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
    L_0x0022:
        if (r2 <= 0) goto L_0x0007;
    L_0x0024:
        r5 = r10.mServer;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = 0;
        r7 = r4.length;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r7 = java.lang.Math.min(r7, r2);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r3 = libcore.io.IoBridge.read(r5, r4, r6, r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5 = -1;
        if (r3 != r5) goto L_0x005f;
    L_0x0033:
        r5 = new java.io.IOException;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = new java.lang.StringBuilder;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6.<init>();	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r7 = "Unexpected EOF; still expected ";
        r6 = r6.append(r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = r6.append(r2);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r7 = " bytes";
        r6 = r6.append(r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = r6.toString();	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5.<init>(r6);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        throw r5;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
    L_0x0052:
        r5 = move-exception;
        r1 = r5;
    L_0x0054:
        r5 = "FileBridge";
        r6 = "Failed during bridge";
        android.util.Log.wtf(r5, r6, r1);	 Catch:{ all -> 0x0097 }
        r10.forceClose();
    L_0x005e:
        return;
    L_0x005f:
        r5 = r10.mTarget;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = 0;
        libcore.io.IoBridge.write(r5, r4, r6, r3);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r2 = r2 - r3;
        goto L_0x0022;
    L_0x0067:
        r5 = 2;
        if (r0 != r5) goto L_0x007b;
    L_0x006a:
        r5 = r10.mTarget;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        android.system.Os.fsync(r5);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5 = r10.mServer;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = 0;
        r7 = 8;
        libcore.io.IoBridge.write(r5, r4, r6, r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        goto L_0x0007;
    L_0x0078:
        r5 = move-exception;
        r1 = r5;
        goto L_0x0054;
    L_0x007b:
        r5 = 3;
        if (r0 != r5) goto L_0x0007;
    L_0x007e:
        r5 = r10.mTarget;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        android.system.Os.fsync(r5);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5 = r10.mTarget;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        android.system.Os.close(r5);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5 = 1;
        r10.mClosed = r5;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r5 = r10.mServer;	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
        r6 = 0;
        r7 = 8;
        libcore.io.IoBridge.write(r5, r4, r6, r7);	 Catch:{ ErrnoException -> 0x0052, IOException -> 0x0078 }
    L_0x0093:
        r10.forceClose();
        goto L_0x005e;
    L_0x0097:
        r5 = move-exception;
        r10.forceClose();
        throw r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.os.FileBridge.run():void");
    }
}
