#!/bin/bash

# Мониторинг ресурсов системы
# Вариант Б из задания

INTERVAL=5
LOG_FILE="monitor.log"

echo "Запуск мониторинга. Интервал: ${INTERVAL} сек."

while true; do
    echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---" >> "$LOG_FILE"
    free -h >> "$LOG_FILE"
    df -h >> "$LOG_FILE"
    uptime >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    sleep "$INTERVAL"
done
