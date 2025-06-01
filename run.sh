#!/bin/bash

VENV_DIR=$(mktemp -d)
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

pip install httpx > /dev/null

curl -s "https://github.com/Tim-oxa/xui2remnawave/raw/refs/heads/main/main.py" | python3

deactivate
rm -rf "$VENV_DIR"
