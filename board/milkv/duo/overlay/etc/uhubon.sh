CONFIG=/etc/milkv-duo.conf
source ${CONFIG}

hub_on() {
  echo "turn on usb hub"
  if [ ! -d $SYS_GPIO/gpio$GPIO_HUBPORT_EN ]; then
      ${DUO_WRITE} $GPIO_HUBPORT_EN >/sys/class/gpio/export
  fi

  if [ ! -d $SYS_GPIO/gpio$GPIO_ROLESEL ]; then
      ${DUO_WRITE} $GPIO_ROLESEL >/sys/class/gpio/export
  fi

  if [ ! -d $SYS_GPIO/gpio$GPIO_HUBRST ]; then
      ${DUO_WRITE} $GPIO_HUBRST >/sys/class/gpio/export
  fi

  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_HUBPORT_EN/direction
  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_ROLESEL/direction
  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_HUBRST/direction

  ${DUO_WRITE} 1 >/sys/class/gpio/gpio$GPIO_HUBPORT_EN/value
  ${DUO_WRITE} 0 >/sys/class/gpio/gpio$GPIO_ROLESEL/value
  ${DUO_WRITE} 0 >/sys/class/gpio/gpio$GPIO_HUBRST/value
}

hub_off() {
  echo "turn off usb hub"
  if [ ! -d $SYS_GPIO/gpio$GPIO_HUBPORT_EN ]; then
      ${DUO_WRITE} $GPIO_HUBPORT_EN >/sys/class/gpio/export
  fi

  if [ ! -d $SYS_GPIO/gpio$GPIO_ROLESEL ]; then
      ${DUO_WRITE} $GPIO_ROLESEL >/sys/class/gpio/export
  fi

  if [ ! -d $SYS_GPIO/gpio$GPIO_HUBRST ]; then
      ${DUO_WRITE} $GPIO_HUBRST >/sys/class/gpio/export
  fi

  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_HUBPORT_EN/direction
  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_ROLESEL/direction
  ${DUO_WRITE} "out" >/sys/class/gpio/gpio$GPIO_HUBRST/direction

  ${DUO_WRITE} 0 >/sys/class/gpio/gpio$GPIO_HUBPORT_EN/value
  ${DUO_WRITE} 1 >/sys/class/gpio/gpio$GPIO_ROLESEL/value
  ${DUO_WRITE} 1 >/sys/class/gpio/gpio$GPIO_HUBRST/value
}

inst_mod() {
  insmod /mnt/system/ko/configfs.ko
  insmod /mnt/system/ko/libcomposite.ko
  insmod /mnt/system/ko/u_serial.ko
  insmod /mnt/system/ko/usb_f_acm.ko
  insmod /mnt/system/ko/cvi_usb_f_cvg.ko
  insmod /mnt/system/ko/usb_f_uvc.ko
  insmod /mnt/system/ko/usb_f_fs.ko
  insmod /mnt/system/ko/u_audio.ko
  insmod /mnt/system/ko/usb_f_uac1.ko
  insmod /mnt/system/ko/usb_f_serial.ko
  insmod /mnt/system/ko/usb_f_mass_storage.ko
  insmod /mnt/system/ko/u_ether.ko
  insmod /mnt/system/ko/usb_f_ecm.ko
  insmod /mnt/system/ko/usb_f_eem.ko
  insmod /mnt/system/ko/usb_f_rndis.ko
}

case "$1" in
  host)
	insmod /mnt/system/ko/dwc2.ko
  ${DUO_WRITE} host > /proc/cviusb/otg_role
	;;
  device)
	${DUO_WRITE} device > /proc/cviusb/otg_role
	;;
  *)
	echo "Usage: $0 host"
	echo "Usage: $0 device"
	exit 1
esac
exit $?
