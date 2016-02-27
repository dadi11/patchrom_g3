package android.media.tv;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.ServiceInfo;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.drawable.Drawable;
import android.hardware.hdmi.HdmiDeviceInfo;
import android.net.Uri;
import android.os.FileObserver;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.SparseIntArray;
import android.util.Xml;
import com.android.internal.R;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.xmlpull.v1.XmlPullParserException;

public final class TvInputInfo implements Parcelable {
    public static final Creator<TvInputInfo> CREATOR;
    private static final boolean DEBUG = false;
    private static final String DELIMITER_INFO_IN_ID = "/";
    public static final String EXTRA_INPUT_ID = "android.media.tv.extra.INPUT_ID";
    private static final int LENGTH_HDMI_DEVICE_ID = 2;
    private static final int LENGTH_HDMI_PHYSICAL_ADDRESS = 4;
    private static final String PREFIX_HARDWARE_DEVICE = "HW";
    private static final String PREFIX_HDMI_DEVICE = "HDMI";
    private static final String TAG = "TvInputInfo";
    public static final int TYPE_COMPONENT = 1004;
    public static final int TYPE_COMPOSITE = 1001;
    public static final int TYPE_DISPLAY_PORT = 1008;
    public static final int TYPE_DVI = 1006;
    public static final int TYPE_HDMI = 1007;
    public static final int TYPE_OTHER = 1000;
    public static final int TYPE_SCART = 1003;
    public static final int TYPE_SVIDEO = 1002;
    public static final int TYPE_TUNER = 0;
    public static final int TYPE_VGA = 1005;
    private static final String XML_START_TAG_NAME = "tv-input";
    private static SparseIntArray sHardwareTypeToTvInputType;
    private HdmiDeviceInfo mHdmiDeviceInfo;
    private Uri mIconUri;
    private final String mId;
    private boolean mIsConnectedToHdmiSwitch;
    private String mLabel;
    private final String mParentId;
    private final ResolveInfo mService;
    private String mSettingsActivity;
    private String mSetupActivity;
    private int mType;

    /* renamed from: android.media.tv.TvInputInfo.1 */
    static class C04381 implements Creator<TvInputInfo> {
        C04381() {
        }

        public TvInputInfo createFromParcel(Parcel in) {
            return new TvInputInfo(null);
        }

        public TvInputInfo[] newArray(int size) {
            return new TvInputInfo[size];
        }
    }

    public static final class TvInputSettings {
        private static final String CUSTOM_NAME_SEPARATOR = ",";
        private static final String TV_INPUT_SEPARATOR = ":";

        private TvInputSettings() {
        }

        private static boolean isHidden(Context context, String inputId, int userId) {
            return getHiddenTvInputIds(context, userId).contains(inputId);
        }

        private static String getCustomLabel(Context context, String inputId, int userId) {
            return (String) getCustomLabels(context, userId).get(inputId);
        }

        public static Set<String> getHiddenTvInputIds(Context context, int userId) {
            String hiddenIdsString = Secure.getStringForUser(context.getContentResolver(), "tv_input_hidden_inputs", userId);
            Set<String> set = new HashSet();
            if (!TextUtils.isEmpty(hiddenIdsString)) {
                String[] arr$ = hiddenIdsString.split(TV_INPUT_SEPARATOR);
                int len$ = arr$.length;
                for (int i$ = TvInputInfo.TYPE_TUNER; i$ < len$; i$++) {
                    set.add(Uri.decode(arr$[i$]));
                }
            }
            return set;
        }

        public static Map<String, String> getCustomLabels(Context context, int userId) {
            String labelsString = Secure.getStringForUser(context.getContentResolver(), "tv_input_custom_labels", userId);
            Map<String, String> map = new HashMap();
            if (!TextUtils.isEmpty(labelsString)) {
                String[] arr$ = labelsString.split(TV_INPUT_SEPARATOR);
                int len$ = arr$.length;
                for (int i$ = TvInputInfo.TYPE_TUNER; i$ < len$; i$++) {
                    String[] pair = arr$[i$].split(CUSTOM_NAME_SEPARATOR);
                    map.put(Uri.decode(pair[TvInputInfo.TYPE_TUNER]), Uri.decode(pair[1]));
                }
            }
            return map;
        }

        public static void putHiddenTvInputs(Context context, Set<String> hiddenInputIds, int userId) {
            StringBuilder builder = new StringBuilder();
            boolean firstItem = true;
            for (String inputId : hiddenInputIds) {
                ensureValidField(inputId);
                if (firstItem) {
                    firstItem = TvInputInfo.DEBUG;
                } else {
                    builder.append(TV_INPUT_SEPARATOR);
                }
                builder.append(Uri.encode(inputId));
            }
            Secure.putStringForUser(context.getContentResolver(), "tv_input_hidden_inputs", builder.toString(), userId);
        }

        public static void putCustomLabels(Context context, Map<String, String> customLabels, int userId) {
            StringBuilder builder = new StringBuilder();
            boolean firstItem = true;
            for (Entry<String, String> entry : customLabels.entrySet()) {
                ensureValidField((String) entry.getKey());
                ensureValidField((String) entry.getValue());
                if (firstItem) {
                    firstItem = TvInputInfo.DEBUG;
                } else {
                    builder.append(TV_INPUT_SEPARATOR);
                }
                builder.append(Uri.encode((String) entry.getKey()));
                builder.append(CUSTOM_NAME_SEPARATOR);
                builder.append(Uri.encode((String) entry.getValue()));
            }
            Secure.putStringForUser(context.getContentResolver(), "tv_input_custom_labels", builder.toString(), userId);
        }

        private static void ensureValidField(String value) {
            if (TextUtils.isEmpty(value)) {
                throw new IllegalArgumentException(value + " should not empty ");
            }
        }
    }

    static {
        sHardwareTypeToTvInputType = new SparseIntArray();
        sHardwareTypeToTvInputType.put(1, TYPE_OTHER);
        sHardwareTypeToTvInputType.put(LENGTH_HDMI_DEVICE_ID, TYPE_TUNER);
        sHardwareTypeToTvInputType.put(3, TYPE_COMPOSITE);
        sHardwareTypeToTvInputType.put(LENGTH_HDMI_PHYSICAL_ADDRESS, TYPE_SVIDEO);
        sHardwareTypeToTvInputType.put(5, TYPE_SCART);
        sHardwareTypeToTvInputType.put(6, TYPE_COMPONENT);
        sHardwareTypeToTvInputType.put(7, TYPE_VGA);
        sHardwareTypeToTvInputType.put(8, TYPE_DVI);
        sHardwareTypeToTvInputType.put(9, TYPE_HDMI);
        sHardwareTypeToTvInputType.put(10, TYPE_DISPLAY_PORT);
        CREATOR = new C04381();
    }

    public static TvInputInfo createTvInputInfo(Context context, ResolveInfo service) throws XmlPullParserException, IOException {
        return createTvInputInfo(context, service, generateInputIdForComponentName(new ComponentName(service.serviceInfo.packageName, service.serviceInfo.name)), null, TYPE_TUNER, null, null, DEBUG);
    }

    public static TvInputInfo createTvInputInfo(Context context, ResolveInfo service, HdmiDeviceInfo hdmiDeviceInfo, String parentId, String label, Uri iconUri) throws XmlPullParserException, IOException {
        TvInputInfo input = createTvInputInfo(context, service, generateInputIdForHdmiDevice(new ComponentName(service.serviceInfo.packageName, service.serviceInfo.name), hdmiDeviceInfo), parentId, TYPE_HDMI, label, iconUri, (hdmiDeviceInfo.getPhysicalAddress() & FileObserver.ALL_EVENTS) != 0 ? true : DEBUG);
        input.mHdmiDeviceInfo = hdmiDeviceInfo;
        return input;
    }

    public static TvInputInfo createTvInputInfo(Context context, ResolveInfo service, TvInputHardwareInfo hardwareInfo, String label, Uri iconUri) throws XmlPullParserException, IOException {
        int inputType = sHardwareTypeToTvInputType.get(hardwareInfo.getType(), TYPE_TUNER);
        return createTvInputInfo(context, service, generateInputIdForHardware(new ComponentName(service.serviceInfo.packageName, service.serviceInfo.name), hardwareInfo), null, inputType, label, iconUri, DEBUG);
    }

    private static TvInputInfo createTvInputInfo(Context context, ResolveInfo service, String id, String parentId, int inputType, String label, Uri iconUri, boolean isConnectedToHdmiSwitch) throws XmlPullParserException, IOException {
        ServiceInfo si = service.serviceInfo;
        PackageManager pm = context.getPackageManager();
        XmlResourceParser parser = null;
        try {
            parser = si.loadXmlMetaData(pm, TvInputService.SERVICE_META_DATA);
            if (parser == null) {
                throw new XmlPullParserException("No android.media.tv.input meta-data for " + si.name);
            }
            Resources res = pm.getResourcesForApplication(si.applicationInfo);
            AttributeSet attrs = Xml.asAttributeSet(parser);
            int type;
            do {
                type = parser.next();
                if (type == 1) {
                    break;
                }
            } while (type != LENGTH_HDMI_DEVICE_ID);
            if (XML_START_TAG_NAME.equals(parser.getName())) {
                TvInputInfo input = new TvInputInfo(service, id, parentId, inputType);
                TypedArray sa = res.obtainAttributes(attrs, R.styleable.TvInputService);
                input.mSetupActivity = sa.getString(1);
                if (inputType == 0 && TextUtils.isEmpty(input.mSetupActivity)) {
                    throw new XmlPullParserException("Setup activity not found in " + si.name);
                }
                input.mSettingsActivity = sa.getString(TYPE_TUNER);
                sa.recycle();
                input.mLabel = label;
                input.mIconUri = iconUri;
                input.mIsConnectedToHdmiSwitch = isConnectedToHdmiSwitch;
                if (parser != null) {
                    parser.close();
                }
                return input;
            }
            throw new XmlPullParserException("Meta-data does not start with tv-input-service tag in " + si.name);
        } catch (NameNotFoundException e) {
            throw new XmlPullParserException("Unable to create context for: " + si.packageName);
        } catch (Throwable th) {
            if (parser != null) {
                parser.close();
            }
        }
    }

    private TvInputInfo(ResolveInfo service, String id, String parentId, int type) {
        this.mType = TYPE_TUNER;
        this.mService = service;
        this.mId = id;
        this.mParentId = parentId;
        this.mType = type;
    }

    public String getId() {
        return this.mId;
    }

    public String getParentId() {
        return this.mParentId;
    }

    public ServiceInfo getServiceInfo() {
        return this.mService.serviceInfo;
    }

    public ComponentName getComponent() {
        return new ComponentName(this.mService.serviceInfo.packageName, this.mService.serviceInfo.name);
    }

    public Intent createSetupIntent() {
        if (TextUtils.isEmpty(this.mSetupActivity)) {
            return null;
        }
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.setClassName(this.mService.serviceInfo.packageName, this.mSetupActivity);
        intent.putExtra(EXTRA_INPUT_ID, getId());
        return intent;
    }

    public Intent createSettingsIntent() {
        if (TextUtils.isEmpty(this.mSettingsActivity)) {
            return null;
        }
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.setClassName(this.mService.serviceInfo.packageName, this.mSettingsActivity);
        intent.putExtra(EXTRA_INPUT_ID, getId());
        return intent;
    }

    public int getType() {
        return this.mType;
    }

    public HdmiDeviceInfo getHdmiDeviceInfo() {
        if (this.mType == TYPE_HDMI) {
            return this.mHdmiDeviceInfo;
        }
        return null;
    }

    public boolean isPassthroughInput() {
        return this.mType != 0 ? true : DEBUG;
    }

    public boolean isConnectedToHdmiSwitch() {
        return this.mIsConnectedToHdmiSwitch;
    }

    public boolean isHidden(Context context) {
        return TvInputSettings.isHidden(context, this.mId, UserHandle.myUserId());
    }

    public CharSequence loadLabel(Context context) {
        if (TextUtils.isEmpty(this.mLabel)) {
            return this.mService.loadLabel(context.getPackageManager());
        }
        return this.mLabel;
    }

    public CharSequence loadCustomLabel(Context context) {
        return TvInputSettings.getCustomLabel(context, this.mId, UserHandle.myUserId());
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.graphics.drawable.Drawable loadIcon(android.content.Context r9) {
        /*
        r8 = this;
        r5 = 0;
        r4 = r8.mIconUri;
        if (r4 != 0) goto L_0x000a;
    L_0x0005:
        r0 = r8.loadServiceIcon(r9);
    L_0x0009:
        return r0;
    L_0x000a:
        r4 = r9.getContentResolver();	 Catch:{ IOException -> 0x002d }
        r6 = r8.mIconUri;	 Catch:{ IOException -> 0x002d }
        r2 = r4.openInputStream(r6);	 Catch:{ IOException -> 0x002d }
        r4 = 0;
        r6 = 0;
        r0 = android.graphics.drawable.Drawable.createFromStream(r2, r6);	 Catch:{ Throwable -> 0x0062, all -> 0x0079 }
        if (r0 != 0) goto L_0x0051;
    L_0x001c:
        r0 = r8.loadServiceIcon(r9);	 Catch:{ Throwable -> 0x0062, all -> 0x0079 }
        if (r2 == 0) goto L_0x0009;
    L_0x0022:
        if (r5 == 0) goto L_0x004d;
    L_0x0024:
        r2.close();	 Catch:{ Throwable -> 0x0028 }
        goto L_0x0009;
    L_0x0028:
        r3 = move-exception;
        r4.addSuppressed(r3);	 Catch:{ IOException -> 0x002d }
        goto L_0x0009;
    L_0x002d:
        r1 = move-exception;
        r4 = "TvInputInfo";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "Loading the default icon due to a failure on loading ";
        r5 = r5.append(r6);
        r6 = r8.mIconUri;
        r5 = r5.append(r6);
        r5 = r5.toString();
        android.util.Log.w(r4, r5, r1);
        r0 = r8.loadServiceIcon(r9);
        goto L_0x0009;
    L_0x004d:
        r2.close();	 Catch:{ IOException -> 0x002d }
        goto L_0x0009;
    L_0x0051:
        if (r2 == 0) goto L_0x0009;
    L_0x0053:
        if (r5 == 0) goto L_0x005e;
    L_0x0055:
        r2.close();	 Catch:{ Throwable -> 0x0059 }
        goto L_0x0009;
    L_0x0059:
        r3 = move-exception;
        r4.addSuppressed(r3);	 Catch:{ IOException -> 0x002d }
        goto L_0x0009;
    L_0x005e:
        r2.close();	 Catch:{ IOException -> 0x002d }
        goto L_0x0009;
    L_0x0062:
        r4 = move-exception;
        throw r4;	 Catch:{ all -> 0x0064 }
    L_0x0064:
        r5 = move-exception;
        r7 = r5;
        r5 = r4;
        r4 = r7;
    L_0x0068:
        if (r2 == 0) goto L_0x006f;
    L_0x006a:
        if (r5 == 0) goto L_0x0075;
    L_0x006c:
        r2.close();	 Catch:{ Throwable -> 0x0070 }
    L_0x006f:
        throw r4;	 Catch:{ IOException -> 0x002d }
    L_0x0070:
        r3 = move-exception;
        r5.addSuppressed(r3);	 Catch:{ IOException -> 0x002d }
        goto L_0x006f;
    L_0x0075:
        r2.close();	 Catch:{ IOException -> 0x002d }
        goto L_0x006f;
    L_0x0079:
        r4 = move-exception;
        goto L_0x0068;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.tv.TvInputInfo.loadIcon(android.content.Context):android.graphics.drawable.Drawable");
    }

    public int describeContents() {
        return TYPE_TUNER;
    }

    public int hashCode() {
        return this.mId.hashCode();
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof TvInputInfo)) {
            return DEBUG;
        }
        return this.mId.equals(((TvInputInfo) o).mId);
    }

    public String toString() {
        return "TvInputInfo{id=" + this.mId + ", pkg=" + this.mService.serviceInfo.packageName + ", service=" + this.mService.serviceInfo.name + "}";
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.mId);
        dest.writeString(this.mParentId);
        this.mService.writeToParcel(dest, flags);
        dest.writeString(this.mSetupActivity);
        dest.writeString(this.mSettingsActivity);
        dest.writeInt(this.mType);
        dest.writeParcelable(this.mHdmiDeviceInfo, flags);
        dest.writeParcelable(this.mIconUri, flags);
        dest.writeString(this.mLabel);
        dest.writeByte(this.mIsConnectedToHdmiSwitch ? (byte) 1 : (byte) 0);
    }

    private Drawable loadServiceIcon(Context context) {
        if (this.mService.serviceInfo.icon == 0 && this.mService.serviceInfo.applicationInfo.icon == 0) {
            return null;
        }
        return this.mService.serviceInfo.loadIcon(context.getPackageManager());
    }

    private static final String generateInputIdForComponentName(ComponentName name) {
        return name.flattenToShortString();
    }

    private static final String generateInputIdForHdmiDevice(ComponentName name, HdmiDeviceInfo deviceInfo) {
        Object[] objArr = new Object[LENGTH_HDMI_PHYSICAL_ADDRESS];
        objArr[TYPE_TUNER] = DELIMITER_INFO_IN_ID;
        objArr[1] = PREFIX_HDMI_DEVICE;
        objArr[LENGTH_HDMI_DEVICE_ID] = Integer.valueOf(LENGTH_HDMI_PHYSICAL_ADDRESS);
        objArr[3] = Integer.valueOf(LENGTH_HDMI_DEVICE_ID);
        String format = String.format("%s%s%%0%sX%%0%sX", objArr);
        StringBuilder append = new StringBuilder().append(name.flattenToShortString());
        objArr = new Object[LENGTH_HDMI_DEVICE_ID];
        objArr[TYPE_TUNER] = Integer.valueOf(deviceInfo.getPhysicalAddress());
        objArr[1] = Integer.valueOf(deviceInfo.getId());
        return append.append(String.format(format, objArr)).toString();
    }

    private static final String generateInputIdForHardware(ComponentName name, TvInputHardwareInfo hardwareInfo) {
        return name.flattenToShortString() + String.format("%s%s%d", new Object[]{DELIMITER_INFO_IN_ID, PREFIX_HARDWARE_DEVICE, Integer.valueOf(hardwareInfo.getDeviceId())});
    }

    private TvInputInfo(Parcel in) {
        boolean z;
        this.mType = TYPE_TUNER;
        this.mId = in.readString();
        this.mParentId = in.readString();
        this.mService = (ResolveInfo) ResolveInfo.CREATOR.createFromParcel(in);
        this.mSetupActivity = in.readString();
        this.mSettingsActivity = in.readString();
        this.mType = in.readInt();
        this.mHdmiDeviceInfo = (HdmiDeviceInfo) in.readParcelable(null);
        this.mIconUri = (Uri) in.readParcelable(null);
        this.mLabel = in.readString();
        if (in.readByte() == (byte) 1) {
            z = true;
        } else {
            z = DEBUG;
        }
        this.mIsConnectedToHdmiSwitch = z;
    }
}
