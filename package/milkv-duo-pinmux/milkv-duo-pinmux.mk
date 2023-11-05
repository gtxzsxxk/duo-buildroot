################################################################################
#
# milkv-duo-pinmux
#
################################################################################

MILKV_DUO_PINMUX_VERSION = c0e32327aaf13490437f485a3fb04bbb4c60f00f
MILKV_DUO_PINMUX_SITE = $(call github,milkv-duo,milkv-duo-pinmux,$(MILKV_DUO_PINMUX_VERSION))

define MILKV_DUO_PINMUX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-I $(@D)/include $(@D)/src/*.c -o $(@D)/duo-pinmux
endef

define MILKV_DUO_PINMUX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/duo-pinmux $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
