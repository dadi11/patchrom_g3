.class public Lcom/android/server/ePDGConnInfo;
.super Ljava/lang/Object;
.source "ePDGConnInfo.java"


# instance fields
.field public ConnectedGWAddr:Ljava/lang/String;

.field public mFQDN:Ljava/lang/String;

.field public mIface:Ljava/lang/String;

.field public mIpsecAddr:Ljava/lang/String;

.field public mIpsecGW:Ljava/lang/String;

.field public mdnss:Ljava/lang/String;

.field public mid:I

.field public reason:I

.field public returntype:I


# direct methods
.method public constructor <init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "type"    # I
    .param p2, "fail"    # I
    .param p3, "id"    # I
    .param p4, "GWaddr"    # Ljava/lang/String;
    .param p5, "fqdn"    # Ljava/lang/String;
    .param p6, "ipsec"    # Ljava/lang/String;
    .param p7, "ipif"    # Ljava/lang/String;
    .param p8, "ipsecGW"    # Ljava/lang/String;
    .param p9, "idnss"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    iput p1, p0, Lcom/android/server/ePDGConnInfo;->returntype:I

    iput p2, p0, Lcom/android/server/ePDGConnInfo;->reason:I

    iput-object p4, p0, Lcom/android/server/ePDGConnInfo;->ConnectedGWAddr:Ljava/lang/String;

    iput p3, p0, Lcom/android/server/ePDGConnInfo;->mid:I

    iput-object p5, p0, Lcom/android/server/ePDGConnInfo;->mFQDN:Ljava/lang/String;

    iput-object p6, p0, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iput-object p7, p0, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iput-object p8, p0, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iput-object p9, p0, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    return-void
.end method
