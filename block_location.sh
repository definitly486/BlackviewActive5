#!/bin/sh

for package in \
    video.player.videoplayer \
    org.dslul.openboard.inputmethod.latin \
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
    com.android.keychain
do
    echo "Blocking location: $package"

    if adb shell pm path "$package" >/dev/null 2>&1; then
        adb shell cmd appops set "$package" FINE_LOCATION ignore
        adb shell cmd appops set "$package" COARSE_LOCATION ignore
    else
        echo "  Package not installed, skipping."
    fi
done

echo "Done."
