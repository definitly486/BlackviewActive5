#!/bin/sh

for package in \
    video.player.videoplayer \
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
    org.schabi.newpipe
do
    echo "Blocking background: $package"

    adb shell cmd appops set "$package" RUN_IN_BACKGROUND ignore
    adb shell cmd appops set "$package" RUN_ANY_IN_BACKGROUND ignore
done

echo "Done."
