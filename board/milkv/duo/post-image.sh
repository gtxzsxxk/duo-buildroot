#!/bin/sh

###########################################################
# File: post-image.sh
# Author: GP Orcullo <kinsamanka@gmail.com>
# Description: this sh will make the fip.bin and boot.sd,
#              then pack everything to an image file.
###########################################################

./fiptool.py genfip fip.bin \
    --MONITOR_RUNADDR=0x80000000 \
    --CHIP_CONF=chip_conf.bin \
    --NOR_INFO=FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF \
    --NAND_INFO=00000000 \
    --BL2=bl2.bin \
    --BLCP_IMG_RUNADDR=0x05200200 \
    --BLCP_PARAM_LOADADDR=0 \
    --DDR_PARAM=ddr_param.bin \
    --MONITOR=fw_dynamic.bin \
    --LOADER_2ND=u-boot.bin

lzma -fk ${BINARIES_DIR}/Image
mkimage -f ${BINARIES_DIR}/multi.its ${BINARIES_DIR}/boot.sd
support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg
gzip -fk ${BINARIES_DIR}/milkv-duo_sdcard.img