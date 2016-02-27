package android.hardware.camera2.impl;

import android.graphics.Point;
import android.graphics.Rect;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.marshal.MarshalQueryable;
import android.hardware.camera2.marshal.MarshalRegistry;
import android.hardware.camera2.marshal.Marshaler;
import android.hardware.camera2.marshal.impl.MarshalQueryableArray;
import android.hardware.camera2.marshal.impl.MarshalQueryableBlackLevelPattern;
import android.hardware.camera2.marshal.impl.MarshalQueryableBoolean;
import android.hardware.camera2.marshal.impl.MarshalQueryableColorSpaceTransform;
import android.hardware.camera2.marshal.impl.MarshalQueryableEnum;
import android.hardware.camera2.marshal.impl.MarshalQueryableHighSpeedVideoConfiguration;
import android.hardware.camera2.marshal.impl.MarshalQueryableMeteringRectangle;
import android.hardware.camera2.marshal.impl.MarshalQueryableNativeByteToInteger;
import android.hardware.camera2.marshal.impl.MarshalQueryablePair;
import android.hardware.camera2.marshal.impl.MarshalQueryableParcelable;
import android.hardware.camera2.marshal.impl.MarshalQueryablePrimitive;
import android.hardware.camera2.marshal.impl.MarshalQueryableRange;
import android.hardware.camera2.marshal.impl.MarshalQueryableRect;
import android.hardware.camera2.marshal.impl.MarshalQueryableReprocessFormatsMap;
import android.hardware.camera2.marshal.impl.MarshalQueryableRggbChannelVector;
import android.hardware.camera2.marshal.impl.MarshalQueryableSize;
import android.hardware.camera2.marshal.impl.MarshalQueryableSizeF;
import android.hardware.camera2.marshal.impl.MarshalQueryableStreamConfiguration;
import android.hardware.camera2.marshal.impl.MarshalQueryableStreamConfigurationDuration;
import android.hardware.camera2.marshal.impl.MarshalQueryableString;
import android.hardware.camera2.params.Face;
import android.hardware.camera2.params.HighSpeedVideoConfiguration;
import android.hardware.camera2.params.LensShadingMap;
import android.hardware.camera2.params.StreamConfiguration;
import android.hardware.camera2.params.StreamConfigurationDuration;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.hardware.camera2.params.TonemapCurve;
import android.hardware.camera2.utils.TypeReference;
import android.location.Location;
import android.location.LocationManager;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import android.util.Size;
import android.view.inputmethod.InputMethodManager;
import com.android.internal.util.Preconditions;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.HashMap;

public class CameraMetadataNative implements Parcelable {
    private static final String CELLID_PROCESS = "CELLID";
    public static final Creator<CameraMetadataNative> CREATOR;
    private static final int FACE_LANDMARK_SIZE = 6;
    private static final String GPS_PROCESS = "GPS";
    public static final int NATIVE_JPEG_FORMAT = 33;
    public static final int NUM_TYPES = 6;
    private static final String TAG = "CameraMetadataJV";
    public static final int TYPE_BYTE = 0;
    public static final int TYPE_DOUBLE = 4;
    public static final int TYPE_FLOAT = 2;
    public static final int TYPE_INT32 = 1;
    public static final int TYPE_INT64 = 3;
    public static final int TYPE_RATIONAL = 5;
    private static final boolean VERBOSE;
    private static final HashMap<Key<?>, GetCommand> sGetCommandMap;
    private static final HashMap<Key<?>, SetCommand> sSetCommandMap;
    private long mMetadataPtr;

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.1 */
    static class C02371 implements Creator<CameraMetadataNative> {
        C02371() {
        }

        public CameraMetadataNative createFromParcel(Parcel in) {
            CameraMetadataNative metadata = new CameraMetadataNative();
            metadata.readFromParcel(in);
            return metadata;
        }

        public CameraMetadataNative[] newArray(int size) {
            return new CameraMetadataNative[size];
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.2 */
    static class C02382 implements GetCommand {
        C02382() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getAvailableFormats();
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.3 */
    static class C02393 implements GetCommand {
        C02393() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getFaces();
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.4 */
    static class C02404 implements GetCommand {
        C02404() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getFaceRectangles();
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.5 */
    static class C02415 implements GetCommand {
        C02415() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getStreamConfigurationMap();
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.6 */
    static class C02426 implements GetCommand {
        C02426() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getMaxRegions(key);
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.7 */
    static class C02437 implements GetCommand {
        C02437() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getMaxRegions(key);
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.8 */
    static class C02448 implements GetCommand {
        C02448() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getMaxRegions(key);
        }
    }

    /* renamed from: android.hardware.camera2.impl.CameraMetadataNative.9 */
    static class C02459 implements GetCommand {
        C02459() {
        }

        public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
            return metadata.getMaxNumOutputs(key);
        }
    }

    public static class Key<T> {
        private boolean mHasTag;
        private final int mHash;
        private final String mName;
        private int mTag;
        private final Class<T> mType;
        private final TypeReference<T> mTypeReference;

        public Key(String name, Class<T> type) {
            if (name == null) {
                throw new NullPointerException("Key needs a valid name");
            } else if (type == null) {
                throw new NullPointerException("Type needs to be non-null");
            } else {
                this.mName = name;
                this.mType = type;
                this.mTypeReference = TypeReference.createSpecializedTypeReference((Class) type);
                this.mHash = this.mName.hashCode() ^ this.mTypeReference.hashCode();
            }
        }

        public Key(String name, TypeReference<T> typeReference) {
            if (name == null) {
                throw new NullPointerException("Key needs a valid name");
            } else if (typeReference == null) {
                throw new NullPointerException("TypeReference needs to be non-null");
            } else {
                this.mName = name;
                this.mType = typeReference.getRawType();
                this.mTypeReference = typeReference;
                this.mHash = this.mName.hashCode() ^ this.mTypeReference.hashCode();
            }
        }

        public final String getName() {
            return this.mName;
        }

        public final int hashCode() {
            return this.mHash;
        }

        public final boolean equals(Object o) {
            if (this == o) {
                return true;
            }
            if (o == null || hashCode() != o.hashCode()) {
                return false;
            }
            Key<?> lhs;
            if (o instanceof android.hardware.camera2.CaptureResult.Key) {
                lhs = ((android.hardware.camera2.CaptureResult.Key) o).getNativeKey();
            } else if (o instanceof android.hardware.camera2.CaptureRequest.Key) {
                lhs = ((android.hardware.camera2.CaptureRequest.Key) o).getNativeKey();
            } else if (o instanceof android.hardware.camera2.CameraCharacteristics.Key) {
                lhs = ((android.hardware.camera2.CameraCharacteristics.Key) o).getNativeKey();
            } else if (!(o instanceof Key)) {
                return false;
            } else {
                lhs = (Key) o;
            }
            if (this.mName.equals(lhs.mName) && this.mTypeReference.equals(lhs.mTypeReference)) {
                return true;
            }
            return false;
        }

        public final int getTag() {
            if (!this.mHasTag) {
                this.mTag = CameraMetadataNative.getTag(this.mName);
                this.mHasTag = true;
            }
            return this.mTag;
        }

        public final Class<T> getType() {
            return this.mType;
        }

        public final TypeReference<T> getTypeReference() {
            return this.mTypeReference;
        }
    }

    private native long nativeAllocate();

    private native long nativeAllocateCopy(CameraMetadataNative cameraMetadataNative) throws NullPointerException;

    private static native void nativeClassInit();

    private native synchronized void nativeClose();

    private native synchronized void nativeDump() throws IOException;

    private native synchronized int nativeGetEntryCount();

    private static native int nativeGetTagFromKey(String str) throws IllegalArgumentException;

    private static native int nativeGetTypeFromTag(int i) throws IllegalArgumentException;

    private native synchronized boolean nativeIsEmpty();

    private native synchronized void nativeReadFromParcel(Parcel parcel);

    private native synchronized byte[] nativeReadValues(int i);

    public static native int nativeSetupGlobalVendorTagDescriptor();

    private native synchronized void nativeSwap(CameraMetadataNative cameraMetadataNative) throws NullPointerException;

    private native synchronized void nativeWriteToParcel(Parcel parcel);

    private native synchronized void nativeWriteValues(int i, byte[] bArr);

    static {
        VERBOSE = Log.isLoggable(TAG, TYPE_FLOAT);
        CREATOR = new C02371();
        sGetCommandMap = new HashMap();
        sGetCommandMap.put(CameraCharacteristics.SCALER_AVAILABLE_FORMATS.getNativeKey(), new C02382());
        sGetCommandMap.put(CaptureResult.STATISTICS_FACES.getNativeKey(), new C02393());
        sGetCommandMap.put(CaptureResult.STATISTICS_FACE_RECTANGLES.getNativeKey(), new C02404());
        sGetCommandMap.put(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP.getNativeKey(), new C02415());
        sGetCommandMap.put(CameraCharacteristics.CONTROL_MAX_REGIONS_AE.getNativeKey(), new C02426());
        sGetCommandMap.put(CameraCharacteristics.CONTROL_MAX_REGIONS_AWB.getNativeKey(), new C02437());
        sGetCommandMap.put(CameraCharacteristics.CONTROL_MAX_REGIONS_AF.getNativeKey(), new C02448());
        sGetCommandMap.put(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_RAW.getNativeKey(), new C02459());
        sGetCommandMap.put(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_PROC.getNativeKey(), new GetCommand() {
            public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
                return metadata.getMaxNumOutputs(key);
            }
        });
        sGetCommandMap.put(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_PROC_STALLING.getNativeKey(), new GetCommand() {
            public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
                return metadata.getMaxNumOutputs(key);
            }
        });
        sGetCommandMap.put(CaptureRequest.TONEMAP_CURVE.getNativeKey(), new GetCommand() {
            public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
                return metadata.getTonemapCurve();
            }
        });
        sGetCommandMap.put(CaptureResult.JPEG_GPS_LOCATION.getNativeKey(), new GetCommand() {
            public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
                return metadata.getGpsLocation();
            }
        });
        sGetCommandMap.put(CaptureResult.STATISTICS_LENS_SHADING_CORRECTION_MAP.getNativeKey(), new GetCommand() {
            public <T> T getValue(CameraMetadataNative metadata, Key<T> key) {
                return metadata.getLensShadingMap();
            }
        });
        sSetCommandMap = new HashMap();
        sSetCommandMap.put(CameraCharacteristics.SCALER_AVAILABLE_FORMATS.getNativeKey(), new SetCommand() {
            public <T> void setValue(CameraMetadataNative metadata, T value) {
                metadata.setAvailableFormats((int[]) value);
            }
        });
        sSetCommandMap.put(CaptureResult.STATISTICS_FACE_RECTANGLES.getNativeKey(), new SetCommand() {
            public <T> void setValue(CameraMetadataNative metadata, T value) {
                metadata.setFaceRectangles((Rect[]) value);
            }
        });
        sSetCommandMap.put(CaptureResult.STATISTICS_FACES.getNativeKey(), new SetCommand() {
            public <T> void setValue(CameraMetadataNative metadata, T value) {
                metadata.setFaces((Face[]) value);
            }
        });
        sSetCommandMap.put(CaptureRequest.TONEMAP_CURVE.getNativeKey(), new SetCommand() {
            public <T> void setValue(CameraMetadataNative metadata, T value) {
                metadata.setTonemapCurve((TonemapCurve) value);
            }
        });
        sSetCommandMap.put(CaptureResult.JPEG_GPS_LOCATION.getNativeKey(), new SetCommand() {
            public <T> void setValue(CameraMetadataNative metadata, T value) {
                metadata.setGpsLocation((Location) value);
            }
        });
        nativeClassInit();
        registerAllMarshalers();
    }

    private static String translateLocationProviderToProcess(String provider) {
        if (provider == null) {
            return null;
        }
        Object obj = -1;
        switch (provider.hashCode()) {
            case 102570:
                if (provider.equals(LocationManager.GPS_PROVIDER)) {
                    obj = null;
                    break;
                }
                break;
            case 1843485230:
                if (provider.equals(LocationManager.NETWORK_PROVIDER)) {
                    obj = TYPE_INT32;
                    break;
                }
                break;
        }
        switch (obj) {
            case TYPE_BYTE /*0*/:
                return GPS_PROCESS;
            case TYPE_INT32 /*1*/:
                return CELLID_PROCESS;
            default:
                return null;
        }
    }

    private static String translateProcessToLocationProvider(String process) {
        if (process == null) {
            return null;
        }
        Object obj = -1;
        switch (process.hashCode()) {
            case 70794:
                if (process.equals(GPS_PROCESS)) {
                    obj = null;
                    break;
                }
                break;
            case 1984215549:
                if (process.equals(CELLID_PROCESS)) {
                    obj = TYPE_INT32;
                    break;
                }
                break;
        }
        switch (obj) {
            case TYPE_BYTE /*0*/:
                return LocationManager.GPS_PROVIDER;
            case TYPE_INT32 /*1*/:
                return LocationManager.NETWORK_PROVIDER;
            default:
                return null;
        }
    }

    public CameraMetadataNative() {
        this.mMetadataPtr = nativeAllocate();
        if (this.mMetadataPtr == 0) {
            throw new OutOfMemoryError("Failed to allocate native CameraMetadata");
        }
    }

    public CameraMetadataNative(CameraMetadataNative other) {
        this.mMetadataPtr = nativeAllocateCopy(other);
        if (this.mMetadataPtr == 0) {
            throw new OutOfMemoryError("Failed to allocate native CameraMetadata");
        }
    }

    public static CameraMetadataNative move(CameraMetadataNative other) {
        CameraMetadataNative newObject = new CameraMetadataNative();
        newObject.swap(other);
        return newObject;
    }

    public int describeContents() {
        return TYPE_BYTE;
    }

    public void writeToParcel(Parcel dest, int flags) {
        nativeWriteToParcel(dest);
    }

    public <T> T get(android.hardware.camera2.CameraCharacteristics.Key<T> key) {
        return get(key.getNativeKey());
    }

    public <T> T get(android.hardware.camera2.CaptureResult.Key<T> key) {
        return get(key.getNativeKey());
    }

    public <T> T get(android.hardware.camera2.CaptureRequest.Key<T> key) {
        return get(key.getNativeKey());
    }

    public <T> T get(Key<T> key) {
        Preconditions.checkNotNull(key, "key must not be null");
        GetCommand g = (GetCommand) sGetCommandMap.get(key);
        if (g != null) {
            return g.getValue(this, key);
        }
        return getBase((Key) key);
    }

    public void readFromParcel(Parcel in) {
        nativeReadFromParcel(in);
    }

    public <T> void set(Key<T> key, T value) {
        SetCommand s = (SetCommand) sSetCommandMap.get(key);
        if (s != null) {
            s.setValue(this, value);
        } else {
            setBase((Key) key, (Object) value);
        }
    }

    public <T> void set(android.hardware.camera2.CaptureRequest.Key<T> key, T value) {
        set(key.getNativeKey(), (Object) value);
    }

    public <T> void set(android.hardware.camera2.CaptureResult.Key<T> key, T value) {
        set(key.getNativeKey(), (Object) value);
    }

    public <T> void set(android.hardware.camera2.CameraCharacteristics.Key<T> key, T value) {
        set(key.getNativeKey(), (Object) value);
    }

    private void close() {
        nativeClose();
        this.mMetadataPtr = 0;
    }

    private <T> T getBase(android.hardware.camera2.CameraCharacteristics.Key<T> key) {
        return getBase(key.getNativeKey());
    }

    private <T> T getBase(android.hardware.camera2.CaptureResult.Key<T> key) {
        return getBase(key.getNativeKey());
    }

    private <T> T getBase(android.hardware.camera2.CaptureRequest.Key<T> key) {
        return getBase(key.getNativeKey());
    }

    private <T> T getBase(Key<T> key) {
        byte[] values = readValues(key.getTag());
        if (values == null) {
            return null;
        }
        return getMarshalerForKey(key).unmarshal(ByteBuffer.wrap(values).order(ByteOrder.nativeOrder()));
    }

    private int[] getAvailableFormats() {
        int[] availableFormats = (int[]) getBase(CameraCharacteristics.SCALER_AVAILABLE_FORMATS);
        if (availableFormats != null) {
            for (int i = TYPE_BYTE; i < availableFormats.length; i += TYPE_INT32) {
                if (availableFormats[i] == NATIVE_JPEG_FORMAT) {
                    availableFormats[i] = InputMethodManager.CONTROL_START_INITIAL;
                }
            }
        }
        return availableFormats;
    }

    private boolean setFaces(Face[] faces) {
        if (faces == null) {
            return false;
        }
        int i$;
        int numFaces = faces.length;
        boolean fullMode = true;
        Face[] arr$ = faces;
        int len$ = arr$.length;
        for (i$ = TYPE_BYTE; i$ < len$; i$ += TYPE_INT32) {
            Face face = arr$[i$];
            if (face == null) {
                numFaces--;
                Log.w(TAG, "setFaces - null face detected, skipping");
            } else if (face.getId() == -1) {
                fullMode = false;
            }
        }
        Object faceRectangles = new Rect[numFaces];
        Object faceScores = new byte[numFaces];
        Object faceIds = null;
        Object faceLandmarks = null;
        if (fullMode) {
            faceIds = new int[numFaces];
            faceLandmarks = new int[(numFaces * NUM_TYPES)];
        }
        int i = TYPE_BYTE;
        arr$ = faces;
        len$ = arr$.length;
        for (i$ = TYPE_BYTE; i$ < len$; i$ += TYPE_INT32) {
            face = arr$[i$];
            if (face != null) {
                faceRectangles[i] = face.getBounds();
                faceScores[i] = (byte) face.getScore();
                if (fullMode) {
                    faceIds[i] = face.getId();
                    int j = TYPE_BYTE + TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_BYTE] = face.getLeftEyePosition().f13x;
                    int j2 = j + TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_INT32] = face.getLeftEyePosition().f14y;
                    j2 += TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_FLOAT] = face.getRightEyePosition().f13x;
                    j2 += TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_INT64] = face.getRightEyePosition().f14y;
                    j2 += TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_DOUBLE] = face.getMouthPosition().f13x;
                    j2 += TYPE_INT32;
                    faceLandmarks[(i * NUM_TYPES) + TYPE_RATIONAL] = face.getMouthPosition().f14y;
                }
                i += TYPE_INT32;
            }
        }
        set(CaptureResult.STATISTICS_FACE_RECTANGLES, faceRectangles);
        set(CaptureResult.STATISTICS_FACE_IDS, faceIds);
        set(CaptureResult.STATISTICS_FACE_LANDMARKS, faceLandmarks);
        set(CaptureResult.STATISTICS_FACE_SCORES, faceScores);
        return true;
    }

    private Face[] getFaces() {
        Integer faceDetectMode = (Integer) get(CaptureResult.STATISTICS_FACE_DETECT_MODE);
        byte[] faceScores = (byte[]) get(CaptureResult.STATISTICS_FACE_SCORES);
        Rect[] faceRectangles = (Rect[]) get(CaptureResult.STATISTICS_FACE_RECTANGLES);
        int[] faceIds = (int[]) get(CaptureResult.STATISTICS_FACE_IDS);
        int[] faceLandmarks = (int[]) get(CaptureResult.STATISTICS_FACE_LANDMARKS);
        Object[] objArr = new Object[TYPE_RATIONAL];
        objArr[TYPE_BYTE] = faceDetectMode;
        objArr[TYPE_INT32] = faceScores;
        objArr[TYPE_FLOAT] = faceRectangles;
        objArr[TYPE_INT64] = faceIds;
        objArr[TYPE_DOUBLE] = faceLandmarks;
        if (areValuesAllNull(objArr)) {
            return null;
        }
        if (faceDetectMode == null) {
            Log.w(TAG, "Face detect mode metadata is null, assuming the mode is SIMPLE");
            faceDetectMode = Integer.valueOf(TYPE_INT32);
        } else if (faceDetectMode.intValue() == 0) {
            return new Face[TYPE_BYTE];
        } else {
            if (!(faceDetectMode.intValue() == TYPE_INT32 || faceDetectMode.intValue() == TYPE_FLOAT)) {
                Log.w(TAG, "Unknown face detect mode: " + faceDetectMode);
                return new Face[TYPE_BYTE];
            }
        }
        if (faceScores == null || faceRectangles == null) {
            Log.w(TAG, "Expect face scores and rectangles to be non-null");
            return new Face[TYPE_BYTE];
        }
        if (faceScores.length != faceRectangles.length) {
            String str = TAG;
            Object[] objArr2 = new Object[TYPE_FLOAT];
            objArr2[TYPE_BYTE] = Integer.valueOf(faceScores.length);
            objArr2[TYPE_INT32] = Integer.valueOf(faceRectangles.length);
            Log.w(str, String.format("Face score size(%d) doesn match face rectangle size(%d)!", objArr2));
        }
        int numFaces = Math.min(faceScores.length, faceRectangles.length);
        if (faceDetectMode.intValue() == TYPE_FLOAT) {
            if (faceIds == null || faceLandmarks == null) {
                Log.w(TAG, "Expect face ids and landmarks to be non-null for FULL mode,fallback to SIMPLE mode");
                faceDetectMode = Integer.valueOf(TYPE_INT32);
            } else {
                if (!(faceIds.length == numFaces && faceLandmarks.length == numFaces * NUM_TYPES)) {
                    str = TAG;
                    objArr2 = new Object[TYPE_INT64];
                    objArr2[TYPE_BYTE] = Integer.valueOf(faceIds.length);
                    objArr2[TYPE_INT32] = Integer.valueOf(faceLandmarks.length * NUM_TYPES);
                    objArr2[TYPE_FLOAT] = Integer.valueOf(numFaces);
                    Log.w(str, String.format("Face id size(%d), or face landmark size(%d) don'tmatch face number(%d)!", objArr2));
                }
                int min = Math.min(numFaces, faceIds.length);
                numFaces = Math.min(numFaces, faceLandmarks.length / NUM_TYPES);
            }
        }
        ArrayList<Face> faceList = new ArrayList();
        int i;
        if (faceDetectMode.intValue() == TYPE_INT32) {
            i = TYPE_BYTE;
            while (i < numFaces) {
                if (faceScores[i] <= 100 && faceScores[i] >= TYPE_INT32) {
                    faceList.add(new Face(faceRectangles[i], faceScores[i]));
                }
                i += TYPE_INT32;
            }
        } else {
            i = TYPE_BYTE;
            while (i < numFaces) {
                if (faceScores[i] <= 100 && faceScores[i] >= TYPE_INT32 && faceIds[i] >= 0) {
                    faceList.add(new Face(faceRectangles[i], faceScores[i], faceIds[i], new Point(faceLandmarks[i * NUM_TYPES], faceLandmarks[(i * NUM_TYPES) + TYPE_INT32]), new Point(faceLandmarks[(i * NUM_TYPES) + TYPE_FLOAT], faceLandmarks[(i * NUM_TYPES) + TYPE_INT64]), new Point(faceLandmarks[(i * NUM_TYPES) + TYPE_DOUBLE], faceLandmarks[(i * NUM_TYPES) + TYPE_RATIONAL])));
                }
                i += TYPE_INT32;
            }
        }
        Face[] faces = new Face[faceList.size()];
        faceList.toArray(faces);
        return faces;
    }

    private Rect[] getFaceRectangles() {
        Rect[] faceRectangles = (Rect[]) getBase(CaptureResult.STATISTICS_FACE_RECTANGLES);
        if (faceRectangles == null) {
            return null;
        }
        Rect[] fixedFaceRectangles = new Rect[faceRectangles.length];
        for (int i = TYPE_BYTE; i < faceRectangles.length; i += TYPE_INT32) {
            fixedFaceRectangles[i] = new Rect(faceRectangles[i].left, faceRectangles[i].top, faceRectangles[i].right - faceRectangles[i].left, faceRectangles[i].bottom - faceRectangles[i].top);
        }
        return fixedFaceRectangles;
    }

    private LensShadingMap getLensShadingMap() {
        float[] lsmArray = (float[]) getBase(CaptureResult.STATISTICS_LENS_SHADING_MAP);
        Size s = (Size) get(CameraCharacteristics.LENS_INFO_SHADING_MAP_SIZE);
        if (lsmArray == null) {
            return null;
        }
        if (s != null) {
            return new LensShadingMap(lsmArray, s.getHeight(), s.getWidth());
        }
        Log.w(TAG, "getLensShadingMap - Lens shading map size was null.");
        return null;
    }

    private Location getGpsLocation() {
        String processingMethod = (String) get(CaptureResult.JPEG_GPS_PROCESSING_METHOD);
        double[] coords = (double[]) get(CaptureResult.JPEG_GPS_COORDINATES);
        Long timeStamp = (Long) get(CaptureResult.JPEG_GPS_TIMESTAMP);
        Object[] objArr = new Object[TYPE_INT64];
        objArr[TYPE_BYTE] = processingMethod;
        objArr[TYPE_INT32] = coords;
        objArr[TYPE_FLOAT] = timeStamp;
        if (areValuesAllNull(objArr)) {
            return null;
        }
        Location l = new Location(translateProcessToLocationProvider(processingMethod));
        if (timeStamp != null) {
            l.setTime(timeStamp.longValue());
        } else {
            Log.w(TAG, "getGpsLocation - No timestamp for GPS location.");
        }
        if (coords != null) {
            l.setLatitude(coords[TYPE_BYTE]);
            l.setLongitude(coords[TYPE_INT32]);
            l.setAltitude(coords[TYPE_FLOAT]);
            return l;
        }
        Log.w(TAG, "getGpsLocation - No coordinates for GPS location");
        return l;
    }

    private boolean setGpsLocation(Location l) {
        if (l == null) {
            return false;
        }
        Object coords = new double[TYPE_INT64];
        coords[TYPE_BYTE] = l.getLatitude();
        coords[TYPE_INT32] = l.getLongitude();
        coords[TYPE_FLOAT] = l.getAltitude();
        Object processMethod = translateLocationProviderToProcess(l.getProvider());
        set(CaptureRequest.JPEG_GPS_TIMESTAMP, Long.valueOf(l.getTime()));
        set(CaptureRequest.JPEG_GPS_COORDINATES, coords);
        if (processMethod == null) {
            Log.w(TAG, "setGpsLocation - No process method, Location is not from a GPS or NETWORKprovider");
        } else {
            setBase(CaptureRequest.JPEG_GPS_PROCESSING_METHOD, processMethod);
        }
        return true;
    }

    private StreamConfigurationMap getStreamConfigurationMap() {
        return new StreamConfigurationMap((StreamConfiguration[]) getBase(CameraCharacteristics.SCALER_AVAILABLE_STREAM_CONFIGURATIONS), (StreamConfigurationDuration[]) getBase(CameraCharacteristics.SCALER_AVAILABLE_MIN_FRAME_DURATIONS), (StreamConfigurationDuration[]) getBase(CameraCharacteristics.SCALER_AVAILABLE_STALL_DURATIONS), (HighSpeedVideoConfiguration[]) getBase(CameraCharacteristics.CONTROL_AVAILABLE_HIGH_SPEED_VIDEO_CONFIGURATIONS));
    }

    private <T> Integer getMaxRegions(Key<T> key) {
        int[] maxRegions = (int[]) getBase(CameraCharacteristics.CONTROL_MAX_REGIONS);
        if (maxRegions == null) {
            return null;
        }
        if (key.equals(CameraCharacteristics.CONTROL_MAX_REGIONS_AE)) {
            return Integer.valueOf(maxRegions[TYPE_BYTE]);
        }
        if (key.equals(CameraCharacteristics.CONTROL_MAX_REGIONS_AWB)) {
            return Integer.valueOf(maxRegions[TYPE_INT32]);
        }
        if (key.equals(CameraCharacteristics.CONTROL_MAX_REGIONS_AF)) {
            return Integer.valueOf(maxRegions[TYPE_FLOAT]);
        }
        throw new AssertionError("Invalid key " + key);
    }

    private <T> Integer getMaxNumOutputs(Key<T> key) {
        int[] maxNumOutputs = (int[]) getBase(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_STREAMS);
        if (maxNumOutputs == null) {
            return null;
        }
        if (key.equals(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_RAW)) {
            return Integer.valueOf(maxNumOutputs[TYPE_BYTE]);
        }
        if (key.equals(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_PROC)) {
            return Integer.valueOf(maxNumOutputs[TYPE_INT32]);
        }
        if (key.equals(CameraCharacteristics.REQUEST_MAX_NUM_OUTPUT_PROC_STALLING)) {
            return Integer.valueOf(maxNumOutputs[TYPE_FLOAT]);
        }
        throw new AssertionError("Invalid key " + key);
    }

    private <T> TonemapCurve getTonemapCurve() {
        float[] red = (float[]) getBase(CaptureRequest.TONEMAP_CURVE_RED);
        float[] green = (float[]) getBase(CaptureRequest.TONEMAP_CURVE_GREEN);
        float[] blue = (float[]) getBase(CaptureRequest.TONEMAP_CURVE_BLUE);
        Object[] objArr = new Object[TYPE_INT64];
        objArr[TYPE_BYTE] = red;
        objArr[TYPE_INT32] = green;
        objArr[TYPE_FLOAT] = blue;
        if (areValuesAllNull(objArr)) {
            return null;
        }
        if (red != null && green != null && blue != null) {
            return new TonemapCurve(red, green, blue);
        }
        Log.w(TAG, "getTonemapCurve - missing tone curve components");
        return null;
    }

    private <T> void setBase(android.hardware.camera2.CameraCharacteristics.Key<T> key, T value) {
        setBase(key.getNativeKey(), (Object) value);
    }

    private <T> void setBase(android.hardware.camera2.CaptureResult.Key<T> key, T value) {
        setBase(key.getNativeKey(), (Object) value);
    }

    private <T> void setBase(android.hardware.camera2.CaptureRequest.Key<T> key, T value) {
        setBase(key.getNativeKey(), (Object) value);
    }

    private <T> void setBase(Key<T> key, T value) {
        int tag = key.getTag();
        if (value == null) {
            writeValues(tag, null);
            return;
        }
        Marshaler<T> marshaler = getMarshalerForKey(key);
        byte[] values = new byte[marshaler.calculateMarshalSize(value)];
        marshaler.marshal(value, ByteBuffer.wrap(values).order(ByteOrder.nativeOrder()));
        writeValues(tag, values);
    }

    private boolean setAvailableFormats(int[] value) {
        int[] availableFormat = value;
        if (value == null) {
            return false;
        }
        Object newValues = new int[availableFormat.length];
        for (int i = TYPE_BYTE; i < availableFormat.length; i += TYPE_INT32) {
            newValues[i] = availableFormat[i];
            if (availableFormat[i] == 256) {
                newValues[i] = NATIVE_JPEG_FORMAT;
            }
        }
        setBase(CameraCharacteristics.SCALER_AVAILABLE_FORMATS, newValues);
        return true;
    }

    private boolean setFaceRectangles(Rect[] faceRects) {
        if (faceRects == null) {
            return false;
        }
        Object newFaceRects = new Rect[faceRects.length];
        for (int i = TYPE_BYTE; i < newFaceRects.length; i += TYPE_INT32) {
            newFaceRects[i] = new Rect(faceRects[i].left, faceRects[i].top, faceRects[i].right + faceRects[i].left, faceRects[i].bottom + faceRects[i].top);
        }
        setBase(CaptureResult.STATISTICS_FACE_RECTANGLES, newFaceRects);
        return true;
    }

    private <T> boolean setTonemapCurve(TonemapCurve tc) {
        if (tc == null) {
            return false;
        }
        float[][] curve = new float[TYPE_INT64][];
        for (int i = TYPE_BYTE; i <= TYPE_FLOAT; i += TYPE_INT32) {
            curve[i] = new float[(tc.getPointCount(i) * TYPE_FLOAT)];
            tc.copyColorCurve(i, curve[i], TYPE_BYTE);
        }
        setBase(CaptureRequest.TONEMAP_CURVE_RED, curve[TYPE_BYTE]);
        setBase(CaptureRequest.TONEMAP_CURVE_GREEN, curve[TYPE_INT32]);
        setBase(CaptureRequest.TONEMAP_CURVE_BLUE, curve[TYPE_FLOAT]);
        return true;
    }

    public void swap(CameraMetadataNative other) {
        nativeSwap(other);
    }

    public int getEntryCount() {
        return nativeGetEntryCount();
    }

    public boolean isEmpty() {
        return nativeIsEmpty();
    }

    public static int getTag(String key) {
        return nativeGetTagFromKey(key);
    }

    public static int getNativeType(int tag) {
        return nativeGetTypeFromTag(tag);
    }

    public void writeValues(int tag, byte[] src) {
        nativeWriteValues(tag, src);
    }

    public byte[] readValues(int tag) {
        return nativeReadValues(tag);
    }

    public void dumpToLog() {
        try {
            nativeDump();
        } catch (IOException e) {
            Log.wtf(TAG, "Dump logging failed", e);
        }
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    private static <T> Marshaler<T> getMarshalerForKey(Key<T> key) {
        return MarshalRegistry.getMarshaler(key.getTypeReference(), getNativeType(key.getTag()));
    }

    private static void registerAllMarshalers() {
        if (VERBOSE) {
            Log.v(TAG, "Shall register metadata marshalers");
        }
        MarshalQueryable[] arr$ = new MarshalQueryable[]{new MarshalQueryablePrimitive(), new MarshalQueryableEnum(), new MarshalQueryableArray(), new MarshalQueryableBoolean(), new MarshalQueryableNativeByteToInteger(), new MarshalQueryableRect(), new MarshalQueryableSize(), new MarshalQueryableSizeF(), new MarshalQueryableString(), new MarshalQueryableReprocessFormatsMap(), new MarshalQueryableRange(), new MarshalQueryablePair(), new MarshalQueryableMeteringRectangle(), new MarshalQueryableColorSpaceTransform(), new MarshalQueryableStreamConfiguration(), new MarshalQueryableStreamConfigurationDuration(), new MarshalQueryableRggbChannelVector(), new MarshalQueryableBlackLevelPattern(), new MarshalQueryableHighSpeedVideoConfiguration(), new MarshalQueryableParcelable()};
        int len$ = arr$.length;
        for (int i$ = TYPE_BYTE; i$ < len$; i$ += TYPE_INT32) {
            MarshalRegistry.registerMarshalQueryable(arr$[i$]);
        }
        if (VERBOSE) {
            Log.v(TAG, "Registered metadata marshalers");
        }
    }

    private static boolean areValuesAllNull(Object... objs) {
        Object[] arr$ = objs;
        int len$ = arr$.length;
        for (int i$ = TYPE_BYTE; i$ < len$; i$ += TYPE_INT32) {
            if (arr$[i$] != null) {
                return false;
            }
        }
        return true;
    }
}
