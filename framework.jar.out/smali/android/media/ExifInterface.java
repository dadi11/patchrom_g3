package android.media;

import android.text.format.Time;
import java.io.IOException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.TimeZone;

public class ExifInterface {
    public static final int ORIENTATION_FLIP_HORIZONTAL = 2;
    public static final int ORIENTATION_FLIP_VERTICAL = 4;
    public static final int ORIENTATION_NORMAL = 1;
    public static final int ORIENTATION_ROTATE_180 = 3;
    public static final int ORIENTATION_ROTATE_270 = 8;
    public static final int ORIENTATION_ROTATE_90 = 6;
    public static final int ORIENTATION_TRANSPOSE = 5;
    public static final int ORIENTATION_TRANSVERSE = 7;
    public static final int ORIENTATION_UNDEFINED = 0;
    public static final String TAG_APERTURE = "FNumber";
    public static final String TAG_DATETIME = "DateTime";
    public static final String TAG_EXPOSURE_TIME = "ExposureTime";
    public static final String TAG_FLASH = "Flash";
    public static final String TAG_FOCAL_LENGTH = "FocalLength";
    public static final String TAG_GPS_ALTITUDE = "GPSAltitude";
    public static final String TAG_GPS_ALTITUDE_REF = "GPSAltitudeRef";
    public static final String TAG_GPS_DATESTAMP = "GPSDateStamp";
    public static final String TAG_GPS_LATITUDE = "GPSLatitude";
    public static final String TAG_GPS_LATITUDE_REF = "GPSLatitudeRef";
    public static final String TAG_GPS_LONGITUDE = "GPSLongitude";
    public static final String TAG_GPS_LONGITUDE_REF = "GPSLongitudeRef";
    public static final String TAG_GPS_PROCESSING_METHOD = "GPSProcessingMethod";
    public static final String TAG_GPS_TIMESTAMP = "GPSTimeStamp";
    public static final String TAG_IMAGE_LENGTH = "ImageLength";
    public static final String TAG_IMAGE_WIDTH = "ImageWidth";
    public static final String TAG_ISO = "ISOSpeedRatings";
    public static final String TAG_MAKE = "Make";
    public static final String TAG_MODEL = "Model";
    public static final String TAG_ORIENTATION = "Orientation";
    public static final String TAG_WHITE_BALANCE = "WhiteBalance";
    public static final int WHITEBALANCE_AUTO = 0;
    public static final int WHITEBALANCE_MANUAL = 1;
    private static SimpleDateFormat sFormatter;
    private static final Object sLock;
    private HashMap<String, String> mAttributes;
    private String mFilename;
    private boolean mHasThumbnail;

    private native boolean appendThumbnailNative(String str, String str2);

    private native void commitChangesNative(String str);

    private native String getAttributesNative(String str);

    private native byte[] getThumbnailNative(String str);

    private native long[] getThumbnailRangeNative(String str);

    private native void saveAttributesNative(String str, String str2);

    static {
        System.loadLibrary("jhead_jni");
        sFormatter = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
        sFormatter.setTimeZone(TimeZone.getTimeZone(Time.TIMEZONE_UTC));
        sLock = new Object();
    }

    public ExifInterface(String filename) throws IOException {
        if (filename == null) {
            throw new IllegalArgumentException("filename cannot be null");
        }
        this.mFilename = filename;
        loadAttributes();
    }

    public String getAttribute(String tag) {
        return (String) this.mAttributes.get(tag);
    }

    public int getAttributeInt(String tag, int defaultValue) {
        String value = (String) this.mAttributes.get(tag);
        if (value != null) {
            try {
                defaultValue = Integer.valueOf(value).intValue();
            } catch (NumberFormatException e) {
            }
        }
        return defaultValue;
    }

    public double getAttributeDouble(String tag, double defaultValue) {
        String value = (String) this.mAttributes.get(tag);
        if (value == null) {
            return defaultValue;
        }
        try {
            int index = value.indexOf("/");
            if (index == -1) {
                return defaultValue;
            }
            double denom = Double.parseDouble(value.substring(index + WHITEBALANCE_MANUAL));
            if (denom != 0.0d) {
                return Double.parseDouble(value.substring(WHITEBALANCE_AUTO, index)) / denom;
            }
            return defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public void setAttribute(String tag, String value) {
        this.mAttributes.put(tag, value);
    }

    private void loadAttributes() throws IOException {
        String attrStr;
        this.mAttributes = new HashMap();
        synchronized (sLock) {
            attrStr = getAttributesNative(this.mFilename);
        }
        int ptr = attrStr.indexOf(32);
        int count = Integer.parseInt(attrStr.substring(WHITEBALANCE_AUTO, ptr));
        ptr += WHITEBALANCE_MANUAL;
        for (int i = WHITEBALANCE_AUTO; i < count; i += WHITEBALANCE_MANUAL) {
            int equalPos = attrStr.indexOf(61, ptr);
            String attrName = attrStr.substring(ptr, equalPos);
            ptr = equalPos + WHITEBALANCE_MANUAL;
            int lenPos = attrStr.indexOf(32, ptr);
            int attrLen = Integer.parseInt(attrStr.substring(ptr, lenPos));
            ptr = lenPos + WHITEBALANCE_MANUAL;
            String attrValue = attrStr.substring(ptr, ptr + attrLen);
            ptr += attrLen;
            if (attrName.equals("hasThumbnail")) {
                this.mHasThumbnail = attrValue.equalsIgnoreCase("true");
            } else {
                this.mAttributes.put(attrName, attrValue);
            }
        }
    }

    public void saveAttributes() throws IOException {
        StringBuilder sb = new StringBuilder();
        int size = this.mAttributes.size();
        if (this.mAttributes.containsKey("hasThumbnail")) {
            size--;
        }
        sb.append(size + " ");
        for (Entry<String, String> iter : this.mAttributes.entrySet()) {
            String key = (String) iter.getKey();
            if (!key.equals("hasThumbnail")) {
                String val = (String) iter.getValue();
                sb.append(key + "=");
                sb.append(val.length() + " ");
                sb.append(val);
            }
        }
        String s = sb.toString();
        synchronized (sLock) {
            saveAttributesNative(this.mFilename, s);
            commitChangesNative(this.mFilename);
        }
    }

    public boolean hasThumbnail() {
        return this.mHasThumbnail;
    }

    public byte[] getThumbnail() {
        byte[] thumbnailNative;
        synchronized (sLock) {
            thumbnailNative = getThumbnailNative(this.mFilename);
        }
        return thumbnailNative;
    }

    public long[] getThumbnailRange() {
        long[] thumbnailRangeNative;
        synchronized (sLock) {
            thumbnailRangeNative = getThumbnailRangeNative(this.mFilename);
        }
        return thumbnailRangeNative;
    }

    public boolean getLatLong(float[] output) {
        String latValue = (String) this.mAttributes.get(TAG_GPS_LATITUDE);
        String latRef = (String) this.mAttributes.get(TAG_GPS_LATITUDE_REF);
        String lngValue = (String) this.mAttributes.get(TAG_GPS_LONGITUDE);
        String lngRef = (String) this.mAttributes.get(TAG_GPS_LONGITUDE_REF);
        if (!(latValue == null || latRef == null || lngValue == null || lngRef == null)) {
            try {
                output[WHITEBALANCE_AUTO] = convertRationalLatLonToFloat(latValue, latRef);
                output[WHITEBALANCE_MANUAL] = convertRationalLatLonToFloat(lngValue, lngRef);
                return true;
            } catch (IllegalArgumentException e) {
            }
        }
        return false;
    }

    public double getAltitude(double defaultValue) {
        int i = -1;
        double altitude = getAttributeDouble(TAG_GPS_ALTITUDE, -1.0d);
        int ref = getAttributeInt(TAG_GPS_ALTITUDE_REF, -1);
        if (altitude < 0.0d || ref < 0) {
            return defaultValue;
        }
        if (ref != WHITEBALANCE_MANUAL) {
            i = WHITEBALANCE_MANUAL;
        }
        return altitude * ((double) i);
    }

    public long getDateTime() {
        long j = -1;
        String dateTimeString = (String) this.mAttributes.get(TAG_DATETIME);
        if (dateTimeString != null) {
            try {
                Date datetime = sFormatter.parse(dateTimeString, new ParsePosition(WHITEBALANCE_AUTO));
                if (datetime != null) {
                    j = datetime.getTime();
                }
            } catch (IllegalArgumentException e) {
            }
        }
        return j;
    }

    public long getGpsDateTime() {
        long j = -1;
        String date = (String) this.mAttributes.get(TAG_GPS_DATESTAMP);
        String time = (String) this.mAttributes.get(TAG_GPS_TIMESTAMP);
        if (!(date == null || time == null)) {
            String dateTimeString = date + ' ' + time;
            if (dateTimeString != null) {
                try {
                    Date datetime = sFormatter.parse(dateTimeString, new ParsePosition(WHITEBALANCE_AUTO));
                    if (datetime != null) {
                        j = datetime.getTime();
                    }
                } catch (IllegalArgumentException e) {
                }
            }
        }
        return j;
    }

    private static float convertRationalLatLonToFloat(String rationalString, String ref) {
        try {
            String[] parts = rationalString.split(",");
            String[] pair = parts[WHITEBALANCE_AUTO].split("/");
            double degrees = Double.parseDouble(pair[WHITEBALANCE_AUTO].trim()) / Double.parseDouble(pair[WHITEBALANCE_MANUAL].trim());
            pair = parts[WHITEBALANCE_MANUAL].split("/");
            double minutes = Double.parseDouble(pair[WHITEBALANCE_AUTO].trim()) / Double.parseDouble(pair[WHITEBALANCE_MANUAL].trim());
            pair = parts[ORIENTATION_FLIP_HORIZONTAL].split("/");
            double result = ((minutes / 60.0d) + degrees) + ((Double.parseDouble(pair[WHITEBALANCE_AUTO].trim()) / Double.parseDouble(pair[WHITEBALANCE_MANUAL].trim())) / 3600.0d);
            if (!ref.equals("S")) {
                if (!ref.equals("W")) {
                    return (float) result;
                }
            }
            return (float) (-result);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException();
        } catch (ArrayIndexOutOfBoundsException e2) {
            throw new IllegalArgumentException();
        }
    }
}
