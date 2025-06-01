#!/bin/bash

apt update && apt install -y python3 python3-pip curl

pip3 install httpx

curl -sSL https://raw.githubusercontent.com/Tim-oxa/xui2remnawave/refs/heads/main/main.py | python3
