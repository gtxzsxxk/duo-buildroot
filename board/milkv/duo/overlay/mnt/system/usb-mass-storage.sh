#!/bin/sh

CONFIG=/etc/milkv-duo.conf
source ${CONFIG}

/etc/uhubon.sh device >> /tmp/usb.log 2>&1
/etc/run_usb.sh probe msc ${DUO_USB_MASS_STORAGE_ROOT} >> /tmp/usb.log 2>&1
/etc/run_usb.sh start >> /tmp/usb.log 2>&1

[ $? = 0 ] && echo "Mass Storage started successfully" || echo "Fail to start Mass Storage"
