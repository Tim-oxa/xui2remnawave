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

echo "Запуск процесса миграции..."
% curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/main/main.py | python

echo "Очистка временных файлов..."
deactivate
rm -rf "$VENV_DIR"

echo "Миграция завершена!"
