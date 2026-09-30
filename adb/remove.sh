#!/bin/sh

# Blackview Active 5 — безопасное удаление необязательных пакетов
# FreeBSD + ADB
#
# ВАЖНО:
# Используется pm uninstall --user 0.
# Системный APK физически не удаляется из прошивки.

set -u

ADB="${ADB:-adb}"

echo "== Проверяем устройство =="
"$ADB" get-state || {
    echo "ADB не видит устройство."
    echo "Проверь USB debugging и adb devices."
    exit 1
}

echo ""
echo "== Список пакетов для удаления =="

PACKAGES="
com.blackview.weather
com.blackview.note
com.blackview.useguide
com.blackview.userfeedback
com.blackview.easytrans
com.blackview.searchcenter
com.blackview.appsedge
com.blackview.gamemode
com.blackview.applock
com.blackview.call.recorder
com.blackview.frozenapp
com.blackview.tool
com.blackview.powersavemode
com.google.android.youtube
com.google.android.apps.youtube.music
com.google.android.videos
com.google.android.apps.docs
com.google.android.apps.photos
com.google.android.apps.wellbeing
com.google.android.apps.tachyon
com.google.android.gm
com.google.android.apps.maps
"

# Google-приложения ниже пока НЕ удаляем.
# Их можно добавить после проверки, действительно ли они тебе не нужны.

for pkg in $PACKAGES
do
    echo ""
    echo ">>> $pkg"

    if "$ADB" shell pm path "$pkg" >/dev/null 2>&1; then
        "$ADB" shell pm uninstall --user 0 "$pkg"
    else
        echo "    не установлен — пропускаем"
    fi
done

echo ""
echo "== Готово =="
echo "Перезагрузи телефон:"
echo "    adb reboot"
