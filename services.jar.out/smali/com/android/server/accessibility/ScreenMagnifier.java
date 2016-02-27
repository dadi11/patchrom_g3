package com.android.server.accessibility;

import android.animation.ObjectAnimator;
import android.animation.TypeEvaluator;
import android.animation.ValueAnimator;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Rect;
import android.graphics.Region;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Handler;
import android.os.Message;
import android.os.Process;
import android.os.SystemClock;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.Property;
import android.view.GestureDetector;
import android.view.GestureDetector.SimpleOnGestureListener;
import android.view.MagnificationSpec;
import android.view.MotionEvent;
import android.view.MotionEvent.PointerCoords;
import android.view.MotionEvent.PointerProperties;
import android.view.ScaleGestureDetector;
import android.view.ScaleGestureDetector.OnScaleGestureListener;
import android.view.ViewConfiguration;
import android.view.WindowManagerInternal;
import android.view.WindowManagerInternal.MagnificationCallbacks;
import android.view.accessibility.AccessibilityEvent;
import android.view.animation.DecelerateInterpolator;
import com.android.internal.os.SomeArgs;
import com.android.server.LocalServices;
import com.android.server.wm.WindowManagerService.C0569H;
import java.util.Locale;

public final class ScreenMagnifier implements MagnificationCallbacks, EventStreamTransformation {
    private static final boolean DEBUG_DETECTING = false;
    private static final boolean DEBUG_MAGNIFICATION_CONTROLLER = false;
    private static final boolean DEBUG_PANNING = false;
    private static final boolean DEBUG_SCALING = false;
    private static final boolean DEBUG_SET_MAGNIFICATION_SPEC = false;
    private static final boolean DEBUG_STATE_TRANSITIONS = false;
    private static final float DEFAULT_MAGNIFICATION_SCALE = 2.0f;
    private static final int DEFAULT_SCREEN_MAGNIFICATION_AUTO_UPDATE = 1;
    private static final String LOG_TAG;
    private static final int MESSAGE_ON_MAGNIFIED_BOUNDS_CHANGED = 1;
    private static final int MESSAGE_ON_RECTANGLE_ON_SCREEN_REQUESTED = 2;
    private static final int MESSAGE_ON_ROTATION_CHANGED = 4;
    private static final int MESSAGE_ON_USER_CONTEXT_CHANGED = 3;
    private static final int MULTI_TAP_TIME_SLOP_ADJUSTMENT = 50;
    private static final int MY_PID;
    private static final int STATE_DELEGATING = 1;
    private static final int STATE_DETECTING = 2;
    private static final int STATE_MAGNIFIED_INTERACTION = 4;
    private static final int STATE_VIEWPORT_DRAGGING = 3;
    private final AccessibilityManagerService mAms;
    private final Context mContext;
    private int mCurrentState;
    private long mDelegatingStateDownTime;
    private final DetectingStateHandler mDetectingStateHandler;
    private final Handler mHandler;
    private final long mLongAnimationDuration;
    private final MagnificationController mMagnificationController;
    private final Region mMagnifiedBounds;
    private final MagnifiedContentInteractonStateHandler mMagnifiedContentInteractonStateHandler;
    private final int mMultiTapDistanceSlop;
    private final int mMultiTapTimeSlop;
    private EventStreamTransformation mNext;
    private int mPreviousState;
    private final ScreenStateObserver mScreenStateObserver;
    private final StateViewportDraggingHandler mStateViewportDraggingHandler;
    private final int mTapDistanceSlop;
    private final int mTapTimeSlop;
    private PointerCoords[] mTempPointerCoords;
    private PointerProperties[] mTempPointerProperties;
    private final Rect mTempRect;
    private final Rect mTempRect1;
    private boolean mTranslationEnabledBeforePan;
    private boolean mUpdateMagnificationSpecOnNextBoundsChange;
    private final WindowManagerInternal mWindowManager;

    /* renamed from: com.android.server.accessibility.ScreenMagnifier.1 */
    class C01051 extends Handler {
        C01051() {
        }

        public void handleMessage(Message message) {
            switch (message.what) {
                case ScreenMagnifier.STATE_DELEGATING /*1*/:
                    Region bounds = message.obj;
                    ScreenMagnifier.this.handleOnMagnifiedBoundsChanged(bounds);
                    bounds.recycle();
                case ScreenMagnifier.STATE_DETECTING /*2*/:
                    SomeArgs args = message.obj;
                    ScreenMagnifier.this.handleOnRectangleOnScreenRequested(args.argi1, args.argi2, args.argi3, args.argi4);
                    args.recycle();
                case ScreenMagnifier.STATE_VIEWPORT_DRAGGING /*3*/:
                    ScreenMagnifier.this.handleOnUserContextChanged();
                case ScreenMagnifier.STATE_MAGNIFIED_INTERACTION /*4*/:
                    ScreenMagnifier.this.handleOnRotationChanged(message.arg1);
                default:
            }
        }
    }

    /* renamed from: com.android.server.accessibility.ScreenMagnifier.2 */
    class C01062 extends AsyncTask<Void, Void, Void> {
        final /* synthetic */ float val$scale;

        C01062(float f) {
            this.val$scale = f;
        }

        protected Void doInBackground(Void... params) {
            Secure.putFloat(ScreenMagnifier.this.mContext.getContentResolver(), "accessibility_display_magnification_scale", this.val$scale);
            return null;
        }
    }

    private final class DetectingStateHandler {
        private static final int ACTION_TAP_COUNT = 3;
        private static final int MESSAGE_ON_ACTION_TAP_AND_HOLD = 1;
        private static final int MESSAGE_TRANSITION_TO_DELEGATING_STATE = 2;
        private MotionEventInfo mDelayedEventQueue;
        private final Handler mHandler;
        private MotionEvent mLastDownEvent;
        private MotionEvent mLastTapUpEvent;
        private int mTapCount;

        /* renamed from: com.android.server.accessibility.ScreenMagnifier.DetectingStateHandler.1 */
        class C01071 extends Handler {
            C01071() {
            }

            public void handleMessage(Message message) {
                int type = message.what;
                switch (type) {
                    case DetectingStateHandler.MESSAGE_ON_ACTION_TAP_AND_HOLD /*1*/:
                        DetectingStateHandler.this.onActionTapAndHold(message.obj, message.arg1);
                    case DetectingStateHandler.MESSAGE_TRANSITION_TO_DELEGATING_STATE /*2*/:
                        ScreenMagnifier.this.transitionToState(DetectingStateHandler.MESSAGE_ON_ACTION_TAP_AND_HOLD);
                        DetectingStateHandler.this.sendDelayedMotionEvents();
                        DetectingStateHandler.this.clear();
                    default:
                        throw new IllegalArgumentException("Unknown message type: " + type);
                }
            }
        }

        private DetectingStateHandler() {
            this.mHandler = new C01071();
        }

        public void onMotionEvent(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
            cacheDelayedMotionEvent(event, rawEvent, policyFlags);
            switch (event.getActionMasked()) {
                case ScreenMagnifier.MY_PID:
                    this.mHandler.removeMessages(MESSAGE_TRANSITION_TO_DELEGATING_STATE);
                    if (ScreenMagnifier.this.mMagnifiedBounds.contains((int) event.getX(), (int) event.getY())) {
                        if (this.mTapCount == MESSAGE_TRANSITION_TO_DELEGATING_STATE && this.mLastDownEvent != null && GestureUtils.isMultiTap(this.mLastDownEvent, event, ScreenMagnifier.this.mMultiTapTimeSlop, ScreenMagnifier.this.mMultiTapDistanceSlop, ScreenMagnifier.MY_PID)) {
                            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MESSAGE_ON_ACTION_TAP_AND_HOLD, policyFlags, ScreenMagnifier.MY_PID, event), (long) ViewConfiguration.getLongPressTimeout());
                        } else if (this.mTapCount < ACTION_TAP_COUNT) {
                            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(MESSAGE_TRANSITION_TO_DELEGATING_STATE), (long) ScreenMagnifier.this.mMultiTapTimeSlop);
                        }
                        clearLastDownEvent();
                        this.mLastDownEvent = MotionEvent.obtain(event);
                        return;
                    }
                    transitionToDelegatingStateAndClear();
                case MESSAGE_ON_ACTION_TAP_AND_HOLD /*1*/:
                    if (this.mLastDownEvent != null) {
                        this.mHandler.removeMessages(MESSAGE_ON_ACTION_TAP_AND_HOLD);
                        if (!ScreenMagnifier.this.mMagnifiedBounds.contains((int) event.getX(), (int) event.getY())) {
                            transitionToDelegatingStateAndClear();
                        } else if (!GestureUtils.isTap(this.mLastDownEvent, event, ScreenMagnifier.this.mTapTimeSlop, ScreenMagnifier.this.mTapDistanceSlop, ScreenMagnifier.MY_PID)) {
                            transitionToDelegatingStateAndClear();
                        } else if (this.mLastTapUpEvent == null || GestureUtils.isMultiTap(this.mLastTapUpEvent, event, ScreenMagnifier.this.mMultiTapTimeSlop, ScreenMagnifier.this.mMultiTapDistanceSlop, ScreenMagnifier.MY_PID)) {
                            this.mTapCount += MESSAGE_ON_ACTION_TAP_AND_HOLD;
                            if (this.mTapCount == ACTION_TAP_COUNT) {
                                clear();
                                onActionTap(event, policyFlags);
                                return;
                            }
                            clearLastTapUpEvent();
                            this.mLastTapUpEvent = MotionEvent.obtain(event);
                        } else {
                            transitionToDelegatingStateAndClear();
                        }
                    }
                case MESSAGE_TRANSITION_TO_DELEGATING_STATE /*2*/:
                    if (this.mLastDownEvent != null && this.mTapCount < MESSAGE_TRANSITION_TO_DELEGATING_STATE && Math.abs(GestureUtils.computeDistance(this.mLastDownEvent, event, ScreenMagnifier.MY_PID)) > ((double) ScreenMagnifier.this.mTapDistanceSlop)) {
                        transitionToDelegatingStateAndClear();
                    }
                case C0569H.ADD_STARTING /*5*/:
                    if (ScreenMagnifier.this.mMagnificationController.isMagnifying()) {
                        ScreenMagnifier.this.transitionToState(ScreenMagnifier.STATE_MAGNIFIED_INTERACTION);
                        clear();
                        return;
                    }
                    transitionToDelegatingStateAndClear();
                default:
            }
        }

        public void clear() {
            this.mHandler.removeMessages(MESSAGE_ON_ACTION_TAP_AND_HOLD);
            this.mHandler.removeMessages(MESSAGE_TRANSITION_TO_DELEGATING_STATE);
            clearTapDetectionState();
            clearDelayedMotionEvents();
        }

        private void clearTapDetectionState() {
            this.mTapCount = ScreenMagnifier.MY_PID;
            clearLastTapUpEvent();
            clearLastDownEvent();
        }

        private void clearLastTapUpEvent() {
            if (this.mLastTapUpEvent != null) {
                this.mLastTapUpEvent.recycle();
                this.mLastTapUpEvent = null;
            }
        }

        private void clearLastDownEvent() {
            if (this.mLastDownEvent != null) {
                this.mLastDownEvent.recycle();
                this.mLastDownEvent = null;
            }
        }

        private void cacheDelayedMotionEvent(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
            MotionEventInfo info = MotionEventInfo.obtain(event, rawEvent, policyFlags);
            if (this.mDelayedEventQueue == null) {
                this.mDelayedEventQueue = info;
                return;
            }
            MotionEventInfo tail = this.mDelayedEventQueue;
            while (tail.mNext != null) {
                tail = tail.mNext;
            }
            tail.mNext = info;
        }

        private void sendDelayedMotionEvents() {
            while (this.mDelayedEventQueue != null) {
                MotionEventInfo info = this.mDelayedEventQueue;
                this.mDelayedEventQueue = info.mNext;
                long offset = SystemClock.uptimeMillis() - info.mCachedTimeMillis;
                MotionEvent event = obtainEventWithOffsetTimeAndDownTime(info.mEvent, offset);
                MotionEvent rawEvent = obtainEventWithOffsetTimeAndDownTime(info.mRawEvent, offset);
                ScreenMagnifier.this.onMotionEvent(event, rawEvent, info.mPolicyFlags);
                event.recycle();
                rawEvent.recycle();
                info.recycle();
            }
        }

        private MotionEvent obtainEventWithOffsetTimeAndDownTime(MotionEvent event, long offset) {
            int pointerCount = event.getPointerCount();
            PointerCoords[] coords = ScreenMagnifier.this.getTempPointerCoordsWithMinSize(pointerCount);
            PointerProperties[] properties = ScreenMagnifier.this.getTempPointerPropertiesWithMinSize(pointerCount);
            for (int i = ScreenMagnifier.MY_PID; i < pointerCount; i += MESSAGE_ON_ACTION_TAP_AND_HOLD) {
                event.getPointerCoords(i, coords[i]);
                event.getPointerProperties(i, properties[i]);
            }
            return MotionEvent.obtain(event.getDownTime() + offset, event.getEventTime() + offset, event.getAction(), pointerCount, properties, coords, event.getMetaState(), event.getButtonState(), 1.0f, 1.0f, event.getDeviceId(), event.getEdgeFlags(), event.getSource(), event.getFlags());
        }

        private void clearDelayedMotionEvents() {
            while (this.mDelayedEventQueue != null) {
                MotionEventInfo info = this.mDelayedEventQueue;
                this.mDelayedEventQueue = info.mNext;
                info.recycle();
            }
        }

        private void transitionToDelegatingStateAndClear() {
            ScreenMagnifier.this.transitionToState(MESSAGE_ON_ACTION_TAP_AND_HOLD);
            sendDelayedMotionEvents();
            clear();
        }

        private void onActionTap(MotionEvent up, int policyFlags) {
            if (ScreenMagnifier.this.mMagnificationController.isMagnifying()) {
                ScreenMagnifier.this.mMagnificationController.reset(true);
            } else {
                ScreenMagnifier.this.mMagnificationController.setScaleAndMagnifiedRegionCenter(ScreenMagnifier.this.getPersistedScale(), up.getX(), up.getY(), true);
            }
        }

        private void onActionTapAndHold(MotionEvent down, int policyFlags) {
            clear();
            ScreenMagnifier.this.mTranslationEnabledBeforePan = ScreenMagnifier.this.mMagnificationController.isMagnifying();
            ScreenMagnifier.this.mMagnificationController.setScaleAndMagnifiedRegionCenter(ScreenMagnifier.this.getPersistedScale(), down.getX(), down.getY(), true);
            ScreenMagnifier.this.transitionToState(ACTION_TAP_COUNT);
        }
    }

    private final class MagnificationController {
        private static final String PROPERTY_NAME_MAGNIFICATION_SPEC = "magnificationSpec";
        private final MagnificationSpec mCurrentMagnificationSpec;
        private final MagnificationSpec mSentMagnificationSpec;
        private final Rect mTempRect;
        private final ValueAnimator mTransformationAnimator;

        /* renamed from: com.android.server.accessibility.ScreenMagnifier.MagnificationController.1 */
        class C01081 implements TypeEvaluator<MagnificationSpec> {
            private final MagnificationSpec mTempTransformationSpec;
            final /* synthetic */ ScreenMagnifier val$this$0;

            C01081(ScreenMagnifier screenMagnifier) {
                this.val$this$0 = screenMagnifier;
                this.mTempTransformationSpec = MagnificationSpec.obtain();
            }

            public MagnificationSpec evaluate(float fraction, MagnificationSpec fromSpec, MagnificationSpec toSpec) {
                MagnificationSpec result = this.mTempTransformationSpec;
                result.scale = fromSpec.scale + ((toSpec.scale - fromSpec.scale) * fraction);
                result.offsetX = fromSpec.offsetX + ((toSpec.offsetX - fromSpec.offsetX) * fraction);
                result.offsetY = fromSpec.offsetY + ((toSpec.offsetY - fromSpec.offsetY) * fraction);
                return result;
            }
        }

        public MagnificationController(long animationDuration) {
            this.mSentMagnificationSpec = MagnificationSpec.obtain();
            this.mCurrentMagnificationSpec = MagnificationSpec.obtain();
            this.mTempRect = new Rect();
            Property<MagnificationController, MagnificationSpec> property = Property.of(MagnificationController.class, MagnificationSpec.class, PROPERTY_NAME_MAGNIFICATION_SPEC);
            TypeEvaluator<MagnificationSpec> evaluator = new C01081(ScreenMagnifier.this);
            MagnificationSpec[] magnificationSpecArr = new MagnificationSpec[ScreenMagnifier.STATE_DETECTING];
            magnificationSpecArr[ScreenMagnifier.MY_PID] = this.mSentMagnificationSpec;
            magnificationSpecArr[ScreenMagnifier.STATE_DELEGATING] = this.mCurrentMagnificationSpec;
            this.mTransformationAnimator = ObjectAnimator.ofObject(this, property, evaluator, magnificationSpecArr);
            this.mTransformationAnimator.setDuration(animationDuration);
            this.mTransformationAnimator.setInterpolator(new DecelerateInterpolator(2.5f));
        }

        public boolean isMagnifying() {
            return this.mCurrentMagnificationSpec.scale > 1.0f ? true : ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
        }

        public void reset(boolean animate) {
            if (this.mTransformationAnimator.isRunning()) {
                this.mTransformationAnimator.cancel();
            }
            this.mCurrentMagnificationSpec.clear();
            if (animate) {
                animateMangificationSpec(this.mSentMagnificationSpec, this.mCurrentMagnificationSpec);
            } else {
                setMagnificationSpec(this.mCurrentMagnificationSpec);
            }
            this.mTempRect.setEmpty();
            ScreenMagnifier.this.mAms.onMagnificationStateChanged();
        }

        public float getScale() {
            return this.mCurrentMagnificationSpec.scale;
        }

        public float getOffsetX() {
            return this.mCurrentMagnificationSpec.offsetX;
        }

        public float getOffsetY() {
            return this.mCurrentMagnificationSpec.offsetY;
        }

        public void setScale(float scale, float pivotX, float pivotY, boolean animate) {
            Rect magnifiedFrame = this.mTempRect;
            ScreenMagnifier.this.mMagnifiedBounds.getBounds(magnifiedFrame);
            MagnificationSpec spec = this.mCurrentMagnificationSpec;
            float oldScale = spec.scale;
            float normPivotX = ((-spec.offsetX) + pivotX) / oldScale;
            float normPivotY = ((-spec.offsetY) + pivotY) / oldScale;
            float offsetX = ((((-spec.offsetX) + ((float) (magnifiedFrame.width() / ScreenMagnifier.STATE_DETECTING))) / oldScale) - normPivotX) * (oldScale / scale);
            setScaleAndMagnifiedRegionCenter(scale, normPivotX + offsetX, normPivotY + (((((-spec.offsetY) + ((float) (magnifiedFrame.height() / ScreenMagnifier.STATE_DETECTING))) / oldScale) - normPivotY) * (oldScale / scale)), animate);
        }

        public void setMagnifiedRegionCenter(float centerX, float centerY, boolean animate) {
            setScaleAndMagnifiedRegionCenter(this.mCurrentMagnificationSpec.scale, centerX, centerY, animate);
        }

        public void offsetMagnifiedRegionCenter(float offsetX, float offsetY) {
            float nonNormOffsetX = this.mCurrentMagnificationSpec.offsetX - offsetX;
            this.mCurrentMagnificationSpec.offsetX = Math.min(Math.max(nonNormOffsetX, getMinOffsetX()), 0.0f);
            float nonNormOffsetY = this.mCurrentMagnificationSpec.offsetY - offsetY;
            this.mCurrentMagnificationSpec.offsetY = Math.min(Math.max(nonNormOffsetY, getMinOffsetY()), 0.0f);
            setMagnificationSpec(this.mCurrentMagnificationSpec);
        }

        public void setScaleAndMagnifiedRegionCenter(float scale, float centerX, float centerY, boolean animate) {
            if (Float.compare(this.mCurrentMagnificationSpec.scale, scale) != 0 || Float.compare(this.mCurrentMagnificationSpec.offsetX, centerX) != 0 || Float.compare(this.mCurrentMagnificationSpec.offsetY, centerY) != 0) {
                if (this.mTransformationAnimator.isRunning()) {
                    this.mTransformationAnimator.cancel();
                }
                updateMagnificationSpec(scale, centerX, centerY);
                if (animate) {
                    animateMangificationSpec(this.mSentMagnificationSpec, this.mCurrentMagnificationSpec);
                } else {
                    setMagnificationSpec(this.mCurrentMagnificationSpec);
                }
                ScreenMagnifier.this.mAms.onMagnificationStateChanged();
            }
        }

        public void updateMagnificationSpec(float scale, float magnifiedCenterX, float magnifiedCenterY) {
            Rect magnifiedFrame = this.mTempRect;
            ScreenMagnifier.this.mMagnifiedBounds.getBounds(magnifiedFrame);
            this.mCurrentMagnificationSpec.scale = scale;
            float nonNormOffsetX = ((float) (magnifiedFrame.width() / ScreenMagnifier.STATE_DETECTING)) - (magnifiedCenterX * scale);
            this.mCurrentMagnificationSpec.offsetX = Math.min(Math.max(nonNormOffsetX, getMinOffsetX()), 0.0f);
            float nonNormOffsetY = ((float) (magnifiedFrame.height() / ScreenMagnifier.STATE_DETECTING)) - (magnifiedCenterY * scale);
            this.mCurrentMagnificationSpec.offsetY = Math.min(Math.max(nonNormOffsetY, getMinOffsetY()), 0.0f);
        }

        private float getMinOffsetX() {
            Rect magnifiedFrame = this.mTempRect;
            ScreenMagnifier.this.mMagnifiedBounds.getBounds(magnifiedFrame);
            float viewportWidth = (float) magnifiedFrame.width();
            return viewportWidth - (this.mCurrentMagnificationSpec.scale * viewportWidth);
        }

        private float getMinOffsetY() {
            Rect magnifiedFrame = this.mTempRect;
            ScreenMagnifier.this.mMagnifiedBounds.getBounds(magnifiedFrame);
            float viewportHeight = (float) magnifiedFrame.height();
            return viewportHeight - (this.mCurrentMagnificationSpec.scale * viewportHeight);
        }

        private void animateMangificationSpec(MagnificationSpec fromSpec, MagnificationSpec toSpec) {
            ValueAnimator valueAnimator = this.mTransformationAnimator;
            Object[] objArr = new Object[ScreenMagnifier.STATE_DETECTING];
            objArr[ScreenMagnifier.MY_PID] = fromSpec;
            objArr[ScreenMagnifier.STATE_DELEGATING] = toSpec;
            valueAnimator.setObjectValues(objArr);
            this.mTransformationAnimator.start();
        }

        public MagnificationSpec getMagnificationSpec() {
            return this.mSentMagnificationSpec;
        }

        public void setMagnificationSpec(MagnificationSpec spec) {
            this.mSentMagnificationSpec.scale = spec.scale;
            this.mSentMagnificationSpec.offsetX = spec.offsetX;
            this.mSentMagnificationSpec.offsetY = spec.offsetY;
            ScreenMagnifier.this.mWindowManager.setMagnificationSpec(MagnificationSpec.obtain(spec));
        }
    }

    private final class MagnifiedContentInteractonStateHandler extends SimpleOnGestureListener implements OnScaleGestureListener {
        private static final float MAX_SCALE = 5.0f;
        private static final float MIN_SCALE = 1.3f;
        private static final float SCALING_THRESHOLD = 0.3f;
        private final GestureDetector mGestureDetector;
        private float mInitialScaleFactor;
        private final ScaleGestureDetector mScaleGestureDetector;
        private boolean mScaling;

        public MagnifiedContentInteractonStateHandler(Context context) {
            this.mInitialScaleFactor = -1.0f;
            this.mScaleGestureDetector = new ScaleGestureDetector(context, this);
            this.mScaleGestureDetector.setQuickScaleEnabled(ScreenMagnifier.DEBUG_STATE_TRANSITIONS);
            this.mGestureDetector = new GestureDetector(context, this);
        }

        public void onMotionEvent(MotionEvent event) {
            this.mScaleGestureDetector.onTouchEvent(event);
            this.mGestureDetector.onTouchEvent(event);
            if (ScreenMagnifier.this.mCurrentState == ScreenMagnifier.STATE_MAGNIFIED_INTERACTION && event.getActionMasked() == ScreenMagnifier.STATE_DELEGATING) {
                clear();
                float scale = Math.min(Math.max(ScreenMagnifier.this.mMagnificationController.getScale(), MIN_SCALE), MAX_SCALE);
                if (scale != ScreenMagnifier.this.getPersistedScale()) {
                    ScreenMagnifier.this.persistScale(scale);
                }
                if (ScreenMagnifier.this.mPreviousState == ScreenMagnifier.STATE_VIEWPORT_DRAGGING) {
                    ScreenMagnifier.this.transitionToState(ScreenMagnifier.STATE_VIEWPORT_DRAGGING);
                } else {
                    ScreenMagnifier.this.transitionToState(ScreenMagnifier.STATE_DETECTING);
                }
            }
        }

        public boolean onScroll(MotionEvent first, MotionEvent second, float distanceX, float distanceY) {
            if (ScreenMagnifier.this.mCurrentState == ScreenMagnifier.STATE_MAGNIFIED_INTERACTION) {
                ScreenMagnifier.this.mMagnificationController.offsetMagnifiedRegionCenter(distanceX, distanceY);
            }
            return true;
        }

        public boolean onScale(ScaleGestureDetector detector) {
            if (this.mScaling) {
                ScreenMagnifier.this.mMagnificationController.setScale(Math.min(Math.max(ScreenMagnifier.this.mMagnificationController.getScale() * detector.getScaleFactor(), MIN_SCALE), MAX_SCALE), detector.getFocusX(), detector.getFocusY(), ScreenMagnifier.DEBUG_STATE_TRANSITIONS);
                return true;
            }
            if (this.mInitialScaleFactor < 0.0f) {
                this.mInitialScaleFactor = detector.getScaleFactor();
            } else if (Math.abs(detector.getScaleFactor() - this.mInitialScaleFactor) > SCALING_THRESHOLD) {
                this.mScaling = true;
                return true;
            }
            return ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
        }

        public boolean onScaleBegin(ScaleGestureDetector detector) {
            return ScreenMagnifier.this.mCurrentState == ScreenMagnifier.STATE_MAGNIFIED_INTERACTION ? true : ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
        }

        public void onScaleEnd(ScaleGestureDetector detector) {
            clear();
        }

        private void clear() {
            this.mInitialScaleFactor = -1.0f;
            this.mScaling = ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
        }
    }

    private static final class MotionEventInfo {
        private static final int MAX_POOL_SIZE = 10;
        private static final Object sLock;
        private static MotionEventInfo sPool;
        private static int sPoolSize;
        public long mCachedTimeMillis;
        public MotionEvent mEvent;
        private boolean mInPool;
        private MotionEventInfo mNext;
        public int mPolicyFlags;
        public MotionEvent mRawEvent;

        private MotionEventInfo() {
        }

        static {
            sLock = new Object();
        }

        public static MotionEventInfo obtain(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
            MotionEventInfo info;
            synchronized (sLock) {
                if (sPoolSize > 0) {
                    sPoolSize--;
                    info = sPool;
                    sPool = info.mNext;
                    info.mNext = null;
                    info.mInPool = ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
                } else {
                    info = new MotionEventInfo();
                }
                info.initialize(event, rawEvent, policyFlags);
            }
            return info;
        }

        private void initialize(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
            this.mEvent = MotionEvent.obtain(event);
            this.mRawEvent = MotionEvent.obtain(rawEvent);
            this.mPolicyFlags = policyFlags;
            this.mCachedTimeMillis = SystemClock.uptimeMillis();
        }

        public void recycle() {
            synchronized (sLock) {
                if (this.mInPool) {
                    throw new IllegalStateException("Already recycled.");
                }
                clear();
                if (sPoolSize < MAX_POOL_SIZE) {
                    sPoolSize += ScreenMagnifier.STATE_DELEGATING;
                    this.mNext = sPool;
                    sPool = this;
                    this.mInPool = true;
                }
            }
        }

        private void clear() {
            this.mEvent.recycle();
            this.mEvent = null;
            this.mRawEvent.recycle();
            this.mRawEvent = null;
            this.mPolicyFlags = ScreenMagnifier.MY_PID;
            this.mCachedTimeMillis = 0;
        }
    }

    private final class ScreenStateObserver extends BroadcastReceiver {
        private static final int MESSAGE_ON_SCREEN_STATE_CHANGE = 1;
        private final Context mContext;
        private final Handler mHandler;
        private final MagnificationController mMagnificationController;

        /* renamed from: com.android.server.accessibility.ScreenMagnifier.ScreenStateObserver.1 */
        class C01091 extends Handler {
            C01091() {
            }

            public void handleMessage(Message message) {
                switch (message.what) {
                    case ScreenStateObserver.MESSAGE_ON_SCREEN_STATE_CHANGE /*1*/:
                        ScreenStateObserver.this.handleOnScreenStateChange(message.obj);
                    default:
                }
            }
        }

        public ScreenStateObserver(Context context, MagnificationController magnificationController) {
            this.mHandler = new C01091();
            this.mContext = context;
            this.mMagnificationController = magnificationController;
            this.mContext.registerReceiver(this, new IntentFilter("android.intent.action.SCREEN_OFF"));
        }

        public void destroy() {
            this.mContext.unregisterReceiver(this);
        }

        public void onReceive(Context context, Intent intent) {
            this.mHandler.obtainMessage(MESSAGE_ON_SCREEN_STATE_CHANGE, intent.getAction()).sendToTarget();
        }

        private void handleOnScreenStateChange(String action) {
            if (this.mMagnificationController.isMagnifying() && ScreenMagnifier.isScreenMagnificationAutoUpdateEnabled(this.mContext)) {
                this.mMagnificationController.reset(ScreenMagnifier.DEBUG_STATE_TRANSITIONS);
            }
        }
    }

    private final class StateViewportDraggingHandler {
        private boolean mLastMoveOutsideMagnifiedRegion;

        private StateViewportDraggingHandler() {
        }

        private void onMotionEvent(MotionEvent event, int policyFlags) {
            switch (event.getActionMasked()) {
                case ScreenMagnifier.MY_PID:
                    throw new IllegalArgumentException("Unexpected event type: ACTION_DOWN");
                case ScreenMagnifier.STATE_DELEGATING /*1*/:
                    if (!ScreenMagnifier.this.mTranslationEnabledBeforePan) {
                        ScreenMagnifier.this.mMagnificationController.reset(true);
                    }
                    clear();
                    ScreenMagnifier.this.transitionToState(ScreenMagnifier.STATE_DETECTING);
                case ScreenMagnifier.STATE_DETECTING /*2*/:
                    if (event.getPointerCount() != ScreenMagnifier.STATE_DELEGATING) {
                        throw new IllegalStateException("Should have one pointer down.");
                    }
                    float eventX = event.getX();
                    float eventY = event.getY();
                    if (!ScreenMagnifier.this.mMagnifiedBounds.contains((int) eventX, (int) eventY)) {
                        this.mLastMoveOutsideMagnifiedRegion = true;
                    } else if (this.mLastMoveOutsideMagnifiedRegion) {
                        this.mLastMoveOutsideMagnifiedRegion = ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
                        ScreenMagnifier.this.mMagnificationController.setMagnifiedRegionCenter(eventX, eventY, true);
                    } else {
                        ScreenMagnifier.this.mMagnificationController.setMagnifiedRegionCenter(eventX, eventY, ScreenMagnifier.DEBUG_STATE_TRANSITIONS);
                    }
                case C0569H.ADD_STARTING /*5*/:
                    clear();
                    ScreenMagnifier.this.transitionToState(ScreenMagnifier.STATE_MAGNIFIED_INTERACTION);
                case C0569H.REMOVE_STARTING /*6*/:
                    throw new IllegalArgumentException("Unexpected event type: ACTION_POINTER_UP");
                default:
            }
        }

        public void clear() {
            this.mLastMoveOutsideMagnifiedRegion = ScreenMagnifier.DEBUG_STATE_TRANSITIONS;
        }
    }

    static {
        LOG_TAG = ScreenMagnifier.class.getSimpleName();
        MY_PID = Process.myPid();
    }

    public ScreenMagnifier(Context context, int displayId, AccessibilityManagerService service) {
        this.mTempRect = new Rect();
        this.mTempRect1 = new Rect();
        this.mTapTimeSlop = ViewConfiguration.getTapTimeout();
        this.mMultiTapTimeSlop = ViewConfiguration.getDoubleTapTimeout() - 50;
        this.mMagnifiedBounds = new Region();
        this.mHandler = new C01051();
        this.mContext = context;
        this.mWindowManager = (WindowManagerInternal) LocalServices.getService(WindowManagerInternal.class);
        this.mAms = service;
        this.mLongAnimationDuration = (long) context.getResources().getInteger(17694722);
        this.mTapDistanceSlop = ViewConfiguration.get(context).getScaledTouchSlop();
        this.mMultiTapDistanceSlop = ViewConfiguration.get(context).getScaledDoubleTapSlop();
        this.mDetectingStateHandler = new DetectingStateHandler();
        this.mStateViewportDraggingHandler = new StateViewportDraggingHandler();
        this.mMagnifiedContentInteractonStateHandler = new MagnifiedContentInteractonStateHandler(context);
        this.mMagnificationController = new MagnificationController(this.mLongAnimationDuration);
        this.mScreenStateObserver = new ScreenStateObserver(context, this.mMagnificationController);
        this.mWindowManager.setMagnificationCallbacks(this);
        transitionToState(STATE_DETECTING);
    }

    public void onMagnifedBoundsChanged(Region bounds) {
        this.mHandler.obtainMessage(STATE_DELEGATING, Region.obtain(bounds)).sendToTarget();
        if (MY_PID != Binder.getCallingPid()) {
            bounds.recycle();
        }
    }

    private void handleOnMagnifiedBoundsChanged(Region bounds) {
        if (this.mUpdateMagnificationSpecOnNextBoundsChange) {
            this.mUpdateMagnificationSpecOnNextBoundsChange = DEBUG_STATE_TRANSITIONS;
            MagnificationSpec spec = this.mMagnificationController.getMagnificationSpec();
            Rect magnifiedFrame = this.mTempRect;
            this.mMagnifiedBounds.getBounds(magnifiedFrame);
            float scale = spec.scale;
            this.mMagnificationController.setScaleAndMagnifiedRegionCenter(scale, ((-spec.offsetX) + ((float) (magnifiedFrame.width() / STATE_DETECTING))) / scale, ((-spec.offsetY) + ((float) (magnifiedFrame.height() / STATE_DETECTING))) / scale, DEBUG_STATE_TRANSITIONS);
        }
        this.mMagnifiedBounds.set(bounds);
        this.mAms.onMagnificationStateChanged();
    }

    public void onRectangleOnScreenRequested(int left, int top, int right, int bottom) {
        SomeArgs args = SomeArgs.obtain();
        args.argi1 = left;
        args.argi2 = top;
        args.argi3 = right;
        args.argi4 = bottom;
        this.mHandler.obtainMessage(STATE_DETECTING, args).sendToTarget();
    }

    private void handleOnRectangleOnScreenRequested(int left, int top, int right, int bottom) {
        Rect magnifiedFrame = this.mTempRect;
        this.mMagnifiedBounds.getBounds(magnifiedFrame);
        if (magnifiedFrame.intersects(left, top, right, bottom)) {
            float scrollX;
            float scrollY;
            Rect magnifFrameInScreenCoords = this.mTempRect1;
            getMagnifiedFrameInContentCoords(magnifFrameInScreenCoords);
            if (right - left > magnifFrameInScreenCoords.width()) {
                if (TextUtils.getLayoutDirectionFromLocale(Locale.getDefault()) == 0) {
                    scrollX = (float) (left - magnifFrameInScreenCoords.left);
                } else {
                    scrollX = (float) (right - magnifFrameInScreenCoords.right);
                }
            } else if (left < magnifFrameInScreenCoords.left) {
                scrollX = (float) (left - magnifFrameInScreenCoords.left);
            } else if (right > magnifFrameInScreenCoords.right) {
                scrollX = (float) (right - magnifFrameInScreenCoords.right);
            } else {
                scrollX = 0.0f;
            }
            if (bottom - top > magnifFrameInScreenCoords.height()) {
                scrollY = (float) (top - magnifFrameInScreenCoords.top);
            } else if (top < magnifFrameInScreenCoords.top) {
                scrollY = (float) (top - magnifFrameInScreenCoords.top);
            } else if (bottom > magnifFrameInScreenCoords.bottom) {
                scrollY = (float) (bottom - magnifFrameInScreenCoords.bottom);
            } else {
                scrollY = 0.0f;
            }
            float scale = this.mMagnificationController.getScale();
            this.mMagnificationController.offsetMagnifiedRegionCenter(scrollX * scale, scrollY * scale);
        }
    }

    public void onRotationChanged(int rotation) {
        this.mHandler.obtainMessage(STATE_MAGNIFIED_INTERACTION, rotation, MY_PID).sendToTarget();
    }

    private void handleOnRotationChanged(int rotation) {
        resetMagnificationIfNeeded();
        if (this.mMagnificationController.isMagnifying()) {
            this.mUpdateMagnificationSpecOnNextBoundsChange = true;
        }
    }

    public void onUserContextChanged() {
        this.mHandler.sendEmptyMessage(STATE_VIEWPORT_DRAGGING);
    }

    private void handleOnUserContextChanged() {
        resetMagnificationIfNeeded();
    }

    private void getMagnifiedFrameInContentCoords(Rect rect) {
        MagnificationSpec spec = this.mMagnificationController.getMagnificationSpec();
        this.mMagnifiedBounds.getBounds(rect);
        rect.offset((int) (-spec.offsetX), (int) (-spec.offsetY));
        rect.scale(1.0f / spec.scale);
    }

    private void resetMagnificationIfNeeded() {
        if (this.mMagnificationController.isMagnifying() && isScreenMagnificationAutoUpdateEnabled(this.mContext)) {
            this.mMagnificationController.reset(true);
        }
    }

    public void onMotionEvent(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
        this.mMagnifiedContentInteractonStateHandler.onMotionEvent(event);
        switch (this.mCurrentState) {
            case STATE_DELEGATING /*1*/:
                handleMotionEventStateDelegating(event, rawEvent, policyFlags);
            case STATE_DETECTING /*2*/:
                this.mDetectingStateHandler.onMotionEvent(event, rawEvent, policyFlags);
            case STATE_VIEWPORT_DRAGGING /*3*/:
                this.mStateViewportDraggingHandler.onMotionEvent(event, policyFlags);
            case STATE_MAGNIFIED_INTERACTION /*4*/:
            default:
                throw new IllegalStateException("Unknown state: " + this.mCurrentState);
        }
    }

    public void onAccessibilityEvent(AccessibilityEvent event) {
        if (this.mNext != null) {
            this.mNext.onAccessibilityEvent(event);
        }
    }

    public void setNext(EventStreamTransformation next) {
        this.mNext = next;
    }

    public void clear() {
        this.mCurrentState = STATE_DETECTING;
        this.mDetectingStateHandler.clear();
        this.mStateViewportDraggingHandler.clear();
        this.mMagnifiedContentInteractonStateHandler.clear();
        if (this.mNext != null) {
            this.mNext.clear();
        }
    }

    public void onDestroy() {
        this.mScreenStateObserver.destroy();
        this.mWindowManager.setMagnificationCallbacks(null);
    }

    private void handleMotionEventStateDelegating(MotionEvent event, MotionEvent rawEvent, int policyFlags) {
        switch (event.getActionMasked()) {
            case MY_PID:
                this.mDelegatingStateDownTime = event.getDownTime();
                break;
            case STATE_DELEGATING /*1*/:
                if (this.mDetectingStateHandler.mDelayedEventQueue == null) {
                    transitionToState(STATE_DETECTING);
                    break;
                }
                break;
        }
        if (this.mNext != null) {
            float eventX = event.getX();
            float eventY = event.getY();
            if (this.mMagnificationController.isMagnifying() && this.mMagnifiedBounds.contains((int) eventX, (int) eventY)) {
                float scale = this.mMagnificationController.getScale();
                float scaledOffsetX = this.mMagnificationController.getOffsetX();
                float scaledOffsetY = this.mMagnificationController.getOffsetY();
                int pointerCount = event.getPointerCount();
                PointerCoords[] coords = getTempPointerCoordsWithMinSize(pointerCount);
                PointerProperties[] properties = getTempPointerPropertiesWithMinSize(pointerCount);
                for (int i = MY_PID; i < pointerCount; i += STATE_DELEGATING) {
                    event.getPointerCoords(i, coords[i]);
                    coords[i].x = (coords[i].x - scaledOffsetX) / scale;
                    coords[i].y = (coords[i].y - scaledOffsetY) / scale;
                    event.getPointerProperties(i, properties[i]);
                }
                event = MotionEvent.obtain(event.getDownTime(), event.getEventTime(), event.getAction(), pointerCount, properties, coords, MY_PID, MY_PID, 1.0f, 1.0f, event.getDeviceId(), MY_PID, event.getSource(), event.getFlags());
            }
            event.setDownTime(this.mDelegatingStateDownTime);
            this.mNext.onMotionEvent(event, rawEvent, policyFlags);
        }
    }

    private PointerCoords[] getTempPointerCoordsWithMinSize(int size) {
        int oldSize;
        if (this.mTempPointerCoords != null) {
            oldSize = this.mTempPointerCoords.length;
        } else {
            oldSize = MY_PID;
        }
        if (oldSize < size) {
            PointerCoords[] oldTempPointerCoords = this.mTempPointerCoords;
            this.mTempPointerCoords = new PointerCoords[size];
            if (oldTempPointerCoords != null) {
                System.arraycopy(oldTempPointerCoords, MY_PID, this.mTempPointerCoords, MY_PID, oldSize);
            }
        }
        for (int i = oldSize; i < size; i += STATE_DELEGATING) {
            this.mTempPointerCoords[i] = new PointerCoords();
        }
        return this.mTempPointerCoords;
    }

    private PointerProperties[] getTempPointerPropertiesWithMinSize(int size) {
        int oldSize;
        if (this.mTempPointerProperties != null) {
            oldSize = this.mTempPointerProperties.length;
        } else {
            oldSize = MY_PID;
        }
        if (oldSize < size) {
            PointerProperties[] oldTempPointerProperties = this.mTempPointerProperties;
            this.mTempPointerProperties = new PointerProperties[size];
            if (oldTempPointerProperties != null) {
                System.arraycopy(oldTempPointerProperties, MY_PID, this.mTempPointerProperties, MY_PID, oldSize);
            }
        }
        for (int i = oldSize; i < size; i += STATE_DELEGATING) {
            this.mTempPointerProperties[i] = new PointerProperties();
        }
        return this.mTempPointerProperties;
    }

    private void transitionToState(int state) {
        this.mPreviousState = this.mCurrentState;
        this.mCurrentState = state;
    }

    private void persistScale(float scale) {
        new C01062(scale).execute(new Void[MY_PID]);
    }

    private float getPersistedScale() {
        return Secure.getFloat(this.mContext.getContentResolver(), "accessibility_display_magnification_scale", DEFAULT_MAGNIFICATION_SCALE);
    }

    private static boolean isScreenMagnificationAutoUpdateEnabled(Context context) {
        return Secure.getInt(context.getContentResolver(), "accessibility_display_magnification_auto_update", STATE_DELEGATING) == STATE_DELEGATING ? true : DEBUG_STATE_TRANSITIONS;
    }
}
