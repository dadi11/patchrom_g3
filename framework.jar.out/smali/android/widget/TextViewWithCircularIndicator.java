package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Paint.Style;
import android.graphics.Typeface;
import android.util.AttributeSet;
import com.android.internal.R;

class TextViewWithCircularIndicator extends TextView {
    private static final int SELECTED_CIRCLE_ALPHA = 60;
    private int mCircleColor;
    private final Paint mCirclePaint;
    private boolean mDrawIndicator;
    private final String mItemIsSelectedText;

    public TextViewWithCircularIndicator(Context context) {
        this(context, null);
    }

    public TextViewWithCircularIndicator(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public TextViewWithCircularIndicator(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public TextViewWithCircularIndicator(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs);
        this.mCirclePaint = new Paint();
        TypedArray a = this.mContext.obtainStyledAttributes(attrs, R.styleable.DatePicker, defStyleAttr, defStyleRes);
        int resId = a.getResourceId(13, -1);
        if (resId != -1) {
            setTextAppearance(context, resId);
        }
        this.mItemIsSelectedText = context.getResources().getString(17041039);
        a.recycle();
        init();
    }

    private void init() {
        this.mCirclePaint.setTypeface(Typeface.create(this.mCirclePaint.getTypeface(), 1));
        this.mCirclePaint.setAntiAlias(true);
        this.mCirclePaint.setTextAlign(Align.CENTER);
        this.mCirclePaint.setStyle(Style.FILL);
    }

    public void setCircleColor(int color) {
        if (color != this.mCircleColor) {
            this.mCircleColor = color;
            this.mCirclePaint.setColor(this.mCircleColor);
            this.mCirclePaint.setAlpha(SELECTED_CIRCLE_ALPHA);
            requestLayout();
        }
    }

    public void setDrawIndicator(boolean drawIndicator) {
        this.mDrawIndicator = drawIndicator;
    }

    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (this.mDrawIndicator) {
            int width = getWidth();
            int height = getHeight();
            canvas.drawCircle((float) (width / 2), (float) (height / 2), (float) (Math.min(width, height) / 2), this.mCirclePaint);
        }
    }

    public CharSequence getContentDescription() {
        CharSequence itemText = getText();
        if (!this.mDrawIndicator) {
            return itemText;
        }
        return String.format(this.mItemIsSelectedText, new Object[]{itemText});
    }
}
