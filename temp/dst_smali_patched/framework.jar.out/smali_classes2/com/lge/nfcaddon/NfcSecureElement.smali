.class public final Lcom/lge/nfcaddon/NfcSecureElement;
.super Ljava/lang/Object;
.source "NfcSecureElement.java"


# static fields
.field public static final ALL_SE_ID:Ljava/lang/String; = "com.nxp.all_se.ID"

.field public static final ALL_SE_ID_TYPE:I = 0x3

.field public static final HOST_ID:Ljava/lang/String; = "com.nxp.host.ID"

.field public static final HOST_ID_TYPE:I = 0x0

.field public static final SMART_MX_ID:Ljava/lang/String; = "com.nxp.smart_mx.ID"

.field public static final SMART_MX_ID_TYPE:I = 0x1

.field private static final TAG:Ljava/lang/String; = "NfcSecureElement"

.field public static final UICC_ID:Ljava/lang/String; = "com.nxp.uicc.ID"

.field public static final UICC_ID_TYPE:I = 0x2


# instance fields
.field private mService:Lcom/lge/nfcaddon/INfcSecureElement;


# direct methods
.method public constructor <init>(Lcom/lge/nfcaddon/INfcSecureElement;)V
    .locals 0
    .param p1, "mSecureElementService"    # Lcom/lge/nfcaddon/INfcSecureElement;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    return-void
.end method


# virtual methods
.method public activeSwp()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcSecureElement;->getDefaultSelectedSecureElement()Ljava/lang/String;

    move-result-object v1

    .local v1, "seID":Ljava/lang/String;
    const-string v2, "com.nxp.uicc.ID"

    invoke-virtual {v1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "UICC is not selected"

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcSecureElement;->activeSwp()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcSecureElement"

    const-string v3, "activeSwp failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "activeSwp failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public closeSecureElementConnection(I)V
    .locals 4
    .param p1, "handle"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcSecureElement;->closeSecureElementConnection(I)I

    move-result v1

    .local v1, "status":I
    invoke-static {v1}, Landroid/nfc/ErrorCodes;->isError(I)Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Error during the conection close"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "status":I
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcSecureElement"

    const-string v3, "RemoteException in closeSecureElement(): "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "RemoteException in closeSecureElement()"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Landroid/os/RemoteException;
    .restart local v1    # "status":I
    :cond_0
    return-void
.end method

.method public deSelectedSecureElement()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcSecureElement;->deselectSecureElement()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "NfcSecureElement"

    const-string v2, "deselectSecureElement failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v1, Ljava/io/IOException;

    const-string v2, "deselectSecureElement failed"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public exchangeAPDU(I[B)[B
    .locals 4
    .param p1, "handle"    # I
    .param p2, "data"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2, p1, p2}, Lcom/lge/nfcaddon/INfcSecureElement;->exchangeAPDU(I[B)[B

    move-result-object v1

    .local v1, "response":[B
    if-nez v1, :cond_0

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Exchange APDU failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "response":[B
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcSecureElement"

    const-string v3, "RemoteException in exchangeAPDU(): "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "RemoteException in exchangeAPDU()"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Landroid/os/RemoteException;
    .restart local v1    # "response":[B
    :cond_0
    return-object v1
.end method

.method public getDefaultSelectedSecureElement()Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .local v1, "seID":I
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcSecureElement;->getSelectedSecureElement()I

    move-result v1

    const v2, 0xabcdf0

    if-ne v1, v2, :cond_0

    const-string v2, "com.nxp.uicc.ID"

    :goto_0
    return-object v2

    :cond_0
    const v2, 0xabcdef

    if-ne v1, v2, :cond_1

    const-string v2, "com.nxp.smart_mx.ID"

    goto :goto_0

    :cond_1
    new-instance v2, Ljava/io/IOException;

    const-string v3, "No Secure Element selected"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcSecureElement"

    const-string v3, "getSelectedSecureElement failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "getSelectedSecureElement failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public getSecureElementTechList(I)[I
    .locals 3
    .param p1, "handle"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    :try_start_0
    iget-object v1, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v1, p1}, Lcom/lge/nfcaddon/INfcSecureElement;->getSecureElementTechList(I)[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "NfcSecureElement"

    const-string v2, "RemoteException in getSecureElementTechList(): "

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v1, Ljava/io/IOException;

    const-string v2, "RemoteException in getSecureElementTechList()"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getSecureElementUid(I)[B
    .locals 4
    .param p1, "handle"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .local v1, "uid":[B
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcSecureElement;->getSecureElementUid(I)[B

    move-result-object v1

    if-nez v1, :cond_0

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Get Secure Element UID failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcSecureElement"

    const-string v3, "RemoteException in getSecureElementUid(): "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "RemoteException in getSecureElementUid()"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    return-object v1
.end method

.method public openSecureElementConnection(Ljava/lang/String;)I
    .locals 4
    .param p1, "seType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-string v2, "com.nxp.smart_mx.ID"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcSecureElement;->openSecureElementConnection()I

    move-result v1

    .local v1, "handle":I
    if-eqz v1, :cond_0

    return v1

    :cond_0
    new-instance v2, Ljava/io/IOException;

    const-string v3, "SmartMX connection not allowed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "handle":I
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcSecureElement"

    const-string v3, "RemoteException in openSecureElementConnection(): "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "RemoteException in openSecureElementConnection()"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const-string v2, "com.nxp.uicc.ID"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/io/IOException;

    const-string v3, "UICC connection not supported"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_2
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Unknown Secure Element type"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public openSecureElementConnectionForTTIA(Ljava/lang/String;I)I
    .locals 4
    .param p1, "seType"    # Ljava/lang/String;
    .param p2, "mode"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-string v2, "com.nxp.smart_mx.ID"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    if-nez v2, :cond_0

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Service is null"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2, p2}, Lcom/lge/nfcaddon/INfcSecureElement;->openSecureElementConnectionForTTIA(I)I

    move-result v1

    .local v1, "handle":I
    if-eqz v1, :cond_1

    .end local v1    # "handle":I
    :goto_0
    return v1

    .restart local v1    # "handle":I
    :cond_1
    new-instance v2, Ljava/io/IOException;

    const-string v3, "SmartMX connection not allowed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .end local v1    # "handle":I
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v2, "NfcSecureElement"

    const-string v3, "RemoteException in openSecureElementConnection(): "

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "RemoteException in openSecureElementConnection()"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v1, -0x1

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    const-string v2, "com.nxp.uicc.ID"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    new-instance v2, Ljava/io/IOException;

    const-string v3, "UICC connection not supported"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_3
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Unknown Secure Element type"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public selectDefaultSecureElement(Ljava/lang/String;)V
    .locals 7
    .param p1, "seId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .local v2, "seID":I
    const/4 v4, 0x0

    .local v4, "seSelected":Z
    const-string v5, "com.nxp.uicc.ID"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    const/4 v2, 0x2

    :goto_0
    :try_start_0
    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5}, Lcom/lge/nfcaddon/INfcSecureElement;->getSelectedSecureElement()I

    move-result v5

    if-eq v5, v2, :cond_0

    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5}, Lcom/lge/nfcaddon/INfcSecureElement;->deselectSecureElement()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :try_start_1
    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5}, Lcom/lge/nfcaddon/INfcSecureElement;->getSecureElementList()[I

    move-result-object v3

    .local v3, "seList":[I
    array-length v5, v3

    if-eqz v5, :cond_4

    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    array-length v5, v3

    if-ge v1, v5, :cond_4

    aget v5, v3, v1

    if-ne v5, v2, :cond_1

    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5, v2}, Lcom/lge/nfcaddon/INfcSecureElement;->selectSecureElement(I)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    const/4 v4, 0x1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .end local v1    # "i":I
    .end local v3    # "seList":[I
    :cond_2
    const-string v5, "com.nxp.smart_mx.ID"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    const/4 v2, 0x1

    goto :goto_0

    :cond_3
    const-string v5, "NfcSecureElement"

    const-string v6, "selectDefaultSecureElement: wrong Secure Element ID"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v5, Ljava/io/IOException;

    const-string v6, "selectDefaultSecureElement failed: Wrong Secure Element ID"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v5, "NfcSecureElement"

    const-string v6, "selectDefaultSecureElement: getSelectedSecureElement failed"

    invoke-static {v5, v6, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v5, Ljava/io/IOException;

    const-string v6, "Failure in deselecting the selected Secure Element"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v3    # "seList":[I
    :cond_4
    if-nez v4, :cond_5

    :try_start_2
    const-string v5, "com.nxp.uicc.ID"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5, v2}, Lcom/lge/nfcaddon/INfcSecureElement;->storeSePreference(I)V

    new-instance v5, Ljava/io/IOException;

    const-string v6, "UICC not detected"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .end local v3    # "seList":[I
    :catch_1
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    const-string v5, "NfcSecureElement"

    const-string v6, "selectUiccCardEmulation: getSecureElementList failed"

    invoke-static {v5, v6, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_5
    return-void

    .restart local v3    # "seList":[I
    :cond_6
    :try_start_3
    const-string v5, "com.nxp.smart_mx.ID"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    iget-object v5, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v5, v2}, Lcom/lge/nfcaddon/INfcSecureElement;->storeSePreference(I)V

    new-instance v5, Ljava/io/IOException;

    const-string v6, "SMART_MX not detected"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
.end method

.method public setDefaultSecureElementState(Z)V
    .locals 4
    .param p1, "state"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .local v1, "seID":I
    :try_start_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcSecureElement;->getSelectedSecureElement()I

    move-result v1

    if-nez v1, :cond_0

    new-instance v2, Ljava/io/IOException;

    const-string v3, "No Secure Element selected"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcSecureElement"

    const-string v3, "getSelectedSecureElement failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "getSelectedSecureElement failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    if-eqz p1, :cond_1

    :try_start_1
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    const/4 v3, 0x1

    invoke-interface {v2, v3}, Lcom/lge/nfcaddon/INfcSecureElement;->setSecureElementState(Z)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_0
    return-void

    :catch_1
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    :try_start_2
    const-string v2, "NfcSecureElement"

    const-string v3, "Enable card emulation failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Enable card emulation failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :try_start_3
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    const/4 v3, 0x0

    invoke-interface {v2, v3}, Lcom/lge/nfcaddon/INfcSecureElement;->setSecureElementState(Z)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_0

    :catch_2
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    :try_start_4
    const-string v2, "NfcSecureElement"

    const-string v3, "Disable card emulation failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "Disable card emulation failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
.end method

.method public setSecureElementStateForTTIA(I)I
    .locals 5
    .param p1, "mode"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    :try_start_0
    const-string v2, "NfcSecureElement"

    const-string v3, "In setSecureElementStateForTTIA in NfcSecureElement"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/nfcaddon/NfcSecureElement;->mService:Lcom/lge/nfcaddon/INfcSecureElement;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcSecureElement;->setSecureElementStateForTTIA(I)I

    move-result v1

    .local v1, "status":I
    const-string v2, "NfcSecureElement"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "In setSecureElementStateForTTIA in NfcSecureElement. status : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .end local v1    # "status":I
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcSecureElement"

    const-string v3, "setSecureElementStateForTTIA failed"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/io/IOException;

    const-string v3, "setSecureElementStateForTTIA failed"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method
