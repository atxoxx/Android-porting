#!/bin/sh
#
# A ROM MODDING SCRIPT BY ZONALRIPPER
#
# View README.md for details.

###############################################################
# VERSION CONTROL                                             #
# v1.0 - initial version                                      #
# v1.1 - added removal of avb string from fstab file          #
# v1.2 - enabled sparse feat.                                 #
# v1.3 - enabled brotli compression                           #
# v1.5 - added more debloat                                   #
# v1.6 - added support for S21 fstab                          #
# v1.7 - added omc decryption, fix ussd codes                 #
# v1.8 - changed to use img2sdat in tools folder              #
# v2.0 - added more debloat options                           #
# v3.0 - paramatised the tasks                                #
# v3.1 - added more debloat                                   #
# v3.2 - added BT lib patch + changed tools folder name       #
# v3.3 - added device seperation (S10,S20,S21)                #
# v3.4 - Cleanup for S10 device                               #
# V3.5 - Add keystore patching                                #
# v3.6 - change lib and keystore patching method              #
# v4.0 - Rework to mod system folder  #GitUpload              #
# v4.1 - Add support for N10 device and cleanup of code       #
# v4.2 - comment out knoxcore from debloat                    #
# v4.3 - fixed secure folder for S20                          #
# v4.4 - added more debloat options                           #
# v4.5 - Added FRP and Reactivation Disable for vendor        #
# v4.6 - Added floating features for S10,N10 & S20            #
# v4.7 - FixTypo and Latest Debloat                           #
# v4.8 - disable liboemcrypto.so for netflix fix              #
# v4.9 - AR removal and cleanup                               #
# v5.0 - Amend for S21 Android 12                             #
# v5.3 - Adapt bt patch for Android 12; comment sn patching   #
# v5.4 - BT patch differnt depending on device                #
# v5.5 - Remove recovery-from-boot from vendor                #
# v5.6 - Changed printf statements to echo                    #
# v5.7 - Add S21 deodex                                       #
# v5.8 - Add S20 deodex                                       #
# v5.9 - Change S20 BT patching for A12                       #
# v6.0 - Add extra bloat from A12 firmwares by LeeXDA18.      #
# v6.1 - Fix Floating_feature command                         #
# v6.2 - Add deletion of wsm_manifest.xml for S10             #
# v6.3 - S10 CSC Fix                                          #
# v6.4 - Add CSC feature for all devices add N20 Device       #
# v6.5 - Add build.prop features                              #
# v6.6 - add dalvik mods                                      #
# v6.8 - add S22 mods                                         #
# v6.9 - update S22 fstab mods                                #
###############################################################

###############################################################
#script function for changing prop values                     #
#usage setProperty "property.name" "newValue" "FileToUpdate"  #
###############################################################
echo "WELCOME TO SAMSUNG ROM DISARM TOOL";

setProperty()
{
  awk -v pat="^$1=" -v value="$1=$2" '{ if ($0 ~ pat) print value; else print $0; }' $3 > $3.tmp
  mv $3.tmp $3
}

: 'Used only by CRB
NOTE: Variables set by CRB
'
{ROMPath}
romversion="{romversion}"
device={device}

: 'Disabled for CRB
read -p "Enter ROM version: " romversion
'

# AMEND S20/S21/S22 SYSTEM DEBLOAT HERE
debloatSystem() {
local md5
local i

rm -R -f $SYSMOUNT/system/app/ARDrawing
rm -R -f $SYSMOUNT/system/app/ARZone
rm -R -f $SYSMOUNT/system/app/AutomationTest_FB
rm -R -f $SYSMOUNT/system/app/EasterEgg
rm -R -f $SYSMOUNT/system/app/EasymodeContactsWidget81
# rm -R -f $SYSMOUNT/system/app/ESEServiceAgent #NFC-Knox-SKMS related service
rm -R -f $SYSMOUNT/system/app/Facebook_stub
# rm -R -f $SYSMOUNT/system/app/FactoryAirCommandManager #SPen related
rm -R -f $SYSMOUNT/system/app/FactoryCameraFB
rm -R -f $SYSMOUNT/system/app/FBAppManager_NS
rm -R -f $SYSMOUNT/system/app/Foundation
rm -R -f $SYSMOUNT/system/app/KidsHome_Installer
rm -R -f $SYSMOUNT/system/app/LiveDrawing
rm -R -f $SYSMOUNT/system/app/LiveTranscribe
# rm -R -f $SYSMOUNT/system/app/MdecService #Call and text on other devices
rm -R -f $SYSMOUNT/system/app/MDMApp
rm -R -f $SYSMOUNT/system/app/MinusOnePage
rm -R -f $SYSMOUNT/system/app/Netflix_activationCommon
rm -R -f $SYSMOUNT/system/app/Netflix_stub
rm -R -f $SYSMOUNT/system/app/Notes40
rm -R -f $SYSMOUNT/system/app/PlayAutoInstallConfig #Removes the bloat setup by Google on Clean Flash of a ROM.
rm -R -f $SYSMOUNT/system/app/SamsungPassAutofill_v1
rm -R -f $SYSMOUNT/system/app/SamsungTTS
rm -R -f $SYSMOUNT/system/app/SmartReminder
rm -R -f $SYSMOUNT/system/app/UniversalMDMClient
rm -R -f $SYSMOUNT/system/app/VideoEditorLite_Dream_N
rm -R -f $SYSMOUNT/system/app/HoneyBoard/oat
rm -R -f $SYSMOUNT/system/priv-app/AppUpdateCenter
rm -R -f $SYSMOUNT/system/priv-app/AREmoji
rm -R -f $SYSMOUNT/system/priv-app/AREmojiEditor
rm -R -f $SYSMOUNT/system/priv-app/AuthFramework
rm -R -f $SYSMOUNT/system/priv-app/AutoDoodle
rm -R -f $SYSMOUNT/system/priv-app/AvatarEmojiSticker_Palette
rm -R -f $SYSMOUNT/system/priv-app/AvatarEmojiSticker_S
rm -R -f $SYSMOUNT/system/priv-app/AvatarEmojiSticker_S2
rm -R -f $SYSMOUNT/system/priv-app/StickerFaceARAvatar
rm -R -f $SYSMOUNT/system/priv-app/CIDManager
# rm -R -f $SYSMOUNT/system/priv-app/DigitalKey
rm -R -f $SYSMOUNT/system/priv-app/FBInstaller_NS
rm -R -f $SYSMOUNT/system/priv-app/FBServices
rm -R -f $SYSMOUNT/system/priv-app/FotaAgent
# rm -R -f $SYSMOUNT/system/priv-app/KnoxGuard
rm -R -f $SYSMOUNT/system/priv-app/LiveStickers
rm -R -f $SYSMOUNT/system/priv-app/MateAgent
# rm -R -f $SYSMOUNT/system/priv-app/OMCAgent5
rm -R -f $SYSMOUNT/system/priv-app/OneDrive_Samsung_v3
# rm -R -f $SYSMOUNT/system/priv-app/PaymentFramework #Samsung Pay
# rm -R -f $SYSMOUNT/system/priv-app/SamsungBilling #Samsung Pay
# rm -R -f $SYSMOUNT/system/priv-app/SamsungCarKeyFw
rm -R -f $SYSMOUNT/system/priv-app/SamsungPass
rm -R -f $SYSMOUNT/system/priv-app/SamsungSocial
rm -R -f $SYSMOUNT/system/priv-app/SmartEye
rm -R -f $SYSMOUNT/system/priv-app/SOAgent*
rm -R -f $SYSMOUNT/system/priv-app/StickerFaceARAvatar
rm -R -f $SYSMOUNT/system/priv-app/Tag
rm -R -f $SYSMOUNT/system/priv-app/Tips
rm -R -f $SYSMOUNT/system/priv-app/Upday
rm -R -f $SYSMOUNT/system/priv-app/Fast/oat
rm -R -f $SYSMOUNT/system/priv-app/NSDSWebApp/oat
rm -R -f $SYSMOUNT/system/priv-app/SamsungInCallUI/oat
rm -R -f $SYSMOUNT/system/priv-app/SecSettings/oat
rm -R -f $SYSMOUNT/system/priv-app/SecureFolder/oat
rm -R -f $SYSMOUNT/system/priv-app/Telecom/oat
rm -R -f $SYSMOUNT/system/priv-app/TeleService/oat
rm -R -f $SYSMOUNT/system/preload/AirCommand
rm -R -f $SYSMOUNT/system/preload/Facebook_stub_preload
rm -R -f $SYSMOUNT/system/preload/SmartSwitch
rm -R -f $SYSMOUNT/system/preload/Tips
rm -R -f $SYSMOUNT/system/hidden/SmartTutor
rm -f $SYSMOUNT/system/etc/sysconfig/samsungpassapp.xml
rm -f $SYSMOUNT/system/recovery-from-boot.p
rm -R -f $SYSMOUNT/system/tts/lang_SMT/smt_es_MX*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/smt_en_GB*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/smt_pt_BR*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/smt_ru_RU*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_de_DE*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_en_GB*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_es_ES*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_es_MX*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_fr_FR*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_it_IT*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_pt_BR*
rm -R -f $SYSMOUNT/system/tts/lang_SMT/vdata_ru_RU*
rm -R -f $SYSMOUNT/system/framework/oat/arm64/services.art
rm -R -f $SYSMOUNT/system/framework/oat/arm64/services.odex
rm -R -f $SYSMOUNT/system/framework/oat/arm64/services.vdex
find $PWD/system/system/app -mindepth 1 -maxdepth 2 -type d -name "oat" -exec rm -rf '{}' \;
find $PWD/system/system/priv-app -mindepth 1 -maxdepth 2 -type d -name "oat" -exec rm -rf '{}' \;
}

# AMEND S10/N10 SYSTEM DEBLOAT HERE
s10debloatSystem() {
local md5
local i

rm -R -f $SYSMOUNT/system/app/AutomationTest_FB
rm -R -f $SYSMOUNT/system/app/EasterEgg
rm -R -f $SYSMOUNT/system/app/ESEServiceAgent
rm -R -f $SYSMOUNT/system/app/Facebook_stub
rm -R -f $SYSMOUNT/system/app/FactoryCameraFB
rm -R -f $SYSMOUNT/system/app/FBAppManager_NS
rm -R -f $SYSMOUNT/system/app/KidsHome_Installer
rm -R -f $SYSMOUNT/system/app/LiveDrawing
rm -R -f $SYSMOUNT/system/app/ARDrawing
rm -R -f $SYSMOUNT/system/app/ARZone
rm -R -f $SYSMOUNT/system/priv-app/AREmoji
rm -R -f $SYSMOUNT/system/priv-app/AREmojiEditor
rm -R -f $SYSMOUNT/system/priv-app/AvatarEmojiSticker_Palette
rm -R -f $SYSMOUNT/system/app/LiveTranscribe
rm -R -f $SYSMOUNT/system/app/Maps
rm -R -f $SYSMOUNT/system/app/MDMApp
rm -R -f $SYSMOUNT/system/app/mldapchecker
rm -R -f $SYSMOUNT/system/app/SamsungPassAutofill_v1
rm -R -f $SYSMOUNT/system/app/SamsungTTS
rm -R -f $SYSMOUNT/system/app/UniversalMDMClient
rm -R -f $SYSMOUNT/system/app/HoneyBoard/oat
rm -R -f $SYSMOUNT/system/priv-app/CIDManager
rm -R -f $SYSMOUNT/system/priv-app/EnhancedAttestationAgent
rm -R -f $SYSMOUNT/system/priv-app/FBInstaller_NS
rm -R -f $SYSMOUNT/system/priv-app/FBServices
rm -R -f $SYSMOUNT/system/priv-app/FotaAgent
rm -R -f $SYSMOUNT/system/priv-app/KLMSAgent
rm -R -f $SYSMOUNT/system/priv-app/MateAgent
rm -R -f $SYSMOUNT/system/priv-app/OneDrive_Samsung_v3
rm -R -f $SYSMOUNT/system/priv-app/PaymentFramework
rm -R -f $SYSMOUNT/system/priv-app/SamsungBilling
rm -R -f $SYSMOUNT/system/priv-app/SamsungPass
rm -R -f $SYSMOUNT/system/priv-app/SamsungSocial
rm -R -f $SYSMOUNT/system/priv-app/SOAgent
rm -R -f $SYSMOUNT/system/priv-app/Upday
rm -R -f $SYSMOUNT/system/priv-app/Fast/oat
rm -R -f $SYSMOUNT/system/priv-app/NSDSWebApp/oat
rm -R -f $SYSMOUNT/system/priv-app/SamsungInCallUI/oat
rm -R -f $SYSMOUNT/system/priv-app/SecSettings/oat
rm -R -f $SYSMOUNT/system/priv-app/SecureFolder/oat
rm -R -f $SYSMOUNT/system/priv-app/Telecom/oat
rm -R -f $SYSMOUNT/system/priv-app/TeleService/oat
rm -f $SYSMOUNT/system/etc/sysconfig/samsungpassapp.xml
rm -f $SYSMOUNT/system/recovery-from-boot.p
rm -f $SYSMOUNT/system/tts/lang_SMT/smt_es_MX*.*
rm -f $SYSMOUNT/system/tts/lang_SMT/smt_en_GB*.*
rm -f $SYSMOUNT/system/tts/lang_SMT/smt_pt_BR*.*
rm -f $SYSMOUNT/system/tts/lang_SMT/smt_ru_RU*.*
rm -f $SYSMOUNT/system/framework/oat/arm64/services.art
rm -f $SYSMOUNT/system/framework/oat/arm64/services.odex
rm -f $SYSMOUNT/system/framework/oat/arm64/services.vdex
rm -R -f vendor/etc/vintf/manifest/wsm_manifest.xml
rm -R -f vendor/etc/vintf/manifest/vaultkeeper_manifest.xml
}

# AMEND S20/S21/S22 PRODUCT/PRISM DEBLOAT HERE
debloatPPV() {
local md5
local i

rm -R -f product/app/Maps
rm -R -f product/app/YouTube
rm -R -f product/app/Chrome/oat
rm -R -f product/app/DuoStub/oat
rm -R -f product/app/Gmail2/oat
rm -R -f product/app/GoogleCalendarSyncAdapter/oat
rm -R -f product/app/GoogleContactsSyncAdapter/oat
rm -R -f product/app/GoogleLocationHistory/oat
rm -R -f product/app/SpeechServicesByGoogle/oat
rm -R -f product/app/TrichromeLibrary/oat
rm -R -f product/app/WebViewGoogle/oat
rm -R -f product/priv-app/AndroidAutoStub/oat
rm -R -f product/priv-app/CarrierServices/oat
rm -R -f product/priv-app/CarrierWifi/oat
rm -R -f product/priv-app/ConfigUpdater/oat
rm -R -f product/priv-app/DevicePersonalizationServices/oat
rm -R -f product/priv-app/GmsCore/oat
rm -R -f product/priv-app/GmsCore//m/Independent/oat
rm -R -f product/priv-app/GoogleOneTimeInitializer/oat
rm -R -f product/priv-app/GooglePartnerSetup/oat
rm -R -f product/priv-app/GoogleRestore/oat
rm -R -f product/priv-app/HotwordEnrollmentOKGoogleEx4CORTEXM55/oat
rm -R -f product/priv-app/HotwordEnrollmentXGoogleEx4CORTEXM55/oat
rm -R -f product/priv-app/Phonesky/oat
rm -R -f product/priv-app/PrivateComputeServices/oat
rm -R -f product/priv-app/SearchSelector/oat
rm -R -f product/priv-app/Velvet/oat
rm -R -f product/priv-app/VoiceAccess/oat
rm -R -f product/priv-app/Messages
rm -R -f prism/media/carriers/single/PRT/media/bootsamsung.qmg
rm -R -f prism/media/carriers/single/PRT/media/video/shutdown/shutdown.qmg
rm -R -f prism/preload/*
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/3D*
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/bable*
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/brokat*
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/geometria*
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/default_wallpaper.png
rm -R -f prism/media/carriers/single/PRT/wallpaper/drawable/lockscreen_default_wallpaper.png

find $PWD/prism/app -mindepth 1 -maxdepth 1 -type d -not -name "UserManual" -exec rm -rf '{}' \;
find $PWD/prism/HWRDB/data -mindepth 1 -maxdepth 1 -type f -not -name "hwr_ar.dat" -not -name "hwr_de_DE.dat" -not -name "hwr_en_US.dat" -not -name "hwr_en_GB.dat" -not -name "hwr_fr_FR.dat" -not -name "hwr_ro_RO.dat" -exec rm -rf '{}' \;
rm -R -f prism/priv-app/*
rm -R -f prism/sipdb/Xt9/*
find $PWD/prism/sipdb/SwiftKey -mindepth 1 -maxdepth 1 -type d -not -name "ar" -not -name "de" -not -name "en_us" -not -name "en_gb" -not -name "fr_fr" -not -name "ro" -exec rm -rf '{}' \;
}

#deodex ROM
deodex() {
local md5
local i

rm -R -f $SYSMOUNT/system/framework/arm
rm -R -f $SYSMOUNT/system/framework/arm64
rm -R -f $SYSMOUNT/system/framework/oat
rm -f $SYSMOUNT/system/framework/boot-core-icu4j.vdex
rm -f $SYSMOUNT/system/framework/boot-drutils.vdex
rm -f $SYSMOUNT/system/framework/boot-esecomm.vdex
rm -f $SYSMOUNT/system/framework/boot-ext.vdex
rm -f $SYSMOUNT/system/framework/boot-framework.vdex
rm -f $SYSMOUNT/system/framework/boot-framework-graphics.vdex
rm -f $SYSMOUNT/system/framework/boot-ims-common.vdex
rm -f $SYSMOUNT/system/framework/boot-knoxanalyticssdk.vdex
rm -f $SYSMOUNT/system/framework/boot-knoxsdk.vdex
rm -f $SYSMOUNT/system/framework/boot-sem-telephony-common.vdex
rm -f $SYSMOUNT/system/framework/boot-SmpsManager.vdex
rm -f $SYSMOUNT/system/framework/boot-telephony-common.vdex
rm -f $SYSMOUNT/system/framework/boot-uibc_java.vdex
rm -f $SYSMOUNT/system/framework/boot-voip-common.vdex
}

# AMEND S10/N10 PRODUCT DEBLOAT HERE
s10debloatPPV() {
local md5
local i

rm -R -f product/app/Multi_SKU*
rm -R -f product/app/MySingtel*
rm -R -f product/app/yandex*
rm -R -f product/preload/INS/hidden_app/*
rm -R -f product/preload/SER/hidden_app/*
rm -R -f product/HWRDB/data/hwr_zh*
rm -R -f product/priv-app/*
rm -R -f product/sipdb/Xt9/*
rm -R -f product/etc/permissions/*
rm -R -f product/etc/sysconfig/*
find $PWD/product/sipdb/SwiftKey -mindepth 1 -maxdepth 1 -type d -not -name "ar" -not -name "de" -not -name "en_us" -not -name "en_gb" -not -name "es_es" -not -name "fr_fr" -not -name "ro" -not -name "ru" -exec rm -rf '{}' \;
}

# AMEND SYSTEM BUILD PROP TWEAKS HERE FOR ALL VERSIONS
BUILDPROP="
##CUSTOM TWEAKS##
fw.max_users=3
fw.power_user_switcher=1
fw.show_hidden_users=1
fw.show_multiuserui=1
ring.delay=0
ro.kernel.android.checkjni=0
ro.kernel.checkjni=0
ro.media.enc.jpeg.quality=100
ro.securestorage.support=false
ro.telephony.call_ring.delay=0
wlan.wfd.hdcp=disable
ro.security.vaultkeeper.native=0
ro.security.vaultkeeper.feature=0
ro.config.hw_quickpoweron=true
profiler.force_disable_err_rpt=1
profiler.force_disable_ulog=1
wifi.supplicant_scan_interval=120
debug.performance.tuning=1
ro.HOME_APP_ADJ=1
ro.lge.proximity.delay=25
mot.proximity.delay=25
ro.ril.power_collapse=1
pm.sleep_mode=1
persist.cust.tel.eons=1
persist.adb.notify=0
persist.service.adb.enable=1
ro.boot.flash.locked=1
video.accelerate.hw=1
ro.media.dec.jpeg.memcap=20000000
ro.media.enc.hprof.vid.bps=8000000
ro.mot.eri.losalert.delay=1000
ro.config.hw_fast_dormancy=1
ro.ril.enable.amr.wideband=1
persist.sys.NV_FPSLIMIT=90
debug.qctwa.statusbar=1
debug.qctwa.preservebuf=1
debug.qc.hardware=true
com.qc.hardware=true
ro.telephony.sms_segment_size=160
persist.telephony.support.ipv6=1
persist.telephony.support.ipv4=1
persist.sys.shutdown.mode=hibernate
ro.config.hw_power_saving=true
ro.media.enc.hprof.vid.fps=65
ro.mot.buttonlight.timeout=1
ro.ril.set.mtu1472=1
touch.pressure.scale=0.001
windowsmgr.max_events_per_sec=90
persist.sys.use_16bpp_alpha=1
dalvik.vm.verify-bytecode=false
dalvik.vm.execution-mode=int:fast
dalvik.vm.checkjni=false
dalvik.vm.dexopt-data-only=1
dalvik.vm.dexopt-flags=m=v,o=y
dalvik.vm.jmiopts=forcecopy
debug.composition.type=gpu
ro.max.fling_velocity=20000
ro.min.fling_velocity=18000
debug.kill_allocating_task=0
debug.overlayui.enable=1
debug.egl.profiler=1
debug.egl.hw=1
debug.sf.hw=1
hw3d.force=1
hw2d.force=1
force_hw_ui=true
ro.config.disable.hw_accel=false
persist.sys.purgeable_assets=1
persist.sys.use_dithering=1
boot.fps=30
shutdown.fps=30"

cscfeature() {
local md5
local i

CSC_PROD="$PWD/product/omc"
CSC_OPTICS="$PWD/optics/configs/carriers/"


echo "applying CSC features"
if [ $device = "S10" ] || [ $device = "N10" ] && [ -d "$CSC_PROD" ]; then
#remove csc so not to duplicate
    find $CSC_PROD -type f -name "cscfeature.xml" -exec sed -i '/CscFeature_SystemUI_ConfigOverrideDataIcon\|CscFeature_Wifi_SupportAdvancedMenu\|CscFeature_SmartManager_ConfigDashboard\|CscFeature_SmartManager_DisableAntiMalware\|CscFeature_Calendar_SetColorOfDays\|CscFeature_Camera_ShutterSoundMenu\|CscFeature_Camera_EnableCameraDuringCall\|CscFeature_Camera_EnableSmsNotiPopup\|CscFeature_Common_ConfigSvcProviderForUnknownNumber\|CscFeature_Setting_SupportRealTimeNetworkSpeed\|CscFeature_VoiceCall_ConfigRecording\|CscFeature_SystemUI_SupportRecentAppProtection\|CscFeature_Knox_SupportKnoxGuard\|CscFeature_RIL_SupportEsim\|CscFeature_SmartManager_ConfigSubFeatures\|CscFeature_Web_SetHomepageURL\|CscFeature_Common_EnhanceImageQuality\|CscFeature_Message_SupportAntiPhishing/d' {} +
#add csc mods
    find $CSC_PROD -type f -name "cscfeature.xml" -exec sed -i -- '/<FeatureSet>/ a\    <CscFeature_SystemUI_ConfigOverrideDataIcon>LTE</CscFeature_SystemUI_ConfigOverrideDataIcon>\n    <CscFeature_Wifi_SupportAdvancedMenu>TRUE</CscFeature_Wifi_SupportAdvancedMenu>\n    <CscFeature_SmartManager_ConfigDashboard>dual_dashboard</CscFeature_SmartManager_ConfigDashboard>\n    <CscFeature_SmartManager_DisableAntiMalware>TRUE</CscFeature_SmartManager_DisableAntiMalware>\n    <CscFeature_Calendar_SetColorOfDays>XXXXXBR</CscFeature_Calendar_SetColorOfDays>\n    <CscFeature_Camera_ShutterSoundMenu>TRUE</CscFeature_Camera_ShutterSoundMenu>\n    <CscFeature_Camera_EnableCameraDuringCall>TRUE</CscFeature_Camera_EnableCameraDuringCall>\n    <CscFeature_Camera_EnableSmsNotiPopup>TRUE</CscFeature_Camera_EnableSmsNotiPopup>\n    <CscFeature_Common_ConfigSvcProviderForUnknownNumber>whitepages,whitepages,whitepages</CscFeature_Common_ConfigSvcProviderForUnknownNumber>\n    <CscFeature_Setting_SupportRealTimeNetworkSpeed>TRUE</CscFeature_Setting_SupportRealTimeNetworkSpeed>\n     <CscFeature_VoiceCall_ConfigRecording>RecordingAllowed</CscFeature_VoiceCall_ConfigRecording>\n    <CscFeature_SystemUI_SupportRecentAppProtection>TRUE</CscFeature_SystemUI_SupportRecentAppProtection>\n    <CscFeature_Knox_SupportKnoxGuard>FALSE</CscFeature_Knox_SupportKnoxGuard>\n    <CscFeature_RIL_SupportEsim>TRUE</CscFeature_RIL_SupportEsim>\n    <CscFeature_SmartManager_ConfigSubFeatures>applock</CscFeature_SmartManager_ConfigSubFeatures>\n    <CscFeature_Web_SetHomepageURL>https://www.google.com/</CscFeature_Web_SetHomepageURL>\n    <CscFeature_Common_EnhanceImageQuality>TRUE</CscFeature_Common_EnhanceImageQuality>\n    <CscFeature_Message_SupportAntiPhishing>TRUE</CscFeature_Message_SupportAntiPhishing>' {} +
    echo "     ..CSC features applied"
elif [ $device = "S22" ] || [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ] && [ -d "$CSC_OPTICS" ]; then
#remove csc so not to duplicate
    find $CSC_OPTICS -type f -name "cscfeature.xml" -exec sed -i '/CscFeature_SystemUI_ConfigOverrideDataIcon\|CscFeature_Wifi_SupportAdvancedMenu\|CscFeature_SmartManager_ConfigDashboard\|CscFeature_SmartManager_DisableAntiMalware\|CscFeature_Calendar_SetColorOfDays\|CscFeature_Camera_ShutterSoundMenu\|CscFeature_Camera_EnableCameraDuringCall\|CscFeature_Camera_EnableSmsNotiPopup\|CscFeature_Common_ConfigSvcProviderForUnknownNumber\|CscFeature_Setting_SupportRealTimeNetworkSpeed\|CscFeature_VoiceCall_ConfigRecording\|CscFeature_SystemUI_SupportRecentAppProtection\|CscFeature_Knox_SupportKnoxGuard\|CscFeature_RIL_SupportEsim\|CscFeature_SmartManager_ConfigSubFeatures\|CscFeature_Web_SetHomepageURL\|CscFeature_Common_EnhanceImageQuality\|CscFeature_Message_SupportAntiPhishing/d' {} +
#add csc mods
    find $CSC_OPTICS -type f -name "cscfeature.xml" -exec sed -i -- '/<FeatureSet>/ a\    <CscFeature_SystemUI_ConfigOverrideDataIcon>LTE</CscFeature_SystemUI_ConfigOverrideDataIcon>\n    <CscFeature_Wifi_SupportAdvancedMenu>TRUE</CscFeature_Wifi_SupportAdvancedMenu>\n    <CscFeature_SmartManager_ConfigDashboard>dual_dashboard</CscFeature_SmartManager_ConfigDashboard>\n    <CscFeature_SmartManager_DisableAntiMalware>TRUE</CscFeature_SmartManager_DisableAntiMalware>\n    <CscFeature_Calendar_SetColorOfDays>XXXXXBR</CscFeature_Calendar_SetColorOfDays>\n    <CscFeature_Camera_ShutterSoundMenu>TRUE</CscFeature_Camera_ShutterSoundMenu>\n    <CscFeature_Camera_EnableCameraDuringCall>TRUE</CscFeature_Camera_EnableCameraDuringCall>\n    <CscFeature_Camera_EnableSmsNotiPopup>TRUE</CscFeature_Camera_EnableSmsNotiPopup>\n    <CscFeature_Common_ConfigSvcProviderForUnknownNumber>whitepages,whitepages,whitepages</CscFeature_Common_ConfigSvcProviderForUnknownNumber>\n    <CscFeature_Setting_SupportRealTimeNetworkSpeed>TRUE</CscFeature_Setting_SupportRealTimeNetworkSpeed>\n    <CscFeature_VoiceCall_ConfigRecording>RecordingAllowed</CscFeature_VoiceCall_ConfigRecording>\n    <CscFeature_SystemUI_SupportRecentAppProtection>TRUE</CscFeature_SystemUI_SupportRecentAppProtection>\n    <CscFeature_Knox_SupportKnoxGuard>FALSE</CscFeature_Knox_SupportKnoxGuard>\n    <CscFeature_RIL_SupportEsim>TRUE</CscFeature_RIL_SupportEsim>\n    <CscFeature_SmartManager_ConfigSubFeatures>applock</CscFeature_SmartManager_ConfigSubFeatures>\n    <CscFeature_Web_SetHomepageURL>https://www.google.com/</CscFeature_Web_SetHomepageURL>\n    <CscFeature_Common_EnhanceImageQuality>TRUE</CscFeature_Common_EnhanceImageQuality>\n    <CscFeature_Message_SupportAntiPhishing>TRUE</CscFeature_Message_SupportAntiPhishing>' {} +
    echo "     ..CSC features applied"
else
    echo "     ..CSC features not applied"
fi
}

#
#
# SYSTEM MODS
modsystem()
{
##SYSTEM DEBLOAT##
SYSMOUNT="$PWD/system"
echo "debloating system";
if [ $device = "S22" ] || [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    debloatSystem
    echo "     ..'$device' System debloated"
elif [ $device = "S10" ] || [ $device = "N10" ]; then
: 'Used only by CRB
NOTE: Variables set by CRB
'
    {s10debloatSystem}
    echo "     ..'$device' System debloated"
else
    echo "     ..No system folder found"
fi

##PATCH BLUETOOTH##
LIBFILE="system/lib64/libbluetooth.so"
echo "Patching '$LIBFILE'";
if [ -f "$SYSMOUNT/$LIBFILE" ]; then

: 'Disabled for CRB
	perl -0777 -i -pe 's/\x88\x00\x00\x34\xf9\x03\x1f\x2a\xf3\x03\x1f\x2a\x41\x00\x00\x14/\x1f\x20\x03\xd5\xf9\x03\x1f\x2a\xf3\x03\x1f\x2a\x48\x00\x00\x14/' $SYSMOUNT/$LIBFILE
'
	hexpatch $SYSMOUNT/$LIBFILE "88000034f9031f2af3031f2a41000014" "1f2003d5f9031f2af3031f2a48000014"
    echo "     ..file succesfully patched"
else
    echo "     ..'$LIBFILE' not found"
fi

##MOD BUILD.PROP##
SYSBUILDPROP="system/build.prop"
echo "modding '$SYSBUILDPROP'";
if [ -f "$SYSMOUNT/$SYSBUILDPROP" ]; then
    setProperty "ro.build.display.id" "$romversion" "$SYSMOUNT/$SYSBUILDPROP" $SYSMOUNT/$SYSBUILDPROP
    echo "     ..ROM version set"
    setProperty "ro.config.iccc_version" "iccc_disabled" "$SYSMOUNT/$SYSBUILDPROP"
    echo "     ..iccc disabled"
    setProperty "ro.config.dmverity" "false" "$SYSMOUNT/$SYSBUILDPROP"
    echo "     ..dmverity disabled"
    echo "$BUILDPROP" >> $SYSMOUNT/$SYSBUILDPROP
    echo "     ..tweaks added"
else
    echo "     ..'$SYSBUILDPROP' not found"
fi
}

####################
#PRISM/PRODUCT MODS#
####################
modprismproduct()
{
#DEBLOAT PRISM
echo "debloating prism & product";
if [ $device = "S22" ] || [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    debloatPPV
    echo "     ..'$device' Prism/Product debloated"
elif [ $device = "S10" ] || [ $device = "N10" ]; then
    s10debloatPPV
    echo "     ..'$device' Prism/Product debloated"
else
    echo "     ..No Prism/Product found for '$device'"
fi

#DISABLE SCS SERVICE
echo "disable SCS service";
PRISMINIT="prism/etc/init/init.rc"
PRODUCTINIT="product/etc/init/init.rc"
if [ $device = "S22" ] || [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    sed -i 's/start\sscs/stop\ scs/g' $PWD/$PRISMINIT
    echo "     ..SCS stopped"
elif [ $device = "S10" ] || [ $device = "N10" ]; then
    sed -i 's/start\sscs/stop\ scs/g' $PWD/$PRODUCTINIT
    echo "     ..SCS stopped"
else
    echo "     ..Failed to disable SCS service"
fi

#DECODE CSC FILES S10 N10
#OMC="product/omc"
#DECODE="disarm_tools/omc-decoder.jar"
#echo "decoding CSC files in product"
#if [ $device = "S10" ] || [ $device = "N10" ] ; then
#    if [ -d "$PWD/$OMC" ] && [ -f "$PWD/$DECODE" ]; then
#        java -jar $PWD/$DECODE -i $PWD/$OMC -o $PWD/$OMC
#        echo "     ..CSC files decoded"
#    else
#        echo "     ..No decode tool or omc folder found"
#    fi
#else
#    echo "     ..Skipped as only on S10 & N10 devices"
#fi
}

#VENDOR MODS
modvendor()
{
#DISABLE FRP & INCREASE FRAME BUFFER
VENDORBUILDPROP="vendor/build.prop"
echo "modding '$VENDORBUILDPROP'";
if [ -f "$PWD/$VENDORBUILDPROP" ]; then
    setProperty "ro.frp.pst" "" "$PWD/$VENDORBUILDPROP"
    echo "     ..frp disabled"
    setProperty "ro.surface_flinger.max_frame_buffer_acquired_buffers" "4" "$PWD/$VENDORBUILDPROP"
    echo "     ..frame buffer increased"
else
    echo "     ..'$VENDORBUILDPROP' not found"
fi

#DISABLE FRP AND GOOGLE REACTIVATION
UEVENTD="vendor/ueventd.rc"
echo "modding '$UEVENTD'";
if [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    sed -i -e 's/\/dev\/block\/by-name\/persist/#\/dev\/block\/by-name\/persist/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/platform\/13100000.ufs\/by-name\/persistent/#\/dev\/block\/platform\/13100000.ufs\/by-name\/persistent/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/platform\/13100000.ufs\/by-name\/steady/#\/dev\/block\/platform\/13100000.ufs\/by-name\/steady/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/platform\/13100000.ufs\/by-name\/param/#\/dev\/block\/platform\/13100000.ufs\/by-name\/param/g' $PWD/$UEVENTD
    echo "     ..FRP and Reactivation disabled for '$device'"
elif [ $device = "S22" ]; then
    sed -i -e 's/\/dev\/block\/by-name\/persist/#\/dev\/block\/by-name\/persist/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/by-name\/param/#\/dev\/block\/by-name\/param/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/by-name\/persistent/#\/dev\/block\/by-name\/persistent/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/by-name\/steady/#\/dev\/block\/by-name\/steady/g' $PWD/$UEVENTD
    echo "     ..FRP and Reactivation disabled for '$device'"
elif [ $device = "S10" ] || [ $device = "N10" ]; then
    sed -i -e 's/\/dev\/block\/by-name\/persist/#\/dev\/block\/by-name\/persist/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/platform\/13d60000.ufs\/by-name\/persistent/#\/dev\/block\/platform\/13d60000.ufs\/by-name\/persistent/g' $PWD/$UEVENTD
    sed -i -e 's/\/dev\/block\/platform\/13d60000.ufs\/by-name\/steady/#\/dev\/block\/platform\/13d60000.ufs\/by-name\/steady/g' $PWD/$UEVENTD
    echo "     ..FRP and Reactivation disabled for '$device'"
else
    echo "     ..'$UEVENTD' not found"
fi

#REMOVE VENDOR RECOVERY-FROM-BOOT
RECOVERY="vendor/recovery-from-boot.p"
if [ -f $PWD/$RECOVERY ]; then
    rm -f $PWD/$RECOVERY
    echo "     ..vendor recovery-from-boot removed"
else
    echo "     ..'$RECOVERY' not found"
fi

#MOD FSTAB ENCRYPTION OPTIONS
FSTAB="$(find $PWD/vendor/etc/ -maxdepth 1 -name "fstab.*" ! -name "fstab.ramplus" -exec basename {} \;)"
FSTABDIR="$PWD/vendor/etc"
echo "modding '$FSTAB'"
if [ $FSTAB = "fstab.exynos9820" ] || [ $FSTAB = "fstab.exynos9825" ] || [ $FSTAB = "fstab.exynos990" ]; then
    sed -i -e 's/fileencryption=ice/encryptable=ice/g' $FSTABDIR/$FSTAB
    sed -i -e 's/avb,//g' $FSTABDIR/$FSTAB
    sed -i -e 's/avb=vbmeta,//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi\.avbpubkey:\/avb\/s-gsi.avbpubkey//g' $FSTABDIR/$FSTAB
    echo "     ..'$device' encryption disabled"
elif [ $FSTAB = "fstab.s5e9925" ]; then
    sed -i -e 's/fileencryption=ice/encryptable=ice/g' $FSTABDIR/$FSTAB
    sed -i -e 's/fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0/encryptable=ice/g'  $FSTABDIR/$FSTAB
    sed -i -e 's/metadata_encryption=aes-256-xts:wrappedkey_v0,//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb,/,/g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=boot//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=vbmeta//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=dtbo//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=vendor_boot//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=vbmeta_system//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb=vbmeta_system//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,formattable_system/,formattable/g' $FSTABDIR/$FSTAB
    sed -i -e 's/first_stage_mount_system/first_stage_mount/g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi\.avbpubkey:\/avb\/s-gsi.avbpubkey//g' $FSTABDIR/$FSTAB
    echo "     ..'$device' encryption disabled"
elif [ $FSTAB = "fstab.exynos2100" ]; then
    sed -i -e 's/fileencryption=aes-256-xts:aes-256-cts:v2/encryptable=ice/g'  $FSTABDIR/$FSTAB
    sed -i -e 's/avb,//g' $FSTABDIR/$FSTAB
    sed -i -e 's/avb=vbmeta,//g' $FSTABDIR/$FSTAB
    sed -i -e 's/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi\.avbpubkey:\/avb\/s-gsi.avbpubkey//g' $FSTABDIR/$FSTAB
    echo "     ..'$device' encryption disabled"
else
    echo "     ..No '$device' FSTAB found"
fi

#DISABLE CASS
CASS="vendor/etc/init/cass.rc"
echo "modding '$CASS'"
if [ -f "$PWD/$CASS" ]; then
    sed -i 's/start\scass/stop\ cass/g' $PWD/$CASS
    echo "     ..CASS disabled"
else
    echo "     ..'$CASS' not found"
fi

#DISABLE PROCA
PROCA="vendor/etc/init/pa_daemon_teegris.rc"
echo "modding '$PROCA'"
if [ -f "$PWD/$PROCA" ]; then
    sed -i 's/start\sproca/stop\ proca/g' $PWD/$PROCA
    echo "     ..proca disabled"
else
    echo "     ..'$PROCA' not found"
fi

#DISABLE VAULTKEEPER
VAULT="vendor/etc/init/vaultkeeper_common.rc"
echo "modding '$VAULT'"
if [ -f "$PWD/$VAULT" ]; then
    sed -i 's/start\svaultkeeper/stop\ vaultkeeper/g' $PWD/$VAULT
    rm -f vendor/etc/vintf/manifest/vaultkeeper_manifest.xml
    rm -f vendor/bin/vaultkeeperd
    echo "     ..vaultkeeper disabled"
else
    echo "     ..'$VAULT' not found"
fi

#DISABLE WSM, SECURESTORAGE & PROCA
MANIFEST="vendor/etc/vintf/manifest.xml"
echo "modding '$MANIFEST'"
if [ $device = "S21" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.proca<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $PWD/$MANIFEST
    sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.wsm<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $PWD/$MANIFEST
    echo "     ..proca & wsm disabled"
elif [ $device = "S10" ] || [ $device = "N10" ]; then
    sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.proca<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $PWD/$MANIFEST
    sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.wsm<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $PWD/$MANIFEST
    sed -i -e '/<hal format="hidl">/{N;/<name>vendor\.samsung\.hardware\.security\.securestorage<\/name>/{:loop;N;/<\/hal>/!bloop;d}}' $PWD/$MANIFEST
    rm -f vendor/etc/vintf/manifest/wsm_manifest.xml
    echo "     ..proca, securestorage & wsm disabled"
else    
    echo "     ..'$MANIFEST' not found"
fi

#ADD FLOATING FEATURE (ADDITION FOR A12) BOTH SYSTEM & VENDOR
FLOAT="$SYSMOUNT/system/etc/floating_feature.xml"
VFLOAT="$PWD/vendor/etc/floating_feature.xml"
echo "modding '$FLOAT'"
if [ $device = "S10" ] || [ $device = "N10" ] || [ $device = "S20" ] || [ $device = "N20" ]; then
    sed -i -e '/<\/SecFloatingFeatureSet>/i    <SEC_FLOATING_FEATURE_LAUNCHER_CONFIG_ZERO_PAGE_PACKAGE_NAMES>com.google.android.googlequicksearchbox,com.samsung.android.app.spage<\/SEC_FLOATING_FEATURE_LAUNCHER_CONFIG_ZERO_PAGE_PACKAGE_NAMES>' $FLOAT
    sed -i -e '/<\/SecFloatingFeatureSet>/i    <SEC_FLOATING_FEATURE_LAUNCHER_CONFIG_ZERO_PAGE_PACKAGE_NAMES>com.google.android.googlequicksearchbox,com.samsung.android.app.spage<\/SEC_FLOATING_FEATURE_LAUNCHER_CONFIG_ZERO_PAGE_PACKAGE_NAMES>' $VFLOAT
    echo "     ..floating features added"
elif [ $device = "S21" ]; then
    echo "     ..Mod not needed on S21"
else    
    echo "     ..floating features not added"
fi

#DISABLE LIBOEMCRYPTO.SO
LIBOEM="vendor/lib64/liboemcrypto.so"
echo "modding '$LIBOEM'"
if [ -f "$PWD/$LIBOEM" ]; then
    mv $PWD/$LIBOEM $PWD/$LIBOEM.bak
    echo "     ..liboemcrypto modded"
else
    echo "     ..'$LIBOEM' not found"
fi
}

modoptics()
{
#DECODE CSC S20 S21 S22
OMC="optics/configs/carriers/"
DECODE="disarm_tools/omc-decoder.jar"
echo "decoding CSC files in Optics"
if [ -d "$PWD/optics" ]; then
    if [ -f "$PWD/$DECODE" ]; then
        java -jar $PWD/$DECODE -i $PWD/$OMC -o $PWD/$OMC
        echo "     ..CSC files decoded"
    else
        echo "     ..decode tool not found in '$DECODE'"
    fi
else
    echo "     ..no optics folder found"
fi
}

S20() {
modsystem
modprismproduct
modvendor
: 'Disabled for CRB
modoptics
'
deodex
cscfeature
}

S21() {
modsystem
modprismproduct
modvendor
: 'Disabled for CRB
modoptics
'
deodex
cscfeature
}

S22() {
modsystem
modprismproduct
modvendor
: 'Disabled for CRB
modoptics
'
deodex
cscfeature
}

S10() {
modsystem
modprismproduct
modvendor
deodex
cscfeature
}

N10() {
modsystem
modprismproduct
modvendor
deodex
cscfeature
}

N20() {
modsystem
modprismproduct
modvendor
deodex
cscfeature
}

: 'Disabled for CRB
NOTE: Do not remove this string which is used to read devices
read -p "Which device are you building for [N10,S10,N20,S20,S21,S22] " device
'
case "$device" in
    S20) 
        echo "Modding for '$device' device"
        S20 ;;
    s20) 
        echo "Modding for '$device' device"
        S20 ;;
    S21)
        echo "Modding for '$device' device"
        S21 ;;
    s21)
        echo "Modding for '$device' device"
        S21 ;;
    S22)
        echo "Modding for '$device' device"
        S22 ;;
    s22)
        echo "Modding for '$device' device"
        S22 ;;
    S10)
        echo "Modding for '$device' device"
        S10 ;;
    s10)
        echo "Modding for '$device' device"
        S10 ;;
    N10)
        echo "Modding for '$device' device"
        N10 ;;
    n10)
        echo "Modding for '$device' device"
        N10 ;;
    N20)
        echo "Modding for '$device' device"
        N20 ;;
    n20)
        echo "Modding for '$device' device"
        N20 ;;
    *) echo "The device $device is not currently supported" ;;
esac

echo "Modding Complete!"

