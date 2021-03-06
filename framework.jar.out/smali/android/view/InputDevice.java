package android.view;

import android.hardware.Camera.Parameters;
import android.hardware.input.InputDeviceIdentifier;
import android.hardware.input.InputManager;
import android.os.NullVibrator;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.Vibrator;
import java.util.ArrayList;
import java.util.List;

public final class InputDevice implements Parcelable {
    public static final Creator<InputDevice> CREATOR;
    public static final int KEYBOARD_TYPE_ALPHABETIC = 2;
    public static final int KEYBOARD_TYPE_NONE = 0;
    public static final int KEYBOARD_TYPE_NON_ALPHABETIC = 1;
    @Deprecated
    public static final int MOTION_RANGE_ORIENTATION = 8;
    @Deprecated
    public static final int MOTION_RANGE_PRESSURE = 2;
    @Deprecated
    public static final int MOTION_RANGE_SIZE = 3;
    @Deprecated
    public static final int MOTION_RANGE_TOOL_MAJOR = 6;
    @Deprecated
    public static final int MOTION_RANGE_TOOL_MINOR = 7;
    @Deprecated
    public static final int MOTION_RANGE_TOUCH_MAJOR = 4;
    @Deprecated
    public static final int MOTION_RANGE_TOUCH_MINOR = 5;
    @Deprecated
    public static final int MOTION_RANGE_X = 0;
    @Deprecated
    public static final int MOTION_RANGE_Y = 1;
    public static final int SOURCE_ANY = -256;
    public static final int SOURCE_CLASS_BUTTON = 1;
    public static final int SOURCE_CLASS_JOYSTICK = 16;
    public static final int SOURCE_CLASS_MASK = 255;
    public static final int SOURCE_CLASS_NONE = 0;
    public static final int SOURCE_CLASS_POINTER = 2;
    public static final int SOURCE_CLASS_POSITION = 8;
    public static final int SOURCE_CLASS_TRACKBALL = 4;
    public static final int SOURCE_DPAD = 513;
    public static final int SOURCE_GAMEPAD = 1025;
    public static final int SOURCE_HDMI = 33554433;
    public static final int SOURCE_JOYSTICK = 16777232;
    public static final int SOURCE_KEYBOARD = 257;
    public static final int SOURCE_MOUSE = 8194;
    public static final int SOURCE_STYLUS = 16386;
    public static final int SOURCE_TOUCHPAD = 1048584;
    public static final int SOURCE_TOUCHSCREEN = 4098;
    public static final int SOURCE_TOUCH_NAVIGATION = 2097152;
    public static final int SOURCE_TRACKBALL = 65540;
    public static final int SOURCE_UNKNOWN = 0;
    private final int mControllerNumber;
    private final String mDescriptor;
    private final int mGeneration;
    private final boolean mHasButtonUnderPad;
    private final boolean mHasVibrator;
    private final int mId;
    private final InputDeviceIdentifier mIdentifier;
    private final boolean mIsExternal;
    private final KeyCharacterMap mKeyCharacterMap;
    private final int mKeyboardType;
    private final ArrayList<MotionRange> mMotionRanges;
    private final String mName;
    private final int mProductId;
    private final int mSources;
    private final int mVendorId;
    private Vibrator mVibrator;

    /* renamed from: android.view.InputDevice.1 */
    static class C08191 implements Creator<InputDevice> {
        C08191() {
        }

        public InputDevice createFromParcel(Parcel in) {
            return new InputDevice(null);
        }

        public InputDevice[] newArray(int size) {
            return new InputDevice[size];
        }
    }

    public static final class MotionRange {
        private int mAxis;
        private float mFlat;
        private float mFuzz;
        private float mMax;
        private float mMin;
        private float mResolution;
        private int mSource;

        private MotionRange(int axis, int source, float min, float max, float flat, float fuzz, float resolution) {
            this.mAxis = axis;
            this.mSource = source;
            this.mMin = min;
            this.mMax = max;
            this.mFlat = flat;
            this.mFuzz = fuzz;
            this.mResolution = resolution;
        }

        public int getAxis() {
            return this.mAxis;
        }

        public int getSource() {
            return this.mSource;
        }

        public boolean isFromSource(int source) {
            return (getSource() & source) == source;
        }

        public float getMin() {
            return this.mMin;
        }

        public float getMax() {
            return this.mMax;
        }

        public float getRange() {
            return this.mMax - this.mMin;
        }

        public float getFlat() {
            return this.mFlat;
        }

        public float getFuzz() {
            return this.mFuzz;
        }

        public float getResolution() {
            return this.mResolution;
        }
    }

    static {
        CREATOR = new C08191();
    }

    private InputDevice(int id, int generation, int controllerNumber, String name, int vendorId, int productId, String descriptor, boolean isExternal, int sources, int keyboardType, KeyCharacterMap keyCharacterMap, boolean hasVibrator, boolean hasButtonUnderPad) {
        this.mMotionRanges = new ArrayList();
        this.mId = id;
        this.mGeneration = generation;
        this.mControllerNumber = controllerNumber;
        this.mName = name;
        this.mVendorId = vendorId;
        this.mProductId = productId;
        this.mDescriptor = descriptor;
        this.mIsExternal = isExternal;
        this.mSources = sources;
        this.mKeyboardType = keyboardType;
        this.mKeyCharacterMap = keyCharacterMap;
        this.mHasVibrator = hasVibrator;
        this.mHasButtonUnderPad = hasButtonUnderPad;
        this.mIdentifier = new InputDeviceIdentifier(descriptor, vendorId, productId);
    }

    private InputDevice(Parcel in) {
        boolean z;
        boolean z2 = true;
        this.mMotionRanges = new ArrayList();
        this.mId = in.readInt();
        this.mGeneration = in.readInt();
        this.mControllerNumber = in.readInt();
        this.mName = in.readString();
        this.mVendorId = in.readInt();
        this.mProductId = in.readInt();
        this.mDescriptor = in.readString();
        if (in.readInt() != 0) {
            z = true;
        } else {
            z = false;
        }
        this.mIsExternal = z;
        this.mSources = in.readInt();
        this.mKeyboardType = in.readInt();
        this.mKeyCharacterMap = (KeyCharacterMap) KeyCharacterMap.CREATOR.createFromParcel(in);
        if (in.readInt() != 0) {
            z = true;
        } else {
            z = false;
        }
        this.mHasVibrator = z;
        if (in.readInt() == 0) {
            z2 = false;
        }
        this.mHasButtonUnderPad = z2;
        this.mIdentifier = new InputDeviceIdentifier(this.mDescriptor, this.mVendorId, this.mProductId);
        while (true) {
            int axis = in.readInt();
            if (axis >= 0) {
                addMotionRange(axis, in.readInt(), in.readFloat(), in.readFloat(), in.readFloat(), in.readFloat(), in.readFloat());
            } else {
                return;
            }
        }
    }

    public static InputDevice getDevice(int id) {
        return InputManager.getInstance().getInputDevice(id);
    }

    public static int[] getDeviceIds() {
        return InputManager.getInstance().getInputDeviceIds();
    }

    public int getId() {
        return this.mId;
    }

    public int getControllerNumber() {
        return this.mControllerNumber;
    }

    public InputDeviceIdentifier getIdentifier() {
        return this.mIdentifier;
    }

    public int getGeneration() {
        return this.mGeneration;
    }

    public int getVendorId() {
        return this.mVendorId;
    }

    public int getProductId() {
        return this.mProductId;
    }

    public String getDescriptor() {
        return this.mDescriptor;
    }

    public boolean isVirtual() {
        return this.mId < 0;
    }

    public boolean isExternal() {
        return this.mIsExternal;
    }

    public boolean isFullKeyboard() {
        return (this.mSources & SOURCE_KEYBOARD) == SOURCE_KEYBOARD && this.mKeyboardType == SOURCE_CLASS_POINTER;
    }

    public String getName() {
        return this.mName;
    }

    public int getSources() {
        return this.mSources;
    }

    public boolean supportsSource(int source) {
        return (this.mSources & source) == source;
    }

    public int getKeyboardType() {
        return this.mKeyboardType;
    }

    public KeyCharacterMap getKeyCharacterMap() {
        return this.mKeyCharacterMap;
    }

    public boolean[] hasKeys(int... keys) {
        return InputManager.getInstance().deviceHasKeys(this.mId, keys);
    }

    public MotionRange getMotionRange(int axis) {
        int numRanges = this.mMotionRanges.size();
        for (int i = SOURCE_CLASS_NONE; i < numRanges; i += SOURCE_CLASS_BUTTON) {
            MotionRange range = (MotionRange) this.mMotionRanges.get(i);
            if (range.mAxis == axis) {
                return range;
            }
        }
        return null;
    }

    public MotionRange getMotionRange(int axis, int source) {
        int numRanges = this.mMotionRanges.size();
        for (int i = SOURCE_CLASS_NONE; i < numRanges; i += SOURCE_CLASS_BUTTON) {
            MotionRange range = (MotionRange) this.mMotionRanges.get(i);
            if (range.mAxis == axis && range.mSource == source) {
                return range;
            }
        }
        return null;
    }

    public List<MotionRange> getMotionRanges() {
        return this.mMotionRanges;
    }

    private void addMotionRange(int axis, int source, float min, float max, float flat, float fuzz, float resolution) {
        this.mMotionRanges.add(new MotionRange(source, min, max, flat, fuzz, resolution, null));
    }

    public Vibrator getVibrator() {
        Vibrator vibrator;
        synchronized (this.mMotionRanges) {
            if (this.mVibrator == null) {
                if (this.mHasVibrator) {
                    this.mVibrator = InputManager.getInstance().getInputDeviceVibrator(this.mId);
                } else {
                    this.mVibrator = NullVibrator.getInstance();
                }
            }
            vibrator = this.mVibrator;
        }
        return vibrator;
    }

    public boolean hasButtonUnderPad() {
        return this.mHasButtonUnderPad;
    }

    public void writeToParcel(Parcel out, int flags) {
        int i;
        int i2 = SOURCE_CLASS_BUTTON;
        out.writeInt(this.mId);
        out.writeInt(this.mGeneration);
        out.writeInt(this.mControllerNumber);
        out.writeString(this.mName);
        out.writeInt(this.mVendorId);
        out.writeInt(this.mProductId);
        out.writeString(this.mDescriptor);
        if (this.mIsExternal) {
            i = SOURCE_CLASS_BUTTON;
        } else {
            i = SOURCE_CLASS_NONE;
        }
        out.writeInt(i);
        out.writeInt(this.mSources);
        out.writeInt(this.mKeyboardType);
        this.mKeyCharacterMap.writeToParcel(out, flags);
        if (this.mHasVibrator) {
            i = SOURCE_CLASS_BUTTON;
        } else {
            i = SOURCE_CLASS_NONE;
        }
        out.writeInt(i);
        if (!this.mHasButtonUnderPad) {
            i2 = SOURCE_CLASS_NONE;
        }
        out.writeInt(i2);
        int numRanges = this.mMotionRanges.size();
        for (int i3 = SOURCE_CLASS_NONE; i3 < numRanges; i3 += SOURCE_CLASS_BUTTON) {
            MotionRange range = (MotionRange) this.mMotionRanges.get(i3);
            out.writeInt(range.mAxis);
            out.writeInt(range.mSource);
            out.writeFloat(range.mMin);
            out.writeFloat(range.mMax);
            out.writeFloat(range.mFlat);
            out.writeFloat(range.mFuzz);
            out.writeFloat(range.mResolution);
        }
        out.writeInt(-1);
    }

    public int describeContents() {
        return SOURCE_CLASS_NONE;
    }

    public String toString() {
        StringBuilder description = new StringBuilder();
        description.append("Input Device ").append(this.mId).append(": ").append(this.mName).append("\n");
        description.append("  Descriptor: ").append(this.mDescriptor).append("\n");
        description.append("  Generation: ").append(this.mGeneration).append("\n");
        description.append("  Location: ").append(this.mIsExternal ? "external" : "built-in").append("\n");
        description.append("  Keyboard Type: ");
        switch (this.mKeyboardType) {
            case SOURCE_CLASS_NONE /*0*/:
                description.append(Parameters.EFFECT_NONE);
                break;
            case SOURCE_CLASS_BUTTON /*1*/:
                description.append("non-alphabetic");
                break;
            case SOURCE_CLASS_POINTER /*2*/:
                description.append("alphabetic");
                break;
        }
        description.append("\n");
        description.append("  Has Vibrator: ").append(this.mHasVibrator).append("\n");
        description.append("  Sources: 0x").append(Integer.toHexString(this.mSources)).append(" (");
        appendSourceDescriptionIfApplicable(description, SOURCE_KEYBOARD, "keyboard");
        appendSourceDescriptionIfApplicable(description, SOURCE_DPAD, "dpad");
        appendSourceDescriptionIfApplicable(description, SOURCE_TOUCHSCREEN, "touchscreen");
        appendSourceDescriptionIfApplicable(description, SOURCE_MOUSE, "mouse");
        appendSourceDescriptionIfApplicable(description, SOURCE_STYLUS, "stylus");
        appendSourceDescriptionIfApplicable(description, SOURCE_TRACKBALL, "trackball");
        appendSourceDescriptionIfApplicable(description, SOURCE_TOUCHPAD, "touchpad");
        appendSourceDescriptionIfApplicable(description, SOURCE_JOYSTICK, "joystick");
        appendSourceDescriptionIfApplicable(description, SOURCE_GAMEPAD, "gamepad");
        description.append(" )\n");
        int numAxes = this.mMotionRanges.size();
        for (int i = SOURCE_CLASS_NONE; i < numAxes; i += SOURCE_CLASS_BUTTON) {
            MotionRange range = (MotionRange) this.mMotionRanges.get(i);
            description.append("    ").append(MotionEvent.axisToString(range.mAxis));
            description.append(": source=0x").append(Integer.toHexString(range.mSource));
            description.append(" min=").append(range.mMin);
            description.append(" max=").append(range.mMax);
            description.append(" flat=").append(range.mFlat);
            description.append(" fuzz=").append(range.mFuzz);
            description.append(" resolution=").append(range.mResolution);
            description.append("\n");
        }
        return description.toString();
    }

    private void appendSourceDescriptionIfApplicable(StringBuilder description, int source, String sourceName) {
        if ((this.mSources & source) == source) {
            description.append(" ");
            description.append(sourceName);
        }
    }
}
