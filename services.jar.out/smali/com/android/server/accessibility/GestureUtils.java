package com.android.server.accessibility;

import android.util.MathUtils;
import android.view.MotionEvent;

final class GestureUtils {
    private GestureUtils() {
    }

    public static boolean isTap(MotionEvent down, MotionEvent up, int tapTimeSlop, int tapDistanceSlop, int actionIndex) {
        return eventsWithinTimeAndDistanceSlop(down, up, tapTimeSlop, tapDistanceSlop, actionIndex);
    }

    public static boolean isMultiTap(MotionEvent firstUp, MotionEvent secondUp, int multiTapTimeSlop, int multiTapDistanceSlop, int actionIndex) {
        return eventsWithinTimeAndDistanceSlop(firstUp, secondUp, multiTapTimeSlop, multiTapDistanceSlop, actionIndex);
    }

    private static boolean eventsWithinTimeAndDistanceSlop(MotionEvent first, MotionEvent second, int timeout, int distance, int actionIndex) {
        if (!isTimedOut(first, second, timeout) && computeDistance(first, second, actionIndex) < ((double) distance)) {
            return true;
        }
        return false;
    }

    public static double computeDistance(MotionEvent first, MotionEvent second, int pointerIndex) {
        return (double) MathUtils.dist(first.getX(pointerIndex), first.getY(pointerIndex), second.getX(pointerIndex), second.getY(pointerIndex));
    }

    public static boolean isTimedOut(MotionEvent firstUp, MotionEvent secondUp, int timeout) {
        return secondUp.getEventTime() - firstUp.getEventTime() >= ((long) timeout);
    }

    public static boolean isSamePointerContext(MotionEvent first, MotionEvent second) {
        return first.getPointerIdBits() == second.getPointerIdBits() && first.getPointerId(first.getActionIndex()) == second.getPointerId(second.getActionIndex());
    }

    public static boolean isDraggingGesture(float firstPtrDownX, float firstPtrDownY, float secondPtrDownX, float secondPtrDownY, float firstPtrX, float firstPtrY, float secondPtrX, float secondPtrY, float maxDraggingAngleCos) {
        float firstDeltaX = firstPtrX - firstPtrDownX;
        float firstDeltaY = firstPtrY - firstPtrDownY;
        if (firstDeltaX == 0.0f && firstDeltaY == 0.0f) {
            return true;
        }
        float firstXNormalized;
        float firstYNormalized;
        float firstMagnitude = (float) Math.sqrt((double) ((firstDeltaX * firstDeltaX) + (firstDeltaY * firstDeltaY)));
        if (firstMagnitude > 0.0f) {
            firstXNormalized = firstDeltaX / firstMagnitude;
        } else {
            firstXNormalized = firstDeltaX;
        }
        if (firstMagnitude > 0.0f) {
            firstYNormalized = firstDeltaY / firstMagnitude;
        } else {
            firstYNormalized = firstDeltaY;
        }
        float secondDeltaX = secondPtrX - secondPtrDownX;
        float secondDeltaY = secondPtrY - secondPtrDownY;
        if (secondDeltaX == 0.0f && secondDeltaY == 0.0f) {
            return true;
        }
        float secondXNormalized;
        float secondYNormalized;
        float secondMagnitude = (float) Math.sqrt((double) ((secondDeltaX * secondDeltaX) + (secondDeltaY * secondDeltaY)));
        if (secondMagnitude > 0.0f) {
            secondXNormalized = secondDeltaX / secondMagnitude;
        } else {
            secondXNormalized = secondDeltaX;
        }
        if (secondMagnitude > 0.0f) {
            secondYNormalized = secondDeltaY / secondMagnitude;
        } else {
            secondYNormalized = secondDeltaY;
        }
        if ((firstXNormalized * secondXNormalized) + (firstYNormalized * secondYNormalized) < maxDraggingAngleCos) {
            return false;
        }
        return true;
    }
}
