#!/bin/sh
#
# install_apks.sh — установка всех APK из указанной папки через adb
# Использование: ./install_apks.sh /path/to/apk_folder

set -e

APK_DIR="${1:-.}"

if ! command -v adb >/dev/null 2>&1; then
    echo "Ошибка: adb не найден в PATH." >&2
    echo "Установите через: pkg install android-tools-adb" >&2
    exit 1
fi

if [ ! -d "$APK_DIR" ]; then
    echo "Ошибка: папка '$APK_DIR' не существует." >&2
    exit 1
fi

# Получаем serial подключённого устройства
DEVICE_SERIALS=$(adb devices | awk '$2 == "device" {print $1}')
DEVICE_COUNT=$(printf '%s\n' "$DEVICE_SERIALS" | grep -c . || true)

if [ "$DEVICE_COUNT" -eq 0 ]; then
    echo "Ошибка: не найдено ни одного подключённого устройства." >&2
    echo "Проверьте 'adb devices' и разрешение отладки по USB." >&2
    exit 1
fi

if [ "$DEVICE_COUNT" -gt 1 ]; then
    echo "Ошибка: подключено несколько устройств:" >&2
    printf '%s\n' "$DEVICE_SERIALS" >&2
    echo "Используйте adb -s SERIAL или выберите устройство в скрипте." >&2
    exit 1
fi

DEVICE_SERIAL=$(printf '%s\n' "$DEVICE_SERIALS")

echo "Устройство: $DEVICE_SERIAL"
echo "Папка с APK: $APK_DIR"
echo "----------------------------------------"

TOTAL=0
OK=0
FAIL=0
FAILED_LIST=""

for apk in "$APK_DIR"/*.apk; do
    [ -e "$apk" ] || continue

    TOTAL=$((TOTAL + 1))
    NAME=$(basename "$apk")

    echo "[$TOTAL] Устанавливаю: $NAME"

    if LOG=$(adb -s "$DEVICE_SERIAL" install -r "$apk" 2>&1); then
        echo "    -> OK"
        OK=$((OK + 1))
    else
        echo "    -> ОШИБКА"
        printf '%s\n' "$LOG" | sed 's/^/       /'

        FAIL=$((FAIL + 1))

        if [ -n "$FAILED_LIST" ]; then
            FAILED_LIST="$FAILED_LIST
  - $NAME"
        else
            FAILED_LIST="  - $NAME"
        fi
    fi

    echo "----------------------------------------"
done

echo ""
echo "Готово. Всего файлов: $TOTAL | Успешно: $OK | С ошибками: $FAIL"

if [ "$FAIL" -gt 0 ]; then
    echo ""
    echo "Не удалось установить:"
    printf '%s\n' "$FAILED_LIST"
fi

if [ "$TOTAL" -eq 0 ]; then
    echo "В папке '$APK_DIR' не найдено .apk файлов."
fi

# Возвращаем ненулевой код, если хотя бы один APK не установился.
[ "$FAIL" -eq 0 ]
