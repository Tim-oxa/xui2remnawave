#!/bin/bash

echo "Подготовка окружения..."
VENV_DIR=$(mktemp -d)
python3 -m venv "$VENV_DIR" || exit 1
source "$VENV_DIR/bin/activate" || exit 1

echo "Установка зависимостей..."
pip install httpx > /dev/null || {
    echo "Ошибка установки httpx"
    exit 1
}

echo "Загрузка скрипта миграции..."
SCRIPT_FILE="$VENV_DIR/main.py"
curl -s "https://github.com/Tim-oxa/xui2remnawave/raw/main/main.py" -o "$SCRIPT_FILE" || {
    echo "Ошибка скачивания скрипта"
    exit 1
}

echo "Запуск процесса миграции..."
python3 "$SCRIPT_FILE"

echo "Очистка временных файлов..."
deactivate
rm -rf "$VENV_DIR"

echo "Миграция завершена!"
