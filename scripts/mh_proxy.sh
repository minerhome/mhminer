#!/bin/bash


if ps aux | grep 'mh_proxy'; then
    echo "mh_proxy already running."
    exit 1
else
    cd /root/mh_proxy
    chmod +x *
    nohup ./mh_proxy >> mh_proxy.log 2>&1 &
fi




