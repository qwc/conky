#! /usr/bin/env python3

import os
import json
import re


def replace_multi(string, value_dict: dict):
    target = (string + '')[:-1]
    for k, v in value_dict.items():
        target = target.replace(k, v)
    return target


template = """${font StyleBats:size=20}tpl_icon${font}${offset 8}${voffset -12}tpl_name: ${alignr}${offset -10}${fs_used tpl_mp} / ${fs_size tpl_mp}${alignr}${fs_bar tpl_mp}
${offset 30}I/O R: ${alignr}${offset -10}${diskio_read tpl_dev}${alignr}${diskiograph_read tpl_dev 8,100}
${offset 30}I/O W: ${alignr}${offset -10}${diskio_write tpl_dev}${alignr}${diskiograph_write tpl_dev 8,100}
# ${offset 30}I/O ${alignr}${offset -30}W: ${alignr}${offset -10}${diskio_write tpl_dev}${alignr}${offset -30}${diskiograph_write tpl_dev 8,50 -l} \
# ${alignr}${offset -20}R: ${alignr}${offset -10}${diskio_read tpl_dev}${alignr}${diskiograph_read tpl_dev 8,50 -l}
"""  # noqa


fstab = None

with open("/etc/fstab", "r") as input:
    fstab = input.read()

fstab = fstab.replace("\t", " ")

fstab_lines = fstab.split("\n")
relevant_lines = []
for l in fstab_lines:
    if l != "" and l[0] != "#":
        relevant_lines.append(l)

options = ["dev", "mp", "fs", "options", "dump", "pass"]
fstab_settings = []
for line in relevant_lines:
    fstab_settings.append(dict(zip(options, re.split(" +", line))))

tpl_settings = ["tpl_icon", "tpl_name", "tpl_mp", "tpl_fs", "tpl_dev"]

for setting in fstab_settings:
    if (
        "//" in setting.get("dev") or
        "swap" == setting.get("fs") or
        "proc" == setting.get("fs") or
        "tmpfs" == setting.get("dev") or
        "/boot" == setting.get("mp")
    ):
        # skip cifs things
        continue
    # print(json.dumps(setting, indent=4))
    icon = "4"
    if "ordered" in setting.get("options"):
        icon = "e"
    dev = None
    dev_prefix = ""
    if "LABEL" in setting.get("dev"):
        dev_prefix = "/dev/disk/by-label/"
        dev = setting.get("dev").split("=")[1]
    elif "UUID" in setting.get("dev"):
        dev_prefix = "/dev/disk/by-uuid/"
        dev = setting.get("dev").split("=")[1]
    else:
        dev = setting.get("dev")
    dev = os.path.normpath(
        os.path.join(
            os.path.dirname(dev_prefix),
            os.readlink(dev_prefix + dev)
        )
    )
    name = setting.get("mp")
    if "media" in name:
        name = name.replace("/media/", "")
    print(replace_multi(template, dict(zip(
        tpl_settings,
        [
            icon,
            name,
            setting.get("mp"),
            setting.get("fs"),
            dev
        ]
    ))))

# print(template)
