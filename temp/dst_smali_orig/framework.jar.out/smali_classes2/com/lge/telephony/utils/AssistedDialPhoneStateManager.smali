.class public Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;
.super Ljava/lang/Object;
.source "AssistedDialPhoneStateManager.java"


# static fields
.field public static final ASSIST_OFF:Ljava/lang/String; = "assist_off"

.field public static final ASSIST_ON:Ljava/lang/String; = "assist_on"

.field public static final DIAL_FROM_CONTACT:Ljava/lang/String; = "contact"

.field public static final DIAL_FROM_IDLE:Ljava/lang/String; = "idle"

.field public static final RADIO_TECH_CDMA:Ljava/lang/String; = "cdma"

.field public static final RADIO_TECH_GSM:Ljava/lang/String; = "gsm"

.field public static final ROAMING_STATUS_HOME:Ljava/lang/String; = "home"

.field public static final ROAMING_STATUS_ROAMING:Ljava/lang/String; = "roaming"

.field private static sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mCurrentRadioTech:Ljava/lang/String;

.field private mCurrentRoamingStatus:Ljava/lang/String;

.field private mListener:Landroid/telephony/PhoneStateListener;

.field private mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

.field private mOtaMccObserver:Landroid/database/ContentObserver;

.field private mOtaSidObserver:Landroid/database/ContentObserver;

.field private mRefAreaCode:Ljava/lang/String;

.field private mRefAreaObserver:Landroid/database/ContentObserver;

.field private mRefCountry:Lcom/lge/telephony/LGReferenceCountry;

.field private mRefCountryObserver:Landroid/database/ContentObserver;

.field private mSIDTable:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/SIDRangeType;",
            ">;"
        }
    .end annotation
.end field

.field private mTelephonyManager:Landroid/telephony/TelephonyManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    return-void
.end method

.method protected constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountry:Lcom/lge/telephony/LGReferenceCountry;

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaCode:Ljava/lang/String;

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$1;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$1;-><init>(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaMccObserver:Landroid/database/ContentObserver;

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$2;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$2;-><init>(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaSidObserver:Landroid/database/ContentObserver;

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$3;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$3;-><init>(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaObserver:Landroid/database/ContentObserver;

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$4;

    new-instance v1, Landroid/os/Handler;

    invoke-direct {v1}, Landroid/os/Handler;-><init>()V

    invoke-direct {v0, p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$4;-><init>(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountryObserver:Landroid/database/ContentObserver;

    iput-object p1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    sput-object p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->init()V

    return-void
.end method

.method static synthetic access$000(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 1
    .param p0, "x0"    # Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    .prologue
    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryInternal()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;Lcom/lge/telephony/LGReferenceCountry;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 1
    .param p0, "x0"    # Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;
    .param p1, "x1"    # Lcom/lge/telephony/LGReferenceCountry;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->updateOtaCountry(Lcom/lge/telephony/LGReferenceCountry;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    return-object v0
.end method

.method private fillReferenceCountry(Lcom/lge/telephony/LGReferenceCountry;Landroid/database/Cursor;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 1
    .param p1, "refCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p2, "cursor"    # Landroid/database/Cursor;

    .prologue
    const-string v0, "countryindex"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setIndex(I)V

    const-string v0, "countryname"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setCountryName(Ljava/lang/String;)V

    const-string v0, "mcc"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setMccCode(Ljava/lang/String;)V

    const-string v0, "countrycode"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setCountryCode(Ljava/lang/String;)V

    const-string v0, "iddprefix"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setIddPrefix(Ljava/lang/String;)V

    const-string v0, "nddprefix"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setNddPrefix(Ljava/lang/String;)V

    const-string v0, "nanp"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setNanp(Ljava/lang/String;)V

    const-string v0, "area"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setAreaCode(Ljava/lang/String;)V

    const-string v0, "length"

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/lge/telephony/LGReferenceCountry;->setNumLength(Ljava/lang/String;)V

    return-object p1
.end method

.method private getCountryWithCondition(Ljava/lang/String;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 9
    .param p1, "where"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    const/4 v6, 0x0

    .local v6, "country":Lcom/lge/telephony/LGReferenceCountry;
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "resolver":Landroid/content/ContentResolver;
    const-string v1, "AssistedDial"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getCountryWithCondition WHERE : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/constants/SettingsConstants$AssistDial;->PROJECTION:[Ljava/lang/String;

    move-object v3, p1

    move-object v5, v4

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .local v8, "cursor":Landroid/database/Cursor;
    if-nez v8, :cond_0

    const-string v1, "AssistedDial"

    const-string v2, "Failed to query"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-object v4

    :cond_0
    :try_start_0
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_1

    new-instance v7, Lcom/lge/telephony/LGReferenceCountry;

    invoke-direct {v7}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .local v7, "country":Lcom/lge/telephony/LGReferenceCountry;
    :try_start_1
    invoke-direct {p0, v7, v8}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->fillReferenceCountry(Lcom/lge/telephony/LGReferenceCountry;Landroid/database/Cursor;)Lcom/lge/telephony/LGReferenceCountry;

    const-string v1, "AssistedDial"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getCountryWithCondition is returning : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v7}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object v6, v7

    .end local v7    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    :cond_1
    if-eqz v8, :cond_2

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_2
    :goto_1
    move-object v4, v6

    goto :goto_0

    :catch_0
    move-exception v1

    :goto_2
    if-eqz v8, :cond_2

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    goto :goto_1

    :catchall_0
    move-exception v1

    :goto_3
    if-eqz v8, :cond_3

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_3
    throw v1

    .end local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v7    # "country":Lcom/lge/telephony/LGReferenceCountry;
    :catchall_1
    move-exception v1

    move-object v6, v7

    .end local v7    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    goto :goto_3

    .end local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v7    # "country":Lcom/lge/telephony/LGReferenceCountry;
    :catch_1
    move-exception v1

    move-object v6, v7

    .end local v7    # "country":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v6    # "country":Lcom/lge/telephony/LGReferenceCountry;
    goto :goto_2
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const-class v1, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    if-nez v0, :cond_0

    if-eqz p0, :cond_0

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-direct {v0, p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    :cond_0
    sget-object v0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->sInstance:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private getOtaCountryByMcc()Lcom/lge/telephony/LGReferenceCountry;
    .locals 6

    .prologue
    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .local v1, "resolver":Landroid/content/ContentResolver;
    const/16 v0, 0x3ff

    .local v0, "otaMcc":I
    :try_start_0
    const-string v3, "assist_dial_ota_mcc"

    invoke-static {v1, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    const-string v3, "AssistedDial"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "OTA Country MCC: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mcc LIKE \'%"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%\'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .local v2, "sWhere":Ljava/lang/String;
    invoke-direct {p0, v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCountryWithCondition(Ljava/lang/String;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    return-object v3

    .end local v2    # "sWhere":Ljava/lang/String;
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method private getOtaCountryBySid()Lcom/lge/telephony/LGReferenceCountry;
    .locals 10

    .prologue
    const/4 v3, 0x0

    .local v3, "otaCountry":Lcom/lge/telephony/LGReferenceCountry;
    iget-object v7, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    .local v5, "resolver":Landroid/content/ContentResolver;
    const/4 v4, 0x0

    .local v4, "otaSid":I
    :try_start_0
    const-string v7, "assist_dial_ota_sid"

    invoke-static {v5, v7}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    :goto_0
    if-nez v4, :cond_0

    .end local v3    # "otaCountry":Lcom/lge/telephony/LGReferenceCountry;
    :goto_1
    return-object v3

    .restart local v3    # "otaCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_0
    move-exception v1

    .local v1, "ex":Landroid/provider/Settings$SettingNotFoundException;
    const-string v7, "AssistedDial"

    const-string v8, "assist_dial_ota_sid Setting Not Found!"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "ex":Landroid/provider/Settings$SettingNotFoundException;
    :cond_0
    const-string v7, "AssistedDial"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "OTA Country SID: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    .local v2, "index":I
    :goto_2
    iget-object v7, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v2, v7, :cond_2

    iget-object v7, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/telephony/utils/SIDRangeType;

    invoke-virtual {v7}, Lcom/lge/telephony/utils/SIDRangeType;->getStart()I

    move-result v7

    if-gt v7, v4, :cond_1

    iget-object v7, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/telephony/utils/SIDRangeType;

    invoke-virtual {v7}, Lcom/lge/telephony/utils/SIDRangeType;->getEnd()I

    move-result v7

    if-gt v4, v7, :cond_1

    iget-object v7, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/telephony/utils/SIDRangeType;

    invoke-virtual {v7}, Lcom/lge/telephony/utils/SIDRangeType;->getCountryIndex()I

    move-result v0

    .local v0, "countryIndex":I
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "countryindex = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .local v6, "sWhere":Ljava/lang/String;
    invoke-direct {p0, v6}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCountryWithCondition(Ljava/lang/String;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    goto :goto_1

    .end local v0    # "countryIndex":I
    .end local v6    # "sWhere":Ljava/lang/String;
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_2
    const-string v7, "AssistedDial"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "getOtaCountryBySid for sid "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " is returning null"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method

.method private getOtaCountryInternal()Lcom/lge/telephony/LGReferenceCountry;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .local v0, "otaCountry":Lcom/lge/telephony/LGReferenceCountry;
    const-string v1, "gsm"

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryByMcc()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    if-eqz v0, :cond_0

    move-object v1, v0

    :goto_0
    return-object v1

    :cond_0
    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryBySid()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    goto :goto_0

    :cond_1
    const-string v1, "cdma"

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "AssistedDial"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Current radio tech is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "AssistedDial"

    const-string v2, "getOtaCountry is returning null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    goto :goto_0

    :cond_2
    const-string v1, "AssistedDial"

    const-string v2, "tech is cdma"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryBySid()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    if-eqz v0, :cond_3

    move-object v1, v0

    goto :goto_0

    :cond_3
    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryByMcc()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    goto :goto_0
.end method

.method private init()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const-string v3, "AssistedDial"

    const-string v4, "Initializing"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    const-string v4, "phone"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/telephony/TelephonyManager;

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    new-instance v3, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$5;

    invoke-direct {v3, p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager$5;-><init>(Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;)V

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mListener:Landroid/telephony/PhoneStateListener;

    :try_start_0
    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v2

    .local v2, "phoneType":I
    const/4 v3, 0x2

    if-ne v3, v2, :cond_1

    const-string v3, "cdma"

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "phoneType":I
    :cond_0
    :goto_0
    const-string v3, "home"

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRoamingStatus:Ljava/lang/String;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    iget-object v4, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mListener:Landroid/telephony/PhoneStateListener;

    invoke-virtual {v3, v4, v5}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "cr":Landroid/content/ContentResolver;
    const-string v3, "assist_dial_ota_mcc"

    invoke-static {v3}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaMccObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v3, v5, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v3, "assist_dial_ota_sid"

    invoke-static {v3}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaSidObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v3, v5, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v3, "area"

    invoke-static {v3}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v3, v5, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const-string v3, "assist_dial_reference_country"

    invoke-static {v3}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountryObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v3, v5, v4}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefAreaCode()Ljava/lang/String;

    return-void

    .end local v0    # "cr":Landroid/content/ContentResolver;
    .restart local v2    # "phoneType":I
    :cond_1
    if-ne v5, v2, :cond_0

    :try_start_1
    const-string v3, "gsm"

    iput-object v3, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .end local v2    # "phoneType":I
    :catch_0
    move-exception v1

    .local v1, "ex":Ljava/lang/Exception;
    const-string v3, "AssistedDial"

    const-string v4, "AssistedDialPhoneStateManager :: Exception"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private updateOtaCountry(Lcom/lge/telephony/LGReferenceCountry;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 1
    .param p1, "newCountry"    # Lcom/lge/telephony/LGReferenceCountry;

    .prologue
    iput-object p1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

    return-object v0
.end method


# virtual methods
.method protected applyServiceState(Landroid/telephony/ServiceState;)V
    .locals 4
    .param p1, "state"    # Landroid/telephony/ServiceState;

    .prologue
    const-string v1, "AssistedDial"

    const-string v2, "Service State Changed"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v0

    .local v0, "phoneType":I
    const/4 v1, 0x2

    if-ne v1, v0, :cond_1

    const-string v1, "cdma"

    iput-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;

    :goto_0
    invoke-virtual {p1}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_USA_NORMAL:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    :cond_0
    const-string v1, "roaming"

    iput-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRoamingStatus:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "phoneType":I
    :goto_1
    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryInternal()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->updateOtaCountry(Lcom/lge/telephony/LGReferenceCountry;)Lcom/lge/telephony/LGReferenceCountry;

    return-void

    .restart local v0    # "phoneType":I
    :cond_1
    const/4 v1, 0x1

    if-ne v1, v0, :cond_2

    :try_start_1
    const-string v1, "gsm"

    iput-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;

    goto :goto_0

    .end local v0    # "phoneType":I
    :catch_0
    move-exception v1

    goto :goto_1

    .restart local v0    # "phoneType":I
    :cond_2
    const-string v1, "invalid"

    iput-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;

    goto :goto_0

    :cond_3
    const-string v1, "home"

    iput-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRoamingStatus:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method getCurrentAssistDialProperty()Ljava/lang/String;
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "assist_dial"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "isAssistedDialChecked":I
    const/4 v1, 0x1

    if-ne v1, v0, :cond_0

    const-string v1, "assist_on"

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "assist_off"

    goto :goto_0
.end method

.method getCurrentDialingPoint()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .local v0, "dialPoint":I
    :try_start_0
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "assist_dial_from_contact"

    invoke-static {v1, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    :goto_0
    const/4 v1, 0x1

    if-ne v1, v0, :cond_0

    const-string v1, "contact"

    :goto_1
    return-object v1

    :cond_0
    const-string v1, "idle"

    goto :goto_1

    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method getCurrentRadioTech()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRadioTech:Ljava/lang/String;

    return-object v0
.end method

.method getCurrentRoamingStatus()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mCurrentRoamingStatus:Ljava/lang/String;

    return-object v0
.end method

.method getOperatorName()Ljava/lang/String;
    .locals 2

    .prologue
    const-string v0, "ro.build.target_operator"

    const-string v1, ""

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;
    .locals 2

    .prologue
    const-string v0, "AssistedDial"

    const-string v1, "getOtaCountry is called"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mOtaCountry:Lcom/lge/telephony/LGReferenceCountry;

    :goto_0
    return-object v0

    :cond_0
    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryInternal()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->updateOtaCountry(Lcom/lge/telephony/LGReferenceCountry;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    goto :goto_0
.end method

.method getOtaCountryCode()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getOtaIDDPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getOtaNDDPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getRefAreaCode()Ljava/lang/String;
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefAreaCode(Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getRefAreaCode(Z)Ljava/lang/String;
    .locals 4
    .param p1, "isUpdate"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaCode:Ljava/lang/String;

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaCode:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Ref area code is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "area"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "area"

    invoke-static {v0, v1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaCode:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefAreaCode:Ljava/lang/String;

    goto :goto_0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method getRefCountry()Lcom/lge/telephony/LGReferenceCountry;
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry(Z)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    return-object v0
.end method

.method getRefCountry(Z)Lcom/lge/telephony/LGReferenceCountry;
    .locals 5
    .param p1, "isUpdate"    # Z

    .prologue
    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountry:Lcom/lge/telephony/LGReferenceCountry;

    if-eqz v2, :cond_0

    if-nez p1, :cond_0

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountry:Lcom/lge/telephony/LGReferenceCountry;

    :goto_0
    return-object v2

    :cond_0
    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "assist_dial_reference_country"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "refCountryIndex":Ljava/lang/String;
    const-string v2, "AssistedDial"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getRefCountry : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "countryindex = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "where":Ljava/lang/String;
    const-string v2, "AssistedDial"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "WHERE : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCountryWithCondition(Ljava/lang/String;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mRefCountry:Lcom/lge/telephony/LGReferenceCountry;

    goto :goto_0
.end method

.method getRefCountryCode()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getRefIDDPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getRefNDDPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getRefNumLength()Ljava/lang/Integer;
    .locals 3

    .prologue
    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "temp Rlog - ref Num Length : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method getRefPNLength()Ljava/lang/Integer;
    .locals 4

    .prologue
    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "temp Rlog - ref pn length : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountry()Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method isAssistDialPropertyChanged(Ljava/lang/String;)Z
    .locals 1
    .param p1, "mLastAssistDialProperty"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentAssistDialProperty()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method isDialingPointChanged(Ljava/lang/String;)Z
    .locals 1
    .param p1, "mLastDialingPoint"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentDialingPoint()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method isInitialized()Z
    .locals 1

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method isRadioTechChanged(Ljava/lang/String;)Z
    .locals 1
    .param p1, "mLastRadioTech"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method isRoamingStatusChanged(Ljava/lang/String;)Z
    .locals 1
    .param p1, "mLastRoamingStatus"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRoamingStatus()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    iput-object p1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mContext:Landroid/content/Context;

    return-void
.end method

.method public setSIDTable(Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/SIDRangeType;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "table":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/utils/SIDRangeType;>;"
    iput-object p1, p0, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->mSIDTable:Ljava/util/ArrayList;

    return-void
.end method
