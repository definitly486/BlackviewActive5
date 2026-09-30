#!/bin/sh

killall -9 adb 2>/dev/null

dir=$(dirname "$(realpath "$0")")
n=0
log="$dir/remove_result.log"

# Очищаем лог перед новым запуском
: > "$log"

exec 3< "$dir/list_for_remove"

while IFS= read -r i <&3; do
    [ -z "$i" ] && continue

    n=$((n + 1))

    echo
    echo "[$n] Удаляем: $i" | tee -a "$log"

    result=$(adb shell pm uninstall --user 0 "$i" 2>&1)
    echo "$result" | tee -a "$log"

    sleep 0.1
done

exec 3<&-

echo
echo "Удаление завершено. Всего обработано: $n" | tee -a "$log"
echo "Лог сохранён: $log"