#!/bin/sh

CONFIG=/etc/milkv-duo.conf
source ${CONFIG}

if test -d ${LED_PATH}; then
    echo "GPIO${LED_GPIO} already exported"
else
    (echo ${LED_GPIO} >/sys/class/gpio/export) >/dev/null 2>&1
fi

(echo out >${LED_PATH}/direction) >/dev/null 2>&1

while true; do
    (echo 0 >${LED_PATH}/value) >/dev/null 2>&1
    sleep 0.5
    (echo 1 >${LED_PATH}/value) >/dev/null 2>&1
    sleep 0.5
done
