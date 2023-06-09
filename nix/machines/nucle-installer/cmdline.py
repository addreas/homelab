#!/usr/bin/env python3
import sys, shlex, json

with open('/proc/cmdline', 'r') as cmdline:
    items = shlex.split(cmdline)

item_map = {
    kv[0]: "=".join(kv[1:]) if len(kv) > 1 else True
    for kv in [i.split("=") for i in items]
}

if "-j" in sys.argv or "--json" in sys.argv:
    print(json.dumps(item_map))
elif len(sys.argv) == 2 and sys.argv[1] in item_map:
    print(item_map[sys.argv[1]])
else:
    print('\n'.join(items))
