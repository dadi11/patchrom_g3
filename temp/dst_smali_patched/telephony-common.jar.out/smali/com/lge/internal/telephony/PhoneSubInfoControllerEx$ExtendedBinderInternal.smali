.class final Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;
.super Lcom/lge/internal/telephony/IPhoneSubInfoEx$Stub;
.source "PhoneSubInfoControllerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ExtendedBinderInternal"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;


# direct methods
.method private constructor <init>(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    invoke-direct {p0}, Lcom/lge/internal/telephony/IPhoneSubInfoEx$Stub;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;
    .param p2, "x1"    # Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;-><init>(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)V

    return-void
.end method


# virtual methods
.method public getDeviceIdForVZW(I)Ljava/lang/String;
    .locals 2
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$300(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v0

    invoke-virtual {p0, p1, v0, v1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getDeviceIdForVZWUsingSubId(IJ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDeviceIdForVZWUsingSubId(IJ)Ljava/lang/String;
    .locals 4
    .param p1, "type"    # I
    .param p2, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p2, p3}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$400(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getDeviceIdForVZW(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getDeviceIdForVZWUsingSubId phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;
    .locals 6
    .param p1, "setpreferrednetworktype"    # Z
    .param p2, "preferrednetworktype"    # I
    .param p3, "networksignal"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$500(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v4

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    invoke-virtual/range {v0 .. v5}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getDmNodeHandlerDiagMonNetworkSubId(ZIIJ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDmNodeHandlerDiagMonNetworkSubId(ZIIJ)Ljava/lang/String;
    .locals 4
    .param p1, "setpreferrednetworktype"    # Z
    .param p2, "preferrednetworktype"    # I
    .param p3, "networksignal"    # I
    .param p4, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p4, p5}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$600(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getDmNodeHandlerDiagMonNetwork phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getEsn()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$1100(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getEsnUsingSubId(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEsnUsingSubId(J)Ljava/lang/String;
    .locals 5
    .param p1, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p1, p2}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$1200(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getEsn()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getEsnUsingSubId phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMSIN()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$100(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getMSINUsingSubId(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMSINUsingSubId(J)Ljava/lang/String;
    .locals 5
    .param p1, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p1, p2}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$200(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getMSIN()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getMSINUsingSubId phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getTimeFromSIB16String()[J
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$900(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getTimeFromSIB16StringUsingSubId(J)[J

    move-result-object v0

    return-object v0
.end method

.method public getTimeFromSIB16StringUsingSubId(J)[J
    .locals 5
    .param p1, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p1, p2}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$1000(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getTimeFromSIB16String()[J

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getTimeFromSIB16String phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getValueFromSIB16String()[I
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getDefaultSubId()J
    invoke-static {v0}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$700(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;)J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->getValueFromSIB16StringUsingSubId(J)[I

    move-result-object v0

    return-object v0
.end method

.method public getValueFromSIB16StringUsingSubId(J)[I
    .locals 5
    .param p1, "subId"    # J

    .prologue
    iget-object v1, p0, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx$ExtendedBinderInternal;->this$0:Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;

    # invokes: Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->getPhoneSubInfoProxy(J)Lcom/android/internal/telephony/PhoneSubInfoProxy;
    invoke-static {v1, p1, p2}, Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;->access$800(Lcom/lge/internal/telephony/PhoneSubInfoControllerEx;J)Lcom/android/internal/telephony/PhoneSubInfoProxy;

    move-result-object v0

    .local v0, "phoneSubInfoProxy":Lcom/android/internal/telephony/PhoneSubInfoProxy;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneSubInfoProxy;->getValueFromSIB16String()[I

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const-string v1, "PhoneSubInfoControllerEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getValueFromSIB16String phoneSubInfoProxy is null for Subscription:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method
