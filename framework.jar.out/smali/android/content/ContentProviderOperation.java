package android.content;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.Log;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class ContentProviderOperation implements Parcelable {
    public static final Creator<ContentProviderOperation> CREATOR;
    private static final String TAG = "ContentProviderOperation";
    public static final int TYPE_ASSERT = 4;
    public static final int TYPE_DELETE = 3;
    public static final int TYPE_INSERT = 1;
    public static final int TYPE_UPDATE = 2;
    private final Integer mExpectedCount;
    private final String mSelection;
    private final String[] mSelectionArgs;
    private final Map<Integer, Integer> mSelectionArgsBackReferences;
    private final int mType;
    private final Uri mUri;
    private final ContentValues mValues;
    private final ContentValues mValuesBackReferences;
    private final boolean mYieldAllowed;

    /* renamed from: android.content.ContentProviderOperation.1 */
    static class C00971 implements Creator<ContentProviderOperation> {
        C00971() {
        }

        public ContentProviderOperation createFromParcel(Parcel source) {
            return new ContentProviderOperation(null);
        }

        public ContentProviderOperation[] newArray(int size) {
            return new ContentProviderOperation[size];
        }
    }

    public static class Builder {
        private Integer mExpectedCount;
        private String mSelection;
        private String[] mSelectionArgs;
        private Map<Integer, Integer> mSelectionArgsBackReferences;
        private final int mType;
        private final Uri mUri;
        private ContentValues mValues;
        private ContentValues mValuesBackReferences;
        private boolean mYieldAllowed;

        private Builder(int type, Uri uri) {
            if (uri == null) {
                throw new IllegalArgumentException("uri must not be null");
            }
            this.mType = type;
            this.mUri = uri;
        }

        public ContentProviderOperation build() {
            if (this.mType == ContentProviderOperation.TYPE_UPDATE && ((this.mValues == null || this.mValues.size() == 0) && (this.mValuesBackReferences == null || this.mValuesBackReferences.size() == 0))) {
                throw new IllegalArgumentException("Empty values");
            } else if (this.mType != ContentProviderOperation.TYPE_ASSERT || ((this.mValues != null && this.mValues.size() != 0) || ((this.mValuesBackReferences != null && this.mValuesBackReferences.size() != 0) || this.mExpectedCount != null))) {
                return new ContentProviderOperation();
            } else {
                throw new IllegalArgumentException("Empty values");
            }
        }

        public Builder withValueBackReferences(ContentValues backReferences) {
            if (this.mType == ContentProviderOperation.TYPE_INSERT || this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                this.mValuesBackReferences = backReferences;
                return this;
            }
            throw new IllegalArgumentException("only inserts, updates, and asserts can have value back-references");
        }

        public Builder withValueBackReference(String key, int previousResult) {
            if (this.mType == ContentProviderOperation.TYPE_INSERT || this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                if (this.mValuesBackReferences == null) {
                    this.mValuesBackReferences = new ContentValues();
                }
                this.mValuesBackReferences.put(key, Integer.valueOf(previousResult));
                return this;
            }
            throw new IllegalArgumentException("only inserts, updates, and asserts can have value back-references");
        }

        public Builder withSelectionBackReference(int selectionArgIndex, int previousResult) {
            if (this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_DELETE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                if (this.mSelectionArgsBackReferences == null) {
                    this.mSelectionArgsBackReferences = new HashMap();
                }
                this.mSelectionArgsBackReferences.put(Integer.valueOf(selectionArgIndex), Integer.valueOf(previousResult));
                return this;
            }
            throw new IllegalArgumentException("only updates, deletes, and asserts can have selection back-references");
        }

        public Builder withValues(ContentValues values) {
            if (this.mType == ContentProviderOperation.TYPE_INSERT || this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                if (this.mValues == null) {
                    this.mValues = new ContentValues();
                }
                this.mValues.putAll(values);
                return this;
            }
            throw new IllegalArgumentException("only inserts, updates, and asserts can have values");
        }

        public Builder withValue(String key, Object value) {
            if (this.mType == ContentProviderOperation.TYPE_INSERT || this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                if (this.mValues == null) {
                    this.mValues = new ContentValues();
                }
                if (value == null) {
                    this.mValues.putNull(key);
                } else if (value instanceof String) {
                    this.mValues.put(key, (String) value);
                } else if (value instanceof Byte) {
                    this.mValues.put(key, (Byte) value);
                } else if (value instanceof Short) {
                    this.mValues.put(key, (Short) value);
                } else if (value instanceof Integer) {
                    this.mValues.put(key, (Integer) value);
                } else if (value instanceof Long) {
                    this.mValues.put(key, (Long) value);
                } else if (value instanceof Float) {
                    this.mValues.put(key, (Float) value);
                } else if (value instanceof Double) {
                    this.mValues.put(key, (Double) value);
                } else if (value instanceof Boolean) {
                    this.mValues.put(key, (Boolean) value);
                } else if (value instanceof byte[]) {
                    this.mValues.put(key, (byte[]) value);
                } else {
                    throw new IllegalArgumentException("bad value type: " + value.getClass().getName());
                }
                return this;
            }
            throw new IllegalArgumentException("only inserts and updates can have values");
        }

        public Builder withSelection(String selection, String[] selectionArgs) {
            if (this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_DELETE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                this.mSelection = selection;
                if (selectionArgs == null) {
                    this.mSelectionArgs = null;
                } else {
                    this.mSelectionArgs = new String[selectionArgs.length];
                    System.arraycopy(selectionArgs, 0, this.mSelectionArgs, 0, selectionArgs.length);
                }
                return this;
            }
            throw new IllegalArgumentException("only updates, deletes, and asserts can have selections");
        }

        public Builder withExpectedCount(int count) {
            if (this.mType == ContentProviderOperation.TYPE_UPDATE || this.mType == ContentProviderOperation.TYPE_DELETE || this.mType == ContentProviderOperation.TYPE_ASSERT) {
                this.mExpectedCount = Integer.valueOf(count);
                return this;
            }
            throw new IllegalArgumentException("only updates, deletes, and asserts can have expected counts");
        }

        public Builder withYieldAllowed(boolean yieldAllowed) {
            this.mYieldAllowed = yieldAllowed;
            return this;
        }
    }

    private ContentProviderOperation(Builder builder) {
        this.mType = builder.mType;
        this.mUri = builder.mUri;
        this.mValues = builder.mValues;
        this.mSelection = builder.mSelection;
        this.mSelectionArgs = builder.mSelectionArgs;
        this.mExpectedCount = builder.mExpectedCount;
        this.mSelectionArgsBackReferences = builder.mSelectionArgsBackReferences;
        this.mValuesBackReferences = builder.mValuesBackReferences;
        this.mYieldAllowed = builder.mYieldAllowed;
    }

    private ContentProviderOperation(Parcel source) {
        ContentValues contentValues;
        String readString;
        String[] readStringArray;
        Integer valueOf;
        Map map = null;
        this.mType = source.readInt();
        this.mUri = (Uri) Uri.CREATOR.createFromParcel(source);
        if (source.readInt() != 0) {
            contentValues = (ContentValues) ContentValues.CREATOR.createFromParcel(source);
        } else {
            contentValues = null;
        }
        this.mValues = contentValues;
        if (source.readInt() != 0) {
            readString = source.readString();
        } else {
            readString = null;
        }
        this.mSelection = readString;
        if (source.readInt() != 0) {
            readStringArray = source.readStringArray();
        } else {
            readStringArray = null;
        }
        this.mSelectionArgs = readStringArray;
        if (source.readInt() != 0) {
            valueOf = Integer.valueOf(source.readInt());
        } else {
            valueOf = null;
        }
        this.mExpectedCount = valueOf;
        if (source.readInt() != 0) {
            contentValues = (ContentValues) ContentValues.CREATOR.createFromParcel(source);
        } else {
            contentValues = null;
        }
        this.mValuesBackReferences = contentValues;
        if (source.readInt() != 0) {
            map = new HashMap();
        }
        this.mSelectionArgsBackReferences = map;
        if (this.mSelectionArgsBackReferences != null) {
            int count = source.readInt();
            for (int i = 0; i < count; i += TYPE_INSERT) {
                this.mSelectionArgsBackReferences.put(Integer.valueOf(source.readInt()), Integer.valueOf(source.readInt()));
            }
        }
        this.mYieldAllowed = source.readInt() != 0;
    }

    public ContentProviderOperation(ContentProviderOperation cpo, boolean removeUserIdFromUri) {
        this.mType = cpo.mType;
        if (removeUserIdFromUri) {
            this.mUri = ContentProvider.getUriWithoutUserId(cpo.mUri);
        } else {
            this.mUri = cpo.mUri;
        }
        this.mValues = cpo.mValues;
        this.mSelection = cpo.mSelection;
        this.mSelectionArgs = cpo.mSelectionArgs;
        this.mExpectedCount = cpo.mExpectedCount;
        this.mSelectionArgsBackReferences = cpo.mSelectionArgsBackReferences;
        this.mValuesBackReferences = cpo.mValuesBackReferences;
        this.mYieldAllowed = cpo.mYieldAllowed;
    }

    public ContentProviderOperation getWithoutUserIdInUri() {
        if (ContentProvider.uriHasUserId(this.mUri)) {
            return new ContentProviderOperation(this, true);
        }
        return this;
    }

    public void writeToParcel(Parcel dest, int flags) {
        int i;
        dest.writeInt(this.mType);
        Uri.writeToParcel(dest, this.mUri);
        if (this.mValues != null) {
            dest.writeInt(TYPE_INSERT);
            this.mValues.writeToParcel(dest, 0);
        } else {
            dest.writeInt(0);
        }
        if (this.mSelection != null) {
            dest.writeInt(TYPE_INSERT);
            dest.writeString(this.mSelection);
        } else {
            dest.writeInt(0);
        }
        if (this.mSelectionArgs != null) {
            dest.writeInt(TYPE_INSERT);
            dest.writeStringArray(this.mSelectionArgs);
        } else {
            dest.writeInt(0);
        }
        if (this.mExpectedCount != null) {
            dest.writeInt(TYPE_INSERT);
            dest.writeInt(this.mExpectedCount.intValue());
        } else {
            dest.writeInt(0);
        }
        if (this.mValuesBackReferences != null) {
            dest.writeInt(TYPE_INSERT);
            this.mValuesBackReferences.writeToParcel(dest, 0);
        } else {
            dest.writeInt(0);
        }
        if (this.mSelectionArgsBackReferences != null) {
            dest.writeInt(TYPE_INSERT);
            dest.writeInt(this.mSelectionArgsBackReferences.size());
            for (Entry<Integer, Integer> entry : this.mSelectionArgsBackReferences.entrySet()) {
                dest.writeInt(((Integer) entry.getKey()).intValue());
                dest.writeInt(((Integer) entry.getValue()).intValue());
            }
        } else {
            dest.writeInt(0);
        }
        if (this.mYieldAllowed) {
            i = TYPE_INSERT;
        } else {
            i = 0;
        }
        dest.writeInt(i);
    }

    public static Builder newInsert(Uri uri) {
        return new Builder(uri, null);
    }

    public static Builder newUpdate(Uri uri) {
        return new Builder(uri, null);
    }

    public static Builder newDelete(Uri uri) {
        return new Builder(uri, null);
    }

    public static Builder newAssertQuery(Uri uri) {
        return new Builder(uri, null);
    }

    public Uri getUri() {
        return this.mUri;
    }

    public boolean isYieldAllowed() {
        return this.mYieldAllowed;
    }

    public int getType() {
        return this.mType;
    }

    public boolean isDeleteOperation() {
        return this.mType == TYPE_DELETE;
    }

    public boolean isWriteOperation() {
        return this.mType == TYPE_DELETE || this.mType == TYPE_INSERT || this.mType == TYPE_UPDATE;
    }

    public boolean isReadOperation() {
        return this.mType == TYPE_ASSERT;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.content.ContentProviderResult apply(android.content.ContentProvider r20, android.content.ContentProviderResult[] r21, int r22) throws android.content.OperationApplicationException {
        /*
        r19 = this;
        r0 = r19;
        r1 = r21;
        r2 = r22;
        r18 = r0.resolveValueBackReferences(r1, r2);
        r0 = r19;
        r1 = r21;
        r2 = r22;
        r7 = r0.resolveSelectionArgsBackReferences(r1, r2);
        r0 = r19;
        r3 = r0.mType;
        r4 = 1;
        if (r3 != r4) goto L_0x0037;
    L_0x001b:
        r0 = r19;
        r3 = r0.mUri;
        r0 = r20;
        r1 = r18;
        r15 = r0.insert(r3, r1);
        if (r15 != 0) goto L_0x0031;
    L_0x0029:
        r3 = new android.content.OperationApplicationException;
        r4 = "insert failed";
        r3.<init>(r4);
        throw r3;
    L_0x0031:
        r3 = new android.content.ContentProviderResult;
        r3.<init>(r15);
    L_0x0036:
        return r3;
    L_0x0037:
        r0 = r19;
        r3 = r0.mType;
        r4 = 3;
        if (r3 != r4) goto L_0x0083;
    L_0x003e:
        r0 = r19;
        r3 = r0.mUri;
        r0 = r19;
        r4 = r0.mSelection;
        r0 = r20;
        r16 = r0.delete(r3, r4, r7);
    L_0x004c:
        r0 = r19;
        r3 = r0.mExpectedCount;
        if (r3 == 0) goto L_0x0172;
    L_0x0052:
        r0 = r19;
        r3 = r0.mExpectedCount;
        r3 = r3.intValue();
        r0 = r16;
        if (r3 == r0) goto L_0x0172;
    L_0x005e:
        r3 = "ContentProviderOperation";
        r4 = r19.toString();
        android.util.Log.e(r3, r4);
        r3 = new android.content.OperationApplicationException;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r6 = "wrong number of rows: ";
        r4 = r4.append(r6);
        r0 = r16;
        r4 = r4.append(r0);
        r4 = r4.toString();
        r3.<init>(r4);
        throw r3;
    L_0x0083:
        r0 = r19;
        r3 = r0.mType;
        r4 = 2;
        if (r3 != r4) goto L_0x009b;
    L_0x008a:
        r0 = r19;
        r3 = r0.mUri;
        r0 = r19;
        r4 = r0.mSelection;
        r0 = r20;
        r1 = r18;
        r16 = r0.update(r3, r1, r4, r7);
        goto L_0x004c;
    L_0x009b:
        r0 = r19;
        r3 = r0.mType;
        r4 = 4;
        if (r3 != r4) goto L_0x014c;
    L_0x00a2:
        r5 = 0;
        if (r18 == 0) goto L_0x00d6;
    L_0x00a5:
        r17 = new java.util.ArrayList;
        r17.<init>();
        r3 = r18.valueSet();
        r14 = r3.iterator();
    L_0x00b2:
        r3 = r14.hasNext();
        if (r3 == 0) goto L_0x00c8;
    L_0x00b8:
        r11 = r14.next();
        r11 = (java.util.Map.Entry) r11;
        r3 = r11.getKey();
        r0 = r17;
        r0.add(r3);
        goto L_0x00b2;
    L_0x00c8:
        r3 = r17.size();
        r3 = new java.lang.String[r3];
        r0 = r17;
        r5 = r0.toArray(r3);
        r5 = (java.lang.String[]) r5;
    L_0x00d6:
        r0 = r19;
        r4 = r0.mUri;
        r0 = r19;
        r6 = r0.mSelection;
        r8 = 0;
        r3 = r20;
        r9 = r3.query(r4, r5, r6, r7, r8);
        r16 = r9.getCount();	 Catch:{ all -> 0x013f }
        if (r5 == 0) goto L_0x0147;
    L_0x00eb:
        r3 = r9.moveToNext();	 Catch:{ all -> 0x013f }
        if (r3 == 0) goto L_0x0147;
    L_0x00f1:
        r13 = 0;
    L_0x00f2:
        r3 = r5.length;	 Catch:{ all -> 0x013f }
        if (r13 >= r3) goto L_0x00eb;
    L_0x00f5:
        r10 = r9.getString(r13);	 Catch:{ all -> 0x013f }
        r3 = r5[r13];	 Catch:{ all -> 0x013f }
        r0 = r18;
        r12 = r0.getAsString(r3);	 Catch:{ all -> 0x013f }
        r3 = android.text.TextUtils.equals(r10, r12);	 Catch:{ all -> 0x013f }
        if (r3 != 0) goto L_0x0144;
    L_0x0107:
        r3 = "ContentProviderOperation";
        r4 = r19.toString();	 Catch:{ all -> 0x013f }
        android.util.Log.e(r3, r4);	 Catch:{ all -> 0x013f }
        r3 = new android.content.OperationApplicationException;	 Catch:{ all -> 0x013f }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x013f }
        r4.<init>();	 Catch:{ all -> 0x013f }
        r6 = "Found value ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x013f }
        r4 = r4.append(r10);	 Catch:{ all -> 0x013f }
        r6 = " when expected ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x013f }
        r4 = r4.append(r12);	 Catch:{ all -> 0x013f }
        r6 = " for column ";
        r4 = r4.append(r6);	 Catch:{ all -> 0x013f }
        r6 = r5[r13];	 Catch:{ all -> 0x013f }
        r4 = r4.append(r6);	 Catch:{ all -> 0x013f }
        r4 = r4.toString();	 Catch:{ all -> 0x013f }
        r3.<init>(r4);	 Catch:{ all -> 0x013f }
        throw r3;	 Catch:{ all -> 0x013f }
    L_0x013f:
        r3 = move-exception;
        r9.close();
        throw r3;
    L_0x0144:
        r13 = r13 + 1;
        goto L_0x00f2;
    L_0x0147:
        r9.close();
        goto L_0x004c;
    L_0x014c:
        r3 = "ContentProviderOperation";
        r4 = r19.toString();
        android.util.Log.e(r3, r4);
        r3 = new java.lang.IllegalStateException;
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r6 = "bad type, ";
        r4 = r4.append(r6);
        r0 = r19;
        r6 = r0.mType;
        r4 = r4.append(r6);
        r4 = r4.toString();
        r3.<init>(r4);
        throw r3;
    L_0x0172:
        r3 = new android.content.ContentProviderResult;
        r0 = r16;
        r3.<init>(r0);
        goto L_0x0036;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.content.ContentProviderOperation.apply(android.content.ContentProvider, android.content.ContentProviderResult[], int):android.content.ContentProviderResult");
    }

    public ContentValues resolveValueBackReferences(ContentProviderResult[] backRefs, int numBackRefs) {
        if (this.mValuesBackReferences == null) {
            return this.mValues;
        }
        ContentValues values;
        if (this.mValues == null) {
            values = new ContentValues();
        } else {
            values = new ContentValues(this.mValues);
        }
        for (Entry<String, Object> entry : this.mValuesBackReferences.valueSet()) {
            String key = (String) entry.getKey();
            Integer backRefIndex = this.mValuesBackReferences.getAsInteger(key);
            if (backRefIndex == null) {
                Log.e(TAG, toString());
                throw new IllegalArgumentException("values backref " + key + " is not an integer");
            }
            values.put(key, Long.valueOf(backRefToValue(backRefs, numBackRefs, backRefIndex)));
        }
        return values;
    }

    public String[] resolveSelectionArgsBackReferences(ContentProviderResult[] backRefs, int numBackRefs) {
        if (this.mSelectionArgsBackReferences == null) {
            return this.mSelectionArgs;
        }
        String[] newArgs = new String[this.mSelectionArgs.length];
        System.arraycopy(this.mSelectionArgs, 0, newArgs, 0, this.mSelectionArgs.length);
        for (Entry<Integer, Integer> selectionArgBackRef : this.mSelectionArgsBackReferences.entrySet()) {
            newArgs[((Integer) selectionArgBackRef.getKey()).intValue()] = String.valueOf(backRefToValue(backRefs, numBackRefs, Integer.valueOf(((Integer) selectionArgBackRef.getValue()).intValue())));
        }
        return newArgs;
    }

    public String toString() {
        return "mType: " + this.mType + ", mUri: " + this.mUri + ", mSelection: " + this.mSelection + ", mExpectedCount: " + this.mExpectedCount + ", mYieldAllowed: " + this.mYieldAllowed + ", mValues: " + this.mValues + ", mValuesBackReferences: " + this.mValuesBackReferences + ", mSelectionArgsBackReferences: " + this.mSelectionArgsBackReferences;
    }

    private long backRefToValue(ContentProviderResult[] backRefs, int numBackRefs, Integer backRefIndex) {
        if (backRefIndex.intValue() >= numBackRefs) {
            Log.e(TAG, toString());
            throw new ArrayIndexOutOfBoundsException("asked for back ref " + backRefIndex + " but there are only " + numBackRefs + " back refs");
        }
        ContentProviderResult backRef = backRefs[backRefIndex.intValue()];
        if (backRef.uri != null) {
            return ContentUris.parseId(backRef.uri);
        }
        return (long) backRef.count.intValue();
    }

    public int describeContents() {
        return 0;
    }

    static {
        CREATOR = new C00971();
    }
}
