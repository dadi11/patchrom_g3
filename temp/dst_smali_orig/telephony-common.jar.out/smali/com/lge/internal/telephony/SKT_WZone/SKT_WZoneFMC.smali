.class public Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;
.super Ljava/lang/Object;
.source "SKT_WZoneFMC.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$1;,
        Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$SKT_WZoneFMCHolder;,
        Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;
    }
.end annotation


# static fields
.field public static final ACTION_EXIT_NAME_ANSWER_VOIP:Ljava/lang/String; = "answer_voip"

.field public static final ACTION_EXIT_NAME_HANGUP_VOIP:Ljava/lang/String; = "hangup_voip"

.field public static final ACTION_EXIT_NAME_MOVETOTOP_VOIP:Ljava/lang/String; = "movetotop_voip"


# instance fields
.field private mActionExtName:Ljava/lang/String;

.field private mPhoneNumber:Ljava/lang/String;

.field private mSActionintent:Ljava/lang/String;

.field private mState:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;->IDLE:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    iput-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mState:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$1;

    .prologue
    invoke-direct {p0}, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$SKT_WZoneFMCHolder;->SKT_WZONEFMC:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;

    return-object v0
.end method


# virtual methods
.method public cleanCurrentVoIP()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mActionExtName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mSActionintent:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mPhoneNumber:Ljava/lang/String;

    sget-object v0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;->IDLE:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    iput-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mState:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    return-void
.end method

.method public getActionExtName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mActionExtName:Ljava/lang/String;

    return-object v0
.end method

.method public getPhoneNumber()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mPhoneNumber:Ljava/lang/String;

    return-object v0
.end method

.method public getSActionintent()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mSActionintent:Ljava/lang/String;

    return-object v0
.end method

.method public getState()Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mState:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    return-object v0
.end method

.method public setCurrentVoIP(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "actionExtName"    # Ljava/lang/String;
    .param p2, "sActionintent"    # Ljava/lang/String;
    .param p3, "PhoneNumber"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mActionExtName:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mSActionintent:Ljava/lang/String;

    iput-object p3, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mPhoneNumber:Ljava/lang/String;

    return-void
.end method

.method public setState(Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;)V
    .locals 0
    .param p1, "s"    # Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    .prologue
    iput-object p1, p0, Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC;->mState:Lcom/lge/internal/telephony/SKT_WZone/SKT_WZoneFMC$State;

    return-void
.end method
