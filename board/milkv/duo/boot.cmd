set bootargs root=/dev/mmcblk0p2 rootwait rw \
console=ttyS0,115200 earlycon=sbi loglevel=9 \
riscv.fwsz=0x80000

set bootsd_addr "0x81400000"
set fdt_filename "cv1800b_milkv_duo_sd"
mmc dev 0

echo > Loading Kernel and FDT...
fatload mmc 0 ${bootsd_addr} boot.sd

echo > Booting System...
bootm ${bootsd_addr}#config-${fdt_filename}