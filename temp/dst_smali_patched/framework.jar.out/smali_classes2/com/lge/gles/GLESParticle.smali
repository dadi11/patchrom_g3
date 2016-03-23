.class public Lcom/lge/gles/GLESParticle;
.super Ljava/lang/Object;
.source "GLESParticle.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESParticle"


# instance fields
.field public mAlpha:F

.field public mDurationInMS:J

.field public mIndex:I

.field public mIsSetDefaultValue:Z

.field public mPosX:F

.field public mPosY:F

.field public mPosZ:F

.field public mSize:F

.field public mVecX:F

.field public mVecY:F

.field public mVelocityX:F

.field public mVelocityY:F


# direct methods
.method public constructor <init>(I)V
    .locals 3
    .param p1, "index"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v2, p0, Lcom/lge/gles/GLESParticle;->mIndex:I

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosZ:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mSize:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mAlpha:F

    iput-boolean v2, p0, Lcom/lge/gles/GLESParticle;->mIsSetDefaultValue:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/gles/GLESParticle;->mDurationInMS:J

    iput p1, p0, Lcom/lge/gles/GLESParticle;->mIndex:I

    iput-boolean v2, p0, Lcom/lge/gles/GLESParticle;->mIsSetDefaultValue:Z

    return-void
.end method

.method public constructor <init>(ILcom/lge/gles/GLESParticle;)V
    .locals 2
    .param p1, "index"    # I
    .param p2, "defaultParticle"    # Lcom/lge/gles/GLESParticle;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v1, p0, Lcom/lge/gles/GLESParticle;->mIndex:I

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosZ:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mSize:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mAlpha:F

    iput-boolean v1, p0, Lcom/lge/gles/GLESParticle;->mIsSetDefaultValue:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/gles/GLESParticle;->mDurationInMS:J

    iput p1, p0, Lcom/lge/gles/GLESParticle;->mIndex:I

    invoke-virtual {p0, p2}, Lcom/lge/gles/GLESParticle;->copy(Lcom/lge/gles/GLESParticle;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticle;->mIsSetDefaultValue:Z

    return-void
.end method


# virtual methods
.method public copy(Lcom/lge/gles/GLESParticle;)V
    .locals 1
    .param p1, "particle"    # Lcom/lge/gles/GLESParticle;

    .prologue
    iget v0, p1, Lcom/lge/gles/GLESParticle;->mPosX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosX:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mPosY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosY:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mPosZ:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mPosZ:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mSize:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mSize:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mVecX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecX:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mVecY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVecY:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mVelocityX:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityX:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mVelocityY:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mVelocityY:F

    iget v0, p1, Lcom/lge/gles/GLESParticle;->mAlpha:F

    iput v0, p0, Lcom/lge/gles/GLESParticle;->mAlpha:F

    return-void
.end method

.method public setAlpha(F)V
    .locals 0
    .param p1, "alpha"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticle;->mAlpha:F

    return-void
.end method

.method public setDirection(FF)V
    .locals 0
    .param p1, "vecX"    # F
    .param p2, "vecY"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticle;->mVecX:F

    iput p2, p0, Lcom/lge/gles/GLESParticle;->mVecY:F

    return-void
.end method

.method public setPosition(FFF)V
    .locals 0
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "z"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticle;->mPosX:F

    iput p2, p0, Lcom/lge/gles/GLESParticle;->mPosY:F

    iput p3, p0, Lcom/lge/gles/GLESParticle;->mPosZ:F

    return-void
.end method

.method public setSize(F)V
    .locals 0
    .param p1, "size"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticle;->mSize:F

    return-void
.end method

.method public setVelocity(FF)V
    .locals 0
    .param p1, "velX"    # F
    .param p2, "velY"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticle;->mVelocityX:F

    iput p2, p0, Lcom/lge/gles/GLESParticle;->mVelocityY:F

    return-void
.end method
