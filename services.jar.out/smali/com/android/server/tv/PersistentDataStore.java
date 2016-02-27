package com.android.server.tv;

import android.content.Context;
import android.content.Intent;
import android.media.tv.TvContentRating;
import android.os.Environment;
import android.os.Handler;
import android.os.UserHandle;
import android.text.TextUtils;
import android.util.AtomicFile;
import android.util.Slog;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.XmlUtils;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

final class PersistentDataStore {
    private static final String ATTR_ENABLED = "enabled";
    private static final String ATTR_STRING = "string";
    private static final String TAG = "TvInputManagerService";
    private static final String TAG_BLOCKED_RATINGS = "blocked-ratings";
    private static final String TAG_PARENTAL_CONTROLS = "parental-controls";
    private static final String TAG_RATING = "rating";
    private static final String TAG_TV_INPUT_MANAGER_STATE = "tv-input-manager-state";
    private final AtomicFile mAtomicFile;
    private final List<TvContentRating> mBlockedRatings;
    private boolean mBlockedRatingsChanged;
    private final Context mContext;
    private final Handler mHandler;
    private boolean mLoaded;
    private boolean mParentalControlsEnabled;
    private boolean mParentalControlsEnabledChanged;
    private final Runnable mSaveRunnable;

    /* renamed from: com.android.server.tv.PersistentDataStore.1 */
    class C05271 implements Runnable {
        C05271() {
        }

        public void run() {
            PersistentDataStore.this.save();
        }
    }

    public PersistentDataStore(Context context, int userId) {
        this.mHandler = new Handler();
        this.mBlockedRatings = Collections.synchronizedList(new ArrayList());
        this.mSaveRunnable = new C05271();
        this.mContext = context;
        File userDir = Environment.getUserSystemDirectory(userId);
        if (userDir.exists() || userDir.mkdirs()) {
            this.mAtomicFile = new AtomicFile(new File(userDir, "tv-input-manager-state.xml"));
            return;
        }
        throw new IllegalStateException("User dir cannot be created: " + userDir);
    }

    public boolean isParentalControlsEnabled() {
        loadIfNeeded();
        return this.mParentalControlsEnabled;
    }

    public void setParentalControlsEnabled(boolean enabled) {
        loadIfNeeded();
        if (this.mParentalControlsEnabled != enabled) {
            this.mParentalControlsEnabled = enabled;
            this.mParentalControlsEnabledChanged = true;
            postSave();
        }
    }

    public boolean isRatingBlocked(TvContentRating rating) {
        loadIfNeeded();
        synchronized (this.mBlockedRatings) {
            for (TvContentRating blcokedRating : this.mBlockedRatings) {
                if (rating.contains(blcokedRating)) {
                    return true;
                }
            }
            return false;
        }
    }

    public TvContentRating[] getBlockedRatings() {
        loadIfNeeded();
        return (TvContentRating[]) this.mBlockedRatings.toArray(new TvContentRating[this.mBlockedRatings.size()]);
    }

    public void addBlockedRating(TvContentRating rating) {
        loadIfNeeded();
        if (rating != null && !this.mBlockedRatings.contains(rating)) {
            this.mBlockedRatings.add(rating);
            this.mBlockedRatingsChanged = true;
            postSave();
        }
    }

    public void removeBlockedRating(TvContentRating rating) {
        loadIfNeeded();
        if (rating != null && this.mBlockedRatings.contains(rating)) {
            this.mBlockedRatings.remove(rating);
            this.mBlockedRatingsChanged = true;
            postSave();
        }
    }

    private void loadIfNeeded() {
        if (!this.mLoaded) {
            load();
            this.mLoaded = true;
        }
    }

    private void clearState() {
        this.mBlockedRatings.clear();
        this.mParentalControlsEnabled = false;
    }

    private void load() {
        Exception ex;
        clearState();
        try {
            InputStream is = this.mAtomicFile.openRead();
            try {
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(new BufferedInputStream(is), StandardCharsets.UTF_8.name());
                loadFromXml(parser);
                IoUtils.closeQuietly(is);
            } catch (Exception e) {
                ex = e;
                try {
                    Slog.w(TAG, "Failed to load tv input manager persistent store data.", ex);
                    clearState();
                } finally {
                    IoUtils.closeQuietly(is);
                }
            } catch (Exception e2) {
                ex = e2;
                Slog.w(TAG, "Failed to load tv input manager persistent store data.", ex);
                clearState();
            }
        } catch (FileNotFoundException e3) {
        }
    }

    private void postSave() {
        this.mHandler.removeCallbacks(this.mSaveRunnable);
        this.mHandler.post(this.mSaveRunnable);
    }

    private void save() {
        FileOutputStream os;
        try {
            os = this.mAtomicFile.startWrite();
            XmlSerializer serializer = new FastXmlSerializer();
            serializer.setOutput(new BufferedOutputStream(os), StandardCharsets.UTF_8.name());
            saveToXml(serializer);
            serializer.flush();
            if (true) {
                this.mAtomicFile.finishWrite(os);
                broadcastChangesIfNeeded();
                return;
            }
            this.mAtomicFile.failWrite(os);
        } catch (IOException ex) {
            Slog.w(TAG, "Failed to save tv input manager persistent store data.", ex);
        } catch (Throwable th) {
            if (false) {
                this.mAtomicFile.finishWrite(os);
                broadcastChangesIfNeeded();
            } else {
                this.mAtomicFile.failWrite(os);
            }
        }
    }

    private void broadcastChangesIfNeeded() {
        if (this.mParentalControlsEnabledChanged) {
            this.mParentalControlsEnabledChanged = false;
            this.mContext.sendBroadcastAsUser(new Intent("android.media.tv.action.PARENTAL_CONTROLS_ENABLED_CHANGED"), UserHandle.ALL);
        }
        if (this.mBlockedRatingsChanged) {
            this.mBlockedRatingsChanged = false;
            this.mContext.sendBroadcastAsUser(new Intent("android.media.tv.action.BLOCKED_RATINGS_CHANGED"), UserHandle.ALL);
        }
    }

    private void loadFromXml(XmlPullParser parser) throws IOException, XmlPullParserException {
        XmlUtils.beginDocument(parser, TAG_TV_INPUT_MANAGER_STATE);
        int outerDepth = parser.getDepth();
        while (XmlUtils.nextElementWithin(parser, outerDepth)) {
            if (parser.getName().equals(TAG_BLOCKED_RATINGS)) {
                loadBlockedRatingsFromXml(parser);
            } else if (parser.getName().equals(TAG_PARENTAL_CONTROLS)) {
                String enabled = parser.getAttributeValue(null, ATTR_ENABLED);
                if (TextUtils.isEmpty(enabled)) {
                    throw new XmlPullParserException("Missing enabled attribute on parental-controls");
                }
                this.mParentalControlsEnabled = Boolean.valueOf(enabled).booleanValue();
            } else {
                continue;
            }
        }
    }

    private void loadBlockedRatingsFromXml(XmlPullParser parser) throws IOException, XmlPullParserException {
        int outerDepth = parser.getDepth();
        while (XmlUtils.nextElementWithin(parser, outerDepth)) {
            if (parser.getName().equals(TAG_RATING)) {
                String ratingString = parser.getAttributeValue(null, ATTR_STRING);
                if (TextUtils.isEmpty(ratingString)) {
                    throw new XmlPullParserException("Missing string attribute on rating");
                }
                this.mBlockedRatings.add(TvContentRating.unflattenFromString(ratingString));
            }
        }
    }

    private void saveToXml(XmlSerializer serializer) throws IOException {
        serializer.startDocument(null, Boolean.valueOf(true));
        serializer.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
        serializer.startTag(null, TAG_TV_INPUT_MANAGER_STATE);
        serializer.startTag(null, TAG_BLOCKED_RATINGS);
        synchronized (this.mBlockedRatings) {
            for (TvContentRating rating : this.mBlockedRatings) {
                serializer.startTag(null, TAG_RATING);
                serializer.attribute(null, ATTR_STRING, rating.flattenToString());
                serializer.endTag(null, TAG_RATING);
            }
        }
        serializer.endTag(null, TAG_BLOCKED_RATINGS);
        serializer.startTag(null, TAG_PARENTAL_CONTROLS);
        serializer.attribute(null, ATTR_ENABLED, Boolean.toString(this.mParentalControlsEnabled));
        serializer.endTag(null, TAG_PARENTAL_CONTROLS);
        serializer.endTag(null, TAG_TV_INPUT_MANAGER_STATE);
        serializer.endDocument();
    }
}
