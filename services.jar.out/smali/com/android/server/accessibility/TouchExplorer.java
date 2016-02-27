package com.android.server.accessibility;

import android.content.Context;
import android.gesture.Gesture;
import android.gesture.GestureLibraries;
import android.gesture.GestureLibrary;
import android.gesture.GesturePoint;
import android.gesture.GestureStroke;
import android.gesture.Prediction;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Handler;
import android.os.SystemClock;
import android.util.Slog;
import android.view.MotionEvent;
import android.view.MotionEvent.PointerCoords;
import android.view.MotionEvent.PointerProperties;
import android.view.VelocityTracker;
import android.view.ViewConfiguration;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;
import com.android.server.job.controllers.JobStatus;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class TouchExplorer implements EventStreamTransformation {
    private static final int ALL_POINTER_ID_BITS = -1;
    private static final int CLICK_LOCATION_ACCESSIBILITY_FOCUS = 1;
    private static final int CLICK_LOCATION_LAST_TOUCH_EXPLORED = 2;
    private static final int CLICK_LOCATION_NONE = 0;
    private static final boolean DEBUG = false;
    private static final int EXIT_GESTURE_DETECTION_TIMEOUT = 2000;
    private static final int GESTURE_DETECTION_VELOCITY_DIP = 1000;
    private static final int INVALID_POINTER_ID = -1;
    private static final String LOG_TAG = "TouchExplorer";
    private static final float MAX_DRAGGING_ANGLE_COS = 0.52532196f;
    private static final int MAX_POINTER_COUNT = 32;
    private static final int MIN_POINTER_DISTANCE_TO_USE_MIDDLE_LOCATION_DIP = 200;
    private static final float MIN_PREDICTION_SCORE = 2.0f;
    private static final int STATE_DELEGATING = 4;
    private static final int STATE_DRAGGING = 2;
    private static final int STATE_GESTURE_DETECTING = 5;
    private static final int STATE_TOUCH_EXPLORING = 1;
    private static final int TOUCH_TOLERANCE = 3;
    private final AccessibilityManagerService mAms;
    private final Context mContext;
    private int mCurrentState;
    private final int mDetermineUserIntentTimeout;
    private final DoubleTapDetector mDoubleTapDetector;
    private final int mDoubleTapSlop;
    private final int mDoubleTapTimeout;
    private int mDraggingPointerId;
    private final ExitGestureDetectionModeDelayed mExitGestureDetectionModeDelayed;
    private GestureLibrary mGestureLibrary;
    private final Handler mHandler;
    private final InjectedPointerTracker mInjectedPointerTracker;
    private int mLastTouchedWindowId;
    private int mLongPressingPointerDeltaX;
    private int mLongPressingPointerDeltaY;
    private int mLongPressingPointerId;
    private EventStreamTransformation mNext;
    private final PerformLongPressDelayed mPerformLongPressDelayed;
    private float mPreviousX;
    private float mPreviousY;
    private final ReceivedPointerTracker mReceivedPointerTracker;
    private final int mScaledGestureDetectionVelocity;
    private final int mScaledMinPointerDistanceToUseMiddleLocation;
    private final SendHoverEnterAndMoveDelayed mSendHoverEnterAndMoveDelayed;
    private final SendHoverExitDelayed mSendHoverExitDelayed;
    private final SendAccessibilityEventDelayed mSendTouchExplorationEndDelayed;
    private final SendAccessibilityEventDelayed mSendTouchInteractionEndDelayed;
    private final ArrayList<GesturePoint> mStrokeBuffer;
    private final int mTapTimeout;
    private final Point mTempPoint;
    private final Rect mTempRect;
    private boolean mTouchExplorationInProgress;
    private final int mTouchSlop;
    private final VelocityTracker mVelocityTracker;

    private class DoubleTapDetector {
        private MotionEvent mDownEvent;
        private MotionEvent mFirstTapEvent;

        private DoubleTapDetector() {
        }

        public void onMotionEvent(MotionEvent event, int policyFlags) {
            int actionIndex = event.getActionIndex();
            switch (event.getActionMasked()) {
                case TouchExplorer.CLICK_LOCATION_NONE /*0*/:
                case TouchExplorer.STATE_GESTURE_DETECTING /*5*/:
                    if (!(this.mFirstTapEvent == null || GestureUtils.isSamePointerContext(this.mFirstTapEvent, event))) {
                        clear();
                    }
                    this.mDownEvent = MotionEvent.obtain(event);
                case TouchExplorer.STATE_TOUCH_EXPLORING /*1*/:
                case C0569H.REMOVE_STARTING /*6*/:
                    if (this.mDownEvent == null) {
                        return;
                    }
                    if (GestureUtils.isSamePointerContext(this.mDownEvent, event)) {
                        if (GestureUtils.isTap(this.mDownEvent, event, TouchExplorer.this.mTapTimeout, TouchExplorer.this.mTouchSlop, actionIndex)) {
                            if (this.mFirstTapEvent == null || GestureUtils.isTimedOut(this.mFirstTapEvent, event, TouchExplorer.this.mDoubleTapTimeout)) {
                                this.mFirstTapEvent = MotionEvent.obtain(event);
                                this.mDownEvent.recycle();
                                this.mDownEvent = null;
                                return;
                            } else if (GestureUtils.isMultiTap(this.mFirstTapEvent, event, TouchExplorer.this.mDoubleTapTimeout, TouchExplorer.this.mDoubleTapSlop, actionIndex)) {
                                onDoubleTap(event, policyFlags);
                                this.mFirstTapEvent.recycle();
                                this.mFirstTapEvent = null;
                                this.mDownEvent.recycle();
                                this.mDownEvent = null;
                                return;
                            } else {
                                this.mFirstTapEvent.recycle();
                                this.mFirstTapEvent = null;
                            }
                        } else if (this.mFirstTapEvent != null) {
                            this.mFirstTapEvent.recycle();
                            this.mFirstTapEvent = null;
                        }
                        this.mDownEvent.recycle();
                        this.mDownEvent = null;
                        return;
                    }
                    clear();
                default:
            }
        }

        public void onDoubleTap(MotionEvent secondTapUp, int policyFlags) {
            if (secondTapUp.getPointerCount() <= TouchExplorer.STATE_DRAGGING) {
                TouchExplorer.this.mSendHoverEnterAndMoveDelayed.cancel();
                TouchExplorer.this.mSendHoverExitDelayed.cancel();
                TouchExplorer.this.mPerformLongPressDelayed.cancel();
                if (TouchExplorer.this.mSendTouchExplorationEndDelayed.isPending()) {
                    TouchExplorer.this.mSendTouchExplorationEndDelayed.forceSendAndRemove();
                }
                if (TouchExplorer.this.mSendTouchInteractionEndDelayed.isPending()) {
                    TouchExplorer.this.mSendTouchInteractionEndDelayed.forceSendAndRemove();
                }
                int pointerIndex = secondTapUp.findPointerIndex(secondTapUp.getPointerId(secondTapUp.getActionIndex()));
                Point clickLocation = TouchExplorer.this.mTempPoint;
                int result = TouchExplorer.this.computeClickLocation(clickLocation);
                if (result != 0) {
                    PointerProperties[] properties = new PointerProperties[TouchExplorer.STATE_TOUCH_EXPLORING];
                    properties[TouchExplorer.CLICK_LOCATION_NONE] = new PointerProperties();
                    secondTapUp.getPointerProperties(pointerIndex, properties[TouchExplorer.CLICK_LOCATION_NONE]);
                    PointerCoords[] coords = new PointerCoords[TouchExplorer.STATE_TOUCH_EXPLORING];
                    coords[TouchExplorer.CLICK_LOCATION_NONE] = new PointerCoords();
                    coords[TouchExplorer.CLICK_LOCATION_NONE].x = (float) clickLocation.x;
                    coords[TouchExplorer.CLICK_LOCATION_NONE].y = (float) clickLocation.y;
                    MotionEvent event = MotionEvent.obtain(secondTapUp.getDownTime(), secondTapUp.getEventTime(), TouchExplorer.CLICK_LOCATION_NONE, TouchExplorer.STATE_TOUCH_EXPLORING, properties, coords, TouchExplorer.CLICK_LOCATION_NONE, TouchExplorer.CLICK_LOCATION_NONE, 1.0f, 1.0f, secondTapUp.getDeviceId(), TouchExplorer.CLICK_LOCATION_NONE, secondTapUp.getSource(), secondTapUp.getFlags());
                    TouchExplorer.this.sendActionDownAndUp(event, policyFlags, result == TouchExplorer.STATE_TOUCH_EXPLORING ? true : TouchExplorer.DEBUG);
                    event.recycle();
                }
            }
        }

        public void clear() {
            if (this.mDownEvent != null) {
                this.mDownEvent.recycle();
                this.mDownEvent = null;
            }
            if (this.mFirstTapEvent != null) {
                this.mFirstTapEvent.recycle();
                this.mFirstTapEvent = null;
            }
        }

        public boolean firstTapDetected() {
            return (this.mFirstTapEvent == null || SystemClock.uptimeMillis() - this.mFirstTapEvent.getEventTime() >= ((long) TouchExplorer.this.mDoubleTapTimeout)) ? TouchExplorer.DEBUG : true;
        }
    }

    private final class ExitGestureDetectionModeDelayed implements Runnable {
        private ExitGestureDetectionModeDelayed() {
        }

        public void post() {
            TouchExplorer.this.mHandler.postDelayed(this, 2000);
        }

        public void cancel() {
            TouchExplorer.this.mHandler.removeCallbacks(this);
        }

        public void run() {
            TouchExplorer.this.sendAccessibilityEvent(524288);
            TouchExplorer.this.sendAccessibilityEvent(DumpState.DUMP_PREFERRED);
            TouchExplorer.this.clear();
        }
    }

    class InjectedPointerTracker {
        private static final String LOG_TAG_INJECTED_POINTER_TRACKER = "InjectedPointerTracker";
        private int mInjectedPointersDown;
        private long mLastInjectedDownEventTime;
        private MotionEvent mLastInjectedHoverEvent;
        private MotionEvent mLastInjectedHoverEventForClick;

        InjectedPointerTracker() {
        }

        public void onMotionEvent(MotionEvent event) {
            switch (event.getActionMasked()) {
                case TouchExplorer.CLICK_LOCATION_NONE /*0*/:
                case TouchExplorer.STATE_GESTURE_DETECTING /*5*/:
                    this.mInjectedPointersDown |= TouchExplorer.STATE_TOUCH_EXPLORING << event.getPointerId(event.getActionIndex());
                    this.mLastInjectedDownEventTime = event.getDownTime();
                case TouchExplorer.STATE_TOUCH_EXPLORING /*1*/:
                case C0569H.REMOVE_STARTING /*6*/:
                    this.mInjectedPointersDown &= (TouchExplorer.STATE_TOUCH_EXPLORING << event.getPointerId(event.getActionIndex())) ^ TouchExplorer.INVALID_POINTER_ID;
                    if (this.mInjectedPointersDown == 0) {
                        this.mLastInjectedDownEventTime = 0;
                    }
                case C0569H.FINISHED_STARTING /*7*/:
                case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                    if (this.mLastInjectedHoverEvent != null) {
                        this.mLastInjectedHoverEvent.recycle();
                    }
                    this.mLastInjectedHoverEvent = MotionEvent.obtain(event);
                    if (this.mLastInjectedHoverEventForClick != null) {
                        this.mLastInjectedHoverEventForClick.recycle();
                    }
                    this.mLastInjectedHoverEventForClick = MotionEvent.obtain(event);
                default:
            }
        }

        public void clear() {
            this.mInjectedPointersDown = TouchExplorer.CLICK_LOCATION_NONE;
        }

        public long getLastInjectedDownEventTime() {
            return this.mLastInjectedDownEventTime;
        }

        public int getInjectedPointerDownCount() {
            return Integer.bitCount(this.mInjectedPointersDown);
        }

        public int getInjectedPointersDown() {
            return this.mInjectedPointersDown;
        }

        public boolean isInjectedPointerDown(int pointerId) {
            if ((this.mInjectedPointersDown & (TouchExplorer.STATE_TOUCH_EXPLORING << pointerId)) != 0) {
                return true;
            }
            return TouchExplorer.DEBUG;
        }

        public MotionEvent getLastInjectedHoverEvent() {
            return this.mLastInjectedHoverEvent;
        }

        public MotionEvent getLastInjectedHoverEventForClick() {
            return this.mLastInjectedHoverEventForClick;
        }

        public String toString() {
            StringBuilder builder = new StringBuilder();
            builder.append("=========================");
            builder.append("\nDown pointers #");
            builder.append(Integer.bitCount(this.mInjectedPointersDown));
            builder.append(" [ ");
            for (int i = TouchExplorer.CLICK_LOCATION_NONE; i < TouchExplorer.MAX_POINTER_COUNT; i += TouchExplorer.STATE_TOUCH_EXPLORING) {
                if ((this.mInjectedPointersDown & i) != 0) {
                    builder.append(i);
                    builder.append(" ");
                }
            }
            builder.append("]");
            builder.append("\n=========================");
            return builder.toString();
        }
    }

    private final class PerformLongPressDelayed implements Runnable {
        private MotionEvent mEvent;
        private int mPolicyFlags;

        private PerformLongPressDelayed() {
        }

        public void post(MotionEvent prototype, int policyFlags) {
            this.mEvent = MotionEvent.obtain(prototype);
            this.mPolicyFlags = policyFlags;
            TouchExplorer.this.mHandler.postDelayed(this, (long) ViewConfiguration.getLongPressTimeout());
        }

        public void cancel() {
            if (this.mEvent != null) {
                TouchExplorer.this.mHandler.removeCallbacks(this);
                clear();
            }
        }

        private boolean isPending() {
            return TouchExplorer.this.mHandler.hasCallbacks(this);
        }

        public void run() {
            if (TouchExplorer.this.mReceivedPointerTracker.getLastReceivedEvent().getPointerCount() != 0) {
                int pointerId = this.mEvent.getPointerId(this.mEvent.getActionIndex());
                int pointerIndex = this.mEvent.findPointerIndex(pointerId);
                Point clickLocation = TouchExplorer.this.mTempPoint;
                if (TouchExplorer.this.computeClickLocation(clickLocation) != 0) {
                    TouchExplorer.this.mLongPressingPointerId = pointerId;
                    TouchExplorer.this.mLongPressingPointerDeltaX = ((int) this.mEvent.getX(pointerIndex)) - clickLocation.x;
                    TouchExplorer.this.mLongPressingPointerDeltaY = ((int) this.mEvent.getY(pointerIndex)) - clickLocation.y;
                    TouchExplorer.this.sendHoverExitAndTouchExplorationGestureEndIfNeeded(this.mPolicyFlags);
                    TouchExplorer.this.mCurrentState = TouchExplorer.STATE_DELEGATING;
                    TouchExplorer.this.sendDownForAllNotInjectedPointers(this.mEvent, this.mPolicyFlags);
                    clear();
                }
            }
        }

        private void clear() {
            this.mEvent.recycle();
            this.mEvent = null;
            this.mPolicyFlags = TouchExplorer.CLICK_LOCATION_NONE;
        }
    }

    class ReceivedPointerTracker {
        private static final String LOG_TAG_RECEIVED_POINTER_TRACKER = "ReceivedPointerTracker";
        private int mLastReceivedDownEdgeFlags;
        private MotionEvent mLastReceivedEvent;
        private long mLastReceivedUpPointerDownTime;
        private float mLastReceivedUpPointerDownX;
        private float mLastReceivedUpPointerDownY;
        private int mPrimaryPointerId;
        private final long[] mReceivedPointerDownTime;
        private final float[] mReceivedPointerDownX;
        private final float[] mReceivedPointerDownY;
        private int mReceivedPointersDown;

        ReceivedPointerTracker() {
            this.mReceivedPointerDownX = new float[TouchExplorer.MAX_POINTER_COUNT];
            this.mReceivedPointerDownY = new float[TouchExplorer.MAX_POINTER_COUNT];
            this.mReceivedPointerDownTime = new long[TouchExplorer.MAX_POINTER_COUNT];
        }

        public void clear() {
            Arrays.fill(this.mReceivedPointerDownX, 0.0f);
            Arrays.fill(this.mReceivedPointerDownY, 0.0f);
            Arrays.fill(this.mReceivedPointerDownTime, 0);
            this.mReceivedPointersDown = TouchExplorer.CLICK_LOCATION_NONE;
            this.mPrimaryPointerId = TouchExplorer.CLICK_LOCATION_NONE;
            this.mLastReceivedUpPointerDownTime = 0;
            this.mLastReceivedUpPointerDownX = 0.0f;
            this.mLastReceivedUpPointerDownY = 0.0f;
        }

        public void onMotionEvent(MotionEvent event) {
            if (this.mLastReceivedEvent != null) {
                this.mLastReceivedEvent.recycle();
            }
            this.mLastReceivedEvent = MotionEvent.obtain(event);
            switch (event.getActionMasked()) {
                case TouchExplorer.CLICK_LOCATION_NONE /*0*/:
                    handleReceivedPointerDown(event.getActionIndex(), event);
                case TouchExplorer.STATE_TOUCH_EXPLORING /*1*/:
                    handleReceivedPointerUp(event.getActionIndex(), event);
                case TouchExplorer.STATE_GESTURE_DETECTING /*5*/:
                    handleReceivedPointerDown(event.getActionIndex(), event);
                case C0569H.REMOVE_STARTING /*6*/:
                    handleReceivedPointerUp(event.getActionIndex(), event);
                default:
            }
        }

        public MotionEvent getLastReceivedEvent() {
            return this.mLastReceivedEvent;
        }

        public int getReceivedPointerDownCount() {
            return Integer.bitCount(this.mReceivedPointersDown);
        }

        public boolean isReceivedPointerDown(int pointerId) {
            if ((this.mReceivedPointersDown & (TouchExplorer.STATE_TOUCH_EXPLORING << pointerId)) != 0) {
                return true;
            }
            return TouchExplorer.DEBUG;
        }

        public float getReceivedPointerDownX(int pointerId) {
            return this.mReceivedPointerDownX[pointerId];
        }

        public float getReceivedPointerDownY(int pointerId) {
            return this.mReceivedPointerDownY[pointerId];
        }

        public long getReceivedPointerDownTime(int pointerId) {
            return this.mReceivedPointerDownTime[pointerId];
        }

        public int getPrimaryPointerId() {
            if (this.mPrimaryPointerId == TouchExplorer.INVALID_POINTER_ID) {
                this.mPrimaryPointerId = findPrimaryPointerId();
            }
            return this.mPrimaryPointerId;
        }

        public long getLastReceivedUpPointerDownTime() {
            return this.mLastReceivedUpPointerDownTime;
        }

        public float getLastReceivedUpPointerDownX() {
            return this.mLastReceivedUpPointerDownX;
        }

        public float getLastReceivedUpPointerDownY() {
            return this.mLastReceivedUpPointerDownY;
        }

        public int getLastReceivedDownEdgeFlags() {
            return this.mLastReceivedDownEdgeFlags;
        }

        private void handleReceivedPointerDown(int pointerIndex, MotionEvent event) {
            int pointerId = event.getPointerId(pointerIndex);
            int pointerFlag = TouchExplorer.STATE_TOUCH_EXPLORING << pointerId;
            this.mLastReceivedUpPointerDownTime = 0;
            this.mLastReceivedUpPointerDownX = 0.0f;
            this.mLastReceivedUpPointerDownX = 0.0f;
            this.mLastReceivedDownEdgeFlags = event.getEdgeFlags();
            this.mReceivedPointersDown |= pointerFlag;
            this.mReceivedPointerDownX[pointerId] = event.getX(pointerIndex);
            this.mReceivedPointerDownY[pointerId] = event.getY(pointerIndex);
            this.mReceivedPointerDownTime[pointerId] = event.getEventTime();
            this.mPrimaryPointerId = pointerId;
        }

        private void handleReceivedPointerUp(int pointerIndex, MotionEvent event) {
            int pointerId = event.getPointerId(pointerIndex);
            int pointerFlag = TouchExplorer.STATE_TOUCH_EXPLORING << pointerId;
            this.mLastReceivedUpPointerDownTime = getReceivedPointerDownTime(pointerId);
            this.mLastReceivedUpPointerDownX = this.mReceivedPointerDownX[pointerId];
            this.mLastReceivedUpPointerDownY = this.mReceivedPointerDownY[pointerId];
            this.mReceivedPointersDown &= pointerFlag ^ TouchExplorer.INVALID_POINTER_ID;
            this.mReceivedPointerDownX[pointerId] = 0.0f;
            this.mReceivedPointerDownY[pointerId] = 0.0f;
            this.mReceivedPointerDownTime[pointerId] = 0;
            if (this.mPrimaryPointerId == pointerId) {
                this.mPrimaryPointerId = TouchExplorer.INVALID_POINTER_ID;
            }
        }

        private int findPrimaryPointerId() {
            int primaryPointerId = TouchExplorer.INVALID_POINTER_ID;
            long minDownTime = JobStatus.NO_LATEST_RUNTIME;
            int pointerIdBits = this.mReceivedPointersDown;
            while (pointerIdBits > 0) {
                int pointerId = Integer.numberOfTrailingZeros(pointerIdBits);
                pointerIdBits &= (TouchExplorer.STATE_TOUCH_EXPLORING << pointerId) ^ TouchExplorer.INVALID_POINTER_ID;
                long downPointerTime = this.mReceivedPointerDownTime[pointerId];
                if (downPointerTime < minDownTime) {
                    minDownTime = downPointerTime;
                    primaryPointerId = pointerId;
                }
            }
            return primaryPointerId;
        }

        public String toString() {
            StringBuilder builder = new StringBuilder();
            builder.append("=========================");
            builder.append("\nDown pointers #");
            builder.append(getReceivedPointerDownCount());
            builder.append(" [ ");
            for (int i = TouchExplorer.CLICK_LOCATION_NONE; i < TouchExplorer.MAX_POINTER_COUNT; i += TouchExplorer.STATE_TOUCH_EXPLORING) {
                if (isReceivedPointerDown(i)) {
                    builder.append(i);
                    builder.append(" ");
                }
            }
            builder.append("]");
            builder.append("\nPrimary pointer id [ ");
            builder.append(getPrimaryPointerId());
            builder.append(" ]");
            builder.append("\n=========================");
            return builder.toString();
        }
    }

    private class SendAccessibilityEventDelayed implements Runnable {
        private final int mDelay;
        private final int mEventType;

        public SendAccessibilityEventDelayed(int eventType, int delay) {
            this.mEventType = eventType;
            this.mDelay = delay;
        }

        public void cancel() {
            TouchExplorer.this.mHandler.removeCallbacks(this);
        }

        public void post() {
            TouchExplorer.this.mHandler.postDelayed(this, (long) this.mDelay);
        }

        public boolean isPending() {
            return TouchExplorer.this.mHandler.hasCallbacks(this);
        }

        public void forceSendAndRemove() {
            if (isPending()) {
                run();
                cancel();
            }
        }

        public void run() {
            TouchExplorer.this.sendAccessibilityEvent(this.mEventType);
        }
    }

    class SendHoverEnterAndMoveDelayed implements Runnable {
        private final String LOG_TAG_SEND_HOVER_DELAYED;
        private final List<MotionEvent> mEvents;
        private int mPointerIdBits;
        private int mPolicyFlags;

        SendHoverEnterAndMoveDelayed() {
            this.LOG_TAG_SEND_HOVER_DELAYED = "SendHoverEnterAndMoveDelayed";
            this.mEvents = new ArrayList();
        }

        public void post(MotionEvent event, boolean touchExplorationInProgress, int pointerIdBits, int policyFlags) {
            cancel();
            addEvent(event);
            this.mPointerIdBits = pointerIdBits;
            this.mPolicyFlags = policyFlags;
            TouchExplorer.this.mHandler.postDelayed(this, (long) TouchExplorer.this.mDetermineUserIntentTimeout);
        }

        public void addEvent(MotionEvent event) {
            this.mEvents.add(MotionEvent.obtain(event));
        }

        public void cancel() {
            if (isPending()) {
                TouchExplorer.this.mHandler.removeCallbacks(this);
                clear();
            }
        }

        private boolean isPending() {
            return TouchExplorer.this.mHandler.hasCallbacks(this);
        }

        private void clear() {
            this.mPointerIdBits = TouchExplorer.INVALID_POINTER_ID;
            this.mPolicyFlags = TouchExplorer.CLICK_LOCATION_NONE;
            for (int i = this.mEvents.size() + TouchExplorer.INVALID_POINTER_ID; i >= 0; i += TouchExplorer.INVALID_POINTER_ID) {
                ((MotionEvent) this.mEvents.remove(i)).recycle();
            }
        }

        public void forceSendAndRemove() {
            if (isPending()) {
                run();
                cancel();
            }
        }

        public void run() {
            TouchExplorer.this.sendAccessibilityEvent(DumpState.DUMP_PREFERRED);
            if (!this.mEvents.isEmpty()) {
                TouchExplorer.this.sendMotionEvent((MotionEvent) this.mEvents.get(TouchExplorer.CLICK_LOCATION_NONE), 9, this.mPointerIdBits, this.mPolicyFlags);
                int eventCount = this.mEvents.size();
                for (int i = TouchExplorer.STATE_TOUCH_EXPLORING; i < eventCount; i += TouchExplorer.STATE_TOUCH_EXPLORING) {
                    TouchExplorer.this.sendMotionEvent((MotionEvent) this.mEvents.get(i), 7, this.mPointerIdBits, this.mPolicyFlags);
                }
            }
            clear();
        }
    }

    class SendHoverExitDelayed implements Runnable {
        private final String LOG_TAG_SEND_HOVER_DELAYED;
        private int mPointerIdBits;
        private int mPolicyFlags;
        private MotionEvent mPrototype;

        SendHoverExitDelayed() {
            this.LOG_TAG_SEND_HOVER_DELAYED = "SendHoverExitDelayed";
        }

        public void post(MotionEvent prototype, int pointerIdBits, int policyFlags) {
            cancel();
            this.mPrototype = MotionEvent.obtain(prototype);
            this.mPointerIdBits = pointerIdBits;
            this.mPolicyFlags = policyFlags;
            TouchExplorer.this.mHandler.postDelayed(this, (long) TouchExplorer.this.mDetermineUserIntentTimeout);
        }

        public void cancel() {
            if (isPending()) {
                TouchExplorer.this.mHandler.removeCallbacks(this);
                clear();
            }
        }

        private boolean isPending() {
            return TouchExplorer.this.mHandler.hasCallbacks(this);
        }

        private void clear() {
            this.mPrototype.recycle();
            this.mPrototype = null;
            this.mPointerIdBits = TouchExplorer.INVALID_POINTER_ID;
            this.mPolicyFlags = TouchExplorer.CLICK_LOCATION_NONE;
        }

        public void forceSendAndRemove() {
            if (isPending()) {
                run();
                cancel();
            }
        }

        public void run() {
            TouchExplorer.this.sendMotionEvent(this.mPrototype, 10, this.mPointerIdBits, this.mPolicyFlags);
            if (!TouchExplorer.this.mSendTouchExplorationEndDelayed.isPending()) {
                TouchExplorer.this.mSendTouchExplorationEndDelayed.cancel();
                TouchExplorer.this.mSendTouchExplorationEndDelayed.post();
            }
            if (TouchExplorer.this.mSendTouchInteractionEndDelayed.isPending()) {
                TouchExplorer.this.mSendTouchInteractionEndDelayed.cancel();
                TouchExplorer.this.mSendTouchInteractionEndDelayed.post();
            }
            clear();
        }
    }

    public TouchExplorer(Context context, AccessibilityManagerService service) {
        this.mCurrentState = STATE_TOUCH_EXPLORING;
        this.mVelocityTracker = VelocityTracker.obtain();
        this.mTempRect = new Rect();
        this.mTempPoint = new Point();
        this.mStrokeBuffer = new ArrayList(100);
        this.mLongPressingPointerId = INVALID_POINTER_ID;
        this.mContext = context;
        this.mAms = service;
        this.mReceivedPointerTracker = new ReceivedPointerTracker();
        this.mInjectedPointerTracker = new InjectedPointerTracker();
        this.mTapTimeout = ViewConfiguration.getTapTimeout();
        this.mDetermineUserIntentTimeout = ViewConfiguration.getDoubleTapTimeout();
        this.mDoubleTapTimeout = ViewConfiguration.getDoubleTapTimeout();
        this.mTouchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
        this.mDoubleTapSlop = ViewConfiguration.get(context).getScaledDoubleTapSlop();
        this.mHandler = new Handler(context.getMainLooper());
        this.mPerformLongPressDelayed = new PerformLongPressDelayed();
        this.mExitGestureDetectionModeDelayed = new ExitGestureDetectionModeDelayed();
        this.mGestureLibrary = GestureLibraries.fromRawResource(context, 17825794);
        this.mGestureLibrary.setOrientationStyle(8);
        this.mGestureLibrary.setSequenceType(STATE_DRAGGING);
        this.mGestureLibrary.load();
        this.mSendHoverEnterAndMoveDelayed = new SendHoverEnterAndMoveDelayed();
        this.mSendHoverExitDelayed = new SendHoverExitDelayed();
        this.mSendTouchExplorationEndDelayed = new SendAccessibilityEventDelayed(DumpState.DUMP_PREFERRED_XML, this.mDetermineUserIntentTimeout);
        this.mSendTouchInteractionEndDelayed = new SendAccessibilityEventDelayed(2097152, this.mDetermineUserIntentTimeout);
        this.mDoubleTapDetector = new DoubleTapDetector();
        float density = context.getResources().getDisplayMetrics().density;
        this.mScaledMinPointerDistanceToUseMiddleLocation = (int) (200.0f * density);
        this.mScaledGestureDetectionVelocity = (int) (1000.0f * density);
    }

    public void clear() {
        if (this.mReceivedPointerTracker.getLastReceivedEvent() != null) {
            clear(this.mReceivedPointerTracker.getLastReceivedEvent(), 33554432);
        }
    }

    public void onDestroy() {
    }

    private void clear(MotionEvent event, int policyFlags) {
        switch (this.mCurrentState) {
            case STATE_TOUCH_EXPLORING /*1*/:
                sendHoverExitAndTouchExplorationGestureEndIfNeeded(policyFlags);
                break;
            case STATE_DRAGGING /*2*/:
                this.mDraggingPointerId = INVALID_POINTER_ID;
                sendUpForInjectedDownPointers(event, policyFlags);
                break;
            case STATE_DELEGATING /*4*/:
                sendUpForInjectedDownPointers(event, policyFlags);
                break;
            case STATE_GESTURE_DETECTING /*5*/:
                this.mStrokeBuffer.clear();
                break;
        }
        this.mSendHoverEnterAndMoveDelayed.cancel();
        this.mSendHoverExitDelayed.cancel();
        this.mPerformLongPressDelayed.cancel();
        this.mExitGestureDetectionModeDelayed.cancel();
        this.mSendTouchExplorationEndDelayed.cancel();
        this.mSendTouchInteractionEndDelayed.cancel();
        this.mReceivedPointerTracker.clear();
        this.mInjectedPointerTracker.clear();
        this.mDoubleTapDetector.clear();
        this.mLongPressingPointerId = INVALID_POINTER_ID;
        this.mLongPressingPointerDeltaX = CLICK_LOCATION_NONE;
        this.mLongPressingPointerDeltaY = CLICK_LOCATION_NONE;
        this.mCurrentState = STATE_TOUCH_EXPLORING;
        if (this.mNext != null) {
            this.mNext.clear();
        }
        this.mTouchExplorationInProgress = DEBUG;
        this.mAms.onTouchInteractionEnd();
    }

    public void setNext(EventStreamTransformation next) {
        this.mNext = next;
    }

    public void onMotionEvent(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
        this.mReceivedPointerTracker.onMotionEvent(rawEvent);
        switch (this.mCurrentState) {
            case STATE_TOUCH_EXPLORING /*1*/:
                handleMotionEventStateTouchExploring(event, rawEvent, policyFlags);
            case STATE_DRAGGING /*2*/:
                handleMotionEventStateDragging(event, policyFlags);
            case STATE_DELEGATING /*4*/:
                handleMotionEventStateDelegating(event, policyFlags);
            case STATE_GESTURE_DETECTING /*5*/:
                handleMotionEventGestureDetecting(rawEvent, policyFlags);
            default:
                throw new IllegalStateException("Illegal state: " + this.mCurrentState);
        }
    }

    public void onAccessibilityEvent(AccessibilityEvent event) {
        int eventType = event.getEventType();
        if (this.mSendTouchExplorationEndDelayed.isPending() && eventType == DumpState.DUMP_VERIFIERS) {
            this.mSendTouchExplorationEndDelayed.cancel();
            sendAccessibilityEvent(DumpState.DUMP_PREFERRED_XML);
        }
        if (this.mSendTouchInteractionEndDelayed.isPending() && eventType == DumpState.DUMP_VERIFIERS) {
            this.mSendTouchInteractionEndDelayed.cancel();
            sendAccessibilityEvent(2097152);
        }
        switch (eventType) {
            case MAX_POINTER_COUNT /*32*/:
            case 32768:
                if (this.mInjectedPointerTracker.mLastInjectedHoverEventForClick != null) {
                    this.mInjectedPointerTracker.mLastInjectedHoverEventForClick.recycle();
                    this.mInjectedPointerTracker.mLastInjectedHoverEventForClick = null;
                }
                this.mLastTouchedWindowId = INVALID_POINTER_ID;
                break;
            case DumpState.DUMP_PROVIDERS /*128*/:
            case DumpState.DUMP_VERIFIERS /*256*/:
                this.mLastTouchedWindowId = event.getWindowId();
                break;
        }
        if (this.mNext != null) {
            this.mNext.onAccessibilityEvent(event);
        }
    }

    private void handleMotionEventStateTouchExploring(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
        ReceivedPointerTracker receivedTracker = this.mReceivedPointerTracker;
        this.mVelocityTracker.addMovement(rawEvent);
        this.mDoubleTapDetector.onMotionEvent(event, policyFlags);
        int pointerIdBits;
        switch (event.getActionMasked()) {
            case CLICK_LOCATION_NONE /*0*/:
                this.mAms.onTouchInteractionStart();
                handleMotionEventGestureDetecting(rawEvent, policyFlags);
                sendAccessibilityEvent(1048576);
                this.mSendHoverEnterAndMoveDelayed.cancel();
                this.mSendHoverExitDelayed.cancel();
                this.mPerformLongPressDelayed.cancel();
                if (this.mSendTouchExplorationEndDelayed.isPending()) {
                    this.mSendTouchExplorationEndDelayed.forceSendAndRemove();
                }
                if (this.mSendTouchInteractionEndDelayed.isPending()) {
                    this.mSendTouchInteractionEndDelayed.forceSendAndRemove();
                }
                if (this.mDoubleTapDetector.firstTapDetected()) {
                    this.mPerformLongPressDelayed.post(event, policyFlags);
                } else if (!this.mTouchExplorationInProgress) {
                    if (this.mSendHoverEnterAndMoveDelayed.isPending()) {
                        this.mSendHoverEnterAndMoveDelayed.addEvent(event);
                        return;
                    }
                    this.mSendHoverEnterAndMoveDelayed.post(event, true, STATE_TOUCH_EXPLORING << receivedTracker.getPrimaryPointerId(), policyFlags);
                }
            case STATE_TOUCH_EXPLORING /*1*/:
                this.mAms.onTouchInteractionEnd();
                this.mStrokeBuffer.clear();
                pointerIdBits = STATE_TOUCH_EXPLORING << event.getPointerId(event.getActionIndex());
                this.mPerformLongPressDelayed.cancel();
                this.mVelocityTracker.clear();
                if (this.mSendHoverEnterAndMoveDelayed.isPending()) {
                    this.mSendHoverExitDelayed.post(event, pointerIdBits, policyFlags);
                } else {
                    sendHoverExitAndTouchExplorationGestureEndIfNeeded(policyFlags);
                }
                if (!this.mSendTouchInteractionEndDelayed.isPending()) {
                    this.mSendTouchInteractionEndDelayed.post();
                }
            case STATE_DRAGGING /*2*/:
                int pointerId = receivedTracker.getPrimaryPointerId();
                int pointerIndex = event.findPointerIndex(pointerId);
                pointerIdBits = STATE_TOUCH_EXPLORING << pointerId;
                switch (event.getPointerCount()) {
                    case STATE_TOUCH_EXPLORING /*1*/:
                        if (this.mSendHoverEnterAndMoveDelayed.isPending()) {
                            handleMotionEventGestureDetecting(rawEvent, policyFlags);
                            this.mSendHoverEnterAndMoveDelayed.addEvent(event);
                            if (Math.hypot((double) (receivedTracker.getReceivedPointerDownX(pointerId) - rawEvent.getX(pointerIndex)), (double) (receivedTracker.getReceivedPointerDownY(pointerId) - rawEvent.getY(pointerIndex))) > ((double) this.mDoubleTapSlop)) {
                                this.mVelocityTracker.computeCurrentVelocity(GESTURE_DETECTION_VELOCITY_DIP);
                                if (Math.max(Math.abs(this.mVelocityTracker.getXVelocity(pointerId)), Math.abs(this.mVelocityTracker.getYVelocity(pointerId))) > ((float) this.mScaledGestureDetectionVelocity)) {
                                    this.mCurrentState = STATE_GESTURE_DETECTING;
                                    this.mVelocityTracker.clear();
                                    this.mSendHoverEnterAndMoveDelayed.cancel();
                                    this.mSendHoverExitDelayed.cancel();
                                    this.mPerformLongPressDelayed.cancel();
                                    this.mExitGestureDetectionModeDelayed.post();
                                    sendAccessibilityEvent(262144);
                                    return;
                                }
                                this.mSendHoverEnterAndMoveDelayed.forceSendAndRemove();
                                this.mSendHoverExitDelayed.cancel();
                                this.mPerformLongPressDelayed.cancel();
                                sendMotionEvent(event, 7, pointerIdBits, policyFlags);
                                return;
                            }
                            return;
                        }
                        if (this.mPerformLongPressDelayed.isPending()) {
                            if (Math.hypot((double) (receivedTracker.getReceivedPointerDownX(pointerId) - rawEvent.getX(pointerIndex)), (double) (receivedTracker.getReceivedPointerDownY(pointerId) - rawEvent.getY(pointerIndex))) > ((double) this.mTouchSlop)) {
                                this.mPerformLongPressDelayed.cancel();
                            }
                        }
                        if (this.mTouchExplorationInProgress) {
                            sendTouchExplorationGestureStartAndHoverEnterIfNeeded(policyFlags);
                            sendMotionEvent(event, 7, pointerIdBits, policyFlags);
                        }
                    case STATE_DRAGGING /*2*/:
                        if (this.mSendHoverEnterAndMoveDelayed.isPending()) {
                            this.mSendHoverEnterAndMoveDelayed.cancel();
                            this.mSendHoverExitDelayed.cancel();
                            this.mPerformLongPressDelayed.cancel();
                        } else {
                            this.mPerformLongPressDelayed.cancel();
                            if (this.mTouchExplorationInProgress) {
                                if (Math.hypot((double) (receivedTracker.getReceivedPointerDownX(pointerId) - rawEvent.getX(pointerIndex)), (double) (receivedTracker.getReceivedPointerDownY(pointerId) - rawEvent.getY(pointerIndex))) >= ((double) this.mDoubleTapSlop)) {
                                    sendHoverExitAndTouchExplorationGestureEndIfNeeded(policyFlags);
                                } else {
                                    return;
                                }
                            }
                        }
                        this.mStrokeBuffer.clear();
                        if (isDraggingGesture(event)) {
                            this.mCurrentState = STATE_DRAGGING;
                            this.mDraggingPointerId = pointerId;
                            event.setEdgeFlags(receivedTracker.getLastReceivedDownEdgeFlags());
                            sendMotionEvent(event, CLICK_LOCATION_NONE, pointerIdBits, policyFlags);
                        } else {
                            this.mCurrentState = STATE_DELEGATING;
                            sendDownForAllNotInjectedPointers(event, policyFlags);
                        }
                        this.mVelocityTracker.clear();
                    default:
                        if (this.mSendHoverEnterAndMoveDelayed.isPending()) {
                            this.mSendHoverEnterAndMoveDelayed.cancel();
                            this.mSendHoverExitDelayed.cancel();
                            this.mPerformLongPressDelayed.cancel();
                        } else {
                            this.mPerformLongPressDelayed.cancel();
                            sendHoverExitAndTouchExplorationGestureEndIfNeeded(policyFlags);
                        }
                        this.mCurrentState = STATE_DELEGATING;
                        sendDownForAllNotInjectedPointers(event, policyFlags);
                        this.mVelocityTracker.clear();
                }
            case TOUCH_TOLERANCE /*3*/:
                clear(event, policyFlags);
            case STATE_GESTURE_DETECTING /*5*/:
                this.mSendHoverEnterAndMoveDelayed.cancel();
                this.mSendHoverExitDelayed.cancel();
                this.mPerformLongPressDelayed.cancel();
            default:
        }
    }

    private void handleMotionEventStateDragging(MotionEvent event, int policyFlags) {
        int pointerIdBits = STATE_TOUCH_EXPLORING << this.mDraggingPointerId;
        switch (event.getActionMasked()) {
            case CLICK_LOCATION_NONE /*0*/:
                throw new IllegalStateException("Dragging state can be reached only if two pointers are already down");
            case STATE_TOUCH_EXPLORING /*1*/:
                this.mAms.onTouchInteractionEnd();
                sendAccessibilityEvent(2097152);
                if (event.getPointerId(event.getActionIndex()) == this.mDraggingPointerId) {
                    this.mDraggingPointerId = INVALID_POINTER_ID;
                    sendMotionEvent(event, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
                }
                this.mCurrentState = STATE_TOUCH_EXPLORING;
            case STATE_DRAGGING /*2*/:
                switch (event.getPointerCount()) {
                    case STATE_TOUCH_EXPLORING /*1*/:
                    case STATE_DRAGGING /*2*/:
                        if (isDraggingGesture(event)) {
                            float firstPtrX = event.getX(CLICK_LOCATION_NONE);
                            float firstPtrY = event.getY(CLICK_LOCATION_NONE);
                            float deltaX = firstPtrX - event.getX(STATE_TOUCH_EXPLORING);
                            float deltaY = firstPtrY - event.getY(STATE_TOUCH_EXPLORING);
                            if (Math.hypot((double) deltaX, (double) deltaY) > ((double) this.mScaledMinPointerDistanceToUseMiddleLocation)) {
                                event.setLocation(deltaX / MIN_PREDICTION_SCORE, deltaY / MIN_PREDICTION_SCORE);
                            }
                            sendMotionEvent(event, STATE_DRAGGING, pointerIdBits, policyFlags);
                            return;
                        }
                        this.mCurrentState = STATE_DELEGATING;
                        sendMotionEvent(event, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
                        sendDownForAllNotInjectedPointers(event, policyFlags);
                    default:
                        this.mCurrentState = STATE_DELEGATING;
                        sendMotionEvent(event, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
                        sendDownForAllNotInjectedPointers(event, policyFlags);
                }
            case TOUCH_TOLERANCE /*3*/:
                clear(event, policyFlags);
            case STATE_GESTURE_DETECTING /*5*/:
                this.mCurrentState = STATE_DELEGATING;
                if (this.mDraggingPointerId != INVALID_POINTER_ID) {
                    sendMotionEvent(event, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
                }
                sendDownForAllNotInjectedPointers(event, policyFlags);
            case C0569H.REMOVE_STARTING /*6*/:
                if (event.getPointerId(event.getActionIndex()) == this.mDraggingPointerId) {
                    this.mDraggingPointerId = INVALID_POINTER_ID;
                    sendMotionEvent(event, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
                }
            default:
        }
    }

    private void handleMotionEventStateDelegating(MotionEvent event, int policyFlags) {
        switch (event.getActionMasked()) {
            case CLICK_LOCATION_NONE /*0*/:
                throw new IllegalStateException("Delegating state can only be reached if there is at least one pointer down!");
            case STATE_TOUCH_EXPLORING /*1*/:
                if (this.mLongPressingPointerId >= 0) {
                    event = offsetEvent(event, -this.mLongPressingPointerDeltaX, -this.mLongPressingPointerDeltaY);
                    this.mLongPressingPointerId = INVALID_POINTER_ID;
                    this.mLongPressingPointerDeltaX = CLICK_LOCATION_NONE;
                    this.mLongPressingPointerDeltaY = CLICK_LOCATION_NONE;
                }
                sendMotionEvent(event, event.getAction(), INVALID_POINTER_ID, policyFlags);
                this.mAms.onTouchInteractionEnd();
                sendAccessibilityEvent(2097152);
                this.mCurrentState = STATE_TOUCH_EXPLORING;
            case TOUCH_TOLERANCE /*3*/:
                clear(event, policyFlags);
            default:
                sendMotionEvent(event, event.getAction(), INVALID_POINTER_ID, policyFlags);
        }
    }

    private void handleMotionEventGestureDetecting(MotionEvent event, int policyFlags) {
        float x;
        float y;
        switch (event.getActionMasked()) {
            case CLICK_LOCATION_NONE /*0*/:
                x = event.getX();
                y = event.getY();
                this.mPreviousX = x;
                this.mPreviousY = y;
                this.mStrokeBuffer.add(new GesturePoint(x, y, event.getEventTime()));
            case STATE_TOUCH_EXPLORING /*1*/:
                this.mAms.onTouchInteractionEnd();
                sendAccessibilityEvent(524288);
                sendAccessibilityEvent(2097152);
                this.mStrokeBuffer.add(new GesturePoint(event.getX(), event.getY(), event.getEventTime()));
                Gesture gesture = new Gesture();
                gesture.addStroke(new GestureStroke(this.mStrokeBuffer));
                ArrayList<Prediction> predictions = this.mGestureLibrary.recognize(gesture);
                if (!predictions.isEmpty()) {
                    Prediction bestPrediction = (Prediction) predictions.get(CLICK_LOCATION_NONE);
                    if (bestPrediction.score >= 2.0d) {
                        try {
                            this.mAms.onGesture(Integer.parseInt(bestPrediction.name));
                        } catch (NumberFormatException e) {
                            Slog.w(LOG_TAG, "Non numeric gesture id:" + bestPrediction.name);
                        }
                    }
                }
                this.mStrokeBuffer.clear();
                this.mExitGestureDetectionModeDelayed.cancel();
                this.mCurrentState = STATE_TOUCH_EXPLORING;
            case STATE_DRAGGING /*2*/:
                x = event.getX();
                y = event.getY();
                float dX = Math.abs(x - this.mPreviousX);
                float dY = Math.abs(y - this.mPreviousY);
                if (dX >= 3.0f || dY >= 3.0f) {
                    this.mPreviousX = x;
                    this.mPreviousY = y;
                    this.mStrokeBuffer.add(new GesturePoint(x, y, event.getEventTime()));
                }
            case TOUCH_TOLERANCE /*3*/:
                clear(event, policyFlags);
            default:
        }
    }

    private void sendAccessibilityEvent(int type) {
        AccessibilityManager accessibilityManager = AccessibilityManager.getInstance(this.mContext);
        if (accessibilityManager.isEnabled()) {
            AccessibilityEvent event = AccessibilityEvent.obtain(type);
            event.setWindowId(this.mAms.getActiveWindowId());
            accessibilityManager.sendAccessibilityEvent(event);
            switch (type) {
                case DumpState.DUMP_PREFERRED /*512*/:
                    this.mTouchExplorationInProgress = true;
                case DumpState.DUMP_PREFERRED_XML /*1024*/:
                    this.mTouchExplorationInProgress = DEBUG;
                default:
            }
        }
    }

    private void sendDownForAllNotInjectedPointers(MotionEvent prototype, int policyFlags) {
        InjectedPointerTracker injectedPointers = this.mInjectedPointerTracker;
        int pointerIdBits = CLICK_LOCATION_NONE;
        int pointerCount = prototype.getPointerCount();
        for (int i = CLICK_LOCATION_NONE; i < pointerCount; i += STATE_TOUCH_EXPLORING) {
            int pointerId = prototype.getPointerId(i);
            if (!injectedPointers.isInjectedPointerDown(pointerId)) {
                pointerIdBits |= STATE_TOUCH_EXPLORING << pointerId;
                sendMotionEvent(prototype, computeInjectionAction(CLICK_LOCATION_NONE, i), pointerIdBits, policyFlags);
            }
        }
    }

    private void sendHoverExitAndTouchExplorationGestureEndIfNeeded(int policyFlags) {
        MotionEvent event = this.mInjectedPointerTracker.getLastInjectedHoverEvent();
        if (event != null && event.getActionMasked() != 10) {
            int pointerIdBits = event.getPointerIdBits();
            if (!this.mSendTouchExplorationEndDelayed.isPending()) {
                this.mSendTouchExplorationEndDelayed.post();
            }
            sendMotionEvent(event, 10, pointerIdBits, policyFlags);
        }
    }

    private void sendTouchExplorationGestureStartAndHoverEnterIfNeeded(int policyFlags) {
        MotionEvent event = this.mInjectedPointerTracker.getLastInjectedHoverEvent();
        if (event != null && event.getActionMasked() == 10) {
            int pointerIdBits = event.getPointerIdBits();
            sendAccessibilityEvent(DumpState.DUMP_PREFERRED);
            sendMotionEvent(event, 9, pointerIdBits, policyFlags);
        }
    }

    private void sendUpForInjectedDownPointers(MotionEvent prototype, int policyFlags) {
        InjectedPointerTracker injectedTracked = this.mInjectedPointerTracker;
        int pointerIdBits = CLICK_LOCATION_NONE;
        int pointerCount = prototype.getPointerCount();
        for (int i = CLICK_LOCATION_NONE; i < pointerCount; i += STATE_TOUCH_EXPLORING) {
            int pointerId = prototype.getPointerId(i);
            if (injectedTracked.isInjectedPointerDown(pointerId)) {
                pointerIdBits |= STATE_TOUCH_EXPLORING << pointerId;
                sendMotionEvent(prototype, computeInjectionAction(STATE_TOUCH_EXPLORING, i), pointerIdBits, policyFlags);
            }
        }
    }

    private void sendActionDownAndUp(MotionEvent prototype, int policyFlags, boolean targetAccessibilityFocus) {
        int pointerIdBits = STATE_TOUCH_EXPLORING << prototype.getPointerId(prototype.getActionIndex());
        prototype.setTargetAccessibilityFocus(targetAccessibilityFocus);
        sendMotionEvent(prototype, CLICK_LOCATION_NONE, pointerIdBits, policyFlags);
        prototype.setTargetAccessibilityFocus(targetAccessibilityFocus);
        sendMotionEvent(prototype, STATE_TOUCH_EXPLORING, pointerIdBits, policyFlags);
    }

    private void sendMotionEvent(MotionEvent prototype, int action, int pointerIdBits, int policyFlags) {
        MotionEvent event;
        prototype.setAction(action);
        if (pointerIdBits == INVALID_POINTER_ID) {
            event = prototype;
        } else {
            event = prototype.split(pointerIdBits);
        }
        if (action == 0) {
            event.setDownTime(event.getEventTime());
        } else {
            event.setDownTime(this.mInjectedPointerTracker.getLastInjectedDownEventTime());
        }
        if (this.mLongPressingPointerId >= 0) {
            event = offsetEvent(event, -this.mLongPressingPointerDeltaX, -this.mLongPressingPointerDeltaY);
        }
        policyFlags |= 1073741824;
        if (this.mNext != null) {
            this.mNext.onMotionEvent(event, null, policyFlags);
        }
        this.mInjectedPointerTracker.onMotionEvent(event);
        if (event != prototype) {
            event.recycle();
        }
    }

    private MotionEvent offsetEvent(MotionEvent event, int offsetX, int offsetY) {
        if (offsetX == 0 && offsetY == 0) {
            return event;
        }
        int remappedIndex = event.findPointerIndex(this.mLongPressingPointerId);
        int pointerCount = event.getPointerCount();
        PointerProperties[] props = PointerProperties.createArray(pointerCount);
        PointerCoords[] coords = PointerCoords.createArray(pointerCount);
        for (int i = CLICK_LOCATION_NONE; i < pointerCount; i += STATE_TOUCH_EXPLORING) {
            event.getPointerProperties(i, props[i]);
            event.getPointerCoords(i, coords[i]);
            if (i == remappedIndex) {
                PointerCoords pointerCoords = coords[i];
                pointerCoords.x += (float) offsetX;
                pointerCoords = coords[i];
                pointerCoords.y += (float) offsetY;
            }
        }
        return MotionEvent.obtain(event.getDownTime(), event.getEventTime(), event.getAction(), event.getPointerCount(), props, coords, event.getMetaState(), event.getButtonState(), 1.0f, 1.0f, event.getDeviceId(), event.getEdgeFlags(), event.getSource(), event.getFlags());
    }

    private int computeInjectionAction(int actionMasked, int pointerIndex) {
        switch (actionMasked) {
            case CLICK_LOCATION_NONE /*0*/:
            case STATE_GESTURE_DETECTING /*5*/:
                if (this.mInjectedPointerTracker.getInjectedPointerDownCount() == 0) {
                    return CLICK_LOCATION_NONE;
                }
                return (pointerIndex << 8) | STATE_GESTURE_DETECTING;
            case C0569H.REMOVE_STARTING /*6*/:
                if (this.mInjectedPointerTracker.getInjectedPointerDownCount() == STATE_TOUCH_EXPLORING) {
                    return STATE_TOUCH_EXPLORING;
                }
                return (pointerIndex << 8) | 6;
            default:
                return actionMasked;
        }
    }

    private boolean isDraggingGesture(MotionEvent event) {
        ReceivedPointerTracker receivedTracker = this.mReceivedPointerTracker;
        return GestureUtils.isDraggingGesture(receivedTracker.getReceivedPointerDownX(CLICK_LOCATION_NONE), receivedTracker.getReceivedPointerDownY(CLICK_LOCATION_NONE), receivedTracker.getReceivedPointerDownX(STATE_TOUCH_EXPLORING), receivedTracker.getReceivedPointerDownY(STATE_TOUCH_EXPLORING), event.getX(CLICK_LOCATION_NONE), event.getY(CLICK_LOCATION_NONE), event.getX(STATE_TOUCH_EXPLORING), event.getY(STATE_TOUCH_EXPLORING), MAX_DRAGGING_ANGLE_COS);
    }

    private int computeClickLocation(Point outLocation) {
        MotionEvent lastExploreEvent = this.mInjectedPointerTracker.getLastInjectedHoverEventForClick();
        if (lastExploreEvent != null) {
            int lastExplorePointerIndex = lastExploreEvent.getActionIndex();
            outLocation.x = (int) lastExploreEvent.getX(lastExplorePointerIndex);
            outLocation.y = (int) lastExploreEvent.getY(lastExplorePointerIndex);
            if (!this.mAms.accessibilityFocusOnlyInActiveWindow() || this.mLastTouchedWindowId == this.mAms.getActiveWindowId()) {
                if (this.mAms.getAccessibilityFocusClickPointInScreen(outLocation)) {
                    return STATE_TOUCH_EXPLORING;
                }
                return STATE_DRAGGING;
            }
        }
        if (this.mAms.getAccessibilityFocusClickPointInScreen(outLocation)) {
            return STATE_TOUCH_EXPLORING;
        }
        return CLICK_LOCATION_NONE;
    }

    private static String getStateSymbolicName(int state) {
        switch (state) {
            case STATE_TOUCH_EXPLORING /*1*/:
                return "STATE_TOUCH_EXPLORING";
            case STATE_DRAGGING /*2*/:
                return "STATE_DRAGGING";
            case STATE_DELEGATING /*4*/:
                return "STATE_DELEGATING";
            case STATE_GESTURE_DETECTING /*5*/:
                return "STATE_GESTURE_DETECTING";
            default:
                throw new IllegalArgumentException("Unknown state: " + state);
        }
    }

    public String toString() {
        return LOG_TAG;
    }
}
