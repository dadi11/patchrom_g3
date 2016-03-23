#
# Makefile for LG G3
#

# The original zip file, MUST be specified by each product
local-zip-file     := stockrom.zip

# The output zip file of MIUI rom, the default is porting_miui.zip if not specified
local-out-zip-file := MIUI_G3.zip

# All vendor apks needed
local-phone-apps := LGBluetooth4 HTMLViewer KeyChain LGEIME LgNfc PacProcessor \
        UserDictionaryProvider qcrilmsgtunnel LteConfigs 

local-phone-priv-apps := BackupRestoreConfirmation DefaultContainerService FusedLocation \
        InputDevices ProxyHandler SharedStorageBackup \
        Shell TagGoogle VpnDialogs com.qualcomm.location com.qualcomm.services.location \
        LGCameraApp LGNetworkSettings LGSettings WapService

local-density := XXHDPI

# The certificate for release version
local-certificate-dir := security

# The local targets after the zip file is generated, could include 'zip2sd' to 
# deliver the zip file to phone, or to customize other actions

include $(PORT_BUILD)/porting.mk
