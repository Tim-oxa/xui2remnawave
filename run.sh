#!/bin/bash
set -e

echo "Подготовка окружения..."
VENV_DIR=$(mktemp -d)
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

echo "Установка зависимостей..."
pip install httpx

echo "Скачивание скрипта..."
curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/main/main.py -o main.py

echo "Запуск..."
python main.py < /dev/tty > /dev/tty

echo "Очистка временных файлов..."
deactivate
rm -rf "$VENV_DIR" main.py

echo "Миграция завершена!"
