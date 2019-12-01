#! /usr/bin/env python3

fstab = None

with open("/etc/fstab", "r") as input:
    fstab = input.read()

fstab_lines = fstab.split("\n")
relevant_lines = []
for l in fstab_lines:
    if l[0] != "#" and l != "":
        relevant_lines.append(l)

template="""${font StyleBats:size=20}e${font}${offset 8}${voffset -12}tpl_name  -  tpl_typ: ${alignr}${offset -10}${fs_used tpl_mp} tpl_mp ${fs_size tpl_mp}${alignr}${fs_bar tpl_mp}
${offset 30}I/O Read: ${alignr}${offset -10}${diskio_read tpl_dev}${alignr}${diskiograph_read tpl_dev 8,100}
${offset 30}I/O Write: ${alignr}${offset -10}${diskio_write tpl_dev}${alignr}${diskiograph_write tpl_dev 8,100}"""

print(template)
