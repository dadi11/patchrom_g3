package com.android.server.usb;

import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.net.LocalSocket;
import android.os.Environment;
import android.os.FileUtils;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.util.Base64;
import android.util.Slog;
import com.android.server.FgThread;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.MessageDigest;

public class UsbDebuggingManager implements Runnable {
    private static final boolean DEBUG = false;
    private static final String TAG = "UsbDebuggingManager";
    private final String ADBD_SOCKET;
    private final String ADB_DIRECTORY;
    private final String ADB_KEYS_FILE;
    private final int BUFFER_SIZE;
    private boolean mAdbEnabled;
    private final Context mContext;
    private String mFingerprints;
    private final Handler mHandler;
    private OutputStream mOutputStream;
    private LocalSocket mSocket;
    private Thread mThread;

    class UsbDebuggingHandler extends Handler {
        private static final int MESSAGE_ADB_ALLOW = 3;
        private static final int MESSAGE_ADB_CLEAR = 6;
        private static final int MESSAGE_ADB_CONFIRM = 5;
        private static final int MESSAGE_ADB_DENY = 4;
        private static final int MESSAGE_ADB_DISABLED = 2;
        private static final int MESSAGE_ADB_ENABLED = 1;

        public UsbDebuggingHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            String key;
            String fingerprints;
            switch (msg.what) {
                case MESSAGE_ADB_ENABLED /*1*/:
                    if (!UsbDebuggingManager.this.mAdbEnabled) {
                        UsbDebuggingManager.this.mAdbEnabled = true;
                        UsbDebuggingManager.this.mThread = new Thread(UsbDebuggingManager.this, UsbDebuggingManager.TAG);
                        UsbDebuggingManager.this.mThread.start();
                    }
                case MESSAGE_ADB_DISABLED /*2*/:
                    if (UsbDebuggingManager.this.mAdbEnabled) {
                        UsbDebuggingManager.this.mAdbEnabled = UsbDebuggingManager.DEBUG;
                        UsbDebuggingManager.this.closeSocket();
                        try {
                            UsbDebuggingManager.this.mThread.join();
                        } catch (Exception e) {
                        }
                        UsbDebuggingManager.this.mThread = null;
                        UsbDebuggingManager.this.mOutputStream = null;
                        UsbDebuggingManager.this.mSocket = null;
                    }
                case MESSAGE_ADB_ALLOW /*3*/:
                    key = msg.obj;
                    fingerprints = UsbDebuggingManager.this.getFingerprints(key);
                    if (fingerprints.equals(UsbDebuggingManager.this.mFingerprints)) {
                        if (msg.arg1 == MESSAGE_ADB_ENABLED) {
                            UsbDebuggingManager.this.writeKey(key);
                        }
                        UsbDebuggingManager.this.sendResponse("OK");
                        return;
                    }
                    Slog.e(UsbDebuggingManager.TAG, "Fingerprints do not match. Got " + fingerprints + ", expected " + UsbDebuggingManager.this.mFingerprints);
                case MESSAGE_ADB_DENY /*4*/:
                    UsbDebuggingManager.this.sendResponse("NO");
                case MESSAGE_ADB_CONFIRM /*5*/:
                    key = (String) msg.obj;
                    fingerprints = UsbDebuggingManager.this.getFingerprints(key);
                    if ("".equals(fingerprints)) {
                        UsbDebuggingManager.this.sendResponse("NO");
                        return;
                    }
                    UsbDebuggingManager.this.mFingerprints = fingerprints;
                    UsbDebuggingManager.this.startConfirmation(key, UsbDebuggingManager.this.mFingerprints);
                case MESSAGE_ADB_CLEAR /*6*/:
                    UsbDebuggingManager.this.deleteKeyFile();
                default:
            }
        }
    }

    public UsbDebuggingManager(Context context) {
        this.ADBD_SOCKET = "adbd";
        this.ADB_DIRECTORY = "misc/adb";
        this.ADB_KEYS_FILE = "adb_keys";
        this.BUFFER_SIZE = DumpState.DUMP_VERSION;
        this.mAdbEnabled = DEBUG;
        this.mSocket = null;
        this.mOutputStream = null;
        this.mHandler = new UsbDebuggingHandler(FgThread.get().getLooper());
        this.mContext = context;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void listenToSocket() throws java.io.IOException {
        /*
        r11 = this;
        r6 = 4096; // 0x1000 float:5.74E-42 double:2.0237E-320;
        r1 = new byte[r6];	 Catch:{ all -> 0x0071 }
        r0 = new android.net.LocalSocketAddress;	 Catch:{ all -> 0x0071 }
        r6 = "adbd";
        r7 = android.net.LocalSocketAddress.Namespace.RESERVED;	 Catch:{ all -> 0x0071 }
        r0.<init>(r6, r7);	 Catch:{ all -> 0x0071 }
        r3 = 0;
        r6 = new android.net.LocalSocket;	 Catch:{ all -> 0x0071 }
        r6.<init>();	 Catch:{ all -> 0x0071 }
        r11.mSocket = r6;	 Catch:{ all -> 0x0071 }
        r6 = r11.mSocket;	 Catch:{ all -> 0x0071 }
        r6.connect(r0);	 Catch:{ all -> 0x0071 }
        r6 = r11.mSocket;	 Catch:{ all -> 0x0071 }
        r6 = r6.getOutputStream();	 Catch:{ all -> 0x0071 }
        r11.mOutputStream = r6;	 Catch:{ all -> 0x0071 }
        r6 = r11.mSocket;	 Catch:{ all -> 0x0071 }
        r3 = r6.getInputStream();	 Catch:{ all -> 0x0071 }
    L_0x0028:
        r2 = r3.read(r1);	 Catch:{ all -> 0x0071 }
        if (r2 >= 0) goto L_0x0032;
    L_0x002e:
        r11.closeSocket();
        return;
    L_0x0032:
        r6 = 0;
        r6 = r1[r6];	 Catch:{ all -> 0x0071 }
        r7 = 80;
        if (r6 != r7) goto L_0x0076;
    L_0x0039:
        r6 = 1;
        r6 = r1[r6];	 Catch:{ all -> 0x0071 }
        r7 = 75;
        if (r6 != r7) goto L_0x0076;
    L_0x0040:
        r4 = new java.lang.String;	 Catch:{ all -> 0x0071 }
        r6 = 2;
        r6 = java.util.Arrays.copyOfRange(r1, r6, r2);	 Catch:{ all -> 0x0071 }
        r4.<init>(r6);	 Catch:{ all -> 0x0071 }
        r6 = "UsbDebuggingManager";
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0071 }
        r7.<init>();	 Catch:{ all -> 0x0071 }
        r8 = "Received public key: ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0071 }
        r7 = r7.append(r4);	 Catch:{ all -> 0x0071 }
        r7 = r7.toString();	 Catch:{ all -> 0x0071 }
        android.util.Slog.d(r6, r7);	 Catch:{ all -> 0x0071 }
        r6 = r11.mHandler;	 Catch:{ all -> 0x0071 }
        r7 = 5;
        r5 = r6.obtainMessage(r7);	 Catch:{ all -> 0x0071 }
        r5.obj = r4;	 Catch:{ all -> 0x0071 }
        r6 = r11.mHandler;	 Catch:{ all -> 0x0071 }
        r6.sendMessage(r5);	 Catch:{ all -> 0x0071 }
        goto L_0x0028;
    L_0x0071:
        r6 = move-exception;
        r11.closeSocket();
        throw r6;
    L_0x0076:
        r6 = "UsbDebuggingManager";
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0071 }
        r7.<init>();	 Catch:{ all -> 0x0071 }
        r8 = "Wrong message: ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0071 }
        r8 = new java.lang.String;	 Catch:{ all -> 0x0071 }
        r9 = 0;
        r10 = 2;
        r9 = java.util.Arrays.copyOfRange(r1, r9, r10);	 Catch:{ all -> 0x0071 }
        r8.<init>(r9);	 Catch:{ all -> 0x0071 }
        r7 = r7.append(r8);	 Catch:{ all -> 0x0071 }
        r7 = r7.toString();	 Catch:{ all -> 0x0071 }
        android.util.Slog.e(r6, r7);	 Catch:{ all -> 0x0071 }
        goto L_0x002e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.usb.UsbDebuggingManager.listenToSocket():void");
    }

    public void run() {
        while (this.mAdbEnabled) {
            try {
                listenToSocket();
            } catch (Exception e) {
                SystemClock.sleep(1000);
            }
        }
    }

    private void closeSocket() {
        try {
            this.mOutputStream.close();
        } catch (IOException e) {
            Slog.e(TAG, "Failed closing output stream: " + e);
        }
        try {
            this.mSocket.close();
        } catch (IOException ex) {
            Slog.e(TAG, "Failed closing socket: " + ex);
        }
    }

    private void sendResponse(String msg) {
        if (this.mOutputStream != null) {
            try {
                this.mOutputStream.write(msg.getBytes());
            } catch (IOException ex) {
                Slog.e(TAG, "Failed to write response:", ex);
            }
        }
    }

    private String getFingerprints(String key) {
        String hex = "0123456789ABCDEF";
        StringBuilder sb = new StringBuilder();
        if (key == null) {
            return "";
        }
        try {
            try {
                byte[] digest = MessageDigest.getInstance("MD5").digest(Base64.decode(key.split("\\s+")[0].getBytes(), 0));
                for (int i = 0; i < digest.length; i++) {
                    sb.append(hex.charAt((digest[i] >> 4) & 15));
                    sb.append(hex.charAt(digest[i] & 15));
                    if (i < digest.length - 1) {
                        sb.append(":");
                    }
                }
                return sb.toString();
            } catch (IllegalArgumentException e) {
                Slog.e(TAG, "error doing base64 decoding", e);
                return "";
            }
        } catch (Exception ex) {
            Slog.e(TAG, "Error getting digester", ex);
            return "";
        }
    }

    private void startConfirmation(String key, String fingerprints) {
        String nameString = Resources.getSystem().getString(17039429);
        ComponentName componentName = ComponentName.unflattenFromString(nameString);
        if (!startConfirmationActivity(componentName, key, fingerprints) && !startConfirmationService(componentName, key, fingerprints)) {
            Slog.e(TAG, "unable to start customAdbPublicKeyConfirmationComponent " + nameString + " as an Activity or a Service");
        }
    }

    private boolean startConfirmationActivity(ComponentName componentName, String key, String fingerprints) {
        PackageManager packageManager = this.mContext.getPackageManager();
        Intent intent = createConfirmationIntent(componentName, key, fingerprints);
        intent.addFlags(268435456);
        if (packageManager.resolveActivity(intent, 65536) != null) {
            try {
                this.mContext.startActivity(intent);
                return true;
            } catch (ActivityNotFoundException e) {
                Slog.e(TAG, "unable to start adb whitelist activity: " + componentName, e);
            }
        }
        return DEBUG;
    }

    private boolean startConfirmationService(ComponentName componentName, String key, String fingerprints) {
        try {
            if (this.mContext.startService(createConfirmationIntent(componentName, key, fingerprints)) != null) {
                return true;
            }
        } catch (SecurityException e) {
            Slog.e(TAG, "unable to start adb whitelist service: " + componentName, e);
        }
        return DEBUG;
    }

    private Intent createConfirmationIntent(ComponentName componentName, String key, String fingerprints) {
        Intent intent = new Intent();
        intent.setClassName(componentName.getPackageName(), componentName.getClassName());
        intent.putExtra("key", key);
        intent.putExtra("fingerprints", fingerprints);
        return intent;
    }

    private File getUserKeyFile() {
        File adbDir = new File(Environment.getDataDirectory(), "misc/adb");
        if (adbDir.exists()) {
            return new File(adbDir, "adb_keys");
        }
        Slog.e(TAG, "ADB data directory does not exist");
        return null;
    }

    private void writeKey(String key) {
        try {
            File keyFile = getUserKeyFile();
            if (keyFile != null) {
                if (!keyFile.exists()) {
                    keyFile.createNewFile();
                    FileUtils.setPermissions(keyFile.toString(), 416, -1, -1);
                }
                FileOutputStream fo = new FileOutputStream(keyFile, true);
                fo.write(key.getBytes());
                fo.write(10);
                fo.close();
            }
        } catch (IOException ex) {
            Slog.e(TAG, "Error writing key:" + ex);
        }
    }

    private void deleteKeyFile() {
        File keyFile = getUserKeyFile();
        if (keyFile != null) {
            keyFile.delete();
        }
    }

    public void setAdbEnabled(boolean enabled) {
        this.mHandler.sendEmptyMessage(enabled ? 1 : 2);
    }

    public void allowUsbDebugging(boolean alwaysAllow, String publicKey) {
        Message msg = this.mHandler.obtainMessage(3);
        msg.arg1 = alwaysAllow ? 1 : 0;
        msg.obj = publicKey;
        this.mHandler.sendMessage(msg);
    }

    public void denyUsbDebugging() {
        this.mHandler.sendEmptyMessage(4);
    }

    public void clearUsbDebuggingKeys() {
        this.mHandler.sendEmptyMessage(6);
    }

    public void dump(FileDescriptor fd, PrintWriter pw) {
        boolean z = DEBUG;
        pw.println("  USB Debugging State:");
        StringBuilder append = new StringBuilder().append("    Connected to adbd: ");
        if (this.mOutputStream != null) {
            z = true;
        }
        pw.println(append.append(z).toString());
        pw.println("    Last key received: " + this.mFingerprints);
        pw.println("    User keys:");
        try {
            pw.println(FileUtils.readTextFile(new File("/data/misc/adb/adb_keys"), 0, null));
        } catch (IOException e) {
            pw.println("IOException: " + e);
        }
        pw.println("    System keys:");
        try {
            pw.println(FileUtils.readTextFile(new File("/adb_keys"), 0, null));
        } catch (IOException e2) {
            pw.println("IOException: " + e2);
        }
    }
}
