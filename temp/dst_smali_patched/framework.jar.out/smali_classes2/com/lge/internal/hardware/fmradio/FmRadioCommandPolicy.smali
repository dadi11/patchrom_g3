.class public Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;
.super Ljava/lang/Object;
.source "FmRadioCommandPolicy.java"

# interfaces
.implements Lcom/lge/internal/hardware/fmradio/CommandCasePolicy;


# static fields
.field private static final T:Ljava/lang/String; = "FMFRW_FmRadioCommandPolicy"

.field static defeatRelationship:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Lcom/lge/internal/hardware/fmradio/FMRadioCommand;",
            "Ljava/util/Map",
            "<",
            "Lcom/lge/internal/hardware/fmradio/FMRadioCommand;",
            "Ljava/lang/Integer;",
            ">;>;"
        }
    .end annotation
.end field

.field private static myInstance:Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, -0x1

    new-instance v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;

    invoke-direct {v1}, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;-><init>()V

    sput-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->myInstance:Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;

    new-instance v1, Ljava/util/EnumMap;

    const-class v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v1, v2}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    sput-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    new-instance v0, Ljava/util/EnumMap;

    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .local v0, "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/EnumMap;

    .end local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    const-class v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-direct {v0, v1}, Ljava/util/EnumMap;-><init>(Ljava/lang/Class;)V

    .restart local v0    # "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    sget-object v1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    sget-object v2, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->INITIALIZE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_RESUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RADIO_PAUSE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_FORWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SEEK_BACKWARD:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TUNE_AFTER_SCAN:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->SET_VOLUME:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_ON:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->RDS_OFF:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object v1, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->TERMINATE:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private blindFights(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;)I
    .locals 3
    .param p1, "newCommand"    # Lcom/lge/internal/hardware/fmradio/FMRadioCommand;
    .param p2, "runningCommand"    # Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    .prologue
    const-string v0, "FMFRW_FmRadioCommandPolicy"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unspecified command case relation: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " -> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/lge/internal/hardware/fmradio/FMRadioCommand;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public static getInstance()Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->myInstance:Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;

    return-object v0
.end method


# virtual methods
.method public fights(Lcom/lge/internal/hardware/fmradio/CommandCase;Lcom/lge/internal/hardware/fmradio/CommandCase;)I
    .locals 2
    .param p1, "newCase"    # Lcom/lge/internal/hardware/fmradio/CommandCase;
    .param p2, "runningCase"    # Lcom/lge/internal/hardware/fmradio/CommandCase;

    .prologue
    check-cast p1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;

    .end local p1    # "newCase":Lcom/lge/internal/hardware/fmradio/CommandCase;
    iget-object v0, p1, Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;->command:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    check-cast p2, Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;

    .end local p2    # "runningCase":Lcom/lge/internal/hardware/fmradio/CommandCase;
    iget-object v1, p2, Lcom/lge/internal/hardware/fmradio/FmRadioCommandCase;->command:Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    invoke-virtual {p0, v0, v1}, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->fights(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;)I

    move-result v0

    return v0
.end method

.method fights(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;)I
    .locals 3
    .param p1, "newCommand"    # Lcom/lge/internal/hardware/fmradio/FMRadioCommand;
    .param p2, "runningCommand"    # Lcom/lge/internal/hardware/fmradio/FMRadioCommand;

    .prologue
    sget-object v2, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->defeatRelationship:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .local v1, "m":Ljava/util/Map;, "Ljava/util/Map<Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Ljava/lang/Integer;>;"
    if-nez v1, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->blindFights(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;)I

    move-result v2

    :goto_0
    return v2

    :cond_0
    invoke-interface {v1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .local v0, "i":Ljava/lang/Integer;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/lge/internal/hardware/fmradio/FmRadioCommandPolicy;->blindFights(Lcom/lge/internal/hardware/fmradio/FMRadioCommand;Lcom/lge/internal/hardware/fmradio/FMRadioCommand;)I

    move-result v2

    goto :goto_0
.end method
