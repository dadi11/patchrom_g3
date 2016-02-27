package android.media;

import android.media.SoundPool.OnLoadCompleteListener;
import android.util.Log;
import android.view.WindowManager.LayoutParams;

public class MediaActionSound {
    public static final int FOCUS_COMPLETE = 1;
    private static final int NUM_MEDIA_SOUND_STREAMS = 1;
    public static final int SHUTTER_CLICK = 0;
    private static final String[] SOUND_FILES;
    private static final int SOUND_NOT_LOADED = -1;
    public static final int START_VIDEO_RECORDING = 2;
    public static final int STOP_VIDEO_RECORDING = 3;
    private static final String TAG = "MediaActionSound";
    private OnLoadCompleteListener mLoadCompleteListener;
    private int mSoundIdToPlay;
    private int[] mSoundIds;
    private SoundPool mSoundPool;

    /* renamed from: android.media.MediaActionSound.1 */
    class C03671 implements OnLoadCompleteListener {
        C03671() {
        }

        public void onLoadComplete(SoundPool soundPool, int sampleId, int status) {
            if (status != 0) {
                Log.e(MediaActionSound.TAG, "Unable to load sound for playback (status: " + status + ")");
            } else if (MediaActionSound.this.mSoundIdToPlay == sampleId) {
                soundPool.play(sampleId, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, MediaActionSound.SHUTTER_CLICK, MediaActionSound.SHUTTER_CLICK, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
                MediaActionSound.this.mSoundIdToPlay = MediaActionSound.SOUND_NOT_LOADED;
            }
        }
    }

    static {
        SOUND_FILES = new String[]{"/system/media/audio/ui/camera_click.ogg", "/system/media/audio/ui/camera_focus.ogg", "/system/media/audio/ui/VideoRecord.ogg", "/system/media/audio/ui/VideoRecord.ogg"};
    }

    public MediaActionSound() {
        this.mLoadCompleteListener = new C03671();
        this.mSoundPool = new SoundPool((int) NUM_MEDIA_SOUND_STREAMS, 7, (int) SHUTTER_CLICK);
        this.mSoundPool.setOnLoadCompleteListener(this.mLoadCompleteListener);
        this.mSoundIds = new int[SOUND_FILES.length];
        for (int i = SHUTTER_CLICK; i < this.mSoundIds.length; i += NUM_MEDIA_SOUND_STREAMS) {
            this.mSoundIds[i] = SOUND_NOT_LOADED;
        }
        this.mSoundIdToPlay = SOUND_NOT_LOADED;
    }

    public synchronized void load(int soundName) {
        if (soundName >= 0) {
            if (soundName < SOUND_FILES.length) {
                if (this.mSoundIds[soundName] == SOUND_NOT_LOADED) {
                    this.mSoundIds[soundName] = this.mSoundPool.load(SOUND_FILES[soundName], (int) NUM_MEDIA_SOUND_STREAMS);
                }
            }
        }
        throw new RuntimeException("Unknown sound requested: " + soundName);
    }

    public synchronized void play(int soundName) {
        if (soundName >= 0) {
            if (soundName < SOUND_FILES.length) {
                if (this.mSoundIds[soundName] == SOUND_NOT_LOADED) {
                    this.mSoundIdToPlay = this.mSoundPool.load(SOUND_FILES[soundName], (int) NUM_MEDIA_SOUND_STREAMS);
                    this.mSoundIds[soundName] = this.mSoundIdToPlay;
                } else {
                    this.mSoundPool.play(this.mSoundIds[soundName], LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, SHUTTER_CLICK, SHUTTER_CLICK, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
                }
            }
        }
        throw new RuntimeException("Unknown sound requested: " + soundName);
    }

    public void release() {
        if (this.mSoundPool != null) {
            this.mSoundPool.release();
            this.mSoundPool = null;
        }
    }
}
