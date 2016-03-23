.class public Lcom/android/internal/telephony/ClientIdItem;
.super Ljava/lang/Object;
.source "ClientIdItem.java"


# instance fields
.field private clientid:Lcom/android/internal/telephony/ClientIdInfo;

.field private mccmnc:Ljava/lang/String;

.field private mvno_match_data:Ljava/lang/String;

.field private mvno_type:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->clientid:Lcom/android/internal/telephony/ClientIdInfo;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/ClientIdInfo;)V
    .locals 1
    .param p1, "mccmnc"    # Ljava/lang/String;
    .param p2, "mvno_type"    # Ljava/lang/String;
    .param p3, "mvno_match_data"    # Ljava/lang/String;
    .param p4, "clientid"    # Lcom/android/internal/telephony/ClientIdInfo;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->clientid:Lcom/android/internal/telephony/ClientIdInfo;

    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    iput-object p2, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    iput-object p3, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    iput-object p4, p0, Lcom/android/internal/telephony/ClientIdItem;->clientid:Lcom/android/internal/telephony/ClientIdInfo;

    return-void
.end method


# virtual methods
.method public getClientid()Lcom/android/internal/telephony/ClientIdInfo;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->clientid:Lcom/android/internal/telephony/ClientIdInfo;

    return-object v0
.end method

.method public getMccmnc()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    return-object v0
.end method

.method public getMvno_match_data()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    return-object v0
.end method

.method public getMvno_type()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    return-object v0
.end method

.method public setClientid(Lcom/android/internal/telephony/ClientIdInfo;)V
    .locals 0
    .param p1, "clientid"    # Lcom/android/internal/telephony/ClientIdInfo;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdItem;->clientid:Lcom/android/internal/telephony/ClientIdInfo;

    return-void
.end method

.method public setMccmnc(Ljava/lang/String;)V
    .locals 0
    .param p1, "mccmnc"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    return-void
.end method

.method public setMvno_match_data(Ljava/lang/String;)V
    .locals 0
    .param p1, "mvno_match_data"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    return-void
.end method

.method public setMvno_type(Ljava/lang/String;)V
    .locals 0
    .param p1, "mvno_type"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ClientIdItem [mccmnc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ClientIdItem;->mccmnc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mvno_type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mvno_match_data="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ClientIdItem;->mvno_match_data:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
