.class public Lcom/android/internal/telephony/LGPhoneInterfaceManager;
.super Lcom/android/internal/telephony/ILGTelephony$Stub;
.source "LGPhoneInterfaceManager.java"


# static fields
.field private static final DBG:Z = true

.field public static final EVENT_EPDG_SETUP_DATA_CALL:I = 0x2

.field public static final LISTEN_SETUP_DATA_CALL_RSP_PARAM:I = 0x1

.field private static final LOG_TAG:Ljava/lang/String; = "LGPhoneInterfaceManager"

.field private static sInstance:Lcom/android/internal/telephony/LGPhoneInterfaceManager;


# instance fields
.field mMyRil:Lcom/android/internal/telephony/RIL;

.field mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

.field mPhone:Lcom/android/internal/telephony/Phone;

.field public myfeature:I


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/Phone;Lcom/android/internal/telephony/RIL;Landroid/content/Context;)V
    .locals 2
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p2, "myril"    # Lcom/android/internal/telephony/RIL;
    .param p3, "con"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/ILGTelephony$Stub;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->myfeature:I

    iput-object p1, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mPhone:Lcom/android/internal/telephony/Phone;

    iput-object p2, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v0

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->myfeature:I

    iget v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->myfeature:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_1

    :cond_0
    new-instance v0, Lcom/android/internal/telephony/ePDGinterface;

    iget-object v1, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-direct {v0, p2, v1, p3}, Lcom/android/internal/telephony/ePDGinterface;-><init>(Lcom/android/internal/telephony/RIL;Lcom/android/internal/telephony/Phone;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

    :cond_1
    invoke-direct {p0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->publish()V

    return-void
.end method

.method static init(Lcom/android/internal/telephony/Phone;Lcom/android/internal/telephony/RIL;Landroid/content/Context;)Lcom/android/internal/telephony/LGPhoneInterfaceManager;
    .locals 4
    .param p0, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p1, "myril"    # Lcom/android/internal/telephony/RIL;
    .param p2, "con"    # Landroid/content/Context;

    .prologue
    const-class v1, Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->sInstance:Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    if-nez v0, :cond_0

    new-instance v0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    invoke-direct {v0, p0, p1, p2}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;-><init>(Lcom/android/internal/telephony/Phone;Lcom/android/internal/telephony/RIL;Landroid/content/Context;)V

    sput-object v0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->sInstance:Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    :goto_0
    sget-object v0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->sInstance:Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    monitor-exit v1

    return-object v0

    :cond_0
    const-string v0, "LGPhoneInterfaceManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "init() called multiple times!    sInstance = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->sInstance:Lcom/android/internal/telephony/LGPhoneInterfaceManager;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private log(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGPhoneInterfaceManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[JPhoneMgr] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private publish()V
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "publish: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    const-string v0, "Jphone"

    invoke-static {v0, p0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    return-void
.end method


# virtual methods
.method public checkDataProfileEx(II)Z
    .locals 1
    .param p1, "type"    # I
    .param p2, "Q_IPv"    # I

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public ePDGDeactivateDataCall(Ljava/lang/String;II)V
    .locals 5
    .param p1, "apntype"    # Ljava/lang/String;
    .param p2, "cid"    # I
    .param p3, "reason"    # I

    .prologue
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[ePDG] ePDGDeactivateDataCall start "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    const-string v3, "ims"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget v3, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->myfeature:I

    const/4 v4, 0x1

    if-ne v3, v4, :cond_1

    iget-object v2, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v2, Lcom/android/internal/telephony/PhoneProxy;

    .local v2, "myPhone":Lcom/android/internal/telephony/PhoneProxy;
    iget-object v0, v2, Lcom/android/internal/telephony/PhoneProxy;->mActivePhone:Lcom/android/internal/telephony/Phone;

    check-cast v0, Lcom/android/internal/telephony/PhoneBase;

    .local v0, "myBasePhone":Lcom/android/internal/telephony/PhoneBase;
    iget-object v1, v0, Lcom/android/internal/telephony/PhoneBase;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .local v1, "myDctracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    if-nez v1, :cond_0

    const-string v3, "[ePDG] myDctracker=null"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    .end local v0    # "myBasePhone":Lcom/android/internal/telephony/PhoneBase;
    .end local v1    # "myDctracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    .end local v2    # "myPhone":Lcom/android/internal/telephony/PhoneProxy;
    :goto_0
    return-void

    .restart local v0    # "myBasePhone":Lcom/android/internal/telephony/PhoneBase;
    .restart local v1    # "myDctracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    .restart local v2    # "myPhone":Lcom/android/internal/telephony/PhoneProxy;
    :cond_0
    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setIMSteardown()V

    goto :goto_0

    .end local v0    # "myBasePhone":Lcom/android/internal/telephony/PhoneBase;
    .end local v1    # "myDctracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    .end local v2    # "myPhone":Lcom/android/internal/telephony/PhoneProxy;
    :cond_1
    iget-object v3, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

    const/4 v4, 0x0

    invoke-virtual {v3, p1, p2, p3, v4}, Lcom/android/internal/telephony/ePDGinterface;->ePDGDeactivateDataCall(Ljava/lang/String;IILandroid/os/Message;)V

    goto :goto_0
.end method

.method public ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "radioTechnology"    # Ljava/lang/String;
    .param p2, "profile"    # Ljava/lang/String;
    .param p3, "apntype"    # Ljava/lang/String;
    .param p4, "user"    # Ljava/lang/String;
    .param p5, "password"    # Ljava/lang/String;
    .param p6, "authType"    # Ljava/lang/String;
    .param p7, "protocol"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0, p3}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->getDPfromtype(Ljava/lang/String;)Lcom/android/internal/telephony/dataconnection/ApnSetting;

    move-result-object v9

    .local v9, "apnSetting":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    if-nez v9, :cond_0

    const-string v0, "[ePDG] setup_data_call fail cause apn is null "

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG] setup_data_call success get dp"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v9}, Lcom/android/internal/telephony/dataconnection/ApnSetting;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

    iget-object v3, v9, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    iget-object v7, v9, Lcom/android/internal/telephony/dataconnection/ApnSetting;->protocol:Ljava/lang/String;

    move-object v1, p1

    move-object v2, p2

    move-object v4, p4

    move-object v5, p5

    move-object/from16 v6, p6

    move-object v8, p3

    invoke-virtual/range {v0 .. v8}, Lcom/android/internal/telephony/ePDGinterface;->ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, v9, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    goto :goto_0
.end method

.method public getAPNList()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "publish: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getAPNList()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public getDPfromtype(Ljava/lang/String;)Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .locals 5
    .param p1, "apntype"    # Ljava/lang/String;

    .prologue
    iget-object v3, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v3, Lcom/android/internal/telephony/PhoneProxy;

    .local v3, "myPhone":Lcom/android/internal/telephony/PhoneProxy;
    iget-object v1, v3, Lcom/android/internal/telephony/PhoneProxy;->mActivePhone:Lcom/android/internal/telephony/Phone;

    check-cast v1, Lcom/android/internal/telephony/PhoneBase;

    .local v1, "myBasePhone":Lcom/android/internal/telephony/PhoneBase;
    iget-object v2, v1, Lcom/android/internal/telephony/PhoneBase;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .local v2, "myDctracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    if-nez v2, :cond_0

    const-string v4, "[ePDG] myDctracker=null"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {v2, p1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getDPbyType(Ljava/lang/String;)Lcom/android/internal/telephony/dataconnection/ApnSetting;

    move-result-object v0

    .local v0, "apnSetting":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    goto :goto_0
.end method

.method public getDebugInfo(II)[I
    .locals 1
    .param p1, "infotype"    # I
    .param p2, "itemnum"    # I

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getPcscfAddress(ILjava/lang/String;)V
    .locals 2
    .param p1, "cid"    # I
    .param p2, "ipv"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getPcscfAddress: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ipv :"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/ePDGinterface;->getPcscfAddress(ILjava/lang/String;)V

    return-void
.end method

.method public setePDGsetprefTest(Ljava/lang/String;I)V
    .locals 4
    .param p1, "apntype"    # Ljava/lang/String;
    .param p2, "data_pref"    # I

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setePDGsetprefTest: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->getDPfromtype(Ljava/lang/String;)Lcom/android/internal/telephony/dataconnection/ApnSetting;

    move-result-object v0

    .local v0, "apnSetting":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    if-nez v0, :cond_0

    const-string v1, "[ePDG] setePDGsetprefTest fail cause apn is null "

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/LGPhoneInterfaceManager;->mMyePDGinterface:Lcom/android/internal/telephony/ePDGinterface;

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p2, v3}, Lcom/android/internal/telephony/ePDGinterface;->setePDGsetprefTest(Ljava/lang/String;ILandroid/os/Message;)V

    goto :goto_0
.end method
