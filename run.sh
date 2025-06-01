#!/bin/bash

set -e

VENV_DIR="$HOME/xui2remnawave-env"
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}[1/6] Обновление пакетов...${NC}"
sudo apt update

echo -e "${GREEN}[2/6] Установка Python, pip и необходимых пакетов...${NC}"
sudo apt install -y python3-full python3-venv python3-pip curl

echo -e "${GREEN}[3/6] Создание виртуального окружения...${NC}"
python3 -m venv "$VENV_DIR"

echo -e "${GREEN}[4/6] Активация окружения и установка httpx...${NC}"
source "$VENV_DIR/bin/activate"
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install httpx

echo -e "${GREEN}[5/6] Запуск скрипта...${NC}"
curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/main/main.py | "$VENV_DIR/bin/python"

echo -e "${GREEN}[6/6] Готово! Скрипт завершил работу.${NC}"
