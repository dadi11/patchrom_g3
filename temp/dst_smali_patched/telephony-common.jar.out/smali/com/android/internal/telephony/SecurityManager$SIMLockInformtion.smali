.class public Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;
.super Ljava/lang/Object;
.source "SecurityManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/SecurityManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "SIMLockInformtion"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;
    }
.end annotation


# instance fields
.field public corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

.field public country:I

.field public network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

.field public networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

.field public operator:I

.field public serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

.field public sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

.field final synthetic this$0:Lcom/android/internal/telephony/SecurityManager;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/SecurityManager;)V
    .locals 1

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->this$0:Lcom/android/internal/telephony/SecurityManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;-><init>(Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;-><init>(Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;-><init>(Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;-><init>(Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    new-instance v0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;-><init>(Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    return-void
.end method
