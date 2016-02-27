package com.android.server.wm;

import android.graphics.Rect;
import android.graphics.Region;
import android.graphics.Region.Op;
import android.util.Slog;
import android.view.Display;
import android.view.DisplayInfo;
import java.io.PrintWriter;
import java.util.ArrayList;

class DisplayContent {
    final boolean isDefaultDisplay;
    boolean layoutNeeded;
    int mBaseDisplayDensity;
    int mBaseDisplayHeight;
    Rect mBaseDisplayRect;
    int mBaseDisplayWidth;
    Rect mContentRect;
    boolean mDeferredRemoval;
    private final Display mDisplay;
    private final int mDisplayId;
    private final DisplayInfo mDisplayInfo;
    final Object mDisplaySizeLock;
    final ArrayList<WindowToken> mExitingTokens;
    private TaskStack mHomeStack;
    int mInitialDisplayDensity;
    int mInitialDisplayHeight;
    int mInitialDisplayWidth;
    final WindowManagerService mService;
    private final ArrayList<TaskStack> mStacks;
    StackTapPointerEventListener mTapDetector;
    Rect mTmpRect;
    final ArrayList<Task> mTmpTaskHistory;
    Region mTouchExcludeRegion;
    private final WindowList mWindows;
    int pendingLayoutChanges;

    DisplayContent(Display display, WindowManagerService service) {
        boolean z = false;
        this.mWindows = new WindowList();
        this.mDisplaySizeLock = new Object();
        this.mInitialDisplayWidth = 0;
        this.mInitialDisplayHeight = 0;
        this.mInitialDisplayDensity = 0;
        this.mBaseDisplayWidth = 0;
        this.mBaseDisplayHeight = 0;
        this.mBaseDisplayDensity = 0;
        this.mDisplayInfo = new DisplayInfo();
        this.mBaseDisplayRect = new Rect();
        this.mContentRect = new Rect();
        this.mExitingTokens = new ArrayList();
        this.mStacks = new ArrayList();
        this.mHomeStack = null;
        this.mTouchExcludeRegion = new Region();
        this.mTmpRect = new Rect();
        this.mTmpTaskHistory = new ArrayList();
        this.mDisplay = display;
        this.mDisplayId = display.getDisplayId();
        display.getDisplayInfo(this.mDisplayInfo);
        if (this.mDisplayId == 0) {
            z = true;
        }
        this.isDefaultDisplay = z;
        this.mService = service;
    }

    int getDisplayId() {
        return this.mDisplayId;
    }

    WindowList getWindowList() {
        return this.mWindows;
    }

    Display getDisplay() {
        return this.mDisplay;
    }

    DisplayInfo getDisplayInfo() {
        return this.mDisplayInfo;
    }

    public boolean hasAccess(int uid) {
        return this.mDisplay.hasAccess(uid);
    }

    public boolean isPrivate() {
        return (this.mDisplay.getFlags() & 4) != 0;
    }

    ArrayList<TaskStack> getStacks() {
        return this.mStacks;
    }

    ArrayList<Task> getTasks() {
        this.mTmpTaskHistory.clear();
        int numStacks = this.mStacks.size();
        for (int stackNdx = 0; stackNdx < numStacks; stackNdx++) {
            this.mTmpTaskHistory.addAll(((TaskStack) this.mStacks.get(stackNdx)).getTasks());
        }
        return this.mTmpTaskHistory;
    }

    TaskStack getHomeStack() {
        if (this.mHomeStack == null && this.mDisplayId == 0) {
            Slog.e("WindowManager", "getHomeStack: Returning null from this=" + this);
        }
        return this.mHomeStack;
    }

    void updateDisplayInfo() {
        this.mDisplay.getDisplayInfo(this.mDisplayInfo);
        for (int i = this.mStacks.size() - 1; i >= 0; i--) {
            ((TaskStack) this.mStacks.get(i)).updateDisplayInfo();
        }
    }

    void getLogicalDisplayRect(Rect out) {
        boolean rotated = true;
        int orientation = this.mDisplayInfo.rotation;
        if (!(orientation == 1 || orientation == 3)) {
            rotated = false;
        }
        int physWidth = rotated ? this.mBaseDisplayHeight : this.mBaseDisplayWidth;
        int physHeight = rotated ? this.mBaseDisplayWidth : this.mBaseDisplayHeight;
        int width = this.mDisplayInfo.logicalWidth;
        int left = (physWidth - width) / 2;
        int height = this.mDisplayInfo.logicalHeight;
        int top = (physHeight - height) / 2;
        out.set(left, top, left + width, top + height);
    }

    void attachStack(TaskStack stack) {
        if (stack.mStackId == 0) {
            if (this.mHomeStack != null) {
                throw new IllegalArgumentException("attachStack: HOME_STACK_ID (0) not first.");
            }
            this.mHomeStack = stack;
        }
        this.mStacks.add(stack);
        this.layoutNeeded = true;
    }

    void moveStack(TaskStack stack, boolean toTop) {
        this.mStacks.remove(stack);
        this.mStacks.add(toTop ? this.mStacks.size() : 0, stack);
    }

    void detachStack(TaskStack stack) {
        this.mStacks.remove(stack);
    }

    void resize(Rect contentRect) {
        this.mContentRect.set(contentRect);
    }

    int stackIdFromPoint(int x, int y) {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            TaskStack stack = (TaskStack) this.mStacks.get(stackNdx);
            stack.getBounds(this.mTmpRect);
            if (this.mTmpRect.contains(x, y)) {
                return stack.mStackId;
            }
        }
        return -1;
    }

    void setTouchExcludeRegion(TaskStack focusedStack) {
        this.mTouchExcludeRegion.set(this.mBaseDisplayRect);
        WindowList windows = getWindowList();
        for (int i = windows.size() - 1; i >= 0; i--) {
            WindowState win = (WindowState) windows.get(i);
            TaskStack stack = win.getStack();
            if (!(!win.isVisibleLw() || stack == null || stack == focusedStack)) {
                this.mTmpRect.set(win.mVisibleFrame);
                this.mTmpRect.intersect(win.mVisibleInsets);
                this.mTouchExcludeRegion.op(this.mTmpRect, Op.DIFFERENCE);
            }
        }
        this.mTapDetector.setTouchExcludeRegion(this.mTouchExcludeRegion);
    }

    void switchUserStacks(int newUserId) {
        WindowList windows = getWindowList();
        for (int i = 0; i < windows.size(); i++) {
            WindowState win = (WindowState) windows.get(i);
            if (win.isHiddenFromUserLocked()) {
                win.hideLw(false);
            }
        }
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ((TaskStack) this.mStacks.get(stackNdx)).switchUser(newUserId);
        }
    }

    void resetAnimationBackgroundAnimator() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ((TaskStack) this.mStacks.get(stackNdx)).resetAnimationBackgroundAnimator();
        }
    }

    boolean animateDimLayers() {
        boolean result = false;
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            result |= ((TaskStack) this.mStacks.get(stackNdx)).animateDimLayers();
        }
        return result;
    }

    void resetDimming() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ((TaskStack) this.mStacks.get(stackNdx)).resetDimmingTag();
        }
    }

    boolean isDimming() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            if (((TaskStack) this.mStacks.get(stackNdx)).isDimming()) {
                return true;
            }
        }
        return false;
    }

    void stopDimmingIfNeeded() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ((TaskStack) this.mStacks.get(stackNdx)).stopDimmingIfNeeded();
        }
    }

    void close() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ((TaskStack) this.mStacks.get(stackNdx)).close();
        }
    }

    boolean isAnimating() {
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            if (((TaskStack) this.mStacks.get(stackNdx)).isAnimating()) {
                return true;
            }
        }
        return false;
    }

    void checkForDeferredActions() {
        boolean animating = false;
        for (int stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            TaskStack stack = (TaskStack) this.mStacks.get(stackNdx);
            if (stack.isAnimating()) {
                animating = true;
            } else {
                if (stack.mDeferDetach) {
                    this.mService.detachStackLocked(this, stack);
                }
                ArrayList<Task> tasks = stack.getTasks();
                for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                    Task task = (Task) tasks.get(taskNdx);
                    AppTokenList tokens = task.mAppTokens;
                    for (int tokenNdx = tokens.size() - 1; tokenNdx >= 0; tokenNdx--) {
                        AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                        if (wtoken.mDeferRemoval) {
                            stack.mExitingAppTokens.remove(wtoken);
                            wtoken.mDeferRemoval = false;
                            this.mService.removeAppFromTaskLocked(wtoken);
                        }
                    }
                    if (task.mDeferRemoval) {
                        task.mDeferRemoval = false;
                        this.mService.removeTaskLocked(task);
                    }
                }
            }
        }
        if (!animating && this.mDeferredRemoval) {
            this.mService.onDisplayRemoved(this.mDisplayId);
        }
    }

    public void dump(String prefix, PrintWriter pw) {
        int stackNdx;
        pw.print(prefix);
        pw.print("Display: mDisplayId=");
        pw.println(this.mDisplayId);
        String subPrefix = "  " + prefix;
        pw.print(subPrefix);
        pw.print("init=");
        pw.print(this.mInitialDisplayWidth);
        pw.print("x");
        pw.print(this.mInitialDisplayHeight);
        pw.print(" ");
        pw.print(this.mInitialDisplayDensity);
        pw.print("dpi");
        if (!(this.mInitialDisplayWidth == this.mBaseDisplayWidth && this.mInitialDisplayHeight == this.mBaseDisplayHeight && this.mInitialDisplayDensity == this.mBaseDisplayDensity)) {
            pw.print(" base=");
            pw.print(this.mBaseDisplayWidth);
            pw.print("x");
            pw.print(this.mBaseDisplayHeight);
            pw.print(" ");
            pw.print(this.mBaseDisplayDensity);
            pw.print("dpi");
        }
        pw.print(" cur=");
        pw.print(this.mDisplayInfo.logicalWidth);
        pw.print("x");
        pw.print(this.mDisplayInfo.logicalHeight);
        pw.print(" app=");
        pw.print(this.mDisplayInfo.appWidth);
        pw.print("x");
        pw.print(this.mDisplayInfo.appHeight);
        pw.print(" rng=");
        pw.print(this.mDisplayInfo.smallestNominalAppWidth);
        pw.print("x");
        pw.print(this.mDisplayInfo.smallestNominalAppHeight);
        pw.print("-");
        pw.print(this.mDisplayInfo.largestNominalAppWidth);
        pw.print("x");
        pw.println(this.mDisplayInfo.largestNominalAppHeight);
        pw.print(subPrefix);
        pw.print("deferred=");
        pw.print(this.mDeferredRemoval);
        pw.print(" layoutNeeded=");
        pw.println(this.layoutNeeded);
        for (stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            TaskStack stack = (TaskStack) this.mStacks.get(stackNdx);
            pw.print(prefix);
            pw.print("mStacks[" + stackNdx + "]");
            pw.println(stack.mStackId);
            stack.dump(prefix + "  ", pw);
        }
        pw.println();
        pw.println("  Application tokens in top down Z order:");
        int ndx = 0;
        for (stackNdx = this.mStacks.size() - 1; stackNdx >= 0; stackNdx--) {
            stack = (TaskStack) this.mStacks.get(stackNdx);
            pw.print("  mStackId=");
            pw.println(stack.mStackId);
            ArrayList<Task> tasks = stack.getTasks();
            for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
                Task task = (Task) tasks.get(taskNdx);
                pw.print("    mTaskId=");
                pw.println(task.taskId);
                AppTokenList tokens = task.mAppTokens;
                int tokenNdx = tokens.size() - 1;
                while (tokenNdx >= 0) {
                    AppWindowToken wtoken = (AppWindowToken) tokens.get(tokenNdx);
                    pw.print("    Activity #");
                    pw.print(tokenNdx);
                    pw.print(' ');
                    pw.print(wtoken);
                    pw.println(":");
                    wtoken.dump(pw, "      ");
                    tokenNdx--;
                    ndx++;
                }
            }
        }
        if (ndx == 0) {
            pw.println("    None");
        }
        pw.println();
        if (!this.mExitingTokens.isEmpty()) {
            pw.println();
            pw.println("  Exiting tokens:");
            for (int i = this.mExitingTokens.size() - 1; i >= 0; i--) {
                WindowToken token = (WindowToken) this.mExitingTokens.get(i);
                pw.print("  Exiting #");
                pw.print(i);
                pw.print(' ');
                pw.print(token);
                pw.println(':');
                token.dump(pw, "    ");
            }
        }
        pw.println();
    }

    public String toString() {
        return "Display " + this.mDisplayId + " info=" + this.mDisplayInfo + " stacks=" + this.mStacks;
    }
}
