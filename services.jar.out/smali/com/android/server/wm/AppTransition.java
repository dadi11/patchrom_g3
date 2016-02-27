package com.android.server.wm;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.Handler;
import android.os.IRemoteCallback;
import android.view.WindowManager.LayoutParams;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.ClipRectAnimation;
import android.view.animation.Interpolator;
import android.view.animation.ScaleAnimation;
import android.view.animation.TranslateAnimation;
import com.android.internal.R;
import com.android.internal.util.DumpUtils.Dump;
import com.android.server.AttributeCache;
import com.android.server.AttributeCache.Entry;
import java.io.PrintWriter;

public class AppTransition implements Dump {
    private static final int APP_STATE_IDLE = 0;
    private static final int APP_STATE_READY = 1;
    private static final int APP_STATE_RUNNING = 2;
    private static final int APP_STATE_TIMEOUT = 3;
    private static final boolean DEBUG_ANIM = false;
    private static final boolean DEBUG_APP_TRANSITIONS = false;
    private static final int DEFAULT_APP_TRANSITION_DURATION = 250;
    private static final int NEXT_TRANSIT_TYPE_CUSTOM = 1;
    private static final int NEXT_TRANSIT_TYPE_CUSTOM_IN_PLACE = 7;
    private static final int NEXT_TRANSIT_TYPE_NONE = 0;
    private static final int NEXT_TRANSIT_TYPE_SCALE_UP = 2;
    private static final int NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_DOWN = 6;
    private static final int NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP = 5;
    private static final int NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN = 4;
    private static final int NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_UP = 3;
    private static final float RECENTS_THUMBNAIL_FADEIN_FRACTION = 0.7f;
    private static final float RECENTS_THUMBNAIL_FADEOUT_FRACTION = 0.3f;
    private static final String TAG = "AppTransition";
    private static final int THUMBNAIL_APP_TRANSITION_ALPHA_DURATION = 325;
    private static final int THUMBNAIL_APP_TRANSITION_DURATION = 325;
    private static final int THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN = 2;
    private static final int THUMBNAIL_TRANSITION_ENTER_SCALE_UP = 0;
    private static final int THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN = 3;
    private static final int THUMBNAIL_TRANSITION_EXIT_SCALE_UP = 1;
    public static final int TRANSIT_ACTIVITY_CLOSE = 7;
    public static final int TRANSIT_ACTIVITY_OPEN = 6;
    public static final int TRANSIT_NONE = 0;
    public static final int TRANSIT_TASK_CLOSE = 9;
    public static final int TRANSIT_TASK_IN_PLACE = 17;
    public static final int TRANSIT_TASK_OPEN = 8;
    public static final int TRANSIT_TASK_OPEN_BEHIND = 16;
    public static final int TRANSIT_TASK_TO_BACK = 11;
    public static final int TRANSIT_TASK_TO_FRONT = 10;
    public static final int TRANSIT_UNSET = -1;
    public static final int TRANSIT_WALLPAPER_CLOSE = 12;
    public static final int TRANSIT_WALLPAPER_INTRA_CLOSE = 15;
    public static final int TRANSIT_WALLPAPER_INTRA_OPEN = 14;
    public static final int TRANSIT_WALLPAPER_OPEN = 13;
    private int mAppTransitionState;
    private final int mConfigShortAnimTime;
    private final Context mContext;
    private int mCurrentUserId;
    private final Interpolator mDecelerateInterpolator;
    private final Handler mH;
    private int mNextAppTransition;
    private IRemoteCallback mNextAppTransitionCallback;
    private int mNextAppTransitionEnter;
    private int mNextAppTransitionExit;
    private int mNextAppTransitionInPlace;
    private Rect mNextAppTransitionInsets;
    private String mNextAppTransitionPackage;
    private boolean mNextAppTransitionScaleUp;
    private int mNextAppTransitionStartHeight;
    private int mNextAppTransitionStartWidth;
    private int mNextAppTransitionStartX;
    private int mNextAppTransitionStartY;
    private Bitmap mNextAppTransitionThumbnail;
    private int mNextAppTransitionType;
    private final Interpolator mThumbnailFadeInInterpolator;
    private final Interpolator mThumbnailFadeOutInterpolator;
    private final Interpolator mThumbnailFastOutSlowInInterpolator;
    private Rect mTmpFromClipRect;
    private Rect mTmpToClipRect;

    /* renamed from: com.android.server.wm.AppTransition.1 */
    class C05581 implements Interpolator {
        C05581() {
        }

        public float getInterpolation(float input) {
            if (input < AppTransition.RECENTS_THUMBNAIL_FADEIN_FRACTION) {
                return 0.0f;
            }
            return (input - AppTransition.RECENTS_THUMBNAIL_FADEIN_FRACTION) / AppTransition.RECENTS_THUMBNAIL_FADEOUT_FRACTION;
        }
    }

    /* renamed from: com.android.server.wm.AppTransition.2 */
    class C05592 implements Interpolator {
        C05592() {
        }

        public float getInterpolation(float input) {
            if (input < AppTransition.RECENTS_THUMBNAIL_FADEOUT_FRACTION) {
                return input / AppTransition.RECENTS_THUMBNAIL_FADEOUT_FRACTION;
            }
            return 1.0f;
        }
    }

    AppTransition(Context context, Handler h) {
        this.mNextAppTransition = TRANSIT_UNSET;
        this.mNextAppTransitionType = TRANSIT_NONE;
        this.mNextAppTransitionInsets = new Rect();
        this.mTmpFromClipRect = new Rect();
        this.mTmpToClipRect = new Rect();
        this.mAppTransitionState = TRANSIT_NONE;
        this.mCurrentUserId = TRANSIT_NONE;
        this.mContext = context;
        this.mH = h;
        this.mConfigShortAnimTime = context.getResources().getInteger(17694720);
        this.mDecelerateInterpolator = AnimationUtils.loadInterpolator(context, 17563651);
        this.mThumbnailFastOutSlowInInterpolator = AnimationUtils.loadInterpolator(context, 17563661);
        this.mThumbnailFadeInInterpolator = new C05581();
        this.mThumbnailFadeOutInterpolator = new C05592();
    }

    boolean isTransitionSet() {
        return this.mNextAppTransition != TRANSIT_UNSET ? true : DEBUG_APP_TRANSITIONS;
    }

    boolean isTransitionNone() {
        return this.mNextAppTransition == 0 ? true : DEBUG_APP_TRANSITIONS;
    }

    boolean isTransitionEqual(int transit) {
        return this.mNextAppTransition == transit ? true : DEBUG_APP_TRANSITIONS;
    }

    int getAppTransition() {
        return this.mNextAppTransition;
    }

    void setAppTransition(int transit) {
        this.mNextAppTransition = transit;
    }

    boolean isReady() {
        return (this.mAppTransitionState == THUMBNAIL_TRANSITION_EXIT_SCALE_UP || this.mAppTransitionState == THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN) ? true : DEBUG_APP_TRANSITIONS;
    }

    void setReady() {
        this.mAppTransitionState = THUMBNAIL_TRANSITION_EXIT_SCALE_UP;
    }

    boolean isRunning() {
        return this.mAppTransitionState == THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN ? true : DEBUG_APP_TRANSITIONS;
    }

    void setIdle() {
        this.mAppTransitionState = TRANSIT_NONE;
    }

    boolean isTimeout() {
        return this.mAppTransitionState == THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN ? true : DEBUG_APP_TRANSITIONS;
    }

    void setTimeout() {
        this.mAppTransitionState = THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN;
    }

    Bitmap getNextAppTransitionThumbnail() {
        return this.mNextAppTransitionThumbnail;
    }

    boolean isNextThumbnailTransitionAspectScaled() {
        return (this.mNextAppTransitionType == NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP || this.mNextAppTransitionType == TRANSIT_ACTIVITY_OPEN) ? true : DEBUG_APP_TRANSITIONS;
    }

    boolean isNextThumbnailTransitionScaleUp() {
        return this.mNextAppTransitionScaleUp;
    }

    int getStartingX() {
        return this.mNextAppTransitionStartX;
    }

    int getStartingY() {
        return this.mNextAppTransitionStartY;
    }

    void prepare() {
        if (!isRunning()) {
            this.mAppTransitionState = TRANSIT_NONE;
        }
    }

    void goodToGo() {
        this.mNextAppTransition = TRANSIT_UNSET;
        this.mAppTransitionState = THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN;
    }

    void clear() {
        this.mNextAppTransitionType = TRANSIT_NONE;
        this.mNextAppTransitionPackage = null;
        this.mNextAppTransitionThumbnail = null;
    }

    void freeze() {
        setAppTransition(TRANSIT_UNSET);
        clear();
        setReady();
    }

    private Entry getCachedAnimations(LayoutParams lp) {
        if (lp == null || lp.windowAnimations == 0) {
            return null;
        }
        String packageName = lp.packageName != null ? lp.packageName : "android";
        int resId = lp.windowAnimations;
        if ((-16777216 & resId) == 16777216) {
            packageName = "android";
        }
        return AttributeCache.instance().get(packageName, resId, R.styleable.WindowAnimation, this.mCurrentUserId);
    }

    private Entry getCachedAnimations(String packageName, int resId) {
        if (packageName == null) {
            return null;
        }
        if ((-16777216 & resId) == 16777216) {
            packageName = "android";
        }
        return AttributeCache.instance().get(packageName, resId, R.styleable.WindowAnimation, this.mCurrentUserId);
    }

    Animation loadAnimationAttr(LayoutParams lp, int animAttr) {
        int anim = TRANSIT_NONE;
        Context context = this.mContext;
        if (animAttr >= 0) {
            Entry ent = getCachedAnimations(lp);
            if (ent != null) {
                context = ent.context;
                anim = ent.array.getResourceId(animAttr, TRANSIT_NONE);
            }
        }
        if (anim != 0) {
            return AnimationUtils.loadAnimation(context, anim);
        }
        return null;
    }

    Animation loadAnimationRes(LayoutParams lp, int resId) {
        Context context = this.mContext;
        if (resId < 0) {
            return null;
        }
        Entry ent = getCachedAnimations(lp);
        if (ent != null) {
            context = ent.context;
        }
        return AnimationUtils.loadAnimation(context, resId);
    }

    private Animation loadAnimationRes(String packageName, int resId) {
        int anim = TRANSIT_NONE;
        Context context = this.mContext;
        if (resId >= 0) {
            Entry ent = getCachedAnimations(packageName, resId);
            if (ent != null) {
                context = ent.context;
                anim = resId;
            }
        }
        if (anim != 0) {
            return AnimationUtils.loadAnimation(context, anim);
        }
        return null;
    }

    private static float computePivot(int startPos, float finalScale) {
        float denom = finalScale - 1.0f;
        if (Math.abs(denom) < 1.0E-4f) {
            return (float) startPos;
        }
        return ((float) (-startPos)) / denom;
    }

    private Animation createScaleUpAnimationLocked(int transit, boolean enter, int appWidth, int appHeight) {
        Animation a;
        long duration;
        if (enter) {
            float scaleW = ((float) this.mNextAppTransitionStartWidth) / ((float) appWidth);
            float scaleH = ((float) this.mNextAppTransitionStartHeight) / ((float) appHeight);
            Animation scale = new ScaleAnimation(scaleW, 1.0f, scaleH, 1.0f, computePivot(this.mNextAppTransitionStartX, scaleW), computePivot(this.mNextAppTransitionStartY, scaleH));
            scale.setInterpolator(this.mDecelerateInterpolator);
            Animation alpha = new AlphaAnimation(0.0f, 1.0f);
            alpha.setInterpolator(this.mThumbnailFadeOutInterpolator);
            Animation set = new AnimationSet(DEBUG_APP_TRANSITIONS);
            set.addAnimation(scale);
            set.addAnimation(alpha);
            set.setDetachWallpaper(true);
            a = set;
        } else if (transit == TRANSIT_WALLPAPER_INTRA_OPEN || transit == TRANSIT_WALLPAPER_INTRA_CLOSE) {
            a = new AlphaAnimation(1.0f, 0.0f);
            a.setDetachWallpaper(true);
        } else {
            a = new AlphaAnimation(1.0f, 1.0f);
        }
        switch (transit) {
            case TRANSIT_ACTIVITY_OPEN /*6*/:
            case TRANSIT_ACTIVITY_CLOSE /*7*/:
                duration = (long) this.mConfigShortAnimTime;
                break;
            default:
                duration = 250;
                break;
        }
        a.setDuration(duration);
        a.setFillAfter(true);
        a.setInterpolator(this.mDecelerateInterpolator);
        a.initialize(appWidth, appHeight, appWidth, appHeight);
        return a;
    }

    Animation prepareThumbnailAnimationWithDuration(Animation a, int appWidth, int appHeight, int duration, Interpolator interpolator) {
        if (duration > 0) {
            a.setDuration((long) duration);
        }
        a.setFillAfter(true);
        a.setInterpolator(interpolator);
        a.initialize(appWidth, appHeight, appWidth, appHeight);
        return a;
    }

    Animation prepareThumbnailAnimation(Animation a, int appWidth, int appHeight, int transit) {
        int duration;
        switch (transit) {
            case TRANSIT_ACTIVITY_OPEN /*6*/:
            case TRANSIT_ACTIVITY_CLOSE /*7*/:
                duration = this.mConfigShortAnimTime;
                break;
            default:
                duration = DEFAULT_APP_TRANSITION_DURATION;
                break;
        }
        return prepareThumbnailAnimationWithDuration(a, appWidth, appHeight, duration, this.mDecelerateInterpolator);
    }

    int getThumbnailTransitionState(boolean enter) {
        if (enter) {
            if (this.mNextAppTransitionScaleUp) {
                return TRANSIT_NONE;
            }
            return THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN;
        } else if (this.mNextAppTransitionScaleUp) {
            return THUMBNAIL_TRANSITION_EXIT_SCALE_UP;
        } else {
            return THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN;
        }
    }

    Animation createThumbnailAspectScaleAnimationLocked(int appWidth, int appHeight, int deviceWidth, int transit) {
        Animation a;
        int thumbWidthI = this.mNextAppTransitionThumbnail.getWidth();
        float thumbWidth = thumbWidthI > 0 ? (float) thumbWidthI : 1.0f;
        int thumbHeightI = this.mNextAppTransitionThumbnail.getHeight();
        float thumbHeight = thumbHeightI > 0 ? (float) thumbHeightI : 1.0f;
        float scaleW = ((float) deviceWidth) / thumbWidth;
        float unscaledWidth = (float) deviceWidth;
        float unscaledStartY = ((float) this.mNextAppTransitionStartY) - (((thumbHeight * scaleW) - thumbHeight) / 2.0f);
        Animation alpha;
        Animation translateAnimation;
        Animation set;
        if (this.mNextAppTransitionScaleUp) {
            Animation scale = new ScaleAnimation(1.0f, scaleW, 1.0f, scaleW, ((float) this.mNextAppTransitionStartX) + (thumbWidth / 2.0f), ((float) this.mNextAppTransitionStartY) + (thumbHeight / 2.0f));
            scale.setInterpolator(this.mThumbnailFastOutSlowInInterpolator);
            scale.setDuration(325);
            alpha = new AlphaAnimation(1.0f, 0.0f);
            alpha.setInterpolator(this.mThumbnailFadeOutInterpolator);
            alpha.setDuration(325);
            translateAnimation = new TranslateAnimation(0.0f, 0.0f, 0.0f, (-unscaledStartY) + ((float) this.mNextAppTransitionInsets.top));
            translateAnimation.setInterpolator(this.mThumbnailFastOutSlowInInterpolator);
            translateAnimation.setDuration(325);
            set = new AnimationSet(DEBUG_APP_TRANSITIONS);
            set.addAnimation(scale);
            set.addAnimation(alpha);
            set.addAnimation(translateAnimation);
            a = set;
        } else {
            Animation scaleAnimation = new ScaleAnimation(scaleW, 1.0f, scaleW, 1.0f, (thumbWidth / 2.0f) + ((float) this.mNextAppTransitionStartX), (thumbHeight / 2.0f) + ((float) this.mNextAppTransitionStartY));
            scaleAnimation.setInterpolator(this.mThumbnailFastOutSlowInInterpolator);
            scaleAnimation.setDuration(325);
            alpha = new AlphaAnimation(0.0f, 1.0f);
            alpha.setInterpolator(this.mThumbnailFadeInInterpolator);
            alpha.setDuration(325);
            translateAnimation = new TranslateAnimation(0.0f, 0.0f, (-unscaledStartY) + ((float) this.mNextAppTransitionInsets.top), 0.0f);
            translateAnimation.setInterpolator(this.mThumbnailFastOutSlowInInterpolator);
            translateAnimation.setDuration(325);
            set = new AnimationSet(DEBUG_APP_TRANSITIONS);
            set.addAnimation(scaleAnimation);
            set.addAnimation(alpha);
            set.addAnimation(translateAnimation);
            a = set;
        }
        return prepareThumbnailAnimationWithDuration(a, appWidth, appHeight, TRANSIT_NONE, this.mThumbnailFastOutSlowInInterpolator);
    }

    Animation createAspectScaledThumbnailEnterExitAnimationLocked(int thumbTransitState, int appWidth, int appHeight, int orientation, int transit, Rect containingFrame, Rect contentInsets, boolean isFullScreen) {
        Animation a;
        int thumbWidthI = this.mNextAppTransitionStartWidth;
        float thumbWidth = thumbWidthI > 0 ? (float) thumbWidthI : 1.0f;
        int thumbHeightI = this.mNextAppTransitionStartHeight;
        float thumbHeight = thumbHeightI > 0 ? (float) thumbHeightI : 1.0f;
        float scale;
        int scaledTopDecor;
        int unscaledThumbHeight;
        int unscaledThumbWidth;
        Animation clipAnim;
        Animation translateAnimation;
        Animation set;
        switch (thumbTransitState) {
            case TRANSIT_NONE /*0*/:
                if (orientation == THUMBNAIL_TRANSITION_EXIT_SCALE_UP) {
                    scale = thumbWidth / ((float) appWidth);
                    scaledTopDecor = (int) (((float) contentInsets.top) * scale);
                    unscaledThumbHeight = (int) (thumbHeight / scale);
                    this.mTmpFromClipRect.set(containingFrame);
                    if (isFullScreen) {
                        this.mTmpFromClipRect.top = contentInsets.top;
                    }
                    this.mTmpFromClipRect.bottom = this.mTmpFromClipRect.top + unscaledThumbHeight;
                    this.mTmpToClipRect.set(containingFrame);
                } else {
                    scale = thumbHeight / ((float) (appHeight - contentInsets.top));
                    scaledTopDecor = (int) (((float) contentInsets.top) * scale);
                    unscaledThumbWidth = (int) (thumbWidth / scale);
                    unscaledThumbHeight = (int) (thumbHeight / scale);
                    this.mTmpFromClipRect.set(containingFrame);
                    if (isFullScreen) {
                        this.mTmpFromClipRect.top = contentInsets.top;
                        this.mTmpFromClipRect.bottom = this.mTmpFromClipRect.top + unscaledThumbHeight;
                    }
                    this.mTmpFromClipRect.right = this.mTmpFromClipRect.left + unscaledThumbWidth;
                    this.mTmpToClipRect.set(containingFrame);
                }
                this.mNextAppTransitionInsets.set(contentInsets);
                Animation scaleAnim = new ScaleAnimation(scale, 1.0f, scale, 1.0f, computePivot(this.mNextAppTransitionStartX, scale), computePivot(this.mNextAppTransitionStartY, scale));
                clipAnim = new ClipRectAnimation(this.mTmpFromClipRect, this.mTmpToClipRect);
                translateAnimation = new TranslateAnimation(0.0f, 0.0f, (float) (-scaledTopDecor), 0.0f);
                set = new AnimationSet(true);
                set.addAnimation(clipAnim);
                set.addAnimation(scaleAnim);
                set.addAnimation(translateAnimation);
                a = set;
                break;
            case THUMBNAIL_TRANSITION_EXIT_SCALE_UP /*1*/:
                if (transit != TRANSIT_WALLPAPER_INTRA_OPEN) {
                    a = new AlphaAnimation(1.0f, 1.0f);
                    break;
                }
                a = new AlphaAnimation(1.0f, 0.0f);
                break;
            case THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN /*2*/:
                if (transit != TRANSIT_WALLPAPER_INTRA_OPEN) {
                    a = new AlphaAnimation(1.0f, 1.0f);
                    break;
                }
                a = new AlphaAnimation(0.0f, 1.0f);
                break;
            case THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN /*3*/:
                if (orientation == THUMBNAIL_TRANSITION_EXIT_SCALE_UP) {
                    scale = thumbWidth / ((float) appWidth);
                    scaledTopDecor = (int) (((float) contentInsets.top) * scale);
                    unscaledThumbHeight = (int) (thumbHeight / scale);
                    this.mTmpFromClipRect.set(containingFrame);
                    this.mTmpToClipRect.set(containingFrame);
                    if (isFullScreen) {
                        this.mTmpToClipRect.top = contentInsets.top;
                    }
                    this.mTmpToClipRect.bottom = this.mTmpToClipRect.top + unscaledThumbHeight;
                } else {
                    scale = thumbHeight / ((float) (appHeight - contentInsets.top));
                    scaledTopDecor = (int) (((float) contentInsets.top) * scale);
                    unscaledThumbWidth = (int) (thumbWidth / scale);
                    unscaledThumbHeight = (int) (thumbHeight / scale);
                    this.mTmpFromClipRect.set(containingFrame);
                    this.mTmpToClipRect.set(containingFrame);
                    if (isFullScreen) {
                        this.mTmpToClipRect.top = contentInsets.top;
                        this.mTmpToClipRect.bottom = this.mTmpToClipRect.top + unscaledThumbHeight;
                    }
                    this.mTmpToClipRect.right = this.mTmpToClipRect.left + unscaledThumbWidth;
                }
                this.mNextAppTransitionInsets.set(contentInsets);
                Animation scaleAnimation = new ScaleAnimation(1.0f, scale, 1.0f, scale, computePivot(this.mNextAppTransitionStartX, scale), computePivot(this.mNextAppTransitionStartY, scale));
                clipAnim = new ClipRectAnimation(this.mTmpFromClipRect, this.mTmpToClipRect);
                translateAnimation = new TranslateAnimation(0.0f, 0.0f, 0.0f, (float) (-scaledTopDecor));
                set = new AnimationSet(true);
                set.addAnimation(clipAnim);
                set.addAnimation(scaleAnimation);
                set.addAnimation(translateAnimation);
                a = set;
                a.setZAdjustment(THUMBNAIL_TRANSITION_EXIT_SCALE_UP);
                break;
            default:
                throw new RuntimeException("Invalid thumbnail transition state");
        }
        return prepareThumbnailAnimationWithDuration(a, appWidth, appHeight, Math.max(THUMBNAIL_APP_TRANSITION_DURATION, THUMBNAIL_APP_TRANSITION_DURATION), this.mThumbnailFastOutSlowInInterpolator);
    }

    Animation createThumbnailScaleAnimationLocked(int appWidth, int appHeight, int transit) {
        Animation a;
        int thumbWidthI = this.mNextAppTransitionThumbnail.getWidth();
        float thumbWidth = thumbWidthI > 0 ? (float) thumbWidthI : 1.0f;
        int thumbHeightI = this.mNextAppTransitionThumbnail.getHeight();
        float thumbHeight = thumbHeightI > 0 ? (float) thumbHeightI : 1.0f;
        float scaleW;
        float scaleH;
        if (this.mNextAppTransitionScaleUp) {
            scaleW = ((float) appWidth) / thumbWidth;
            scaleH = ((float) appHeight) / thumbHeight;
            Animation scale = new ScaleAnimation(1.0f, scaleW, 1.0f, scaleH, computePivot(this.mNextAppTransitionStartX, 1.0f / scaleW), computePivot(this.mNextAppTransitionStartY, 1.0f / scaleH));
            scale.setInterpolator(this.mDecelerateInterpolator);
            Animation alpha = new AlphaAnimation(1.0f, 0.0f);
            alpha.setInterpolator(this.mThumbnailFadeOutInterpolator);
            Animation set = new AnimationSet(DEBUG_APP_TRANSITIONS);
            set.addAnimation(scale);
            set.addAnimation(alpha);
            a = set;
        } else {
            scaleW = ((float) appWidth) / thumbWidth;
            scaleH = ((float) appHeight) / thumbHeight;
            a = new ScaleAnimation(scaleW, 1.0f, scaleH, 1.0f, computePivot(this.mNextAppTransitionStartX, 1.0f / scaleW), computePivot(this.mNextAppTransitionStartY, 1.0f / scaleH));
        }
        return prepareThumbnailAnimation(a, appWidth, appHeight, transit);
    }

    Animation createThumbnailEnterExitAnimationLocked(int thumbTransitState, int appWidth, int appHeight, int transit) {
        Animation a;
        int thumbWidthI = this.mNextAppTransitionThumbnail.getWidth();
        float thumbWidth = thumbWidthI > 0 ? (float) thumbWidthI : 1.0f;
        int thumbHeightI = this.mNextAppTransitionThumbnail.getHeight();
        float thumbHeight = thumbHeightI > 0 ? (float) thumbHeightI : 1.0f;
        float scaleW;
        float scaleH;
        switch (thumbTransitState) {
            case TRANSIT_NONE /*0*/:
                scaleW = thumbWidth / ((float) appWidth);
                scaleH = thumbHeight / ((float) appHeight);
                a = new ScaleAnimation(scaleW, 1.0f, scaleH, 1.0f, computePivot(this.mNextAppTransitionStartX, scaleW), computePivot(this.mNextAppTransitionStartY, scaleH));
                break;
            case THUMBNAIL_TRANSITION_EXIT_SCALE_UP /*1*/:
                if (transit != TRANSIT_WALLPAPER_INTRA_OPEN) {
                    a = new AlphaAnimation(1.0f, 1.0f);
                    break;
                }
                a = new AlphaAnimation(1.0f, 0.0f);
                break;
            case THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN /*2*/:
                a = new AlphaAnimation(1.0f, 1.0f);
                break;
            case THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN /*3*/:
                scaleW = thumbWidth / ((float) appWidth);
                scaleH = thumbHeight / ((float) appHeight);
                Animation scale = new ScaleAnimation(1.0f, scaleW, 1.0f, scaleH, computePivot(this.mNextAppTransitionStartX, scaleW), computePivot(this.mNextAppTransitionStartY, scaleH));
                Animation alpha = new AlphaAnimation(1.0f, 0.0f);
                Animation animationSet = new AnimationSet(true);
                animationSet.addAnimation(scale);
                animationSet.addAnimation(alpha);
                animationSet.setZAdjustment(THUMBNAIL_TRANSITION_EXIT_SCALE_UP);
                a = animationSet;
                break;
            default:
                throw new RuntimeException("Invalid thumbnail transition state");
        }
        return prepareThumbnailAnimation(a, appWidth, appHeight, transit);
    }

    Animation loadAnimation(LayoutParams lp, int transit, boolean enter, int appWidth, int appHeight, int orientation, Rect containingFrame, Rect contentInsets, boolean isFullScreen, boolean isVoiceInteraction) {
        if (isVoiceInteraction && (transit == TRANSIT_ACTIVITY_OPEN || transit == TRANSIT_TASK_OPEN || transit == TRANSIT_TASK_TO_FRONT)) {
            int i;
            if (enter) {
                i = 17432693;
            } else {
                i = 17432694;
            }
            return loadAnimationRes(lp, i);
        } else if (isVoiceInteraction && (transit == TRANSIT_ACTIVITY_CLOSE || transit == TRANSIT_TASK_CLOSE || transit == TRANSIT_TASK_TO_BACK)) {
            return loadAnimationRes(lp, enter ? 17432691 : 17432692);
        } else if (this.mNextAppTransitionType == THUMBNAIL_TRANSITION_EXIT_SCALE_UP) {
            return loadAnimationRes(this.mNextAppTransitionPackage, enter ? this.mNextAppTransitionEnter : this.mNextAppTransitionExit);
        } else if (this.mNextAppTransitionType == TRANSIT_ACTIVITY_CLOSE) {
            return loadAnimationRes(this.mNextAppTransitionPackage, this.mNextAppTransitionInPlace);
        } else {
            if (this.mNextAppTransitionType == THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN) {
                return createScaleUpAnimationLocked(transit, enter, appWidth, appHeight);
            }
            if (this.mNextAppTransitionType == THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN || this.mNextAppTransitionType == NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN) {
                this.mNextAppTransitionScaleUp = this.mNextAppTransitionType == THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN ? true : DEBUG_APP_TRANSITIONS;
                return createThumbnailEnterExitAnimationLocked(getThumbnailTransitionState(enter), appWidth, appHeight, transit);
            } else if (this.mNextAppTransitionType == NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP || this.mNextAppTransitionType == TRANSIT_ACTIVITY_OPEN) {
                this.mNextAppTransitionScaleUp = this.mNextAppTransitionType == NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP ? true : DEBUG_APP_TRANSITIONS;
                return createAspectScaledThumbnailEnterExitAnimationLocked(getThumbnailTransitionState(enter), appWidth, appHeight, orientation, transit, containingFrame, contentInsets, isFullScreen);
            } else {
                int animAttr = TRANSIT_NONE;
                switch (transit) {
                    case TRANSIT_ACTIVITY_OPEN /*6*/:
                        animAttr = enter ? NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN : NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP;
                        break;
                    case TRANSIT_ACTIVITY_CLOSE /*7*/:
                        animAttr = enter ? TRANSIT_ACTIVITY_OPEN : TRANSIT_ACTIVITY_CLOSE;
                        break;
                    case TRANSIT_TASK_OPEN /*8*/:
                        animAttr = enter ? TRANSIT_TASK_OPEN : TRANSIT_TASK_CLOSE;
                        break;
                    case TRANSIT_TASK_CLOSE /*9*/:
                        animAttr = enter ? TRANSIT_TASK_TO_FRONT : TRANSIT_TASK_TO_BACK;
                        break;
                    case TRANSIT_TASK_TO_FRONT /*10*/:
                        animAttr = enter ? TRANSIT_WALLPAPER_CLOSE : TRANSIT_WALLPAPER_OPEN;
                        break;
                    case TRANSIT_TASK_TO_BACK /*11*/:
                        animAttr = enter ? TRANSIT_WALLPAPER_INTRA_OPEN : TRANSIT_WALLPAPER_INTRA_CLOSE;
                        break;
                    case TRANSIT_WALLPAPER_CLOSE /*12*/:
                        animAttr = enter ? 18 : 19;
                        break;
                    case TRANSIT_WALLPAPER_OPEN /*13*/:
                        animAttr = enter ? TRANSIT_TASK_OPEN_BEHIND : TRANSIT_TASK_IN_PLACE;
                        break;
                    case TRANSIT_WALLPAPER_INTRA_OPEN /*14*/:
                        animAttr = enter ? 20 : 21;
                        break;
                    case TRANSIT_WALLPAPER_INTRA_CLOSE /*15*/:
                        animAttr = enter ? 22 : 23;
                        break;
                    case TRANSIT_TASK_OPEN_BEHIND /*16*/:
                        animAttr = enter ? 25 : 24;
                        break;
                }
                return animAttr != 0 ? loadAnimationAttr(lp, animAttr) : null;
            }
        }
    }

    void postAnimationCallback() {
        if (this.mNextAppTransitionCallback != null) {
            this.mH.sendMessage(this.mH.obtainMessage(26, this.mNextAppTransitionCallback));
            this.mNextAppTransitionCallback = null;
        }
    }

    void overridePendingAppTransition(String packageName, int enterAnim, int exitAnim, IRemoteCallback startedCallback) {
        if (isTransitionSet()) {
            this.mNextAppTransitionType = THUMBNAIL_TRANSITION_EXIT_SCALE_UP;
            this.mNextAppTransitionPackage = packageName;
            this.mNextAppTransitionThumbnail = null;
            this.mNextAppTransitionEnter = enterAnim;
            this.mNextAppTransitionExit = exitAnim;
            postAnimationCallback();
            this.mNextAppTransitionCallback = startedCallback;
            return;
        }
        postAnimationCallback();
    }

    void overridePendingAppTransitionScaleUp(int startX, int startY, int startWidth, int startHeight) {
        if (isTransitionSet()) {
            this.mNextAppTransitionType = THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN;
            this.mNextAppTransitionPackage = null;
            this.mNextAppTransitionThumbnail = null;
            this.mNextAppTransitionStartX = startX;
            this.mNextAppTransitionStartY = startY;
            this.mNextAppTransitionStartWidth = startWidth;
            this.mNextAppTransitionStartHeight = startHeight;
            postAnimationCallback();
            this.mNextAppTransitionCallback = null;
        }
    }

    void overridePendingAppTransitionThumb(Bitmap srcThumb, int startX, int startY, IRemoteCallback startedCallback, boolean scaleUp) {
        if (isTransitionSet()) {
            this.mNextAppTransitionType = scaleUp ? THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN : NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN;
            this.mNextAppTransitionPackage = null;
            this.mNextAppTransitionThumbnail = srcThumb;
            this.mNextAppTransitionScaleUp = scaleUp;
            this.mNextAppTransitionStartX = startX;
            this.mNextAppTransitionStartY = startY;
            postAnimationCallback();
            this.mNextAppTransitionCallback = startedCallback;
            return;
        }
        postAnimationCallback();
    }

    void overridePendingAppTransitionAspectScaledThumb(Bitmap srcThumb, int startX, int startY, int targetWidth, int targetHeight, IRemoteCallback startedCallback, boolean scaleUp) {
        if (isTransitionSet()) {
            this.mNextAppTransitionType = scaleUp ? NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP : TRANSIT_ACTIVITY_OPEN;
            this.mNextAppTransitionPackage = null;
            this.mNextAppTransitionThumbnail = srcThumb;
            this.mNextAppTransitionScaleUp = scaleUp;
            this.mNextAppTransitionStartX = startX;
            this.mNextAppTransitionStartY = startY;
            this.mNextAppTransitionStartWidth = targetWidth;
            this.mNextAppTransitionStartHeight = targetHeight;
            postAnimationCallback();
            this.mNextAppTransitionCallback = startedCallback;
            return;
        }
        postAnimationCallback();
    }

    void overrideInPlaceAppTransition(String packageName, int anim) {
        if (isTransitionSet()) {
            this.mNextAppTransitionType = TRANSIT_ACTIVITY_CLOSE;
            this.mNextAppTransitionPackage = packageName;
            this.mNextAppTransitionInPlace = anim;
            return;
        }
        postAnimationCallback();
    }

    public String toString() {
        return "mNextAppTransition=0x" + Integer.toHexString(this.mNextAppTransition);
    }

    public static String appTransitionToString(int transition) {
        switch (transition) {
            case TRANSIT_UNSET /*-1*/:
                return "TRANSIT_UNSET";
            case TRANSIT_NONE /*0*/:
                return "TRANSIT_NONE";
            case TRANSIT_ACTIVITY_OPEN /*6*/:
                return "TRANSIT_ACTIVITY_OPEN";
            case TRANSIT_ACTIVITY_CLOSE /*7*/:
                return "TRANSIT_ACTIVITY_CLOSE";
            case TRANSIT_TASK_OPEN /*8*/:
                return "TRANSIT_TASK_OPEN";
            case TRANSIT_TASK_CLOSE /*9*/:
                return "TRANSIT_TASK_CLOSE";
            case TRANSIT_TASK_TO_FRONT /*10*/:
                return "TRANSIT_TASK_TO_FRONT";
            case TRANSIT_TASK_TO_BACK /*11*/:
                return "TRANSIT_TASK_TO_BACK";
            case TRANSIT_WALLPAPER_CLOSE /*12*/:
                return "TRANSIT_WALLPAPER_CLOSE";
            case TRANSIT_WALLPAPER_OPEN /*13*/:
                return "TRANSIT_WALLPAPER_OPEN";
            case TRANSIT_WALLPAPER_INTRA_OPEN /*14*/:
                return "TRANSIT_WALLPAPER_INTRA_OPEN";
            case TRANSIT_WALLPAPER_INTRA_CLOSE /*15*/:
                return "TRANSIT_WALLPAPER_INTRA_CLOSE";
            case TRANSIT_TASK_OPEN_BEHIND /*16*/:
                return "TRANSIT_TASK_OPEN_BEHIND";
            default:
                return "<UNKNOWN>";
        }
    }

    private String appStateToString() {
        switch (this.mAppTransitionState) {
            case TRANSIT_NONE /*0*/:
                return "APP_STATE_IDLE";
            case THUMBNAIL_TRANSITION_EXIT_SCALE_UP /*1*/:
                return "APP_STATE_READY";
            case THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN /*2*/:
                return "APP_STATE_RUNNING";
            case THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN /*3*/:
                return "APP_STATE_TIMEOUT";
            default:
                return "unknown state=" + this.mAppTransitionState;
        }
    }

    private String transitTypeToString() {
        switch (this.mNextAppTransitionType) {
            case TRANSIT_NONE /*0*/:
                return "NEXT_TRANSIT_TYPE_NONE";
            case THUMBNAIL_TRANSITION_EXIT_SCALE_UP /*1*/:
                return "NEXT_TRANSIT_TYPE_CUSTOM";
            case THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN /*2*/:
                return "NEXT_TRANSIT_TYPE_SCALE_UP";
            case THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN /*3*/:
                return "NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_UP";
            case NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN /*4*/:
                return "NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN";
            case NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP /*5*/:
                return "NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP";
            case TRANSIT_ACTIVITY_OPEN /*6*/:
                return "NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_DOWN";
            case TRANSIT_ACTIVITY_CLOSE /*7*/:
                return "NEXT_TRANSIT_TYPE_CUSTOM_IN_PLACE";
            default:
                return "unknown type=" + this.mNextAppTransitionType;
        }
    }

    public void dump(PrintWriter pw) {
        pw.print(" " + this);
        pw.print("  mAppTransitionState=");
        pw.println(appStateToString());
        if (this.mNextAppTransitionType != 0) {
            pw.print("  mNextAppTransitionType=");
            pw.println(transitTypeToString());
        }
        switch (this.mNextAppTransitionType) {
            case THUMBNAIL_TRANSITION_EXIT_SCALE_UP /*1*/:
                pw.print("  mNextAppTransitionPackage=");
                pw.println(this.mNextAppTransitionPackage);
                pw.print("  mNextAppTransitionEnter=0x");
                pw.print(Integer.toHexString(this.mNextAppTransitionEnter));
                pw.print(" mNextAppTransitionExit=0x");
                pw.println(Integer.toHexString(this.mNextAppTransitionExit));
                break;
            case THUMBNAIL_TRANSITION_ENTER_SCALE_DOWN /*2*/:
                pw.print("  mNextAppTransitionStartX=");
                pw.print(this.mNextAppTransitionStartX);
                pw.print(" mNextAppTransitionStartY=");
                pw.println(this.mNextAppTransitionStartY);
                pw.print("  mNextAppTransitionStartWidth=");
                pw.print(this.mNextAppTransitionStartWidth);
                pw.print(" mNextAppTransitionStartHeight=");
                pw.println(this.mNextAppTransitionStartHeight);
                break;
            case THUMBNAIL_TRANSITION_EXIT_SCALE_DOWN /*3*/:
            case NEXT_TRANSIT_TYPE_THUMBNAIL_SCALE_DOWN /*4*/:
            case NEXT_TRANSIT_TYPE_THUMBNAIL_ASPECT_SCALE_UP /*5*/:
            case TRANSIT_ACTIVITY_OPEN /*6*/:
                pw.print("  mNextAppTransitionThumbnail=");
                pw.print(this.mNextAppTransitionThumbnail);
                pw.print(" mNextAppTransitionStartX=");
                pw.print(this.mNextAppTransitionStartX);
                pw.print(" mNextAppTransitionStartY=");
                pw.println(this.mNextAppTransitionStartY);
                pw.print(" mNextAppTransitionStartWidth=");
                pw.print(this.mNextAppTransitionStartWidth);
                pw.print(" mNextAppTransitionStartHeight=");
                pw.println(this.mNextAppTransitionStartHeight);
                pw.print("  mNextAppTransitionScaleUp=");
                pw.println(this.mNextAppTransitionScaleUp);
                break;
            case TRANSIT_ACTIVITY_CLOSE /*7*/:
                pw.print("  mNextAppTransitionPackage=");
                pw.println(this.mNextAppTransitionPackage);
                pw.print("  mNextAppTransitionInPlace=0x");
                pw.print(Integer.toHexString(this.mNextAppTransitionInPlace));
                break;
        }
        if (this.mNextAppTransitionCallback != null) {
            pw.print("  mNextAppTransitionCallback=");
            pw.println(this.mNextAppTransitionCallback);
        }
    }

    public void setCurrentUser(int newUserId) {
        this.mCurrentUserId = newUserId;
    }
}
