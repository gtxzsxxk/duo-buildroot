################################################################################
#
# milkv-duo-smallcore-freertos
#
################################################################################

MILKV_DUO_SMALLCORE_FREERTOS_VERSION = 1dac21ade58b0f9a0a531cfe93ee319337a88d80
MILKV_DUO_SMALLCORE_FREERTOS_SITE = $(call github,milkv-duo,milkv-duo-smallcore-freertos,$(MILKV_DUO_SMALLCORE_FREERTOS_VERSION))
MILKV_DUO_SMALLCORE_FREERTOS_INSTALL_STAGING = YES
MILKV_DUO_SMALLCORE_FREERTOS_DEPENDENCIES = host-cmake host-ninja
MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV = CROSS_COMPILE=$(TARGET_CROSS)

define MILKV_DUO_SMALLCORE_FREERTOS_BUILD_CMDS
	if [ ! -d $(@D)/cvitek/build/arch ]; then \
		mkdir -p $(@D)/cvitek/build/arch; \
	fi

	cd $(@D)/cvitek/build/arch && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DTOP_DIR=$(@D)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DRUN_ARCH=riscv64 \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(@D)/cvitek/arch
	cd $(@D)/cvitek/build/arch && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v

	if [ ! -d $(@D)/cvitek/build/kernel ]; then \
		mkdir -p $(@D)/cvitek/build/kernel; \
	fi

	cd $(@D)/cvitek/build/kernel && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(@D)/cvitek \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(@D)/cvitek/kernel
	cd $(@D)/cvitek/build/kernel && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v

	if [ ! -d $(@D)/cvitek/build/common ]; then \
		mkdir -p $(@D)/cvitek/build/common; \
	fi

	cd $(@D)/cvitek/build/common && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(@D)/cvitek \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(@D)/cvitek/common
	cd $(@D)/cvitek/build/common && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v

	if [ ! -d $(@D)/cvitek/build/hal ]; then \
		mkdir -p $(@D)/cvitek/build/hal; \
	fi

	cd $(@D)/cvitek/build/hal && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(@D)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		-DBOARD_FPGA=n \
		$(@D)/cvitek/hal/cv180x
	cd $(@D)/cvitek/build/hal && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v

	if [ ! -d $(@D)/cvitek/build/driver ]; then \
		mkdir -p $(@D)/cvitek/build/driver; \
	fi

	cd $(@D)/cvitek/build/driver && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(@D)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DBOARD_FPGA=n \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(@D)/cvitek/driver
	cd $(@D)/cvitek/build/driver && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v

	if [ ! -d $(@D)/cvitek/build/task ]; then \
		mkdir -p $(@D)/cvitek/build/task; \
	fi

	cd $(@D)/cvitek/build/task && \
	$(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DRUN_TYPE=CVIRTOS \
		-DTOP_DIR=$(@D)/cvitek \
		-DBUILD_ENV_PATH=$(@D)/cvitek/build \
		-DBOARD_FPGA=n \
		-DCMAKE_TOOLCHAIN_FILE=$(@D)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(@D)/cvitek/task
	cd $(@D)/cvitek/build/task && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target install -- -v
	cd $(@D)/cvitek/build/task && $(TARGET_MAKE_ENV) $(MILKV_DUO_SMALLCORE_FREERTOS_CONF_ENV) $(BR2_CMAKE) --build . --target cvirtos.bin -- -v
endef

define MILKV_DUO_SMALLCORE_FREERTOS_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/cvitek/install/bin/cvirtos.bin $(BINARIES_DIR)/cvirtos.bin
	if [ ! -e $(BINARIES_DIR)/empty.bin ]; then \
		touch $(BINARIES_DIR)/empty.bin; \
	fi
endef

$(eval $(generic-package))
