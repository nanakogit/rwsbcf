#!/bin/sh

# replace UUID in config file
sed -i "s/PASTE_YOUR_UUID_HERE/$UUID/g" config.json

# run sing-box in background
sing-box run -c config.json &

# run Cloudflare Tunnel
cloudflared tunnel --no-autoupdate run --token $ARGO_TOKEN
