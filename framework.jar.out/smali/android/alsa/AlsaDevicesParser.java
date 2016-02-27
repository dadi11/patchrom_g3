package android.alsa;

import android.content.Context;
import android.net.ProxyInfo;
import android.util.Slog;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Vector;

public class AlsaDevicesParser {
    private static final String TAG = "AlsaDevicesParser";
    private static final int kEndIndex_CardNum = 8;
    private static final int kEndIndex_DeviceNum = 11;
    private static final int kIndex_CardDeviceField = 5;
    private static final int kStartIndex_CardNum = 6;
    private static final int kStartIndex_DeviceNum = 9;
    private static final int kStartIndex_Type = 14;
    private static LineTokenizer mTokenizer;
    private Vector<AlsaDeviceRecord> deviceRecords_;
    private boolean mHasCaptureDevices;
    private boolean mHasMIDIDevices;
    private boolean mHasPlaybackDevices;

    public class AlsaDeviceRecord {
        public static final int kDeviceDir_Capture = 0;
        public static final int kDeviceDir_Playback = 1;
        public static final int kDeviceDir_Unknown = -1;
        public static final int kDeviceType_Audio = 0;
        public static final int kDeviceType_Control = 1;
        public static final int kDeviceType_MIDI = 2;
        public static final int kDeviceType_Unknown = -1;
        int mCardNum;
        int mDeviceDir;
        int mDeviceNum;
        int mDeviceType;

        public AlsaDeviceRecord() {
            this.mCardNum = kDeviceType_Unknown;
            this.mDeviceNum = kDeviceType_Unknown;
            this.mDeviceType = kDeviceType_Unknown;
            this.mDeviceDir = kDeviceType_Unknown;
        }

        public boolean parse(String line) {
            int delimOffset = kDeviceType_Audio;
            int tokenIndex = kDeviceType_Audio;
            while (true) {
                int tokenOffset = AlsaDevicesParser.mTokenizer.nextToken(line, delimOffset);
                if (tokenOffset == kDeviceType_Unknown) {
                    return true;
                }
                delimOffset = AlsaDevicesParser.mTokenizer.nextDelimiter(line, tokenOffset);
                if (delimOffset == kDeviceType_Unknown) {
                    delimOffset = line.length();
                }
                String token = line.substring(tokenOffset, delimOffset);
                switch (tokenIndex) {
                    case kDeviceType_Control /*1*/:
                        this.mCardNum = Integer.parseInt(token);
                        if (line.charAt(delimOffset) == '-') {
                            break;
                        }
                        tokenIndex += kDeviceType_Control;
                        break;
                    case kDeviceType_MIDI /*2*/:
                        this.mDeviceNum = Integer.parseInt(token);
                        break;
                    case SetDrawableParameters.TAG /*3*/:
                        if (!token.equals("digital")) {
                            if (!token.equals("control")) {
                                if (!token.equals("raw")) {
                                    break;
                                }
                                break;
                            }
                            this.mDeviceType = kDeviceType_Control;
                            break;
                        }
                        break;
                    case ViewGroupAction.TAG /*4*/:
                        if (!token.equals(Context.AUDIO_SERVICE)) {
                            if (!token.equals("midi")) {
                                break;
                            }
                            this.mDeviceType = kDeviceType_MIDI;
                            AlsaDevicesParser.this.mHasMIDIDevices = true;
                            break;
                        }
                        this.mDeviceType = kDeviceType_Audio;
                        break;
                    case AlsaDevicesParser.kIndex_CardDeviceField /*5*/:
                        if (!token.equals("capture")) {
                            if (!token.equals("playback")) {
                                break;
                            }
                            this.mDeviceDir = kDeviceType_Control;
                            AlsaDevicesParser.this.mHasPlaybackDevices = true;
                            break;
                        }
                        this.mDeviceDir = kDeviceType_Audio;
                        AlsaDevicesParser.this.mHasCaptureDevices = true;
                        break;
                    default:
                        break;
                }
                tokenIndex += kDeviceType_Control;
            }
        }

        public String textFormat() {
            StringBuilder sb = new StringBuilder();
            sb.append("[" + this.mCardNum + ":" + this.mDeviceNum + "]");
            switch (this.mDeviceType) {
                case kDeviceType_Unknown /*-1*/:
                    sb.append(" N/A");
                    break;
                case kDeviceType_Audio /*0*/:
                    sb.append(" Audio");
                    break;
                case kDeviceType_Control /*1*/:
                    sb.append(" Control");
                    break;
                case kDeviceType_MIDI /*2*/:
                    sb.append(" MIDI");
                    break;
            }
            switch (this.mDeviceDir) {
                case kDeviceType_Unknown /*-1*/:
                    sb.append(" N/A");
                    break;
                case kDeviceType_Audio /*0*/:
                    sb.append(" Capture");
                    break;
                case kDeviceType_Control /*1*/:
                    sb.append(" Playback");
                    break;
            }
            return sb.toString();
        }
    }

    static {
        mTokenizer = new LineTokenizer(" :[]-");
    }

    private boolean isLineDeviceRecord(String line) {
        return line.charAt(kIndex_CardDeviceField) == '[';
    }

    public AlsaDevicesParser() {
        this.mHasCaptureDevices = false;
        this.mHasPlaybackDevices = false;
        this.mHasMIDIDevices = false;
        this.deviceRecords_ = new Vector();
    }

    public int getNumDeviceRecords() {
        return this.deviceRecords_.size();
    }

    public AlsaDeviceRecord getDeviceRecordAt(int index) {
        return (AlsaDeviceRecord) this.deviceRecords_.get(index);
    }

    public void Log() {
        int numDevRecs = getNumDeviceRecords();
        for (int index = 0; index < numDevRecs; index++) {
            Slog.w(TAG, "usb:" + getDeviceRecordAt(index).textFormat());
        }
    }

    public boolean hasPlaybackDevices() {
        return this.mHasPlaybackDevices;
    }

    public boolean hasPlaybackDevices(int card) {
        for (int index = 0; index < this.deviceRecords_.size(); index++) {
            AlsaDeviceRecord deviceRecord = (AlsaDeviceRecord) this.deviceRecords_.get(index);
            if (deviceRecord.mCardNum == card && deviceRecord.mDeviceType == 0 && deviceRecord.mDeviceDir == 1) {
                return true;
            }
        }
        return false;
    }

    public boolean hasCaptureDevices() {
        return this.mHasCaptureDevices;
    }

    public boolean hasCaptureDevices(int card) {
        for (int index = 0; index < this.deviceRecords_.size(); index++) {
            AlsaDeviceRecord deviceRecord = (AlsaDeviceRecord) this.deviceRecords_.get(index);
            if (deviceRecord.mCardNum == card && deviceRecord.mDeviceType == 0 && deviceRecord.mDeviceDir == 0) {
                return true;
            }
        }
        return false;
    }

    public boolean hasMIDIDevices() {
        return this.mHasMIDIDevices;
    }

    public boolean hasMIDIDevices(int card) {
        for (int index = 0; index < this.deviceRecords_.size(); index++) {
            AlsaDeviceRecord deviceRecord = (AlsaDeviceRecord) this.deviceRecords_.get(index);
            if (deviceRecord.mCardNum == card && deviceRecord.mDeviceType == 2) {
                return true;
            }
        }
        return false;
    }

    public void scan() {
        this.deviceRecords_.clear();
        String devicesFilePath = "/proc/asound/devices";
        try {
            FileReader reader = new FileReader(new File("/proc/asound/devices"));
            BufferedReader bufferedReader = new BufferedReader(reader);
            String str = ProxyInfo.LOCAL_EXCL_LIST;
            while (true) {
                str = bufferedReader.readLine();
                if (str == null) {
                    reader.close();
                    return;
                } else if (isLineDeviceRecord(str)) {
                    AlsaDeviceRecord deviceRecord = new AlsaDeviceRecord();
                    deviceRecord.parse(str);
                    this.deviceRecords_.add(deviceRecord);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e2) {
            e2.printStackTrace();
        }
    }
}
