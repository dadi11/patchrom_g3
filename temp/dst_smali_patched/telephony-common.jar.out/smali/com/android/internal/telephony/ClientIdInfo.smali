.class Lcom/android/internal/telephony/ClientIdInfo;
.super Ljava/lang/Object;
.source "ClientIdItem.java"


# instance fields
.field private clientidbase:Ljava/lang/String;

.field private clientidbase_am:Ljava/lang/String;

.field private clientidbase_gmm:Ljava/lang/String;

.field private clientidbase_ms:Ljava/lang/String;

.field private clientidbase_yt:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_ms:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_am:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_gmm:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_yt:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getClientidbase()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase:Ljava/lang/String;

    return-object v0
.end method

.method public getClientidbase_am()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_am:Ljava/lang/String;

    return-object v0
.end method

.method public getClientidbase_gmm()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_gmm:Ljava/lang/String;

    return-object v0
.end method

.method public getClientidbase_ms()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_ms:Ljava/lang/String;

    return-object v0
.end method

.method public getClientidbase_yt()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_yt:Ljava/lang/String;

    return-object v0
.end method

.method public setClientidbase(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientidbase"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase:Ljava/lang/String;

    return-void
.end method

.method public setClientidbase_am(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientidbase_am"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_am:Ljava/lang/String;

    return-void
.end method

.method public setClientidbase_gmm(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientidbase_gmm"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_gmm:Ljava/lang/String;

    return-void
.end method

.method public setClientidbase_ms(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientidbase_ms"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_ms:Ljava/lang/String;

    return-void
.end method

.method public setClientidbase_yt(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientidbase_yt"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdInfo;->clientidbase_yt:Ljava/lang/String;

    return-void
.end method
