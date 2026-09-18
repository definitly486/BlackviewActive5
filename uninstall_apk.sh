#!/bin/sh
killall -9 adb
dir=$(dirname "$(realpath $0)")

  for i in $(cat $dir/user_apps_nopath.txt ); do

            adb shell pm uninstall --user 0   $i 

done