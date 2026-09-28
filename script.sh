#!/bin/bash

# Мониторинг ресурсов системы
# Вариант Б из задания
# Автор: Иван

# Константа: интервал в секундах
INTERVAL=5
LOG_FILE="monitor.log"

if [ ! -w "$(pwd)" ]; then
    echo "Ошибка: нет прав на запись в текущую директорию $(pwd)" >&2
    exit 1
fi

touch "$LOG_FILE" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Ошибка: не удалось создать файл лога $LOG_FILE" >&2
    exit 1
fi

cleanup() {
    echo ""
    echo "Мониторинг остановлен. Лог сохранён в $LOG_FILE"
    exit 0
}
trap cleanup SIGINT SIGTERM

echo "=== Мониторинг ресурсов системы ==="
echo "Интервал: ${INTERVAL} сек."
echo "Лог-файл: $LOG_FILE"
echo "Для остановки нажмите Ctrl+C"
echo "===================================="

while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        echo "[MEMORY]"
        free -h
        echo "[DISK]"
        df -h
        echo "[UPTIME]"
        uptime
        echo ""
    } >> "$LOG_FILE"
    
    echo "[$(date '+%H:%M:%S')] Данные записаны в $LOG_FILE"
    sleep "$INTERVAL"
done
