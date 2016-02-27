package com.android.internal.telephony.test;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import com.android.internal.telephony.DriverCall;
import com.android.internal.telephony.RadioNVItems;
import com.android.internal.telephony.gsm.CallFailCause;
import java.util.ArrayList;
import java.util.List;

class SimulatedGsmCallState extends Handler {
    static final int CONNECTING_PAUSE_MSEC = 500;
    static final int EVENT_PROGRESS_CALL_STATE = 1;
    static final int MAX_CALLS = 7;
    private boolean mAutoProgressConnecting;
    CallInfo[] mCalls;
    private boolean mNextDialFailImmediately;

    public SimulatedGsmCallState(Looper looper) {
        super(looper);
        this.mCalls = new CallInfo[MAX_CALLS];
        this.mAutoProgressConnecting = true;
    }

    public void handleMessage(Message msg) {
        synchronized (this) {
            switch (msg.what) {
                case EVENT_PROGRESS_CALL_STATE /*1*/:
                    progressConnectingCallState();
                    break;
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean triggerRing(java.lang.String r8) {
        /*
        r7 = this;
        r4 = 0;
        monitor-enter(r7);
        r1 = -1;
        r3 = 0;
        r2 = 0;
    L_0x0005:
        r5 = r7.mCalls;	 Catch:{ all -> 0x003c }
        r5 = r5.length;	 Catch:{ all -> 0x003c }
        if (r2 >= r5) goto L_0x0031;
    L_0x000a:
        r5 = r7.mCalls;	 Catch:{ all -> 0x003c }
        r0 = r5[r2];	 Catch:{ all -> 0x003c }
        if (r0 != 0) goto L_0x0016;
    L_0x0010:
        if (r1 >= 0) goto L_0x0016;
    L_0x0012:
        r1 = r2;
    L_0x0013:
        r2 = r2 + 1;
        goto L_0x0005;
    L_0x0016:
        if (r0 == 0) goto L_0x002d;
    L_0x0018:
        r5 = r0.mState;	 Catch:{ all -> 0x003c }
        r6 = com.android.internal.telephony.test.CallInfo.State.INCOMING;	 Catch:{ all -> 0x003c }
        if (r5 == r6) goto L_0x0024;
    L_0x001e:
        r5 = r0.mState;	 Catch:{ all -> 0x003c }
        r6 = com.android.internal.telephony.test.CallInfo.State.WAITING;	 Catch:{ all -> 0x003c }
        if (r5 != r6) goto L_0x002d;
    L_0x0024:
        r5 = "ModelInterpreter";
        r6 = "triggerRing failed; phone already ringing";
        android.telephony.Rlog.w(r5, r6);	 Catch:{ all -> 0x003c }
        monitor-exit(r7);	 Catch:{ all -> 0x003c }
    L_0x002c:
        return r4;
    L_0x002d:
        if (r0 == 0) goto L_0x0013;
    L_0x002f:
        r3 = 1;
        goto L_0x0013;
    L_0x0031:
        if (r1 >= 0) goto L_0x003f;
    L_0x0033:
        r5 = "ModelInterpreter";
        r6 = "triggerRing failed; all full";
        android.telephony.Rlog.w(r5, r6);	 Catch:{ all -> 0x003c }
        monitor-exit(r7);	 Catch:{ all -> 0x003c }
        goto L_0x002c;
    L_0x003c:
        r4 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x003c }
        throw r4;
    L_0x003f:
        r4 = r7.mCalls;	 Catch:{ all -> 0x003c }
        r5 = android.telephony.PhoneNumberUtils.extractNetworkPortion(r8);	 Catch:{ all -> 0x003c }
        r5 = com.android.internal.telephony.test.CallInfo.createIncomingCall(r5);	 Catch:{ all -> 0x003c }
        r4[r1] = r5;	 Catch:{ all -> 0x003c }
        if (r3 == 0) goto L_0x0055;
    L_0x004d:
        r4 = r7.mCalls;	 Catch:{ all -> 0x003c }
        r4 = r4[r1];	 Catch:{ all -> 0x003c }
        r5 = com.android.internal.telephony.test.CallInfo.State.WAITING;	 Catch:{ all -> 0x003c }
        r4.mState = r5;	 Catch:{ all -> 0x003c }
    L_0x0055:
        monitor-exit(r7);	 Catch:{ all -> 0x003c }
        r4 = 1;
        goto L_0x002c;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.triggerRing(java.lang.String):boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void progressConnectingCallState() {
        /*
        r6 = this;
        monitor-enter(r6);
        r1 = 0;
    L_0x0002:
        r2 = r6.mCalls;	 Catch:{ all -> 0x0034 }
        r2 = r2.length;	 Catch:{ all -> 0x0034 }
        if (r1 >= r2) goto L_0x0025;
    L_0x0007:
        r2 = r6.mCalls;	 Catch:{ all -> 0x0034 }
        r0 = r2[r1];	 Catch:{ all -> 0x0034 }
        if (r0 == 0) goto L_0x0027;
    L_0x000d:
        r2 = r0.mState;	 Catch:{ all -> 0x0034 }
        r3 = com.android.internal.telephony.test.CallInfo.State.DIALING;	 Catch:{ all -> 0x0034 }
        if (r2 != r3) goto L_0x0027;
    L_0x0013:
        r2 = com.android.internal.telephony.test.CallInfo.State.ALERTING;	 Catch:{ all -> 0x0034 }
        r0.mState = r2;	 Catch:{ all -> 0x0034 }
        r2 = r6.mAutoProgressConnecting;	 Catch:{ all -> 0x0034 }
        if (r2 == 0) goto L_0x0025;
    L_0x001b:
        r2 = 1;
        r2 = r6.obtainMessage(r2, r0);	 Catch:{ all -> 0x0034 }
        r4 = 500; // 0x1f4 float:7.0E-43 double:2.47E-321;
        r6.sendMessageDelayed(r2, r4);	 Catch:{ all -> 0x0034 }
    L_0x0025:
        monitor-exit(r6);	 Catch:{ all -> 0x0034 }
        return;
    L_0x0027:
        if (r0 == 0) goto L_0x0037;
    L_0x0029:
        r2 = r0.mState;	 Catch:{ all -> 0x0034 }
        r3 = com.android.internal.telephony.test.CallInfo.State.ALERTING;	 Catch:{ all -> 0x0034 }
        if (r2 != r3) goto L_0x0037;
    L_0x002f:
        r2 = com.android.internal.telephony.test.CallInfo.State.ACTIVE;	 Catch:{ all -> 0x0034 }
        r0.mState = r2;	 Catch:{ all -> 0x0034 }
        goto L_0x0025;
    L_0x0034:
        r2 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0034 }
        throw r2;
    L_0x0037:
        r1 = r1 + 1;
        goto L_0x0002;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.progressConnectingCallState():void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void progressConnectingToActive() {
        /*
        r4 = this;
        monitor-enter(r4);
        r1 = 0;
    L_0x0002:
        r2 = r4.mCalls;	 Catch:{ all -> 0x0022 }
        r2 = r2.length;	 Catch:{ all -> 0x0022 }
        if (r1 >= r2) goto L_0x001d;
    L_0x0007:
        r2 = r4.mCalls;	 Catch:{ all -> 0x0022 }
        r0 = r2[r1];	 Catch:{ all -> 0x0022 }
        if (r0 == 0) goto L_0x001f;
    L_0x000d:
        r2 = r0.mState;	 Catch:{ all -> 0x0022 }
        r3 = com.android.internal.telephony.test.CallInfo.State.DIALING;	 Catch:{ all -> 0x0022 }
        if (r2 == r3) goto L_0x0019;
    L_0x0013:
        r2 = r0.mState;	 Catch:{ all -> 0x0022 }
        r3 = com.android.internal.telephony.test.CallInfo.State.ALERTING;	 Catch:{ all -> 0x0022 }
        if (r2 != r3) goto L_0x001f;
    L_0x0019:
        r2 = com.android.internal.telephony.test.CallInfo.State.ACTIVE;	 Catch:{ all -> 0x0022 }
        r0.mState = r2;	 Catch:{ all -> 0x0022 }
    L_0x001d:
        monitor-exit(r4);	 Catch:{ all -> 0x0022 }
        return;
    L_0x001f:
        r1 = r1 + 1;
        goto L_0x0002;
    L_0x0022:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0022 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.progressConnectingToActive():void");
    }

    public void setAutoProgressConnectingCall(boolean b) {
        this.mAutoProgressConnecting = b;
    }

    public void setNextDialFailImmediately(boolean b) {
        this.mNextDialFailImmediately = b;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean triggerHangupForeground() {
        /*
        r5 = this;
        monitor-enter(r5);
        r1 = 0;
        r2 = 0;
    L_0x0003:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r3 = r3.length;	 Catch:{ all -> 0x004c }
        if (r2 >= r3) goto L_0x0023;
    L_0x0008:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r0 = r3[r2];	 Catch:{ all -> 0x004c }
        if (r0 == 0) goto L_0x0020;
    L_0x000e:
        r3 = r0.mState;	 Catch:{ all -> 0x004c }
        r4 = com.android.internal.telephony.test.CallInfo.State.INCOMING;	 Catch:{ all -> 0x004c }
        if (r3 == r4) goto L_0x001a;
    L_0x0014:
        r3 = r0.mState;	 Catch:{ all -> 0x004c }
        r4 = com.android.internal.telephony.test.CallInfo.State.WAITING;	 Catch:{ all -> 0x004c }
        if (r3 != r4) goto L_0x0020;
    L_0x001a:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r4 = 0;
        r3[r2] = r4;	 Catch:{ all -> 0x004c }
        r1 = 1;
    L_0x0020:
        r2 = r2 + 1;
        goto L_0x0003;
    L_0x0023:
        r2 = 0;
    L_0x0024:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r3 = r3.length;	 Catch:{ all -> 0x004c }
        if (r2 >= r3) goto L_0x004a;
    L_0x0029:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r0 = r3[r2];	 Catch:{ all -> 0x004c }
        if (r0 == 0) goto L_0x0047;
    L_0x002f:
        r3 = r0.mState;	 Catch:{ all -> 0x004c }
        r4 = com.android.internal.telephony.test.CallInfo.State.DIALING;	 Catch:{ all -> 0x004c }
        if (r3 == r4) goto L_0x0041;
    L_0x0035:
        r3 = r0.mState;	 Catch:{ all -> 0x004c }
        r4 = com.android.internal.telephony.test.CallInfo.State.ACTIVE;	 Catch:{ all -> 0x004c }
        if (r3 == r4) goto L_0x0041;
    L_0x003b:
        r3 = r0.mState;	 Catch:{ all -> 0x004c }
        r4 = com.android.internal.telephony.test.CallInfo.State.ALERTING;	 Catch:{ all -> 0x004c }
        if (r3 != r4) goto L_0x0047;
    L_0x0041:
        r3 = r5.mCalls;	 Catch:{ all -> 0x004c }
        r4 = 0;
        r3[r2] = r4;	 Catch:{ all -> 0x004c }
        r1 = 1;
    L_0x0047:
        r2 = r2 + 1;
        goto L_0x0024;
    L_0x004a:
        monitor-exit(r5);	 Catch:{ all -> 0x004c }
        return r1;
    L_0x004c:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x004c }
        throw r3;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.triggerHangupForeground():boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean triggerHangupBackground() {
        /*
        r5 = this;
        monitor-enter(r5);
        r1 = 0;
        r2 = 0;
    L_0x0003:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001f }
        r3 = r3.length;	 Catch:{ all -> 0x001f }
        if (r2 >= r3) goto L_0x001d;
    L_0x0008:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001f }
        r0 = r3[r2];	 Catch:{ all -> 0x001f }
        if (r0 == 0) goto L_0x001a;
    L_0x000e:
        r3 = r0.mState;	 Catch:{ all -> 0x001f }
        r4 = com.android.internal.telephony.test.CallInfo.State.HOLDING;	 Catch:{ all -> 0x001f }
        if (r3 != r4) goto L_0x001a;
    L_0x0014:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001f }
        r4 = 0;
        r3[r2] = r4;	 Catch:{ all -> 0x001f }
        r1 = 1;
    L_0x001a:
        r2 = r2 + 1;
        goto L_0x0003;
    L_0x001d:
        monitor-exit(r5);	 Catch:{ all -> 0x001f }
        return r1;
    L_0x001f:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x001f }
        throw r3;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.triggerHangupBackground():boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean triggerHangupAll() {
        /*
        r5 = this;
        monitor-enter(r5);
        r1 = 0;
        r2 = 0;
    L_0x0003:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001d }
        r3 = r3.length;	 Catch:{ all -> 0x001d }
        if (r2 >= r3) goto L_0x001b;
    L_0x0008:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001d }
        r0 = r3[r2];	 Catch:{ all -> 0x001d }
        r3 = r5.mCalls;	 Catch:{ all -> 0x001d }
        r3 = r3[r2];	 Catch:{ all -> 0x001d }
        if (r3 == 0) goto L_0x0013;
    L_0x0012:
        r1 = 1;
    L_0x0013:
        r3 = r5.mCalls;	 Catch:{ all -> 0x001d }
        r4 = 0;
        r3[r2] = r4;	 Catch:{ all -> 0x001d }
        r2 = r2 + 1;
        goto L_0x0003;
    L_0x001b:
        monitor-exit(r5);	 Catch:{ all -> 0x001d }
        return r1;
    L_0x001d:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x001d }
        throw r3;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.triggerHangupAll():boolean");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean onAnswer() {
        /*
        r4 = this;
        monitor-enter(r4);
        r1 = 0;
    L_0x0002:
        r2 = r4.mCalls;	 Catch:{ all -> 0x0025 }
        r2 = r2.length;	 Catch:{ all -> 0x0025 }
        if (r1 >= r2) goto L_0x0022;
    L_0x0007:
        r2 = r4.mCalls;	 Catch:{ all -> 0x0025 }
        r0 = r2[r1];	 Catch:{ all -> 0x0025 }
        if (r0 == 0) goto L_0x001f;
    L_0x000d:
        r2 = r0.mState;	 Catch:{ all -> 0x0025 }
        r3 = com.android.internal.telephony.test.CallInfo.State.INCOMING;	 Catch:{ all -> 0x0025 }
        if (r2 == r3) goto L_0x0019;
    L_0x0013:
        r2 = r0.mState;	 Catch:{ all -> 0x0025 }
        r3 = com.android.internal.telephony.test.CallInfo.State.WAITING;	 Catch:{ all -> 0x0025 }
        if (r2 != r3) goto L_0x001f;
    L_0x0019:
        r2 = r4.switchActiveAndHeldOrWaiting();	 Catch:{ all -> 0x0025 }
        monitor-exit(r4);	 Catch:{ all -> 0x0025 }
    L_0x001e:
        return r2;
    L_0x001f:
        r1 = r1 + 1;
        goto L_0x0002;
    L_0x0022:
        monitor-exit(r4);	 Catch:{ all -> 0x0025 }
        r2 = 0;
        goto L_0x001e;
    L_0x0025:
        r2 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0025 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.internal.telephony.test.SimulatedGsmCallState.onAnswer():boolean");
    }

    public boolean onHangup() {
        boolean found = false;
        for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo call = this.mCalls[i];
            if (!(call == null || call.mState == State.WAITING)) {
                this.mCalls[i] = null;
                found = true;
            }
        }
        return found;
    }

    public boolean onChld(char c0, char c1) {
        int callIndex = 0;
        if (c1 != '\u0000') {
            callIndex = c1 - 49;
            if (callIndex < 0 || callIndex >= this.mCalls.length) {
                return false;
            }
        }
        switch (c0) {
            case '0':
                return releaseHeldOrUDUB();
            case CallFailCause.QOS_NOT_AVAIL /*49*/:
                if (c1 <= '\u0000') {
                    return releaseActiveAcceptHeldOrWaiting();
                }
                if (this.mCalls[callIndex] == null) {
                    return false;
                }
                this.mCalls[callIndex] = null;
                return true;
            case '2':
                if (c1 <= '\u0000') {
                    return switchActiveAndHeldOrWaiting();
                }
                return separateCall(callIndex);
            case RadioNVItems.RIL_NV_CDMA_PRL_VERSION /*51*/:
                return conference();
            case RadioNVItems.RIL_NV_CDMA_BC10 /*52*/:
                return explicitCallTransfer();
            case RadioNVItems.RIL_NV_CDMA_BC14 /*53*/:
                return false;
            default:
                return false;
        }
    }

    public boolean releaseHeldOrUDUB() {
        int i;
        boolean found = false;
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null && c.isRinging()) {
                found = true;
                this.mCalls[i] = null;
                break;
            }
        }
        if (!found) {
            for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
                c = this.mCalls[i];
                if (c != null && c.mState == State.HOLDING) {
                    this.mCalls[i] = null;
                }
            }
        }
        return true;
    }

    public boolean releaseActiveAcceptHeldOrWaiting() {
        int i;
        boolean foundHeld = false;
        boolean foundActive = false;
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null && c.mState == State.ACTIVE) {
                this.mCalls[i] = null;
                foundActive = true;
            }
        }
        if (!foundActive) {
            for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
                c = this.mCalls[i];
                if (c != null && (c.mState == State.DIALING || c.mState == State.ALERTING)) {
                    this.mCalls[i] = null;
                }
            }
        }
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            c = this.mCalls[i];
            if (c != null && c.mState == State.HOLDING) {
                c.mState = State.ACTIVE;
                foundHeld = true;
            }
        }
        if (!foundHeld) {
            for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
                c = this.mCalls[i];
                if (c != null && c.isRinging()) {
                    c.mState = State.ACTIVE;
                    break;
                }
            }
        }
        return true;
    }

    public boolean switchActiveAndHeldOrWaiting() {
        int i;
        boolean hasHeld = false;
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null && c.mState == State.HOLDING) {
                hasHeld = true;
                break;
            }
        }
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            c = this.mCalls[i];
            if (c != null) {
                if (c.mState == State.ACTIVE) {
                    c.mState = State.HOLDING;
                } else if (c.mState == State.HOLDING) {
                    c.mState = State.ACTIVE;
                } else if (!hasHeld && c.isRinging()) {
                    c.mState = State.ACTIVE;
                }
            }
        }
        return true;
    }

    public boolean separateCall(int index) {
        try {
            CallInfo c = this.mCalls[index];
            if (c == null || c.isConnecting() || countActiveLines() != EVENT_PROGRESS_CALL_STATE) {
                return false;
            }
            c.mState = State.ACTIVE;
            c.mIsMpty = false;
            for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
                int countHeld = 0;
                int lastHeld = 0;
                if (i != index) {
                    CallInfo cb = this.mCalls[i];
                    if (cb != null && cb.mState == State.ACTIVE) {
                        cb.mState = State.HOLDING;
                        countHeld = 0 + EVENT_PROGRESS_CALL_STATE;
                        lastHeld = i;
                    }
                }
                if (countHeld == EVENT_PROGRESS_CALL_STATE) {
                    this.mCalls[lastHeld].mIsMpty = false;
                }
            }
            return true;
        } catch (InvalidStateEx e) {
            return false;
        }
    }

    public boolean conference() {
        int i;
        int countCalls = 0;
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null) {
                countCalls += EVENT_PROGRESS_CALL_STATE;
                if (c.isConnecting()) {
                    return false;
                }
            }
        }
        for (i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            c = this.mCalls[i];
            if (c != null) {
                c.mState = State.ACTIVE;
                if (countCalls > 0) {
                    c.mIsMpty = true;
                }
            }
        }
        return true;
    }

    public boolean explicitCallTransfer() {
        int countCalls = 0;
        for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null) {
                countCalls += EVENT_PROGRESS_CALL_STATE;
                if (c.isConnecting()) {
                    return false;
                }
            }
        }
        return triggerHangupAll();
    }

    public boolean onDial(String address) {
        int freeSlot = -1;
        Rlog.d("GSM", "SC> dial '" + address + "'");
        if (this.mNextDialFailImmediately) {
            this.mNextDialFailImmediately = false;
            Rlog.d("GSM", "SC< dial fail (per request)");
            return false;
        }
        String phNum = PhoneNumberUtils.extractNetworkPortion(address);
        if (phNum.length() == 0) {
            Rlog.d("GSM", "SC< dial fail (invalid ph num)");
            return false;
        } else if (phNum.startsWith("*99") && phNum.endsWith("#")) {
            Rlog.d("GSM", "SC< dial ignored (gprs)");
            return true;
        } else {
            try {
                if (countActiveLines() > EVENT_PROGRESS_CALL_STATE) {
                    Rlog.d("GSM", "SC< dial fail (invalid call state)");
                    return false;
                }
                int i = 0;
                while (i < this.mCalls.length) {
                    if (freeSlot < 0 && this.mCalls[i] == null) {
                        freeSlot = i;
                    }
                    if (this.mCalls[i] == null || this.mCalls[i].isActiveOrHeld()) {
                        if (this.mCalls[i] != null && this.mCalls[i].mState == State.ACTIVE) {
                            this.mCalls[i].mState = State.HOLDING;
                        }
                        i += EVENT_PROGRESS_CALL_STATE;
                    } else {
                        Rlog.d("GSM", "SC< dial fail (invalid call state)");
                        return false;
                    }
                }
                if (freeSlot < 0) {
                    Rlog.d("GSM", "SC< dial fail (invalid call state)");
                    return false;
                }
                this.mCalls[freeSlot] = CallInfo.createOutgoingCall(phNum);
                if (this.mAutoProgressConnecting) {
                    sendMessageDelayed(obtainMessage(EVENT_PROGRESS_CALL_STATE, this.mCalls[freeSlot]), 500);
                }
                Rlog.d("GSM", "SC< dial (slot = " + freeSlot + ")");
                return true;
            } catch (InvalidStateEx e) {
                Rlog.d("GSM", "SC< dial fail (invalid call state)");
                return false;
            }
        }
    }

    public List<DriverCall> getDriverCalls() {
        ArrayList<DriverCall> ret = new ArrayList(this.mCalls.length);
        for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null) {
                ret.add(c.toDriverCall(i + EVENT_PROGRESS_CALL_STATE));
            }
        }
        Rlog.d("GSM", "SC< getDriverCalls " + ret);
        return ret;
    }

    public List<String> getClccLines() {
        ArrayList<String> ret = new ArrayList(this.mCalls.length);
        for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo c = this.mCalls[i];
            if (c != null) {
                ret.add(c.toCLCCLine(i + EVENT_PROGRESS_CALL_STATE));
            }
        }
        return ret;
    }

    private int countActiveLines() throws InvalidStateEx {
        boolean hasMpty = false;
        boolean hasHeld = false;
        boolean hasActive = false;
        boolean hasConnecting = false;
        boolean hasRinging = false;
        boolean mptyIsHeld = false;
        for (int i = 0; i < this.mCalls.length; i += EVENT_PROGRESS_CALL_STATE) {
            CallInfo call = this.mCalls[i];
            if (call != null) {
                int i2;
                if (hasMpty || !call.mIsMpty) {
                    if (call.mIsMpty && mptyIsHeld && call.mState == State.ACTIVE) {
                        Rlog.e("ModelInterpreter", "Invalid state");
                        throw new InvalidStateEx();
                    } else if (!call.mIsMpty && hasMpty && mptyIsHeld && call.mState == State.HOLDING) {
                        Rlog.e("ModelInterpreter", "Invalid state");
                        throw new InvalidStateEx();
                    }
                } else if (call.mState == State.HOLDING) {
                    mptyIsHeld = true;
                } else {
                    mptyIsHeld = false;
                }
                hasMpty |= call.mIsMpty;
                if (call.mState == State.HOLDING) {
                    i2 = EVENT_PROGRESS_CALL_STATE;
                } else {
                    i2 = 0;
                }
                hasHeld |= i2;
                if (call.mState == State.ACTIVE) {
                    i2 = EVENT_PROGRESS_CALL_STATE;
                } else {
                    i2 = 0;
                }
                hasActive |= i2;
                hasConnecting |= call.isConnecting();
                hasRinging |= call.isRinging();
            }
        }
        int ret = 0;
        if (hasHeld) {
            ret = 0 + EVENT_PROGRESS_CALL_STATE;
        }
        if (hasActive) {
            ret += EVENT_PROGRESS_CALL_STATE;
        }
        if (hasConnecting) {
            ret += EVENT_PROGRESS_CALL_STATE;
        }
        if (hasRinging) {
            return ret + EVENT_PROGRESS_CALL_STATE;
        }
        return ret;
    }
}
