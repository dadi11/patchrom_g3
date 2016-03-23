.class public final Lcom/android/internal/telephony/cat/CatRecover_LGE;
.super Ljava/lang/Object;
.source "CatRecover_LGE.java"


# static fields
.field private static final ID_SET_UP_MENU:I = 0x25

.field private static final PREF_STK_MENU_RECOVER:Ljava/lang/String; = "STK_MENU_RECOVER"

.field private static final PROPERTY_CAT_SERVICE_INIT_DONE:Ljava/lang/String; = "gsm.lge.cat_init_done"


# instance fields
.field private mStkRecoverCmd:Z

.field private mSubId:I

.field private strPrefStkMenuSlot:Ljava/lang/String;

.field private strPropCatInitDoneSlot:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/CommandsInterface;)V
    .locals 2
    .param p1, "mCmdIf"    # Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    iput-boolean v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mStkRecoverCmd:Z

    iput-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPropCatInitDoneSlot:Ljava/lang/String;

    iput-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    invoke-static {p1}, Lcom/lge/uicc/framework/IccTools;->getSlotId(Ljava/lang/Object;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "CatRecover_LGE   Slot Number : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "gsm.lge.cat_init_done"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPropCatInitDoneSlot:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "STK_MENU_RECOVER"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    return-void
.end method

.method private getTypeOfCommand(Ljava/lang/String;)I
    .locals 10
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return v6

    :cond_1
    const/4 v4, 0x0

    .local v4, "rawData":[B
    :try_start_0
    invoke-static {p1}, Lcom/android/internal/telephony/uicc/IccUtils;->hexStringToBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    const/4 v0, 0x0

    .local v0, "berTlv":Lcom/android/internal/telephony/cat/BerTlv;
    :try_start_1
    invoke-static {v4}, Lcom/android/internal/telephony/cat/BerTlv;->decode([B)Lcom/android/internal/telephony/cat/BerTlv;
    :try_end_1
    .catch Lcom/android/internal/telephony/cat/ResultException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/cat/BerTlv;->getTag()I

    move-result v8

    const/16 v9, 0xd0

    if-ne v8, v9, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/cat/BerTlv;->getComprehensionTlvs()Ljava/util/List;

    move-result-object v2

    .local v2, "ctlvs":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/cat/ComprehensionTlv;>;"
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/cat/CatRecover_LGE;->searchForTagOfCmd(Ljava/util/List;)Lcom/android/internal/telephony/cat/ComprehensionTlv;

    move-result-object v1

    .local v1, "ctlvCmdDet":Lcom/android/internal/telephony/cat/ComprehensionTlv;
    const/4 v6, 0x0

    .local v6, "typeOfCommand":I
    if-eqz v1, :cond_0

    :try_start_2
    invoke-virtual {v1}, Lcom/android/internal/telephony/cat/ComprehensionTlv;->getRawValue()[B

    move-result-object v5

    .local v5, "rawValue":[B
    invoke-virtual {v1}, Lcom/android/internal/telephony/cat/ComprehensionTlv;->getValueIndex()I

    move-result v7

    .local v7, "valueIndex":I
    add-int/lit8 v8, v7, 0x1

    aget-byte v8, v5, v8
    :try_end_2
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_2

    and-int/lit16 v6, v8, 0xff

    goto :goto_0

    .end local v0    # "berTlv":Lcom/android/internal/telephony/cat/BerTlv;
    .end local v1    # "ctlvCmdDet":Lcom/android/internal/telephony/cat/ComprehensionTlv;
    .end local v2    # "ctlvs":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/cat/ComprehensionTlv;>;"
    .end local v5    # "rawValue":[B
    .end local v6    # "typeOfCommand":I
    .end local v7    # "valueIndex":I
    :catch_0
    move-exception v3

    .local v3, "e":Ljava/lang/Exception;
    const-string v8, "hexStringToBytes() Error"

    invoke-static {p0, v8}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    .end local v3    # "e":Ljava/lang/Exception;
    .restart local v0    # "berTlv":Lcom/android/internal/telephony/cat/BerTlv;
    :catch_1
    move-exception v3

    .local v3, "e":Lcom/android/internal/telephony/cat/ResultException;
    const-string v8, "BerTlv.decode() Error"

    invoke-static {p0, v8}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    .end local v3    # "e":Lcom/android/internal/telephony/cat/ResultException;
    .restart local v1    # "ctlvCmdDet":Lcom/android/internal/telephony/cat/ComprehensionTlv;
    .restart local v2    # "ctlvs":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/cat/ComprehensionTlv;>;"
    .restart local v6    # "typeOfCommand":I
    :catch_2
    move-exception v3

    .local v3, "e":Ljava/lang/IndexOutOfBoundsException;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "getTypeOfCommand: Failed to procees command details e="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {p0, v8}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private searchForTagOfCmd(Ljava/util/List;)Lcom/android/internal/telephony/cat/ComprehensionTlv;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/cat/ComprehensionTlv;",
            ">;)",
            "Lcom/android/internal/telephony/cat/ComprehensionTlv;"
        }
    .end annotation

    .prologue
    .local p1, "ctlvs":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/cat/ComprehensionTlv;>;"
    const/4 v4, 0x0

    if-nez p1, :cond_0

    move-object v0, v4

    :goto_0
    return-object v0

    :cond_0
    sget-object v2, Lcom/android/internal/telephony/cat/ComprehensionTlvTag;->COMMAND_DETAILS:Lcom/android/internal/telephony/cat/ComprehensionTlvTag;

    .local v2, "tag":Lcom/android/internal/telephony/cat/ComprehensionTlvTag;
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/android/internal/telephony/cat/ComprehensionTlv;>;"
    invoke-virtual {v2}, Lcom/android/internal/telephony/cat/ComprehensionTlvTag;->value()I

    move-result v3

    .local v3, "tagValue":I
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/cat/ComprehensionTlv;

    .local v0, "ctlv":Lcom/android/internal/telephony/cat/ComprehensionTlv;
    invoke-virtual {v0}, Lcom/android/internal/telephony/cat/ComprehensionTlv;->getTag()I

    move-result v5

    if-ne v5, v3, :cond_1

    goto :goto_0

    .end local v0    # "ctlv":Lcom/android/internal/telephony/cat/ComprehensionTlv;
    :cond_2
    move-object v0, v4

    goto :goto_0
.end method


# virtual methods
.method public dispose()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    iput v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mSubId:I

    iput-boolean v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mStkRecoverCmd:Z

    iput-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPropCatInitDoneSlot:Ljava/lang/String;

    iput-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    return-void
.end method

.method protected isStkRecoverCommand(I)Z
    .locals 3
    .param p1, "typeOfCommand"    # I

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    const/16 v2, 0x25

    if-ne p1, v2, :cond_0

    iget-boolean v2, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mStkRecoverCmd:Z

    if-ne v2, v0, :cond_0

    const-string v2, "StkRecoveCmd - Do not send TERMINAL RESPONSE"

    invoke-static {p0, v2}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    iput-boolean v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mStkRecoverCmd:Z

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method protected recoverStkCommands(Lcom/android/internal/telephony/cat/RilMessageDecoder;)V
    .locals 4
    .param p1, "mMsgDecoder"    # Lcom/android/internal/telephony/cat/RilMessageDecoder;

    .prologue
    const-string v1, "1"

    iget-object v2, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPropCatInitDoneSlot:Ljava/lang/String;

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    const-string v2, "None"

    invoke-static {v1, v2}, Lcom/lge/uicc/framework/LGUICC;->getPreference(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "StoredStkMenu":Ljava/lang/String;
    const-string v1, "None"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "Restore SET_UP_MENU command"

    invoke-static {p0, v1}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->mStkRecoverCmd:Z

    new-instance v1, Lcom/android/internal/telephony/cat/RilMessage;

    const/4 v2, 0x2

    invoke-direct {v1, v2, v0}, Lcom/android/internal/telephony/cat/RilMessage;-><init>(ILjava/lang/String;)V

    invoke-virtual {p1, v1}, Lcom/android/internal/telephony/cat/RilMessageDecoder;->sendStartDecodingMessageParams(Lcom/android/internal/telephony/cat/RilMessage;)V

    .end local v0    # "StoredStkMenu":Ljava/lang/String;
    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v1, "This is first creator call. (Normal Initialize)"

    invoke-static {p0, v1}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/uicc/framework/LGUICC;->removePreference(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPropCatInitDoneSlot:Ljava/lang/String;

    const-string v2, "1"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected storeStkCommands(Ljava/lang/String;)V
    .locals 2
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cat/CatRecover_LGE;->getTypeOfCommand(Ljava/lang/String;)I

    move-result v0

    const/16 v1, 0x25

    if-ne v0, v1, :cond_0

    const-string v0, "Store SETUP_MENU Command"

    invoke-static {p0, v0}, Lcom/android/internal/telephony/cat/CatLog;->d(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/cat/CatRecover_LGE;->strPrefStkMenuSlot:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/lge/uicc/framework/LGUICC;->setPreference(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
