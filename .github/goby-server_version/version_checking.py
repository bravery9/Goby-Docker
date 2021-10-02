#!/usr/bin/env python
# _*_ coding: utf-8 _*_
import os, re, requests, platform
code_server_version =  requests.get("https://api.github.com/repos/gobysec/Goby/releases/latest").json()["tag_name"]
if code_server_version == open(".github/goby-server_version/goby-server_version").read():
    print("It's the latest edition! version: " + code_server_version)
    os._exit("It's the latest edition!")
else:
    open(".github/goby-server_version/goby-server_version", "w").write(code_server_version)