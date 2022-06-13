################################################################################
#
# xpadneo
#
################################################################################
XPADNEO_VERSION = v0.9.2
XPADNEO_SITE = $(call github,atar-axis,xpadneo,$(XPADNEO_VERSION))
XPADNEO_IS_KERNEL_PKG=yes

define XPADNEO_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) modules -C $(@D)/hid-xpadneo -f Makefile VERBOSE=1
endef

define XPADNEO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/modules/kver/kernel/drivers/hid
		cp -v $(@D)/hid-xpadneo/src/*.ko $(TARGET_DIR)/lib/modules/$(KVER)/kernel/drivers/hid/

	mkdir -p $(TARGET_DIR)/usr/lib/udev/rules.d
		cp -v $(@D)/hid-xpadneo/etc-udev-rules.d/*.rules $(TARGET_DIR)/usr/lib/udev/rules.d/

	mkdir -p $(TARGET_DIR)/usr/lib/modprobe.d
		cp -v $(@D)/hid-xpadneo/etc-modprobe.d/*.conf $(TARGET_DIR)/usr/lib/modprobe.d/
		echo "options hid_xpadneo trigger_rumble_mode=2" >> $(TARGET_DIR)/usr/lib/modprobe.d/xpadneo.conf
		echo "options bluetooth disable_ertm=1" >> $(TARGET_DIR)/usr/lib/modprobe.d/xpadneo.conf
endef

$(eval $(kernel-module))
$(eval $(generic-package))
