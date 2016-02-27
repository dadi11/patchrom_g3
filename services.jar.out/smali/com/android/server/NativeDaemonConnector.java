package com.android.server;

import android.net.LocalSocket;
import android.net.LocalSocketAddress;
import android.net.LocalSocketAddress.Namespace;
import android.os.Build;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager.WakeLock;
import android.os.SystemClock;
import android.util.LocalLog;
import android.util.Slog;
import com.android.server.Watchdog.Monitor;
import com.google.android.collect.Lists;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

final class NativeDaemonConnector implements Runnable, Callback, Monitor {
    private static final int DEFAULT_TIMEOUT = 60000;
    private static final boolean LOGD = false;
    private static final boolean VDBG = false;
    private static final long WARN_EXECUTE_DELAY_MS = 500;
    private final int BUFFER_SIZE;
    private final String TAG;
    private Handler mCallbackHandler;
    private INativeDaemonConnectorCallbacks mCallbacks;
    private final Object mDaemonLock;
    private LocalLog mLocalLog;
    private final Looper mLooper;
    private OutputStream mOutputStream;
    private final ResponseQueue mResponseQueue;
    private AtomicInteger mSequenceNumber;
    private String mSocket;
    private final WakeLock mWakeLock;

    public static class Command {
        private ArrayList<Object> mArguments;
        private String mCmd;

        public Command(String cmd, Object... args) {
            this.mArguments = Lists.newArrayList();
            this.mCmd = cmd;
            for (Object arg : args) {
                appendArg(arg);
            }
        }

        public Command appendArg(Object arg) {
            this.mArguments.add(arg);
            return this;
        }
    }

    private static class NativeDaemonArgumentException extends NativeDaemonConnectorException {
        public NativeDaemonArgumentException(String command, NativeDaemonEvent event) {
            super(command, event);
        }

        public IllegalArgumentException rethrowAsParcelableException() {
            throw new IllegalArgumentException(getMessage(), this);
        }
    }

    private static class NativeDaemonFailureException extends NativeDaemonConnectorException {
        public NativeDaemonFailureException(String command, NativeDaemonEvent event) {
            super(command, event);
        }
    }

    private static class ResponseQueue {
        private int mMaxCount;
        private final LinkedList<PendingCmd> mPendingCmds;

        private static class PendingCmd {
            public int availableResponseCount;
            public final int cmdNum;
            public final String logCmd;
            public BlockingQueue<NativeDaemonEvent> responses;

            public PendingCmd(int cmdNum, String logCmd) {
                this.responses = new ArrayBlockingQueue(10);
                this.cmdNum = cmdNum;
                this.logCmd = logCmd;
            }
        }

        ResponseQueue(int maxCount) {
            this.mPendingCmds = new LinkedList();
            this.mMaxCount = maxCount;
        }

        public void add(int cmdNum, NativeDaemonEvent response) {
            Throwable th;
            synchronized (this.mPendingCmds) {
                try {
                    PendingCmd pendingCmd;
                    PendingCmd found;
                    PendingCmd pendingCmd2;
                    Iterator i$ = this.mPendingCmds.iterator();
                    while (i$.hasNext()) {
                        pendingCmd = (PendingCmd) i$.next();
                        if (pendingCmd.cmdNum == cmdNum) {
                            found = pendingCmd;
                            break;
                        }
                    }
                    found = null;
                    if (found == null) {
                        while (this.mPendingCmds.size() >= this.mMaxCount) {
                            try {
                                Slog.e("NativeDaemonConnector.ResponseQueue", "more buffered than allowed: " + this.mPendingCmds.size() + " >= " + this.mMaxCount);
                                pendingCmd = (PendingCmd) this.mPendingCmds.remove();
                                Slog.e("NativeDaemonConnector.ResponseQueue", "Removing request: " + pendingCmd.logCmd + " (" + pendingCmd.cmdNum + ")");
                            } catch (Throwable th2) {
                                th = th2;
                                pendingCmd2 = found;
                            }
                        }
                        pendingCmd2 = new PendingCmd(cmdNum, null);
                        this.mPendingCmds.add(pendingCmd2);
                    } else {
                        pendingCmd2 = found;
                    }
                    pendingCmd2.availableResponseCount++;
                    if (pendingCmd2.availableResponseCount == 0) {
                        this.mPendingCmds.remove(pendingCmd2);
                    }
                    try {
                        pendingCmd2.responses.put(response);
                    } catch (InterruptedException e) {
                    }
                } catch (Throwable th3) {
                    th = th3;
                    throw th;
                }
            }
        }

        public NativeDaemonEvent remove(int cmdNum, int timeoutMs, String logCmd) {
            Throwable th;
            synchronized (this.mPendingCmds) {
                try {
                    PendingCmd found;
                    PendingCmd found2;
                    Iterator i$ = this.mPendingCmds.iterator();
                    while (i$.hasNext()) {
                        PendingCmd pendingCmd = (PendingCmd) i$.next();
                        if (pendingCmd.cmdNum == cmdNum) {
                            found = pendingCmd;
                            break;
                        }
                    }
                    found = null;
                    if (found == null) {
                        try {
                            found2 = new PendingCmd(cmdNum, logCmd);
                            this.mPendingCmds.add(found2);
                        } catch (Throwable th2) {
                            th = th2;
                            found2 = found;
                            throw th;
                        }
                    }
                    found2 = found;
                    found2.availableResponseCount--;
                    if (found2.availableResponseCount == 0) {
                        this.mPendingCmds.remove(found2);
                    }
                    NativeDaemonEvent result = null;
                    try {
                        result = (NativeDaemonEvent) found2.responses.poll((long) timeoutMs, TimeUnit.MILLISECONDS);
                    } catch (InterruptedException e) {
                    }
                    if (result == null) {
                        Slog.e("NativeDaemonConnector.ResponseQueue", "Timeout waiting for response");
                    }
                    return result;
                } catch (Throwable th3) {
                    th = th3;
                    throw th;
                }
            }
        }

        public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            pw.println("Pending requests:");
            synchronized (this.mPendingCmds) {
                Iterator i$ = this.mPendingCmds.iterator();
                while (i$.hasNext()) {
                    PendingCmd pendingCmd = (PendingCmd) i$.next();
                    pw.println("  Cmd " + pendingCmd.cmdNum + " - " + pendingCmd.logCmd);
                }
            }
        }
    }

    public static class SensitiveArg {
        private final Object mArg;

        public SensitiveArg(Object arg) {
            this.mArg = arg;
        }

        public String toString() {
            return String.valueOf(this.mArg);
        }
    }

    NativeDaemonConnector(INativeDaemonConnectorCallbacks callbacks, String socket, int responseQueueSize, String logTag, int maxLogSize, WakeLock wl) {
        this(callbacks, socket, responseQueueSize, logTag, maxLogSize, wl, FgThread.get().getLooper());
    }

    NativeDaemonConnector(INativeDaemonConnectorCallbacks callbacks, String socket, int responseQueueSize, String logTag, int maxLogSize, WakeLock wl, Looper looper) {
        this.mDaemonLock = new Object();
        this.BUFFER_SIZE = DumpState.DUMP_VERSION;
        this.mCallbacks = callbacks;
        this.mSocket = socket;
        this.mResponseQueue = new ResponseQueue(responseQueueSize);
        this.mWakeLock = wl;
        if (this.mWakeLock != null) {
            this.mWakeLock.setReferenceCounted(true);
        }
        this.mLooper = looper;
        this.mSequenceNumber = new AtomicInteger(0);
        if (logTag == null) {
            logTag = "NativeDaemonConnector";
        }
        this.TAG = logTag;
        this.mLocalLog = new LocalLog(maxLogSize);
    }

    public void run() {
        this.mCallbackHandler = new Handler(this.mLooper, this);
        while (true) {
            try {
                listenToSocket();
            } catch (Exception e) {
                loge("Error in NativeDaemonConnector: " + e);
                SystemClock.sleep(5000);
            }
        }
    }

    public boolean handleMessage(Message msg) {
        String event = msg.obj;
        try {
            if (!this.mCallbacks.onEvent(msg.what, event, NativeDaemonEvent.unescapeArgs(event))) {
                log(String.format("Unhandled event '%s'", new Object[]{event}));
            }
            if (this.mCallbacks.onCheckHoldWakeLock(msg.what) && this.mWakeLock != null) {
                this.mWakeLock.release();
            }
        } catch (Exception e) {
            loge("Error handling '" + event + "': " + e);
            if (this.mCallbacks.onCheckHoldWakeLock(msg.what) && this.mWakeLock != null) {
                this.mWakeLock.release();
            }
        } catch (Throwable th) {
            if (this.mCallbacks.onCheckHoldWakeLock(msg.what) && this.mWakeLock != null) {
                this.mWakeLock.release();
            }
        }
        return true;
    }

    private LocalSocketAddress determineSocketAddress() {
        if (this.mSocket.startsWith("__test__") && Build.IS_DEBUGGABLE) {
            return new LocalSocketAddress(this.mSocket);
        }
        return new LocalSocketAddress(this.mSocket, Namespace.RESERVED);
    }

    private void listenToSocket() throws IOException {
        IOException ex;
        Throwable th;
        LocalSocket localSocket = null;
        try {
            LocalSocket socket = new LocalSocket();
            try {
                int count;
                socket.connect(determineSocketAddress());
                InputStream inputStream = socket.getInputStream();
                synchronized (this.mDaemonLock) {
                    this.mOutputStream = socket.getOutputStream();
                }
                this.mCallbacks.onDaemonConnected();
                byte[] buffer = new byte[DumpState.DUMP_VERSION];
                int start = 0;
                while (true) {
                    count = inputStream.read(buffer, start, 4096 - start);
                    if (count < 0) {
                        break;
                    }
                    count += start;
                    start = 0;
                    for (int i = 0; i < count; i++) {
                        if (buffer[i] == null) {
                            String rawEvent = new String(buffer, start, i - start, StandardCharsets.UTF_8);
                            boolean releaseWl = VDBG;
                            try {
                                NativeDaemonEvent event = NativeDaemonEvent.parseRawEvent(rawEvent);
                                log("RCV <- {" + event + "}");
                                if (event.isClassUnsolicited()) {
                                    if (this.mCallbacks.onCheckHoldWakeLock(event.getCode()) && this.mWakeLock != null) {
                                        this.mWakeLock.acquire();
                                        releaseWl = true;
                                    }
                                    if (this.mCallbackHandler.sendMessage(this.mCallbackHandler.obtainMessage(event.getCode(), event.getRawEvent()))) {
                                        releaseWl = VDBG;
                                    }
                                } else {
                                    this.mResponseQueue.add(event.getCmdNumber(), event);
                                }
                                if (releaseWl) {
                                    this.mWakeLock.acquire();
                                }
                            } catch (IllegalArgumentException e) {
                                log("Problem parsing message " + e);
                                if (null != null) {
                                    this.mWakeLock.acquire();
                                }
                            } catch (Throwable th2) {
                                if (null != null) {
                                    this.mWakeLock.acquire();
                                }
                            }
                            start = i + 1;
                        }
                    }
                    if (start == 0) {
                        log("RCV incomplete");
                    }
                    if (start != count) {
                        int remaining = 4096 - start;
                        System.arraycopy(buffer, start, buffer, 0, remaining);
                        start = remaining;
                    } else {
                        start = 0;
                    }
                }
                loge("got " + count + " reading with start = " + start);
                synchronized (this.mDaemonLock) {
                    if (this.mOutputStream != null) {
                        try {
                            loge("closing stream for " + this.mSocket);
                            this.mOutputStream.close();
                        } catch (IOException e2) {
                            loge("Failed closing output stream: " + e2);
                        }
                        this.mOutputStream = null;
                    }
                }
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (IOException ex2) {
                        loge("Failed closing socket: " + ex2);
                    }
                }
            } catch (IOException e3) {
                ex2 = e3;
                localSocket = socket;
            } catch (Throwable th3) {
                th = th3;
                localSocket = socket;
            }
        } catch (IOException e4) {
            ex2 = e4;
            try {
                loge("Communications error: " + ex2);
                throw ex2;
            } catch (Throwable th4) {
                th = th4;
                synchronized (this.mDaemonLock) {
                    if (this.mOutputStream != null) {
                        try {
                            loge("closing stream for " + this.mSocket);
                            this.mOutputStream.close();
                        } catch (IOException e22) {
                            loge("Failed closing output stream: " + e22);
                        }
                        this.mOutputStream = null;
                    }
                }
                if (localSocket != null) {
                    try {
                        localSocket.close();
                    } catch (IOException ex22) {
                        loge("Failed closing socket: " + ex22);
                    }
                }
                throw th;
            }
        }
    }

    static void makeCommand(StringBuilder rawBuilder, StringBuilder logBuilder, int sequenceNumber, String cmd, Object... args) {
        if (cmd.indexOf(0) >= 0) {
            throw new IllegalArgumentException("Unexpected command: " + cmd);
        } else if (cmd.indexOf(32) >= 0) {
            throw new IllegalArgumentException("Arguments must be separate from command");
        } else {
            rawBuilder.append(sequenceNumber).append(' ').append(cmd);
            logBuilder.append(sequenceNumber).append(' ').append(cmd);
            for (Object arg : args) {
                String argString = String.valueOf(arg);
                if (argString.indexOf(0) >= 0) {
                    throw new IllegalArgumentException("Unexpected argument: " + arg);
                }
                rawBuilder.append(' ');
                logBuilder.append(' ');
                appendEscaped(rawBuilder, argString);
                if (arg instanceof SensitiveArg) {
                    logBuilder.append("[scrubbed]");
                } else {
                    appendEscaped(logBuilder, argString);
                }
            }
            rawBuilder.append('\u0000');
        }
    }

    public NativeDaemonEvent execute(Command cmd) throws NativeDaemonConnectorException {
        return execute(cmd.mCmd, cmd.mArguments.toArray());
    }

    public NativeDaemonEvent execute(String cmd, Object... args) throws NativeDaemonConnectorException {
        NativeDaemonEvent[] events = executeForList(cmd, args);
        if (events.length == 1) {
            return events[0];
        }
        throw new NativeDaemonConnectorException("Expected exactly one response, but received " + events.length);
    }

    public NativeDaemonEvent[] executeForList(Command cmd) throws NativeDaemonConnectorException {
        return executeForList(cmd.mCmd, cmd.mArguments.toArray());
    }

    public NativeDaemonEvent[] executeForList(String cmd, Object... args) throws NativeDaemonConnectorException {
        return execute(DEFAULT_TIMEOUT, cmd, args);
    }

    public NativeDaemonEvent[] execute(int timeout, String cmd, Object... args) throws NativeDaemonConnectorException {
        long startTime = SystemClock.elapsedRealtime();
        ArrayList<NativeDaemonEvent> events = Lists.newArrayList();
        StringBuilder rawBuilder = new StringBuilder();
        StringBuilder logBuilder = new StringBuilder();
        int sequenceNumber = this.mSequenceNumber.incrementAndGet();
        makeCommand(rawBuilder, logBuilder, sequenceNumber, cmd, args);
        String rawCmd = rawBuilder.toString();
        String logCmd = logBuilder.toString();
        log("SND -> {" + logCmd + "}");
        synchronized (this.mDaemonLock) {
            if (this.mOutputStream == null) {
                throw new NativeDaemonConnectorException("missing output stream");
            }
            try {
                this.mOutputStream.write(rawCmd.getBytes(StandardCharsets.UTF_8));
            } catch (Throwable e) {
                throw new NativeDaemonConnectorException("problem sending command", e);
            }
        }
        NativeDaemonEvent event;
        do {
            event = this.mResponseQueue.remove(sequenceNumber, timeout, logCmd);
            if (event == null) {
                loge("timed-out waiting for response to " + logCmd);
                throw new NativeDaemonFailureException(logCmd, event);
            }
            events.add(event);
        } while (event.isClassContinue());
        long endTime = SystemClock.elapsedRealtime();
        if (endTime - startTime > WARN_EXECUTE_DELAY_MS) {
            loge("NDC Command {" + logCmd + "} took too long (" + (endTime - startTime) + "ms)");
        }
        if (event.isClassClientError()) {
            throw new NativeDaemonArgumentException(logCmd, event);
        } else if (!event.isClassServerError()) {
            return (NativeDaemonEvent[]) events.toArray(new NativeDaemonEvent[events.size()]);
        } else {
            throw new NativeDaemonFailureException(logCmd, event);
        }
    }

    static void appendEscaped(StringBuilder builder, String arg) {
        boolean hasSpaces = arg.indexOf(32) >= 0 ? true : VDBG;
        if (hasSpaces) {
            builder.append('\"');
        }
        int length = arg.length();
        for (int i = 0; i < length; i++) {
            char c = arg.charAt(i);
            if (c == '\"') {
                builder.append("\\\"");
            } else if (c == '\\') {
                builder.append("\\\\");
            } else {
                builder.append(c);
            }
        }
        if (hasSpaces) {
            builder.append('\"');
        }
    }

    public void monitor() {
        synchronized (this.mDaemonLock) {
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        this.mLocalLog.dump(fd, pw, args);
        pw.println();
        this.mResponseQueue.dump(fd, pw, args);
    }

    private void log(String logstring) {
        this.mLocalLog.log(logstring);
    }

    private void loge(String logstring) {
        Slog.e(this.TAG, logstring);
        this.mLocalLog.log(logstring);
    }
}
