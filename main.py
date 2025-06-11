import datetime as dt
import httpx
import json
import re

xui_url = input("3X-UI panel url: ")
if xui_url.endswith("/"):
    xui_url = xui_url[:-1]
xui_username = input("3X-UI username: ")
xui_password = input("3X-UI password: ")

remna_url = input("Remnawave panel url: ")
if remna_url.endswith("/"):
    remna_url = remna_url[:-1]
remna_token = input("Remnawave API token: ")

inbound_id = input("3X-UI inbound id: ")


remna_url += "/api"

xui = httpx.Client()
xui.post(xui_url + "/login", data={
    "username": xui_username,
    "password": xui_password
})

remna = httpx.Client(headers={
    "Content-Type": "application/json",
    "X-Forwarded-Proto": "https",
    "X-Forwarded-For": "127.0.0.1",
    "Authorization": "Bearer " + remna_token
})

response = remna.post(f"{remna_url}/users", json=data)
response.raise_for_status() 
print(response.text)
    