package com.android.server;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Binder;
import android.os.IBinder;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.service.persistentdata.IPersistentDataBlockService.Stub;
import android.util.Slog;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import libcore.io.IoUtils;

public class PersistentDataBlockService extends SystemService {
    public static final int DIGEST_SIZE_BYTES = 32;
    private static final int HEADER_SIZE = 8;
    private static final int MAX_DATA_BLOCK_SIZE = 102400;
    private static final int PARTITION_TYPE_MARKER = 428873843;
    private static final String PERSISTENT_DATA_BLOCK_PROP = "ro.frp.pst";
    private static final String TAG;
    private int mAllowedUid;
    private long mBlockDeviceSize;
    private final Context mContext;
    private final String mDataBlockFile;
    private final Object mLock;
    private final IBinder mService;

    /* renamed from: com.android.server.PersistentDataBlockService.1 */
    class C00771 extends Stub {
        public byte[] read() {
            /* JADX: method processing error */
/*
            Error: jadx.core.utils.exceptions.JadxRuntimeException: Can't find immediate dominator for block B:48:0x00a9 in {26, 29, 43, 44, 45, 47, 49, 50, 51, 52, 53, 54, 55, 56, 58} preds:[]
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeDominators(BlockProcessor.java:129)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:48)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:14)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
            /*
            r10 = this;
            r5 = 0;
            r8 = 0;
            r6 = com.android.server.PersistentDataBlockService.this;
            r7 = android.os.Binder.getCallingUid();
            r6.enforceUid(r7);
            r6 = com.android.server.PersistentDataBlockService.this;
            r6 = r6.enforceChecksumValidity();
            if (r6 != 0) goto L_0x0016;
        L_0x0013:
            r0 = new byte[r8];
        L_0x0015:
            return r0;
        L_0x0016:
            r2 = new java.io.DataInputStream;	 Catch:{ FileNotFoundException -> 0x004d }
            r6 = new java.io.FileInputStream;	 Catch:{ FileNotFoundException -> 0x004d }
            r7 = new java.io.File;	 Catch:{ FileNotFoundException -> 0x004d }
            r8 = com.android.server.PersistentDataBlockService.this;	 Catch:{ FileNotFoundException -> 0x004d }
            r8 = r8.mDataBlockFile;	 Catch:{ FileNotFoundException -> 0x004d }
            r7.<init>(r8);	 Catch:{ FileNotFoundException -> 0x004d }
            r6.<init>(r7);	 Catch:{ FileNotFoundException -> 0x004d }
            r2.<init>(r6);	 Catch:{ FileNotFoundException -> 0x004d }
            r6 = com.android.server.PersistentDataBlockService.this;	 Catch:{ IOException -> 0x00ac }
            r7 = r6.mLock;	 Catch:{ IOException -> 0x00ac }
            monitor-enter(r7);	 Catch:{ IOException -> 0x00ac }
            r6 = com.android.server.PersistentDataBlockService.this;	 Catch:{ IOException -> 0x00ac }
            r4 = r6.getTotalDataSizeLocked(r2);	 Catch:{ IOException -> 0x00ac }
            if (r4 != 0) goto L_0x0059;	 Catch:{ IOException -> 0x00ac }
        L_0x003a:
            r6 = 0;	 Catch:{ IOException -> 0x00ac }
            r0 = new byte[r6];	 Catch:{ IOException -> 0x00ac }
            monitor-exit(r7);	 Catch:{ IOException -> 0x00ac }
            r2.close();	 Catch:{ IOException -> 0x0042 }
            goto L_0x0015;
        L_0x0042:
            r1 = move-exception;
            r5 = com.android.server.PersistentDataBlockService.TAG;
            r6 = "failed to close OutputStream";
            android.util.Slog.e(r5, r6);
            goto L_0x0015;
        L_0x004d:
            r1 = move-exception;
            r6 = com.android.server.PersistentDataBlockService.TAG;
            r7 = "partition not available?";
            android.util.Slog.e(r6, r7, r1);
            r0 = r5;
            goto L_0x0015;
        L_0x0059:
            r0 = new byte[r4];	 Catch:{ IOException -> 0x00ac }
            r6 = 0;	 Catch:{ IOException -> 0x00ac }
            r3 = r2.read(r0, r6, r4);	 Catch:{ IOException -> 0x00ac }
            if (r3 >= r4) goto L_0x0097;	 Catch:{ IOException -> 0x00ac }
        L_0x0062:
            r6 = com.android.server.PersistentDataBlockService.TAG;	 Catch:{ IOException -> 0x00ac }
            r8 = new java.lang.StringBuilder;	 Catch:{ IOException -> 0x00ac }
            r8.<init>();	 Catch:{ IOException -> 0x00ac }
            r9 = "failed to read entire data block. bytes read: ";	 Catch:{ IOException -> 0x00ac }
            r8 = r8.append(r9);	 Catch:{ IOException -> 0x00ac }
            r8 = r8.append(r3);	 Catch:{ IOException -> 0x00ac }
            r9 = "/";	 Catch:{ IOException -> 0x00ac }
            r8 = r8.append(r9);	 Catch:{ IOException -> 0x00ac }
            r8 = r8.append(r4);	 Catch:{ IOException -> 0x00ac }
            r8 = r8.toString();	 Catch:{ IOException -> 0x00ac }
            android.util.Slog.e(r6, r8);	 Catch:{ IOException -> 0x00ac }
            monitor-exit(r7);	 Catch:{ IOException -> 0x00ac }
            r2.close();	 Catch:{ IOException -> 0x008c }
        L_0x008a:
            r0 = r5;
            goto L_0x0015;
        L_0x008c:
            r1 = move-exception;
            r6 = com.android.server.PersistentDataBlockService.TAG;
            r7 = "failed to close OutputStream";
            android.util.Slog.e(r6, r7);
            goto L_0x008a;
        L_0x0097:
            monitor-exit(r7);	 Catch:{ IOException -> 0x00ac }
            r2.close();	 Catch:{ IOException -> 0x009d }
            goto L_0x0015;
        L_0x009d:
            r1 = move-exception;
            r5 = com.android.server.PersistentDataBlockService.TAG;
            r6 = "failed to close OutputStream";
            android.util.Slog.e(r5, r6);
            goto L_0x0015;
        L_0x00a9:
            r6 = move-exception;
            monitor-exit(r7);	 Catch:{ IOException -> 0x00ac }
            throw r6;	 Catch:{ IOException -> 0x00ac }
        L_0x00ac:
            r1 = move-exception;
            r6 = com.android.server.PersistentDataBlockService.TAG;	 Catch:{ all -> 0x00c7 }
            r7 = "failed to read data";	 Catch:{ all -> 0x00c7 }
            android.util.Slog.e(r6, r7, r1);	 Catch:{ all -> 0x00c7 }
            r2.close();
        L_0x00b9:
            r0 = r5;
            goto L_0x0015;
        L_0x00bc:
            r1 = move-exception;
            r6 = com.android.server.PersistentDataBlockService.TAG;
            r7 = "failed to close OutputStream";
            android.util.Slog.e(r6, r7);
            goto L_0x00b9;
        L_0x00c7:
            r5 = move-exception;
            r2.close();	 Catch:{ IOException -> 0x00cc }
        L_0x00cb:
            throw r5;
        L_0x00cc:
            r1 = move-exception;
            r6 = com.android.server.PersistentDataBlockService.TAG;
            r7 = "failed to close OutputStream";
            android.util.Slog.e(r6, r7);
            goto L_0x00cb;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.PersistentDataBlockService.1.read():byte[]");
        }

        C00771() {
        }

        public int write(byte[] data) throws RemoteException {
            PersistentDataBlockService.this.enforceUid(Binder.getCallingUid());
            long maxBlockSize = (PersistentDataBlockService.this.getBlockDeviceSize() - 8) - 1;
            if (((long) data.length) > maxBlockSize) {
                return (int) (-maxBlockSize);
            }
            try {
                DataOutputStream outputStream = new DataOutputStream(new FileOutputStream(new File(PersistentDataBlockService.this.mDataBlockFile)));
                ByteBuffer headerAndData = ByteBuffer.allocate(data.length + PersistentDataBlockService.HEADER_SIZE);
                headerAndData.putInt(PersistentDataBlockService.PARTITION_TYPE_MARKER);
                headerAndData.putInt(data.length);
                headerAndData.put(data);
                synchronized (PersistentDataBlockService.this.mLock) {
                    try {
                        outputStream.write(new byte[PersistentDataBlockService.DIGEST_SIZE_BYTES], 0, PersistentDataBlockService.DIGEST_SIZE_BYTES);
                        outputStream.write(headerAndData.array());
                        outputStream.flush();
                        if (PersistentDataBlockService.this.computeAndWriteDigestLocked()) {
                            int length = data.length;
                            return length;
                        }
                        return -1;
                    } catch (IOException e) {
                        Slog.e(PersistentDataBlockService.TAG, "failed writing to the persistent data block", e);
                        return -1;
                    } finally {
                        IoUtils.closeQuietly(outputStream);
                    }
                }
            } catch (FileNotFoundException e2) {
                Slog.e(PersistentDataBlockService.TAG, "partition not available?", e2);
                return -1;
            }
        }

        public void wipe() {
            PersistentDataBlockService.this.enforceOemUnlockPermission();
            synchronized (PersistentDataBlockService.this.mLock) {
                if (PersistentDataBlockService.this.nativeWipe(PersistentDataBlockService.this.mDataBlockFile) < 0) {
                    Slog.e(PersistentDataBlockService.TAG, "failed to wipe persistent partition");
                }
            }
        }

        public void setOemUnlockEnabled(boolean enabled) {
            if (!ActivityManager.isUserAMonkey()) {
                PersistentDataBlockService.this.enforceOemUnlockPermission();
                PersistentDataBlockService.this.enforceIsOwner();
                synchronized (PersistentDataBlockService.this.mLock) {
                    PersistentDataBlockService.this.doSetOemUnlockEnabledLocked(enabled);
                    PersistentDataBlockService.this.computeAndWriteDigestLocked();
                }
            }
        }

        public boolean getOemUnlockEnabled() {
            PersistentDataBlockService.this.enforceOemUnlockPermission();
            return PersistentDataBlockService.this.doGetOemUnlockEnabled();
        }

        public int getDataBlockSize() {
            if (PersistentDataBlockService.this.mContext.checkCallingPermission("android.permission.ACCESS_PDB_STATE") != 0) {
                PersistentDataBlockService.this.enforceUid(Binder.getCallingUid());
            }
            try {
                DataInputStream inputStream = new DataInputStream(new FileInputStream(new File(PersistentDataBlockService.this.mDataBlockFile)));
                try {
                    int access$700;
                    synchronized (PersistentDataBlockService.this.mLock) {
                        access$700 = PersistentDataBlockService.this.getTotalDataSizeLocked(inputStream);
                    }
                    IoUtils.closeQuietly(inputStream);
                    return access$700;
                } catch (IOException e) {
                    try {
                        Slog.e(PersistentDataBlockService.TAG, "error reading data block size");
                        return 0;
                    } finally {
                        IoUtils.closeQuietly(inputStream);
                    }
                }
            } catch (FileNotFoundException e2) {
                Slog.e(PersistentDataBlockService.TAG, "partition not available");
                return 0;
            }
        }

        public long getMaximumDataBlockSize() {
            long actualSize = (PersistentDataBlockService.this.getBlockDeviceSize() - 8) - 1;
            return actualSize <= 102400 ? actualSize : 102400;
        }
    }

    private native long nativeGetBlockDeviceSize(String str);

    private native int nativeWipe(String str);

    static {
        TAG = PersistentDataBlockService.class.getSimpleName();
    }

    public PersistentDataBlockService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mAllowedUid = -1;
        this.mService = new C00771();
        this.mContext = context;
        this.mDataBlockFile = SystemProperties.get(PERSISTENT_DATA_BLOCK_PROP);
        this.mBlockDeviceSize = -1;
        this.mAllowedUid = getAllowedUid(0);
    }

    private int getAllowedUid(int userHandle) {
        String allowedPackage = this.mContext.getResources().getString(17039433);
        int allowedUid = -1;
        try {
            allowedUid = this.mContext.getPackageManager().getPackageUid(allowedPackage, userHandle);
        } catch (NameNotFoundException e) {
            Slog.e(TAG, "not able to find package " + allowedPackage, e);
        }
        return allowedUid;
    }

    public void onStart() {
        enforceChecksumValidity();
        formatIfOemUnlockEnabled();
        publishBinderService("persistent_data_block", this.mService);
    }

    private void formatIfOemUnlockEnabled() {
        if (doGetOemUnlockEnabled()) {
            synchronized (this.mLock) {
                formatPartitionLocked(true);
            }
        }
    }

    private void enforceOemUnlockPermission() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.OEM_UNLOCK_STATE", "Can't access OEM unlock state");
    }

    private void enforceUid(int callingUid) {
        if (callingUid != this.mAllowedUid) {
            throw new SecurityException("uid " + callingUid + " not allowed to access PST");
        }
    }

    private void enforceIsOwner() {
        if (!Binder.getCallingUserHandle().isOwner()) {
            throw new SecurityException("Only the Owner is allowed to change OEM unlock state");
        }
    }

    private int getTotalDataSizeLocked(DataInputStream inputStream) throws IOException {
        inputStream.skipBytes(DIGEST_SIZE_BYTES);
        if (inputStream.readInt() == PARTITION_TYPE_MARKER) {
            return inputStream.readInt();
        }
        return 0;
    }

    private long getBlockDeviceSize() {
        synchronized (this.mLock) {
            if (this.mBlockDeviceSize == -1) {
                this.mBlockDeviceSize = nativeGetBlockDeviceSize(this.mDataBlockFile);
            }
        }
        return this.mBlockDeviceSize;
    }

    private boolean enforceChecksumValidity() {
        byte[] storedDigest = new byte[DIGEST_SIZE_BYTES];
        synchronized (this.mLock) {
            byte[] digest = computeDigestLocked(storedDigest);
            if (digest == null || !Arrays.equals(storedDigest, digest)) {
                Slog.i(TAG, "Formatting FRP partition...");
                formatPartitionLocked(false);
                return false;
            }
            return true;
        }
    }

    private boolean computeAndWriteDigestLocked() {
        byte[] digest = computeDigestLocked(null);
        if (digest == null) {
            return false;
        }
        try {
            DataOutputStream outputStream = new DataOutputStream(new FileOutputStream(new File(this.mDataBlockFile)));
            try {
                outputStream.write(digest, 0, DIGEST_SIZE_BYTES);
                outputStream.flush();
                return true;
            } catch (IOException e) {
                Slog.e(TAG, "failed to write block checksum", e);
                return false;
            } finally {
                IoUtils.closeQuietly(outputStream);
            }
        } catch (FileNotFoundException e2) {
            Slog.e(TAG, "partition not available?", e2);
            return false;
        }
    }

    private byte[] computeDigestLocked(byte[] storedDigest) {
        try {
            DataInputStream inputStream = new DataInputStream(new FileInputStream(new File(this.mDataBlockFile)));
            try {
                byte[] data;
                int read;
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                if (storedDigest != null) {
                    try {
                        if (storedDigest.length == DIGEST_SIZE_BYTES) {
                            inputStream.read(storedDigest);
                            data = new byte[DumpState.DUMP_PREFERRED_XML];
                            md.update(data, 0, DIGEST_SIZE_BYTES);
                            while (true) {
                                read = inputStream.read(data);
                                if (read == -1) {
                                    md.update(data, 0, read);
                                } else {
                                    IoUtils.closeQuietly(inputStream);
                                    return md.digest();
                                }
                            }
                        }
                    } catch (IOException e) {
                        Slog.e(TAG, "failed to read partition", e);
                        return null;
                    } finally {
                        IoUtils.closeQuietly(inputStream);
                    }
                }
                inputStream.skipBytes(DIGEST_SIZE_BYTES);
                data = new byte[DumpState.DUMP_PREFERRED_XML];
                md.update(data, 0, DIGEST_SIZE_BYTES);
                while (true) {
                    read = inputStream.read(data);
                    if (read == -1) {
                        IoUtils.closeQuietly(inputStream);
                        return md.digest();
                    }
                    md.update(data, 0, read);
                }
            } catch (NoSuchAlgorithmException e2) {
                Slog.e(TAG, "SHA-256 not supported?", e2);
                IoUtils.closeQuietly(inputStream);
                return null;
            }
        } catch (FileNotFoundException e3) {
            Slog.e(TAG, "partition not available?", e3);
            return null;
        }
    }

    private void formatPartitionLocked(boolean setOemUnlockEnabled) {
        try {
            DataOutputStream outputStream = new DataOutputStream(new FileOutputStream(new File(this.mDataBlockFile)));
            try {
                outputStream.write(new byte[DIGEST_SIZE_BYTES], 0, DIGEST_SIZE_BYTES);
                outputStream.writeInt(PARTITION_TYPE_MARKER);
                outputStream.writeInt(0);
                outputStream.flush();
                doSetOemUnlockEnabledLocked(setOemUnlockEnabled);
                computeAndWriteDigestLocked();
            } catch (IOException e) {
                Slog.e(TAG, "failed to format block", e);
            } finally {
                IoUtils.closeQuietly(outputStream);
            }
        } catch (FileNotFoundException e2) {
            Slog.e(TAG, "partition not available?", e2);
        }
    }

    private void doSetOemUnlockEnabledLocked(boolean enabled) {
        byte b = (byte) 1;
        try {
            FileOutputStream outputStream = new FileOutputStream(new File(this.mDataBlockFile));
            try {
                FileChannel channel = outputStream.getChannel();
                channel.position(getBlockDeviceSize() - 1);
                ByteBuffer data = ByteBuffer.allocate(1);
                if (!enabled) {
                    b = (byte) 0;
                }
                data.put(b);
                data.flip();
                channel.write(data);
                outputStream.flush();
            } catch (IOException e) {
                Slog.e(TAG, "unable to access persistent partition", e);
            } finally {
                IoUtils.closeQuietly(outputStream);
            }
        } catch (FileNotFoundException e2) {
            Slog.e(TAG, "partition not available", e2);
        }
    }

    private boolean doGetOemUnlockEnabled() {
        try {
            DataInputStream inputStream = new DataInputStream(new FileInputStream(new File(this.mDataBlockFile)));
            try {
                boolean z;
                synchronized (this.mLock) {
                    inputStream.skip(getBlockDeviceSize() - 1);
                    if (inputStream.readByte() != null) {
                        z = true;
                    } else {
                        z = false;
                    }
                }
                IoUtils.closeQuietly(inputStream);
                return z;
            } catch (IOException e) {
                try {
                    Slog.e(TAG, "unable to access persistent partition", e);
                    return false;
                } finally {
                    IoUtils.closeQuietly(inputStream);
                }
            }
        } catch (FileNotFoundException e2) {
            Slog.e(TAG, "partition not available");
            return false;
        }
    }
}
