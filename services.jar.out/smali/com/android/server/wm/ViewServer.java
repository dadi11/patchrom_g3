package com.android.server.wm;

import android.util.Slog;
import com.android.server.wm.WindowManagerService.WindowChangeListener;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class ViewServer implements Runnable {
    private static final String COMMAND_PROTOCOL_VERSION = "PROTOCOL";
    private static final String COMMAND_SERVER_VERSION = "SERVER";
    private static final String COMMAND_WINDOW_MANAGER_AUTOLIST = "AUTOLIST";
    private static final String COMMAND_WINDOW_MANAGER_GET_FOCUS = "GET_FOCUS";
    private static final String COMMAND_WINDOW_MANAGER_LIST = "LIST";
    private static final String LOG_TAG = "ViewServer";
    private static final String VALUE_PROTOCOL_VERSION = "4";
    private static final String VALUE_SERVER_VERSION = "4";
    public static final int VIEW_SERVER_DEFAULT_PORT = 4939;
    private static final int VIEW_SERVER_MAX_CONNECTIONS = 10;
    private final int mPort;
    private ServerSocket mServer;
    private Thread mThread;
    private ExecutorService mThreadPool;
    private final WindowManagerService mWindowManager;

    class ViewServerWorker implements Runnable, WindowChangeListener {
        private Socket mClient;
        private boolean mNeedFocusedWindowUpdate;
        private boolean mNeedWindowListUpdate;

        public ViewServerWorker(Socket client) {
            this.mClient = client;
            this.mNeedWindowListUpdate = false;
            this.mNeedFocusedWindowUpdate = false;
        }

        public void run() {
            IOException e;
            Throwable th;
            BufferedReader in = null;
            try {
                BufferedReader in2 = new BufferedReader(new InputStreamReader(this.mClient.getInputStream()), DumpState.DUMP_PREFERRED_XML);
                try {
                    String command;
                    String parameters;
                    boolean result;
                    String request = in2.readLine();
                    int index = request.indexOf(32);
                    if (index == -1) {
                        command = request;
                        parameters = "";
                    } else {
                        command = request.substring(0, index);
                        parameters = request.substring(index + 1);
                    }
                    if (ViewServer.COMMAND_PROTOCOL_VERSION.equalsIgnoreCase(command)) {
                        result = ViewServer.writeValue(this.mClient, ViewServer.VALUE_SERVER_VERSION);
                    } else if (ViewServer.COMMAND_SERVER_VERSION.equalsIgnoreCase(command)) {
                        result = ViewServer.writeValue(this.mClient, ViewServer.VALUE_SERVER_VERSION);
                    } else if (ViewServer.COMMAND_WINDOW_MANAGER_LIST.equalsIgnoreCase(command)) {
                        result = ViewServer.this.mWindowManager.viewServerListWindows(this.mClient);
                    } else if (ViewServer.COMMAND_WINDOW_MANAGER_GET_FOCUS.equalsIgnoreCase(command)) {
                        result = ViewServer.this.mWindowManager.viewServerGetFocusedWindow(this.mClient);
                    } else if (ViewServer.COMMAND_WINDOW_MANAGER_AUTOLIST.equalsIgnoreCase(command)) {
                        result = windowManagerAutolistLoop();
                    } else {
                        result = ViewServer.this.mWindowManager.viewServerWindowCommand(this.mClient, command, parameters);
                    }
                    if (!result) {
                        Slog.w(ViewServer.LOG_TAG, "An error occurred with the command: " + command);
                    }
                    if (in2 != null) {
                        try {
                            in2.close();
                        } catch (IOException e2) {
                            e2.printStackTrace();
                        }
                    }
                    if (this.mClient != null) {
                        try {
                            this.mClient.close();
                            in = in2;
                            return;
                        } catch (IOException e22) {
                            e22.printStackTrace();
                            in = in2;
                            return;
                        }
                    }
                } catch (IOException e3) {
                    e22 = e3;
                    in = in2;
                    try {
                        Slog.w(ViewServer.LOG_TAG, "Connection error: ", e22);
                        if (in != null) {
                            try {
                                in.close();
                            } catch (IOException e222) {
                                e222.printStackTrace();
                            }
                        }
                        if (this.mClient != null) {
                            try {
                                this.mClient.close();
                            } catch (IOException e2222) {
                                e2222.printStackTrace();
                            }
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        if (in != null) {
                            try {
                                in.close();
                            } catch (IOException e22222) {
                                e22222.printStackTrace();
                            }
                        }
                        if (this.mClient != null) {
                            try {
                                this.mClient.close();
                            } catch (IOException e222222) {
                                e222222.printStackTrace();
                            }
                        }
                        throw th;
                    }
                } catch (Throwable th3) {
                    th = th3;
                    in = in2;
                    if (in != null) {
                        in.close();
                    }
                    if (this.mClient != null) {
                        this.mClient.close();
                    }
                    throw th;
                }
            } catch (IOException e4) {
                e222222 = e4;
                Slog.w(ViewServer.LOG_TAG, "Connection error: ", e222222);
                if (in != null) {
                    in.close();
                }
                if (this.mClient != null) {
                    this.mClient.close();
                }
            }
        }

        public void windowsChanged() {
            synchronized (this) {
                this.mNeedWindowListUpdate = true;
                notifyAll();
            }
        }

        public void focusChanged() {
            synchronized (this) {
                this.mNeedFocusedWindowUpdate = true;
                notifyAll();
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private boolean windowManagerAutolistLoop() {
            /*
            r6 = this;
            r4 = com.android.server.wm.ViewServer.this;
            r4 = r4.mWindowManager;
            r4.addWindowChangeListener(r6);
            r2 = 0;
            r3 = new java.io.BufferedWriter;	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
            r4 = new java.io.OutputStreamWriter;	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
            r5 = r6.mClient;	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
            r5 = r5.getOutputStream();	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
            r4.<init>(r5);	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
            r3.<init>(r4);	 Catch:{ Exception -> 0x0093, all -> 0x0091 }
        L_0x001a:
            r4 = java.lang.Thread.interrupted();	 Catch:{ Exception -> 0x0032, all -> 0x006a }
            if (r4 != 0) goto L_0x007b;
        L_0x0020:
            r1 = 0;
            r0 = 0;
            monitor-enter(r6);	 Catch:{ Exception -> 0x0032, all -> 0x006a }
        L_0x0023:
            r4 = r6.mNeedWindowListUpdate;	 Catch:{ all -> 0x002f }
            if (r4 != 0) goto L_0x0044;
        L_0x0027:
            r4 = r6.mNeedFocusedWindowUpdate;	 Catch:{ all -> 0x002f }
            if (r4 != 0) goto L_0x0044;
        L_0x002b:
            r6.wait();	 Catch:{ all -> 0x002f }
            goto L_0x0023;
        L_0x002f:
            r4 = move-exception;
            monitor-exit(r6);	 Catch:{ all -> 0x002f }
            throw r4;	 Catch:{ Exception -> 0x0032, all -> 0x006a }
        L_0x0032:
            r4 = move-exception;
            r2 = r3;
        L_0x0034:
            if (r2 == 0) goto L_0x0039;
        L_0x0036:
            r2.close();	 Catch:{ IOException -> 0x008d }
        L_0x0039:
            r4 = com.android.server.wm.ViewServer.this;
            r4 = r4.mWindowManager;
            r4.removeWindowChangeListener(r6);
        L_0x0042:
            r4 = 1;
            return r4;
        L_0x0044:
            r4 = r6.mNeedWindowListUpdate;	 Catch:{ all -> 0x002f }
            if (r4 == 0) goto L_0x004c;
        L_0x0048:
            r4 = 0;
            r6.mNeedWindowListUpdate = r4;	 Catch:{ all -> 0x002f }
            r1 = 1;
        L_0x004c:
            r4 = r6.mNeedFocusedWindowUpdate;	 Catch:{ all -> 0x002f }
            if (r4 == 0) goto L_0x0054;
        L_0x0050:
            r4 = 0;
            r6.mNeedFocusedWindowUpdate = r4;	 Catch:{ all -> 0x002f }
            r0 = 1;
        L_0x0054:
            monitor-exit(r6);	 Catch:{ all -> 0x002f }
            if (r1 == 0) goto L_0x005f;
        L_0x0057:
            r4 = "LIST UPDATE\n";
            r3.write(r4);	 Catch:{ Exception -> 0x0032, all -> 0x006a }
            r3.flush();	 Catch:{ Exception -> 0x0032, all -> 0x006a }
        L_0x005f:
            if (r0 == 0) goto L_0x001a;
        L_0x0061:
            r4 = "ACTION_FOCUS UPDATE\n";
            r3.write(r4);	 Catch:{ Exception -> 0x0032, all -> 0x006a }
            r3.flush();	 Catch:{ Exception -> 0x0032, all -> 0x006a }
            goto L_0x001a;
        L_0x006a:
            r4 = move-exception;
            r2 = r3;
        L_0x006c:
            if (r2 == 0) goto L_0x0071;
        L_0x006e:
            r2.close();	 Catch:{ IOException -> 0x008f }
        L_0x0071:
            r5 = com.android.server.wm.ViewServer.this;
            r5 = r5.mWindowManager;
            r5.removeWindowChangeListener(r6);
            throw r4;
        L_0x007b:
            if (r3 == 0) goto L_0x0080;
        L_0x007d:
            r3.close();	 Catch:{ IOException -> 0x008b }
        L_0x0080:
            r4 = com.android.server.wm.ViewServer.this;
            r4 = r4.mWindowManager;
            r4.removeWindowChangeListener(r6);
            r2 = r3;
            goto L_0x0042;
        L_0x008b:
            r4 = move-exception;
            goto L_0x0080;
        L_0x008d:
            r4 = move-exception;
            goto L_0x0039;
        L_0x008f:
            r5 = move-exception;
            goto L_0x0071;
        L_0x0091:
            r4 = move-exception;
            goto L_0x006c;
        L_0x0093:
            r4 = move-exception;
            goto L_0x0034;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.wm.ViewServer.ViewServerWorker.windowManagerAutolistLoop():boolean");
        }
    }

    ViewServer(WindowManagerService windowManager, int port) {
        this.mWindowManager = windowManager;
        this.mPort = port;
    }

    boolean start() throws IOException {
        if (this.mThread != null) {
            return false;
        }
        this.mServer = new ServerSocket(this.mPort, VIEW_SERVER_MAX_CONNECTIONS, InetAddress.getLocalHost());
        this.mThread = new Thread(this, "Remote View Server [port=" + this.mPort + "]");
        this.mThreadPool = Executors.newFixedThreadPool(VIEW_SERVER_MAX_CONNECTIONS);
        this.mThread.start();
        return true;
    }

    boolean stop() {
        if (this.mThread != null) {
            this.mThread.interrupt();
            if (this.mThreadPool != null) {
                try {
                    this.mThreadPool.shutdownNow();
                } catch (SecurityException e) {
                    Slog.w(LOG_TAG, "Could not stop all view server threads");
                }
            }
            this.mThreadPool = null;
            this.mThread = null;
            try {
                this.mServer.close();
                this.mServer = null;
                return true;
            } catch (IOException e2) {
                Slog.w(LOG_TAG, "Could not close the view server");
            }
        }
        return false;
    }

    boolean isRunning() {
        return this.mThread != null && this.mThread.isAlive();
    }

    public void run() {
        while (Thread.currentThread() == this.mThread) {
            try {
                Socket client = this.mServer.accept();
                if (this.mThreadPool != null) {
                    this.mThreadPool.submit(new ViewServerWorker(client));
                } else {
                    try {
                        client.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e2) {
                Slog.w(LOG_TAG, "Connection error: ", e2);
            }
        }
    }

    private static boolean writeValue(Socket client, String value) {
        Throwable th;
        BufferedWriter out = null;
        try {
            BufferedWriter out2 = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()), DumpState.DUMP_INSTALLS);
            try {
                out2.write(value);
                out2.write("\n");
                out2.flush();
                if (out2 != null) {
                    try {
                        out2.close();
                        out = out2;
                        return true;
                    } catch (IOException e) {
                        out = out2;
                        return false;
                    }
                }
                return true;
            } catch (Exception e2) {
                out = out2;
                if (out != null) {
                    return false;
                }
                try {
                    out.close();
                    return false;
                } catch (IOException e3) {
                    return false;
                }
            } catch (Throwable th2) {
                th = th2;
                out = out2;
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException e4) {
                    }
                }
                throw th;
            }
        } catch (Exception e5) {
            if (out != null) {
                return false;
            }
            out.close();
            return false;
        } catch (Throwable th3) {
            th = th3;
            if (out != null) {
                out.close();
            }
            throw th;
        }
    }
}
