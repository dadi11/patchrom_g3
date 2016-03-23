.class public Lcom/movial/ipphone/WifiCallCheckBoxPreference;
.super Landroid/preference/CheckBoxPreference;
.source "WifiCallCheckBoxPreference.java"


# static fields
.field private static final EVENT_IMS_WIFI_STATUS:I = 0x1

.field private static final TAG:Ljava/lang/String; = "WifiCallCheckBoxPreference"


# instance fields
.field private mCellOnly:Z

.field private final mContext:Landroid/content/Context;

.field private mHandler:Landroid/os/Handler;

.field private mPreference:Landroid/preference/Preference;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    const v0, 0x101008f

    invoke-direct {p0, p1, p2, v0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    invoke-direct {p0, p1, p2, p3}, Landroid/preference/CheckBoxPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    new-instance v0, Lcom/movial/ipphone/WifiCallCheckBoxPreference$1;

    invoke-direct {v0, p0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference$1;-><init>(Lcom/movial/ipphone/WifiCallCheckBoxPreference;)V

    iput-object v0, p0, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->mHandler:Landroid/os/Handler;

    iput-object p1, p0, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->mContext:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$000(Lcom/movial/ipphone/WifiCallCheckBoxPreference;)Landroid/preference/Preference;
    .locals 1
    .param p0, "x0"    # Lcom/movial/ipphone/WifiCallCheckBoxPreference;

    .prologue
    iget-object v0, p0, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->mPreference:Landroid/preference/Preference;

    return-object v0
.end method

.method private registerToIPRegistry(Z)V
    .locals 0
    .param p1, "register"    # Z

    .prologue
    return-void
.end method


# virtual methods
.method protected onClick()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/preference/CheckBoxPreference;->onClick()V

    const-string v0, "WifiCallCheckBoxPreference"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onClick. "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->isChecked()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->isChecked()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    iput-boolean v0, p0, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->mCellOnly:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public pause()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->registerToIPRegistry(Z)V

    return-void
.end method

.method public resume()V
    .locals 0

    .prologue
    return-void
.end method

.method public setValues(Landroid/preference/Preference;)V
    .locals 0
    .param p1, "preference"    # Landroid/preference/Preference;

    .prologue
    iput-object p1, p0, Lcom/movial/ipphone/WifiCallCheckBoxPreference;->mPreference:Landroid/preference/Preference;

    return-void
.end method
