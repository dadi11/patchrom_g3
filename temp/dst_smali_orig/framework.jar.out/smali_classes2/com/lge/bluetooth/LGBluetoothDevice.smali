.class public final Lcom/lge/bluetooth/LGBluetoothDevice;
.super Ljava/lang/Object;
.source "LGBluetoothDevice.java"


# static fields
.field public static final ACTION_ACL_CONNECTED:Ljava/lang/String; = "com.lge.bluetooth.device.action.ACL_CONNECTED"

.field public static final ACTION_ACL_DISCONNECTED:Ljava/lang/String; = "com.lge.bluetooth.device.action.ACL_DISCONNECTED"

.field public static final ACTION_CHANGE_DEVICE_MODE:Ljava/lang/String; = "com.lge.bluetooth.devic.action.ACTION_DEVICE_MODE_CHANGE"

.field public static final ACTION_SAP_CONNECTION_STATE_CHANGED:Ljava/lang/String; = "com.lge.bluetooth.sap.CONNECTION_STATE_CHANGED"

.field public static final ACTION_SAP_DISCONNECT:Ljava/lang/String; = "com.lge.bluetooth.sap.ACTION_SAP_DISCONNECT"

.field public static final ACTION_SAP_REQUEST:Ljava/lang/String; = "com.lge.bluetooth.sap.ACTION_SAP_REQUEST"

.field public static final ACTION_SAP_RESPONSE:Ljava/lang/String; = "com.lge.bluetooth.sap.ACTION_SAP_RESPONSE"

.field public static final ACTION_UUID_CHANGED:Ljava/lang/String; = "com.lge.bluetooth.devic.action.ACTION_UUID_CHANGED"

.field public static final BIP:Landroid/os/ParcelUuid;

.field public static final BPP:Landroid/os/ParcelUuid;

.field private static final DBG:Z = false

.field public static final DISCONNECTION_TYPE_GRACEFUL:I = 0x0

.field public static final DISCONNECTION_TYPE_IMMEDIATE:I = 0x1

.field public static final DUN:Landroid/os/ParcelUuid;

.field public static final EXTRA_DISCOVERABLE_AUTO_ACCEPT:Ljava/lang/String; = "android.bluetooth.adapter.extra.EXTRA_DISCOVERABLE_AUTO_ACCEPT"

.field public static final EXTRA_DISCOVERABLE_ENABLE:Ljava/lang/String; = "android.bluetooth.adapter.extra.EXTRA_DISCOVERABLE_ENABLE"

.field public static final EXTRA_PAIRING_KEY:Ljava/lang/String; = "com.qcom.bluetooth.device.extra.PAIRING_KEY"

.field public static final EXTRA_SAP_DISCONNECT_TYPE:Ljava/lang/String; = "type"

.field public static final EXTRA_SECURE_PAIRING:Ljava/lang/String; = "com.qcom.bluetooth.device.extra.SECURE"

.field public static final EXTRA_SINK_MODE:Ljava/lang/String; = "com.lge.bluetooth.device.extra.EXTRA_SINK_MODE"

.field public static final EXTRA_UUID_A2DP_CHANGED:Ljava/lang/String; = "com.lge.bluetooth.devic.extra.EXTRA_UUID_A2DP_CHANGED"

.field public static final FILE_TRANSFER:Landroid/os/ParcelUuid;

.field public static final HFP_CLIENT:I = 0x14

.field public static final HID:Landroid/os/ParcelUuid;

.field public static final HID_DEVICE:I = 0x1e

.field public static final MAP:Landroid/os/ParcelUuid;

.field public static final MNS:Landroid/os/ParcelUuid;

.field public static final MSE:Landroid/os/ParcelUuid;

.field public static final PBOOK_ACC:Landroid/os/ParcelUuid;

.field public static final PERIPHERAL_JOYSTICK:I = 0x504

.field public static final PROFILE_ID_FTP:I = 0xa

.field public static final PROFILE_ID_SAP:I = 0xc

.field public static final REQUEST_TYPE_DUN_ACCESS:I = 0x8

.field public static final REQUEST_TYPE_FILE_ACCESS:I = 0x4

.field public static final REQUEST_TYPE_HID_ACCESS:I = 0xa

.field public static final REQUEST_TYPE_MESSAGE_ACCESS:I = 0x3

.field public static final REQUEST_TYPE_MNS_ACCESS:I = 0x6

.field public static final REQUEST_TYPE_MSE_ACCESS:I = 0x5

.field public static final REQUEST_TYPE_OPP_ACCESS:I = 0x9

.field public static final REQUEST_TYPE_SIM_ACCESS:I = 0x7

.field public static final SIM_ACC:Landroid/os/ParcelUuid;

.field public static final SPP:Landroid/os/ParcelUuid;

.field private static final TAG:Ljava/lang/String; = "LGBluetoothDevice"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "00001124-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->HID:Landroid/os/ParcelUuid;

    const-string v0, "00001130-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->PBOOK_ACC:Landroid/os/ParcelUuid;

    const-string v0, "00001106-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->FILE_TRANSFER:Landroid/os/ParcelUuid;

    const-string v0, "00001134-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MAP:Landroid/os/ParcelUuid;

    const-string v0, "00001132-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MSE:Landroid/os/ParcelUuid;

    const-string v0, "00001133-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MNS:Landroid/os/ParcelUuid;

    const-string v0, "0000112D-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->SIM_ACC:Landroid/os/ParcelUuid;

    const-string v0, "0000111A-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->BIP:Landroid/os/ParcelUuid;

    const-string v0, "00001122-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->BPP:Landroid/os/ParcelUuid;

    const-string v0, "00001103-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->DUN:Landroid/os/ParcelUuid;

    const-string v0, "00001101-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Landroid/os/ParcelUuid;->fromString(Ljava/lang/String;)Landroid/os/ParcelUuid;

    move-result-object v0

    sput-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->SPP:Landroid/os/ParcelUuid;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getRequestServiceType(Landroid/os/ParcelUuid;)I
    .locals 3
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    const/4 v0, 0x1

    if-nez p0, :cond_1

    const-string v1, "LGBluetoothDevice"

    const-string v2, "getRequestServiceType uuid is null"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isPbap(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 v0, 0x2

    goto :goto_0

    :cond_2
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isOpp(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/16 v0, 0x9

    goto :goto_0

    :cond_3
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isFtp(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_4

    const/4 v0, 0x4

    goto :goto_0

    :cond_4
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isMap(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_5

    const/4 v0, 0x3

    goto :goto_0

    :cond_5
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isMns(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_6

    const/4 v0, 0x5

    goto :goto_0

    :cond_6
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isMse(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_7

    const/4 v0, 0x6

    goto :goto_0

    :cond_7
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isSap(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_8

    const/4 v0, 0x7

    goto :goto_0

    :cond_8
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isDun(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_9

    const/16 v0, 0x8

    goto :goto_0

    :cond_9
    invoke-static {p0}, Lcom/lge/bluetooth/LGBluetoothDevice;->isHid(Landroid/os/ParcelUuid;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/16 v0, 0xa

    goto :goto_0
.end method

.method public static getServiceTypeToUuid(I)Landroid/os/ParcelUuid;
    .locals 1
    .param p0, "type"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "uuid":Landroid/os/ParcelUuid;
    packed-switch p0, :pswitch_data_0

    :goto_0
    return-object v0

    :pswitch_0
    sget-object v0, Landroid/bluetooth/BluetoothUuid;->ObexObjectPush:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_1
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->FILE_TRANSFER:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_2
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MAP:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_3
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MSE:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_4
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MNS:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_5
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->SIM_ACC:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_6
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->DUN:Landroid/os/ParcelUuid;

    goto :goto_0

    :pswitch_7
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->HID:Landroid/os/ParcelUuid;

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_1
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_0
        :pswitch_7
    .end packed-switch
.end method

.method public static isBip(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->BIP:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isBpp(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->BPP:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isDun(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->DUN:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isFtp(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->FILE_TRANSFER:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isHid(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->HID:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isMap(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MAP:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isMns(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MNS:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isMse(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->MSE:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isOpp(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Landroid/bluetooth/BluetoothUuid;->ObexObjectPush:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isPbap(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->PBOOK_ACC:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isSap(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->SIM_ACC:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isSerialPort(Landroid/os/ParcelUuid;)Z
    .locals 1
    .param p0, "uuid"    # Landroid/os/ParcelUuid;

    .prologue
    sget-object v0, Lcom/lge/bluetooth/LGBluetoothDevice;->SPP:Landroid/os/ParcelUuid;

    invoke-virtual {p0, v0}, Landroid/os/ParcelUuid;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
