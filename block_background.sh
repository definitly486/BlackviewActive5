#!/bin/sh

for package in \
    org.dslul.openboard.inputmethod.latin \
    ru.yandex.yandexmaps \
    com.deniscerri.ytdl \
    org.cromite.cromite \
    com.ghisler.android.TotalCommander \
    org.wisso.newpipematerial \
    com.qflair.browserq \
    org.amnezia.vpn \
    org.fossify.messages \
    com.simplemobiletools.contacts.pro \
    com.simplemobiletools.dialer \
    com.saggitt.omega \
    dev.imranr.obtainium.fdroid \
    net.sourceforge.opencamera \
    com.brouken.player \
    org.schabi.newpipe \
    org.sufficientlysecure.keychain \
    com.blackview.launcher
do
    echo "Blocking background: $package"
        adb shell pm revoke "$package" android.permission.POST_NOTIFICATIONS
        adb shell pm set-permission-flags "$package" android.permission.POST_NOTIFICATIONS user-set user-fixed
    adb shell cmd appops set "$package" RUN_IN_BACKGROUND ignore
    adb shell cmd appops set "$package" RUN_ANY_IN_BACKGROUND ignore
done

echo "Done."

adb shell ime enable org.dslul.openboard.inputmethod.latin/.LatinIME
adb shell ime set    org.dslul.openboard.inputmethod.latin/.LatinIME
