package com.android.internal.telephony.test;

import android.os.HandlerThread;
import android.os.Looper;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.util.List;

public class ModelInterpreter implements Runnable, SimulatedRadioControl {
    static final int CONNECTING_PAUSE_MSEC = 500;
    static final String LOG_TAG = "ModelInterpreter";
    static final int MAX_CALLS = 6;
    static final int PROGRESS_CALL_STATE = 1;
    static final String[][] sDefaultResponses;
    private String mFinalResponse;
    HandlerThread mHandlerThread;
    InputStream mIn;
    LineReader mLineReader;
    OutputStream mOut;
    int mPausedResponseCount;
    Object mPausedResponseMonitor;
    ServerSocket mSS;
    SimulatedGsmCallState mSimulatedCallState;

    public ModelInterpreter(InputStream in, OutputStream out) {
        this.mPausedResponseMonitor = new Object();
        this.mIn = in;
        this.mOut = out;
        init();
    }

    public ModelInterpreter(InetSocketAddress sa) throws IOException {
        this.mPausedResponseMonitor = new Object();
        this.mSS = new ServerSocket();
        this.mSS.setReuseAddress(true);
        this.mSS.bind(sa);
        init();
    }

    private void init() {
        new Thread(this, LOG_TAG).start();
        this.mHandlerThread = new HandlerThread(LOG_TAG);
        this.mHandlerThread.start();
        this.mSimulatedCallState = new SimulatedGsmCallState(this.mHandlerThread.getLooper());
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void run() {
        /*
        r5 = this;
    L_0x0000:
        r3 = r5.mSS;
        if (r3 == 0) goto L_0x001d;
    L_0x0004:
        r3 = r5.mSS;	 Catch:{ IOException -> 0x003f }
        r2 = r3.accept();	 Catch:{ IOException -> 0x003f }
        r3 = r2.getInputStream();	 Catch:{ IOException -> 0x0048 }
        r5.mIn = r3;	 Catch:{ IOException -> 0x0048 }
        r3 = r2.getOutputStream();	 Catch:{ IOException -> 0x0048 }
        r5.mOut = r3;	 Catch:{ IOException -> 0x0048 }
        r3 = "ModelInterpreter";
        r4 = "New connection accepted";
        android.telephony.Rlog.i(r3, r4);
    L_0x001d:
        r3 = new com.android.internal.telephony.test.LineReader;
        r4 = r5.mIn;
        r3.<init>(r4);
        r5.mLineReader = r3;
        r3 = "Welcome";
        r5.println(r3);
    L_0x002b:
        r3 = r5.mLineReader;
        r1 = r3.getNextLine();
        if (r1 != 0) goto L_0x0051;
    L_0x0033:
        r3 = "ModelInterpreter";
        r4 = "Disconnected";
        android.telephony.Rlog.i(r3, r4);
        r3 = r5.mSS;
        if (r3 != 0) goto L_0x0000;
    L_0x003e:
        return;
    L_0x003f:
        r0 = move-exception;
        r3 = "ModelInterpreter";
        r4 = "IOException on socket.accept(); stopping";
        android.telephony.Rlog.w(r3, r4, r0);
        goto L_0x003e;
    L_0x0048:
        r0 = move-exception;
        r3 = "ModelInterpreter";
        r4 = "IOException on accepted socket(); re-listening";
        android.telephony.Rlog.w(r3, r4, r0);
        goto L_0x0000;
    L_0x0051:
        r4 = r5.mPausedResponseMonitor;
        monitor-enter(r4);
    L_0x0054:
        r3 = r5.mPausedResponseCount;	 Catch:{ all -> 0x0073 }
        if (r3 <= 0) goto L_0x0060;
    L_0x0058:
        r3 = r5.mPausedResponseMonitor;	 Catch:{ InterruptedException -> 0x005e }
        r3.wait();	 Catch:{ InterruptedException -> 0x005e }
        goto L_0x0054;
    L_0x005e:
        r3 = move-exception;
        goto L_0x0054;
    L_0x0060:
        monitor-exit(r4);	 Catch:{ all -> 0x0073 }
        monitor-enter(r5);
        r3 = "OK";
        r5.mFinalResponse = r3;	 Catch:{ InterpreterEx -> 0x0076, RuntimeException -> 0x007d }
        r5.processLine(r1);	 Catch:{ InterpreterEx -> 0x0076, RuntimeException -> 0x007d }
        r3 = r5.mFinalResponse;	 Catch:{ InterpreterEx -> 0x0076, RuntimeException -> 0x007d }
        r5.println(r3);	 Catch:{ InterpreterEx -> 0x0076, RuntimeException -> 0x007d }
    L_0x006e:
        monitor-exit(r5);	 Catch:{ all -> 0x0070 }
        goto L_0x002b;
    L_0x0070:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0070 }
        throw r3;
    L_0x0073:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0073 }
        throw r3;
    L_0x0076:
        r0 = move-exception;
        r3 = r0.mResult;	 Catch:{ all -> 0x0070 }
        r5.println(r3);	 Catch:{ all -> 0x0070 }
        goto L_0x006e;
    L_0x007d:
        r0 = move-exception;
        r0.printStackTrace();	 Catch:{ all -> 0x0070 }
        r3 = "ERROR";
        r5.println(r3);	 Catch:{ all -> 0x0070 }
        goto L_0x006e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.ModelInterpreter.run():void");
    }

    public void triggerRing(String number) {
        synchronized (this) {
            if (this.mSimulatedCallState.triggerRing(number)) {
                println("RING");
            }
        }
    }

    public void progressConnectingCallState() {
        this.mSimulatedCallState.progressConnectingCallState();
    }

    public void progressConnectingToActive() {
        this.mSimulatedCallState.progressConnectingToActive();
    }

    public void setAutoProgressConnectingCall(boolean b) {
        this.mSimulatedCallState.setAutoProgressConnectingCall(b);
    }

    public void setNextDialFailImmediately(boolean b) {
        this.mSimulatedCallState.setNextDialFailImmediately(b);
    }

    public void setNextCallFailCause(int gsmCause) {
    }

    public void triggerHangupForeground() {
        if (this.mSimulatedCallState.triggerHangupForeground()) {
            println("NO CARRIER");
        }
    }

    public void triggerHangupBackground() {
        if (this.mSimulatedCallState.triggerHangupBackground()) {
            println("NO CARRIER");
        }
    }

    public void triggerHangupAll() {
        if (this.mSimulatedCallState.triggerHangupAll()) {
            println("NO CARRIER");
        }
    }

    public void sendUnsolicited(String unsol) {
        synchronized (this) {
            println(unsol);
        }
    }

    public void triggerSsn(int a, int b) {
    }

    public void triggerIncomingUssd(String statusCode, String message) {
    }

    public void triggerIncomingSMS(String message) {
    }

    public void pauseResponses() {
        synchronized (this.mPausedResponseMonitor) {
            this.mPausedResponseCount += PROGRESS_CALL_STATE;
        }
    }

    public void resumeResponses() {
        synchronized (this.mPausedResponseMonitor) {
            this.mPausedResponseCount--;
            if (this.mPausedResponseCount == 0) {
                this.mPausedResponseMonitor.notifyAll();
            }
        }
    }

    private void onAnswer() throws InterpreterEx {
        if (!this.mSimulatedCallState.onAnswer()) {
            throw new InterpreterEx("ERROR");
        }
    }

    private void onHangup() throws InterpreterEx {
        if (this.mSimulatedCallState.onAnswer()) {
            this.mFinalResponse = "NO CARRIER";
            return;
        }
        throw new InterpreterEx("ERROR");
    }

    private void onCHLD(String command) throws InterpreterEx {
        char c1 = '\u0000';
        char c0 = command.charAt(MAX_CALLS);
        if (command.length() >= 8) {
            c1 = command.charAt(7);
        }
        if (!this.mSimulatedCallState.onChld(c0, c1)) {
            throw new InterpreterEx("ERROR");
        }
    }

    private void onDial(String command) throws InterpreterEx {
        if (!this.mSimulatedCallState.onDial(command.substring(PROGRESS_CALL_STATE))) {
            throw new InterpreterEx("ERROR");
        }
    }

    private void onCLCC() {
        List<String> lines = this.mSimulatedCallState.getClccLines();
        int s = lines.size();
        for (int i = 0; i < s; i += PROGRESS_CALL_STATE) {
            println((String) lines.get(i));
        }
    }

    private void onSMSSend(String command) {
        print("> ");
        String pdu = this.mLineReader.getNextLineCtrlZ();
        println("+CMGS: 1");
    }

    void processLine(String line) throws InterpreterEx {
        String[] commands = splitCommands(line);
        for (int i = 0; i < commands.length; i += PROGRESS_CALL_STATE) {
            String command = commands[i];
            if (command.equals("A")) {
                onAnswer();
            } else if (command.equals("H")) {
                onHangup();
            } else if (command.startsWith("+CHLD=")) {
                onCHLD(command);
            } else if (command.equals("+CLCC")) {
                onCLCC();
            } else if (command.startsWith("D")) {
                onDial(command);
            } else if (command.startsWith("+CMGS=")) {
                onSMSSend(command);
            } else {
                boolean found = false;
                int j = 0;
                while (j < sDefaultResponses.length) {
                    if (command.equals(sDefaultResponses[j][0])) {
                        String r = sDefaultResponses[j][PROGRESS_CALL_STATE];
                        if (r != null) {
                            println(r);
                        }
                        found = true;
                        if (!found) {
                            throw new InterpreterEx("ERROR");
                        }
                    } else {
                        j += PROGRESS_CALL_STATE;
                    }
                }
                if (!found) {
                    throw new InterpreterEx("ERROR");
                }
            }
        }
    }

    String[] splitCommands(String line) throws InterpreterEx {
        if (!line.startsWith("AT")) {
            throw new InterpreterEx("ERROR");
        } else if (line.length() == 2) {
            return new String[0];
        } else {
            String[] ret = new String[PROGRESS_CALL_STATE];
            ret[0] = line.substring(2);
            return ret;
        }
    }

    void println(String s) {
        synchronized (this) {
            try {
                this.mOut.write(s.getBytes("US-ASCII"));
                this.mOut.write(13);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    void print(String s) {
        synchronized (this) {
            try {
                this.mOut.write(s.getBytes("US-ASCII"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void shutdown() {
        Looper looper = this.mHandlerThread.getLooper();
        if (looper != null) {
            looper.quit();
        }
        try {
            this.mIn.close();
        } catch (IOException e) {
        }
        try {
            this.mOut.close();
        } catch (IOException e2) {
        }
    }

    static {
        r0 = new String[31][];
        r0[0] = new String[]{"E0Q0V1", null};
        r0[PROGRESS_CALL_STATE] = new String[]{"+CMEE=2", null};
        r0[2] = new String[]{"+CREG=2", null};
        r0[3] = new String[]{"+CGREG=2", null};
        r0[4] = new String[]{"+CCWA=1", null};
        r0[5] = new String[]{"+COPS=0", null};
        r0[MAX_CALLS] = new String[]{"+CFUN=1", null};
        r0[7] = new String[]{"+CGMI", "+CGMI: Android Model AT Interpreter\r"};
        r0[8] = new String[]{"+CGMM", "+CGMM: Android Model AT Interpreter\r"};
        r0[9] = new String[]{"+CGMR", "+CGMR: 1.0\r"};
        r0[10] = new String[]{"+CGSN", "000000000000000\r"};
        r0[11] = new String[]{"+CIMI", "320720000000000\r"};
        r0[12] = new String[]{"+CSCS=?", "+CSCS: (\"HEX\",\"UCS2\")\r"};
        r0[13] = new String[]{"+CFUN?", "+CFUN: 1\r"};
        r0[14] = new String[]{"+COPS=3,0;+COPS?;+COPS=3,1;+COPS?;+COPS=3,2;+COPS?", "+COPS: 0,0,\"Android\"\r+COPS: 0,1,\"Android\"\r+COPS: 0,2,\"310995\"\r"};
        r0[15] = new String[]{"+CREG?", "+CREG: 2,5, \"0113\", \"6614\"\r"};
        r0[16] = new String[]{"+CGREG?", "+CGREG: 2,0\r"};
        r0[17] = new String[]{"+CSQ", "+CSQ: 16,99\r"};
        r0[18] = new String[]{"+CNMI?", "+CNMI: 1,2,2,1,1\r"};
        r0[19] = new String[]{"+CLIR?", "+CLIR: 1,3\r"};
        r0[20] = new String[]{"%CPVWI=2", "%CPVWI: 0\r"};
        r0[21] = new String[]{"+CUSD=1,\"#646#\"", "+CUSD=0,\"You have used 23 minutes\"\r"};
        r0[22] = new String[]{"+CRSM=176,12258,0,0,10", "+CRSM: 144,0,981062200050259429F6\r"};
        r0[23] = new String[]{"+CRSM=192,12258,0,0,15", "+CRSM: 144,0,0000000A2FE204000FF55501020000\r"};
        r0[24] = new String[]{"+CRSM=192,28474,0,0,15", "+CRSM: 144,0,0000005a6f3a040011f5220102011e\r"};
        r0[25] = new String[]{"+CRSM=178,28474,1,4,30", "+CRSM: 144,0,437573746f6d65722043617265ffffff07818100398799f7ffffffffffff\r"};
        r0[26] = new String[]{"+CRSM=178,28474,2,4,30", "+CRSM: 144,0,566f696365204d61696cffffffffffff07918150367742f3ffffffffffff\r"};
        r0[27] = new String[]{"+CRSM=178,28474,3,4,30", "+CRSM: 144,0,4164676a6dffffffffffffffffffffff0b918188551512c221436587ff01\r"};
        r0[28] = new String[]{"+CRSM=178,28474,4,4,30", "+CRSM: 144,0,810101c1ffffffffffffffffffffffff068114455245f8ffffffffffffff\r"};
        r0[29] = new String[]{"+CRSM=192,28490,0,0,15", "+CRSM: 144,0,000000416f4a040011f5550102010d\r"};
        r0[30] = new String[]{"+CRSM=178,28490,1,4,13", "+CRSM: 144,0,0206092143658709ffffffffff\r"};
        sDefaultResponses = r0;
    }
}
