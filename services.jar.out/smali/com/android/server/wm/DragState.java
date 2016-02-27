package com.android.server.wm;

import android.content.ClipData;
import android.content.ClipDescription;
import android.graphics.Point;
import android.graphics.Region;
import android.os.IBinder;
import android.os.Process;
import android.os.RemoteException;
import android.util.Slog;
import android.view.Display;
import android.view.DragEvent;
import android.view.InputChannel;
import android.view.SurfaceControl;
import com.android.server.input.InputApplicationHandle;
import com.android.server.input.InputWindowHandle;
import java.util.ArrayList;
import java.util.Iterator;

class DragState {
    InputChannel mClientChannel;
    float mCurrentX;
    float mCurrentY;
    ClipData mData;
    ClipDescription mDataDescription;
    Display mDisplay;
    InputApplicationHandle mDragApplicationHandle;
    boolean mDragInProgress;
    boolean mDragResult;
    InputWindowHandle mDragWindowHandle;
    int mFlags;
    DragInputEventReceiver mInputEventReceiver;
    IBinder mLocalWin;
    ArrayList<WindowState> mNotifiedWindows;
    InputChannel mServerChannel;
    final WindowManagerService mService;
    SurfaceControl mSurfaceControl;
    WindowState mTargetWindow;
    float mThumbOffsetX;
    float mThumbOffsetY;
    private final Region mTmpRegion;
    IBinder mToken;

    DragState(WindowManagerService service, IBinder token, SurfaceControl surface, int flags, IBinder localWin) {
        this.mTmpRegion = new Region();
        this.mService = service;
        this.mToken = token;
        this.mSurfaceControl = surface;
        this.mFlags = flags;
        this.mLocalWin = localWin;
        this.mNotifiedWindows = new ArrayList();
    }

    void reset() {
        if (this.mSurfaceControl != null) {
            this.mSurfaceControl.destroy();
        }
        this.mSurfaceControl = null;
        this.mFlags = 0;
        this.mLocalWin = null;
        this.mToken = null;
        this.mData = null;
        this.mThumbOffsetY = 0.0f;
        this.mThumbOffsetX = 0.0f;
        this.mNotifiedWindows = null;
    }

    void register(Display display) {
        this.mDisplay = display;
        if (this.mClientChannel != null) {
            Slog.e("WindowManager", "Duplicate register of drag input channel");
            return;
        }
        InputChannel[] channels = InputChannel.openInputChannelPair("drag");
        this.mServerChannel = channels[0];
        this.mClientChannel = channels[1];
        this.mService.mInputManager.registerInputChannel(this.mServerChannel, null);
        WindowManagerService windowManagerService = this.mService;
        windowManagerService.getClass();
        this.mInputEventReceiver = new DragInputEventReceiver(this.mClientChannel, this.mService.mH.getLooper());
        this.mDragApplicationHandle = new InputApplicationHandle(null);
        this.mDragApplicationHandle.name = "drag";
        this.mDragApplicationHandle.dispatchingTimeoutNanos = 5000000000L;
        this.mDragWindowHandle = new InputWindowHandle(this.mDragApplicationHandle, null, this.mDisplay.getDisplayId());
        this.mDragWindowHandle.name = "drag";
        this.mDragWindowHandle.inputChannel = this.mServerChannel;
        this.mDragWindowHandle.layer = getDragLayerLw();
        this.mDragWindowHandle.layoutParamsFlags = 0;
        this.mDragWindowHandle.layoutParamsType = 2016;
        this.mDragWindowHandle.dispatchingTimeoutNanos = 5000000000L;
        this.mDragWindowHandle.visible = true;
        this.mDragWindowHandle.canReceiveKeys = false;
        this.mDragWindowHandle.hasFocus = true;
        this.mDragWindowHandle.hasWallpaper = false;
        this.mDragWindowHandle.paused = false;
        this.mDragWindowHandle.ownerPid = Process.myPid();
        this.mDragWindowHandle.ownerUid = Process.myUid();
        this.mDragWindowHandle.inputFeatures = 0;
        this.mDragWindowHandle.scaleFactor = 1.0f;
        this.mDragWindowHandle.touchableRegion.setEmpty();
        this.mDragWindowHandle.frameLeft = 0;
        this.mDragWindowHandle.frameTop = 0;
        Point p = new Point();
        this.mDisplay.getRealSize(p);
        this.mDragWindowHandle.frameRight = p.x;
        this.mDragWindowHandle.frameBottom = p.y;
        this.mService.pauseRotationLocked();
    }

    void unregister() {
        if (this.mClientChannel == null) {
            Slog.e("WindowManager", "Unregister of nonexistent drag input channel");
            return;
        }
        this.mService.mInputManager.unregisterInputChannel(this.mServerChannel);
        this.mInputEventReceiver.dispose();
        this.mInputEventReceiver = null;
        this.mClientChannel.dispose();
        this.mServerChannel.dispose();
        this.mClientChannel = null;
        this.mServerChannel = null;
        this.mDragWindowHandle = null;
        this.mDragApplicationHandle = null;
        this.mService.resumeRotationLocked();
    }

    int getDragLayerLw() {
        return (this.mService.mPolicy.windowTypeToLayerLw(2016) * ProcessList.PSS_TEST_MIN_TIME_FROM_STATE_CHANGE) + ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE;
    }

    void broadcastDragStartedLw(float touchX, float touchY) {
        this.mDataDescription = this.mData != null ? this.mData.getDescription() : null;
        this.mNotifiedWindows.clear();
        this.mDragInProgress = true;
        WindowList windows = this.mService.getWindowListLocked(this.mDisplay);
        if (windows != null) {
            int N = windows.size();
            for (int i = 0; i < N; i++) {
                sendDragStartedLw((WindowState) windows.get(i), touchX, touchY, this.mDataDescription);
            }
        }
    }

    private void sendDragStartedLw(WindowState newWin, float touchX, float touchY, ClipDescription desc) {
        if (((this.mFlags & 1) != 0 || newWin.mClient.asBinder() == this.mLocalWin) && this.mDragInProgress && newWin.isPotentialDragTarget()) {
            DragEvent event = obtainDragEvent(newWin, 1, touchX, touchY, null, desc, null, false);
            try {
                newWin.mClient.dispatchDragEvent(event);
                this.mNotifiedWindows.add(newWin);
                if (Process.myPid() != newWin.mSession.mPid) {
                    event.recycle();
                }
            } catch (RemoteException e) {
                Slog.w("WindowManager", "Unable to drag-start window " + newWin);
                if (Process.myPid() != newWin.mSession.mPid) {
                    event.recycle();
                }
            } catch (Throwable th) {
                if (Process.myPid() != newWin.mSession.mPid) {
                    event.recycle();
                }
            }
        }
    }

    void sendDragStartedIfNeededLw(WindowState newWin) {
        if (this.mDragInProgress) {
            Iterator i$ = this.mNotifiedWindows.iterator();
            while (i$.hasNext()) {
                if (((WindowState) i$.next()) == newWin) {
                    return;
                }
            }
            sendDragStartedLw(newWin, this.mCurrentX, this.mCurrentY, this.mDataDescription);
        }
    }

    void broadcastDragEndedLw() {
        DragEvent evt = DragEvent.obtain(4, 0.0f, 0.0f, null, null, null, this.mDragResult);
        Iterator i$ = this.mNotifiedWindows.iterator();
        while (i$.hasNext()) {
            WindowState ws = (WindowState) i$.next();
            try {
                ws.mClient.dispatchDragEvent(evt);
            } catch (RemoteException e) {
                Slog.w("WindowManager", "Unable to drag-end window " + ws);
            }
        }
        this.mNotifiedWindows.clear();
        this.mDragInProgress = false;
        evt.recycle();
    }

    void endDragLw() {
        this.mService.mDragState.broadcastDragEndedLw();
        this.mService.mDragState.unregister();
        this.mService.mInputMonitor.updateInputWindowsLw(true);
        this.mService.mDragState.reset();
        this.mService.mDragState = null;
    }

    void notifyMoveLw(float x, float y) {
        int myPid = Process.myPid();
        SurfaceControl.openTransaction();
        try {
            this.mSurfaceControl.setPosition(x - this.mThumbOffsetX, y - this.mThumbOffsetY);
            WindowState touchedWin = getTouchedWinAtPointLw(x, y);
            if (touchedWin != null) {
                if ((this.mFlags & 1) == 0 && touchedWin.mClient.asBinder() != this.mLocalWin) {
                    touchedWin = null;
                }
                try {
                    DragEvent evt;
                    if (!(touchedWin == this.mTargetWindow || this.mTargetWindow == null)) {
                        evt = obtainDragEvent(this.mTargetWindow, 6, x, y, null, null, null, false);
                        this.mTargetWindow.mClient.dispatchDragEvent(evt);
                        if (myPid != this.mTargetWindow.mSession.mPid) {
                            evt.recycle();
                        }
                    }
                    if (touchedWin != null) {
                        evt = obtainDragEvent(touchedWin, 2, x, y, null, null, null, false);
                        touchedWin.mClient.dispatchDragEvent(evt);
                        if (myPid != touchedWin.mSession.mPid) {
                            evt.recycle();
                        }
                    }
                } catch (RemoteException e) {
                    Slog.w("WindowManager", "can't send drag notification to windows");
                }
                this.mTargetWindow = touchedWin;
            }
        } finally {
            SurfaceControl.closeTransaction();
        }
    }

    boolean notifyDropLw(float x, float y) {
        WindowState touchedWin = getTouchedWinAtPointLw(x, y);
        if (touchedWin == null) {
            this.mDragResult = false;
            return true;
        }
        int myPid = Process.myPid();
        IBinder token = touchedWin.mClient.asBinder();
        DragEvent evt = obtainDragEvent(touchedWin, 3, x, y, null, null, this.mData, false);
        try {
            touchedWin.mClient.dispatchDragEvent(evt);
            this.mService.mH.removeMessages(21, token);
            this.mService.mH.sendMessageDelayed(this.mService.mH.obtainMessage(21, token), 5000);
            if (myPid != touchedWin.mSession.mPid) {
                evt.recycle();
            }
            this.mToken = token;
            return false;
        } catch (RemoteException e) {
            Slog.w("WindowManager", "can't send drop notification to win " + touchedWin);
            if (myPid == touchedWin.mSession.mPid) {
                return true;
            }
            evt.recycle();
            return true;
        } catch (Throwable th) {
            if (myPid != touchedWin.mSession.mPid) {
                evt.recycle();
            }
        }
    }

    private WindowState getTouchedWinAtPointLw(float xf, float yf) {
        WindowState touchedWin = null;
        int x = (int) xf;
        int y = (int) yf;
        WindowList windows = this.mService.getWindowListLocked(this.mDisplay);
        if (windows == null) {
            return null;
        }
        for (int i = windows.size() - 1; i >= 0; i--) {
            WindowState child = (WindowState) windows.get(i);
            int flags = child.mAttrs.flags;
            if (child.isVisibleLw() && (flags & 16) == 0) {
                child.getTouchableRegion(this.mTmpRegion);
                int touchFlags = flags & 40;
                if (this.mTmpRegion.contains(x, y) || touchFlags == 0) {
                    touchedWin = child;
                    break;
                }
            }
        }
        return touchedWin;
    }

    private static DragEvent obtainDragEvent(WindowState win, int action, float x, float y, Object localState, ClipDescription description, ClipData data, boolean result) {
        float winX = x - ((float) win.mFrame.left);
        float winY = y - ((float) win.mFrame.top);
        if (win.mEnforceSizeCompat) {
            winX *= win.mGlobalScale;
            winY *= win.mGlobalScale;
        }
        return DragEvent.obtain(action, winX, winY, localState, description, data, result);
    }
}
