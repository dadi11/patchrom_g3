package android.telecom;

import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public class VideoProfile implements Parcelable {
    public static final Creator<VideoProfile> CREATOR;
    public static final int QUALITY_DEFAULT = 4;
    public static final int QUALITY_HIGH = 1;
    public static final int QUALITY_LOW = 3;
    public static final int QUALITY_MEDIUM = 2;
    private final int mQuality;
    private final int mVideoState;

    /* renamed from: android.telecom.VideoProfile.1 */
    static class C07631 implements Creator<VideoProfile> {
        C07631() {
        }

        public VideoProfile createFromParcel(Parcel source) {
            int state = source.readInt();
            int quality = source.readInt();
            ClassLoader classLoader = VideoProfile.class.getClassLoader();
            return new VideoProfile(state, quality);
        }

        public VideoProfile[] newArray(int size) {
            return new VideoProfile[size];
        }
    }

    public static class VideoState {
        public static final int AUDIO_ONLY = 0;
        public static final int BIDIRECTIONAL = 3;
        public static final int PAUSED = 4;
        public static final int RX_ENABLED = 2;
        public static final int TX_ENABLED = 1;

        public static boolean isAudioOnly(int videoState) {
            return (hasState(videoState, TX_ENABLED) || hasState(videoState, RX_ENABLED)) ? false : true;
        }

        public static boolean isTransmissionEnabled(int videoState) {
            return hasState(videoState, TX_ENABLED);
        }

        public static boolean isReceptionEnabled(int videoState) {
            return hasState(videoState, RX_ENABLED);
        }

        public static boolean isBidirectional(int videoState) {
            return hasState(videoState, BIDIRECTIONAL);
        }

        public static boolean isPaused(int videoState) {
            return hasState(videoState, PAUSED);
        }

        private static boolean hasState(int videoState, int state) {
            return (videoState & state) == state;
        }
    }

    public VideoProfile(int videoState) {
        this(videoState, QUALITY_DEFAULT);
    }

    public VideoProfile(int videoState, int quality) {
        this.mVideoState = videoState;
        this.mQuality = quality;
    }

    public int getVideoState() {
        return this.mVideoState;
    }

    public int getQuality() {
        return this.mQuality;
    }

    static {
        CREATOR = new C07631();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mVideoState);
        dest.writeInt(this.mQuality);
    }
}
