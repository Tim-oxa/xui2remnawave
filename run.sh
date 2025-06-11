#!/bin/bash
set -e

VENV_DIR=$(mktemp -d)
TEMP_FILE="main.py"

cleanup() {
    echo "Очистка временных файлов..."
    deactivate 2>/dev/null || true
    rm -rf "$VENV_DIR"
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

echo "Подготовка окружения..."
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

echo "Установка зависимостей..."
pip install httpx

echo "Скачивание скрипта..."
curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/test/main.py -o "$TEMP_FILE"

echo "Запуск..."
python "$TEMP_FILE" < /dev/tty > /dev/tty

echo "Миграция завершена!"
