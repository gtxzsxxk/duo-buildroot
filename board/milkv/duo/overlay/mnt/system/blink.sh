#!/bin/sh

CONFIG=/etc/milkv-duo.conf
source ${CONFIG}

if test -d ${LED_PATH}; then
    echo "GPIO${LED_GPIO} already exported"
else
    ${DUO_WRITE} ${LED_GPIO} >/sys/class/gpio/export
fi

${DUO_WRITE} out >${LED_PATH}/direction

while true; do
    ${DUO_WRITE} 0 >${LED_PATH}/value
    sleep 0.5
    ${DUO_WRITE} 1 >${LED_PATH}/value
    sleep 0.5
done
