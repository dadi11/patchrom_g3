package android.view.textservice;

import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import com.android.internal.textservice.ISpellCheckerSession;
import com.android.internal.textservice.ISpellCheckerSessionListener;
import com.android.internal.textservice.ITextServicesManager;
import com.android.internal.textservice.ITextServicesSessionListener;
import com.android.internal.textservice.ITextServicesSessionListener.Stub;
import java.util.LinkedList;
import java.util.Queue;

public class SpellCheckerSession {
    private static final boolean DBG = false;
    private static final int MSG_ON_GET_SUGGESTION_MULTIPLE = 1;
    private static final int MSG_ON_GET_SUGGESTION_MULTIPLE_FOR_SENTENCE = 2;
    public static final String SERVICE_META_DATA = "android.view.textservice.scs";
    private static final String TAG;
    private final Handler mHandler;
    private final InternalListener mInternalListener;
    private boolean mIsUsed;
    private final SpellCheckerInfo mSpellCheckerInfo;
    private SpellCheckerSessionListener mSpellCheckerSessionListener;
    private final SpellCheckerSessionListenerImpl mSpellCheckerSessionListenerImpl;
    private final SpellCheckerSubtype mSubtype;
    private final ITextServicesManager mTextServicesManager;

    /* renamed from: android.view.textservice.SpellCheckerSession.1 */
    class C09041 extends Handler {
        C09041() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case SpellCheckerSession.MSG_ON_GET_SUGGESTION_MULTIPLE /*1*/:
                    SpellCheckerSession.this.handleOnGetSuggestionsMultiple((SuggestionsInfo[]) msg.obj);
                case SpellCheckerSession.MSG_ON_GET_SUGGESTION_MULTIPLE_FOR_SENTENCE /*2*/:
                    SpellCheckerSession.this.handleOnGetSentenceSuggestionsMultiple((SentenceSuggestionsInfo[]) msg.obj);
                default:
            }
        }
    }

    private static class InternalListener extends Stub {
        private final SpellCheckerSessionListenerImpl mParentSpellCheckerSessionListenerImpl;

        public InternalListener(SpellCheckerSessionListenerImpl spellCheckerSessionListenerImpl) {
            this.mParentSpellCheckerSessionListenerImpl = spellCheckerSessionListenerImpl;
        }

        public void onServiceConnected(ISpellCheckerSession session) {
            this.mParentSpellCheckerSessionListenerImpl.onServiceConnected(session);
        }
    }

    public interface SpellCheckerSessionListener {
        void onGetSentenceSuggestions(SentenceSuggestionsInfo[] sentenceSuggestionsInfoArr);

        void onGetSuggestions(SuggestionsInfo[] suggestionsInfoArr);
    }

    private static class SpellCheckerSessionListenerImpl extends ISpellCheckerSessionListener.Stub {
        private static final int TASK_CANCEL = 1;
        private static final int TASK_CLOSE = 3;
        private static final int TASK_GET_SUGGESTIONS_MULTIPLE = 2;
        private static final int TASK_GET_SUGGESTIONS_MULTIPLE_FOR_SENTENCE = 4;
        private Handler mAsyncHandler;
        private Handler mHandler;
        private ISpellCheckerSession mISpellCheckerSession;
        private boolean mOpened;
        private final Queue<SpellCheckerParams> mPendingTasks;
        private HandlerThread mThread;

        /* renamed from: android.view.textservice.SpellCheckerSession.SpellCheckerSessionListenerImpl.1 */
        class C09051 extends Handler {
            C09051(Looper x0) {
                super(x0);
            }

            public void handleMessage(Message msg) {
                SpellCheckerParams scp = msg.obj;
                SpellCheckerSessionListenerImpl.this.processTask(scp.mSession, scp, true);
            }
        }

        private static class SpellCheckerParams {
            public final boolean mSequentialWords;
            public ISpellCheckerSession mSession;
            public final int mSuggestionsLimit;
            public final TextInfo[] mTextInfos;
            public final int mWhat;

            public SpellCheckerParams(int what, TextInfo[] textInfos, int suggestionsLimit, boolean sequentialWords) {
                this.mWhat = what;
                this.mTextInfos = textInfos;
                this.mSuggestionsLimit = suggestionsLimit;
                this.mSequentialWords = sequentialWords;
            }
        }

        public SpellCheckerSessionListenerImpl(Handler handler) {
            this.mPendingTasks = new LinkedList();
            this.mOpened = SpellCheckerSession.DBG;
            this.mHandler = handler;
        }

        private void processTask(ISpellCheckerSession session, SpellCheckerParams scp, boolean async) {
            if (async || this.mAsyncHandler == null) {
                switch (scp.mWhat) {
                    case TASK_CANCEL /*1*/:
                        try {
                            session.onCancel();
                            break;
                        } catch (RemoteException e) {
                            Log.e(SpellCheckerSession.TAG, "Failed to cancel " + e);
                            break;
                        }
                    case TASK_GET_SUGGESTIONS_MULTIPLE /*2*/:
                        try {
                            session.onGetSuggestionsMultiple(scp.mTextInfos, scp.mSuggestionsLimit, scp.mSequentialWords);
                            break;
                        } catch (RemoteException e2) {
                            Log.e(SpellCheckerSession.TAG, "Failed to get suggestions " + e2);
                            break;
                        }
                    case TASK_CLOSE /*3*/:
                        try {
                            session.onClose();
                            break;
                        } catch (RemoteException e22) {
                            Log.e(SpellCheckerSession.TAG, "Failed to close " + e22);
                            break;
                        }
                    case TASK_GET_SUGGESTIONS_MULTIPLE_FOR_SENTENCE /*4*/:
                        try {
                            session.onGetSentenceSuggestionsMultiple(scp.mTextInfos, scp.mSuggestionsLimit);
                            break;
                        } catch (RemoteException e222) {
                            Log.e(SpellCheckerSession.TAG, "Failed to get suggestions " + e222);
                            break;
                        }
                }
            }
            scp.mSession = session;
            this.mAsyncHandler.sendMessage(Message.obtain(this.mAsyncHandler, TASK_CANCEL, scp));
            if (scp.mWhat == TASK_CLOSE) {
                synchronized (this) {
                    this.mISpellCheckerSession = null;
                    this.mHandler = null;
                    if (this.mThread != null) {
                        this.mThread.quit();
                    }
                    this.mThread = null;
                    this.mAsyncHandler = null;
                }
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public synchronized void onServiceConnected(com.android.internal.textservice.ISpellCheckerSession r4) {
            /*
            r3 = this;
            monitor-enter(r3);
            monitor-enter(r3);	 Catch:{ all -> 0x0046 }
            r3.mISpellCheckerSession = r4;	 Catch:{ all -> 0x0049 }
            r0 = r4.asBinder();	 Catch:{ all -> 0x0049 }
            r0 = r0 instanceof android.os.Binder;	 Catch:{ all -> 0x0049 }
            if (r0 == 0) goto L_0x002d;
        L_0x000c:
            r0 = r3.mThread;	 Catch:{ all -> 0x0049 }
            if (r0 != 0) goto L_0x002d;
        L_0x0010:
            r0 = new android.os.HandlerThread;	 Catch:{ all -> 0x0049 }
            r1 = "SpellCheckerSession";
            r2 = 10;
            r0.<init>(r1, r2);	 Catch:{ all -> 0x0049 }
            r3.mThread = r0;	 Catch:{ all -> 0x0049 }
            r0 = r3.mThread;	 Catch:{ all -> 0x0049 }
            r0.start();	 Catch:{ all -> 0x0049 }
            r0 = new android.view.textservice.SpellCheckerSession$SpellCheckerSessionListenerImpl$1;	 Catch:{ all -> 0x0049 }
            r1 = r3.mThread;	 Catch:{ all -> 0x0049 }
            r1 = r1.getLooper();	 Catch:{ all -> 0x0049 }
            r0.<init>(r1);	 Catch:{ all -> 0x0049 }
            r3.mAsyncHandler = r0;	 Catch:{ all -> 0x0049 }
        L_0x002d:
            r0 = 1;
            r3.mOpened = r0;	 Catch:{ all -> 0x0049 }
            monitor-exit(r3);	 Catch:{ all -> 0x0049 }
        L_0x0031:
            r0 = r3.mPendingTasks;	 Catch:{ all -> 0x0046 }
            r0 = r0.isEmpty();	 Catch:{ all -> 0x0046 }
            if (r0 != 0) goto L_0x004c;
        L_0x0039:
            r0 = r3.mPendingTasks;	 Catch:{ all -> 0x0046 }
            r0 = r0.poll();	 Catch:{ all -> 0x0046 }
            r0 = (android.view.textservice.SpellCheckerSession.SpellCheckerSessionListenerImpl.SpellCheckerParams) r0;	 Catch:{ all -> 0x0046 }
            r1 = 0;
            r3.processTask(r4, r0, r1);	 Catch:{ all -> 0x0046 }
            goto L_0x0031;
        L_0x0046:
            r0 = move-exception;
            monitor-exit(r3);
            throw r0;
        L_0x0049:
            r0 = move-exception;
            monitor-exit(r3);	 Catch:{ all -> 0x0049 }
            throw r0;	 Catch:{ all -> 0x0046 }
        L_0x004c:
            monitor-exit(r3);
            return;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.view.textservice.SpellCheckerSession.SpellCheckerSessionListenerImpl.onServiceConnected(com.android.internal.textservice.ISpellCheckerSession):void");
        }

        public void cancel() {
            processOrEnqueueTask(new SpellCheckerParams(TASK_CANCEL, null, 0, SpellCheckerSession.DBG));
        }

        public void getSuggestionsMultiple(TextInfo[] textInfos, int suggestionsLimit, boolean sequentialWords) {
            processOrEnqueueTask(new SpellCheckerParams(TASK_GET_SUGGESTIONS_MULTIPLE, textInfos, suggestionsLimit, sequentialWords));
        }

        public void getSentenceSuggestionsMultiple(TextInfo[] textInfos, int suggestionsLimit) {
            processOrEnqueueTask(new SpellCheckerParams(TASK_GET_SUGGESTIONS_MULTIPLE_FOR_SENTENCE, textInfos, suggestionsLimit, SpellCheckerSession.DBG));
        }

        public void close() {
            processOrEnqueueTask(new SpellCheckerParams(TASK_CLOSE, null, 0, SpellCheckerSession.DBG));
        }

        public boolean isDisconnected() {
            return (this.mOpened && this.mISpellCheckerSession == null) ? true : SpellCheckerSession.DBG;
        }

        private void processOrEnqueueTask(SpellCheckerParams scp) {
            synchronized (this) {
                ISpellCheckerSession session = this.mISpellCheckerSession;
                if (session == null) {
                    SpellCheckerParams closeTask = null;
                    if (scp.mWhat == TASK_CANCEL) {
                        while (!this.mPendingTasks.isEmpty()) {
                            SpellCheckerParams tmp = (SpellCheckerParams) this.mPendingTasks.poll();
                            if (tmp.mWhat == TASK_CLOSE) {
                                closeTask = tmp;
                            }
                        }
                    }
                    this.mPendingTasks.offer(scp);
                    if (closeTask != null) {
                        this.mPendingTasks.offer(closeTask);
                    }
                    return;
                }
                processTask(session, scp, SpellCheckerSession.DBG);
            }
        }

        public void onGetSuggestions(SuggestionsInfo[] results) {
            synchronized (this) {
                if (this.mHandler != null) {
                    this.mHandler.sendMessage(Message.obtain(this.mHandler, TASK_CANCEL, results));
                }
            }
        }

        public void onGetSentenceSuggestions(SentenceSuggestionsInfo[] results) {
            synchronized (this) {
                if (this.mHandler != null) {
                    this.mHandler.sendMessage(Message.obtain(this.mHandler, TASK_GET_SUGGESTIONS_MULTIPLE, results));
                }
            }
        }
    }

    static {
        TAG = SpellCheckerSession.class.getSimpleName();
    }

    public SpellCheckerSession(SpellCheckerInfo info, ITextServicesManager tsm, SpellCheckerSessionListener listener, SpellCheckerSubtype subtype) {
        this.mHandler = new C09041();
        if (info == null || listener == null || tsm == null) {
            throw new NullPointerException();
        }
        this.mSpellCheckerInfo = info;
        this.mSpellCheckerSessionListenerImpl = new SpellCheckerSessionListenerImpl(this.mHandler);
        this.mInternalListener = new InternalListener(this.mSpellCheckerSessionListenerImpl);
        this.mTextServicesManager = tsm;
        this.mIsUsed = true;
        this.mSpellCheckerSessionListener = listener;
        this.mSubtype = subtype;
    }

    public boolean isSessionDisconnected() {
        return this.mSpellCheckerSessionListenerImpl.isDisconnected();
    }

    public SpellCheckerInfo getSpellChecker() {
        return this.mSpellCheckerInfo;
    }

    public void cancel() {
        this.mSpellCheckerSessionListenerImpl.cancel();
    }

    public void close() {
        this.mIsUsed = DBG;
        try {
            this.mSpellCheckerSessionListenerImpl.close();
            this.mTextServicesManager.finishSpellCheckerService(this.mSpellCheckerSessionListenerImpl);
        } catch (RemoteException e) {
        }
    }

    public void getSentenceSuggestions(TextInfo[] textInfos, int suggestionsLimit) {
        this.mSpellCheckerSessionListenerImpl.getSentenceSuggestionsMultiple(textInfos, suggestionsLimit);
    }

    @Deprecated
    public void getSuggestions(TextInfo textInfo, int suggestionsLimit) {
        TextInfo[] textInfoArr = new TextInfo[MSG_ON_GET_SUGGESTION_MULTIPLE];
        textInfoArr[0] = textInfo;
        getSuggestions(textInfoArr, suggestionsLimit, DBG);
    }

    @Deprecated
    public void getSuggestions(TextInfo[] textInfos, int suggestionsLimit, boolean sequentialWords) {
        this.mSpellCheckerSessionListenerImpl.getSuggestionsMultiple(textInfos, suggestionsLimit, sequentialWords);
    }

    private void handleOnGetSuggestionsMultiple(SuggestionsInfo[] suggestionInfos) {
        this.mSpellCheckerSessionListener.onGetSuggestions(suggestionInfos);
    }

    private void handleOnGetSentenceSuggestionsMultiple(SentenceSuggestionsInfo[] suggestionInfos) {
        this.mSpellCheckerSessionListener.onGetSentenceSuggestions(suggestionInfos);
    }

    protected void finalize() throws Throwable {
        super.finalize();
        if (this.mIsUsed) {
            Log.e(TAG, "SpellCheckerSession was not finished properly.You should call finishShession() when you finished to use a spell checker.");
            close();
        }
    }

    public ITextServicesSessionListener getTextServicesSessionListener() {
        return this.mInternalListener;
    }

    public ISpellCheckerSessionListener getSpellCheckerSessionListener() {
        return this.mSpellCheckerSessionListenerImpl;
    }
}
