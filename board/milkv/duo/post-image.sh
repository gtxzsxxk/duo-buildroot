#!/bin/sh

###########################################################
# File: post-image.sh
# Author: GP Orcullo <kinsamanka@gmail.com>
# Description: this sh will make the fip.bin and boot.sd,
#              then pack everything to an image file.
###########################################################
if grep -Eq "^BR2_PACKAGE_MILKV_DUO_FIRMWARE_FSBL=y$" ${BR2_CONFIG}; then
    if grep -Eq "^BR2_PACKAGE_MILKV_DUO_SMALLCORE_FREERTOS=y$" ${BR2_CONFIG}; then
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
        --BLCP=${BINARIES_DIR}/empty.bin \
        --BLCP_2ND=${BINARIES_DIR}/cvirtos.bin \
        --BLCP_2ND_RUNADDR=0x83f40000 \
        > ${BINARIES_DIR}/fip.log 2>&1
        echo "[Duo Post-Image fiptool.py] FreeRTOS integrated"
    else
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
        echo "[Duo Post-Image fiptool.py] No FreeRTOS integrated"
    fi

    cp ${BINARIES_DIR}/u-boot.dtb ${BINARIES_DIR}/cv1800b_milkv_duo_sd.dtb
    lzma -fk ${BINARIES_DIR}/Image
    mkimage -f ${BINARIES_DIR}/multi.its ${BINARIES_DIR}/boot.sd
    echo "[Duo Post-Image] > boot.sd generated!"
    support/scripts/genimage.sh -c $(pwd)/board/milkv/duo/genimage.cfg
    gzip -fk ${BINARIES_DIR}/sdcard.img
    echo "[Duo Post-Image] > sdcard.img generated!"
else
    echo "[Duo Post-Image] Not requested to generate the boot files and sdcard.img"
fi