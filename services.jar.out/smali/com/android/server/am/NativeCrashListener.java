package com.android.server.am;

import android.app.ApplicationErrorReport.CrashInfo;
import android.system.ErrnoException;
import android.system.Os;
import android.system.OsConstants;
import android.system.StructTimeval;
import android.util.Slog;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.InterruptedIOException;
import java.net.InetSocketAddress;
import java.net.InetUnixAddress;

final class NativeCrashListener extends Thread {
    static final boolean DEBUG = false;
    static final String DEBUGGERD_SOCKET_PATH = "/data/system/ndebugsocket";
    static final boolean MORE_DEBUG = false;
    static final long SOCKET_TIMEOUT_MILLIS = 2000;
    static final String TAG = "NativeCrashListener";
    final ActivityManagerService mAm;

    class NativeCrashReporter extends Thread {
        ProcessRecord mApp;
        String mCrashReport;
        int mSignal;

        NativeCrashReporter(ProcessRecord app, int signal, String report) {
            super("NativeCrashReport");
            this.mApp = app;
            this.mSignal = signal;
            this.mCrashReport = report;
        }

        public void run() {
            try {
                CrashInfo ci = new CrashInfo();
                ci.exceptionClassName = "Native crash";
                ci.exceptionMessage = Os.strsignal(this.mSignal);
                ci.throwFileName = "unknown";
                ci.throwClassName = "unknown";
                ci.throwMethodName = "unknown";
                ci.stackTrace = this.mCrashReport;
                NativeCrashListener.this.mAm.handleApplicationCrashInner("native_crash", this.mApp, this.mApp.processName, ci);
            } catch (Exception e) {
                Slog.e(NativeCrashListener.TAG, "Unable to report native crash", e);
            }
        }
    }

    NativeCrashListener(ActivityManagerService am) {
        this.mAm = am;
    }

    public void run() {
        byte[] ackSignal = new byte[1];
        File socketFile = new File(DEBUGGERD_SOCKET_PATH);
        if (socketFile.exists()) {
            socketFile.delete();
        }
        try {
            FileDescriptor serverFd = Os.socket(OsConstants.AF_UNIX, OsConstants.SOCK_STREAM, 0);
            Os.bind(serverFd, new InetUnixAddress(DEBUGGERD_SOCKET_PATH), 0);
            Os.listen(serverFd, 1);
            while (true) {
                try {
                    FileDescriptor peerFd = Os.accept(serverFd, new InetSocketAddress());
                    if (peerFd != null && Os.getsockoptUcred(peerFd, OsConstants.SOL_SOCKET, OsConstants.SO_PEERCRED).uid == 0) {
                        consumeNativeCrashData(peerFd);
                    }
                    if (peerFd != null) {
                        try {
                            Os.write(peerFd, ackSignal, 0, 1);
                        } catch (Exception e) {
                        }
                        try {
                            Os.close(peerFd);
                        } catch (ErrnoException e2) {
                        }
                    }
                } catch (Exception e3) {
                    Slog.w(TAG, "Error handling connection", e3);
                    if (null != null) {
                        try {
                            Os.write(null, ackSignal, 0, 1);
                        } catch (Exception e4) {
                        }
                        try {
                            Os.close(null);
                        } catch (ErrnoException e5) {
                        }
                    }
                } catch (Throwable th) {
                    if (null != null) {
                        try {
                            Os.write(null, ackSignal, 0, 1);
                        } catch (Exception e6) {
                        }
                        try {
                            Os.close(null);
                        } catch (ErrnoException e7) {
                        }
                    }
                }
            }
        } catch (Exception e32) {
            Slog.e(TAG, "Unable to init native debug socket!", e32);
        }
    }

    static int unpackInt(byte[] buf, int offset) {
        return ((((buf[offset] & 255) << 24) | ((buf[offset + 1] & 255) << 16)) | ((buf[offset + 2] & 255) << 8)) | (buf[offset + 3] & 255);
    }

    static int readExactly(FileDescriptor fd, byte[] buffer, int offset, int numBytes) throws ErrnoException, InterruptedIOException {
        int totalRead = 0;
        while (numBytes > 0) {
            int n = Os.read(fd, buffer, offset + totalRead, numBytes);
            if (n <= 0) {
                return -1;
            }
            numBytes -= n;
            totalRead += n;
        }
        return totalRead;
    }

    void consumeNativeCrashData(FileDescriptor fd) {
        byte[] buf = new byte[DumpState.DUMP_VERSION];
        ByteArrayOutputStream os = new ByteArrayOutputStream(DumpState.DUMP_VERSION);
        try {
            StructTimeval timeout = StructTimeval.fromMillis(SOCKET_TIMEOUT_MILLIS);
            Os.setsockoptTimeval(fd, OsConstants.SOL_SOCKET, OsConstants.SO_RCVTIMEO, timeout);
            Os.setsockoptTimeval(fd, OsConstants.SOL_SOCKET, OsConstants.SO_SNDTIMEO, timeout);
            if (readExactly(fd, buf, 0, 8) != 8) {
                Slog.e(TAG, "Unable to read from debuggerd");
                return;
            }
            int pid = unpackInt(buf, 0);
            int signal = unpackInt(buf, 4);
            if (pid > 0) {
                ProcessRecord pr;
                synchronized (this.mAm.mPidsSelfLocked) {
                    pr = (ProcessRecord) this.mAm.mPidsSelfLocked.get(pid);
                }
                if (pr == null) {
                    Slog.w(TAG, "Couldn't find ProcessRecord for pid " + pid);
                    return;
                } else if (!pr.persistent) {
                    int bytes;
                    do {
                        bytes = Os.read(fd, buf, 0, buf.length);
                        if (bytes > 0) {
                            if (buf[bytes - 1] == null) {
                                os.write(buf, 0, bytes - 1);
                                break;
                            } else {
                                os.write(buf, 0, bytes);
                                continue;
                            }
                        }
                    } while (bytes > 0);
                    synchronized (this.mAm) {
                        pr.crashing = true;
                        pr.forceCrashReport = true;
                    }
                    new NativeCrashReporter(pr, signal, new String(os.toByteArray(), "UTF-8")).start();
                    return;
                } else {
                    return;
                }
            }
            Slog.e(TAG, "Bogus pid!");
        } catch (Exception e) {
            Slog.e(TAG, "Exception dealing with report", e);
        }
    }
}
