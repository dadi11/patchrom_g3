.class public Landroid/app/LGSharedPreferences;
.super Ljava/lang/Object;
.source "LGSharedPreferences.java"

# interfaces
.implements Landroid/content/SharedPreferences;
.implements Landroid/content/SharedPreferences$Editor;


# static fields
.field private static TAG:Ljava/lang/String;

.field private static final mContent:Ljava/lang/Object;

.field private static final sSharedPrefs:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Landroid/app/LGSharedPreferences;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mContext:Landroid/content/Context;

.field private mCrypt:Landroid/app/SettingsCrypto;

.field private final mListeners:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap",
            "<",
            "Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field mMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private mMode:I

.field private mName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 46
    const-string v0, "LGSharedPreferences"

    sput-object v0, Landroid/app/LGSharedPreferences;->TAG:Ljava/lang/String;

    .line 54
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Landroid/app/LGSharedPreferences;->mContent:Ljava/lang/Object;

    .line 58
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Landroid/app/LGSharedPreferences;->sSharedPrefs:Ljava/util/HashMap;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "mode"    # I

    .prologue
    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    iput-object v0, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    .line 62
    iput-object p1, p0, Landroid/app/LGSharedPreferences;->mContext:Landroid/content/Context;

    .line 63
    iput-object p2, p0, Landroid/app/LGSharedPreferences;->mName:Ljava/lang/String;

    .line 64
    iput p3, p0, Landroid/app/LGSharedPreferences;->mMode:I

    .line 65
    new-instance v0, Landroid/app/SettingsCrypto;

    invoke-direct {v0}, Landroid/app/SettingsCrypto;-><init>()V

    iput-object v0, p0, Landroid/app/LGSharedPreferences;->mCrypt:Landroid/app/SettingsCrypto;

    .line 66
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 67
    return-void
.end method

.method static synthetic access$000(Landroid/app/LGSharedPreferences;Ljava/util/Map;)V
    .locals 0
    .param p0, "x0"    # Landroid/app/LGSharedPreferences;
    .param p1, "x1"    # Ljava/util/Map;

    .prologue
    .line 45
    invoke-direct {p0, p1}, Landroid/app/LGSharedPreferences;->notifyListeners(Ljava/util/Map;)V

    return-void
.end method

.method public static get(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/LGSharedPreferences;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "mode"    # I

    .prologue
    .line 79
    sget-object v2, Landroid/app/LGSharedPreferences;->sSharedPrefs:Ljava/util/HashMap;

    monitor-enter v2

    .line 80
    :try_start_0
    sget-object v1, Landroid/app/LGSharedPreferences;->sSharedPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/LGSharedPreferences;

    .line 81
    .local v0, "sp":Landroid/app/LGSharedPreferences;
    if-nez v0, :cond_0

    .line 82
    new-instance v0, Landroid/app/LGSharedPreferences;

    .end local v0    # "sp":Landroid/app/LGSharedPreferences;
    invoke-direct {v0, p0, p1, p2}, Landroid/app/LGSharedPreferences;-><init>(Landroid/content/Context;Ljava/lang/String;I)V

    .line 83
    .restart local v0    # "sp":Landroid/app/LGSharedPreferences;
    sget-object v1, Landroid/app/LGSharedPreferences;->sSharedPrefs:Ljava/util/HashMap;

    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 85
    :cond_0
    monitor-exit v2

    .line 86
    return-object v0

    .line 85
    .end local v0    # "sp":Landroid/app/LGSharedPreferences;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private notifyListeners(Ljava/util/Map;)V
    .locals 9
    .param p1, "map"    # Ljava/util/Map;

    .prologue
    .line 334
    iget-object v7, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    if-eqz v7, :cond_0

    iget-object v7, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    invoke-virtual {v7}, Ljava/util/WeakHashMap;->size()I

    move-result v7

    if-nez v7, :cond_1

    .line 361
    :cond_0
    :goto_0
    return-void

    .line 338
    :cond_1
    new-instance v6, Ljava/util/HashSet;

    iget-object v7, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    invoke-virtual {v7}, Ljava/util/WeakHashMap;->keySet()Ljava/util/Set;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 341
    .local v6, "listeners":Ljava/util/Set;, "Ljava/util/Set<Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;>;"
    new-instance v4, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v7

    invoke-direct {v4, v7}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 343
    .local v4, "keys":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v7

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v8

    if-ne v7, v8, :cond_4

    .line 344
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v7

    add-int/lit8 v1, v7, -0x1

    .local v1, "i":I
    :goto_1
    if-ltz v1, :cond_0

    .line 345
    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 346
    .local v3, "key":Ljava/lang/String;
    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .line 347
    .local v5, "listener":Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;
    if-eqz v5, :cond_2

    .line 348
    invoke-interface {v5, p0, v3}, Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;->onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    goto :goto_2

    .line 344
    .end local v5    # "listener":Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;
    :cond_3
    add-int/lit8 v1, v1, -0x1

    goto :goto_1

    .line 354
    .end local v1    # "i":I
    .end local v2    # "i$":Ljava/util/Iterator;
    .end local v3    # "key":Ljava/lang/String;
    :cond_4
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mContext:Landroid/content/Context;

    check-cast v0, Landroid/app/Activity;

    .line 355
    .local v0, "activity":Landroid/app/Activity;
    new-instance v7, Landroid/app/LGSharedPreferences$1;

    invoke-direct {v7, p0, p1}, Landroid/app/LGSharedPreferences$1;-><init>(Landroid/app/LGSharedPreferences;Ljava/util/Map;)V

    invoke-virtual {v0, v7}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method private readFromSystemDB()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 90
    const/4 v2, 0x0

    .line 91
    .local v2, "map":Ljava/util/Map;
    const/4 v3, 0x0

    .line 93
    .local v3, "str":Ljava/lang/String;
    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    iget-object v6, p0, Landroid/app/LGSharedPreferences;->mName:Ljava/lang/String;

    invoke-static {v5, v6}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 95
    .local v0, "encrypted":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 96
    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mCrypt:Landroid/app/SettingsCrypto;

    invoke-virtual {v5, v0}, Landroid/app/SettingsCrypto;->decrypt(Ljava/lang/String;)[B

    move-result-object v4

    .line 97
    .local v4, "temp":[B
    if-eqz v4, :cond_0

    .line 98
    new-instance v3, Ljava/lang/String;

    .end local v3    # "str":Ljava/lang/String;
    invoke-direct {v3, v4}, Ljava/lang/String;-><init>([B)V

    .line 102
    .end local v4    # "temp":[B
    .restart local v3    # "str":Ljava/lang/String;
    :cond_0
    if-eqz v3, :cond_1

    .line 103
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    .line 104
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v3}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-direct {v1, v5}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 105
    .local v1, "is":Ljava/io/ByteArrayInputStream;
    if-eqz v1, :cond_1

    .line 106
    invoke-static {v1}, Lcom/android/internal/util/XmlUtils;->readMapXml(Ljava/io/InputStream;)Ljava/util/HashMap;

    move-result-object v2

    .line 107
    invoke-virtual {v1}, Ljava/io/ByteArrayInputStream;->close()V

    .line 111
    .end local v1    # "is":Ljava/io/ByteArrayInputStream;
    :cond_1
    if-eqz v2, :cond_2

    .line 112
    iput-object v2, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    .line 116
    :goto_0
    return-void

    .line 114
    :cond_2
    new-instance v5, Ljava/util/HashMap;

    invoke-direct {v5}, Ljava/util/HashMap;-><init>()V

    iput-object v5, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    goto :goto_0
.end method

.method private updateDB()V
    .locals 1

    .prologue
    .line 235
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->readFromSystemDB()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 239
    :goto_0
    return-void

    .line 236
    :catch_0
    move-exception v0

    .line 237
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private writeToSystemDB()Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 119
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 120
    .local v0, "builder":Ljava/lang/StringBuilder;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 121
    .local v2, "os":Ljava/io/ByteArrayOutputStream;
    if-eqz v2, :cond_0

    .line 122
    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-static {v5, v2}, Lcom/android/internal/util/XmlUtils;->writeMapXml(Ljava/util/Map;Ljava/io/OutputStream;)V

    .line 123
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 126
    :cond_0
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;

    move-result-object v1

    .line 128
    .local v1, "decrypted":Ljava/lang/String;
    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mCrypt:Landroid/app/SettingsCrypto;

    invoke-virtual {v5, v1}, Landroid/app/SettingsCrypto;->encrypt(Ljava/lang/String;)[B

    move-result-object v4

    .line 130
    .local v4, "temp":[B
    const-string v3, ""

    .line 131
    .local v3, "str":Ljava/lang/String;
    if-eqz v4, :cond_1

    .line 132
    invoke-static {v4}, Landroid/app/SettingsCrypto;->bytesToHex([B)Ljava/lang/String;

    move-result-object v3

    .line 134
    :cond_1
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_2

    .line 135
    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    iget-object v6, p0, Landroid/app/LGSharedPreferences;->mName:Ljava/lang/String;

    invoke-static {v5, v6, v3}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 136
    const/4 v5, 0x1

    .line 138
    :goto_0
    return v5

    :cond_2
    const/4 v5, 0x0

    goto :goto_0
.end method


# virtual methods
.method public apply()V
    .locals 0

    .prologue
    .line 147
    invoke-virtual {p0}, Landroid/app/LGSharedPreferences;->commit()Z

    .line 148
    return-void
.end method

.method public clear()Landroid/content/SharedPreferences$Editor;
    .locals 1

    .prologue
    .line 152
    monitor-enter p0

    .line 153
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 154
    monitor-exit p0

    return-object p0

    .line 155
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public commit()Z
    .locals 3

    .prologue
    .line 160
    const/4 v1, 0x0

    .line 162
    .local v1, "result":Z
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->writeToSystemDB()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 166
    :goto_0
    iget-object v2, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-direct {p0, v2}, Landroid/app/LGSharedPreferences;->notifyListeners(Ljava/util/Map;)V

    .line 167
    return v1

    .line 163
    :catch_0
    move-exception v0

    .line 164
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public contains(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 228
    monitor-enter p0

    .line 229
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    monitor-exit p0

    return v0

    .line 230
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public edit()Landroid/content/SharedPreferences$Editor;
    .locals 0

    .prologue
    .line 142
    return-object p0
.end method

.method public getAll()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "*>;"
        }
    .end annotation

    .prologue
    .line 243
    monitor-enter p0

    .line 244
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 245
    new-instance v0, Ljava/util/HashMap;

    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    monitor-exit p0

    return-object v0

    .line 246
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getBoolean(Ljava/lang/String;Z)Z
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defValue"    # Z

    .prologue
    .line 251
    monitor-enter p0

    .line 252
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 253
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    .line 254
    .local v0, "v":Ljava/lang/Boolean;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    .end local p2    # "defValue":Z
    :cond_0
    monitor-exit p0

    return p2

    .line 255
    .end local v0    # "v":Ljava/lang/Boolean;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getFloat(Ljava/lang/String;F)F
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defValue"    # F

    .prologue
    .line 260
    monitor-enter p0

    .line 261
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 262
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Float;

    .line 263
    .local v0, "v":Ljava/lang/Float;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result p2

    .end local p2    # "defValue":F
    :cond_0
    monitor-exit p0

    return p2

    .line 264
    .end local v0    # "v":Ljava/lang/Float;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getInt(Ljava/lang/String;I)I
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defValue"    # I

    .prologue
    .line 269
    monitor-enter p0

    .line 270
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 271
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 272
    .local v0, "v":Ljava/lang/Integer;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result p2

    .end local p2    # "defValue":I
    :cond_0
    monitor-exit p0

    return p2

    .line 273
    .end local v0    # "v":Ljava/lang/Integer;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getLong(Ljava/lang/String;J)J
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defValue"    # J

    .prologue
    .line 278
    monitor-enter p0

    .line 279
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 280
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 281
    .local v0, "v":Ljava/lang/Long;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide p2

    .end local p2    # "defValue":J
    :cond_0
    monitor-exit p0

    return-wide p2

    .line 282
    .end local v0    # "v":Ljava/lang/Long;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "defValue"    # Ljava/lang/String;

    .prologue
    .line 287
    monitor-enter p0

    .line 288
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 289
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 290
    .local v0, "v":Ljava/lang/String;
    if-eqz v0, :cond_0

    .end local v0    # "v":Ljava/lang/String;
    :goto_0
    monitor-exit p0

    return-object v0

    .restart local v0    # "v":Ljava/lang/String;
    :cond_0
    move-object v0, p2

    goto :goto_0

    .line 291
    .end local v0    # "v":Ljava/lang/String;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 296
    .local p2, "defValues":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    monitor-enter p0

    .line 297
    :try_start_0
    invoke-direct {p0}, Landroid/app/LGSharedPreferences;->updateDB()V

    .line 298
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Set;

    .line 299
    .local v0, "v":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    if-eqz v0, :cond_0

    .end local v0    # "v":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :goto_0
    monitor-exit p0

    return-object v0

    .restart local v0    # "v":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :cond_0
    move-object v0, p2

    goto :goto_0

    .line 300
    .end local v0    # "v":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Z

    .prologue
    .line 172
    monitor-enter p0

    .line 173
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 174
    monitor-exit p0

    return-object p0

    .line 175
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # F

    .prologue
    .line 180
    monitor-enter p0

    .line 181
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 182
    monitor-exit p0

    return-object p0

    .line 183
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # I

    .prologue
    .line 188
    monitor-enter p0

    .line 189
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 190
    monitor-exit p0

    return-object p0

    .line 191
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # J

    .prologue
    .line 196
    monitor-enter p0

    .line 197
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 198
    monitor-exit p0

    return-object p0

    .line 199
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    .line 204
    monitor-enter p0

    .line 205
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 206
    monitor-exit p0

    return-object p0

    .line 207
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Landroid/content/SharedPreferences$Editor;"
        }
    .end annotation

    .prologue
    .line 212
    .local p2, "values":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    monitor-enter p0

    .line 213
    :try_start_0
    iget-object v1, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    if-nez p2, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 214
    monitor-exit p0

    return-object p0

    .line 213
    :cond_0
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0, p2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    goto :goto_0

    .line 215
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    .locals 2
    .param p1, "listener"    # Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .prologue
    .line 306
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    sget-object v1, Landroid/app/LGSharedPreferences;->mContent:Ljava/lang/Object;

    invoke-virtual {v0, p1, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 307
    return-void
.end method

.method public remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    .line 220
    monitor-enter p0

    .line 221
    :try_start_0
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mMap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 222
    monitor-exit p0

    return-object p0

    .line 223
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .prologue
    .line 317
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 318
    .local v0, "builder":Ljava/lang/StringBuilder;
    sget-object v4, Landroid/app/LGSharedPreferences;->TAG:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 319
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\r\nName:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    sget-object v4, Landroid/app/LGSharedPreferences;->sSharedPrefs:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v3

    .line 322
    .local v3, "keys":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    if-eqz v3, :cond_0

    .line 323
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 324
    .local v2, "key":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\r\nkey="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 328
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "key":Ljava/lang/String;
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\r\nlistener size="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    invoke-virtual {v5}, Ljava/util/WeakHashMap;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 330
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method

.method public unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
    .locals 1
    .param p1, "listener"    # Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;

    .prologue
    .line 312
    iget-object v0, p0, Landroid/app/LGSharedPreferences;->mListeners:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p1}, Ljava/util/WeakHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 313
    return-void
.end method
