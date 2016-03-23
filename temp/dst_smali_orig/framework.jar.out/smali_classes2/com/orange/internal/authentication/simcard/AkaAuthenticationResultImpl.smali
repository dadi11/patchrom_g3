.class public Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;
.super Ljava/lang/Object;
.source "AkaAuthenticationResultImpl.java"

# interfaces
.implements Lcom/orange/authentication/simcard/AkaAuthenticationResult;


# instance fields
.field private ck:[B

.field private ik:[B

.field private kc:[B

.field private res:[B


# direct methods
.method public constructor <init>([B[B[B[B)V
    .locals 0
    .param p1, "res"    # [B
    .param p2, "ck"    # [B
    .param p3, "ik"    # [B
    .param p4, "kc"    # [B

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->res:[B

    iput-object p2, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->ck:[B

    iput-object p3, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->ik:[B

    iput-object p4, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->kc:[B

    return-void
.end method


# virtual methods
.method public getCk()[B
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->ck:[B

    return-object v0
.end method

.method public getIk()[B
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->ik:[B

    return-object v0
.end method

.method public getKc()[B
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->kc:[B

    return-object v0
.end method

.method public getRes()[B
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/orange/internal/authentication/simcard/AkaAuthenticationResultImpl;->res:[B

    return-object v0
.end method
