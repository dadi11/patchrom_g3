package com.android.server.wm;

import android.os.RemoteException;
import android.view.IApplicationToken;
import android.view.View;
import com.android.server.input.InputApplicationHandle;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.PrintWriter;

class AppWindowToken extends WindowToken {
    final WindowList allAppWindows;
    boolean allDrawn;
    boolean appFullscreen;
    final IApplicationToken appToken;
    boolean clientHidden;
    boolean deferClearAllDrawn;
    boolean firstWindowDrawn;
    int groupId;
    boolean hiddenRequested;
    boolean inPendingTransaction;
    long inputDispatchingTimeoutNanos;
    long lastTransactionSequence;
    boolean layoutConfigChanges;
    final WindowAnimator mAnimator;
    final AppWindowAnimator mAppAnimator;
    boolean mDeferRemoval;
    boolean mEnteringAnimation;
    final InputApplicationHandle mInputApplicationHandle;
    boolean mLaunchTaskBehind;
    int numDrawnWindows;
    int numInterestingWindows;
    boolean removed;
    boolean reportedDrawn;
    boolean reportedVisible;
    int requestedOrientation;
    boolean showWhenLocked;
    StartingData startingData;
    boolean startingDisplayed;
    boolean startingMoved;
    View startingView;
    WindowState startingWindow;
    final boolean voiceInteraction;
    boolean willBeHidden;

    AppWindowToken(WindowManagerService _service, IApplicationToken _token, boolean _voiceInteraction) {
        super(_service, _token.asBinder(), 2, true);
        this.allAppWindows = new WindowList();
        this.groupId = -1;
        this.requestedOrientation = -1;
        this.lastTransactionSequence = Long.MIN_VALUE;
        this.appWindowToken = this;
        this.appToken = _token;
        this.voiceInteraction = _voiceInteraction;
        this.mInputApplicationHandle = new InputApplicationHandle(this);
        this.mAnimator = this.service.mAnimator;
        this.mAppAnimator = new AppWindowAnimator(this);
    }

    void sendAppVisibilityToClients() {
        int N = this.allAppWindows.size();
        for (int i = 0; i < N; i++) {
            WindowState win = (WindowState) this.allAppWindows.get(i);
            if (win != this.startingWindow || !this.clientHidden) {
                try {
                    win.mClient.dispatchAppVisibility(!this.clientHidden);
                } catch (RemoteException e) {
                }
            }
        }
    }

    void updateReportedVisibilityLocked() {
        int i = 1;
        if (this.appToken != null) {
            boolean nowDrawn;
            boolean nowVisible;
            int numInteresting = 0;
            int numVisible = 0;
            int numDrawn = 0;
            boolean nowGone = true;
            int N = this.allAppWindows.size();
            for (int i2 = 0; i2 < N; i2++) {
                WindowState win = (WindowState) this.allAppWindows.get(i2);
                if (!(win == this.startingWindow || win.mAppFreezing || win.mViewVisibility != 0 || win.mAttrs.type == 3 || win.mDestroying)) {
                    numInteresting++;
                    if (win.isDrawnLw()) {
                        numDrawn++;
                        if (!win.mWinAnimator.isAnimating()) {
                            numVisible++;
                        }
                        nowGone = false;
                    } else if (win.mWinAnimator.isAnimating()) {
                        nowGone = false;
                    }
                }
            }
            if (numInteresting <= 0 || numDrawn < numInteresting) {
                nowDrawn = false;
            } else {
                nowDrawn = true;
            }
            if (numInteresting <= 0 || numVisible < numInteresting) {
                nowVisible = false;
            } else {
                nowVisible = true;
            }
            if (!nowGone) {
                if (!nowDrawn) {
                    nowDrawn = this.reportedDrawn;
                }
                if (!nowVisible) {
                    nowVisible = this.reportedVisible;
                }
            }
            if (nowDrawn != this.reportedDrawn) {
                if (nowDrawn) {
                    this.service.mH.sendMessage(this.service.mH.obtainMessage(9, this));
                }
                this.reportedDrawn = nowDrawn;
            }
            if (nowVisible != this.reportedVisible) {
                int i3;
                this.reportedVisible = nowVisible;
                C0569H c0569h = this.service.mH;
                if (nowVisible) {
                    i3 = 1;
                } else {
                    i3 = 0;
                }
                if (!nowGone) {
                    i = 0;
                }
                this.service.mH.sendMessage(c0569h.obtainMessage(8, i3, i, this));
            }
        }
    }

    WindowState findMainWindow() {
        int j = this.windows.size();
        while (j > 0) {
            j--;
            WindowState win = (WindowState) this.windows.get(j);
            if (win.mAttrs.type == 1) {
                return win;
            }
            if (win.mAttrs.type == 3) {
                return win;
            }
        }
        return null;
    }

    boolean isVisible() {
        int N = this.allAppWindows.size();
        for (int i = 0; i < N; i++) {
            WindowState win = (WindowState) this.allAppWindows.get(i);
            if (!win.mAppFreezing && ((win.mViewVisibility == 0 || (win.mWinAnimator.isAnimating() && !this.service.mAppTransition.isTransitionSet())) && !win.mDestroying && win.isDrawnLw())) {
                return true;
            }
        }
        return false;
    }

    void removeAllWindows() {
        int winNdx = this.allAppWindows.size() - 1;
        while (winNdx >= 0) {
            WindowState win = (WindowState) this.allAppWindows.get(winNdx);
            win.mService.removeWindowLocked(win.mSession, win);
            winNdx = Math.min(winNdx - 1, this.allAppWindows.size() - 1);
        }
    }

    void dump(PrintWriter pw, String prefix) {
        super.dump(pw, prefix);
        if (this.appToken != null) {
            pw.print(prefix);
            pw.print("app=true voiceInteraction=");
            pw.println(this.voiceInteraction);
        }
        if (this.allAppWindows.size() > 0) {
            pw.print(prefix);
            pw.print("allAppWindows=");
            pw.println(this.allAppWindows);
        }
        pw.print(prefix);
        pw.print("groupId=");
        pw.print(this.groupId);
        pw.print(" appFullscreen=");
        pw.print(this.appFullscreen);
        pw.print(" requestedOrientation=");
        pw.println(this.requestedOrientation);
        pw.print(prefix);
        pw.print("hiddenRequested=");
        pw.print(this.hiddenRequested);
        pw.print(" clientHidden=");
        pw.print(this.clientHidden);
        pw.print(" willBeHidden=");
        pw.print(this.willBeHidden);
        pw.print(" reportedDrawn=");
        pw.print(this.reportedDrawn);
        pw.print(" reportedVisible=");
        pw.println(this.reportedVisible);
        if (this.paused) {
            pw.print(prefix);
            pw.print("paused=");
            pw.println(this.paused);
        }
        if (this.numInterestingWindows != 0 || this.numDrawnWindows != 0 || this.allDrawn || this.mAppAnimator.allDrawn) {
            pw.print(prefix);
            pw.print("numInterestingWindows=");
            pw.print(this.numInterestingWindows);
            pw.print(" numDrawnWindows=");
            pw.print(this.numDrawnWindows);
            pw.print(" inPendingTransaction=");
            pw.print(this.inPendingTransaction);
            pw.print(" allDrawn=");
            pw.print(this.allDrawn);
            pw.print(" (animator=");
            pw.print(this.mAppAnimator.allDrawn);
            pw.println(")");
        }
        if (this.inPendingTransaction) {
            pw.print(prefix);
            pw.print("inPendingTransaction=");
            pw.println(this.inPendingTransaction);
        }
        if (this.startingData != null || this.removed || this.firstWindowDrawn || this.mDeferRemoval) {
            pw.print(prefix);
            pw.print("startingData=");
            pw.print(this.startingData);
            pw.print(" removed=");
            pw.print(this.removed);
            pw.print(" firstWindowDrawn=");
            pw.print(this.firstWindowDrawn);
            pw.print(" mDeferRemoval=");
            pw.println(this.mDeferRemoval);
        }
        if (this.startingWindow != null || this.startingView != null || this.startingDisplayed || this.startingMoved) {
            pw.print(prefix);
            pw.print("startingWindow=");
            pw.print(this.startingWindow);
            pw.print(" startingView=");
            pw.print(this.startingView);
            pw.print(" startingDisplayed=");
            pw.print(this.startingDisplayed);
            pw.print(" startingMoved");
            pw.println(this.startingMoved);
        }
    }

    public String toString() {
        if (this.stringName == null) {
            StringBuilder sb = new StringBuilder();
            sb.append("AppWindowToken{");
            sb.append(Integer.toHexString(System.identityHashCode(this)));
            sb.append(" token=");
            sb.append(this.token);
            sb.append('}');
            this.stringName = sb.toString();
        }
        return this.stringName;
    }
}
