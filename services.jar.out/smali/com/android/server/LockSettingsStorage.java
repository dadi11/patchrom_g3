package com.android.server;

import android.content.ContentValues;
import android.content.Context;
import android.content.pm.UserInfo;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Environment;
import android.os.UserManager;
import android.util.ArrayMap;
import android.util.Log;
import android.util.Slog;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

class LockSettingsStorage {
    private static final String[] COLUMNS_FOR_PREFETCH;
    private static final String[] COLUMNS_FOR_QUERY;
    private static final String COLUMN_KEY = "name";
    private static final String COLUMN_USERID = "user";
    private static final String COLUMN_VALUE = "value";
    private static final Object DEFAULT;
    private static final String LOCK_PASSWORD_FILE = "password.key";
    private static final String LOCK_PATTERN_FILE = "gesture.key";
    private static final String SYSTEM_DIRECTORY = "/system/";
    private static final String TABLE = "locksettings";
    private static final String TAG = "LockSettingsStorage";
    private final Cache mCache;
    private final Context mContext;
    private final Object mFileWriteLock;
    private final DatabaseHelper mOpenHelper;

    public interface Callback {
        void initialize(SQLiteDatabase sQLiteDatabase);
    }

    private static class Cache {
        private final ArrayMap<CacheKey, Object> mCache;
        private final CacheKey mCacheKey;
        private int mVersion;

        private static final class CacheKey {
            static final int TYPE_FETCHED = 2;
            static final int TYPE_FILE = 1;
            static final int TYPE_KEY_VALUE = 0;
            String key;
            int type;
            int userId;

            private CacheKey() {
            }

            public CacheKey set(int type, String key, int userId) {
                this.type = type;
                this.key = key;
                this.userId = userId;
                return this;
            }

            public boolean equals(Object obj) {
                if (!(obj instanceof CacheKey)) {
                    return false;
                }
                CacheKey o = (CacheKey) obj;
                if (this.userId == o.userId && this.type == o.type && this.key.equals(o.key)) {
                    return true;
                }
                return false;
            }

            public int hashCode() {
                return (this.key.hashCode() ^ this.userId) ^ this.type;
            }
        }

        private Cache() {
            this.mCache = new ArrayMap();
            this.mCacheKey = new CacheKey();
            this.mVersion = 0;
        }

        String peekKeyValue(String key, String defaultValue, int userId) {
            Object cached = peek(0, key, userId);
            return cached == LockSettingsStorage.DEFAULT ? defaultValue : (String) cached;
        }

        boolean hasKeyValue(String key, int userId) {
            return contains(0, key, userId);
        }

        void putKeyValue(String key, String value, int userId) {
            put(0, key, value, userId);
        }

        void putKeyValueIfUnchanged(String key, Object value, int userId, int version) {
            putIfUnchanged(0, key, value, userId, version);
        }

        byte[] peekFile(String fileName) {
            return (byte[]) peek(1, fileName, -1);
        }

        boolean hasFile(String fileName) {
            return contains(1, fileName, -1);
        }

        void putFile(String key, byte[] value) {
            put(1, key, value, -1);
        }

        void putFileIfUnchanged(String key, byte[] value, int version) {
            putIfUnchanged(1, key, value, -1, version);
        }

        void setFetched(int userId) {
            put(2, "isFetched", "true", userId);
        }

        boolean isFetched(int userId) {
            return contains(2, "", userId);
        }

        private synchronized void put(int type, String key, Object value, int userId) {
            this.mCache.put(new CacheKey().set(type, key, userId), value);
            this.mVersion++;
        }

        private synchronized void putIfUnchanged(int type, String key, Object value, int userId, int version) {
            if (!contains(type, key, userId) && this.mVersion == version) {
                put(type, key, value, userId);
            }
        }

        private synchronized boolean contains(int type, String key, int userId) {
            return this.mCache.containsKey(this.mCacheKey.set(type, key, userId));
        }

        private synchronized Object peek(int type, String key, int userId) {
            return this.mCache.get(this.mCacheKey.set(type, key, userId));
        }

        private synchronized int getVersion() {
            return this.mVersion;
        }

        synchronized void removeUser(int userId) {
            for (int i = this.mCache.size() - 1; i >= 0; i--) {
                if (((CacheKey) this.mCache.keyAt(i)).userId == userId) {
                    this.mCache.removeAt(i);
                }
            }
            this.mVersion++;
        }

        synchronized void clear() {
            this.mCache.clear();
            this.mVersion++;
        }
    }

    class DatabaseHelper extends SQLiteOpenHelper {
        private static final String DATABASE_NAME = "locksettings.db";
        private static final int DATABASE_VERSION = 2;
        private static final String TAG = "LockSettingsDB";
        private final Callback mCallback;

        public DatabaseHelper(Context context, Callback callback) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
            setWriteAheadLoggingEnabled(true);
            this.mCallback = callback;
        }

        private void createTable(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE locksettings (_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,user INTEGER,value TEXT);");
        }

        public void onCreate(SQLiteDatabase db) {
            createTable(db);
            this.mCallback.initialize(db);
        }

        public void onUpgrade(SQLiteDatabase db, int oldVersion, int currentVersion) {
            int upgradeVersion = oldVersion;
            if (upgradeVersion == 1) {
                upgradeVersion = DATABASE_VERSION;
            }
            if (upgradeVersion != DATABASE_VERSION) {
                Log.w(TAG, "Failed to upgrade database!");
            }
        }
    }

    static {
        COLUMNS_FOR_QUERY = new String[]{COLUMN_VALUE};
        COLUMNS_FOR_PREFETCH = new String[]{COLUMN_KEY, COLUMN_VALUE};
        DEFAULT = new Object();
    }

    public LockSettingsStorage(Context context, Callback callback) {
        this.mCache = new Cache();
        this.mFileWriteLock = new Object();
        this.mContext = context;
        this.mOpenHelper = new DatabaseHelper(context, callback);
    }

    public void writeKeyValue(String key, String value, int userId) {
        writeKeyValue(this.mOpenHelper.getWritableDatabase(), key, value, userId);
    }

    public void writeKeyValue(SQLiteDatabase db, String key, String value, int userId) {
        ContentValues cv = new ContentValues();
        cv.put(COLUMN_KEY, key);
        cv.put(COLUMN_USERID, Integer.valueOf(userId));
        cv.put(COLUMN_VALUE, value);
        db.beginTransaction();
        try {
            db.delete(TABLE, "name=? AND user=?", new String[]{key, Integer.toString(userId)});
            db.insert(TABLE, null, cv);
            db.setTransactionSuccessful();
            this.mCache.putKeyValue(key, value, userId);
        } finally {
            db.endTransaction();
        }
    }

    public String readKeyValue(String key, String defaultValue, int userId) {
        synchronized (this.mCache) {
            if (this.mCache.hasKeyValue(key, userId)) {
                defaultValue = this.mCache.peekKeyValue(key, defaultValue, userId);
                return defaultValue;
            }
            Object obj;
            int version = this.mCache.getVersion();
            Object result = DEFAULT;
            Cursor cursor = this.mOpenHelper.getReadableDatabase().query(TABLE, COLUMNS_FOR_QUERY, "user=? AND name=?", new String[]{Integer.toString(userId), key}, null, null, null);
            if (cursor != null) {
                if (cursor.moveToFirst()) {
                    result = cursor.getString(0);
                }
                cursor.close();
                obj = result;
            } else {
                obj = result;
            }
            this.mCache.putKeyValueIfUnchanged(key, obj, userId, version);
            if (obj != DEFAULT) {
                return (String) obj;
            }
            return defaultValue;
        }
    }

    public void prefetchUser(int userId) {
        synchronized (this.mCache) {
            if (this.mCache.isFetched(userId)) {
                return;
            }
            this.mCache.setFetched(userId);
            int version = this.mCache.getVersion();
            Cursor cursor = this.mOpenHelper.getReadableDatabase().query(TABLE, COLUMNS_FOR_PREFETCH, "user=?", new String[]{Integer.toString(userId)}, null, null, null);
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    this.mCache.putKeyValueIfUnchanged(cursor.getString(0), cursor.getString(1), userId, version);
                }
                cursor.close();
            }
            readPasswordHash(userId);
            readPatternHash(userId);
        }
    }

    public byte[] readPasswordHash(int userId) {
        byte[] stored = readFile(getLockPasswordFilename(userId));
        return (stored == null || stored.length <= 0) ? null : stored;
    }

    public byte[] readPatternHash(int userId) {
        byte[] stored = readFile(getLockPatternFilename(userId));
        return (stored == null || stored.length <= 0) ? null : stored;
    }

    public boolean hasPassword(int userId) {
        return hasFile(getLockPasswordFilename(userId));
    }

    public boolean hasPattern(int userId) {
        return hasFile(getLockPatternFilename(userId));
    }

    private boolean hasFile(String name) {
        byte[] contents = readFile(name);
        return contents != null && contents.length > 0;
    }

    private byte[] readFile(String name) {
        byte[] peekFile;
        IOException e;
        Throwable th;
        synchronized (this.mCache) {
            if (this.mCache.hasFile(name)) {
                peekFile = this.mCache.peekFile(name);
            } else {
                int version = this.mCache.getVersion();
                RandomAccessFile raf = null;
                peekFile = null;
                try {
                    RandomAccessFile raf2 = new RandomAccessFile(name, "r");
                    try {
                        peekFile = new byte[((int) raf2.length())];
                        raf2.readFully(peekFile, 0, peekFile.length);
                        raf2.close();
                        if (raf2 != null) {
                            try {
                                raf2.close();
                                raf = raf2;
                            } catch (IOException e2) {
                                Slog.e(TAG, "Error closing file " + e2);
                                raf = raf2;
                            }
                        }
                    } catch (IOException e3) {
                        e2 = e3;
                        raf = raf2;
                        try {
                            Slog.e(TAG, "Cannot read file " + e2);
                            if (raf != null) {
                                try {
                                    raf.close();
                                } catch (IOException e22) {
                                    Slog.e(TAG, "Error closing file " + e22);
                                }
                            }
                            this.mCache.putFileIfUnchanged(name, peekFile, version);
                            return peekFile;
                        } catch (Throwable th2) {
                            th = th2;
                            if (raf != null) {
                                try {
                                    raf.close();
                                } catch (IOException e222) {
                                    Slog.e(TAG, "Error closing file " + e222);
                                }
                            }
                            throw th;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        raf = raf2;
                        if (raf != null) {
                            raf.close();
                        }
                        throw th;
                    }
                } catch (IOException e4) {
                    e222 = e4;
                    Slog.e(TAG, "Cannot read file " + e222);
                    if (raf != null) {
                        raf.close();
                    }
                    this.mCache.putFileIfUnchanged(name, peekFile, version);
                    return peekFile;
                }
                this.mCache.putFileIfUnchanged(name, peekFile, version);
            }
        }
        return peekFile;
    }

    private void writeFile(String name, byte[] hash) {
        IOException e;
        Throwable th;
        synchronized (this.mFileWriteLock) {
            RandomAccessFile randomAccessFile = null;
            try {
                RandomAccessFile raf = new RandomAccessFile(name, "rw");
                if (hash != null) {
                    try {
                        if (hash.length != 0) {
                            raf.write(hash, 0, hash.length);
                            raf.close();
                            if (raf == null) {
                                try {
                                    raf.close();
                                    randomAccessFile = raf;
                                } catch (IOException e2) {
                                    Slog.e(TAG, "Error closing file " + e2);
                                    randomAccessFile = raf;
                                } catch (Throwable th2) {
                                    th = th2;
                                    randomAccessFile = raf;
                                    throw th;
                                }
                            }
                            this.mCache.putFile(name, hash);
                        }
                    } catch (IOException e3) {
                        e2 = e3;
                        randomAccessFile = raf;
                        try {
                            Slog.e(TAG, "Error writing to file " + e2);
                            if (randomAccessFile != null) {
                                try {
                                    randomAccessFile.close();
                                } catch (IOException e22) {
                                    Slog.e(TAG, "Error closing file " + e22);
                                } catch (Throwable th3) {
                                    th = th3;
                                    throw th;
                                }
                            }
                            this.mCache.putFile(name, hash);
                        } catch (Throwable th4) {
                            th = th4;
                            if (randomAccessFile != null) {
                                try {
                                    randomAccessFile.close();
                                } catch (IOException e222) {
                                    Slog.e(TAG, "Error closing file " + e222);
                                }
                            }
                            throw th;
                        }
                    } catch (Throwable th5) {
                        th = th5;
                        randomAccessFile = raf;
                        if (randomAccessFile != null) {
                            randomAccessFile.close();
                        }
                        throw th;
                    }
                }
                raf.setLength(0);
                raf.close();
                if (raf == null) {
                } else {
                    raf.close();
                    randomAccessFile = raf;
                }
            } catch (IOException e4) {
                e222 = e4;
                Slog.e(TAG, "Error writing to file " + e222);
                if (randomAccessFile != null) {
                    randomAccessFile.close();
                }
                this.mCache.putFile(name, hash);
            }
            this.mCache.putFile(name, hash);
        }
    }

    public void writePatternHash(byte[] hash, int userId) {
        writeFile(getLockPatternFilename(userId), hash);
    }

    public void writePasswordHash(byte[] hash, int userId) {
        writeFile(getLockPasswordFilename(userId), hash);
    }

    String getLockPatternFilename(int userId) {
        return getLockCredentialFilePathForUser(userId, LOCK_PATTERN_FILE);
    }

    String getLockPasswordFilename(int userId) {
        return getLockCredentialFilePathForUser(userId, LOCK_PASSWORD_FILE);
    }

    private String getLockCredentialFilePathForUser(int userId, String basename) {
        userId = getUserParentOrSelfId(userId);
        String dataSystemDirectory = Environment.getDataDirectory().getAbsolutePath() + SYSTEM_DIRECTORY;
        if (userId == 0) {
            return dataSystemDirectory + basename;
        }
        return new File(Environment.getUserSystemDirectory(userId), basename).getAbsolutePath();
    }

    private int getUserParentOrSelfId(int userId) {
        if (userId == 0) {
            return userId;
        }
        UserInfo pi = ((UserManager) this.mContext.getSystemService(COLUMN_USERID)).getProfileParent(userId);
        if (pi != null) {
            return pi.id;
        }
        return userId;
    }

    public void removeUser(int userId) {
        SQLiteDatabase db = this.mOpenHelper.getWritableDatabase();
        UserInfo parentInfo = ((UserManager) this.mContext.getSystemService(COLUMN_USERID)).getProfileParent(userId);
        synchronized (this.mFileWriteLock) {
            if (parentInfo == null) {
                String name = getLockPasswordFilename(userId);
                File file = new File(name);
                if (file.exists()) {
                    file.delete();
                    this.mCache.putFile(name, null);
                }
                name = getLockPatternFilename(userId);
                file = new File(name);
                if (file.exists()) {
                    file.delete();
                    this.mCache.putFile(name, null);
                }
            }
        }
        try {
            db.beginTransaction();
            db.delete(TABLE, "user='" + userId + "'", null);
            db.setTransactionSuccessful();
            this.mCache.removeUser(userId);
        } finally {
            db.endTransaction();
        }
    }

    void closeDatabase() {
        this.mOpenHelper.close();
    }

    void clearCache() {
        this.mCache.clear();
    }
}
