.class public abstract Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;
.super Landroid/os/Binder;
.source "ZdiRecommendConnector.java"

# interfaces
.implements Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

.field static final TRANSACTION_checkZdiRecommend:I = 0x1

.field static final TRANSACTION_getGlobalRecApp:I = 0x2

.field static final TRANSACTION_getGlobalRecPairApp:I = 0x4

.field static final TRANSACTION_getIndividualRecApp:I = 0x3

.field static final TRANSACTION_getRecAppList:I = 0x7

.field static final TRANSACTION_getRecentPairApp:I = 0x5

.field static final TRANSACTION_getRecentlyUsedApp:I = 0x6


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p0, p0, v0}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;
    .locals 2
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    const-string v1, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-interface {p0, v1}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    .local v0, "iin":Landroid/os/IInterface;
    if-eqz v0, :cond_1

    instance-of v1, v0, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v1, :cond_1

    check-cast v0, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub$Proxy;

    .end local v0    # "iin":Landroid/os/IInterface;
    invoke-direct {v0, p0}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    goto :goto_0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .locals 0

    .prologue
    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 12
    .param p1, "code"    # I
    .param p2, "data"    # Landroid/os/Parcel;
    .param p3, "reply"    # Landroid/os/Parcel;
    .param p4, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    sparse-switch p1, :sswitch_data_0

    invoke-super/range {p0 .. p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v0

    :goto_0
    return v0

    :sswitch_0
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    const/4 v0, 0x1

    goto :goto_0

    :sswitch_1
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->checkZdiRecommend()Z

    move-result v10

    .local v10, "_result":Z
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    if-eqz v10, :cond_0

    const/4 v0, 0x1

    :goto_1
    invoke-virtual {p3, v0}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    .end local v10    # "_result":Z
    :sswitch_2
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .local v7, "_arg0":I
    invoke-virtual {p0, v7}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getGlobalRecApp(I)Ljava/util/List;

    move-result-object v11

    .local v11, "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v11}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto :goto_0

    .end local v7    # "_arg0":I
    .end local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    :sswitch_3
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .local v7, "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .local v8, "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .local v9, "_arg2":I
    invoke-virtual {p0, v7, v8, v9}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getIndividualRecApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;

    move-result-object v11

    .restart local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v11}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto :goto_0

    .end local v7    # "_arg0":Ljava/lang/String;
    .end local v8    # "_arg1":Ljava/lang/String;
    .end local v9    # "_arg2":I
    .end local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    :sswitch_4
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .restart local v7    # "_arg0":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v8

    .restart local v8    # "_arg1":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v9

    .restart local v9    # "_arg2":I
    invoke-virtual {p0, v7, v8, v9}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getGlobalRecPairApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;

    move-result-object v11

    .restart local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v11}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto :goto_0

    .end local v7    # "_arg0":Ljava/lang/String;
    .end local v8    # "_arg1":Ljava/lang/String;
    .end local v9    # "_arg2":I
    .end local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    :sswitch_5
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .local v7, "_arg0":I
    invoke-virtual {p0, v7}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getRecentPairApp(I)Ljava/util/List;

    move-result-object v11

    .restart local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v11}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto/16 :goto_0

    .end local v7    # "_arg0":I
    .end local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    :sswitch_6
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/os/Parcel;->readInt()I

    move-result v7

    .restart local v7    # "_arg0":I
    invoke-virtual {p0, v7}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getRecentlyUsedApp(I)Ljava/util/List;

    move-result-object v11

    .restart local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v11}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto/16 :goto_0

    .end local v7    # "_arg0":I
    .end local v11    # "_result":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    :sswitch_7
    const-string v0, "com.lge.zdi.recommender.binder.ZdiRecommendConnector"

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    sget-object v0, Lcom/lge/zdi/recommender/common/RankedApp;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v1

    .local v1, "_arg0":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    sget-object v0, Lcom/lge/zdi/recommender/common/RankedApp;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v2

    .local v2, "_arg1":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    sget-object v0, Lcom/lge/zdi/recommender/common/RankedApp;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v3

    .local v3, "_arg2":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    sget-object v0, Lcom/lge/zdi/recommender/common/RankedApp;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-virtual {p2, v0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;

    move-result-object v4

    .local v4, "_arg3":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v5

    .local v5, "_arg4":Ljava/lang/String;
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v6

    .local v6, "_arg5":Ljava/lang/String;
    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector$Stub;->getRecAppList(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    invoke-virtual {p3, v1}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    invoke-virtual {p3, v2}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    invoke-virtual {p3, v3}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    invoke-virtual {p3, v4}, Landroid/os/Parcel;->writeTypedList(Ljava/util/List;)V

    const/4 v0, 0x1

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_2
        0x3 -> :sswitch_3
        0x4 -> :sswitch_4
        0x5 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_7
        0x5f4e5446 -> :sswitch_0
    .end sparse-switch
.end method
