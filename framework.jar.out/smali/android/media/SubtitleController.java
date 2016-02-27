package android.media;

import android.content.Context;
import android.media.SubtitleTrack.RenderingWidget;
import android.net.ProxyInfo;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.Looper;
import android.os.Message;
import android.speech.tts.TextToSpeech.Engine;
import android.view.accessibility.CaptioningManager;
import android.view.accessibility.CaptioningManager.CaptioningChangeListener;
import java.util.Iterator;
import java.util.Locale;
import java.util.Vector;

public class SubtitleController {
    static final /* synthetic */ boolean $assertionsDisabled;
    private static final int WHAT_HIDE = 2;
    private static final int WHAT_SELECT_DEFAULT_TRACK = 4;
    private static final int WHAT_SELECT_TRACK = 3;
    private static final int WHAT_SHOW = 1;
    private Anchor mAnchor;
    private final Callback mCallback;
    private CaptioningChangeListener mCaptioningChangeListener;
    private CaptioningManager mCaptioningManager;
    private Handler mHandler;
    private Listener mListener;
    private Vector<Renderer> mRenderers;
    private SubtitleTrack mSelectedTrack;
    private boolean mShowing;
    private MediaTimeProvider mTimeProvider;
    private boolean mTrackIsExplicit;
    private Vector<SubtitleTrack> mTracks;
    private boolean mVisibilityIsExplicit;

    public static abstract class Renderer {
        public abstract SubtitleTrack createTrack(MediaFormat mediaFormat);

        public abstract boolean supports(MediaFormat mediaFormat);
    }

    public interface Anchor {
        Looper getSubtitleLooper();

        void setSubtitleWidget(RenderingWidget renderingWidget);
    }

    public interface Listener {
        void onSubtitleTrackSelected(SubtitleTrack subtitleTrack);
    }

    /* renamed from: android.media.SubtitleController.1 */
    class C03981 implements Callback {
        C03981() {
        }

        public boolean handleMessage(Message msg) {
            switch (msg.what) {
                case SubtitleController.WHAT_SHOW /*1*/:
                    SubtitleController.this.doShow();
                    return true;
                case SubtitleController.WHAT_HIDE /*2*/:
                    SubtitleController.this.doHide();
                    return true;
                case SubtitleController.WHAT_SELECT_TRACK /*3*/:
                    SubtitleController.this.doSelectTrack((SubtitleTrack) msg.obj);
                    return true;
                case SubtitleController.WHAT_SELECT_DEFAULT_TRACK /*4*/:
                    SubtitleController.this.doSelectDefaultTrack();
                    return true;
                default:
                    return SubtitleController.$assertionsDisabled;
            }
        }
    }

    /* renamed from: android.media.SubtitleController.2 */
    class C03992 extends CaptioningChangeListener {
        C03992() {
        }

        public void onEnabledChanged(boolean enabled) {
            SubtitleController.this.selectDefaultTrack();
        }

        public void onLocaleChanged(Locale locale) {
            SubtitleController.this.selectDefaultTrack();
        }
    }

    static {
        $assertionsDisabled = !SubtitleController.class.desiredAssertionStatus() ? true : $assertionsDisabled;
    }

    public SubtitleController(Context context, MediaTimeProvider timeProvider, Listener listener) {
        this.mCallback = new C03981();
        this.mCaptioningChangeListener = new C03992();
        this.mTrackIsExplicit = $assertionsDisabled;
        this.mVisibilityIsExplicit = $assertionsDisabled;
        this.mTimeProvider = timeProvider;
        this.mListener = listener;
        this.mRenderers = new Vector();
        this.mShowing = $assertionsDisabled;
        this.mTracks = new Vector();
        this.mCaptioningManager = (CaptioningManager) context.getSystemService(Context.CAPTIONING_SERVICE);
    }

    protected void finalize() throws Throwable {
        this.mCaptioningManager.removeCaptioningChangeListener(this.mCaptioningChangeListener);
        super.finalize();
    }

    public SubtitleTrack[] getTracks() {
        SubtitleTrack[] tracks;
        synchronized (this.mTracks) {
            tracks = new SubtitleTrack[this.mTracks.size()];
            this.mTracks.toArray(tracks);
        }
        return tracks;
    }

    public SubtitleTrack getSelectedTrack() {
        return this.mSelectedTrack;
    }

    private RenderingWidget getRenderingWidget() {
        if (this.mSelectedTrack == null) {
            return null;
        }
        return this.mSelectedTrack.getRenderingWidget();
    }

    public boolean selectTrack(SubtitleTrack track) {
        if (track != null && !this.mTracks.contains(track)) {
            return $assertionsDisabled;
        }
        processOnAnchor(this.mHandler.obtainMessage(WHAT_SELECT_TRACK, track));
        return true;
    }

    private void doSelectTrack(SubtitleTrack track) {
        this.mTrackIsExplicit = true;
        if (this.mSelectedTrack != track) {
            if (this.mSelectedTrack != null) {
                this.mSelectedTrack.hide();
                this.mSelectedTrack.setTimeProvider(null);
            }
            this.mSelectedTrack = track;
            if (this.mAnchor != null) {
                this.mAnchor.setSubtitleWidget(getRenderingWidget());
            }
            if (this.mSelectedTrack != null) {
                this.mSelectedTrack.setTimeProvider(this.mTimeProvider);
                this.mSelectedTrack.show();
            }
            if (this.mListener != null) {
                this.mListener.onSubtitleTrackSelected(track);
            }
        }
    }

    public SubtitleTrack getDefaultTrack() {
        SubtitleTrack bestTrack = null;
        int bestScore = -1;
        Locale selectedLocale = this.mCaptioningManager.getLocale();
        Locale locale = selectedLocale;
        if (locale == null) {
            locale = Locale.getDefault();
        }
        boolean selectForced = !this.mCaptioningManager.isEnabled() ? true : $assertionsDisabled;
        synchronized (this.mTracks) {
            Iterator i$ = this.mTracks.iterator();
            while (i$.hasNext()) {
                int i;
                int i2;
                SubtitleTrack track = (SubtitleTrack) i$.next();
                MediaFormat format = track.getFormat();
                String language = format.getString(Engine.KEY_PARAM_LANGUAGE);
                boolean forced = format.getInteger(MediaFormat.KEY_IS_FORCED_SUBTITLE, 0) != 0 ? true : $assertionsDisabled;
                boolean autoselect = format.getInteger(MediaFormat.KEY_IS_AUTOSELECT, WHAT_SHOW) != 0 ? true : $assertionsDisabled;
                boolean is_default = format.getInteger(MediaFormat.KEY_IS_DEFAULT, 0) != 0 ? true : $assertionsDisabled;
                boolean languageMatches = (locale == null || locale.getLanguage().equals(ProxyInfo.LOCAL_EXCL_LIST) || locale.getISO3Language().equals(language) || locale.getLanguage().equals(language)) ? true : $assertionsDisabled;
                if (forced) {
                    i = 0;
                } else {
                    i = 8;
                }
                if (selectedLocale == null && is_default) {
                    i2 = WHAT_SELECT_DEFAULT_TRACK;
                } else {
                    i2 = 0;
                }
                i += i2;
                if (autoselect) {
                    i2 = 0;
                } else {
                    i2 = WHAT_HIDE;
                }
                i += i2;
                if (languageMatches) {
                    i2 = WHAT_SHOW;
                } else {
                    i2 = 0;
                }
                int score = i + i2;
                if ((!selectForced || forced) && (((selectedLocale == null && is_default) || (languageMatches && (autoselect || forced || selectedLocale != null))) && score > bestScore)) {
                    bestScore = score;
                    bestTrack = track;
                }
            }
        }
        return bestTrack;
    }

    public void selectDefaultTrack() {
        processOnAnchor(this.mHandler.obtainMessage(WHAT_SELECT_DEFAULT_TRACK));
    }

    private void doSelectDefaultTrack() {
        if (!this.mTrackIsExplicit) {
            SubtitleTrack track = getDefaultTrack();
            if (track != null) {
                selectTrack(track);
                this.mTrackIsExplicit = $assertionsDisabled;
                if (!this.mVisibilityIsExplicit) {
                    show();
                    this.mVisibilityIsExplicit = $assertionsDisabled;
                }
            }
        } else if (!this.mVisibilityIsExplicit) {
            if (this.mCaptioningManager.isEnabled() || !(this.mSelectedTrack == null || this.mSelectedTrack.getFormat().getInteger(MediaFormat.KEY_IS_FORCED_SUBTITLE, 0) == 0)) {
                show();
            } else if (!(this.mSelectedTrack == null || this.mSelectedTrack.isTimedText())) {
                hide();
            }
            this.mVisibilityIsExplicit = $assertionsDisabled;
        }
    }

    public void reset() {
        checkAnchorLooper();
        hide();
        selectTrack(null);
        this.mTracks.clear();
        this.mTrackIsExplicit = $assertionsDisabled;
        this.mVisibilityIsExplicit = $assertionsDisabled;
        this.mCaptioningManager.removeCaptioningChangeListener(this.mCaptioningChangeListener);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.media.SubtitleTrack addTrack(android.media.MediaFormat r8) {
        /*
        r7 = this;
        r4 = r7.mRenderers;
        monitor-enter(r4);
        r3 = r7.mRenderers;	 Catch:{ all -> 0x003e }
        r0 = r3.iterator();	 Catch:{ all -> 0x003e }
    L_0x0009:
        r3 = r0.hasNext();	 Catch:{ all -> 0x003e }
        if (r3 == 0) goto L_0x0041;
    L_0x000f:
        r1 = r0.next();	 Catch:{ all -> 0x003e }
        r1 = (android.media.SubtitleController.Renderer) r1;	 Catch:{ all -> 0x003e }
        r3 = r1.supports(r8);	 Catch:{ all -> 0x003e }
        if (r3 == 0) goto L_0x0009;
    L_0x001b:
        r2 = r1.createTrack(r8);	 Catch:{ all -> 0x003e }
        if (r2 == 0) goto L_0x0009;
    L_0x0021:
        r5 = r7.mTracks;	 Catch:{ all -> 0x003e }
        monitor-enter(r5);	 Catch:{ all -> 0x003e }
        r3 = r7.mTracks;	 Catch:{ all -> 0x003b }
        r3 = r3.size();	 Catch:{ all -> 0x003b }
        if (r3 != 0) goto L_0x0033;
    L_0x002c:
        r3 = r7.mCaptioningManager;	 Catch:{ all -> 0x003b }
        r6 = r7.mCaptioningChangeListener;	 Catch:{ all -> 0x003b }
        r3.addCaptioningChangeListener(r6);	 Catch:{ all -> 0x003b }
    L_0x0033:
        r3 = r7.mTracks;	 Catch:{ all -> 0x003b }
        r3.add(r2);	 Catch:{ all -> 0x003b }
        monitor-exit(r5);	 Catch:{ all -> 0x003b }
        monitor-exit(r4);	 Catch:{ all -> 0x003e }
    L_0x003a:
        return r2;
    L_0x003b:
        r3 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x003b }
        throw r3;	 Catch:{ all -> 0x003e }
    L_0x003e:
        r3 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x003e }
        throw r3;
    L_0x0041:
        monitor-exit(r4);	 Catch:{ all -> 0x003e }
        r2 = 0;
        goto L_0x003a;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.media.SubtitleController.addTrack(android.media.MediaFormat):android.media.SubtitleTrack");
    }

    public void show() {
        processOnAnchor(this.mHandler.obtainMessage(WHAT_SHOW));
    }

    private void doShow() {
        this.mShowing = true;
        this.mVisibilityIsExplicit = true;
        if (this.mSelectedTrack != null) {
            this.mSelectedTrack.show();
        }
    }

    public void hide() {
        processOnAnchor(this.mHandler.obtainMessage(WHAT_HIDE));
    }

    private void doHide() {
        this.mVisibilityIsExplicit = true;
        if (this.mSelectedTrack != null) {
            this.mSelectedTrack.hide();
        }
        this.mShowing = $assertionsDisabled;
    }

    public void registerRenderer(Renderer renderer) {
        synchronized (this.mRenderers) {
            if (!this.mRenderers.contains(renderer)) {
                this.mRenderers.add(renderer);
            }
        }
    }

    public boolean hasRendererFor(MediaFormat format) {
        boolean z;
        synchronized (this.mRenderers) {
            Iterator i$ = this.mRenderers.iterator();
            while (i$.hasNext()) {
                if (((Renderer) i$.next()).supports(format)) {
                    z = true;
                    break;
                }
            }
            z = $assertionsDisabled;
        }
        return z;
    }

    public void setAnchor(Anchor anchor) {
        if (this.mAnchor != anchor) {
            if (this.mAnchor != null) {
                checkAnchorLooper();
                this.mAnchor.setSubtitleWidget(null);
            }
            this.mAnchor = anchor;
            this.mHandler = null;
            if (this.mAnchor != null) {
                this.mHandler = new Handler(this.mAnchor.getSubtitleLooper(), this.mCallback);
                checkAnchorLooper();
                this.mAnchor.setSubtitleWidget(getRenderingWidget());
            }
        }
    }

    private void checkAnchorLooper() {
        if (!$assertionsDisabled && this.mHandler == null) {
            throw new AssertionError("Should have a looper already");
        } else if (!$assertionsDisabled && Looper.myLooper() != this.mHandler.getLooper()) {
            throw new AssertionError("Must be called from the anchor's looper");
        }
    }

    private void processOnAnchor(Message m) {
        if (!$assertionsDisabled && this.mHandler == null) {
            throw new AssertionError("Should have a looper already");
        } else if (Looper.myLooper() == this.mHandler.getLooper()) {
            this.mHandler.dispatchMessage(m);
        } else {
            this.mHandler.sendMessage(m);
        }
    }
}
