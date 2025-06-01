#!/bin/bash

set -e

# Путь к виртуальному окружению
VENV_DIR="$HOME/xui2remnawave-env"

# Цветной вывод
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}[1/5] Обновление пакетов...${NC}"
sudo apt update

echo -e "${GREEN}[2/5] Установка Python и venv...${NC}"
sudo apt install -y python3 python3-venv curl

echo -e "${GREEN}[3/5] Создание виртуального окружения...${NC}"
python3 -m venv "$VENV_DIR"

echo -e "${GREEN}[4/5] Активация окружения и установка зависимостей...${NC}"
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install httpx

echo -e "${GREEN}[5/5] Загрузка и запуск скрипта...${NC}"
curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/main/main.py | python

echo -e "${GREEN}✅ Готово! Скрипт завершил работу.${NC}"
