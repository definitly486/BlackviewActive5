adb shell cmd wifi connect-network "HUAWEI-B315-AFCA" wpa2 "HR63B1DMTJ4"
adb shell settings put global low_power 1
adb shell pm disable-user --user 0 com.google.android.gms
adb shell cmd audio set-ringer-mode SILENT
adb shell pm disable-user --user 0 com.google.android.sdksandbox
adb shell pm disable-user --user 0 com.google.android.uwb.resources
adb shell pm disable-user --user 0 com.google.android.cellbroadcastreceiver
adb shell pm disable-user --user 0 com.android.cellbroadcastreceiver
adb shell pm disable-user --user 0 com.android.cellbroadcast.overlay
adb shell settings put global auto_time_zone 0
adb shell cmd alarm set-timezone Europe/Moscow