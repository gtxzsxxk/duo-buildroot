#!/bin/sh

/etc/uhubon.sh device >> /tmp/usb.log 2>&1
/etc/run_usb.sh probe msc /dev/mmcblk0p1 >> /tmp/usb.log 2>&1
/etc/run_usb.sh start >> /tmp/usb.log 2>&1

[ $? = 0 ] && echo "Mass Storage started successfully" || echo "Fail to start Mass Storage"