package android.media.tv;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;

public final class TvTrackInfo implements Parcelable {
    public static final Creator<TvTrackInfo> CREATOR;
    public static final int TYPE_AUDIO = 0;
    public static final int TYPE_SUBTITLE = 2;
    public static final int TYPE_VIDEO = 1;
    private final int mAudioChannelCount;
    private final int mAudioSampleRate;
    private final Bundle mExtra;
    private final String mId;
    private final String mLanguage;
    private final int mType;
    private final float mVideoFrameRate;
    private final int mVideoHeight;
    private final int mVideoWidth;

    /* renamed from: android.media.tv.TvTrackInfo.1 */
    static class C04671 implements Creator<TvTrackInfo> {
        C04671() {
        }

        public TvTrackInfo createFromParcel(Parcel in) {
            return new TvTrackInfo(null);
        }

        public TvTrackInfo[] newArray(int size) {
            return new TvTrackInfo[size];
        }
    }

    public static final class Builder {
        private int mAudioChannelCount;
        private int mAudioSampleRate;
        private Bundle mExtra;
        private final String mId;
        private String mLanguage;
        private final int mType;
        private float mVideoFrameRate;
        private int mVideoHeight;
        private int mVideoWidth;

        public Builder(int type, String id) {
            if (type != 0 && type != TvTrackInfo.TYPE_VIDEO && type != TvTrackInfo.TYPE_SUBTITLE) {
                throw new IllegalArgumentException("Unknown type: " + type);
            } else if (id == null) {
                throw new IllegalArgumentException("id cannot be null");
            } else {
                this.mType = type;
                this.mId = id;
            }
        }

        public final Builder setLanguage(String language) {
            this.mLanguage = language;
            return this;
        }

        public final Builder setAudioChannelCount(int audioChannelCount) {
            if (this.mType != 0) {
                throw new IllegalStateException("Not an audio track");
            }
            this.mAudioChannelCount = audioChannelCount;
            return this;
        }

        public final Builder setAudioSampleRate(int audioSampleRate) {
            if (this.mType != 0) {
                throw new IllegalStateException("Not an audio track");
            }
            this.mAudioSampleRate = audioSampleRate;
            return this;
        }

        public final Builder setVideoWidth(int videoWidth) {
            if (this.mType != TvTrackInfo.TYPE_VIDEO) {
                throw new IllegalStateException("Not a video track");
            }
            this.mVideoWidth = videoWidth;
            return this;
        }

        public final Builder setVideoHeight(int videoHeight) {
            if (this.mType != TvTrackInfo.TYPE_VIDEO) {
                throw new IllegalStateException("Not a video track");
            }
            this.mVideoHeight = videoHeight;
            return this;
        }

        public final Builder setVideoFrameRate(float videoFrameRate) {
            if (this.mType != TvTrackInfo.TYPE_VIDEO) {
                throw new IllegalStateException("Not a video track");
            }
            this.mVideoFrameRate = videoFrameRate;
            return this;
        }

        public final Builder setExtra(Bundle extra) {
            this.mExtra = new Bundle(extra);
            return this;
        }

        public TvTrackInfo build() {
            return new TvTrackInfo(this.mId, this.mLanguage, this.mAudioChannelCount, this.mAudioSampleRate, this.mVideoWidth, this.mVideoHeight, this.mVideoFrameRate, this.mExtra, null);
        }
    }

    private TvTrackInfo(int type, String id, String language, int audioChannelCount, int audioSampleRate, int videoWidth, int videoHeight, float videoFrameRate, Bundle extra) {
        this.mType = type;
        this.mId = id;
        this.mLanguage = language;
        this.mAudioChannelCount = audioChannelCount;
        this.mAudioSampleRate = audioSampleRate;
        this.mVideoWidth = videoWidth;
        this.mVideoHeight = videoHeight;
        this.mVideoFrameRate = videoFrameRate;
        this.mExtra = extra;
    }

    private TvTrackInfo(Parcel in) {
        this.mType = in.readInt();
        this.mId = in.readString();
        this.mLanguage = in.readString();
        this.mAudioChannelCount = in.readInt();
        this.mAudioSampleRate = in.readInt();
        this.mVideoWidth = in.readInt();
        this.mVideoHeight = in.readInt();
        this.mVideoFrameRate = in.readFloat();
        this.mExtra = in.readBundle();
    }

    public final int getType() {
        return this.mType;
    }

    public final String getId() {
        return this.mId;
    }

    public final String getLanguage() {
        return this.mLanguage;
    }

    public final int getAudioChannelCount() {
        if (this.mType == 0) {
            return this.mAudioChannelCount;
        }
        throw new IllegalStateException("Not an audio track");
    }

    public final int getAudioSampleRate() {
        if (this.mType == 0) {
            return this.mAudioSampleRate;
        }
        throw new IllegalStateException("Not an audio track");
    }

    public final int getVideoWidth() {
        if (this.mType == TYPE_VIDEO) {
            return this.mVideoWidth;
        }
        throw new IllegalStateException("Not a video track");
    }

    public final int getVideoHeight() {
        if (this.mType == TYPE_VIDEO) {
            return this.mVideoHeight;
        }
        throw new IllegalStateException("Not a video track");
    }

    public final float getVideoFrameRate() {
        if (this.mType == TYPE_VIDEO) {
            return this.mVideoFrameRate;
        }
        throw new IllegalStateException("Not a video track");
    }

    public final Bundle getExtra() {
        return this.mExtra;
    }

    public int describeContents() {
        return TYPE_AUDIO;
    }

    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.mType);
        dest.writeString(this.mId);
        dest.writeString(this.mLanguage);
        dest.writeInt(this.mAudioChannelCount);
        dest.writeInt(this.mAudioSampleRate);
        dest.writeInt(this.mVideoWidth);
        dest.writeInt(this.mVideoHeight);
        dest.writeFloat(this.mVideoFrameRate);
        dest.writeBundle(this.mExtra);
    }

    static {
        CREATOR = new C04671();
    }
}
