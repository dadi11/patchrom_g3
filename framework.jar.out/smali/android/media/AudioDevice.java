package android.media;

import android.util.SparseIntArray;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.InputMethodManager;

public class AudioDevice {
    private static final SparseIntArray EXT_TO_INT_DEVICE_MAPPING;
    private static final SparseIntArray INT_TO_EXT_DEVICE_MAPPING;
    public static final int TYPE_AUX_LINE = 19;
    public static final int TYPE_BLUETOOTH_A2DP = 8;
    public static final int TYPE_BLUETOOTH_SCO = 7;
    public static final int TYPE_BUILTIN_EARPIECE = 1;
    public static final int TYPE_BUILTIN_MIC = 15;
    public static final int TYPE_BUILTIN_SPEAKER = 2;
    public static final int TYPE_DOCK = 13;
    public static final int TYPE_FM = 14;
    public static final int TYPE_FM_TUNER = 16;
    public static final int TYPE_HDMI = 9;
    public static final int TYPE_HDMI_ARC = 10;
    public static final int TYPE_LINE_ANALOG = 5;
    public static final int TYPE_LINE_DIGITAL = 6;
    public static final int TYPE_TELEPHONY = 18;
    public static final int TYPE_TV_TUNER = 17;
    public static final int TYPE_UNKNOWN = 0;
    public static final int TYPE_USB_ACCESSORY = 12;
    public static final int TYPE_USB_DEVICE = 11;
    public static final int TYPE_WIRED_HEADPHONES = 4;
    public static final int TYPE_WIRED_HEADSET = 3;
    AudioDevicePortConfig mConfig;

    AudioDevice(AudioDevicePortConfig config) {
        this.mConfig = new AudioDevicePortConfig(config);
    }

    public boolean isInputDevice() {
        return this.mConfig.port().role() == TYPE_BUILTIN_EARPIECE;
    }

    public boolean isOutputDevice() {
        return this.mConfig.port().role() == TYPE_BUILTIN_SPEAKER;
    }

    public int getDeviceType() {
        return INT_TO_EXT_DEVICE_MAPPING.get(this.mConfig.port().type(), TYPE_UNKNOWN);
    }

    public String getAddress() {
        return this.mConfig.port().address();
    }

    public static int convertDeviceTypeToInternalDevice(int deviceType) {
        return EXT_TO_INT_DEVICE_MAPPING.get(deviceType, TYPE_UNKNOWN);
    }

    public static int convertInternalDeviceToDeviceType(int intDevice) {
        return INT_TO_EXT_DEVICE_MAPPING.get(intDevice, TYPE_UNKNOWN);
    }

    static {
        INT_TO_EXT_DEVICE_MAPPING = new SparseIntArray();
        INT_TO_EXT_DEVICE_MAPPING.put(TYPE_BUILTIN_EARPIECE, TYPE_BUILTIN_EARPIECE);
        INT_TO_EXT_DEVICE_MAPPING.put(TYPE_BUILTIN_SPEAKER, TYPE_BUILTIN_SPEAKER);
        INT_TO_EXT_DEVICE_MAPPING.put(TYPE_WIRED_HEADPHONES, TYPE_WIRED_HEADSET);
        INT_TO_EXT_DEVICE_MAPPING.put(TYPE_BLUETOOTH_A2DP, TYPE_WIRED_HEADPHONES);
        INT_TO_EXT_DEVICE_MAPPING.put(TYPE_FM_TUNER, TYPE_BLUETOOTH_SCO);
        INT_TO_EXT_DEVICE_MAPPING.put(32, TYPE_BLUETOOTH_SCO);
        INT_TO_EXT_DEVICE_MAPPING.put(64, TYPE_BLUETOOTH_SCO);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS, TYPE_BLUETOOTH_A2DP);
        INT_TO_EXT_DEVICE_MAPPING.put(InputMethodManager.CONTROL_START_INITIAL, TYPE_BLUETOOTH_A2DP);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY, TYPE_BLUETOOTH_A2DP);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT, TYPE_HDMI);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT, TYPE_DOCK);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_SCROLL_FORWARD, TYPE_DOCK);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD, TYPE_USB_ACCESSORY);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_COPY, TYPE_USB_DEVICE);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_CUT, TYPE_TELEPHONY);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_SET_SELECTION, TYPE_LINE_ANALOG);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_EXPAND, TYPE_HDMI_ARC);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_COLLAPSE, TYPE_LINE_DIGITAL);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_DISMISS, TYPE_FM);
        INT_TO_EXT_DEVICE_MAPPING.put(AccessibilityNodeInfo.ACTION_SET_TEXT, TYPE_AUX_LINE);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_BUILTIN_MIC, TYPE_BUILTIN_MIC);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_BLUETOOTH_SCO_HEADSET, TYPE_BLUETOOTH_SCO);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_WIRED_HEADSET, TYPE_WIRED_HEADSET);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_HDMI, TYPE_HDMI);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_VOICE_CALL, TYPE_TELEPHONY);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_BACK_MIC, TYPE_BUILTIN_MIC);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_ANLG_DOCK_HEADSET, TYPE_DOCK);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_DGTL_DOCK_HEADSET, TYPE_DOCK);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_USB_ACCESSORY, TYPE_USB_ACCESSORY);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_USB_DEVICE, TYPE_USB_DEVICE);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_FM_TUNER, TYPE_FM_TUNER);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_TV_TUNER, TYPE_TV_TUNER);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_LINE, TYPE_LINE_ANALOG);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_SPDIF, TYPE_LINE_DIGITAL);
        INT_TO_EXT_DEVICE_MAPPING.put(AudioSystem.DEVICE_IN_BLUETOOTH_A2DP, TYPE_BLUETOOTH_A2DP);
        EXT_TO_INT_DEVICE_MAPPING = new SparseIntArray();
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_BUILTIN_EARPIECE, TYPE_BUILTIN_EARPIECE);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_BUILTIN_SPEAKER, TYPE_BUILTIN_SPEAKER);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_WIRED_HEADSET, TYPE_WIRED_HEADPHONES);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_WIRED_HEADPHONES, TYPE_BLUETOOTH_A2DP);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_LINE_ANALOG, AccessibilityNodeInfo.ACTION_SET_SELECTION);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_LINE_DIGITAL, AccessibilityNodeInfo.ACTION_COLLAPSE);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_BLUETOOTH_SCO, TYPE_FM_TUNER);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_BLUETOOTH_A2DP, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_HDMI, AccessibilityNodeInfo.ACTION_NEXT_HTML_ELEMENT);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_HDMI_ARC, AccessibilityNodeInfo.ACTION_EXPAND);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_USB_DEVICE, AccessibilityNodeInfo.ACTION_COPY);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_USB_ACCESSORY, AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_DOCK, AccessibilityNodeInfo.ACTION_PREVIOUS_HTML_ELEMENT);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_FM, AccessibilityNodeInfo.ACTION_DISMISS);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_BUILTIN_MIC, AudioSystem.DEVICE_IN_BUILTIN_MIC);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_FM_TUNER, AudioSystem.DEVICE_IN_FM_TUNER);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_TV_TUNER, AudioSystem.DEVICE_IN_TV_TUNER);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_TELEPHONY, AccessibilityNodeInfo.ACTION_CUT);
        EXT_TO_INT_DEVICE_MAPPING.put(TYPE_AUX_LINE, AccessibilityNodeInfo.ACTION_SET_TEXT);
    }
}
