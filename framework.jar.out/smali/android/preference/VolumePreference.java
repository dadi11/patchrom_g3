package android.preference;

import android.app.Dialog;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.preference.Preference.BaseSavedState;
import android.preference.PreferenceManager.OnActivityStopListener;
import android.preference.SeekBarVolumizer.Callback;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnKeyListener;
import android.widget.SeekBar;
import com.android.internal.R;

public class VolumePreference extends SeekBarDialogPreference implements OnActivityStopListener, OnKeyListener, Callback {
    static final String TAG = "VolumePreference";
    private SeekBarVolumizer mSeekBarVolumizer;
    private int mStreamType;

    private static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        VolumeStore mVolumeStore;

        /* renamed from: android.preference.VolumePreference.SavedState.1 */
        static class C06521 implements Creator<SavedState> {
            C06521() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(in);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        public SavedState(Parcel source) {
            super(source);
            this.mVolumeStore = new VolumeStore();
            this.mVolumeStore.volume = source.readInt();
            this.mVolumeStore.originalVolume = source.readInt();
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.mVolumeStore.volume);
            dest.writeInt(this.mVolumeStore.originalVolume);
        }

        VolumeStore getVolumeStore() {
            return this.mVolumeStore;
        }

        public SavedState(Parcelable superState) {
            super(superState);
            this.mVolumeStore = new VolumeStore();
        }

        static {
            CREATOR = new C06521();
        }
    }

    public static class VolumeStore {
        public int originalVolume;
        public int volume;

        public VolumeStore() {
            this.volume = -1;
            this.originalVolume = -1;
        }
    }

    public VolumePreference(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.VolumePreference, defStyleAttr, defStyleRes);
        this.mStreamType = a.getInt(0, 0);
        a.recycle();
    }

    public VolumePreference(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public VolumePreference(Context context, AttributeSet attrs) {
        this(context, attrs, 16842897);
    }

    public void setStreamType(int streamType) {
        this.mStreamType = streamType;
    }

    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);
        SeekBar seekBar = (SeekBar) view.findViewById(16909154);
        this.mSeekBarVolumizer = new SeekBarVolumizer(getContext(), this.mStreamType, null, this);
        this.mSeekBarVolumizer.start();
        this.mSeekBarVolumizer.setSeekBar(seekBar);
        getPreferenceManager().registerOnActivityStopListener(this);
        view.setOnKeyListener(this);
        view.setFocusableInTouchMode(true);
        view.requestFocus();
    }

    public boolean onKey(View v, int keyCode, KeyEvent event) {
        if (this.mSeekBarVolumizer == null) {
            return true;
        }
        boolean isdown;
        if (event.getAction() == 0) {
            isdown = true;
        } else {
            isdown = false;
        }
        switch (keyCode) {
            case MotionEvent.AXIS_DISTANCE /*24*/:
                if (!isdown) {
                    return true;
                }
                this.mSeekBarVolumizer.changeVolumeBy(1);
                return true;
            case MotionEvent.AXIS_TILT /*25*/:
                if (!isdown) {
                    return true;
                }
                this.mSeekBarVolumizer.changeVolumeBy(-1);
                return true;
            case KeyEvent.KEYCODE_VOLUME_MUTE /*164*/:
                if (!isdown) {
                    return true;
                }
                this.mSeekBarVolumizer.muteVolume();
                return true;
            default:
                return false;
        }
    }

    protected void onDialogClosed(boolean positiveResult) {
        super.onDialogClosed(positiveResult);
        if (!(positiveResult || this.mSeekBarVolumizer == null)) {
            this.mSeekBarVolumizer.revertVolume();
        }
        cleanup();
    }

    public void onActivityStop() {
        if (this.mSeekBarVolumizer != null) {
            this.mSeekBarVolumizer.stopSample();
        }
    }

    private void cleanup() {
        getPreferenceManager().unregisterOnActivityStopListener(this);
        if (this.mSeekBarVolumizer != null) {
            Dialog dialog = getDialog();
            if (dialog != null && dialog.isShowing()) {
                View view = dialog.getWindow().getDecorView().findViewById(16909154);
                if (view != null) {
                    view.setOnKeyListener(null);
                }
                this.mSeekBarVolumizer.revertVolume();
            }
            this.mSeekBarVolumizer.stop();
            this.mSeekBarVolumizer = null;
        }
    }

    public void onSampleStarting(SeekBarVolumizer volumizer) {
        if (this.mSeekBarVolumizer != null && volumizer != this.mSeekBarVolumizer) {
            this.mSeekBarVolumizer.stopSample();
        }
    }

    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromTouch) {
    }

    public void onMuted(boolean muted) {
    }

    protected Parcelable onSaveInstanceState() {
        Parcelable superState = super.onSaveInstanceState();
        if (isPersistent()) {
            return superState;
        }
        SavedState myState = new SavedState(superState);
        if (this.mSeekBarVolumizer != null) {
            this.mSeekBarVolumizer.onSaveInstanceState(myState.getVolumeStore());
        }
        return myState;
    }

    protected void onRestoreInstanceState(Parcelable state) {
        if (state == null || !state.getClass().equals(SavedState.class)) {
            super.onRestoreInstanceState(state);
            return;
        }
        SavedState myState = (SavedState) state;
        super.onRestoreInstanceState(myState.getSuperState());
        if (this.mSeekBarVolumizer != null) {
            this.mSeekBarVolumizer.onRestoreInstanceState(myState.getVolumeStore());
        }
    }
}
