import datetime as dt
import httpx
import json
import re

xui_url = input("3X-UI panel url: ")
xui_username = input("3X-UI username: ")
xui_password = input("3X-UI password: ")

remna_url = input("Remnawave panel url: ")
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
    "Authorization": "Bearer " + remna_token
})

username_pattern = re.compile("^[a-zA-Z0-9_-]+$")

users = json.loads(xui.get(xui_url + f"/panel/api/inbounds/get/{inbound_id}").json()["obj"]["settings"])["clients"]
for user in users:
    data = {}

    if username_pattern.match(user["email"]) and len(user["email"]) >= 6:
        data.setdefault("username", user["email"])
    else:
        data.setdefault("username", user["id"].split("-")[0])

    if user["comment"]:
        data.setdefault("description", user["comment"])

    data.setdefault("status", "ACTIVE" if user["enable"] else "DISABLE")

    uid = user["id"]

    data.setdefault("vlessUuid", user["id"])

    if user["expiryTime"]:
        data.setdefault("expireAt", dt.datetime.fromtimestamp(user["expiryTime"] / 1000).isoformat())
    else:
        data.setdefault("expireAt", dt.datetime.today().replace(year=2099).isoformat())

    data.setdefault("trafficLimitBytes", user["totalGB"])

    if user["subId"]:
        data.setdefault("shortUuid", user["subId"])

    data.setdefault("tag", "XUI")

    r = remna.post(remna_url + "/users", json=data)
    if r.status_code == 201:
        print(f"User {user['email']} was added as {data['username']}")
    else:
        print(f"ERROR {user['email']} -", r.text)
