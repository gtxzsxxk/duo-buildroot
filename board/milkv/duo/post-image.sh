#!/bin/sh

###########################################################
# File: post-image.sh
# Author: GP Orcullo <kinsamanka@gmail.com>
# Description: this sh will make the fip.bin and boot.sd,
#              then pack everything to an image file.
###########################################################

${BINARIES_DIR}/fiptool.py genfip ${BINARIES_DIR}/fip.bin \
    --MONITOR_RUNADDR=0x80000000 \
    --CHIP_CONF=${BINARIES_DIR}/chip_conf.bin \
    --NOR_INFO=FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF \
    --NAND_INFO=00000000 \
    --BL2=${BINARIES_DIR}/bl2.bin \
    --BLCP_IMG_RUNADDR=0x05200200 \
    --BLCP_PARAM_LOADADDR=0 \
    --DDR_PARAM=${BINARIES_DIR}/ddr_param.bin \
    --MONITOR=${BINARIES_DIR}/fw_dynamic.bin \
    --LOADER_2ND=${BINARIES_DIR}/u-boot.bin \
    > ${BINARIES_DIR}/fip.log 2>&1

cp ${BINARIES_DIR}/u-boot.dtb ${BINARIES_DIR}/cv1800b_milkv_duo_sd.dtb
lzma -fk ${BINARIES_DIR}/Image
mkimage -f ${BINARIES_DIR}/multi.its ${BINARIES_DIR}/boot.sd
echo "> boot.sd generated!"
support/scripts/genimage.sh -c $(pwd)/board/milkv/duo/genimage.cfg
gzip -fk ${BINARIES_DIR}/sdcard.img