package android.preference;

import android.C0000R;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.SeekBar;

public class SeekBarDialogPreference extends DialogPreference {
    private static final String TAG = "SeekBarDialogPreference";
    private Drawable mMyIcon;

    public SeekBarDialogPreference(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        setDialogLayoutResource(17367233);
        createActionButtons();
        this.mMyIcon = getDialogIcon();
        setDialogIcon(null);
    }

    public SeekBarDialogPreference(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public SeekBarDialogPreference(Context context, AttributeSet attrs) {
        this(context, attrs, 16842897);
    }

    public SeekBarDialogPreference(Context context) {
        this(context, null);
    }

    public void createActionButtons() {
        setPositiveButtonText((int) C0000R.string.ok);
        setNegativeButtonText((int) C0000R.string.cancel);
    }

    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);
        ImageView iconView = (ImageView) view.findViewById(C0000R.id.icon);
        if (this.mMyIcon != null) {
            iconView.setImageDrawable(this.mMyIcon);
        } else {
            iconView.setVisibility(8);
        }
    }

    protected static SeekBar getSeekBar(View dialogView) {
        return (SeekBar) dialogView.findViewById(16909154);
    }
}
