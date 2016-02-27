package android.content;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.net.Uri;
import android.telephony.SubscriptionManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;

public class SearchRecentSuggestionsProvider extends ContentProvider {
    public static final int DATABASE_MODE_2LINES = 2;
    public static final int DATABASE_MODE_QUERIES = 1;
    private static final int DATABASE_VERSION = 512;
    private static final String NULL_COLUMN = "query";
    private static final String ORDER_BY = "date DESC";
    private static final String TAG = "SuggestionsProvider";
    private static final int URI_MATCH_SUGGEST = 1;
    private static final String sDatabaseName = "suggestions.db";
    private static final String sSuggestions = "suggestions";
    private String mAuthority;
    private int mMode;
    private SQLiteOpenHelper mOpenHelper;
    private String mSuggestSuggestionClause;
    private String[] mSuggestionProjection;
    private Uri mSuggestionsUri;
    private boolean mTwoLineDisplay;
    private UriMatcher mUriMatcher;

    private static class DatabaseHelper extends SQLiteOpenHelper {
        private int mNewVersion;

        public DatabaseHelper(Context context, int newVersion) {
            super(context, SearchRecentSuggestionsProvider.sDatabaseName, null, newVersion);
            this.mNewVersion = newVersion;
        }

        public void onCreate(SQLiteDatabase db) {
            StringBuilder builder = new StringBuilder();
            builder.append("CREATE TABLE suggestions (_id INTEGER PRIMARY KEY,display1 TEXT UNIQUE ON CONFLICT REPLACE");
            if ((this.mNewVersion & SearchRecentSuggestionsProvider.DATABASE_MODE_2LINES) != 0) {
                builder.append(",display2 TEXT");
            }
            builder.append(",query TEXT,date LONG);");
            db.execSQL(builder.toString());
        }

        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            Log.w(SearchRecentSuggestionsProvider.TAG, "Upgrading database from version " + oldVersion + " to " + newVersion + ", which will destroy all old data");
            db.execSQL("DROP TABLE IF EXISTS suggestions");
            onCreate(db);
        }
    }

    protected void setupSuggestions(String authority, int mode) {
        if (TextUtils.isEmpty(authority) || (mode & URI_MATCH_SUGGEST) == 0) {
            throw new IllegalArgumentException();
        }
        this.mTwoLineDisplay = (mode & DATABASE_MODE_2LINES) != 0;
        this.mAuthority = new String(authority);
        this.mMode = mode;
        this.mSuggestionsUri = Uri.parse("content://" + this.mAuthority + "/suggestions");
        this.mUriMatcher = new UriMatcher(-1);
        this.mUriMatcher.addURI(this.mAuthority, "search_suggest_query", URI_MATCH_SUGGEST);
        if (this.mTwoLineDisplay) {
            this.mSuggestSuggestionClause = "display1 LIKE ? OR display2 LIKE ?";
            this.mSuggestionProjection = new String[]{"0 AS suggest_format", "'android.resource://system/17301578' AS suggest_icon_1", "display1 AS suggest_text_1", "display2 AS suggest_text_2", "query AS suggest_intent_query", SubscriptionManager.UNIQUE_KEY_SUBSCRIPTION_ID};
            return;
        }
        this.mSuggestSuggestionClause = "display1 LIKE ?";
        this.mSuggestionProjection = new String[]{"0 AS suggest_format", "'android.resource://system/17301578' AS suggest_icon_1", "display1 AS suggest_text_1", "query AS suggest_intent_query", SubscriptionManager.UNIQUE_KEY_SUBSCRIPTION_ID};
    }

    public int delete(Uri uri, String selection, String[] selectionArgs) {
        SQLiteDatabase db = this.mOpenHelper.getWritableDatabase();
        if (uri.getPathSegments().size() != URI_MATCH_SUGGEST) {
            throw new IllegalArgumentException("Unknown Uri");
        } else if (((String) uri.getPathSegments().get(0)).equals(sSuggestions)) {
            int count = db.delete(sSuggestions, selection, selectionArgs);
            getContext().getContentResolver().notifyChange(uri, null);
            return count;
        } else {
            throw new IllegalArgumentException("Unknown Uri");
        }
    }

    public String getType(Uri uri) {
        if (this.mUriMatcher.match(uri) == URI_MATCH_SUGGEST) {
            return "vnd.android.cursor.dir/vnd.android.search.suggest";
        }
        int length = uri.getPathSegments().size();
        if (length >= URI_MATCH_SUGGEST && ((String) uri.getPathSegments().get(0)).equals(sSuggestions)) {
            if (length == URI_MATCH_SUGGEST) {
                return "vnd.android.cursor.dir/suggestion";
            }
            if (length == DATABASE_MODE_2LINES) {
                return "vnd.android.cursor.item/suggestion";
            }
        }
        throw new IllegalArgumentException("Unknown Uri");
    }

    public Uri insert(Uri uri, ContentValues values) {
        SQLiteDatabase db = this.mOpenHelper.getWritableDatabase();
        int length = uri.getPathSegments().size();
        if (length < URI_MATCH_SUGGEST) {
            throw new IllegalArgumentException("Unknown Uri");
        }
        long rowID = -1;
        Uri newUri = null;
        if (((String) uri.getPathSegments().get(0)).equals(sSuggestions) && length == URI_MATCH_SUGGEST) {
            rowID = db.insert(sSuggestions, NULL_COLUMN, values);
            if (rowID > 0) {
                newUri = Uri.withAppendedPath(this.mSuggestionsUri, String.valueOf(rowID));
            }
        }
        if (rowID < 0) {
            throw new IllegalArgumentException("Unknown Uri");
        }
        getContext().getContentResolver().notifyChange(newUri, null);
        return newUri;
    }

    public boolean onCreate() {
        if (this.mAuthority == null || this.mMode == 0) {
            throw new IllegalArgumentException("Provider not configured");
        }
        this.mOpenHelper = new DatabaseHelper(getContext(), this.mMode + DATABASE_VERSION);
        return true;
    }

    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        SQLiteDatabase db = this.mOpenHelper.getReadableDatabase();
        if (this.mUriMatcher.match(uri) == URI_MATCH_SUGGEST) {
            String suggestSelection;
            String[] myArgs;
            if (TextUtils.isEmpty(selectionArgs[0])) {
                suggestSelection = null;
                myArgs = null;
            } else {
                String like = "%" + selectionArgs[0] + "%";
                if (this.mTwoLineDisplay) {
                    myArgs = new String[DATABASE_MODE_2LINES];
                    myArgs[0] = like;
                    myArgs[URI_MATCH_SUGGEST] = like;
                } else {
                    myArgs = new String[URI_MATCH_SUGGEST];
                    myArgs[0] = like;
                }
                suggestSelection = this.mSuggestSuggestionClause;
            }
            Cursor c = db.query(sSuggestions, this.mSuggestionProjection, suggestSelection, myArgs, null, null, ORDER_BY, null);
            c.setNotificationUri(getContext().getContentResolver(), uri);
            return c;
        }
        int length = uri.getPathSegments().size();
        if (length == URI_MATCH_SUGGEST || length == DATABASE_MODE_2LINES) {
            String base = (String) uri.getPathSegments().get(0);
            if (base.equals(sSuggestions)) {
                String[] useProjection = null;
                if (projection != null && projection.length > 0) {
                    useProjection = new String[(projection.length + URI_MATCH_SUGGEST)];
                    System.arraycopy(projection, 0, useProjection, 0, projection.length);
                    useProjection[projection.length] = "_id AS _id";
                }
                StringBuilder stringBuilder = new StringBuilder(InputMethodManager.CONTROL_START_INITIAL);
                if (length == DATABASE_MODE_2LINES) {
                    stringBuilder.append("(_id = ").append((String) uri.getPathSegments().get(URI_MATCH_SUGGEST)).append(")");
                }
                if (selection != null && selection.length() > 0) {
                    if (stringBuilder.length() > 0) {
                        stringBuilder.append(" AND ");
                    }
                    stringBuilder.append('(');
                    stringBuilder.append(selection);
                    stringBuilder.append(')');
                }
                c = db.query(base, useProjection, stringBuilder.toString(), selectionArgs, null, null, sortOrder, null);
                c.setNotificationUri(getContext().getContentResolver(), uri);
                return c;
            }
            throw new IllegalArgumentException("Unknown Uri");
        }
        throw new IllegalArgumentException("Unknown Uri");
    }

    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        throw new UnsupportedOperationException("Not implemented");
    }
}
