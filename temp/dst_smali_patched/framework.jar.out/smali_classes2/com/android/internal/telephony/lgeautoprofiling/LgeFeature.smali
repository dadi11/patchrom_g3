.class public Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;
.super Ljava/lang/Object;
.source "LgeFeature.java"

# interfaces
.implements Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfilingConstants;


# static fields
.field private static final DBG:Z = true

.field private static final EDBG:Z = true

.field private static final VDBG:Z = true

.field private static instance:Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mFeature:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    return-void
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->instance:Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    if-nez v0, :cond_0

    new-instance v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->instance:Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    :goto_0
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->instance:Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    return-object v0

    :cond_0
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->instance:Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->setContext(Landroid/content/Context;)V

    goto :goto_0
.end method

.method private loadFeatureFromPreferences()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    const-string v3, "feature"

    invoke-virtual {v2, v3, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .local v0, "preferences":Landroid/content/SharedPreferences;
    const-string v2, "init"

    const/4 v3, 0x0

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    const-string v2, "TelephonyAutoProfiling"

    const-string v3, "[loadFeatureFromPreferences] preferences do not exist"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;

    iput-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    const-string v2, "init"

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    const-string v1, "TelephonyAutoProfiling"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[loadFeatureFromPreferences] load from preferences complete - "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    goto :goto_0
.end method

.method private loadFeatureFromXml()V
    .locals 5

    .prologue
    const-string v2, "TelephonyAutoProfiling"

    const-string v3, "[loadFeatureFromXml] *** start feature loading from xml"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser;

    invoke-direct {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser;-><init>()V

    .local v1, "parser":Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser;
    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser;->getMatchedProfile(ILcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;)Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser$ProfileData;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser$NameValueProfile;

    .local v0, "featureFromXml":Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser$NameValueProfile;
    if-nez v0, :cond_0

    const-string v2, "TelephonyAutoProfiling"

    const-string v3, "[loadFeatureFromXml] load feature from xml failed"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser;->profileToMap(Lcom/android/internal/telephony/lgeautoprofiling/LgeProfileParser$NameValueProfile;)Ljava/util/HashMap;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    if-eqz v2, :cond_1

    :cond_1
    const-string v2, "TelephonyAutoProfiling"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[loadFeatureFromXml] load feature from xml complete : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private saveFeatureToPreferences(Ljava/util/HashMap;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "featureMap":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v3, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    const-string v4, "feature"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v3, "TelephonyAutoProfiling"

    const-string v4, "[saveFeatureToPreferences] save to file : feature"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    const-string v3, "init"

    const-string v4, "done"

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-virtual {p1}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private setContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    :cond_0
    return-void
.end method


# virtual methods
.method public getValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "value":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->loadFeature()V

    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mFeature:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "value":Ljava/lang/String;
    check-cast v0, Ljava/lang/String;

    .restart local v0    # "value":Ljava/lang/String;
    :cond_1
    if-nez v0, :cond_2

    const-string v0, ""

    .end local v0    # "value":Ljava/lang/String;
    :cond_2
    return-object v0
.end method

.method public loadFeature()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .local v0, "loadSuccessFromPreferences":Z
    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->mContext:Landroid/content/Context;

    if-eqz v1, :cond_0

    :cond_0
    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->loadFeatureFromXml()V

    :cond_1
    return-void
.end method
