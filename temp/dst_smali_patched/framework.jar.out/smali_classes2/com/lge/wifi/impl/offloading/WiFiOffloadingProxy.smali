.class public Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;
.super Ljava/lang/Object;
.source "WiFiOffloadingProxy.java"


# static fields
.field public static final WIFIOFFLOADING_SERVICE:Ljava/lang/String; = "wifioffloading"

.field private static mProxy:Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;


# instance fields
.field public final TAG:Ljava/lang/String;

.field private mService:Lcom/lge/wifi/impl/offloading/IWiFiOffloading;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;->mProxy:Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;

    return-void
.end method

.method public constructor <init>(Lcom/lge/wifi/impl/offloading/IWiFiOffloading;)V
    .locals 2
    .param p1, "service"    # Lcom/lge/wifi/impl/offloading/IWiFiOffloading;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "WiFiOffloadingProxy"

    iput-object v0, p0, Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;->TAG:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;->mService:Lcom/lge/wifi/impl/offloading/IWiFiOffloading;

    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "service is null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iput-object p1, p0, Lcom/lge/wifi/impl/offloading/WiFiOffloadingProxy;->mService:Lcom/lge/wifi/impl/offloading/IWiFiOffloading;

    return-void
.end method
