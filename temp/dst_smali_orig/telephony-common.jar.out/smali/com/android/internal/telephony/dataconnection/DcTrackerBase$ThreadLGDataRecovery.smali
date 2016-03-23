.class public Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;
.super Ljava/lang/Thread;
.source "DcTrackerBase.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "ThreadLGDataRecovery"
.end annotation


# instance fields
.field mLoop:Landroid/os/Looper;

.field private mPhone:Lcom/android/internal/telephony/PhoneBase;

.field private mSUPPORT_LG_DATA_RECOVERY:Z

.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;Lcom/android/internal/telephony/PhoneBase;)V
    .locals 2
    .param p2, "phone"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iput-object p2, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    const-string v0, "persist.telephony.datarecovery"

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mSUPPORT_LG_DATA_RECOVERY:Z

    return-void
.end method


# virtual methods
.method public loopQuit()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mLoop:Landroid/os/Looper;

    invoke-virtual {v0}, Landroid/os/Looper;->quit()V

    return-void
.end method

.method public run()V
    .locals 3

    .prologue
    invoke-static {}, Landroid/os/Looper;->prepare()V

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mLoop:Landroid/os/Looper;

    iget-boolean v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mSUPPORT_LG_DATA_RECOVERY:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    new-instance v1, Lcom/android/internal/telephony/lgdata/LGDataRecovery;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-direct {v1, v2}, Lcom/android/internal/telephony/lgdata/LGDataRecovery;-><init>(Lcom/android/internal/telephony/PhoneBase;)V

    iput-object v1, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mLgDataRecovery:Lcom/android/internal/telephony/lgdata/LGDataRecovery;

    :cond_0
    invoke-static {}, Landroid/os/Looper;->loop()V

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$ThreadLGDataRecovery;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mLgDataRecovery:Lcom/android/internal/telephony/lgdata/LGDataRecovery;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LGDataRecovery;->dispose()V

    return-void
.end method
