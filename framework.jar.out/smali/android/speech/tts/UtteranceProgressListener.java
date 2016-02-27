package android.speech.tts;

import android.speech.tts.TextToSpeech.OnUtteranceCompletedListener;

public abstract class UtteranceProgressListener {

    /* renamed from: android.speech.tts.UtteranceProgressListener.1 */
    static class C07241 extends UtteranceProgressListener {
        final /* synthetic */ OnUtteranceCompletedListener val$listener;

        C07241(OnUtteranceCompletedListener onUtteranceCompletedListener) {
            this.val$listener = onUtteranceCompletedListener;
        }

        public synchronized void onDone(String utteranceId) {
            this.val$listener.onUtteranceCompleted(utteranceId);
        }

        public void onError(String utteranceId) {
            this.val$listener.onUtteranceCompleted(utteranceId);
        }

        public void onStart(String utteranceId) {
        }
    }

    public abstract void onDone(String str);

    @Deprecated
    public abstract void onError(String str);

    public abstract void onStart(String str);

    public void onError(String utteranceId, int errorCode) {
        onError(utteranceId);
    }

    static UtteranceProgressListener from(OnUtteranceCompletedListener listener) {
        return new C07241(listener);
    }
}
