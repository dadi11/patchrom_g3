package android.location;

import android.bluetooth.BluetoothHidDevice;
import android.net.LinkQualityInfo;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;

public class GpsMeasurement implements Parcelable {
    public static final short ADR_STATE_CYCLE_SLIP = (short) 4;
    public static final short ADR_STATE_RESET = (short) 2;
    public static final short ADR_STATE_UNKNOWN = (short) 0;
    public static final short ADR_STATE_VALID = (short) 1;
    public static final Creator<GpsMeasurement> CREATOR;
    private static final int HAS_AZIMUTH = 8;
    private static final int HAS_AZIMUTH_UNCERTAINTY = 16;
    private static final int HAS_BIT_NUMBER = 8192;
    private static final int HAS_CARRIER_CYCLES = 1024;
    private static final int HAS_CARRIER_FREQUENCY = 512;
    private static final int HAS_CARRIER_PHASE = 2048;
    private static final int HAS_CARRIER_PHASE_UNCERTAINTY = 4096;
    private static final int HAS_CODE_PHASE = 128;
    private static final int HAS_CODE_PHASE_UNCERTAINTY = 256;
    private static final int HAS_DOPPLER_SHIFT = 32768;
    private static final int HAS_DOPPLER_SHIFT_UNCERTAINTY = 65536;
    private static final int HAS_ELEVATION = 2;
    private static final int HAS_ELEVATION_UNCERTAINTY = 4;
    private static final int HAS_NO_FLAGS = 0;
    private static final int HAS_PSEUDORANGE = 32;
    private static final int HAS_PSEUDORANGE_UNCERTAINTY = 64;
    private static final int HAS_SNR = 1;
    private static final int HAS_TIME_FROM_LAST_BIT = 16384;
    public static final byte LOSS_OF_LOCK_CYCLE_SLIP = (byte) 2;
    public static final byte LOSS_OF_LOCK_OK = (byte) 1;
    public static final byte LOSS_OF_LOCK_UNKNOWN = (byte) 0;
    public static final byte MULTIPATH_INDICATOR_DETECTED = (byte) 1;
    public static final byte MULTIPATH_INDICATOR_NOT_USED = (byte) 2;
    public static final byte MULTIPATH_INDICATOR_UNKNOWN = (byte) 0;
    public static final short STATE_BIT_SYNC = (short) 2;
    public static final short STATE_CODE_LOCK = (short) 1;
    public static final short STATE_SUBFRAME_SYNC = (short) 4;
    public static final short STATE_TOW_DECODED = (short) 8;
    public static final short STATE_UNKNOWN = (short) 0;
    private static final String TAG = "GpsMeasurement";
    private double mAccumulatedDeltaRangeInMeters;
    private short mAccumulatedDeltaRangeState;
    private double mAccumulatedDeltaRangeUncertaintyInMeters;
    private double mAzimuthInDeg;
    private double mAzimuthUncertaintyInDeg;
    private int mBitNumber;
    private long mCarrierCycles;
    private float mCarrierFrequencyInHz;
    private double mCarrierPhase;
    private double mCarrierPhaseUncertainty;
    private double mCn0InDbHz;
    private double mCodePhaseInChips;
    private double mCodePhaseUncertaintyInChips;
    private double mDopplerShiftInHz;
    private double mDopplerShiftUncertaintyInHz;
    private double mElevationInDeg;
    private double mElevationUncertaintyInDeg;
    private int mFlags;
    private byte mLossOfLock;
    private byte mMultipathIndicator;
    private byte mPrn;
    private double mPseudorangeInMeters;
    private double mPseudorangeRateInMetersPerSec;
    private double mPseudorangeRateUncertaintyInMetersPerSec;
    private double mPseudorangeUncertaintyInMeters;
    private long mReceivedGpsTowInNs;
    private long mReceivedGpsTowUncertaintyInNs;
    private double mSnrInDb;
    private short mState;
    private short mTimeFromLastBitInMs;
    private double mTimeOffsetInNs;
    private boolean mUsedInFix;

    /* renamed from: android.location.GpsMeasurement.1 */
    static class C03361 implements Creator<GpsMeasurement> {
        C03361() {
        }

        public GpsMeasurement createFromParcel(Parcel parcel) {
            GpsMeasurement gpsMeasurement = new GpsMeasurement();
            gpsMeasurement.mFlags = parcel.readInt();
            gpsMeasurement.mPrn = parcel.readByte();
            gpsMeasurement.mTimeOffsetInNs = parcel.readDouble();
            gpsMeasurement.mState = (short) parcel.readInt();
            gpsMeasurement.mReceivedGpsTowInNs = parcel.readLong();
            gpsMeasurement.mReceivedGpsTowUncertaintyInNs = parcel.readLong();
            gpsMeasurement.mCn0InDbHz = parcel.readDouble();
            gpsMeasurement.mPseudorangeRateInMetersPerSec = parcel.readDouble();
            gpsMeasurement.mPseudorangeRateUncertaintyInMetersPerSec = parcel.readDouble();
            gpsMeasurement.mAccumulatedDeltaRangeState = (short) parcel.readInt();
            gpsMeasurement.mAccumulatedDeltaRangeInMeters = parcel.readDouble();
            gpsMeasurement.mAccumulatedDeltaRangeUncertaintyInMeters = parcel.readDouble();
            gpsMeasurement.mPseudorangeInMeters = parcel.readDouble();
            gpsMeasurement.mPseudorangeUncertaintyInMeters = parcel.readDouble();
            gpsMeasurement.mCodePhaseInChips = parcel.readDouble();
            gpsMeasurement.mCodePhaseUncertaintyInChips = parcel.readDouble();
            gpsMeasurement.mCarrierFrequencyInHz = parcel.readFloat();
            gpsMeasurement.mCarrierCycles = parcel.readLong();
            gpsMeasurement.mCarrierPhase = parcel.readDouble();
            gpsMeasurement.mCarrierPhaseUncertainty = parcel.readDouble();
            gpsMeasurement.mLossOfLock = parcel.readByte();
            gpsMeasurement.mBitNumber = parcel.readInt();
            gpsMeasurement.mTimeFromLastBitInMs = (short) parcel.readInt();
            gpsMeasurement.mDopplerShiftInHz = parcel.readDouble();
            gpsMeasurement.mDopplerShiftUncertaintyInHz = parcel.readDouble();
            gpsMeasurement.mMultipathIndicator = parcel.readByte();
            gpsMeasurement.mSnrInDb = parcel.readDouble();
            gpsMeasurement.mElevationInDeg = parcel.readDouble();
            gpsMeasurement.mElevationUncertaintyInDeg = parcel.readDouble();
            gpsMeasurement.mAzimuthInDeg = parcel.readDouble();
            gpsMeasurement.mAzimuthUncertaintyInDeg = parcel.readDouble();
            gpsMeasurement.mUsedInFix = parcel.readInt() != 0;
            return gpsMeasurement;
        }

        public GpsMeasurement[] newArray(int i) {
            return new GpsMeasurement[i];
        }
    }

    GpsMeasurement() {
        initialize();
    }

    public void set(GpsMeasurement measurement) {
        this.mFlags = measurement.mFlags;
        this.mPrn = measurement.mPrn;
        this.mTimeOffsetInNs = measurement.mTimeOffsetInNs;
        this.mState = measurement.mState;
        this.mReceivedGpsTowInNs = measurement.mReceivedGpsTowInNs;
        this.mReceivedGpsTowUncertaintyInNs = measurement.mReceivedGpsTowUncertaintyInNs;
        this.mCn0InDbHz = measurement.mCn0InDbHz;
        this.mPseudorangeRateInMetersPerSec = measurement.mPseudorangeRateInMetersPerSec;
        this.mPseudorangeRateUncertaintyInMetersPerSec = measurement.mPseudorangeRateUncertaintyInMetersPerSec;
        this.mAccumulatedDeltaRangeState = measurement.mAccumulatedDeltaRangeState;
        this.mAccumulatedDeltaRangeInMeters = measurement.mAccumulatedDeltaRangeInMeters;
        this.mAccumulatedDeltaRangeUncertaintyInMeters = measurement.mAccumulatedDeltaRangeUncertaintyInMeters;
        this.mPseudorangeInMeters = measurement.mPseudorangeInMeters;
        this.mPseudorangeUncertaintyInMeters = measurement.mPseudorangeUncertaintyInMeters;
        this.mCodePhaseInChips = measurement.mCodePhaseInChips;
        this.mCodePhaseUncertaintyInChips = measurement.mCodePhaseUncertaintyInChips;
        this.mCarrierFrequencyInHz = measurement.mCarrierFrequencyInHz;
        this.mCarrierCycles = measurement.mCarrierCycles;
        this.mCarrierPhase = measurement.mCarrierPhase;
        this.mCarrierPhaseUncertainty = measurement.mCarrierPhaseUncertainty;
        this.mLossOfLock = measurement.mLossOfLock;
        this.mBitNumber = measurement.mBitNumber;
        this.mTimeFromLastBitInMs = measurement.mTimeFromLastBitInMs;
        this.mDopplerShiftInHz = measurement.mDopplerShiftInHz;
        this.mDopplerShiftUncertaintyInHz = measurement.mDopplerShiftUncertaintyInHz;
        this.mMultipathIndicator = measurement.mMultipathIndicator;
        this.mSnrInDb = measurement.mSnrInDb;
        this.mElevationInDeg = measurement.mElevationInDeg;
        this.mElevationUncertaintyInDeg = measurement.mElevationUncertaintyInDeg;
        this.mAzimuthInDeg = measurement.mAzimuthInDeg;
        this.mAzimuthUncertaintyInDeg = measurement.mAzimuthUncertaintyInDeg;
        this.mUsedInFix = measurement.mUsedInFix;
    }

    public void reset() {
        initialize();
    }

    public byte getPrn() {
        return this.mPrn;
    }

    public void setPrn(byte value) {
        this.mPrn = value;
    }

    public double getTimeOffsetInNs() {
        return this.mTimeOffsetInNs;
    }

    public void setTimeOffsetInNs(double value) {
        this.mTimeOffsetInNs = value;
    }

    public short getState() {
        return this.mState;
    }

    public void setState(short value) {
        switch (value) {
            case HAS_NO_FLAGS /*0*/:
            case HAS_SNR /*1*/:
            case HAS_ELEVATION /*2*/:
            case HAS_ELEVATION_UNCERTAINTY /*4*/:
            case HAS_AZIMUTH /*8*/:
                this.mState = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'sync state': " + value);
                this.mState = STATE_UNKNOWN;
        }
    }

    private String getStateString() {
        switch (this.mState) {
            case HAS_NO_FLAGS /*0*/:
                return "Unknown";
            case HAS_SNR /*1*/:
                return "CodeLock";
            case HAS_ELEVATION /*2*/:
                return "BitSync";
            case HAS_ELEVATION_UNCERTAINTY /*4*/:
                return "SubframeSync";
            case HAS_AZIMUTH /*8*/:
                return "TowDecoded";
            default:
                return "<Invalid>";
        }
    }

    public long getReceivedGpsTowInNs() {
        return this.mReceivedGpsTowInNs;
    }

    public void setReceivedGpsTowInNs(long value) {
        this.mReceivedGpsTowInNs = value;
    }

    public long getReceivedGpsTowUncertaintyInNs() {
        return this.mReceivedGpsTowUncertaintyInNs;
    }

    public void setReceivedGpsTowUncertaintyInNs(long value) {
        this.mReceivedGpsTowUncertaintyInNs = value;
    }

    public double getCn0InDbHz() {
        return this.mCn0InDbHz;
    }

    public void setCn0InDbHz(double value) {
        this.mCn0InDbHz = value;
    }

    public double getPseudorangeRateInMetersPerSec() {
        return this.mPseudorangeRateInMetersPerSec;
    }

    public void setPseudorangeRateInMetersPerSec(double value) {
        this.mPseudorangeRateInMetersPerSec = value;
    }

    public double getPseudorangeRateUncertaintyInMetersPerSec() {
        return this.mPseudorangeRateUncertaintyInMetersPerSec;
    }

    public void setPseudorangeRateUncertaintyInMetersPerSec(double value) {
        this.mPseudorangeRateUncertaintyInMetersPerSec = value;
    }

    public short getAccumulatedDeltaRangeState() {
        return this.mAccumulatedDeltaRangeState;
    }

    public void setAccumulatedDeltaRangeState(short value) {
        switch (value) {
            case HAS_NO_FLAGS /*0*/:
            case HAS_SNR /*1*/:
            case HAS_ELEVATION /*2*/:
            case HAS_ELEVATION_UNCERTAINTY /*4*/:
                this.mAccumulatedDeltaRangeState = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'Accumulated Delta Range state': " + value);
                this.mAccumulatedDeltaRangeState = STATE_UNKNOWN;
        }
    }

    private String getAccumulatedDeltaRangeStateString() {
        switch (this.mAccumulatedDeltaRangeState) {
            case HAS_NO_FLAGS /*0*/:
                return "Unknown";
            case HAS_SNR /*1*/:
                return "Valid";
            case HAS_ELEVATION /*2*/:
                return "Reset";
            case HAS_ELEVATION_UNCERTAINTY /*4*/:
                return "CycleSlip";
            default:
                return "<Invalid>";
        }
    }

    public double getAccumulatedDeltaRangeInMeters() {
        return this.mAccumulatedDeltaRangeInMeters;
    }

    public void setAccumulatedDeltaRangeInMeters(double value) {
        this.mAccumulatedDeltaRangeInMeters = value;
    }

    public double getAccumulatedDeltaRangeUncertaintyInMeters() {
        return this.mAccumulatedDeltaRangeUncertaintyInMeters;
    }

    public void setAccumulatedDeltaRangeUncertaintyInMeters(double value) {
        this.mAccumulatedDeltaRangeUncertaintyInMeters = value;
    }

    public boolean hasPseudorangeInMeters() {
        return isFlagSet(HAS_PSEUDORANGE);
    }

    public double getPseudorangeInMeters() {
        return this.mPseudorangeInMeters;
    }

    public void setPseudorangeInMeters(double value) {
        setFlag(HAS_PSEUDORANGE);
        this.mPseudorangeInMeters = value;
    }

    public void resetPseudorangeInMeters() {
        resetFlag(HAS_PSEUDORANGE);
        this.mPseudorangeInMeters = Double.NaN;
    }

    public boolean hasPseudorangeUncertaintyInMeters() {
        return isFlagSet(HAS_PSEUDORANGE_UNCERTAINTY);
    }

    public double getPseudorangeUncertaintyInMeters() {
        return this.mPseudorangeUncertaintyInMeters;
    }

    public void setPseudorangeUncertaintyInMeters(double value) {
        setFlag(HAS_PSEUDORANGE_UNCERTAINTY);
        this.mPseudorangeUncertaintyInMeters = value;
    }

    public void resetPseudorangeUncertaintyInMeters() {
        resetFlag(HAS_PSEUDORANGE_UNCERTAINTY);
        this.mPseudorangeUncertaintyInMeters = Double.NaN;
    }

    public boolean hasCodePhaseInChips() {
        return isFlagSet(HAS_CODE_PHASE);
    }

    public double getCodePhaseInChips() {
        return this.mCodePhaseInChips;
    }

    public void setCodePhaseInChips(double value) {
        setFlag(HAS_CODE_PHASE);
        this.mCodePhaseInChips = value;
    }

    public void resetCodePhaseInChips() {
        resetFlag(HAS_CODE_PHASE);
        this.mCodePhaseInChips = Double.NaN;
    }

    public boolean hasCodePhaseUncertaintyInChips() {
        return isFlagSet(HAS_CODE_PHASE_UNCERTAINTY);
    }

    public double getCodePhaseUncertaintyInChips() {
        return this.mCodePhaseUncertaintyInChips;
    }

    public void setCodePhaseUncertaintyInChips(double value) {
        setFlag(HAS_CODE_PHASE_UNCERTAINTY);
        this.mCodePhaseUncertaintyInChips = value;
    }

    public void resetCodePhaseUncertaintyInChips() {
        resetFlag(HAS_CODE_PHASE_UNCERTAINTY);
        this.mCodePhaseUncertaintyInChips = Double.NaN;
    }

    public boolean hasCarrierFrequencyInHz() {
        return isFlagSet(HAS_CARRIER_FREQUENCY);
    }

    public float getCarrierFrequencyInHz() {
        return this.mCarrierFrequencyInHz;
    }

    public void setCarrierFrequencyInHz(float carrierFrequencyInHz) {
        setFlag(HAS_CARRIER_FREQUENCY);
        this.mCarrierFrequencyInHz = carrierFrequencyInHz;
    }

    public void resetCarrierFrequencyInHz() {
        resetFlag(HAS_CARRIER_FREQUENCY);
        this.mCarrierFrequencyInHz = Float.NaN;
    }

    public boolean hasCarrierCycles() {
        return isFlagSet(HAS_CARRIER_CYCLES);
    }

    public long getCarrierCycles() {
        return this.mCarrierCycles;
    }

    public void setCarrierCycles(long value) {
        setFlag(HAS_CARRIER_CYCLES);
        this.mCarrierCycles = value;
    }

    public void resetCarrierCycles() {
        resetFlag(HAS_CARRIER_CYCLES);
        this.mCarrierCycles = Long.MIN_VALUE;
    }

    public boolean hasCarrierPhase() {
        return isFlagSet(HAS_CARRIER_PHASE);
    }

    public double getCarrierPhase() {
        return this.mCarrierPhase;
    }

    public void setCarrierPhase(double value) {
        setFlag(HAS_CARRIER_PHASE);
        this.mCarrierPhase = value;
    }

    public void resetCarrierPhase() {
        resetFlag(HAS_CARRIER_PHASE);
        this.mCarrierPhase = Double.NaN;
    }

    public boolean hasCarrierPhaseUncertainty() {
        return isFlagSet(HAS_CARRIER_PHASE_UNCERTAINTY);
    }

    public double getCarrierPhaseUncertainty() {
        return this.mCarrierPhaseUncertainty;
    }

    public void setCarrierPhaseUncertainty(double value) {
        setFlag(HAS_CARRIER_PHASE_UNCERTAINTY);
        this.mCarrierPhaseUncertainty = value;
    }

    public void resetCarrierPhaseUncertainty() {
        resetFlag(HAS_CARRIER_PHASE_UNCERTAINTY);
        this.mCarrierPhaseUncertainty = Double.NaN;
    }

    public byte getLossOfLock() {
        return this.mLossOfLock;
    }

    public void setLossOfLock(byte value) {
        switch (value) {
            case HAS_NO_FLAGS /*0*/:
            case HAS_SNR /*1*/:
            case HAS_ELEVATION /*2*/:
                this.mLossOfLock = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'loss of lock': " + value);
                this.mLossOfLock = MULTIPATH_INDICATOR_UNKNOWN;
        }
    }

    private String getLossOfLockString() {
        switch (this.mLossOfLock) {
            case HAS_NO_FLAGS /*0*/:
                return "Unknown";
            case HAS_SNR /*1*/:
                return "Ok";
            case HAS_ELEVATION /*2*/:
                return "CycleSlip";
            default:
                return "<Invalid>";
        }
    }

    public boolean hasBitNumber() {
        return isFlagSet(HAS_BIT_NUMBER);
    }

    public int getBitNumber() {
        return this.mBitNumber;
    }

    public void setBitNumber(int bitNumber) {
        setFlag(HAS_BIT_NUMBER);
        this.mBitNumber = bitNumber;
    }

    public void resetBitNumber() {
        resetFlag(HAS_BIT_NUMBER);
        this.mBitNumber = RtlSpacingHelper.UNDEFINED;
    }

    public boolean hasTimeFromLastBitInMs() {
        return isFlagSet(HAS_TIME_FROM_LAST_BIT);
    }

    public short getTimeFromLastBitInMs() {
        return this.mTimeFromLastBitInMs;
    }

    public void setTimeFromLastBitInMs(short value) {
        setFlag(HAS_TIME_FROM_LAST_BIT);
        this.mTimeFromLastBitInMs = value;
    }

    public void resetTimeFromLastBitInMs() {
        resetFlag(HAS_TIME_FROM_LAST_BIT);
        this.mTimeFromLastBitInMs = Short.MIN_VALUE;
    }

    public boolean hasDopplerShiftInHz() {
        return isFlagSet(HAS_DOPPLER_SHIFT);
    }

    public double getDopplerShiftInHz() {
        return this.mDopplerShiftInHz;
    }

    public void setDopplerShiftInHz(double value) {
        setFlag(HAS_DOPPLER_SHIFT);
        this.mDopplerShiftInHz = value;
    }

    public void resetDopplerShiftInHz() {
        resetFlag(HAS_DOPPLER_SHIFT);
        this.mDopplerShiftInHz = Double.NaN;
    }

    public boolean hasDopplerShiftUncertaintyInHz() {
        return isFlagSet(HAS_DOPPLER_SHIFT_UNCERTAINTY);
    }

    public double getDopplerShiftUncertaintyInHz() {
        return this.mDopplerShiftUncertaintyInHz;
    }

    public void setDopplerShiftUncertaintyInHz(double value) {
        setFlag(HAS_DOPPLER_SHIFT_UNCERTAINTY);
        this.mDopplerShiftUncertaintyInHz = value;
    }

    public void resetDopplerShiftUncertaintyInHz() {
        resetFlag(HAS_DOPPLER_SHIFT_UNCERTAINTY);
        this.mDopplerShiftUncertaintyInHz = Double.NaN;
    }

    public byte getMultipathIndicator() {
        return this.mMultipathIndicator;
    }

    public void setMultipathIndicator(byte value) {
        switch (value) {
            case HAS_NO_FLAGS /*0*/:
            case HAS_SNR /*1*/:
            case HAS_ELEVATION /*2*/:
                this.mMultipathIndicator = value;
            default:
                Log.d(TAG, "Sanitizing invalid 'muti-path indicator': " + value);
                this.mMultipathIndicator = MULTIPATH_INDICATOR_UNKNOWN;
        }
    }

    private String getMultipathIndicatorString() {
        switch (this.mMultipathIndicator) {
            case HAS_NO_FLAGS /*0*/:
                return "Unknown";
            case HAS_SNR /*1*/:
                return "Detected";
            case HAS_ELEVATION /*2*/:
                return "NotUsed";
            default:
                return "<Invalid>";
        }
    }

    public boolean hasSnrInDb() {
        return isFlagSet(HAS_SNR);
    }

    public double getSnrInDb() {
        return this.mSnrInDb;
    }

    public void setSnrInDb(double snrInDb) {
        setFlag(HAS_SNR);
        this.mSnrInDb = snrInDb;
    }

    public void resetSnrInDb() {
        resetFlag(HAS_SNR);
        this.mSnrInDb = Double.NaN;
    }

    public boolean hasElevationInDeg() {
        return isFlagSet(HAS_ELEVATION);
    }

    public double getElevationInDeg() {
        return this.mElevationInDeg;
    }

    public void setElevationInDeg(double elevationInDeg) {
        setFlag(HAS_ELEVATION);
        this.mElevationInDeg = elevationInDeg;
    }

    public void resetElevationInDeg() {
        resetFlag(HAS_ELEVATION);
        this.mElevationInDeg = Double.NaN;
    }

    public boolean hasElevationUncertaintyInDeg() {
        return isFlagSet(HAS_ELEVATION_UNCERTAINTY);
    }

    public double getElevationUncertaintyInDeg() {
        return this.mElevationUncertaintyInDeg;
    }

    public void setElevationUncertaintyInDeg(double value) {
        setFlag(HAS_ELEVATION_UNCERTAINTY);
        this.mElevationUncertaintyInDeg = value;
    }

    public void resetElevationUncertaintyInDeg() {
        resetFlag(HAS_ELEVATION_UNCERTAINTY);
        this.mElevationUncertaintyInDeg = Double.NaN;
    }

    public boolean hasAzimuthInDeg() {
        return isFlagSet(HAS_AZIMUTH);
    }

    public double getAzimuthInDeg() {
        return this.mAzimuthInDeg;
    }

    public void setAzimuthInDeg(double value) {
        setFlag(HAS_AZIMUTH);
        this.mAzimuthInDeg = value;
    }

    public void resetAzimuthInDeg() {
        resetFlag(HAS_AZIMUTH);
        this.mAzimuthInDeg = Double.NaN;
    }

    public boolean hasAzimuthUncertaintyInDeg() {
        return isFlagSet(HAS_AZIMUTH_UNCERTAINTY);
    }

    public double getAzimuthUncertaintyInDeg() {
        return this.mAzimuthUncertaintyInDeg;
    }

    public void setAzimuthUncertaintyInDeg(double value) {
        setFlag(HAS_AZIMUTH_UNCERTAINTY);
        this.mAzimuthUncertaintyInDeg = value;
    }

    public void resetAzimuthUncertaintyInDeg() {
        resetFlag(HAS_AZIMUTH_UNCERTAINTY);
        this.mAzimuthUncertaintyInDeg = Double.NaN;
    }

    public boolean isUsedInFix() {
        return this.mUsedInFix;
    }

    public void setUsedInFix(boolean value) {
        this.mUsedInFix = value;
    }

    static {
        CREATOR = new C03361();
    }

    public void writeToParcel(Parcel parcel, int flags) {
        parcel.writeInt(this.mFlags);
        parcel.writeByte(this.mPrn);
        parcel.writeDouble(this.mTimeOffsetInNs);
        parcel.writeInt(this.mState);
        parcel.writeLong(this.mReceivedGpsTowInNs);
        parcel.writeLong(this.mReceivedGpsTowUncertaintyInNs);
        parcel.writeDouble(this.mCn0InDbHz);
        parcel.writeDouble(this.mPseudorangeRateInMetersPerSec);
        parcel.writeDouble(this.mPseudorangeRateUncertaintyInMetersPerSec);
        parcel.writeInt(this.mAccumulatedDeltaRangeState);
        parcel.writeDouble(this.mAccumulatedDeltaRangeInMeters);
        parcel.writeDouble(this.mAccumulatedDeltaRangeUncertaintyInMeters);
        parcel.writeDouble(this.mPseudorangeInMeters);
        parcel.writeDouble(this.mPseudorangeUncertaintyInMeters);
        parcel.writeDouble(this.mCodePhaseInChips);
        parcel.writeDouble(this.mCodePhaseUncertaintyInChips);
        parcel.writeFloat(this.mCarrierFrequencyInHz);
        parcel.writeLong(this.mCarrierCycles);
        parcel.writeDouble(this.mCarrierPhase);
        parcel.writeDouble(this.mCarrierPhaseUncertainty);
        parcel.writeByte(this.mLossOfLock);
        parcel.writeInt(this.mBitNumber);
        parcel.writeInt(this.mTimeFromLastBitInMs);
        parcel.writeDouble(this.mDopplerShiftInHz);
        parcel.writeDouble(this.mDopplerShiftUncertaintyInHz);
        parcel.writeByte(this.mMultipathIndicator);
        parcel.writeDouble(this.mSnrInDb);
        parcel.writeDouble(this.mElevationInDeg);
        parcel.writeDouble(this.mElevationUncertaintyInDeg);
        parcel.writeDouble(this.mAzimuthInDeg);
        parcel.writeDouble(this.mAzimuthUncertaintyInDeg);
        parcel.writeInt(this.mUsedInFix ? HAS_SNR : HAS_NO_FLAGS);
    }

    public int describeContents() {
        return HAS_NO_FLAGS;
    }

    public String toString() {
        Double valueOf;
        Float valueOf2;
        Long valueOf3;
        Integer valueOf4;
        Short valueOf5;
        Double d = null;
        String format = "   %-29s = %s\n";
        String formatWithUncertainty = "   %-29s = %-25s   %-40s = %s\n";
        StringBuilder builder = new StringBuilder("GpsMeasurement:\n");
        Object[] objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "Prn";
        objArr[HAS_SNR] = Byte.valueOf(this.mPrn);
        builder.append(String.format("   %-29s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "TimeOffsetInNs";
        objArr[HAS_SNR] = Double.valueOf(this.mTimeOffsetInNs);
        builder.append(String.format("   %-29s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "State";
        objArr[HAS_SNR] = getStateString();
        builder.append(String.format("   %-29s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr[HAS_NO_FLAGS] = "ReceivedGpsTowInNs";
        objArr[HAS_SNR] = Long.valueOf(this.mReceivedGpsTowInNs);
        objArr[HAS_ELEVATION] = "ReceivedGpsTowUncertaintyInNs";
        objArr[3] = Long.valueOf(this.mReceivedGpsTowUncertaintyInNs);
        builder.append(String.format("   %-29s = %-25s   %-40s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "Cn0InDbHz";
        objArr[HAS_SNR] = Double.valueOf(this.mCn0InDbHz);
        builder.append(String.format("   %-29s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr[HAS_NO_FLAGS] = "PseudorangeRateInMetersPerSec";
        objArr[HAS_SNR] = Double.valueOf(this.mPseudorangeRateInMetersPerSec);
        objArr[HAS_ELEVATION] = "PseudorangeRateUncertaintyInMetersPerSec";
        objArr[3] = Double.valueOf(this.mPseudorangeRateUncertaintyInMetersPerSec);
        builder.append(String.format("   %-29s = %-25s   %-40s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "AccumulatedDeltaRangeState";
        objArr[HAS_SNR] = getAccumulatedDeltaRangeStateString();
        builder.append(String.format("   %-29s = %s\n", objArr));
        objArr = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr[HAS_NO_FLAGS] = "AccumulatedDeltaRangeInMeters";
        objArr[HAS_SNR] = Double.valueOf(this.mAccumulatedDeltaRangeInMeters);
        objArr[HAS_ELEVATION] = "AccumulatedDeltaRangeUncertaintyInMeters";
        objArr[3] = Double.valueOf(this.mAccumulatedDeltaRangeUncertaintyInMeters);
        builder.append(String.format("   %-29s = %-25s   %-40s = %s\n", objArr));
        String str = "   %-29s = %-25s   %-40s = %s\n";
        Object[] objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "PseudorangeInMeters";
        objArr2[HAS_SNR] = hasPseudorangeInMeters() ? Double.valueOf(this.mPseudorangeInMeters) : null;
        objArr2[HAS_ELEVATION] = "PseudorangeUncertaintyInMeters";
        objArr2[3] = hasPseudorangeUncertaintyInMeters() ? Double.valueOf(this.mPseudorangeUncertaintyInMeters) : null;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %-25s   %-40s = %s\n";
        objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "CodePhaseInChips";
        if (hasCodePhaseInChips()) {
            valueOf = Double.valueOf(this.mCodePhaseInChips);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        objArr2[HAS_ELEVATION] = "CodePhaseUncertaintyInChips";
        objArr2[3] = hasCodePhaseUncertaintyInChips() ? Double.valueOf(this.mCodePhaseUncertaintyInChips) : null;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %s\n";
        objArr2 = new Object[HAS_ELEVATION];
        objArr2[HAS_NO_FLAGS] = "CarrierFrequencyInHz";
        if (hasCarrierFrequencyInHz()) {
            valueOf2 = Float.valueOf(this.mCarrierFrequencyInHz);
        } else {
            valueOf2 = null;
        }
        objArr2[HAS_SNR] = valueOf2;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %s\n";
        objArr2 = new Object[HAS_ELEVATION];
        objArr2[HAS_NO_FLAGS] = "CarrierCycles";
        if (hasCarrierCycles()) {
            valueOf3 = Long.valueOf(this.mCarrierCycles);
        } else {
            valueOf3 = null;
        }
        objArr2[HAS_SNR] = valueOf3;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %-25s   %-40s = %s\n";
        objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "CarrierPhase";
        if (hasCarrierPhase()) {
            valueOf = Double.valueOf(this.mCarrierPhase);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        objArr2[HAS_ELEVATION] = "CarrierPhaseUncertainty";
        objArr2[3] = hasCarrierPhaseUncertainty() ? Double.valueOf(this.mCarrierPhaseUncertainty) : null;
        builder.append(String.format(str, objArr2));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "LossOfLock";
        objArr[HAS_SNR] = getLossOfLockString();
        builder.append(String.format("   %-29s = %s\n", objArr));
        str = "   %-29s = %s\n";
        objArr2 = new Object[HAS_ELEVATION];
        objArr2[HAS_NO_FLAGS] = "BitNumber";
        if (hasBitNumber()) {
            valueOf4 = Integer.valueOf(this.mBitNumber);
        } else {
            valueOf4 = null;
        }
        objArr2[HAS_SNR] = valueOf4;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %s\n";
        objArr2 = new Object[HAS_ELEVATION];
        objArr2[HAS_NO_FLAGS] = "TimeFromLastBitInMs";
        if (hasTimeFromLastBitInMs()) {
            valueOf5 = Short.valueOf(this.mTimeFromLastBitInMs);
        } else {
            valueOf5 = null;
        }
        objArr2[HAS_SNR] = valueOf5;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %-25s   %-40s = %s\n";
        objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "DopplerShiftInHz";
        if (hasDopplerShiftInHz()) {
            valueOf = Double.valueOf(this.mDopplerShiftInHz);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        objArr2[HAS_ELEVATION] = "DopplerShiftUncertaintyInHz";
        objArr2[3] = hasDopplerShiftUncertaintyInHz() ? Double.valueOf(this.mDopplerShiftUncertaintyInHz) : null;
        builder.append(String.format(str, objArr2));
        objArr = new Object[HAS_ELEVATION];
        objArr[HAS_NO_FLAGS] = "MultipathIndicator";
        objArr[HAS_SNR] = getMultipathIndicatorString();
        builder.append(String.format("   %-29s = %s\n", objArr));
        str = "   %-29s = %s\n";
        objArr2 = new Object[HAS_ELEVATION];
        objArr2[HAS_NO_FLAGS] = "SnrInDb";
        if (hasSnrInDb()) {
            valueOf = Double.valueOf(this.mSnrInDb);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %-25s   %-40s = %s\n";
        objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "ElevationInDeg";
        if (hasElevationInDeg()) {
            valueOf = Double.valueOf(this.mElevationInDeg);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        objArr2[HAS_ELEVATION] = "ElevationUncertaintyInDeg";
        objArr2[3] = hasElevationUncertaintyInDeg() ? Double.valueOf(this.mElevationUncertaintyInDeg) : null;
        builder.append(String.format(str, objArr2));
        str = "   %-29s = %-25s   %-40s = %s\n";
        objArr2 = new Object[HAS_ELEVATION_UNCERTAINTY];
        objArr2[HAS_NO_FLAGS] = "AzimuthInDeg";
        if (hasAzimuthInDeg()) {
            valueOf = Double.valueOf(this.mAzimuthInDeg);
        } else {
            valueOf = null;
        }
        objArr2[HAS_SNR] = valueOf;
        objArr2[HAS_ELEVATION] = "AzimuthUncertaintyInDeg";
        if (hasAzimuthUncertaintyInDeg()) {
            d = Double.valueOf(this.mAzimuthUncertaintyInDeg);
        }
        objArr2[3] = d;
        builder.append(String.format(str, objArr2));
        Object[] objArr3 = new Object[HAS_ELEVATION];
        objArr3[HAS_NO_FLAGS] = "UsedInFix";
        objArr3[HAS_SNR] = Boolean.valueOf(this.mUsedInFix);
        builder.append(String.format("   %-29s = %s\n", objArr3));
        return builder.toString();
    }

    private void initialize() {
        this.mFlags = HAS_NO_FLAGS;
        setPrn(BluetoothHidDevice.SUBCLASS1_MOUSE);
        setTimeOffsetInNs(-9.223372036854776E18d);
        setState(STATE_UNKNOWN);
        setReceivedGpsTowInNs(Long.MIN_VALUE);
        setReceivedGpsTowUncertaintyInNs(LinkQualityInfo.UNKNOWN_LONG);
        setCn0InDbHz(Double.MIN_VALUE);
        setPseudorangeRateInMetersPerSec(Double.MIN_VALUE);
        setPseudorangeRateUncertaintyInMetersPerSec(Double.MIN_VALUE);
        setAccumulatedDeltaRangeState(STATE_UNKNOWN);
        setAccumulatedDeltaRangeInMeters(Double.MIN_VALUE);
        setAccumulatedDeltaRangeUncertaintyInMeters(Double.MIN_VALUE);
        resetPseudorangeInMeters();
        resetPseudorangeUncertaintyInMeters();
        resetCodePhaseInChips();
        resetCodePhaseUncertaintyInChips();
        resetCarrierFrequencyInHz();
        resetCarrierCycles();
        resetCarrierPhase();
        resetCarrierPhaseUncertainty();
        setLossOfLock(MULTIPATH_INDICATOR_UNKNOWN);
        resetBitNumber();
        resetTimeFromLastBitInMs();
        resetDopplerShiftInHz();
        resetDopplerShiftUncertaintyInHz();
        setMultipathIndicator(MULTIPATH_INDICATOR_UNKNOWN);
        resetSnrInDb();
        resetElevationInDeg();
        resetElevationUncertaintyInDeg();
        resetAzimuthInDeg();
        resetAzimuthUncertaintyInDeg();
        setUsedInFix(false);
    }

    private void setFlag(int flag) {
        this.mFlags |= flag;
    }

    private void resetFlag(int flag) {
        this.mFlags &= flag ^ -1;
    }

    private boolean isFlagSet(int flag) {
        return (this.mFlags & flag) == flag;
    }
}
