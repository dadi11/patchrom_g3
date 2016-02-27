package android.net.wifi;

import android.content.Context;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;
import com.android.internal.util.AsyncChannel;
import java.util.List;
import java.util.concurrent.CountDownLatch;

public class WifiScanner {
    private static final int BASE = 159744;
    public static final int CMD_AP_FOUND = 159753;
    public static final int CMD_AP_LOST = 159754;
    public static final int CMD_CONFIGURE_WIFI_CHANGE = 159757;
    public static final int CMD_FULL_SCAN_RESULT = 159764;
    public static final int CMD_GET_SCAN_RESULTS = 159748;
    public static final int CMD_OP_FAILED = 159762;
    public static final int CMD_OP_SUCCEEDED = 159761;
    public static final int CMD_PERIOD_CHANGED = 159763;
    public static final int CMD_RESET_HOTLIST = 159751;
    public static final int CMD_SCAN = 159744;
    public static final int CMD_SCAN_RESULT = 159749;
    public static final int CMD_SET_HOTLIST = 159750;
    public static final int CMD_START_BACKGROUND_SCAN = 159746;
    public static final int CMD_START_TRACKING_CHANGE = 159755;
    public static final int CMD_STOP_BACKGROUND_SCAN = 159747;
    public static final int CMD_STOP_TRACKING_CHANGE = 159756;
    public static final int CMD_WIFI_CHANGES_STABILIZED = 159760;
    public static final int CMD_WIFI_CHANGE_DETECTED = 159759;
    private static final boolean DBG = false;
    public static final String GET_AVAILABLE_CHANNELS_EXTRA = "Channels";
    private static final int INVALID_KEY = 0;
    public static final int MAX_SCAN_PERIOD_MS = 1024000;
    public static final int MIN_SCAN_PERIOD_MS = 1000;
    public static final int REASON_INVALID_LISTENER = -2;
    public static final int REASON_INVALID_REQUEST = -3;
    public static final int REASON_NOT_AUTHORIZED = -4;
    public static final int REASON_SUCCEEDED = 0;
    public static final int REASON_UNSPECIFIED = -1;
    public static final int REPORT_EVENT_AFTER_BUFFER_FULL = 0;
    public static final int REPORT_EVENT_AFTER_EACH_SCAN = 1;
    public static final int REPORT_EVENT_FULL_SCAN_RESULT = 2;
    private static final String TAG = "WifiScanner";
    public static final int WIFI_BAND_24_GHZ = 1;
    public static final int WIFI_BAND_5_GHZ = 2;
    public static final int WIFI_BAND_5_GHZ_DFS_ONLY = 4;
    public static final int WIFI_BAND_5_GHZ_WITH_DFS = 6;
    public static final int WIFI_BAND_BOTH = 3;
    public static final int WIFI_BAND_BOTH_WITH_DFS = 7;
    public static final int WIFI_BAND_UNSPECIFIED = 0;
    private static AsyncChannel sAsyncChannel;
    private static CountDownLatch sConnected;
    private static HandlerThread sHandlerThread;
    private static int sListenerKey;
    private static final SparseArray sListenerMap;
    private static final Object sListenerMapLock;
    private static int sThreadRefCount;
    private static final Object sThreadRefLock;
    private Context mContext;
    private IWifiScanner mService;

    public interface ActionListener {
        void onFailure(int i, String str);

        void onSuccess();
    }

    public static class BssidInfo {
        public String bssid;
        public int frequencyHint;
        public int high;
        public int low;
    }

    public interface BssidListener extends ActionListener {
        void onFound(ScanResult[] scanResultArr);
    }

    public static class ChannelSpec {
        public int dwellTimeMS;
        public int frequency;
        public boolean passive;

        public ChannelSpec(int frequency) {
            this.frequency = frequency;
            this.passive = WifiScanner.DBG;
            this.dwellTimeMS = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }
    }

    public static class HotlistSettings implements Parcelable {
        public static final Creator<HotlistSettings> CREATOR;
        public int apLostThreshold;
        public BssidInfo[] bssidInfos;

        /* renamed from: android.net.wifi.WifiScanner.HotlistSettings.1 */
        static class C05421 implements Creator<HotlistSettings> {
            C05421() {
            }

            public HotlistSettings createFromParcel(Parcel in) {
                HotlistSettings settings = new HotlistSettings();
                settings.apLostThreshold = in.readInt();
                int n = in.readInt();
                settings.bssidInfos = new BssidInfo[n];
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < n; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    BssidInfo info = new BssidInfo();
                    info.bssid = in.readString();
                    info.low = in.readInt();
                    info.high = in.readInt();
                    info.frequencyHint = in.readInt();
                    settings.bssidInfos[i] = info;
                }
                return settings;
            }

            public HotlistSettings[] newArray(int size) {
                return new HotlistSettings[size];
            }
        }

        public int describeContents() {
            return WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.apLostThreshold);
            if (this.bssidInfos != null) {
                dest.writeInt(this.bssidInfos.length);
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < this.bssidInfos.length; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    BssidInfo info = this.bssidInfos[i];
                    dest.writeString(info.bssid);
                    dest.writeInt(info.low);
                    dest.writeInt(info.high);
                    dest.writeInt(info.frequencyHint);
                }
                return;
            }
            dest.writeInt(WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL);
        }

        static {
            CREATOR = new C05421();
        }
    }

    public static class OperationResult implements Parcelable {
        public static final Creator<OperationResult> CREATOR;
        public String description;
        public int reason;

        /* renamed from: android.net.wifi.WifiScanner.OperationResult.1 */
        static class C05431 implements Creator<OperationResult> {
            C05431() {
            }

            public OperationResult createFromParcel(Parcel in) {
                return new OperationResult(in.readInt(), in.readString());
            }

            public OperationResult[] newArray(int size) {
                return new OperationResult[size];
            }
        }

        public OperationResult(int reason, String description) {
            this.reason = reason;
            this.description = description;
        }

        public int describeContents() {
            return WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.reason);
            dest.writeString(this.description);
        }

        static {
            CREATOR = new C05431();
        }
    }

    public static class ParcelableScanResults implements Parcelable {
        public static final Creator<ParcelableScanResults> CREATOR;
        public ScanResult[] mResults;

        /* renamed from: android.net.wifi.WifiScanner.ParcelableScanResults.1 */
        static class C05441 implements Creator<ParcelableScanResults> {
            C05441() {
            }

            public ParcelableScanResults createFromParcel(Parcel in) {
                int n = in.readInt();
                ScanResult[] results = new ScanResult[n];
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < n; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    results[i] = (ScanResult) ScanResult.CREATOR.createFromParcel(in);
                }
                return new ParcelableScanResults(results);
            }

            public ParcelableScanResults[] newArray(int size) {
                return new ParcelableScanResults[size];
            }
        }

        public ParcelableScanResults(ScanResult[] results) {
            this.mResults = results;
        }

        public ScanResult[] getResults() {
            return this.mResults;
        }

        public int describeContents() {
            return WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }

        public void writeToParcel(Parcel dest, int flags) {
            if (this.mResults != null) {
                dest.writeInt(this.mResults.length);
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < this.mResults.length; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    this.mResults[i].writeToParcel(dest, flags);
                }
                return;
            }
            dest.writeInt(WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL);
        }

        static {
            CREATOR = new C05441();
        }
    }

    public interface ScanListener extends ActionListener {
        void onFullResult(ScanResult scanResult);

        void onPeriodChanged(int i);

        void onResults(ScanResult[] scanResultArr);
    }

    public static class ScanSettings implements Parcelable {
        public static final Creator<ScanSettings> CREATOR;
        public int band;
        public ChannelSpec[] channels;
        public int numBssidsPerScan;
        public int periodInMs;
        public int reportEvents;

        /* renamed from: android.net.wifi.WifiScanner.ScanSettings.1 */
        static class C05451 implements Creator<ScanSettings> {
            C05451() {
            }

            public ScanSettings createFromParcel(Parcel in) {
                ScanSettings settings = new ScanSettings();
                settings.band = in.readInt();
                settings.periodInMs = in.readInt();
                settings.reportEvents = in.readInt();
                settings.numBssidsPerScan = in.readInt();
                int num_channels = in.readInt();
                settings.channels = new ChannelSpec[num_channels];
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < num_channels; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    ChannelSpec spec = new ChannelSpec(in.readInt());
                    spec.dwellTimeMS = in.readInt();
                    spec.passive = in.readInt() == WifiScanner.WIFI_BAND_24_GHZ ? true : WifiScanner.DBG;
                    settings.channels[i] = spec;
                }
                return settings;
            }

            public ScanSettings[] newArray(int size) {
                return new ScanSettings[size];
            }
        }

        public int describeContents() {
            return WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.band);
            dest.writeInt(this.periodInMs);
            dest.writeInt(this.reportEvents);
            dest.writeInt(this.numBssidsPerScan);
            if (this.channels != null) {
                dest.writeInt(this.channels.length);
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < this.channels.length; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    int i2;
                    dest.writeInt(this.channels[i].frequency);
                    dest.writeInt(this.channels[i].dwellTimeMS);
                    if (this.channels[i].passive) {
                        i2 = WifiScanner.WIFI_BAND_24_GHZ;
                    } else {
                        i2 = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
                    }
                    dest.writeInt(i2);
                }
                return;
            }
            dest.writeInt(WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL);
        }

        static {
            CREATOR = new C05451();
        }
    }

    private static class ServiceHandler extends Handler {
        ServiceHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 69632:
                    if (msg.arg1 == 0) {
                        WifiScanner.sAsyncChannel.sendMessage(69633);
                    } else {
                        Log.e(WifiScanner.TAG, "Failed to set up channel connection");
                        WifiScanner.sAsyncChannel = null;
                    }
                    WifiScanner.sConnected.countDown();
                case 69634:
                case 69636:
                    Log.e(WifiScanner.TAG, "Channel connection lost");
                    WifiScanner.sAsyncChannel = null;
                    getLooper().quit();
                default:
                    Object listener = WifiScanner.getListener(msg.arg2);
                    if (listener != null) {
                        switch (msg.what) {
                            case WifiScanner.CMD_SCAN_RESULT /*159749*/:
                                ((ScanListener) listener).onResults(((ParcelableScanResults) msg.obj).getResults());
                            case WifiScanner.CMD_AP_FOUND /*159753*/:
                                ((BssidListener) listener).onFound(((ParcelableScanResults) msg.obj).getResults());
                            case WifiScanner.CMD_WIFI_CHANGE_DETECTED /*159759*/:
                                ((WifiChangeListener) listener).onChanging(((ParcelableScanResults) msg.obj).getResults());
                            case WifiScanner.CMD_WIFI_CHANGES_STABILIZED /*159760*/:
                                ((WifiChangeListener) listener).onQuiescence(((ParcelableScanResults) msg.obj).getResults());
                            case WifiScanner.CMD_OP_SUCCEEDED /*159761*/:
                                ((ActionListener) listener).onSuccess();
                            case WifiScanner.CMD_OP_FAILED /*159762*/:
                                OperationResult result = msg.obj;
                                ((ActionListener) listener).onFailure(result.reason, result.description);
                                WifiScanner.removeListener(msg.arg2);
                            case WifiScanner.CMD_PERIOD_CHANGED /*159763*/:
                                ((ScanListener) listener).onPeriodChanged(msg.arg1);
                            case WifiScanner.CMD_FULL_SCAN_RESULT /*159764*/:
                                ((ScanListener) listener).onFullResult(msg.obj);
                            default:
                        }
                    }
            }
        }
    }

    public interface WifiChangeListener extends ActionListener {
        void onChanging(ScanResult[] scanResultArr);

        void onQuiescence(ScanResult[] scanResultArr);
    }

    public static class WifiChangeSettings implements Parcelable {
        public static final Creator<WifiChangeSettings> CREATOR;
        public BssidInfo[] bssidInfos;
        public int lostApSampleSize;
        public int minApsBreachingThreshold;
        public int periodInMs;
        public int rssiSampleSize;
        public int unchangedSampleSize;

        /* renamed from: android.net.wifi.WifiScanner.WifiChangeSettings.1 */
        static class C05461 implements Creator<WifiChangeSettings> {
            C05461() {
            }

            public WifiChangeSettings createFromParcel(Parcel in) {
                WifiChangeSettings settings = new WifiChangeSettings();
                settings.rssiSampleSize = in.readInt();
                settings.lostApSampleSize = in.readInt();
                settings.unchangedSampleSize = in.readInt();
                settings.minApsBreachingThreshold = in.readInt();
                settings.periodInMs = in.readInt();
                int len = in.readInt();
                settings.bssidInfos = new BssidInfo[len];
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < len; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    BssidInfo info = new BssidInfo();
                    info.bssid = in.readString();
                    info.low = in.readInt();
                    info.high = in.readInt();
                    info.frequencyHint = in.readInt();
                    settings.bssidInfos[i] = info;
                }
                return settings;
            }

            public WifiChangeSettings[] newArray(int size) {
                return new WifiChangeSettings[size];
            }
        }

        public int describeContents() {
            return WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL;
        }

        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.rssiSampleSize);
            dest.writeInt(this.lostApSampleSize);
            dest.writeInt(this.unchangedSampleSize);
            dest.writeInt(this.minApsBreachingThreshold);
            dest.writeInt(this.periodInMs);
            if (this.bssidInfos != null) {
                dest.writeInt(this.bssidInfos.length);
                for (int i = WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL; i < this.bssidInfos.length; i += WifiScanner.WIFI_BAND_24_GHZ) {
                    BssidInfo info = this.bssidInfos[i];
                    dest.writeString(info.bssid);
                    dest.writeInt(info.low);
                    dest.writeInt(info.high);
                    dest.writeInt(info.frequencyHint);
                }
                return;
            }
            dest.writeInt(WifiScanner.REPORT_EVENT_AFTER_BUFFER_FULL);
        }

        static {
            CREATOR = new C05461();
        }
    }

    public List<Integer> getAvailableChannels(int band) {
        try {
            return this.mService.getAvailableChannels(band).getIntegerArrayList(GET_AVAILABLE_CHANNELS_EXTRA);
        } catch (RemoteException e) {
            return null;
        }
    }

    public void startBackgroundScan(ScanSettings settings, ScanListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_START_BACKGROUND_SCAN, REPORT_EVENT_AFTER_BUFFER_FULL, putListener(listener), settings);
    }

    public void stopBackgroundScan(ScanListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_STOP_BACKGROUND_SCAN, REPORT_EVENT_AFTER_BUFFER_FULL, removeListener((Object) listener));
    }

    public ScanResult[] getScanResults() {
        validateChannel();
        return (ScanResult[]) sAsyncChannel.sendMessageSynchronously(CMD_GET_SCAN_RESULTS, REPORT_EVENT_AFTER_BUFFER_FULL).obj;
    }

    public void configureWifiChange(int rssiSampleSize, int lostApSampleSize, int unchangedSampleSize, int minApsBreachingThreshold, int periodInMs, BssidInfo[] bssidInfos) {
        validateChannel();
        WifiChangeSettings settings = new WifiChangeSettings();
        settings.rssiSampleSize = rssiSampleSize;
        settings.lostApSampleSize = lostApSampleSize;
        settings.unchangedSampleSize = unchangedSampleSize;
        settings.minApsBreachingThreshold = minApsBreachingThreshold;
        settings.periodInMs = periodInMs;
        settings.bssidInfos = bssidInfos;
        configureWifiChange(settings);
    }

    public void startTrackingWifiChange(WifiChangeListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_START_TRACKING_CHANGE, REPORT_EVENT_AFTER_BUFFER_FULL, putListener(listener));
    }

    public void stopTrackingWifiChange(WifiChangeListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_STOP_TRACKING_CHANGE, REPORT_EVENT_AFTER_BUFFER_FULL, removeListener((Object) listener));
    }

    public void configureWifiChange(WifiChangeSettings settings) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_CONFIGURE_WIFI_CHANGE, REPORT_EVENT_AFTER_BUFFER_FULL, REPORT_EVENT_AFTER_BUFFER_FULL, settings);
    }

    public void startTrackingBssids(BssidInfo[] bssidInfos, int apLostThreshold, BssidListener listener) {
        validateChannel();
        HotlistSettings settings = new HotlistSettings();
        settings.bssidInfos = bssidInfos;
        sAsyncChannel.sendMessage(CMD_SET_HOTLIST, REPORT_EVENT_AFTER_BUFFER_FULL, putListener(listener), settings);
    }

    public void stopTrackingBssids(BssidListener listener) {
        validateChannel();
        sAsyncChannel.sendMessage(CMD_RESET_HOTLIST, REPORT_EVENT_AFTER_BUFFER_FULL, removeListener((Object) listener));
    }

    static {
        sListenerKey = WIFI_BAND_24_GHZ;
        sListenerMap = new SparseArray();
        sListenerMapLock = new Object();
        sThreadRefLock = new Object();
    }

    public WifiScanner(Context context, IWifiScanner service) {
        this.mContext = context;
        this.mService = service;
        init();
    }

    private void init() {
        synchronized (sThreadRefLock) {
            int i = sThreadRefCount + WIFI_BAND_24_GHZ;
            sThreadRefCount = i;
            if (i == WIFI_BAND_24_GHZ) {
                Messenger messenger = null;
                try {
                    messenger = this.mService.getMessenger();
                } catch (RemoteException e) {
                } catch (SecurityException e2) {
                }
                if (messenger == null) {
                    sAsyncChannel = null;
                    return;
                }
                sHandlerThread = new HandlerThread(TAG);
                sAsyncChannel = new AsyncChannel();
                sConnected = new CountDownLatch(WIFI_BAND_24_GHZ);
                sHandlerThread.start();
                sAsyncChannel.connect(this.mContext, new ServiceHandler(sHandlerThread.getLooper()), messenger);
                try {
                    sConnected.await();
                } catch (InterruptedException e3) {
                    Log.e(TAG, "interrupted wait at init");
                }
            }
        }
    }

    private void validateChannel() {
        if (sAsyncChannel == null) {
            throw new IllegalStateException("No permission to access and change wifi or a bad initialization");
        }
    }

    private static int putListener(Object listener) {
        if (listener == null) {
            return REPORT_EVENT_AFTER_BUFFER_FULL;
        }
        int key;
        synchronized (sListenerMapLock) {
            do {
                key = sListenerKey;
                sListenerKey = key + WIFI_BAND_24_GHZ;
            } while (key == 0);
            sListenerMap.put(key, listener);
        }
        return key;
    }

    private static Object getListener(int key) {
        if (key == 0) {
            return null;
        }
        Object listener;
        synchronized (sListenerMapLock) {
            listener = sListenerMap.get(key);
        }
        return listener;
    }

    private static int getListenerKey(Object listener) {
        int i = REPORT_EVENT_AFTER_BUFFER_FULL;
        if (listener != null) {
            synchronized (sListenerMapLock) {
                int index = sListenerMap.indexOfValue(listener);
                if (index == REASON_UNSPECIFIED) {
                } else {
                    i = sListenerMap.keyAt(index);
                }
            }
        }
        return i;
    }

    private static Object removeListener(int key) {
        if (key == 0) {
            return null;
        }
        Object listener;
        synchronized (sListenerMapLock) {
            listener = sListenerMap.get(key);
            sListenerMap.remove(key);
        }
        return listener;
    }

    private static int removeListener(Object listener) {
        int key = getListenerKey(listener);
        if (key != 0) {
            synchronized (sListenerMapLock) {
                sListenerMap.remove(key);
            }
        }
        return key;
    }
}
