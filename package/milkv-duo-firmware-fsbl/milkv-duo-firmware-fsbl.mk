################################################################################
#
# milkv-duo-firmware-fsbl
#
################################################################################
MILKV_DUO_FIRMWARE_FSBL_VERSION = 4fab0be6930e4db216bea90d489c4d232b4b3cc3
MILKV_DUO_FIRMWARE_FSBL_SITE = $(call github,gtxzsxxk,milkv-duo-firmware-fsbl,$(MILKV_DUO_FIRMWARE_FSBL_VERSION))
MILKV_DUO_FIRMWARE_FSBL_INSTALL_STAGING = YES
MILKV_DUO_FIRMWARE_FSBL_DEPENDENCIES = host-python3

define MILKV_DUO_FIRMWARE_FSBL_BUILD_CMDS
	$(MAKE) -C $(@D) \
	ARCH=riscv BOOT_CPU=riscv CHIP_ARCH=cv180x \
	PROJECT_FULLNAME=cv1800b_milkv_duo_sd \
	CROSS_COMPILE=$(TARGET_CROSS) \
	bl2
endef

define MILKV_DUO_FIRMWARE_FSBL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/cv180x/bl2.bin ${BINARIES_DIR}/bl2.bin
	$(INSTALL) -D -m 0755 $(@D)/plat/cv180x/chip_conf.bin ${BINARIES_DIR}/chip_conf.bin
	$(INSTALL) -D -m 0755 $(@D)/plat/cv180x/fiptool.py ${BINARIES_DIR}/fiptool.py
	$(INSTALL) -D -m 0644 $(@D)/plat/cv180x/multi.its ${BINARIES_DIR}/multi.its
	$(INSTALL) -D -m 0755 $(@D)/test/cv181x/ddr_param.bin ${BINARIES_DIR}/ddr_param.bin
endef

$(eval $(generic-package))