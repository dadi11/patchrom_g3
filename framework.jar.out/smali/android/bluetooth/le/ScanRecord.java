package android.bluetooth.le;

import android.bluetooth.BluetoothUuid;
import android.os.ParcelUuid;
import android.util.SparseArray;
import java.util.List;
import java.util.Map;

public final class ScanRecord {
    private static final int DATA_TYPE_FLAGS = 1;
    private static final int DATA_TYPE_LOCAL_NAME_COMPLETE = 9;
    private static final int DATA_TYPE_LOCAL_NAME_SHORT = 8;
    private static final int DATA_TYPE_MANUFACTURER_SPECIFIC_DATA = 255;
    private static final int DATA_TYPE_SERVICE_DATA = 22;
    private static final int DATA_TYPE_SERVICE_UUIDS_128_BIT_COMPLETE = 7;
    private static final int DATA_TYPE_SERVICE_UUIDS_128_BIT_PARTIAL = 6;
    private static final int DATA_TYPE_SERVICE_UUIDS_16_BIT_COMPLETE = 3;
    private static final int DATA_TYPE_SERVICE_UUIDS_16_BIT_PARTIAL = 2;
    private static final int DATA_TYPE_SERVICE_UUIDS_32_BIT_COMPLETE = 5;
    private static final int DATA_TYPE_SERVICE_UUIDS_32_BIT_PARTIAL = 4;
    private static final int DATA_TYPE_TX_POWER_LEVEL = 10;
    private static final String TAG = "ScanRecord";
    private final int mAdvertiseFlags;
    private final byte[] mBytes;
    private final String mDeviceName;
    private final SparseArray<byte[]> mManufacturerSpecificData;
    private final Map<ParcelUuid, byte[]> mServiceData;
    private final List<ParcelUuid> mServiceUuids;
    private final int mTxPowerLevel;

    public int getAdvertiseFlags() {
        return this.mAdvertiseFlags;
    }

    public List<ParcelUuid> getServiceUuids() {
        return this.mServiceUuids;
    }

    public SparseArray<byte[]> getManufacturerSpecificData() {
        return this.mManufacturerSpecificData;
    }

    public byte[] getManufacturerSpecificData(int manufacturerId) {
        return (byte[]) this.mManufacturerSpecificData.get(manufacturerId);
    }

    public Map<ParcelUuid, byte[]> getServiceData() {
        return this.mServiceData;
    }

    public byte[] getServiceData(ParcelUuid serviceDataUuid) {
        if (serviceDataUuid == null) {
            return null;
        }
        return (byte[]) this.mServiceData.get(serviceDataUuid);
    }

    public int getTxPowerLevel() {
        return this.mTxPowerLevel;
    }

    public String getDeviceName() {
        return this.mDeviceName;
    }

    public byte[] getBytes() {
        return this.mBytes;
    }

    private ScanRecord(List<ParcelUuid> serviceUuids, SparseArray<byte[]> manufacturerData, Map<ParcelUuid, byte[]> serviceData, int advertiseFlags, int txPowerLevel, String localName, byte[] bytes) {
        this.mServiceUuids = serviceUuids;
        this.mManufacturerSpecificData = manufacturerData;
        this.mServiceData = serviceData;
        this.mDeviceName = localName;
        this.mAdvertiseFlags = advertiseFlags;
        this.mTxPowerLevel = txPowerLevel;
        this.mBytes = bytes;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public static android.bluetooth.le.ScanRecord parseFromBytes(byte[] r30) {
        /*
        if (r30 != 0) goto L_0x0004;
    L_0x0002:
        r3 = 0;
    L_0x0003:
        return r3;
    L_0x0004:
        r18 = 0;
        r7 = -1;
        r4 = new java.util.ArrayList;
        r4.<init>();
        r9 = 0;
        r8 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r5 = new android.util.SparseArray;
        r5.<init>();
        r6 = new android.util.ArrayMap;
        r6.<init>();
        r19 = r18;
    L_0x001b:
        r0 = r30;
        r3 = r0.length;	 Catch:{ Exception -> 0x008c }
        r0 = r19;
        if (r0 >= r3) goto L_0x00fd;
    L_0x0022:
        r18 = r19 + 1;
        r3 = r30[r19];	 Catch:{ Exception -> 0x003b }
        r0 = r3 & 255;
        r23 = r0;
        if (r23 != 0) goto L_0x006a;
    L_0x002c:
        r3 = r4.isEmpty();	 Catch:{ Exception -> 0x003b }
        if (r3 == 0) goto L_0x0033;
    L_0x0032:
        r4 = 0;
    L_0x0033:
        r3 = new android.bluetooth.le.ScanRecord;	 Catch:{ Exception -> 0x003b }
        r10 = r30;
        r3.<init>(r4, r5, r6, r7, r8, r9, r10);	 Catch:{ Exception -> 0x003b }
        goto L_0x0003;
    L_0x003b:
        r21 = move-exception;
    L_0x003c:
        r3 = "ScanRecord";
        r10 = new java.lang.StringBuilder;
        r10.<init>();
        r11 = "unable to parse scan record: ";
        r10 = r10.append(r11);
        r11 = java.util.Arrays.toString(r30);
        r10 = r10.append(r11);
        r10 = r10.toString();
        android.util.Log.e(r3, r10);
        r10 = new android.bluetooth.le.ScanRecord;
        r11 = 0;
        r12 = 0;
        r13 = 0;
        r14 = -1;
        r15 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r16 = 0;
        r17 = r30;
        r10.<init>(r11, r12, r13, r14, r15, r16, r17);
        r3 = r10;
        goto L_0x0003;
    L_0x006a:
        r20 = r23 + -1;
        r19 = r18 + 1;
        r3 = r30[r18];	 Catch:{ Exception -> 0x008c }
        r0 = r3 & 255;
        r22 = r0;
        switch(r22) {
            case 1: goto L_0x007c;
            case 2: goto L_0x0081;
            case 3: goto L_0x0081;
            case 4: goto L_0x0090;
            case 5: goto L_0x0090;
            case 6: goto L_0x009b;
            case 7: goto L_0x009b;
            case 8: goto L_0x00a7;
            case 9: goto L_0x00a7;
            case 10: goto L_0x00b7;
            case 22: goto L_0x00ba;
            case 255: goto L_0x00dc;
            default: goto L_0x0077;
        };	 Catch:{ Exception -> 0x008c }
    L_0x0077:
        r18 = r19 + r20;
        r19 = r18;
        goto L_0x001b;
    L_0x007c:
        r3 = r30[r19];	 Catch:{ Exception -> 0x008c }
        r7 = r3 & 255;
        goto L_0x0077;
    L_0x0081:
        r3 = 2;
        r0 = r30;
        r1 = r19;
        r2 = r20;
        parseServiceUuid(r0, r1, r2, r3, r4);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x008c:
        r21 = move-exception;
        r18 = r19;
        goto L_0x003c;
    L_0x0090:
        r3 = 4;
        r0 = r30;
        r1 = r19;
        r2 = r20;
        parseServiceUuid(r0, r1, r2, r3, r4);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x009b:
        r3 = 16;
        r0 = r30;
        r1 = r19;
        r2 = r20;
        parseServiceUuid(r0, r1, r2, r3, r4);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x00a7:
        r9 = new java.lang.String;	 Catch:{ Exception -> 0x008c }
        r0 = r30;
        r1 = r19;
        r2 = r20;
        r3 = extractBytes(r0, r1, r2);	 Catch:{ Exception -> 0x008c }
        r9.<init>(r3);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x00b7:
        r8 = r30[r19];	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x00ba:
        r29 = 2;
        r0 = r30;
        r1 = r19;
        r2 = r29;
        r28 = extractBytes(r0, r1, r2);	 Catch:{ Exception -> 0x008c }
        r27 = android.bluetooth.BluetoothUuid.parseUuidFrom(r28);	 Catch:{ Exception -> 0x008c }
        r3 = r19 + r29;
        r10 = r20 - r29;
        r0 = r30;
        r26 = extractBytes(r0, r3, r10);	 Catch:{ Exception -> 0x008c }
        r0 = r27;
        r1 = r26;
        r6.put(r0, r1);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x00dc:
        r3 = r19 + 1;
        r3 = r30[r3];	 Catch:{ Exception -> 0x008c }
        r3 = r3 & 255;
        r3 = r3 << 8;
        r10 = r30[r19];	 Catch:{ Exception -> 0x008c }
        r10 = r10 & 255;
        r25 = r3 + r10;
        r3 = r19 + 2;
        r10 = r20 + -2;
        r0 = r30;
        r24 = extractBytes(r0, r3, r10);	 Catch:{ Exception -> 0x008c }
        r0 = r25;
        r1 = r24;
        r5.put(r0, r1);	 Catch:{ Exception -> 0x008c }
        goto L_0x0077;
    L_0x00fd:
        r18 = r19;
        goto L_0x002c;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.bluetooth.le.ScanRecord.parseFromBytes(byte[]):android.bluetooth.le.ScanRecord");
    }

    public String toString() {
        return "ScanRecord [mAdvertiseFlags=" + this.mAdvertiseFlags + ", mServiceUuids=" + this.mServiceUuids + ", mManufacturerSpecificData=" + BluetoothLeUtils.toString(this.mManufacturerSpecificData) + ", mServiceData=" + BluetoothLeUtils.toString(this.mServiceData) + ", mTxPowerLevel=" + this.mTxPowerLevel + ", mDeviceName=" + this.mDeviceName + "]";
    }

    private static int parseServiceUuid(byte[] scanRecord, int currentPos, int dataLength, int uuidLength, List<ParcelUuid> serviceUuids) {
        while (dataLength > 0) {
            serviceUuids.add(BluetoothUuid.parseUuidFrom(extractBytes(scanRecord, currentPos, uuidLength)));
            dataLength -= uuidLength;
            currentPos += uuidLength;
        }
        return currentPos;
    }

    private static byte[] extractBytes(byte[] scanRecord, int start, int length) {
        byte[] bytes = new byte[length];
        System.arraycopy(scanRecord, start, bytes, 0, length);
        return bytes;
    }
}
